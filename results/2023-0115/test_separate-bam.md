
`test_separate-bam.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Run `separate_bam.sh` and evaluate results](#run-separate_bamsh-and-evaluate-results)
    1. [Contents of `separate_bam.sh` at time of running, evaluation](#contents-of-separate_bamsh-at-time-of-running-evaluation)
        1. [Code](#code)
    1. [Get situated](#get-situated)
        1. [Code](#code-1)
    1. [Run `separate_bam.sh`; evaluate the `flagstat` and `list-tally-flags` files](#run-separate_bamsh-evaluate-the-flagstat-and-list-tally-flags-files)
        1. [Code](#code-2)
        1. [Printed](#printed)
    1. [Examine flags in some of the outfiles](#examine-flags-in-some-of-the-outfiles)
        1. [5781_Q_IP_UT.exclude-unmapped.ex-s-u](#5781_q_ip_utexclude-unmappedex-s-u)
            1. [Code](#code-3)
            1. [Printed](#printed-1)
        1. [5781_Q_IP_UT.exclude-unmapped.in-s](#5781_q_ip_utexclude-unmappedin-s)
            1. [Code](#code-4)
            1. [Printed](#printed-2)
        1. [5781_Q_IP_UT.exclude-unmapped.in-u](#5781_q_ip_utexclude-unmappedin-u)
            1. [Code](#code-5)
            1. [Printed](#printed-3)
        1. [5781_Q_IP_UT.exclude-unmapped.in-s-u](#5781_q_ip_utexclude-unmappedin-s-u)
            1. [Code](#code-6)
            1. [Printed](#printed-4)
1. [Breaking down the contents of the '`ex`' and '`in`' files](#breaking-down-the-contents-of-the-ex-and-in-files)
    1. [Breaking down the contents of the '`ex`' files](#breaking-down-the-contents-of-the-ex-files)
    1. [Breaking down the contents of the '`in`' files](#breaking-down-the-contents-of-the-in-files)
1. [Summarize decisions](#summarize-decisions)
1. [Update `separate_bam.sh` to reflect the above](#update-separate_bamsh-to-reflect-the-above)
    1. [Tasks](#tasks)
    1. [Test the updated script](#test-the-updated-script)
        1. [Code](#code-7)
        1. [Printed](#printed-5)
1. [Observations, `#NEXTSTEP`s](#observations-nextsteps)
1. [Update `separate_bam.sh`](#update-separate_bamsh)
    1. [Contents of `separate_bam.sh` prior to additional updates](#contents-of-separate_bamsh-prior-to-additional-updates)
        1. [Code](#code-8)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="run-separate_bamsh-and-evaluate-results"></a>
## Run `separate_bam.sh` and evaluate results
<a id="contents-of-separate_bamsh-at-time-of-running-evaluation"></a>
### Contents of `separate_bam.sh` at time of running, evaluation
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Contents of separate_bam.sh at time of running, evaluation</i></summary>

```bash
#!/bin/bash

#  separate_split_bam.sh
#  KA


check_dependency() {
    what="""
    check_dependency()
    ------------------
    Check if program is available in \"\${PATH}\"; exit if not
    
    :param 1: program to be checked <chr>
    :return: NA
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    else
        command -v "${1}" &>/dev/null ||
            {
                printf "%s\n" "Exiting: \"${1}\" not found in \"\${PATH}\"."
                printf "%s\n\n" "         Check your env or install \"${1}\"?"
                # exit 1
            }
    fi
}


check_argument_safe_mode() {
    what="""
    check_argument_safe_mode()
    --------------------------
    Run script in \"safe mode\" (\`set -Eeuxo pipefail\`) if specified

    #TODO Check that param is not empty or inappropriate format/string

    :param 1: run script in safe mode: TRUE or FALSE <lgl> [default: FALSE]
    :return: NA    
    """
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            printf "%s\n" "-u: \"Safe mode\" is TRUE."
            set -Eeuxo pipefail
            ;;
        false | f | 0) \
            printf "%s\n" "\"Safe mode\" is FALSE." ;;
        *) \
            printf "%s\n" "Exiting: \"Safe mode\" must be TRUE or FALSE."
            # exit 1
            ;;
    esac
}


check_exists_file() {
    what="""
    check_exists_file()
    -------------------
    Check that a file exists; exit if it doesn't
    
    #TODO Check that param is not an inappropriate format/string

    :param 1: file, including path <chr>
    :return: NA
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    elif [[ ! -f "${1}" ]]; then
        printf "%s\n\n" "Exiting: File \"${1}\" does not exist."
        # exit 1
    else
        :
    fi
}


check_exists_directory() {
    what="""
    check_exists_directory()
    ------------------------
    Check that a directory exists; if it doesn't, then either make it or exit

    #TODO Check that params are not empty or inappropriate formats/strings

    :param 1: create directory if not found: TRUE or FALSE <lgl>
    :param 2: directory, including path <chr>
    :return: NA    
    """
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "${2} doesn't exist; mkdir'ing it."
                    mkdir -p "${2}"
                }
            ;;
        false | f | 0) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "Exiting: ${2} does not exist."
                    exit 1
                }
            ;;
        *) \
            printf "%s\n" "Exiting: param 1 is not TRUE or FALSE."
            printf "%s\n" "${what}"
            exit 1
            ;;
    esac
}


check_argument_threads() {
    what="""
    check_argument_threads()
    ---------------
    Check the value assigned to variable for threads/cores in script

    :param 1: value assigned to variable for threads/cores <int >= 1>
    :return: NA

    #TODO Checks...
    """
    case "${1}" in
        '' | *[!0-9]*) \
            printf "%s\n" "Exiting: argument must be an integer >= 1."
            # exit 1
            ;;
        *) : ;;
    esac
}


check_argument_unmapped() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            unmapped=1
            printf "%s\n" "\"Target 'unmapped' reads\" is TRUE."
            ;;
        false | f | 0) \
            unmapped=0
            printf "%s\n" "\"Target 'unmapped' reads\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"unmapped\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_secondary() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            secondary=1
            printf "%s\n" "\"Target 'secondary' alignments\" is TRUE."
            ;;
        false | f | 0) \
            secondary=0
            printf "%s\n" "\"Target 'secondary' alignments\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"secondary\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_mode() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        1) \
            mode=1
            printf "%s\n" "\"Run in '{in,ex}clusion' mode\" is set to '1'."
            ;;
        2) \
            mode=2
            printf "%s\n" "\"Run in '{in,ex}clusion' mode\" is set to '2'."
            ;;
        3) \
            mode=3
            printf "%s\n" "\"Run in '{in,ex}clusion' mode\" is set to '3'."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"{in,ex}clusion mode\" argument must be 1, 2, or 3.\n"
            # exit 1
            ;;
    esac
}


check_argument_flagstat() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            flagstat=1
            printf "%s\n" "\"Run samtools flagstat\" is TRUE."
            ;;
        false | f | 0) \
            flagstat=0
            printf "%s\n" "\"Run samtools flagstat\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"flagstat\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


calculate_run_time() {
    what="""
    calculate_run_time()
    --------------------
    Calculate run time for chunk of code
    
    #TODO Check that params are not empty or inappropriate formats or strings

    :param 1: start time in \$(date +%s) format
    :param 2: end time in \$(date +%s) format
    :param 3: message to be displayed when printing the run time <chr>
    :return: message <chr>
    """
    local run_time
    
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
        $(( run_time/3600 )) \
        $(( run_time%3600/60 )) \
        $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    what="""
    display_spinning_icon()
    -----------------------
    Display \"spinning icon\" while a background process runs
    
    #TODO Checks...
    
    :param 1: PID of the last program the shell ran in the background <int>
    :param 2: message to be displayed next to the spinning icon <chr>
    :return: spinning icon <chr>
    """
    local spin
    local i
    
    spin="/|\\–"
    i=0
    
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    what="""
    list_tally_flags()
    ------------------
    List and tally flags in a bam infile; function acts on a bam infile to
    perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    list and tally flags; function writes the results to a txt outfile, the
    name of which is derived from the txt infile

    #TODO Checks...

    :param 1: name of bam infile, including path <chr>
    :param 2: name of txt outfile, including path <chr>
    :return: file \"\${2}\"
    """
    local start
    local end

    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
            > "${2}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


check_argument_list_etc() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            list_etc=1
            printf "%s\n" "\"Run list_tally_flags()\" is TRUE."
            ;;
        false | f | 0) \
            list_etc=0
            printf "%s\n" "\"Run list_tally_flags()\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"list_etc\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


convert_chr_lower() {
    what="""
    convert_chr_lower()
    -------------------
    Convert alphabetical characters in a string to lowercase letters
    
    :param 1: string <chr>
    :return: converted string (stdout) <chr>
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    else
        string_in="${1}"
        string_out="$(printf %s "${string_in}" | tr '[:upper:]' '[:lower:]')"

        echo "${string_out}"
    fi
}


print_usage() {
    what="""
    print_usage()
    -------------
    Print the script's help message and exit

    #TODO Checks...

    :param 1: help message assigned to a variable within script <chr>
    :return: help message (stdout) <chr>
    """
    echo "${1}"
    exit 1
}


check_etc() {
    what="""
    check_etc()
    -----------
    Check dependencies, and check and make variable assignments 

    #TODO Checks, etc., and a means to print the contents of variable what

    :global safe_mode:
    :global infile:
    :global outdir:
    :global threads:
    :global flagstat:
    :return global base:
    :return global outfile:
    """
    #  Check for necessary dependencies; exit if not found
    check_dependency samtools

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode "${safe_mode}"

    #  Check that "${infile}" exists
    check_exists_file "${infile}"

    #  If TRUE, then make "${outdir}" if it does not exist; if FALSE (i.e.,
    #+ "${outdir}" does not exist), then exit
    check_exists_directory TRUE "${outdir}"

    #TODO
    check_argument_unmapped "${unmapped}"
    
    #TODO
    check_argument_secondary "${secondary}"
    
    #TODO
    check_argument_mode "${mode}"
    
    #  Check on value assigned to "${flagstat}"
    check_argument_flagstat "${flagstat}"

    #TODO
    check_argument_list_etc "${list_etc}"
    
    #  Check on value assigned to "${threads}"
    check_argument_threads "${threads}"

    #TODO Not sure if I want these assignments in this function...
    #  Make additional variable assignments from the arguments
    base="$(basename "${infile}")"
    outfile="${base%.bam}.exclude-unmapped.bam"

    echo ""
}


main() {
    what="""
    main()
    ------
    Run samtools view to exclude unmapped reads from bam infile; optionally,
    run samtools flagstat on primary alignment-filtered bam outfile

    #TODO Checks, etc., and a means to print the contents of variable what
    
    :global threads: number of threads <int >= 1>
    :global infile: bam infile, including path <chr>
    :global outdir: outfile directory, including path <chr>
    :global outfile: bam outfile, including path <chr>
    :global flagstat: run samtools flagstat on bams <0 or 1>
    :global list_etc: run samtools flagstat on bams <0 or 1>
    :return: file outdir/outfile (samtools view)
    :return: file outdir/outfile (samtools flagstat)
    :return: file outdir/outfile (list_tally_flags)
    """
    echo ""
    echo "Running ${0}... "
    echo "Filtering out unmapped reads..."

    if [[ "${mode}" -eq 1 ]]; then
        #  Inclusion ---------------------------
        #  Including only (--rf/-F) unmapped reads (0x0004, 0x0008)
        if [[ "${unmapped}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0004 \
                --rf 0x0008 \
                -F 0x0100 \
                -b -o "${outdir}/${outfile%.bam}.in-u.bam" \
                "${infile}"
        fi

        #  Including only (--rf/-F) secondary alignments (0x0100)
        if [[ "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0100 \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.in-s.bam" \
                "${infile}"
        fi

        #  Inclusion (--rf) of 0x0100, 0x0004, and 0x0008
        if [[ "${unmapped}" -eq 1 && "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0100 \
                --rf 0x0004 \
                --rf 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.in-s-u.bam" \
                "${infile}"
        fi

        #  Exclusion ---------------------------
        #  Excluding (-F) unmapped reads (0x0004, 0x0008)
        if [[ "${unmapped}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.ex-u.bam" \
                "${infile}"
        fi

        #  Excluding (-F) secondary alignments (0x0100)
        if [[ "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0100 \
                -b -o "${outdir}/${outfile%.bam}.ex-s.bam" \
                "${infile}"
        fi

        #  Excluding (-F) 0x0100, 0x0004, and 0x0008
        if [[ "${unmapped}" -eq 1 && "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0100 \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.ex-s-u.bam" \
                "${infile}"
        fi

    elif [[ "${mode}" -eq 2 ]]; then
        #  Inclusion ---------------------------
        #  Including only (--rf/-F) unmapped reads (0x0004, 0x0008)
        if [[ "${unmapped}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0004 \
                --rf 0x0008 \
                -F 0x0100 \
                -b -o "${outdir}/${outfile%.bam}.in-u.bam" \
                "${infile}"
        fi

        #  Including only (--rf/-F) secondary alignments (0x0100)
        if [[ "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0100 \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.in-s.bam" \
                "${infile}"
        fi

        #  Including only (--rf/-F) 0x0100, 0x0004, and 0x0008
        if [[ "${unmapped}" -eq 1 && "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0100 \
                --rf 0x0004 \
                --rf 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.in-s-u.bam" \
                "${infile}"
        fi

    elif [[ "${mode}" -eq 3 ]]; then
        #  Exclusion ---------------------------
        #  Excluding (-F) unmapped reads (0x0004, 0x0008)
        if [[ "${unmapped}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.ex-u.bam" \
                "${infile}"
        fi

        #  Excluding (-F) secondary alignments (0x0100)
        if [[ "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0100 \
                -b -o "${outdir}/${outfile%.bam}.ex-s.bam" \
                "${infile}"
        fi

        #  Excluding (-F) 0x0100, 0x0004, and 0x0008
        if [[ "${unmapped}" -eq 1 && "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0100 \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.ex-s-u.bam" \
                "${infile}"
        fi
    fi

    if [[ $((flagstat)) -eq 1 ]]; then
        for i in "${outdir}/${outfile%.bam}."*".bam"; do
            samtools flagstat \
                -@ "${threads}" \
                "${i}" \
                    > "${i%.bam}.flagstat.txt"
        done
    fi

    if [[ $((list_etc)) -eq 1 ]]; then
        for i in "${outdir}/${outfile%.bam}."*".bam"; do
            list_tally_flags \
                "${i}" \
                "${i%.bam}.list-tally-flags.txt"
        done
    fi
}


#  ------------------------------------
#  Handle arguments
#  ------------------------------------
help="""
#  ------------------------------------
#  separate_split_bams.sh
#  ------------------------------------
Filter out unmapped reads from a bam infile. Optionally, run samtools flagstat
on the filtered bam outfile.

Name(s) of outfile(s) will be derived from the infile.

Dependencies:
    - samtools >= version #TBD

Arguments:
    -u  safe_mode  use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -i  infile     bam infile, including path <chr>
    -o  outdir     outfile directory, including path; if not found, will be
                   mkdir'd <chr>
    -v  unmapped   target 'unmapped' reads <lgl> [default: TRUE]
    -s  secondary  target 'secondary' alignments <lgl> [default: TRUE]
    -m  mode       run in '{in,ex}clusion' mode 1, 2, or 3 <int = 1, 2, or 3>
                   [default: 1]

                       mode 1: bam outfiles *including* and *excluding* the
                               'unmapped' reads and/or 'secondary' alignments
                               are produced
                       mode 2: only bam outfiles *including* the 'unmapped'
                               reads and/or 'secondary' alignments are produced
                               produced
                       mode 3: only bam outfiles *excluding* the 'unmapped'
                               reads and/or 'secondary' alignments are produced
                               produced

    -f  flagstat   run samtools flagstat on bam outfiles <lgl> [default: TRUE]
    -l  list_etc   run list_tally_flags() on bam outfiles <lgl> [default: TRUE]
    -t  threads    number of threads <int >= 1> [default: 1]
"""

while getopts "u:i:o:v:s:m:f:l:t:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        v) unmapped="${OPTARG}" ;;
        s) secondary="${OPTARG}" ;;
        m) mode="${OPTARG}" ;;
        f) flagstat="${OPTARG}" ;;
        l) list_etc="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage "${help}"
[[ -z "${outdir}" ]] && print_usage "${help}"
[[ -z "${unmapped}" ]] && unmapped=TRUE
[[ -z "${secondary}" ]] && secondary=TRUE
[[ -z "${mode}" ]] && mode=1
[[ -z "${flagstat}" ]] && flagstat=TRUE
[[ -z "${list_etc}" ]] && list_etc=TRUE
[[ -z "${threads}" ]] && threads=1


#  ------------------------------------
#  Check dependencies, and check and make variable assignments 
#  ------------------------------------
check_etc


#  ------------------------------------
#  Run samtools to...
#  ------------------------------------
main
```
</details>
<br />

<a id="get-situated"></a>
### Get situated
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

grabnode  # 8, etc.
transcriptome
Trinity_env
ml SAMtools/1.16.1-GCC-11.2.0

cd results/2023-0115 \
    || echo "cd'ing failed; check on this"
```
</details>
<br />

<a id="run-separate_bamsh-evaluate-the-flagstat-and-list-tally-flags-files"></a>
### Run `separate_bam.sh`; evaluate the `flagstat` and `list-tally-flags` files
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Run separate_bam.sh; evaluate the flagstat and list-tally-flags files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

bash bin/separate_bam.sh

in="test_separate-bam/5781_Q_IP_UT.bam"
out="test_separate-bam/test"
bash bin/separate_bam.sh \
    -u FALSE \
    -i "${in}" \
    -o "${out}" \
    -v TRUE \
    -s TRUE \
    -m 1 \
    -f TRUE \
    -l TRUE \
    -t "${SLURM_CPUS_ON_NODE}"

cd "${out}"

for i in *.flagstat.txt *.list-tally-flags.txt; do
	echo "${i}"
	cat "${i}"
	echo ""
done

transcriptome
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Run separate_bam.sh; evaluate the flagstat and list-tally-flags files</i></summary>

```txt
❯ grabnode
How many CPUs/cores would you like to grab on the node? [1-36] 8
How much memory (GB) would you like to grab? [160]
Please enter the max number of days you would like to grab this node: [1-7] 1
Do you need a GPU ? [y/N]N

You have requested 8 CPUs on this node/server for 1 days or until you type exit.

Warning: If you exit this shell before your jobs are finished, your jobs
on this node/server will be terminated. Please use sbatch for larger jobs.

Shared PI folders can be found in: /fh/fast, /fh/scratch and /fh/secure.

Requesting Queue: campus-new cores: 8 memory: 160 gpu: NONE
srun: job 10188359 queued and waiting for resources
srun: job 10188359 has been allocated resources


❯ bash bin/separate_bam.sh

#  ------------------------------------
#  separate_split_bams.sh
#  ------------------------------------
Filter out unmapped reads from a bam infile. Optionally, run samtools flagstat
on the filtered bam outfile.

Name(s) of outfile(s) will be derived from the infile.

Dependencies:
    - samtools >= version #TBD

Arguments:
    -u  safe_mode  use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -i  infile     bam infile, including path <chr>
    -o  outdir     outfile directory, including path; if not found, will be
                   mkdir'd <chr>
    -v  unmapped   target 'unmapped' reads <lgl> [default: TRUE]
    -s  secondary  target 'secondary' alignments <lgl> [default: TRUE]
    -m  mode       run in '{in,ex}clusion' mode 1, 2, or 3 <int = 1, 2, or 3>
                   [default: 1]

                       mode 1: bam outfiles *including* and *excluding* the
                               'unmapped' reads and/or 'secondary' alignments
                               are produced
                       mode 2: only bam outfiles *including* the 'unmapped'
                               reads and/or 'secondary' alignments are produced
                               produced
                       mode 3: only bam outfiles *excluding* the 'unmapped'
                               reads and/or 'secondary' alignments are produced
                               produced

    -f  flagstat   run samtools flagstat on bam outfiles <lgl> [default: TRUE]
    -l  list_etc   run list_tally_flags() on bam outfiles <lgl> [default: TRUE]
    -t  threads    number of threads <int >= 1> [default: 1]


❯ bash bin/separate_bam.sh \
>     -u FALSE \
>     -i "${in}" \
>     -o "${out}" \
>     -v TRUE \
>     -s TRUE \
>     -m 1 \
>     -f TRUE \
>     -l TRUE \
>     -t "${SLURM_CPUS_ON_NODE}"
"Safe mode" is FALSE.
test_separate-bam/test doesn't exist; mkdir'ing it.
"Run in 'unmapped' mode" is TRUE.
"Run in 'secondary' mode" is TRUE.
"Run in '{in,ex}clusion' mode" is set to '1'.
"Run samtools flagstat" is TRUE.
"Run list_tally_flags()" is TRUE.


Running bin/separate_bam.sh...
Filtering out unmapped reads...
/ Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.exclude-unmapped.ex-s.bam...

List and tally flags in 5781_Q_IP_UT.exclude-unmapped.ex-s.bam.
Run time: 0h:0m:7s

– Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.exclude-unmapped.ex-s-u.bam...

List and tally flags in 5781_Q_IP_UT.exclude-unmapped.ex-s-u.bam.
Run time: 0h:0m:7s

\ Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.exclude-unmapped.ex-u.bam...

List and tally flags in 5781_Q_IP_UT.exclude-unmapped.ex-u.bam.
Run time: 0h:0m:6s

– Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.exclude-unmapped.in-s.bam...

List and tally flags in 5781_Q_IP_UT.exclude-unmapped.in-s.bam.
Run time: 0h:0m:1s

| Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.exclude-unmapped.in-s-u.bam...

List and tally flags in 5781_Q_IP_UT.exclude-unmapped.in-s-u.bam.
Run time: 0h:0m:2s

\ Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.exclude-unmapped.in-u.bam...

List and tally flags in 5781_Q_IP_UT.exclude-unmapped.in-u.bam.
Run time: 0h:0m:0s


❯ cd "${out}"
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/test_separate-bam/test


❯ for i in *.flagstat.txt *.list-tally-flags.txt; do
>     echo "${i}"
>     cat "${i}"
>     echo ""
> done
❯ for i in *.flagstat.txt *.list-tally-flags.txt; do
5781_Q_IP_UT.exclude-unmapped.ex-s.flagstat.txt
4317664 + 0 in total (QC-passed reads + QC-failed reads)
4317664 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
4129819 + 0 mapped (95.65% : N/A)
4129819 + 0 primary mapped (95.65% : N/A)
4317664 + 0 paired in sequencing
2158832 + 0 read1
2158832 + 0 read2
4090422 + 0 properly paired (94.74% : N/A)
4090422 + 0 with itself and mate mapped
39397 + 0 singletons (0.91% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

5781_Q_IP_UT.exclude-unmapped.ex-s-u.flagstat.txt
4090422 + 0 in total (QC-passed reads + QC-failed reads)
4090422 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
4090422 + 0 mapped (100.00% : N/A)
4090422 + 0 primary mapped (100.00% : N/A)
4090422 + 0 paired in sequencing
2045211 + 0 read1
2045211 + 0 read2
4090422 + 0 properly paired (100.00% : N/A)
4090422 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

5781_Q_IP_UT.exclude-unmapped.ex-u.flagstat.txt
4774802 + 0 in total (QC-passed reads + QC-failed reads)
4090422 + 0 primary
684380 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
4774802 + 0 mapped (100.00% : N/A)
4090422 + 0 primary mapped (100.00% : N/A)
4090422 + 0 paired in sequencing
2045211 + 0 read1
2045211 + 0 read2
4090422 + 0 properly paired (100.00% : N/A)
4090422 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

5781_Q_IP_UT.exclude-unmapped.in-s.flagstat.txt
684380 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 primary
684380 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
684380 + 0 mapped (100.00% : N/A)
0 + 0 primary mapped (N/A : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

5781_Q_IP_UT.exclude-unmapped.in-s-u.flagstat.txt
922429 + 0 in total (QC-passed reads + QC-failed reads)
227242 + 0 primary
695187 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
734584 + 0 mapped (79.64% : N/A)
39397 + 0 primary mapped (17.34% : N/A)
227242 + 0 paired in sequencing
113621 + 0 read1
113621 + 0 read2
0 + 0 properly paired (0.00% : N/A)
0 + 0 with itself and mate mapped
39397 + 0 singletons (17.34% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

5781_Q_IP_UT.exclude-unmapped.in-u.flagstat.txt
227242 + 0 in total (QC-passed reads + QC-failed reads)
227242 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
39397 + 0 mapped (17.34% : N/A)
39397 + 0 primary mapped (17.34% : N/A)
227242 + 0 paired in sequencing
113621 + 0 read1
113621 + 0 read2
0 + 0 properly paired (0.00% : N/A)
0 + 0 with itself and mate mapped
39397 + 0 singletons (17.34% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

5781_Q_IP_UT.exclude-unmapped.ex-s.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153

5781_Q_IP_UT.exclude-unmapped.ex-s-u.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147

5781_Q_IP_UT.exclude-unmapped.ex-u.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
 289272 419
 289272 339
  52918 403
  52918 355

5781_Q_IP_UT.exclude-unmapped.in-s.list-tally-flags.txt
 289272 419
 289272 339
  52918 403
  52918 355

5781_Q_IP_UT.exclude-unmapped.in-s-u.list-tally-flags.txt
 289272 419
 289272 339
  74223 77
  74223 141
  52918 403
  52918 355
  18512 165
  18511 89
  17012 73
  17012 133
   8489 345
   1965 137
   1960 69
   1915 101
   1909 153
   1328 329
    797 393
    193 409

5781_Q_IP_UT.exclude-unmapped.in-u.list-tally-flags.txt
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153
```
</details>
<br />

<a id="examine-flags-in-some-of-the-outfiles"></a>
### Examine flags in some of the outfiles
<a id="5781_q_ip_utexclude-unmappedex-s-u"></a>
#### 5781_Q_IP_UT.exclude-unmapped.ex-s-u
<a id="code-3"></a>
##### Code
<details>
<summary><i>Code: 5781_Q_IP_UT.exclude-unmapped.ex-s-u</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

flags=(
	83
	163
	99
	147
)
for i in "${flags[@]}"; do
	echo "❯ perl bin/parse_bam-flag.pl ${i}"
	perl bin/parse_bam-flag.pl "${i}"
	echo ""
done
```
</details>
<br />

<a id="printed-1"></a>
##### Printed
<details>
<summary><i>Printed: 5781_Q_IP_UT.exclude-unmapped.ex-s-u</i></summary>

```txt
❯ for i in "${flags[@]}"; do
>     echo "❯ perl bin/parse_bam-flag.pl ${i}"
>     perl bin/parse_bam-flag.pl "${i}"
>     echo ""
> done
❯ perl bin/parse_bam-flag.pl 83
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 163
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 99
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 147
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the last segment in the template, i.e., second in pair (0x80)
```
</details>
<br />

<a id="5781_q_ip_utexclude-unmappedin-s"></a>
#### 5781_Q_IP_UT.exclude-unmapped.in-s
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: 5781_Q_IP_UT.exclude-unmapped.in-s</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

flags=(
	419
	339
	403
	355
)
echo "5781_Q_IP_UT.exclude-unmapped.in-s.list-tally-flags.txt"
for i in "${flags[@]}"; do
	echo "❯ perl bin/parse_bam-flag.pl ${i}"
	perl bin/parse_bam-flag.pl "${i}"
	echo ""
done
```
</details>
<br />

<a id="printed-2"></a>
##### Printed
<details>
<summary><i>Printed: 5781_Q_IP_UT.exclude-unmapped.in-s</i></summary>

```txt
❯ echo "5781_Q_IP_UT.exclude-unmapped.in-s.list-tally-flags.txt"
5781_Q_IP_UT.exclude-unmapped.in-s.list-tally-flags.txt


❯ for i in "${flags[@]}"; do
>     echo "❯ perl bin/parse_bam-flag.pl ${i}"
>     perl bin/parse_bam-flag.pl "${i}"
>     echo ""
> done
❯ perl bin/parse_bam-flag.pl 419
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the last segment in the template, i.e., second in pair (0x80)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 339
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the first segment in the template, i.e., first in pair (0x40)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 403
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the last segment in the template, i.e., second in pair (0x80)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 355
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the first segment in the template, i.e., first in pair (0x40)
secondary alignment, i.e., not primary alignment (0x100)
```
</details>
<br />

<a id="5781_q_ip_utexclude-unmappedin-u"></a>
#### 5781_Q_IP_UT.exclude-unmapped.in-u
<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: 5781_Q_IP_UT.exclude-unmapped.in-u</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

flags=(
	77
	141
	165
	89
	73
	133
	137
	69
	101
	153
)
for i in "${flags[@]}"; do
	echo "❯ perl bin/parse_bam-flag.pl ${i}"
	perl bin/parse_bam-flag.pl "${i}"
	echo ""
done
```
</details>
<br />

<a id="printed-3"></a>
##### Printed
<details>
<summary><i>Printed: 5781_Q_IP_UT.exclude-unmapped.in-u</i></summary>

```txt
❯ for i in "${flags[@]}"; do
>     echo "❯ perl bin/parse_bam-flag.pl ${i}"
>     perl bin/parse_bam-flag.pl "${i}"
>     echo ""
> done
❯ perl bin/parse_bam-flag.pl 77
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 141
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 165
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 89
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 73
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 133
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 137
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 69
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 101
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 153
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the last segment in the template, i.e., second in pair (0x80)
```
</details>
<br />

<a id="5781_q_ip_utexclude-unmappedin-s-u"></a>
#### 5781_Q_IP_UT.exclude-unmapped.in-s-u
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: 5781_Q_IP_UT.exclude-unmapped.in-s-u</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

flags=(
	419
	339
	77
	141
	403
	355
	165
	89
	73
	133
	345
	137
	69
	101
	153
	329
	393
	409
)
for i in "${flags[@]}"; do
	echo "❯ perl bin/parse_bam-flag.pl ${i}"
	perl bin/parse_bam-flag.pl "${i}"
	echo ""
done
```
</details>
<br />

<a id="printed-4"></a>
##### Printed
<details>
<summary><i>Printed: 5781_Q_IP_UT.exclude-unmapped.in-s-u</i></summary>

```txt
❯ for i in "${flags[@]}"; do
>     echo "❯ perl bin/parse_bam-flag.pl ${i}"
>     perl bin/parse_bam-flag.pl "${i}"
>     echo ""
> done
❯ perl bin/parse_bam-flag.pl 419
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the last segment in the template, i.e., second in pair (0x80)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 339
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the first segment in the template, i.e., first in pair (0x40)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 77
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 141
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 403
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the last segment in the template, i.e., second in pair (0x80)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 355
template having multiple segments in sequencing, i.e., read paired (0x1)
each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the first segment in the template, i.e., first in pair (0x40)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 165
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 89
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 73
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 133
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 345
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the first segment in the template, i.e., first in pair (0x40)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 137
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 69
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 101
template having multiple segments in sequencing, i.e., read paired (0x1)
segment unmapped, i.e., read unmapped (0x4)
SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
the first segment in the template, i.e., first in pair (0x40)

❯ perl bin/parse_bam-flag.pl 153
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the last segment in the template, i.e., second in pair (0x80)

❯ perl bin/parse_bam-flag.pl 329
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the first segment in the template, i.e., first in pair (0x40)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 393
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
the last segment in the template, i.e., second in pair (0x80)
secondary alignment, i.e., not primary alignment (0x100)

❯ perl bin/parse_bam-flag.pl 409
template having multiple segments in sequencing, i.e., read paired (0x1)
next segment in the template unmapped, i.e., mate unmapped (0x8)
SEQ being reverse complemented, i.e., read reverse strand (0x10)
the last segment in the template, i.e., second in pair (0x80)
secondary alignment, i.e., not primary alignment (0x100)
```
</details>
<br />

<a id="breaking-down-the-contents-of-the-ex-and-in-files"></a>
## Breaking down the contents of the '`ex`' and '`in`' files
<a id="breaking-down-the-contents-of-the-ex-files"></a>
### Breaking down the contents of the '`ex`' files
<details>
<summary><i>Notes: Breaking down the contents of the 'ex' files</i></summary>

```txt
5781_Q_IP_UT.exclude-unmapped.ex-s.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153

5781_Q_IP_UT.exclude-unmapped.ex-s-u.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147

5781_Q_IP_UT.exclude-unmapped.ex-u.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
 289272 419
 289272 339
  52918 403
  52918 355
```

- `5781_Q_IP_UT.exclude-unmapped.ex-s`
	+ Composition: Combination of "proper" primary alignments and combinations of singletons and unmapped reads
		* Properly paired alignments (`83` `163` `99` `147`) <b><i>AND</i></b>
		* Unmapped reads (`77` `141` `165` `89` `73` `133` `137` `69` `101` `153`)
	+ Breakdown
		* <b><i>Properly paired</i></b> alignments
			- Paired, oriented, stranded, ordered&mdash;i.e., "proper"
				+ `83`: `0x1` `0x2` `0x10` `0x40`
					* read paired (`0x1`)
					* read mapped in proper pair (`0x2`)
					* read reverse strand (`0x10`)
					* first in pair (`0x40`)
				+ `163`: `0x1` `0x2` `0x20` `0x80`
					* read paired (`0x1`)
					* read mapped in proper pair (`0x2`)
					* mate reverse strand (`0x20`)
					* second in pair (`0x80`)
				+ `99`: `0x1` `0x2` `0x20` `0x40`
					* read paired (`0x1`)
					* read mapped in proper pair (`0x2`)
					* mate reverse strand (`0x20`)
					* first in pair (`0x40`)
				+ `147`: `0x1` `0x2` `0x10` `0x80`
					* read paired (`0x1`)
					* read mapped in proper pair (`0x2`)
					* read reverse strand (`0x10`)
					* second in pair (`0x80`)
		* <b><i>Unmapped</i></b> reads
			- Paired, both reads unmapped and unoriented, but still stranded and ordered
				+ `77`: `0x1` `0x4` `0x8` `0x40`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* mate unmapped (`0x8`)
					* first in pair (`0x40`)
				+ `141`: `0x1` `0x4` `0x8` `0x80`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* mate unmapped (`0x8`)
					* second in pair (`0x80`)
			- Paired, one read mapped, one read unmapped (∴ a singleton and its mate)&mdash;both stranded and ordered
				+ `165`: `0x1` `0x4` `0x20` `0x80`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* mate reverse strand (`0x20`)
					* second in pair (`0x80`)
				+ `89`: `0x1` `0x8` `0x10` `0x40`
					* read paired (`0x1`)
					* mate unmapped (`0x8`)
					* read reverse strand (`0x10`)
					* first in pair (`0x40`)
			- Paired, both reads unmapped, unoriented, and unstranded, but still ordered
				+ `73`: `0x1` `0x8` `0x40`
					* read paired (`0x1`)
					* mate unmapped (`0x8`)
					* first in pair (`0x40`)
				+ `133`: `0x1` `0x4` `0x80`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* second in pair (`0x80`)
				+ `137`: `0x1` `0x8` `0x80`
					* read paired (`0x1`)
					* mate unmapped (`0x8`)
					* second in pair (`0x80`)
				+ `69`: `0x1` `0x4` `0x40`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* first in pair (`0x40`)
			- Paired, both reads unmapped and unoriented, but stranded <u>with pairs on the same strand</u>; also, ordered
				+ `101`: `0x1` `0x4` `0x20` `0x40`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* mate reverse strand (`0x20`)
					* first in pair (`0x40`)
				+ `153`: `0x1` `0x8` `0x10` `0x80`
					* read paired (`0x1`)
					* mate unmapped (`0x8`)
					* read reverse strand (`0x10`)
					* second in pair (`0x80`)
	+ `#REMINDER` What is what in terms of flags
		* ` 0x1`: read paired (`0x1`)
		* ` 0x2`: read mapped in proper pair (`0x2`)
		* ` 0x4`: read unmapped (`0x4`)
		* ` 0x8`: mate unmapped (`0x8`)
		* `0x10`: read reverse strand (`0x10`)
		* `0x20`: mate reverse strand (`0x20`)
		* `0x40`: first in pair (`0x40`)
		* `0x80`: second in pair (`0x80`)
	+ What I would want to use this file for...
		* Seems like nothing if I want to move forward with UMI deduplication
			- That is, need to split off `83`, `163`, `99`, `147`
		* However, if I decide I don't want to do UMI deduplication, then this file&mdash;which contains no multimappers&mdash;could undergo `bam`-to-`fastq` conversion; then, the resulting `fastq`s could be used as input for `Trinity` genome-free mode
		* `#DECISION` <mark>For now, <u><b>do not</b></u> output this file</mark>
- `5781_Q_IP_UT.exclude-unmapped.ex-s-u`
	+ This file is composed solely of alignments with flags `83`, `163`, `99`, and `147`
	+ If UMI deduplication does not work with a combination of primary and secondary alignments (alignments in the below file), then this will become the file to use as input for `umi_tools dedup`
	+ ~~Otherwise, I am not sure if we need this or not~~ We may want to keep and process this file for use in the 4tU-/RNA-seq analyses
	+ `#DECISION` <mark>For now, <u><b>do</b></u> output this file</mark>
- `5781_Q_IP_UT.exclude-unmapped.ex-u`
	+ This file is composed of alignments with flags `83`, `163`, `99`, `147`, `419`, `339`, `403`, `355`
	+ This is what we want to try as input to `umi_tools dedup`
		* If `umi_tools dedup` does not handle the multimappers appropriately, then we'll need to have the "four- and three-hundred" alignments (`419`, `339`, `403`, and `355`) separated out to be added back in to the post-UMI-deduplicated bam (composed of `83`, `163`, `99`, and `147` alignments) prior to running Trinity genome-guided mode
		* No need to do any processing to separate the "four- and three-hundred" alignments out&mdash;the above files is composed solely of `83`, `163`, `99`, `147`, so would want to use that...
	+ `#DECISION` <mark>Output this file</mark>
</details>
<br />

<a id="breaking-down-the-contents-of-the-in-files"></a>
### Breaking down the contents of the '`in`' files
<details>
<summary><i>Notes: Breaking down the contents of the 'in' files</i></summary>

(Got some weird naming going on, e.g., "`exclude-unmapped.in-s`" `#TODO` Fix this)
```txt
5781_Q_IP_UT.exclude-unmapped.in-s.list-tally-flags.txt
 289272 419
 289272 339
  52918 403
  52918 355

5781_Q_IP_UT.exclude-unmapped.in-s-u.list-tally-flags.txt
 289272 419
 289272 339
  74223 77
  74223 141
  52918 403
  52918 355
  18512 165
  18511 89
  17012 73
  17012 133
   8489 345
   1965 137
   1960 69
   1915 101
   1909 153
   1328 329
    797 393
    193 409

5781_Q_IP_UT.exclude-unmapped.in-u.list-tally-flags.txt
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153
```

- `5781_Q_IP_UT.exclude-unmapped.in-s`
	+ Composed only of proper secondary alignments (`419`, `339`, `403`, and `355`)
	+ `#DECISION` <mark>Output this for now; if it turns out that `umi_tools dedup` handles the multimappers properly, then stop outputting it</mark>
- `5781_Q_IP_UT.exclude-unmapped.in-s-u`
	+ Composed of a mix of proper and improper primary and secondary alignments, along with proper and improper singletons
	+ `#NOTE #IMPORTANT` <mark>*Not so* good for&mdash;if necessary&mdash;adding back to UMI-deduplicated bam for <b>Trinity genome-guided work</b></mark>; additional processing would be required to exclude `329` `393` `345` `409`
	+ `#DECISION` <mark><u><b>Do not</b></u> output this</mark>
	+ Breakdown
		* Secondary alignments: Everything proper
			- `419`
				+ read paired (`0x1`)
				+ read mapped in proper pair (`0x2`)
				+ mate reverse strand (`0x20`)
				+ second in pair (`0x80`)
				+ not primary alignment (`0x100`)
			- `339`
				+ read paired (`0x1`)
				+ read mapped in proper pair (`0x2`)
				+ read reverse strand (`0x10`)
				+ first in pair (`0x40`)
				+ not primary alignment (`0x100`)
			- `403`
				+ read paired (`0x1`)
				+ read mapped in proper pair (`0x2`)
				+ read reverse strand (`0x10`)
				+ second in pair (`0x80`)
				+ not primary alignment (`0x100`)
			- `355`
				+ read paired (`0x1`)
				+ read mapped in proper pair (`0x2`)
				+ mate reverse strand (`0x20`)
				+ first in pair (`0x40`)
				+ not primary alignment (`0x100`)
		* Unmapped reads
			- Paired, both reads unmapped but strand is <b><i>not</i></b> determined: <b><i>Use with Trinity GF</i></b>
				+ `77`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* mate unmapped (`0x8`)
					* first in pair (`0x40`)
				+ `141`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* mate unmapped (`0x8`)
					* second in pair (`0x80`)
			- Paired, one read unmapped (a singleton with an unmapped mate), strand is determined: <b><i>Use with Trinity GF</i></b>
				+ `165`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* mate reverse strand (`0x20`)
					* second in pair (`0x80`)
				+ `89`
					* read paired (`0x1`)
					* mate unmapped (`0x8`)
					* read reverse strand (`0x10`)
					* first in pair (`0x40`)
			- Paired, both reads unmapped: <b><i>Use with Trinity GF</i></b>
				+ `73`
					* read paired (`0x1`)
					* mate unmapped (`0x8`)
					* first in pair (`0x40`)
				+ `133`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* second in pair (`0x80`)
				+ `137`
					* read paired (`0x1`)
					* mate unmapped (`0x8`)
					* second in pair (`0x80`)
				+ `69`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* first in pair (`0x40`)
			- Paired, both reads unmapped, stranded but pairs on the same strand: <b><i>Use with Trinity GF</i></b>
				+ `101`
					* read paired (`0x1`)
					* read unmapped (`0x4`)
					* mate reverse strand (`0x20`)
					* first in pair (`0x40`)
				+ `153`
					* read paired (`0x1`)
					* mate unmapped (`0x8`)
					* read reverse strand (`0x10`)
					* second in pair (`0x80`)
			- Improper secondary alignments
				+ Secondary alignment with one read unmapped&mdash;i.e., a secondary singleton with unmapped mate&mdash;and the strand is <b><i>not</i></b> determined: <b><i>Don't use with Trinity GF</i></b>
					* `329`
						- read paired (`0x1`)
						- mate unmapped (`0x8`)
						- first in pair (`0x40`)
						- not primary alignment (`0x100`)
					* `393`
						- read paired (`0x1`)
						- mate unmapped (`0x8`)
						- second in pair (`0x80`)
						- not primary alignment (`0x100`)
				+ Secondary alignment with one read unmapped (again, a secondary singleton and unmapped mate); both are stranded, but the alignment and unmapped read are on the same strand: <b><i>Don't use with Trinity GF</i></b>
					* `345`
						- read paired (`0x1`)
						- mate unmapped (`0x8`)
						- read reverse strand (`0x10`)
						- first in pair (`0x40`)
						- not primary alignment (`0x100`)
					* `409`
						- read paired (`0x1`)
						- mate unmapped (`0x8`)
						- read reverse strand (`0x10`)
						- second in pair (`0x80`)
						- not primary alignment (`0x100`)
- `5781_Q_IP_UT.exclude-unmapped.in-u`
	+ Composed of only "proper" unmapped reads and singletons
	+ `77`, `141` `165`, `89`, `73`, `133`, `137`, `69`, `101`, `153`
	+ `#NOTE #IMPORTANT` <mark>Good for bam-to-fastq conversion for <b>Trinity genome-free work</b></mark>
	+ `#DECISION` <mark>Output this</mark>
</details>
<br />
<br />

<a id="summarize-decisions"></a>
## Summarize decisions
<details>
<summary><i>Notes: Summarize decisions</i></summary>

- *ex*
	+ `5781_Q_IP_UT.exclude-unmapped.ex-s`
		* `#DECISION` <mark>For now, <u><b>do not</b></u> output this file</mark>
		* Composition: Combination of "proper" primary alignments and combinations of singletons and unmapped reads
			- Properly paired alignments: `83` `163` `99` `147`
			- Unmapped reads: `77` `141` `165` `89` `73` `133` `137` `69` `101` `153`
		* <mark>New extension: `.proper.prim-sng-unmap`</mark>
	+ `5781_Q_IP_UT.exclude-unmapped.ex-s-u`
		* `#DECISION` <mark>For now, <u><b>do</b></u> output this file</mark>
		* This file is composed solely of alignments with flags `83`, `163`, `99`, and `147`
		* If UMI deduplication does not work with a combination of primary and secondary alignments, then this will become the file to use as input for umi_tools dedup
		* We may want to keep and process this file for use in the 4tU-/RNA-seq analyses
		* <mark>New extension: `.proper.prim`</mark>
	+ `5781_Q_IP_UT.exclude-unmapped.ex-u`
		* `#DECISION` <mark><u><b>Do</b></u> output this file</mark>
		* This file is composed of alignments with flags `83`, `163`, `99`, `147`, `419`, `339`, `403`, `355`
		* This is what we want to try as input to umi_tools dedup
		* <mark>New extension: `.proper.prim-sec`</mark>
- *in*
	+ `5781_Q_IP_UT.exclude-unmapped.in-s`
		* `#DECISION` <mark><u><b>Do</b></u> output this for now; if it turns out that `umi_tools dedup` handles the multimappers properly, then stop outputting it</mark>
		* Composed only of proper secondary alignments (`419`, `339`, `403`, and `355`)
		* <mark>New extension: `proper.sec`</mark>
	+ `5781_Q_IP_UT.exclude-unmapped.in-s-u`
		* `#DECISION` <mark><u><b>Do not</b></u> output this</mark>
		* Composed of a mix of proper and improper primary and secondary alignments, along with proper and improper singletons
		* `#NOTE #IMPORTANT` <mark>*Not so* good for&mdash;if necessary&mdash;adding back to UMI-deduplicated bam for <b>Trinity genome-guided work</b></mark>; additional processing would be required to exclude `329` `393` `345` `409`
		* <mark>New extension: `proper-improper.prim-sng-unmap`</mark>
	+ `5781_Q_IP_UT.exclude-unmapped.in-u`
		* `#DECISION` <mark>Output this</mark>
		* Composed of only "proper" unmapped reads and singletons: `77`, `141` `165`, `89`, `73`, `133`, `137`, `69`, `101`, `153`
		* <mark>New extension: `proper.unmap`</mark>
</details>
<br />
<br />

<a id="update-separate_bamsh-to-reflect-the-above"></a>
## Update `separate_bam.sh` to reflect the above
<a id="tasks"></a>
### Tasks
- Update `separate_bam.sh` for better outfile names and a better way to specify wanted outfiles
	+ `.ex-s` to `.proper.prim-sng-unmap` *Done. More or less.*
	+ `.ex-s-u` to `.proper.prim` *Done. More or less.*
	+ `.ex-u` to `.proper.prim-sec` *Done. More or less.*
	+ `.in-s` to `.proper.sec` *Done. More or less.*
	+ `.in-s-u` to `.proper-improper.prim-sng-unmap`
	+ `.in-u` to `.proper.unmap` *Done. More or less.*
	+ ~~Get rid of~~Change `"${unmapped}"` *Done.*
	+ ~~Get rid of~~Change `"${secondary}"` *Done.*
	+ Get rid of `"${mode}"` *Done.*

<a id="test-the-updated-script"></a>
### Test the updated script
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Test the updated script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

bash bin/separate_bam.sh

#  Test 2
in="test_separate-bam/5781_Q_IP_UT.bam"
out="test_separate-bam/separate-bam_v2"
bash bin/separate_bam.sh \
    -u FALSE \
    -i "${in}" \
    -o "${out}" \
    -1 TRUE \
    -2 TRUE \
    -3 TRUE \
    -4 TRUE \
    -5 FALSE \
    -6 FALSE \
    -f TRUE \
    -l TRUE \
    -t "${SLURM_CPUS_ON_NODE}"

for i in \
	"${out}/"*.flagstat.txt \
	"${out}/"*.list-tally-flags.txt
do
    echo "${i}"
    cat "${i}"
    echo ""
done


#  Test 3
in="test_separate-bam/5781_Q_IP_UT.bam"
out="test_separate-bam/separate-bam_v3"
bash bin/separate_bam.sh \
    -u FALSE \
    -i "${in}" \
    -o "${out}" \
    -1 FALSE \
    -2 FALSE \
    -3 FALSE \
    -4 FALSE \
    -5 TRUE \
    -6 TRUE \
    -f TRUE \
    -l TRUE \
    -t "${SLURM_CPUS_ON_NODE}"

for i in \
	"${out}/"*.flagstat.txt \
	"${out}/"*.list-tally-flags.txt
do
    echo "${i}"
    cat "${i}"
    echo ""
done
```
</details>
<br />

<a id="printed-5"></a>
#### Printed
<details>
<summary><i>Printed: Test the updated script</i></summary>

```txt
❯ bash bin/separate_bam.sh

#  ------------------------------------
#  separate_split_bams.sh
#  ------------------------------------
Filter out unmapped reads from a bam infile. Optionally, run samtools flagstat
on the filtered bam outfile.

Name(s) of outfile(s) will be derived from the infile.

Dependencies:
    - samtools >= version #TBD

Arguments:
    -u  safe_mode   use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -i  infile      bam infile, including path <chr>
    -o  outdir      outfile directory, including path; if not found, will be
                    mkdir'd <chr>
    -1  primary     output bam composed of 'proper' primary alignments <lgl>
                    [default: TRUE]
    -2  secondary   output bam composed of 'proper' secondary alignments <lgl>
                    [default: TRUE]
    -3  prim_sec    output bam composed of 'proper' primary and secondary
                    alignments <lgl> [default: TRUE]
    -4  unmapped    output bam composed of 'proper' unmapped reads <lgl>
                    [default: TRUE]
    -5  proper_etc  output bam composed of 'proper' primary alignments and
                    singletons, and 'proper' unmapped reads <lgl>
                    [default: FALSE]
    -6  improp_etc  output bam composed of 'proper' and 'improper' primary
                    and secondary alignments, and unmapped reads <lgl>
                    [default: FALSE]
    -f  flagstat    run samtools flagstat on bam outfiles <lgl> [default: TRUE]
    -l  list_tally  run list and tally flags in bam outfiles <lgl>
                    [default: TRUE]
    -t  threads     number of threads <int >= 1> [default: 1]


❯ # Test 2
❯ bash bin/separate_bam.sh \
>     -u FALSE \
>     -i "${in}" \
>     -o "${out}" \
>     -1 TRUE \
>     -2 TRUE \
>     -3 TRUE \
>     -4 TRUE \
>     -5 FALSE \
>     -6 FALSE \
>     -f TRUE \
>     -l TRUE \
>     -t "${SLURM_CPUS_ON_NODE}"
"Safe mode" is FALSE.
test_separate-bam/separate-bam_v2 doesn't exist; mkdir'ing it.
"Output bam composed of 'proper' primary alignments" is TRUE.
"Output bam composed of 'proper' secondary primary alignments" is TRUE.
"Output bam composed of 'proper' primary and secondary alignments" is TRUE.
"Output bam composed of 'proper' unmapped reads" is TRUE.
"Output bam composed of 'proper' primary alignments and singletons, and 'proper' unmapped reads" is FALSE.
"Output bam composed of 'proper' and 'improper' primary and secondary alignments, and unmapped reads" is FALSE.
"Run samtools flagstat" is TRUE.
"Run list_tally_flags()" is TRUE.


Running bin/separate_bam.sh...
Filtering out unmapped reads...
\ Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.primary.bam...

List and tally flags in 5781_Q_IP_UT.primary.bam.
Run time: 0h:0m:6s

| Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.primary-secondary.bam...

List and tally flags in 5781_Q_IP_UT.primary-secondary.bam.
Run time: 0h:0m:7s

– Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.secondary.bam...

List and tally flags in 5781_Q_IP_UT.secondary.bam.
Run time: 0h:0m:2s

\ Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.unmapped.bam...

List and tally flags in 5781_Q_IP_UT.unmapped.bam.
Run time: 0h:0m:0s


❯ for i in \
>     "${out}/"*.flagstat.txt \
>     "${out}/"*.list-tally-flags.txt
> do
>     echo "${i}"
>     cat "${i}"
>     echo ""
> done
test_separate-bam/separate-bam_v2/5781_Q_IP_UT.primary.flagstat.txt
4090422 + 0 in total (QC-passed reads + QC-failed reads)
4090422 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
4090422 + 0 mapped (100.00% : N/A)
4090422 + 0 primary mapped (100.00% : N/A)
4090422 + 0 paired in sequencing
2045211 + 0 read1
2045211 + 0 read2
4090422 + 0 properly paired (100.00% : N/A)
4090422 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

test_separate-bam/separate-bam_v2/5781_Q_IP_UT.primary-secondary.flagstat.txt
4774802 + 0 in total (QC-passed reads + QC-failed reads)
4090422 + 0 primary
684380 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
4774802 + 0 mapped (100.00% : N/A)
4090422 + 0 primary mapped (100.00% : N/A)
4090422 + 0 paired in sequencing
2045211 + 0 read1
2045211 + 0 read2
4090422 + 0 properly paired (100.00% : N/A)
4090422 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

test_separate-bam/separate-bam_v2/5781_Q_IP_UT.secondary.flagstat.txt
684380 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 primary
684380 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
684380 + 0 mapped (100.00% : N/A)
0 + 0 primary mapped (N/A : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

test_separate-bam/separate-bam_v2/5781_Q_IP_UT.unmapped.flagstat.txt
227242 + 0 in total (QC-passed reads + QC-failed reads)
227242 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
39397 + 0 mapped (17.34% : N/A)
39397 + 0 primary mapped (17.34% : N/A)
227242 + 0 paired in sequencing
113621 + 0 read1
113621 + 0 read2
0 + 0 properly paired (0.00% : N/A)
0 + 0 with itself and mate mapped
39397 + 0 singletons (17.34% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

test_separate-bam/separate-bam_v2/5781_Q_IP_UT.primary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147

test_separate-bam/separate-bam_v2/5781_Q_IP_UT.primary-secondary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
 289272 419
 289272 339
  52918 403
  52918 355

test_separate-bam/separate-bam_v2/5781_Q_IP_UT.secondary.list-tally-flags.txt
 289272 419
 289272 339
  52918 403
  52918 355

test_separate-bam/separate-bam_v2/5781_Q_IP_UT.unmapped.list-tally-flags.txt
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153


❯ bash bin/separate_bam.sh \
>     -u FALSE \
>     -i "${in}" \
>     -o "${out}" \
>     -1 FALSE \
>     -2 FALSE \
>     -3 FALSE \
>     -4 FALSE \
>     -5 TRUE \
>     -6 TRUE \
>     -f TRUE \
>     -l TRUE \
>     -t "${SLURM_CPUS_ON_NODE}"
"Safe mode" is FALSE.
test_separate-bam/separate-bam_v3 doesn't exist; mkdir'ing it.
"Output bam composed of 'proper' primary alignments" is FALSE.
"Output bam composed of 'proper' secondary primary alignments" is FALSE.
"Output bam composed of 'proper' primary and secondary alignments" is FALSE.
"Output bam composed of 'proper' unmapped reads" is FALSE.
"Output bam composed of 'proper' primary alignments and singletons, and 'proper' unmapped reads" is TRUE.
"Output bam composed of 'proper' and 'improper' primary and secondary alignments, and unmapped reads" is TRUE.
"Run samtools flagstat" is TRUE.
"Run list_tally_flags()" is TRUE.


Running bin/separate_bam.sh...
Filtering out unmapped reads...


\ Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.proper-etc.bam...

List and tally flags in 5781_Q_IP_UT.proper-etc.bam.
Run time: 0h:0m:6s

| Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on 5781_Q_IP_UT.proper-improper-etc.bam...

List and tally flags in 5781_Q_IP_UT.proper-improper-etc.bam.
Run time: 0h:0m:1s


❯ # Test 3
❯ for i in \
>     "${out}/"*.flagstat.txt \
>     "${out}/"*.list-tally-flags.txt
> do
>     echo "${i}"
>     cat "${i}"
>     echo ""
> done
test_separate-bam/separate-bam_v3/5781_Q_IP_UT.proper-etc.flagstat.txt
4317664 + 0 in total (QC-passed reads + QC-failed reads)
4317664 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
4129819 + 0 mapped (95.65% : N/A)
4129819 + 0 primary mapped (95.65% : N/A)
4317664 + 0 paired in sequencing
2158832 + 0 read1
2158832 + 0 read2
4090422 + 0 properly paired (94.74% : N/A)
4090422 + 0 with itself and mate mapped
39397 + 0 singletons (0.91% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

test_separate-bam/separate-bam_v3/5781_Q_IP_UT.proper-improper-etc.flagstat.txt
922429 + 0 in total (QC-passed reads + QC-failed reads)
227242 + 0 primary
695187 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
734584 + 0 mapped (79.64% : N/A)
39397 + 0 primary mapped (17.34% : N/A)
227242 + 0 paired in sequencing
113621 + 0 read1
113621 + 0 read2
0 + 0 properly paired (0.00% : N/A)
0 + 0 with itself and mate mapped
39397 + 0 singletons (17.34% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

test_separate-bam/separate-bam_v3/5781_Q_IP_UT.proper-etc.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153

test_separate-bam/separate-bam_v3/5781_Q_IP_UT.proper-improper-etc.list-tally-flags.txt
 289272 419
 289272 339
  74223 77
  74223 141
  52918 403
  52918 355
  18512 165
  18511 89
  17012 73
  17012 133
   8489 345
   1965 137
   1960 69
   1915 101
   1909 153
   1328 329
    797 393
    193 409
```
</details>
<br />

<a id="observations-nextsteps"></a>
## Observations, `#NEXTSTEP`s
- It fucking works! There's a bit of clean-up to do, but it works!  
- Need better names for `.proper-etc.` and `.proper-improper-etc.`: Maybe `.primary-unmapped.` and `.secondary-unmapped.`, respectively; also, want to add GNU parallel as a dependent and have it regulate list_tally_flags (also, need to remove the spinning icon, etc. from that function)
- `#TODO #TOMORROW` Move forward with the above edits to `separate_bam.sh`, perform `umi_tools dedup` experiments (determine if `.primary-secondary.` is properly handled; if not, then move forward with `.primary.` and determine the logic/steps for getting `.secondary.` back into the bam prior to running Trinity in genome-guided mode), and work out the logic for, ultimately, what files need to undergo what to be adequate input for (a) 4tU-/RNA-seq analyses, (b) running Trinity in genome-free mode, and (c) running Trinity in genome-guided mode
<br />
<br />

<a id="update-separate_bamsh"></a>
## Update `separate_bam.sh`
<a id="contents-of-separate_bamsh-prior-to-additional-updates"></a>
### Contents of `separate_bam.sh` prior to additional updates
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Contents of separate_bam.sh prior to additional updates</i></summary>

```bash
#!/bin/bash

#  separate_split_bam.sh
#  KA


check_dependency() {
    what="""
    check_dependency()
    ------------------
    Check if program is available in \"\${PATH}\"; exit if not
    
    :param 1: program to be checked <chr>
    :return: NA
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    else
        command -v "${1}" &>/dev/null ||
            {
                printf "%s\n" "Exiting: \"${1}\" not found in \"\${PATH}\"."
                printf "%s\n\n" "         Check your env or install \"${1}\"?"
                # exit 1
            }
    fi
}


check_argument_safe_mode() {
    what="""
    check_argument_safe_mode()
    --------------------------
    Run script in \"safe mode\" (\`set -Eeuxo pipefail\`) if specified

    #TODO Check that param is not empty or inappropriate format/string

    :param 1: run script in safe mode: TRUE or FALSE <lgl> [default: FALSE]
    :return: NA    
    """
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            printf "%s\n" "-u: \"Safe mode\" is TRUE."
            set -Eeuxo pipefail
            ;;
        false | f | 0) \
            printf "%s\n" "\"Safe mode\" is FALSE." ;;
        *) \
            printf "%s\n" "Exiting: \"Safe mode\" must be TRUE or FALSE."
            # exit 1
            ;;
    esac
}


check_exists_file() {
    what="""
    check_exists_file()
    -------------------
    Check that a file exists; exit if it doesn't
    
    #TODO Check that param is not an inappropriate format/string

    :param 1: file, including path <chr>
    :return: NA
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    elif [[ ! -f "${1}" ]]; then
        printf "%s\n\n" "Exiting: File \"${1}\" does not exist."
        # exit 1
    else
        :
    fi
}


check_exists_directory() {
    what="""
    check_exists_directory()
    ------------------------
    Check that a directory exists; if it doesn't, then either make it or exit

    #TODO Check that params are not empty or inappropriate formats/strings

    :param 1: create directory if not found: TRUE or FALSE <lgl>
    :param 2: directory, including path <chr>
    :return: NA    
    """
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "${2} doesn't exist; mkdir'ing it."
                    mkdir -p "${2}"
                }
            ;;
        false | f | 0) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "Exiting: ${2} does not exist."
                    exit 1
                }
            ;;
        *) \
            printf "%s\n" "Exiting: param 1 is not TRUE or FALSE."
            printf "%s\n" "${what}"
            exit 1
            ;;
    esac
}


check_argument_primary() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            primary=1
            printf "%s\n" "\"Output bam composed of 'proper' primary alignments\" is TRUE."
            ;;
        false | f | 0) \
            primary=0
            printf "%s\n" "\"Output bam composed of 'proper' primary alignments\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"primary\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_secondary() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            secondary=1
            printf "%s\n" "\"Output bam composed of 'proper' secondary primary alignments\" is TRUE."
            ;;
        false | f | 0) \
            secondary=0
            printf "%s\n" "\"Output bam composed of 'proper' secondary primary alignments\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"secondary\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_prim_sec() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            prim_sec=1
            printf "%s\n" "\"Output bam composed of 'proper' primary and secondary alignments\" is TRUE."
            ;;
        false | f | 0) \
            prim_sec=0
            printf "%s\n" "\"Output bam composed of 'proper' primary and secondary alignments\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"prim_sec\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_unmapped() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            unmapped=1
            printf "%s\n" "\"Output bam composed of 'proper' unmapped reads\" is TRUE."
            ;;
        false | f | 0) \
            unmapped=0
            printf "%s\n" "\"Output bam composed of 'proper' unmapped reads\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"unmapped\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_proper_etc() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            proper_etc=1
            printf "%s\n" "\"Output bam composed of 'proper' primary alignments and singletons, and 'proper' unmapped reads\" is TRUE."
            ;;
        false | f | 0) \
            proper_etc=0
            printf "%s\n" "\"Output bam composed of 'proper' primary alignments and singletons, and 'proper' unmapped reads\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"proper_etc\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_improp_etc() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            improp_etc=1
            printf "%s\n" "\"Output bam composed of 'proper' and 'improper' primary and secondary alignments, and unmapped reads\" is TRUE."
            ;;
        false | f | 0) \
            improp_etc=0
            printf "%s\n" "\"Output bam composed of 'proper' and 'improper' primary and secondary alignments, and unmapped reads\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"improp_etc\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_flagstat() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            flagstat=1
            printf "%s\n" "\"Run samtools flagstat\" is TRUE."
            ;;
        false | f | 0) \
            flagstat=0
            printf "%s\n" "\"Run samtools flagstat\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"flagstat\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


calculate_run_time() {
    what="""
    calculate_run_time()
    --------------------
    Calculate run time for chunk of code
    
    #TODO Check that params are not empty or inappropriate formats or strings

    :param 1: start time in \$(date +%s) format
    :param 2: end time in \$(date +%s) format
    :param 3: message to be displayed when printing the run time <chr>
    :return: message <chr>
    """
    local run_time
    
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
        $(( run_time/3600 )) \
        $(( run_time%3600/60 )) \
        $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    what="""
    display_spinning_icon()
    -----------------------
    Display \"spinning icon\" while a background process runs
    
    #TODO Checks...
    
    :param 1: PID of the last program the shell ran in the background <int>
    :param 2: message to be displayed next to the spinning icon <chr>
    :return: spinning icon <chr>
    """
    local spin
    local i
    
    spin="/|\\–"
    i=0
    
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    what="""
    list_tally_flags()
    ------------------
    List and tally flags in a bam infile; function acts on a bam infile to
    perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    list and tally flags; function writes the results to a txt outfile, the
    name of which is derived from the txt infile

    #TODO Checks...

    :param 1: name of bam infile, including path <chr>
    :param 2: name of txt outfile, including path <chr>
    :return: file \"\${2}\"
    """
    local start
    local end

    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
            > "${2}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


check_argument_list_tally() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            list_tally=1
            printf "%s\n" "\"Run list_tally_flags()\" is TRUE."
            ;;
        false | f | 0) \
            list_tally=0
            printf "%s\n" "\"Run list_tally_flags()\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"list_tally\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_threads() {
    what="""
    check_argument_threads()
    ---------------
    Check the value assigned to variable for threads/cores in script

    :param 1: value assigned to variable for threads/cores <int >= 1>
    :return: NA

    #TODO Checks...
    """
    case "${1}" in
        '' | *[!0-9]*) \
            printf "%s\n" "Exiting: argument must be an integer >= 1."
            # exit 1
            ;;
        *) : ;;
    esac
}


convert_chr_lower() {
    what="""
    convert_chr_lower()
    -------------------
    Convert alphabetical characters in a string to lowercase letters
    
    :param 1: string <chr>
    :return: converted string (stdout) <chr>
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    else
        string_in="${1}"
        string_out="$(printf %s "${string_in}" | tr '[:upper:]' '[:lower:]')"

        echo "${string_out}"
    fi
}


print_usage() {
    what="""
    print_usage()
    -------------
    Print the script's help message and exit

    #TODO Checks...

    :param 1: help message assigned to a variable within script <chr>
    :return: help message (stdout) <chr>
    """
    echo "${1}"
    exit 1
}


check_etc() {
    what="""
    check_etc()
    -----------
    Check dependencies, and check and make variable assignments 

    #TODO Checks, etc., and a means to print the contents of variable what

    :global safe_mode:
    :global infile:
    :global outdir:
    :global primary:
    :global secondary:
    :global prim_sec:
    :global unmapped:
    :global proper_etc:
    :global improp_etc:
    :global threads:
    :global flagstat:
    :return global base:
    :return global outfile:
    """
    #  Check for necessary dependencies; exit if not found
    check_dependency samtools

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode "${safe_mode}"

    #  Check that "${infile}" exists
    check_exists_file "${infile}"

    #  If TRUE, then make "${outdir}" if it does not exist; if FALSE (i.e.,
    #+ "${outdir}" does not exist), then exit
    check_exists_directory TRUE "${outdir}"

    check_argument_primary "${primary}"

    check_argument_secondary "${secondary}"

    check_argument_prim_sec "${prim_sec}"

    check_argument_unmapped "${unmapped}"

    check_argument_proper_etc "${proper_etc}"

    check_argument_improp_etc "${improp_etc}"
    
    #  Check on value assigned to "${flagstat}"
    check_argument_flagstat "${flagstat}"

    #TODO
    check_argument_list_tally "${list_tally}"
    
    #  Check on value assigned to "${threads}"
    check_argument_threads "${threads}"

    #TODO Not sure if I want these assignments in this function...
    #  Make additional variable assignments from the arguments
    outfile="$(basename "${infile}")"

    echo ""
}


main() {
    what="""
    main()
    ------
    Run samtools view to exclude unmapped reads from bam infile; optionally,
    run samtools flagstat on primary alignment-filtered bam outfile

    #TODO Checks, etc., and a means to print the contents of variable what
    
    :global threads: number of threads <int >= 1>
    :global infile: bam infile, including path <chr>
    :global outdir: outfile directory, including path <chr>
    :global outfile: bam outfile <chr>
    :global primary: output bam composed of 'proper' primary alignments <lgl>
    :global secondary: output bam composed of 'proper' secondary alignments <lgl>
    :global prim_sec: output bam composed of 'proper' primary and secondary alignments <lgl>
    :global unmapped: output bam composed of 'proper' unmapped reads <lgl>
    :global proper_etc: output bam composed of 'proper' primary alignments and singletons, and 'proper' unmapped reads <lgl>
    :global improp_etc: output bam composed of 'proper' and 'improper' primary and secondary alignments, and unmapped reads <lgl>
    :global flagstat: run samtools flagstat on bams <0 or 1>
    :global list_tally: run samtools flagstat on bams <0 or 1>
    :return: file(s) outdir/outfile (samtools view)
    :return: file(s) outdir/outfile (samtools flagstat)
    :return: file(s) outdir/outfile (list_tally_flags)
    """
    echo ""
    echo "Running ${0}... "
    echo "Filtering out unmapped reads..."

    #  Bam composed of "proper" primary alignments
    if [[ "${primary}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            -F 0x0100 \
            -F 0x0004 \
            -F 0x0008 \
            -b -o "${outdir}/${outfile%.bam}.primary.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" secondary alignments
    if [[ "${secondary}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            --rf 0x0100 \
            -F 0x0004 \
            -F 0x0008 \
            -b -o "${outdir}/${outfile%.bam}.secondary.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" primary and secondary alignments
    if [[ "${prim_sec}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            -F 0x0004 \
            -F 0x0008 \
            -b -o "${outdir}/${outfile%.bam}.primary-secondary.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" unmapped reads
    if [[ "${unmapped}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            --rf 0x0004 \
            --rf 0x0008 \
            -F 0x0100 \
            -b -o "${outdir}/${outfile%.bam}.unmapped.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" primary alignments and singletons, and "proper"
    #+ unmapped reads
    if [[ "${proper_etc}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            -F 0x0100 \
            -b -o "${outdir}/${outfile%.bam}.proper-etc.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" and "improper" primary and secondary
    #+ alignments, and unmapped reads
    if [[ "${improp_etc}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            --rf 0x0100 \
            --rf 0x0004 \
            --rf 0x0008 \
            -b -o "${outdir}/${outfile%.bam}.proper-improper-etc.bam" \
            "${infile}"
    fi

    if [[ $((flagstat)) -eq 1 ]]; then
        for i in "${outdir}/${outfile%.bam}."*".bam"; do
            samtools flagstat \
                -@ "${threads}" \
                "${i}" \
                    > "${i%.bam}.flagstat.txt"
        done
    fi

    if [[ $((list_tally)) -eq 1 ]]; then
        #TODO Switch to GNU parallel here
        for i in "${outdir}/${outfile%.bam}."*".bam"; do
            list_tally_flags \
                "${i}" \
                "${i%.bam}.list-tally-flags.txt"
        done
    fi
}


#  ------------------------------------
#  Handle arguments
#  ------------------------------------
help="""
#  ------------------------------------
#  separate_bams.sh
#  ------------------------------------
Filter out unmapped reads from a bam infile. Optionally, run samtools flagstat
on the filtered bam outfile.

Name(s) of outfile(s) will be derived from the infile.

Dependencies:
    - samtools >= version #TBD

Arguments:
    -u  safe_mode   use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -i  infile      bam infile, including path <chr>
    -o  outdir      outfile directory, including path; if not found, will be
                    mkdir'd <chr>
    -1  primary     output bam composed of 'proper' primary alignments <lgl>
                    [default: TRUE]
    -2  secondary   output bam composed of 'proper' secondary alignments <lgl>
                    [default: TRUE]
    -3  prim_sec    output bam composed of 'proper' primary and secondary
                    alignments <lgl> [default: TRUE]
    -4  unmapped    output bam composed of 'proper' unmapped reads <lgl>
                    [default: TRUE]
    -5  proper_etc  output bam composed of 'proper' primary alignments and
                    singletons, and 'proper' unmapped reads <lgl>
                    [default: FALSE]
    -6  improp_etc  output bam composed of 'proper' and 'improper' primary
                    and secondary alignments, and unmapped reads <lgl>
                    [default: FALSE]
    -f  flagstat    run samtools flagstat on bam outfiles <lgl> [default: TRUE]
    -l  list_tally  run list and tally flags in bam outfiles <lgl>
                    [default: TRUE]
    -t  threads     number of threads <int >= 1> [default: 1]
"""

while getopts "u:i:o:1:2:3:4:5:6:f:l:t:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        1) primary="${OPTARG}" ;;
        2) secondary="${OPTARG}" ;;
        3) prim_sec="${OPTARG}" ;;
        4) unmapped="${OPTARG}" ;;
        5) proper_etc="${OPTARG}" ;;
        6) improp_etc="${OPTARG}" ;;
        f) flagstat="${OPTARG}" ;;
        l) list_tally="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage "${help}"
[[ -z "${outdir}" ]] && print_usage "${help}"
[[ -z "${primary}" ]] && primary=TRUE
[[ -z "${secondary}" ]] && secondary=TRUE
[[ -z "${prim_sec}" ]] && prim_sec=TRUE
[[ -z "${unmapped}" ]] && unmapped=TRUE
[[ -z "${proper_etc}" ]] && proper_etc=FALSE
[[ -z "${improp_etc}" ]] && improp_etc=FALSE
[[ -z "${flagstat}" ]] && flagstat=TRUE
[[ -z "${list_tally}" ]] && list_tally=TRUE
[[ -z "${threads}" ]] && threads=1


#  ------------------------------------
#  Check dependencies, and check and make variable assignments 
#  ------------------------------------
check_etc


#  ------------------------------------
#  Run samtools to...
#  ------------------------------------
main

```
</details>
<br />
