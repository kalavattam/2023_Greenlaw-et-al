#!/bin/bash

#  functions.sh
#  KA

calculate_run_time() {
	what="""
	calculate_run_time()
	--------------------
    Calculate run time for chunk of code
    
    :param 1: start time in \$(date +%s) format
    :param 2: end time in \$(date +%s) format
    :param 3: message to be displayed when printing the run time <chr>
    
    #TODO Check that params are not empty or inappropriate formats or strings
    """
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
    
    :param 1: PID of the last program the shell ran in the background (int)
    :param 2: message to be displayed next to the spinning icon (chr)

    #TODO Checks...
	"""
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
    
    :param 1: name of bam infile, including path (chr)

    #TODO Checks...
    """
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
            > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


check_exit() {
	what="""
	check_exit()
	------------
    Check the exit code of a child process
    
    :param 1: exit code <int >= 0>
    :param 2: program/package <chr>

    #TODO Check that params are not empty or inappropriate formats or strings
	"""
    if [[ "${1}" == "0" ]]; then
        echo "${2} completed: $(date)"
    else
        err "Error: ${2} returned exit code ${1}"
    fi
}


err() {
	what="""
	err()
	-----
    Print an error meassage, then exit with code 1
    
    :param 1: program/package <chr>
    :return: error message <stdout>
	
	#TODO Check that param is not empty or inappropriate format or string
	"""
    echo "${1} exited unexpectedly"
    # exit 1
}
