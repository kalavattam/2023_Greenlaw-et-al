
`#tutorial_job-arrays.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
     1. [Insights from troubleshooting and debugging](#insights-from-troubleshooting-and-debugging)
1. [Example 1](#example-1)
     1. [Get situated](#get-situated-1)
     1. [Make `commandlist`](#make-commandlist)
     1. [Make `command_array.sh`](#make-command_arraysh)
          1. [Examine the contents of `command_array.sh`](#examine-the-contents-of-command_arraysh)
          1. [Understanding the contents of `command_array.sh`](#understanding-the-contents-of-command_arraysh)
     1. [Run `command_array.sh`](#run-command_arraysh)
1. [Example 2](#example-2)
1. [Example 3](#example-3)
     1. [Get situated](#get-situated-2)
     1. [Make `analysis.sh`](#make-analysissh)
     1. [Make `filelist.txt`](#make-filelisttxt)
          1. [Make the files in `filelist.txt`](#make-the-files-in-filelisttxt)
     1. [Make `job_array.sh`](#make-job_arraysh)
     1. [Run `job_array.sh`](#run-job_arraysh)
1. [`#TODO`s, notes, etc.](#todos-notes-etc)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<details>
<summary><font size="+2"><i>Notes</i></font></summary>

Working through the `SLURM` job-array tutorial [here](https://in.nau.edu/arc/overview/using-the-cluster-advanced/job-arrays-old/)

This information will be used to redesign how I am submitting `Trinity`/`PASA` parameterization jobs to `SLURM`
- I need to limit the number of jobs submitted to `SLURM` at one time; this is because memory is shared by all concurrent jobs, resulting in ~~some~~many jobs not having enough memory and thus terminating with errors
- `#TODO` Go back and study up on how memory is handled with FHCC's setup of `SLURM`
</details>
<br />
<br />

<a id="get-situated"></a>
## Get situated
<details>
<summary><i>Code: Get situated</i></summary>

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
</details>
<br />

<a id="insights-from-troubleshooting-and-debugging"></a>
### Insights from troubleshooting and debugging
<details>
<summary><i>Notes: Insights from troubleshooting and debugging</i></summary>
<br />

___\*Note that `grabnode` is commented out above.___ This is because <mark>*"batch jobs submitted from interactive sessions fail*,"</mark> giving an error like this:
<details>
<summary><i>Error message</i></summary>

```txt
srun: error: CPU binding outside of job step allocation, allocated CPUs are: 0x200000.
srun: error: Task launch for StepId=7935525.0 failed on node gizmoj7: Unable to satisfy cpu bind request
srun: error: Application launch failed: Unable to satisfy cpu bind request
srun: Job step aborted
```
</details>
<br />

__The reason?__ *"This seems to be due to `SLURM_CPU_BIND_*` env vars being set in the interactive job, which then (undesirably) propagate to the batch job and cause problems if the job's taskset conflicts with the inherited `SLURM_CPU_BIND_*` values.*

*"Unsetting those env vars at the top of the job submission script seems to prevent the issue from occurring, but isn't something we want to recommend to users. Also, we're concerned that propagation of other env vars from the interactive job to the batch might cause other issues."*

Quotes are from&mdash;and more details are available at&mdash;[this link](https://groups.google.com/g/slurm-users/c/mp_JRutKmCc).

Additional details [here](https://bugs.schedmd.com/show_bug.cgi?id=14298).
</details>
<br />
<br />

<a id="example-1"></a>
## Example 1
<a id="get-situated-1"></a>
### Get situated
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

dir="tutorial_job-arrays"  # echo "${dir}"
ex_1="${dir}/example_1"  # echo "${ex_1}"
mkdir -p "${ex_1}"
```
</details>
<br />

<a id="make-commandlist"></a>
### Make `commandlist`
<details>
<summary><i>Code: Make commandlist</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

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
</details>
<br />

<a id="make-command_arraysh"></a>
### Make `command_array.sh`
<details>
<summary><i>Code: Make command_array.sh</i></summary>

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
</details>
<br />

<mark>___\*Note above that the variable passed to `srun` must be quoted&mdash;or else `srun` will attempt to access a file.___</mark>

<details>
<summary><i>Printed to terminal: Make command_array.sh</i></summary>

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
</details>
<br />

<a id="examine-the-contents-of-command_arraysh"></a>
#### Examine the contents of `command_array.sh`

<a id="understanding-the-contents-of-command_arraysh"></a>
#### Understanding the contents of `command_array.sh`
<details>
<summary><i>Notes: Understanding the contents of command_array.sh</i></summary>

- <u>Line 4</u> tells `SLURM` to create an array of `5` items, numbered `1` through `5`.
	+ This should be changed to match the number of jobs you need to run.
	+ In our case, we want this range to match the number of commands in our "`commandlist`" file.
- <u>Line 6</u> utilizes one of `SLURM`’s built in variables, called `SLURM_ARRAY_TASK_ID`.
	+ This accesses the specific task `ID` of the current task in the job array (e.g., `1` for the first task) and can be used like any bash variable.
	+ In this example, ~~"`sed`"~~ "`awk`" is being used to get the contents of a particular line in the "`commandlist`" file using `SLURM_ARRAY_TASK_ID`.
	+ For the first task, the "`command`" variable will be "`sleep 5`".
- <u>Line 3</u> uses a shorthand method of accessing the job array `ID` and array task `ID` and embedding them into the name of the output file.
	+ The "`%A`" represents the `SLURM_ARRAY_JOB_ID` variable (e.g., `1212985`) and the "`%a`" represents the `SLURM_ARRAY_TASK_ID` variable (e.g., `1`).
	+ This would generate an output file similar to "`command_array-1212985_1.out`" for the first element of the array.
</details>
<br />

<a id="run-command_arraysh"></a>
### Run `command_array.sh`
<details>
<summary><i>Code: Run command_array.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch "${ex_1}/command_array.sh"
skal  # alias skal="squeue -u kalavatt"
., "${ex_1}"
head -100 "${ex_1}/command_array-"*".out"
```
</details>
<br />

<details>
<summary><i>Printed to terminal: Run command_array.sh</i></summary>

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
</details>
<br />
<br />

<a id="example-2"></a>
## Example 2
<details>
<summary><i>Intro: Example 2</i></summary>

> With `SLURM`, it is also possible to create jobs that send different parameters to the same set of data. In this next example, we are going to use a simple program written in `R` that calculates the area of a triangle given two sides and an angle as input.
> 
> In this scenario, we will assume that two of the sides of the triangle are known, and we want to calculate how the area changes when the angle between those two sides changes. Let’s consider each integer angle from 1 to 15 degrees. Below is the R program for calculating the area of the triangle and the bash script that calls the program:
</details>
<br />

<details>
<summary><i>Code: Example 2</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

dir="tutorial_job-arrays"  # echo "${dir}"
ex_2="${dir}/example_2"  # echo "${ex_2}"
mkdir -p "${ex_2}"


#  area_of_triangle.R -----------------
if [[ -f "${ex_2}/area_of_triangle.R" ]]; then
	rm "${ex_2}/area_of_triangle.R"
fi
touch "${ex_2}/area_of_triangle.R"
contents="""
#!/bin/Rscript

#  Take in three integers: two sides of a triangle and the angle between them;
#+ calculate the area of a triangle given the two sides and their shared angle
#+ as input

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


#  job_array_triangle.sh --------------
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


#  Submit job_array_triangle.sh -------
sbatch "${ex_2}/job_array_triangle.sh"
skal


#  Check on outfiles ------------------
., "${ex_2}"

cat "${ex_2}/area_of_triangle_5_8_9.out"
```
</details>
<br />

<details>
<summary><i>Printed to terminal: Example 2</i></summary>

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
</details>
<br />

<details>
<summary><i>Breakdown: Example 2</i></summary>

- The `srun` command in the "`job_array_triangle.sh`" script is passing the same first two arguments (`5` and `8`) to each task of the array
- However, it is changing the third argument to be whatever the current task `ID` is
- So the first task calls "`srun Rscript area_of_triangle.r 5 8 1`" because our first array task starts at 1
</details>
<br />
<br />

<a id="example-3"></a>
## Example 3
<details>
<summary><i>Intro: Example 3</i></summary>

> There may be times that you would like to send many different files as input to a program. Instead of having to do this one at a time, you can set up a job array to do this automatically. In this next example, we will be using a simple shell script called "`analysis.sh`" that takes an input file and an output directory as parameters.
</details>
<br />

<a id="get-situated-2"></a>
### Get situated
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

dir="tutorial_job-arrays"  # echo "${dir}"
ex_3="${dir}/example_3"  # echo "${ex_3}"
mkdir -p "${ex_3}"
```
</details>
<br />

<a id="make-analysissh"></a>
### Make `analysis.sh`
<details>
<summary><i>Code: Make analysis.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${ex_3}/analysis.sh" ]]; then
	rm "${ex_3}/analysis.sh"
fi
touch "${ex_3}/analysis.sh"
contents="""
#!/bin/bash

#  analysis.sh
#+
#+ Take two arguments, the first one being a file to be analyzed and the second
#+ a directory to output the analysis, then sleep for a random amount of time
#+ before running md5sum on the infile; the checksum is output to user-defined
#+ directory
#+
#+ \${1} (infile) and \${2} (outdirectory) are the first and second arguments to this
#+ script

#  Strip away directory paths, resulting in filenames alone
BASE=\"\$(basename \"\${1}\")\"

#  Generate a random number between 1 and 5
RAND=\"\$(( \${RANDOM} % 5+1 ))\"

#  Begin the analysis
echo \"Beginning the analysis of \${BASE} at:\"
date

#  The sleep program will sit idle, doing nothing
echo \"Sleeping for \${RAND} seconds …\"
sleep \"\${RAND}\"

#  Now, actually do something, calculating the checksum for the infile
CHKSUM=\"\$(md5sum \${1})\"
echo \"\${CHKSUM}\" > \"\${2}/\${BASE}_sum\"

echo \"Analysis of \${BASE} has been completed at:\"
date
"""

echo "${contents}" >> "${ex_3}/analysis.sh"
sed -i '1d' "${ex_3}/analysis.sh"
chmod 777 "${ex_3}/analysis.sh"
cat -n "${ex_3}/analysis.sh"
```
</details>
<br />

<details>
<summary><i>Printed to terminal: Make analysis.sh</i></summary>

```txt
❯ cat -n "${ex_3}/analysis.sh"
     1	#!/bin/bash
     2
     3	#  analysis.sh
     4	#+
     5	#+ Take two arguments, the first one being a file to be analyzed and the second
     6	#+ a directory to output the analysis, then sleep for a random amount of time
     7	#+ before running md5sum on the infile; the checksum is output to user-defined
     8	#+ directory
     9	#+
    10	#+ ${1} (infile) and ${2} (outdirectory) are the first and second arguments to this
    11	#+ script
    12
    13	#  Strip away directory paths, resulting in filenames alone
    14	BASE="$(basename "${1}")"
    15
    16	#  Generate a random number between 1 and 5
    17	RAND="$(( ${RANDOM} % 5+1 ))"
    18
    19	#  Begin the analysis
    20	echo "Beginning the analysis of ${BASE} at:"
    21	date
    22
    23	#  The sleep program will sit idle, doing nothing
    24	echo "Sleeping for ${RAND} seconds …"
    25	sleep "${RAND}"
    26
    27	#  Now, actually do something, calculating the checksum for the infile
    28	CHKSUM="$(md5sum ${1})"
    29	echo "${CHKSUM}" > "${2}/${BASE}_sum"
    30
    31	echo "Analysis of ${BASE} has been completed at:"
    32	date
    33
```
</details>
<br />

<a id="make-filelisttxt"></a>
### Make `filelist.txt`
<details>
<summary><i>Intro: Make filelist.txt</i></summary>

> Let's say we have 5 different files that we would like our program to analyze. We will store the paths to these input files in another file called "`filelist.txt`":
</details>
<br />

<details>
<summary><i>Code: Make filelist.txt</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${ex_3}/filelist.txt" ]]; then
	rm "${ex_3}/filelist.txt"
fi
touch "${ex_3}/filelist.txt"
contents="""
$(pwd)/${ex_3}/file_1.txt
$(pwd)/${ex_3}/file_2.txt
$(pwd)/${ex_3}/file_3.txt
$(pwd)/${ex_3}/file_4.txt
$(pwd)/${ex_3}/file_5.txt
"""

echo "${contents}" >> "${ex_3}/filelist.txt"
sed -i '1d' "${ex_3}/filelist.txt"
cat -n "${ex_3}/filelist.txt"
```
</details>
<br />

<details>
<summary><i>Printed to terminal: Make filelist.txt</i></summary>

```txt
❯ cat -n "${ex_3}/filelist.txt"
     1	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_1.txt
     2	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_2.txt
     3	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_3.txt
     4	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_4.txt
     5	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_5.txt
     6
```
</details>
<br />

<a id="make-the-files-in-filelisttxt"></a>
#### Make the files in `filelist.txt`
<details>
<summary><i>Code: Make the files in filelist.txt</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="$(cat "${ex_3}/filelist.txt" | wc -l)"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=1; i<=y; i++ )); do
	command="$(awk "NR == ${i}" "${ex_3}/filelist.txt")"

	echo "${command}"
	touch "${command}"
done
., "${ex_3}"
```
</details>
<br />

<details>
<summary><i>Printed to terminal: Make the files in filelist.txt</i></summary>

```txt
❯ for (( i=1; i<=y; i++ )); do
> 	command="$(awk "NR == ${i}" "${ex_3}/filelist.txt")"
>
> 	echo "${command}"
> 	touch "${command}"
> done
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_1.txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_2.txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_3.txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_4.txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_5.txt

❯ ., "${ex_3}"
total 264K
drwxrws--- 2 kalavatt 199 Jan 15 10:18 ./
drwxrws--- 5 kalavatt  81 Jan 14 16:25 ../
-rw-rw---- 1 kalavatt 672 Jan 15 09:45 analysis.sh
-rw-rw---- 1 kalavatt   0 Jan 15 10:18 file_1.txt
-rw-rw---- 1 kalavatt   0 Jan 15 10:18 file_2.txt
-rw-rw---- 1 kalavatt   0 Jan 15 10:18 file_3.txt
-rw-rw---- 1 kalavatt   0 Jan 15 10:18 file_4.txt
-rw-rw---- 1 kalavatt   0 Jan 15 10:18 file_5.txt
-rw-rw---- 1 kalavatt 641 Jan 15 10:17 filelist.txt
```
</details>
<br />

<a id="make-job_arraysh"></a>
### Make `job_array.sh`
<details>
<summary><i>Notes: Make job_array.sh</i></summary>

...create a script called "`job_array.sh`" that uses the command line tool ~~"`sed`"~~"`awk`" and the `SLURM_ARRAY_TASK_ID` variable to get a specific line of that file:

\*Note: <mark>The use of `sed -n` to select line numbers does not exist in `sed (GNU sed) 4.4`, the version installed on the FHCC system,</mark> so we can't do, e.g.,
```bash
sed -n "${SLURM_ARRAY_TASK_ID}"p "${ex_3}/filelist.txt"
```
Instead, we need to do, e.g.,
```bash
awk "NR == ${SLURM_ARRAY_TASK_ID}" "${ex_3}/filelist.txt"
```
*(There are many other ways to do this, including alternative ways to do it with `sed`. Anyway, this is why you see the use of "`awk`" and not "`sed`" in [Example 1](#make-command_arraysh)&mdash;something I spent (too much) time troubleshooting yesterday.)*
</details>
<br />

<details>
<summary><i>Code: Make job_array.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${ex_3}/job_array.sh" ]]; then
	rm "${ex_3}/job_array.sh"
fi
touch "${ex_3}/job_array.sh"
contents="""
#!/bin/bash
#SBATCH --job-name=\"array_test\"
#SBATCH --output=\"${ex_3}/analysis_%a.out\"
#SBATCH --time=20:00
#SBATCH --cpus-per-task=1
#SBATCH --array=1-5

name=\"\$(
	awk \"NR == \${SLURM_ARRAY_TASK_ID}\" \"${ex_3}/filelist.txt\"
)\"

srun \"./${ex_3}/analysis.sh\" \"\${name}\" \"${ex_3}\"
"""

echo "${contents}" >> "${ex_3}/job_array.sh"
sed -i '1d' "${ex_3}/job_array.sh"
cat -n "${ex_3}/job_array.sh"

# SLURM_ARRAY_TASK_ID=1
# name="$(
#     awk "NR == ${SLURM_ARRAY_TASK_ID}" "tutorial_job-arrays/example_3/filelist.txt"
# )"
# echo "${name}"
# # /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_1.txt
```
</details>
<br />

<details>
<summary><i>Printed to terminal: Make job_array.sh</i></summary>

```txt
❯ cat -n "${ex_3}/job_array.sh"
     1	#!/bin/bash
     2	#SBATCH --job-name="array_test"
     3	#SBATCH --output="tutorial_job-arrays/example_3/analysis_%a.out"
     4	#SBATCH --time=20:00
     5	#SBATCH --cpus-per-task=1
     6	#SBATCH --array=1-5
     7
     8	name="$(
     9	    awk "NR == ${SLURM_ARRAY_TASK_ID}" "tutorial_job-arrays/example_3/filelist.txt"
    10	)"
    11
    12	srun "./tutorial_job-arrays/example_3/analysis.sh" "${name}" "tutorial_job-arrays/example_3"
    13
```
</details>
<br />

<a id="run-job_arraysh"></a>
### Run `job_array.sh`
<details>
<summary><i>Run job_array.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Submit job_array_triangle.sh -------
sbatch "${ex_3}/job_array.sh"
skal


#  Check on outfiles ------------------
., "${ex_3}"

cat "${ex_3}/analysis_1.out"

# cd "${ex_3}" && rm -- *.out && cd -
```
</details>
<br />

<details>
<summary><i>Printed to terminal: Run job_array.sh</i></summary>

```txt
❯ skal
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
         7954737_1 campus-ne array_te kalavatt  R       0:00      1 gizmok27 1
         7954737_2 campus-ne array_te kalavatt  R       0:00      1 gizmok35 1
         7954737_3 campus-ne array_te kalavatt  R       0:00      1 gizmok42 1
         7954737_4 campus-ne array_te kalavatt  R       0:00      1 gizmok12 1
         7954737_5 campus-ne array_te kalavatt  R       0:00      1 gizmok12 1

❯ skal
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
         7954737_2 campus-ne array_te kalavatt  R       0:03      1 gizmok35 1
         7954737_3 campus-ne array_te kalavatt  R       0:03      1 gizmok42 1
         7954737_4 campus-ne array_te kalavatt  R       0:03      1 gizmok12 1
         7954737_5 campus-ne array_te kalavatt  R       0:03      1 gizmok12 1

❯ skal
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
         7954737_2 campus-ne array_te kalavatt  R       0:05      1 gizmok35 1
         7954737_5 campus-ne array_te kalavatt  R       0:05      1 gizmok12 1

❯ skal
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS

❯ ., "${ex_3}"

❯ cat "${ex_3}/analysis_1.out"
Beginning the analysis of file_1.txt at:
Sun Jan 15 11:21:36 PST 2023
Sleeping for 5 seconds …
md5sum: tutorial_job-arrays/example_3//home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/example_3/file_1.txt: No such file or directory
Analysis of file_1.txt has been completed at:
Sun Jan 15 11:21:41 PST 2023
```
</details>
<br />

<details>
<summary><i>Error message: Run job_array.sh</i></summary>

With the use of `#SBATCH --partition=core`, we get the following error:
```txt
sbatch: error: invalid partition specified: core
sbatch: error: Batch job submission failed: Invalid partition name specified
```
</details>
<br />

<a id="todos-notes-etc"></a>
## `#TODO`s, notes, etc.
<details>
<summary><i>#TODOs, notes, etc./i></i></summary>

Reading through the text for this example, I think I see what's going on here&mdash;and how I can use this example specifically to run `GNU parallel` such that it takes a header-ed, delimited file of entries that are parameter values for a command under the umbrella of `GNU parallel`; work on this ~~`#TOMORROW`~~in the coming days

I'm going to have to write and run a few tests first to get all the pieces working together&mdash;but I think the effort and time spent will pay off...
- Draft those during downtime for `#TROUBLESHOOT`ing work (*see below*&mdash;e.g., aligning RNA-seq datasets)
- Copy in pertinent code and notes from [`work_Trinity-GF_optimization.md`](./work_Trinity-GF_optimization.md)
	+ The code around [here](./work_Trinity-GF_optimization.md#generate-the-submission-script), I think...
- Going to need to generate header-ed single-line lists of parameters for `Trinity`, so can draw on...
	+ [this (for making lists to be fed to `GNU parallel`)](https://github.com/Noble-Lab/2020_kga0_endothelial-diff/blob/master/bin/make_list_RNA-seq.sh)
	+ and [this (running a command under the umbrella of `GNU parallel`, taking in a list of parameters)](https://github.com/Noble-Lab/2020_kga0_endothelial-diff/blob/master/bin/align_RNA-seq_STAR-Baruzzo-junction.sh)

Also, I really need to get started with the troubleshooting for Alison&mdash;get started with that ~~`#TOMORROW`~~`#TODAY`
</details>
<br />
