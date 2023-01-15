
`#tutorial_job-arrays.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
1. [Example 1](#example-1)
1. [Follow steps for example 1](#follow-steps-for-example-1)
	1. [Make `commandlist`](#make-commandlist)
	1. [Make `command_array.sh`](#make-command_arraysh)
		1. [Understanding the contents of `command_array.sh`](#understanding-the-contents-of-command_arraysh)
	1. [Run `command_array.sh`](#run-command_arraysh)
1. [Example 2](#example-2)
1. [Example 3](#example-3)

<!-- /MarkdownTOC -->
</details>
<br />

Working through the Slurm job-array tutorial [here](https://in.nau.edu/arc/overview/using-the-cluster-advanced/job-arrays-old/)
<br />
<br />

<a id="get-situated"></a>
### Get situated
```bash
#!/bin/bash
#DONTRUN

# grabnode  # 1 core, default settings

mwd() {
    transcriptome \
        && cd "./results/2023-0111" \
        || echo "cd'ing failed; check on this"
}


mwd
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111

Trinity_env
```

___\*Note that `grabnode` is commented out above.___ This is because "batch jobs submitted from interactive sessions fail," giving an error like this:
```txt
srun: error: CPU binding outside of job step allocation, allocated CPUs are: 0x200000.
srun: error: Task launch for StepId=7935525.0 failed on node gizmoj7: Unable to satisfy cpu bind request
srun: error: Application launch failed: Unable to satisfy cpu bind request
srun: Job step aborted
```

The reason? "This seems to be due to `SLURM_CPU_BIND_*` env vars being set in the interactive job, which then (undesirably) propagate to the batch job and cause problems if the job's taskset conflicts with the inherited `SLURM_CPU_BIND_*` values.

"Unsetting those env vars at the top of the job submission script seems to prevent the issue from occurring, but isn't something we want to recommend to users.  Also, we're concerned that propagation of other env vars from the interactive job to the batch might cause other issues."

Quotes are from&mdash;and more details are available at&mdash;[this link](https://groups.google.com/g/slurm-users/c/mp_JRutKmCc).

Additional details [here](https://bugs.schedmd.com/show_bug.cgi?id=14298).
<br />
<br />

<a id="example-1"></a>
## Example 1
<a id="follow-steps-for-example-1"></a>
### Follow steps for example 1
<a id="make-commandlist"></a>
#### Make `commandlist`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

dir="tutorial_job-arrays"  # echo "${dir}"
ex_1="${dir}/example_1"  # echo "${ex_1}"
mkdir -p "${ex_1}"

if [[ -f "${ex_1}/commandlist" ]]; then
	rm "${ex_1}/commandlist"
fi
touch "${ex_1}/commandlist"
contents="""
sleep 5
sleep 4
sleep 8
sleep 2
sleep 6
"""
echo "${contents}" >> "${ex_1}/commandlist"
sed -i '1d' "${ex_1}/commandlist"
# head "${ex_1}/commandlist"
# vi "${ex_1}/commandlist"  # :q
```

<a id="make-command_arraysh"></a>
#### Make `command_array.sh`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${ex_1}/command_array.sh" ]]; then
	rm "${ex_1}/command_array.sh"
fi
touch "${ex_1}/command_array.sh"
contents="""
#!/bin/sh
#SBATCH --job-name=\"command-array\"
#SBATCH --output=\"${ex_1}/command_array-%A_%a.out\"
#SBATCH --array=1-5

command=\"\$(awk \"NR == \${SLURM_ARRAY_TASK_ID}\" \"${ex_1}/commandlist\")\"
srun \${command}
"""
echo "${contents}" >> "${ex_1}/command_array.sh"
sed -i '1d' "${ex_1}/command_array.sh"
cat -n "${ex_1}/command_array.sh"
# cd "${ex_1}" && rm -- *.out && cd -

# SLURM_ARRAY_TASK_ID=4
# command="$(awk "NR == ${SLURM_ARRAY_TASK_ID}" "tutorial_job-arrays/example_1/commandlist")"
# echo "${command}"
# srun ${command}
```

___\*Note above that the variable passed to srun must be quoted, or else srun will attempt to access a file.___

<a id="understanding-the-contents-of-command_arraysh"></a>
##### Understanding the contents of `command_array.sh`
```txt
❯ cat -n "${ex_1}/command_array.sh"
     1	#!/bin/sh
     2	#SBATCH --job-name="command-array"
     3	#SBATCH --output="tutorial_job-arrays/example_1/command_array-%A_%a.out"
     4	#SBATCH --array=1-5
     5
     6	command="$(awk "NR == ${SLURM_ARRAY_TASK_ID}" "tutorial_job-arrays/example_1/commandlist")"
     7	srun ${command}
     8
