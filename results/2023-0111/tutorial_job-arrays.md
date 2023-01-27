
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
1. [Write and run initial tests: Use lists with `Trinity` job submissions](#write-and-run-initial-tests-use-lists-with-trinity-job-submissions)
    1. [Examine and edit the current job-submission script](#examine-and-edit-the-current-job-submission-script)
        1. [Survey the current script](#survey-the-current-script)
        1. [Adapt the script to take a header-ed list of arguments](#adapt-the-script-to-take-a-header-ed-list-of-arguments)
            1. [*Executable version*](#executable-version)
            1. [*HEREDOC-ready version*](#heredoc-ready-version)
    1. [Write a code chunk for a script for the job submission](#write-a-code-chunk-for-a-script-for-the-job-submission)
        1. [*Executable version*](#executable-version-1)
        1. [*HEREDOC-ready version*](#heredoc-ready-version-1)
    1. [Get situated](#get-situated-3)
    1. [Create an appropriate list to be used with modified script](#create-an-appropriate-list-to-be-used-with-modified-script)
        1. [Get file, directory info into a deduplicated associative array](#get-file-directory-info-into-a-deduplicated-associative-array)
        1. [Define variables](#define-variables)
        1. [Set up directory for storing results from these tests](#set-up-directory-for-storing-results-from-these-tests)
        1. [Generate the list](#generate-the-list)
    1. [Write out the list-ready run script \(`echo` test\) using a `HEREDOC`](#write-out-the-list-ready-run-script-echo-test-using-a-heredoc)
    1. [Write out the submission script \(`echo` test\) using a `HEREDOC`](#write-out-the-submission-script-echo-test-using-a-heredoc)
    1. [Do a test run of the script and list](#do-a-test-run-of-the-script-and-list)
1. [Write a code chunk to generate lists of arguments](#write-a-code-chunk-to-generate-lists-of-arguments)
    1. [Get situated](#get-situated-4)
    1. [Get file, directory info into a deduplicated associative array](#get-file-directory-info-into-a-deduplicated-associative-array-1)
    1. [Define variables necessary for the list generation and the main script](#define-variables-necessary-for-the-list-generation-and-the-main-script)
    1. [Set up directory for storing results from these tests](#set-up-directory-for-storing-results-from-these-tests-1)
    1. [Write code for generating lists with permutations of parameters](#write-code-for-generating-lists-with-permutations-of-parameters)
        1. [Start the list with a header](#start-the-list-with-a-header)
        1. [Add the contents to the header-ed list](#add-the-contents-to-the-header-ed-list)
        1. [Examine the text printed to `"${store}/test_list_multi.txt"`](#examine-the-text-printed-to-%24storetest_list_multitxt)
1. [Write a chunk to split the complete list into individual lists](#write-a-chunk-to-split-the-complete-list-into-individual-lists)
1. [Run an `sbatch` `echo` test using the individual lists](#run-an-sbatch-echo-test-using-the-individual-lists)

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
if [[ -d "${dir}" ]]; then
     mv -f "${dir}" "bak.${dir}"
fi
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

<mark>___\*Note above that the variable passed to `srun` must <u>not be quoted</u>&mdash;or else `srun` will attempt to access a file.___</mark>

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

cat "${ex_2}/area_of_triangle_5_8_"*".out"
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

❯ cat "${ex_2}/area_of_triangle_5_8_"*".out"
[1] "The area of a triangle with sides 5 and 8 with angle 10 degrees is 3.472964"
[1] "The area of a triangle with sides 5 and 8 with angle 11 degrees is 3.816180"
[1] "The area of a triangle with sides 5 and 8 with angle 12 degrees is 4.158234"
[1] "The area of a triangle with sides 5 and 8 with angle 13 degrees is 4.499021"
[1] "The area of a triangle with sides 5 and 8 with angle 14 degrees is 4.838438"
[1] "The area of a triangle with sides 5 and 8 with angle 15 degrees is 5.176381"
[1] "The area of a triangle with sides 5 and 8 with angle 1 degrees is 0.349048"
[1] "The area of a triangle with sides 5 and 8 with angle 2 degrees is 0.697990"
[1] "The area of a triangle with sides 5 and 8 with angle 3 degrees is 1.046719"
[1] "The area of a triangle with sides 5 and 8 with angle 4 degrees is 1.395129"
[1] "The area of a triangle with sides 5 and 8 with angle 5 degrees is 1.743115"
[1] "The area of a triangle with sides 5 and 8 with angle 6 degrees is 2.090569"
[1] "The area of a triangle with sides 5 and 8 with angle 7 degrees is 2.437387"
[1] "The area of a triangle with sides 5 and 8 with angle 8 degrees is 2.783462"
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

#  Now, actually do something: Calculate the checksum for the infile
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
    27	#  Now, actually do something: Calculate the checksum for the infile
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
*(There are many other ways to do this, including alternative ways to do it with `sed`. Anyway, this is why you see the use of "`awk`" and not "`sed`" in [Example 1](#make-command_arraysh)&mdash;something I spent (too much) time troubleshooting yesterday (2023-0114).)*
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

#  Scraps
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

cat "${ex_3}/analysis_"*".out"

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

❯ cat "${ex_3}/analysis_"*".out"
Beginning the analysis of file_1.txt at:
Tue Jan 24 13:21:16 PST 2023
Sleeping for 3 seconds …
Analysis of file_1.txt has been completed at:
Tue Jan 24 13:21:19 PST 2023
Beginning the analysis of file_2.txt at:
Tue Jan 24 13:21:16 PST 2023
Sleeping for 3 seconds …
Analysis of file_2.txt has been completed at:
Tue Jan 24 13:21:19 PST 2023
Beginning the analysis of file_3.txt at:
Tue Jan 24 13:21:16 PST 2023
Sleeping for 5 seconds …
Analysis of file_3.txt has been completed at:
Tue Jan 24 13:21:21 PST 2023
Beginning the analysis of file_4.txt at:
Tue Jan 24 13:21:16 PST 2023
Sleeping for 2 seconds …
Analysis of file_4.txt has been completed at:
Tue Jan 24 13:21:18 PST 2023
Beginning the analysis of file_5.txt at:
Tue Jan 24 13:21:19 PST 2023
Sleeping for 1 seconds …
Analysis of file_5.txt has been completed at:
Tue Jan 24 13:21:20 PST 2023
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

Reading through the text for this example, I think I see what's going on here&mdash;and how I can use this example specifically to run `GNU parallel` such that it takes a header-ed, delimited file of entries that are parameter values for a command under the umbrella of `GNU parallel`; work on this ~~`#TOMORROW`~~~~in the coming days~~*Done.*

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
<br />

<a id="write-and-run-initial-tests-use-lists-with-trinity-job-submissions"></a>
## Write and run initial tests: Use lists with `Trinity` job submissions
<a id="get-situated-3"></a>
<a id="examine-and-edit-the-current-job-submission-script"></a>
### Examine and edit the current job-submission script
<a id="survey-the-current-script"></a>
#### Survey the current script
<details>
<summary><i>Code: Survey the current script</i></summary>

```bash
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%A-%a.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%A-%a.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "${1}"
    exit 1
}


check_directory_exists() {
    # Check that a directory exists; exit if it does not
    # 
    # :param 1: directory, including path <chr>
    [[ -d "${1}" ]] ||
        {
            echo -e "Exiting: Directory ${1} does not exist.\n"
            exit 1
        }
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "${1}" ]] ||
        {
            echo -e "Exiting: File ${1} does not exist.\n"
            exit 1
        }
}


check_value_integer() {
    # Check that a value is an integer; exit if not
    # 
    # :param 1: value to be checked for positive \"integer\" data type
    # :param 2: string specifying what argument is being tests <chr> 
    [[ ! "${1}" =~ ^[0-9]+$ ]] &&
        {
            echo -e "Exiting: Argument for ${2} must be a positive integer.\n"
            exit 1
        }
}


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
${0}
-c  {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
-l  {left_1}         first of two .fastq.gz files for 'left' reads <chr>
-b  {left_2}         second of two .fastq.gz files for 'left' reads <chr>
-r  {right_1}        first of two .fastq.gz files for 'right' reads <chr>
-d  {right_2}        second of two .fastq.gz files for 'right' reads <chr>
-o  {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
-k  {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1> [default: 1]
-i  {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float>
                     [default: 0.05]
-g  {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1> [default: 2]
-f  {glue_factor}    fraction of maximum (Inchworm pair coverage) for read glue
                     support <float> [default: 0.05]
"""

while getopts "c:l:b:r:d:o:k:i:g:f:" opt; do
    case "${opt}" in
        c) catalog="${OPTARG}" ;;
        l) left_1="${OPTARG}" ;;
        b) left_2="${OPTARG}" ;;
        r) right_1="${OPTARG}" ;;
        d) right_2="${OPTARG}" ;;
        o) out="${OPTARG}" ;;
        k) min_kmer_cov="${OPTARG}" ;;
        i) min_iso_ratio="${OPTARG}" ;;
        g) min_glue="${OPTARG}" ;;
        f) glue_factor="${OPTARG}" ;;
        *) print_message_exit "${help}" ;;
    esac
done

[[ -z "${catalog}" ]] && print_message_exit "${help}"
[[ -z "${left_1}" ]] && print_message_exit "${help}"
[[ -z "${left_2}" ]] && print_message_exit "${help}"
[[ -z "${right_1}" ]] && print_message_exit "${help}"
[[ -z "${right_2}" ]] && print_message_exit "${help}"
[[ -z "${out}" ]] && print_message_exit "${help}"
[[ -z "${min_kmer_cov}" ]] && min_kmer_cov=1
[[ -z "${min_iso_ratio}" ]] && min_iso_ratio=0.05
[[ -z "${min_glue}" ]] && min_glue=2
[[ -z "${glue_factor}" ]] && glue_factor=0.05


#  ------------------------------------
check_directory_exists "${catalog}"
# check_file_exists "${left_1}"
# check_file_exists "${left_2}"
# check_file_exists "${right_1}"
# check_file_exists "${right_2}"
check_value_integer "${min_kmer_cov}" "{min_kmer_cov}"
check_value_integer "${min_glue}" "{min_glue}"

#TODO 1/2 In the echo test and submission script, check_file_exists() will lead
#TODO 2/2 to exit b/c not accessing container mount
#TODO Check that directory portion of {out} exists
#TODO check_value_float "${min_iso_ratio}" "{min_iso_ratio}"
#TODO check_value_float "${glue_factor}" "{glue_factor}"


#  Echo -------------------------------
time_start="$(date +%s)"

parallel --header : --colsep " " -k -j 1 echo \
    'singularity run \
        --bind {catalog}:/data \
        --bind {scratch}:/loc/scratch \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --seqType fq \
                --left {left_1},{left_2} \
                --right {right_1},{right_2} \
                --jaccard_clip \
                --output {out} \
                --full_cleanup \
                --min_kmer_cov {min_kmer_cov} \
                --min_iso_ratio {min_iso_ratio} \
                --min_glue {min_glue} \
                --glue_factor {glue_factor} \
                --max_reads_per_graph 2000 \
                --normalize_max_read_cov 200 \
                --group_pairs_distance 700 \
                --min_contig_length 200' \
::: catalog "${catalog}" \
::: scratch "/fh/scratch/delete30/tsukiyama_t" \
::: j_mem "50G" \
::: j_cor "${SLURM_CPUS_ON_NODE}" \
::: left_1 "${left_1}" \
:::+ left_2 "${left_2}" \
:::+ right_1 "${right_1}" \
:::+ right_2 "${right_2}" \
:::+ out "${out}" \
::: min_kmer_cov "${min_kmer_cov}" \
::: min_iso_ratio "${min_iso_ratio}" \
::: min_glue "${min_glue}" \
::: glue_factor "${glue_factor}"


#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \
    'singularity run \
        --bind {catalog}:/data \
        --bind {scratch}:/loc/scratch \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --seqType fq \
                --left {left_1},{left_2} \
                --right {right_1},{right_2} \
                --jaccard_clip \
                --output {out} \
                --full_cleanup \
                --min_kmer_cov {min_kmer_cov} \
                --min_iso_ratio {min_iso_ratio} \
                --min_glue {min_glue} \
                --glue_factor {glue_factor} \
                --max_reads_per_graph 2000 \
                --normalize_max_read_cov 200 \
                --group_pairs_distance 700 \
                --min_contig_length 200' \
::: catalog "${catalog}" \
::: scratch "/fh/scratch/delete30/tsukiyama_t" \
::: j_mem "50G" \
::: j_cor "${SLURM_CPUS_ON_NODE}" \
::: left_1 "${left_1}" \
:::+ left_2 "${left_2}" \
:::+ right_1 "${right_1}" \
:::+ right_2 "${right_2}" \
:::+ out "${out}" \
::: min_kmer_cov "${min_kmer_cov}" \
::: min_iso_ratio "${min_iso_ratio}" \
::: min_glue "${min_glue}" \
::: glue_factor "${glue_factor}"

time_end="$(date +%s)"
```
</details>
<br />

<a id="adapt-the-script-to-take-a-header-ed-list-of-arguments"></a>
#### Adapt the script to take a header-ed list of arguments
<details>
<summary><i>Code: Adapt script to take a header-ed list of arguments</i></summary>

<a id="executable-version"></a>
##### *Executable version*
```bash
#!/bin/bash

#  ${script_name_ech}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "${1}" ]] ||
        {
            echo -e "Exiting: File ${1} does not exist.\n"
            exit 1
        }
}


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
${0}:
This script takes in a single file that requires a list of arguments
-a  {arguments}  space-delimited list of arguments for the below settings and
                 parameters; list is header-ed with the names of variables for
                 the arguments (in brackets below)

    #  -------------------------------------
    {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
    {scratch}        scratch directory, including path, to be mounted to the
                     Trinity container <chr>
    {j_mem}          max memory to used by Trinity when limiting can be enabled
                     (e.g., with jellyfish, sorting, etc.); must be in the form
                     of a nonnegative integer followed by a single uppercase
                     letter signifying the unit of storage, e.g., '50G' <chr>
    {j_cor}          number of threads for Trinity to use <int >= 1>
    {left_1}         first of two .fastq.gz files for 'left' reads <chr>
    {left_2}         second of two .fastq.gz files for 'left' reads <chr>
    {right_1}        first of two .fastq.gz files for 'right' reads <chr>
    {right_2}        second of two .fastq.gz files for 'right' reads <chr>
    {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
    {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1>
    {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float>
    {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1>
    {glue_factor}    fraction of maximum (Inchworm pair coverage) for read
                     glue support <float>
    #  -------------------------------------
"""

while getopts "a:" opt; do
    case "${opt}" in
        a) arguments="${OPTARG}" ;;
        *) print_message_exit "${help}" ;;
    esac
done

[[ -z "${arguments}" ]] && print_message_exit "${help}"


#  ------------------------------------
check_file_exists "${arguments}"


#  Echo -------------------------------
time_start="$(date +%s)"

parallel --header : --colsep " " -k -j 1 echo \
    'singularity run \
        --bind {catalog}:/data \
        --bind {scratch}:/loc/scratch \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --seqType fq \
                --left {left_1},{left_2} \
                --right {right_1},{right_2} \
                --jaccard_clip \
                --output {out} \
                --full_cleanup \
                --min_kmer_cov {min_kmer_cov} \
                --min_iso_ratio {min_iso_ratio} \
                --min_glue {min_glue} \
                --glue_factor {glue_factor} \
                --max_reads_per_graph 2000 \
                --normalize_max_read_cov 200 \
                --group_pairs_distance 700 \
                --min_contig_length 200' \
:::: "${arguments}"

time_end="$(date +%s)"
```

<a id="heredoc-ready-version"></a>
##### *HEREDOC-ready version*
`#DEKHO`
```bash
#!/bin/bash

#  ${script_name_ech}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="\$(echo "\${2}" - "\${1}" | bc -l)"
    
    echo ""
    echo "\${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    \$(( run_time/3600 )) \$(( run_time%3600/60 )) \$(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
\${0}:
This script takes in a single file that requires a list of arguments
-a  {arguments}  space-delimited list of arguments for the below settings and
                 parameters; list is header-ed with the names of variables for
                 the arguments (in brackets below)

    #  -------------------------------------
    {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
    {scratch}        scratch directory, including path, to be mounted to the
                     Trinity container <chr>
    {j_mem}          max memory to used by Trinity when limiting can be enabled
                     (e.g., with jellyfish, sorting, etc.); must be in the form
                     of a nonnegative integer followed by a single uppercase
                     letter signifying the unit of storage, e.g., '50G' <chr>
    {j_cor}          number of threads for Trinity to use <int >= 1>
    {left_1}         first of two .fastq.gz files for 'left' reads <chr>
    {left_2}         second of two .fastq.gz files for 'left' reads <chr>
    {right_1}        first of two .fastq.gz files for 'right' reads <chr>
    {right_2}        second of two .fastq.gz files for 'right' reads <chr>
    {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
    {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1>
    {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float>
    {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1>
    {glue_factor}    fraction of maximum (Inchworm pair coverage) for read
                     glue support <float>
    #  -------------------------------------
"""

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"


#  ------------------------------------
check_file_exists "\${arguments}"


#  Echo -------------------------------
time_start="\$(date +%s)"

parallel --header : --colsep " " -k -j 1 echo \
    'singularity run \
        --bind {catalog}:/data \
        --bind {scratch}:/loc/scratch \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --seqType fq \
                --left {left_1},{left_2} \
                --right {right_1},{right_2} \
                --jaccard_clip \
                --output {out} \
                --full_cleanup \
                --min_kmer_cov {min_kmer_cov} \
                --min_iso_ratio {min_iso_ratio} \
                --min_glue {min_glue} \
                --glue_factor {glue_factor} \
                --max_reads_per_graph 2000 \
                --normalize_max_read_cov 200 \
                --group_pairs_distance 700 \
                --min_contig_length 200' \
:::: "\${arguments}"

time_end="\$(date +%s)"
```
</details>
<br />

<a id="write-a-code-chunk-for-a-script-for-the-job-submission"></a>
### Write a code chunk for a script for the job submission
<details>
<summary><i>Code: Write a code chunk for a script for the job submission</i></summary>

<a id="executable-version-1"></a>
#### *Executable version*
```bash
#!/bin/bash

#!/bin/bash

#SBATCH --job-name=${script_name_ech}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_ech%.sh}.%A-%a.err.txt
#SBATCH --output=${err_out}/${script_name_ech%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_name_run}
#  KA
#  $(date '+%Y-%m%d')

srun \
    "${sh_err_out}/${script_name_ech}" \
        -a "${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt"
```

<a id="heredoc-ready-version-1"></a>
#### *HEREDOC-ready version*
```bash
#!/bin/bash

#!/bin/bash

#SBATCH --job-name=${script_name_ech}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_ech%.sh}.%A-%a.err.txt
#SBATCH --output=${err_out}/${script_name_ech%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_name_run}
#  KA
#  $(date '+%Y-%m%d')

srun \
    "${sh_err_out}/${script_name_ech}" \
        -a "${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"
```
</details>
<br />

<a id="get-situated-3"></a>
### Get situated
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

Trinity_env
```
</details>
<br />

<a id="create-an-appropriate-list-to-be-used-with-modified-script"></a>
### Create an appropriate list to be used with modified script
<a id="get-file-directory-info-into-a-deduplicated-associative-array"></a>
#### Get file, directory info into a deduplicated associative array
<details>
<summary><i>Code: Getting file, directory info into a deduplicated associative array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Create an array of files of interest, including relative paths -------------
unset d_in_base
typeset -a d_in_base=(
    files_processed-full/fastq*split/EndToEnd
)
# echoTest "${d_in_base[@]}"
# echo "${#d_in_base[@]}"


#  Get necessary file/path info into separate arrays ------
unset f_in
unset d_in
typeset -a f_in
typeset -a d_in
for i in "${d_in_base[@]}"; do
    # i="${d_in_base[0]}"
    echo "#  Working with files in... --------------------------------"
    echo "#+ ${i}"
    # ., "${i}"

    while IFS=" " read -r -d $'\0'; do
        f_in+=( "$(echo "$(basename "${REPLY%.?.fq.gz}")" | cut -d $'_' -f 2-)" )
        d_in+=( "$(dirname "${REPLY}")" )
    done < <(\
        find "${i}" \
            -type f \
            -name "*_Q_IP_*_1_*.?.fq.gz" \
            -print0
    )

    echo ""
done
echoTest "${f_in[@]}"
echoTest "${d_in[@]}"


#  Rejoin the path and file info before dedup'ing ---------
unset d_f_rejoin
typeset -a d_f_rejoin
for i in $(seq 0 $(echo "${#f_in[@]}" - 1 | bc)); do
    d_f_rejoin+=( "${d_in[${i}]}/${f_in[${i}]}" )
done
echoTest "${d_f_rejoin[@]}"


#  Remove duplicate elements from the "rejoin" array ------
IFS=" " read -r -a d_f_rejoin \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${d_f_rejoin[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echoTest "${d_f_rejoin[@]}"


#  "Unjoin" the "rejoin" array ----------------------------
unset f_in
unset d_in
typeset -a f_in
typeset -a d_in
for i in "${d_f_rejoin[@]}"; do
    echo "#  Working with... ------------------------------------------"
    echo "#+ ${i}"

    f_in+=( "$(basename "${i%.?.fq.gz}")" )
    d_in+=( "$(dirname "${i}")" )

    echo ""
done
echoTest "${f_in[@]}"
echoTest "${d_in[@]}"
```
</details>
<br />

<a id="define-variables"></a>
#### Define variables
<details>
<summary><i>Code: Define variables</i></summary>

`#DEKHO`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_name_sub="submit_Trinity-GF_optimization.sh"
script_name_ech="echo_Trinity-GF_optimization.sh"
script_name_run="run_Trinity-GF_optimization.sh"

sh_err_out="tutorial_job-arrays/test_list"
err_out="tutorial_job-arrays/test_list"
threads=8

max_id_job=1
max_id_task=1

store="tutorial_job-arrays/test_list"  # cd "${store}"
list="test_list.txt"  # echo "${list}"

catalog="$(dirname "$(pwd)")/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
scratch="/fh/scratch/delete30/tsukiyama_t"

j_mem="50G"
j_cor="${threads}"

file_1="${d_in[0]}/5781_${f_in[0]}.1.fq.gz"
d_base="files_Trinity-GF/$(echo "${file_1}" | cut -d "/" -f 1)" 
d_mid="$(\
    echo $(basename "${file_1}" ".Aligned.sortedByCoord.out.sc_all.1.fq.gz") \
        | cut -d $'_' -f 2- \
)"

left_1="/data/5781_${f_in[0]}.1.fq.gz"
left_2="/data/5782_${f_in[0]}.1.fq.gz"
right_1="/data/5781_${f_in[0]}.2.fq.gz"
right_2="/data/5782_${f_in[0]}.2.fq.gz"

out="${d_base}/${d_mid}"

min_kmer_cov=1
min_iso_ratio=0.01
min_glue=1
glue_factor=0.005
```
</details>
<br />

<a id="set-up-directory-for-storing-results-from-these-tests"></a>
#### Set up directory for storing results from these tests
<details>
<summary><i>Code: Set up directory for storing results from these tests</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ ! -d "${store}" ]]; then mkdir -p "${store}"; fi
```
</details>
<br />

<a id="generate-the-list"></a>
#### Generate the list
<details>
<summary><i>Code: Generate the list</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list}" ]]; then
    rm "${store}/${list}"
fi
echo "catalog" \
    "scratch" \
    "j_mem"  \
    "j_cor" \
    "left_1" \
    "left_2" \
    "right_1" \
    "right_2" \
    "out" \
    "min_kmer_cov" \
    "min_iso_ratio" \
    "min_glue" \
    "glue_factor" \
        >> "${store}/${list}"

echo "${catalog}" \
    "/fh/scratch/delete30/tsukiyama_t" \
    "50G" \
    "\${SLURM_CPUS_ON_NODE}" \
    "${left_1}" \
    "${left_2}" \
    "${right_1}" \
    "${right_2}" \
    "${out}" \
    "${min_kmer_cov}" \
    "${min_iso_ratio}" \
    "${min_glue}" \
    "${glue_factor}" \
        >> "${store}/${list}"
# vi "${store}/${list}"
# cat "${store}/${list}"
```
</details>
<br />

<a id="write-out-the-list-ready-run-script-echo-test-using-a-heredoc"></a>
### Write out the list-ready run script (`echo` test) using a `HEREDOC`
<details>
<summary><i>Code: Write out the list-ready, adapted script (echo test) using a HEREDOC</i></summary>

`#DEKHO`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_ech}" ]]; then
    rm "${sh_err_out}/${script_name_ech}"
fi
cat << script > "${sh_err_out}/${script_name_ech}"
#!/bin/bash

#  ${script_name_ech}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="\$(echo "\${2}" - "\${1}" | bc -l)"
    
    echo ""
    echo "\${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    \$(( run_time/3600 )) \$(( run_time%3600/60 )) \$(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
\${0}:
This script takes in a single file that requires a list of arguments
-a  {arguments}  space-delimited list of arguments for the below settings and
                 parameters; list is header-ed with the names of variables for
                 the arguments (in brackets below)

    #  -------------------------------------
    {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
    {scratch}        scratch directory, including path, to be mounted to the
                     Trinity container <chr>
    {j_mem}          max memory to used by Trinity when limiting can be enabled
                     (e.g., with jellyfish, sorting, etc.); must be in the form
                     of a nonnegative integer followed by a single uppercase
                     letter signifying the unit of storage, e.g., '50G' <chr>
    {j_cor}          number of threads for Trinity to use <int >= 1>
    {left_1}         first of two .fastq.gz files for 'left' reads <chr>
    {left_2}         second of two .fastq.gz files for 'left' reads <chr>
    {right_1}        first of two .fastq.gz files for 'right' reads <chr>
    {right_2}        second of two .fastq.gz files for 'right' reads <chr>
    {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
    {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1>
    {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float>
    {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1>
    {glue_factor}    fraction of maximum (Inchworm pair coverage) for read
                     glue support <float>
    #  -------------------------------------
"""

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"


#  ------------------------------------
check_file_exists "\${arguments}"


#  Echo -------------------------------
time_start="\$(date +%s)"

parallel --header : --colsep " " -k -j 1 echo \
    'singularity run \
        --bind {catalog}:/data \
        --bind {scratch}:/loc/scratch \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --seqType fq \
                --left {left_1},{left_2} \
                --right {right_1},{right_2} \
                --jaccard_clip \
                --output {out} \
                --full_cleanup \
                --min_kmer_cov {min_kmer_cov} \
                --min_iso_ratio {min_iso_ratio} \
                --min_glue {min_glue} \
                --glue_factor {glue_factor} \
                --max_reads_per_graph 2000 \
                --normalize_max_read_cov 200 \
                --group_pairs_distance 700 \
                --min_contig_length 200' \
:::: "\${arguments}"

time_end="\$(date +%s)"
script
# vi "${sh_err_out}/${script_name_ech}"  # :q
# cat "${sh_err_out}/${script_name_ech}"
```
</details>
<br />

<a id="write-out-the-submission-script-echo-test-using-a-heredoc"></a>
### Write out the submission script (`echo` test) using a `HEREDOC`
<details>
<summary><i>Code: Write out the submission script (echo test) using a HEREDOC</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${script_name_run}" ]]; then
    rm "${store}/${script_name_run}"
fi
cat << script > "${store}/${script_name_run}"
#!/bin/bash

#SBATCH --job-name=${script_name_ech}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_ech%.sh}.%A-%a.err.txt
#SBATCH --output=${err_out}/${script_name_ech%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_name_run}
#  KA
#  $(date '+%Y-%m%d')

mkc="mkc-\$(
    cat "./${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \
        | awk -v OFS='\t' 'FNR == 2 { print \$10 }'
)"
mir="mir-\$(
    cat "./${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \
        | awk -v OFS='\t' 'FNR == 2 { print \$11 }'
)"
mg="mg-\$(
    cat "./${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \
        | awk -v OFS='\t' 'FNR == 2 { print \$12 }'
)"
gf="gf-\$(
    cat "./${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \
        | awk -v OFS='\t' 'FNR == 2 { print \$13 }'
)"
name="trinity_\${mkc}_\${mir}_\${mg}_\${gf}"

ln -f \
    ${err_out}/${script_name_ech%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \
    ${err_out}/${script_name_ech%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \
    "${sh_err_out}/${script_name_ech}" \
        -a "./${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \
    ${err_out}/${script_name_ech%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \
    ${err_out}/${script_name_ech%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
# vi "${store}/${script_name_run}"  # :q
# cat "${store}/${script_name_run}"
```
`#TODO` Copy and document the code here in the chunks under 'Write a code chunk for a script for the job submission'; then, move on to adapting this code with the numerous individual lists generated below; then, should be go to get Trinity running (handle UMIs first?)
</details>
<br />

<a id="do-a-test-run-of-the-script-and-list"></a>
### Do a test run of the script and list
<details>
<summary><i>Code: Do a test run of the script and list</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get a test file that is named like one of the individual files that I will
#+ ultimately use
if [[ ! -f "./${store}/${list/.txt/.1.txt}" ]]; then 
    cp \
        "./${store}/${list}" \
        "./${store}/${list/.txt/.1.txt}"
fi

sbatch "./${store}/${script_name_run}"

cat ./${store}/${list%.txt}.1.txt \
        | awk -v OFS='\t' 'FNR == 2 { print $10 }'
```
</details>
<br />

<details>
<summary><i>Code and printed: Do a test run of the script and list</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${store}" || echo "cd'ing failed; check on this..."
.,

cat echo_Trinity-GF_optimization.8530517-1.out.txt
```

*Original*
```txt
❯ cd "${store}" || echo "cd'ing failed; check on this..."
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/tutorial_job-arrays/test_list

❯ .,
total 352K
drwxrws--- 2 kalavatt  468 Jan 26 16:50 ./
drwxrws--- 7 kalavatt  197 Jan 26 09:16 ../
-rw-rw---- 1 kalavatt  175 Jan 26 16:49 echo_Trinity-GF_optimization.8530516-1.err.txt
-rw-rw---- 1 kalavatt    0 Jan 26 16:49 echo_Trinity-GF_optimization.8530516-1.out.txt
-rw-rw---- 1 kalavatt    0 Jan 26 16:50 echo_Trinity-GF_optimization.8530517-1.err.txt
-rw-rw---- 1 kalavatt 1.1K Jan 26 16:50 echo_Trinity-GF_optimization.8530517-1.out.txt
-rwxrwx--- 1 kalavatt 4.3K Jan 26 16:37 echo_Trinity-GF_optimization.sh*
-rw-rw---- 1 kalavatt  505 Jan 26 16:47 run_Trinity-GF_optimization.sh
-rw-rw---- 1 kalavatt 4.5K Jan 26 12:28 submit_Trinity-GF_optimization.sh
-rw-rw---- 1 kalavatt  813 Jan 26 16:45 test_list.1.txt
-rw-rw---- 1 kalavatt  813 Jan 26 16:29 test_list.txt

❯ cat echo_Trinity-GF_optimization.8530517-1.out.txt
singularity run --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd:/data --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU ${SLURM_CPUS_ON_NODE} --SS_lib_type FR --seqType fq --left /data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right /data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.01 --min_glue 1 --glue_factor 0.005 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
```

*Reformatted*
```txt

```
Looks like all the information is making it into the script
</details>
<br />
<br />

<a id="write-a-code-chunk-to-generate-lists-of-arguments"></a>
## Write a code chunk to generate lists of arguments
<a id="get-situated-4"></a>
### Get situated
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN

mwd() {
    transcriptome \
        && cd "./results/2023-0111" \
        || echo "cd'ing failed; check on this"
}


mwd

Trinity_env
```
</details>
<br />

<a id="get-file-directory-info-into-a-deduplicated-associative-array-1"></a>
### Get file, directory info into a deduplicated associative array
<details>
<summary><i>Code: Getting file, directory info into a deduplicated associative array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Create an array of files of interest, including relative paths -------------
unset d_in_base
typeset -a d_in_base=(
    files_processed-full/fastq*split/EndToEnd
)
# echoTest "${d_in_base[@]}"
# echo "${#d_in_base[@]}"


#  Get necessary file/path info into separate arrays ------
unset f_in
unset d_in
typeset -a f_in
typeset -a d_in
for i in "${d_in_base[@]}"; do
    # i="${d_in_base[0]}"
    echo "#  Working with files in... --------------------------------"
    echo "#+ ${i}"
    # ., "${i}"

    while IFS=" " read -r -d $'\0'; do
        f_in+=( "$(echo "$(basename "${REPLY%.?.fq.gz}")" | cut -d $'_' -f 2-)" )
        d_in+=( "$(dirname "${REPLY}")" )
    done < <(\
        find "${i}" \
            -type f \
            -name "*_Q_IP_*_1_*.?.fq.gz" \
            -print0
    )

    echo ""
done
echoTest "${f_in[@]}"
echoTest "${d_in[@]}"


#  Rejoin the path and file info before dedup'ing ---------
unset d_f_rejoin
typeset -a d_f_rejoin
for i in $(seq 0 $(echo "${#f_in[@]}" - 1 | bc)); do
    d_f_rejoin+=( "${d_in[${i}]}/${f_in[${i}]}" )
done
echoTest "${d_f_rejoin[@]}"


#  Remove duplicate elements from the "rejoin" array ------
IFS=" " read -r -a d_f_rejoin \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${d_f_rejoin[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echoTest "${d_f_rejoin[@]}"


#  "Unjoin" the "rejoin" array ----------------------------
unset f_in
unset d_in
typeset -a f_in
typeset -a d_in
for i in "${d_f_rejoin[@]}"; do
    echo "#  Working with... ------------------------------------------"
    echo "#+ ${i}"

    f_in+=( "$(basename "${i%.?.fq.gz}")" )
    d_in+=( "$(dirname "${i}")" )

    echo ""
done
echoTest "${f_in[@]}"
echoTest "${d_in[@]}"
```
</details>
<br />

<a id="define-variables-necessary-for-the-list-generation-and-the-main-script"></a>
### Define variables necessary for the list generation and the main script
<details>
<summary><i>Code: Define variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Basic variables: script name and no. threads -------------------------------
script_name_sub="submit_Trinity-GF_optimization.sh"
script_name_ech="echo_Trinity-GF_optimization.sh"
script_name_run="run_Trinity-GF_optimization.sh"

err_out="tutorial_job-arrays/test_list_multi"
threads=8

max_id_job=288
max_id_task=10

store="tutorial_job-arrays/test_list_multi"
list="${store}/test_list_multi.txt"  # head "${list}"


#  Variables for directories to be mounted to the Trinity container -----------
catalog="$(dirname "$(pwd)")/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
scratch="/fh/scratch/delete30/tsukiyama_t"


#  Variables that define the max memory, no. threads used by Trinity ----------
j_mem="50G"
j_cor="${threads}"


#  Variables and arrays necessary to define the .fq.gz infiles ----------------
file_1="${d_in[0]}/5781_${f_in[0]}.1.fq.gz"
d_base="files_Trinity-GF/$(echo "${file_1}" | cut -d "/" -f 1)" 
d_mid="$(\
    echo $(basename "${file_1}" ".Aligned.sortedByCoord.out.sc_all.1.fq.gz") \
        | cut -d $'_' -f 2- \
)"

unset left_1
unset left_2
unset right_1
unset right_2
typeset -a left_1
typeset -a left_2
typeset -a right_1
typeset -a right_2
for i in "${f_in[@]}"; do
    left_1+=( "/data/5781_${i}.1.fq.gz")
    left_2+=( "/data/5782_${i}.1.fq.gz" )
    right_1+=( "/data/5781_${i}.2.fq.gz" )
    right_2+=( "/data/5782_${i}.2.fq.gz" )
done
echoTest "${left_1[@]}"
echoTest "${left_2[@]}"
echoTest "${right_1[@]}"
echoTest "${right_2[@]}"


#  Variables necessary to define Trinity outdirectories -----------------------
unset out
typeset -a out
out=(
    "${d_base}/${d_mid}"
    "${d_base}/something"
    "${d_base}/something_else"
)
echoTest "${out[@]}"


#  Variables necessary to define Trinity model parameters ---------------------
typeset -a min_kmer_cov=(1 2 4 8 16 32)
typeset -a min_iso_ratio=(0.005 0.01 0.05 0.1)
typeset -a min_glue=(1 2 4)
typeset -a glue_factor=(0.005 0.01 0.05 0.1)
echoTest "${min_kmer_cov[@]}"
echoTest "${min_iso_ratio[@]}"
echoTest "${min_glue[@]}"
echoTest "${glue_factor[@]}"
```
</details>
<br />

<a id="set-up-directory-for-storing-results-from-these-tests-1"></a>
### Set up directory for storing results from these tests
<details>
<summary><i>Code: Set up directory for storing results from these tests</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ ! -d "${store}" ]]; then
    mkdir -p "${store}"
fi
```
</details>
<br />

<a id="write-code-for-generating-lists-with-permutations-of-parameters"></a>
### Write code for generating lists with permutations of parameters
<a id="start-the-list-with-a-header"></a>
#### Start the list with a header
<details>
<summary><i>Code: Start the list with a header</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/test_list_multi.txt" ]]; then
    rm "${store}/test_list_multi.txt"
    # mv "${store}/test_list_multi.txt" "${store}/test_list_multi.1.txt"
fi
echo "catalog \
scratch \
j_mem \
j_cor \
left_1 \
left_2 \
right_1 \
right_2 \
out \
min_kmer_cov \
min_iso_ratio \
min_glue \
glue_factor" \
    > "${store}/test_list_multi.txt"
# vi "${store}/test_list_multi.txt"  # :q
# cat "${store}/test_list_multi.txt"
```
</details>
<br />

<a id="add-the-contents-to-the-header-ed-list"></a>
#### Add the contents to the header-ed list
<details>
<summary><i>Code: Write code for generating lists with permutations of parameters</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel --header : --colsep " " -k -j 1 echo \
"{catalog} \
{scratch} \
{j_mem} \
{j_cor} \
{left_1} \
{left_2} \
{right_1} \
{right_2} \
{out}/trinity_mkc-{min_kmer_cov}_mir-{min_iso_ratio}_mg-{min_glue}_gf-{glue_factor} \
{min_kmer_cov} \
{min_iso_ratio} \
{min_glue} \
{glue_factor}" \
::: catalog "${catalog}" \
::: scratch "${scratch}" \
::: j_mem "${j_mem}"  \
::: j_cor "${j_cor}" \
:::+ left_1 "${left_1[@]}" \
:::+ left_2 "${left_2[@]}" \
:::+ right_1 "${right_1[@]}" \
:::+ right_2 "${right_2[@]}" \
:::+ out "${out[@]}" \
::: min_kmer_cov "${min_kmer_cov[@]}" \
::: min_iso_ratio "${min_iso_ratio[@]}" \
::: min_glue "${min_glue[@]}" \
::: glue_factor "${glue_factor[@]}" \
    >> "${store}/test_list_multi.txt"
# wc -l "${store}/test_list_multi.txt"
```
</details>
<br />

<a id="examine-the-text-printed-to-%24storetest_list_multitxt"></a>
#### Examine the text printed to `"${store}/test_list_multi.txt"`
<details>
<summary><i>Printed: Examine the text printed to "${store}/test_list_multi.txt"</i></summary>
<br />

<b>Prior to adding the file stem and header</b>

*Various lines selected from the file and formatted with new lines, etc.*  
<br />

<u>Line 2</u>
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd \
/fh/scratch/delete30/tsukiyama_t \
50G \
8 /data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
files_Trinity-GF/files_processed-full/Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd \
1 \
0.005 \
1 \
0.01
```

<u>Line 65</u>
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd \
/fh/scratch/delete30/tsukiyama_t \
50G \
8 \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
files_Trinity-GF/files_processed-full/Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd \
2 \
0.01 \
2 \
0.005
```

<u>Line 119</u>
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd \
/fh/scratch/delete30/tsukiyama_t \
50G \
8 \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
files_Trinity-GF/files_processed-full/Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd \
4 \
0.01 \
4 \
0.05
```

<u>Line 222</u>
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd \
/fh/scratch/delete30/tsukiyama_t \
50G \
8 \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
files_Trinity-GF/files_processed-full/Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd \
16 \
0.05 \
2 \
0.01
```

<u>Line 278</u>
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd \
/fh/scratch/delete30/tsukiyama_t \
50G \
8 \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
files_Trinity-GF/files_processed-full/Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd \
32 \
0.1 \
1 \
0.01
```

<b>After adding the file stem but not yet the header</b>

*Line selected from the file and formatted with new lines, etc.*  
<br />

<u>Line 4</u>
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd \
/fh/scratch/delete30/tsukiyama_t \
50G \
8 \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
files_Trinity-GF/files_processed-full/Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_mkc-1_mir-0.005_mg-1_gf-0.1 \
1 \
0.005 \
1 \
0.1
```

<b>After adding both the file stem and header</b>

*Line selected from the file and formatted with new lines, etc.*  
<br />

<u>Lines 1 and 2</u>
```txt
catalog scratch j_mem j_cor left_1 left_2 right_1 right_2 out min_kmer_cov min_iso_ratio min_glue glue_factor
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd \
/fh/scratch/delete30/tsukiyama_t \
50G \
8 \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
/data/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
/data/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
files_Trinity-GF/files_processed-full/Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_mkc-1_mir-0.005_mg-1_gf-0.005 \
1 \
0.005 \
1 \
0.005
```

</details>
<br />

<details>
<summary><i>Notes: Examine the text printed to "${store}/test_list_multi.txt"</i></summary>

There should be 288 permutations (from 6 × 4 × 3 × 4), and thus 288 lines, i.e.,
- 6 values for `"${min_kmer_cov[@]}"`
- 4 values for `"${min_iso_ratio[@]}"`
- 3 values for `"${min_glue[@]}"`
- 4 values for `"${glue_factor[@]}"`
</details>
<br />
<br />

<a id="write-a-chunk-to-split-the-complete-list-into-individual-lists"></a>
## Write a chunk to split the complete list into individual lists
<details>
<summary><i>Code: Write a chunk to split the list into individual files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/test_list_multi.24.txt" ]]; then
    rm "${store}/"*.{?,??,???}.txt
fi
typeset -i i=0

sed 1d "${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${individual}" ]] || rm "${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${list}" >> "${individual}"
    echo "${line}" >> "${individual}"

    # echo "Created file: ${individual}"
done
# vi "${store}/test_list_multi.24.txt"  # :q
# cat "${store}/test_list_multi.24.txt"  # :q
```
</details>
<br />
<br />

<a id="run-an-sbatch-echo-test-using-the-individual-lists"></a>
## Run an `sbatch` `echo` test using the individual lists
<details>
<summary><i>Code: Run an sbatch echo test using the individual lists</i></summary>

```bash
#!/bin/bash


```
</details>
<br />