```
- <u>Line 4</u> tells `SLURM` to create an array of `5` items, numbered `1` through `5`.
	+ This should be changed to match the number of jobs you need to run.
	+ In our case, we want this range to match the number of commands in our "`commandlist`" file.
- <u>Line 6</u> utilizes one of `SLURM`’s built in variables, called `SLURM_ARRAY_TASK_ID`.
	+ This accesses the specific task `ID` of the current task in the job array (e.g., `1` for the first task) and can be used like any bash variable.
	+ In this example, "`sed`" is being used to get the contents of a particular line in the "`commandlist`" file using `SLURM_ARRAY_TASK_ID`.
	+ For the first task, the "`command`" variable will be "`sleep 5`".
- <u>Line 3</u> uses a shorthand method of accessing the job array `ID` and array task `ID` and embedding them into the name of the output file.
	+ The "`%A`" represents the `SLURM_ARRAY_JOB_ID` variable (e.g., `1212985`) and the "`%a`" represents the `SLURM_ARRAY_TASK_ID` variable (e.g., `1`).
	+ This would generate an output file similar to "`command_array-1212985_1.out`" for the first element of the array.

<a id="run-command_arraysh"></a>
#### Run `command_array.sh`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch "${ex_1}/command_array.sh"
skal  # alias skal="squeue -u kalavatt"
., "${ex_1}"
head -100 "${ex_1}/command_array-"*".out"
```

```txt
❯ skal
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
         7935880_1 campus-ne command- kalavatt  R       0:01      1 gizmok30 1
         7935880_2 campus-ne command- kalavatt  R       0:01      1 gizmok33 1
         7935880_3 campus-ne command- kalavatt  R       0:01      1 gizmok13 1
         7935880_4 campus-ne command- kalavatt  R       0:01      1 gizmok13 1
         7935880_5 campus-ne command- kalavatt  R       0:01      1 gizmok13 1

❯ ., "${ex_1}"
total 280K
drwxrws--- 2 kalavatt 288 Jan 14 15:51 ./
drwxrws--- 3 kalavatt  27 Jan 14 13:41 ../
-rw-rw---- 1 kalavatt   0 Jan 14 15:51 command_array-7935880_1.out
-rw-rw---- 1 kalavatt   0 Jan 14 15:51 command_array-7935880_2.out
-rw-rw---- 1 kalavatt   0 Jan 14 15:51 command_array-7935880_3.out
-rw-rw---- 1 kalavatt   0 Jan 14 15:51 command_array-7935880_4.out
-rw-rw---- 1 kalavatt   0 Jan 14 15:51 command_array-7935880_5.out
-rw-rw---- 1 kalavatt 248 Jan 14 15:50 command_array.sh
-rw-rw---- 1 kalavatt  41 Jan 14 15:48 commandlist

❯ head -100 ${ex_1}/command_array-*.out
==> tutorial_job-arrays/example_1/command_array-7935880_1.out <==

==> tutorial_job-arrays/example_1/command_array-7935880_2.out <==

==> tutorial_job-arrays/example_1/command_array-7935880_3.out <==

==> tutorial_job-arrays/example_1/command_array-7935880_4.out <==

==> tutorial_job-arrays/example_1/command_array-7935880_5.out <==
```
<br />
<br />

<a id="example-2"></a>
## Example 2
> With SLURM, it is also possible to create jobs that send different parameters to the same set of data. In this next example, we are going to use a simple program written in R that calculates the area of a triangle given two sides and an angle as input.
> 
> In this scenario we will assume that two of the sides of the triangle are known, but we want to calculate how the area will change if the angle between those two sides changes. Let’s consider each integer angle from 1 to 15 degrees. Below are the R program for calculating the area of the triangle and the bash script that calls the program:

```bash
#!/bin/bash
#DONTRUN #CONTINUE

dir="tutorial_job-arrays"  # echo "${dir}"
ex_2="${dir}/example_2"  # echo "${ex_2}"
mkdir -p "${ex_2}"

if [[ -f "${ex_2}/area_of_triangle.R" ]]; then
	rm "${ex_2}/area_of_triangle.R"
fi
touch "${ex_2}/area_of_triangle.R"
contents="""
#!/bin/Rscript

#  Take in 3 integers: 2 sides of a triangle and the angle between them; with
#+ the two sides and angle between them known, calculate the area of the
#+ triangle

args <- commandArgs(TRUE)

side_a <- strtoi(args[1], base=10L)
side_b <- strtoi(args[2], base=10L)
angle <- strtoi(args[3], base=10L)

area = (1/2)*side_a*side_b*sin(angle*pi/180)
sprintf(\"The area of a triangle with sides %i and %i with angle %i degrees is %f\", side_a, side_b, angle, area)
"""
echo "${contents}" >> "${ex_2}/area_of_triangle.R"
sed -i '1d' "${ex_2}/area_of_triangle.R"
cat -n "${ex_2}/area_of_triangle.R"
# cd "${ex_2}" && rm -- *.out && cd -

if [[ -f "${ex_2}/job_array_triangle.sh" ]]; then
	rm "${ex_2}/job_array_triangle.sh"
fi
touch "${ex_2}/job_array_triangle.sh"
contents="""
#!/bin/bash

#SBATCH --job-name=\"area of triangles\"
#SBATCH --output=\"${ex_2}/area_of_triangle_5_8_%a.out\"
#SBATCH --array=1-15

module load R

# calculate the area of a triangle with 2 sides given, and a
# variable angle in degrees between them (Side-Angle-Side)
srun Rscript ${ex_2}/area_of_triangle.R 5 8 \${SLURM_ARRAY_TASK_ID}
"""
echo "${contents}" >> "${ex_2}/job_array_triangle.sh"
sed -i '1d' "${ex_2}/job_array_triangle.sh"
cat -n "${ex_2}/job_array_triangle.sh"
# cd "${ex_2}" && rm -- *.out && cd -

sbatch "${ex_2}/job_array_triangle.sh"
skal

., "${ex_2}"

cat "${ex_2}/area_of_triangle_5_8_9.out"
```

```txt
❯ cat -n "${ex_2}/area_of_triangle.R"
     1	#!/bin/Rscript
     2
     3	#  Take in 3 integers: 2 sides of a triangle and the angle between them; with
     4	#+ the two sides and angle between them known, calculate the area of the
     5	#+ triangle
     6
     7	args <- commandArgs(TRUE)
     8
     9	side_a <- strtoi(args[1], base=10L)
    10	side_b <- strtoi(args[2], base=10L)
    11	angle <- strtoi(args[3], base=10L)
    12
    13	area = (1/2)*side_a*side_b*sin(angle*pi/180)
    14	sprintf("The area of a triangle with sides %i and %i with angle %i degrees is %f", side_a, side_b, angle, area)
    15

❯ cat -n "${ex_2}/job_array_triangle.sh"
     1	#!/bin/bash
     2
     3	#SBATCH --job-name="area of triangles"
     4	#SBATCH --output="tutorial_job-arrays/example_2/area_of_triangle_5_8_%a.out"
     5	#SBATCH --array=1-15
     6
     7	module load R
     8
     9	# calculate the area of a triangle with 2 sides given, and a
    10	# variable angle in degrees between them (Side-Angle-Side)
    11	srun Rscript area_of_triangle.R 5 8 ${SLURM_ARRAY_TASK_ID}
    12

❯ skal
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
         7935901_1 campus-ne area of  kalavatt  R       0:03      1 gizmok42 1
         7935901_2 campus-ne area of  kalavatt  R       0:03      1 gizmok42 1
         7935901_3 campus-ne area of  kalavatt  R       0:03      1 gizmok10 1
         7935901_4 campus-ne area of  kalavatt  R       0:03      1 gizmok10 1
         7935901_5 campus-ne area of  kalavatt  R       0:03      1 gizmok10 1
         7935901_6 campus-ne area of  kalavatt  R       0:03      1 gizmok22 1
         7935901_7 campus-ne area of  kalavatt  R       0:03      1 gizmok22 1
         7935901_8 campus-ne area of  kalavatt  R       0:03      1 gizmok22 1
         7935901_9 campus-ne area of  kalavatt  R       0:03      1 gizmok94 1
        7935901_10 campus-ne area of  kalavatt  R       0:03      1 gizmok94 1
        7935901_11 campus-ne area of  kalavatt  R       0:03      1 gizmok94 1
        7935901_12 campus-ne area of  kalavatt  R       0:03      1 gizmok94 1
        7935901_13 campus-ne area of  kalavatt  R       0:03      1 gizmok36 1
        7935901_14 campus-ne area of  kalavatt  R       0:03      1 gizmok36 1
        7935901_15 campus-ne area of  kalavatt  R       0:03      1 gizmok35 1

❯ ., "${ex_2}"
total 592K
drwxrws--- 2 kalavatt 741 Jan 14 16:19 ./
drwxrws--- 4 kalavatt  54 Jan 14 16:03 ../
-rw-rw---- 1 kalavatt  82 Jan 14 16:19 area_of_triangle_5_8_10.out
-rw-rw---- 1 kalavatt  82 Jan 14 16:19 area_of_triangle_5_8_11.out
-rw-rw---- 1 kalavatt  82 Jan 14 16:19 area_of_triangle_5_8_12.out
-rw-rw---- 1 kalavatt  82 Jan 14 16:19 area_of_triangle_5_8_13.out
-rw-rw---- 1 kalavatt  82 Jan 14 16:19 area_of_triangle_5_8_14.out
-rw-rw---- 1 kalavatt  82 Jan 14 16:19 area_of_triangle_5_8_15.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_1.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_2.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_3.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_4.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_5.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_6.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_7.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_8.out
-rw-rw---- 1 kalavatt  81 Jan 14 16:19 area_of_triangle_5_8_9.out
-rw-rw---- 1 kalavatt 473 Jan 14 16:13 area_of_triangle.R
-rw-rw---- 1 kalavatt 376 Jan 14 16:19 job_array_triangle.sh

❯ cat "${ex_2}/area_of_triangle_5_8_9.out"
[1] "The area of a triangle with sides 5 and 8 with angle 9 degrees is 3.128689"
```

The srun command in the “Job_array_triangle.sh” script is passing the same first two arguments (5 and 8) to each task of the array, but is changing the third to be whatever the current task ID is. So the first task calls “srun Rscript area_of_triangle.r 5 8 1” because our first array task starts at 1.
<br />
<br />

<a id="example-3"></a>
There may be times that you would like to send many different files as input to a program. Instead of having to do this one at a time, you can set up a job array to do this automatically. In this next example, we will be using a simple shell script called “analysis.sh” that takes an input file and an output directory as parameters.

<a id="example-3"></a>
## Example 3
```bash
#!/bin/bash
#DONTRUN #CONTINUE

dir="tutorial_job-arrays"  # echo "${dir}"
ex_3="${dir}/example_3"  # echo "${ex_3}"
mkdir -p "${ex_3}"

if [[ -f "${ex_3}/analysis.sh" ]]; then
	rm "${ex_3}/analysis.sh"
fi
touch "${ex_3}/analysis.sh"
contents="""
#!/bin/bash
#  analysis.sh – an analysis program
#+ \${1} (input) and \${2} (output) are the first and second arguments to this
#+ script

# strip off the directory paths to get just the filename
BASE=\"\$(basename \"\${1}\")\"

# generate random number between 1 and 5
RAND=\"\$(( \${RANDOM} % 5+1 ))\"

# begin the big analysis
echo \"Beginning the analysis of \${BASE} at:\"
date

# the sleep program will just sit idle doing nothing
echo \"Sleeping for \${RAND} seconds …\"
sleep \"\${RAND}\"

# now actually do something, calculating the checksum of our input file
CHKSUM=\"\$(md5sum \${1})\"
echo \"\${CHKSUM}\" > \"\${2}/\${BASE}_sum\"

echo \"Analysis of \${BASE} has been completed at:\"
date
"""
echo "${contents}" >> "${ex_3}/analysis.sh"
sed -i '1d' "${ex_3}/analysis.sh"
cat -n "${ex_3}/analysis.sh"
# cd "${ex_3}" && rm -- *.out && cd -
```

```txt
❯ cat -n "${ex_3}/analysis.sh"
     1	#!/bin/bash
     2	#  analysis.sh – an analysis program
     3	#+ ${1} (input) and ${2} (output) are the first and second arguments to this
     4	#+ script
     5
     6	# strip off the directory paths to get just the filename
     7	BASE="$(basename "${1}")"
     8
     9	# generate random number between 1 and 5
    10	RAND="$(( ${RANDOM} % 5+1 ))"
    11
    12	# begin the big analysis
    13	echo "Beginning the analysis of ${BASE} at:"
    14	date
    15
    16	# the sleep program will just sit idle doing nothing
    17	echo "Sleeping for ${RAND} seconds ..."
    18	sleep "${RAND}"
    19
    20	# now actually do something, calculating the checksum of our input file
    21	CHKSUM="$(md5sum ${1})"
    22	echo "${CHKSUM}" > "${2}/${BASE}_sum"
    23
    24	echo "Analysis of ${BASE} has been completed at:"
    25	date
    26
```

Reading through the text for this example, I think I see what's going on here&mdash;and how I can use this example specifically to run GNU parallel such that it takes a header-ed, delimited file of entries that are parameter values for a command under the umbrella of GNU parallel; work on this `#TOMORROW`

I'm going to have to write and run a few tests first to get all the pieces working together&mdash;but I think the effort and time spent will pay off...

Also, I really need to get started with the troubleshooting for Alison&mdash;get started with that `#TOMORROW` too
