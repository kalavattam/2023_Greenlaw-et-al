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
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


check_argument_safe_mode() {
	what="""
	check_argument_safe_mode()
	--------------------------
    Run script in \"safe mode\" (\`set -Eeuxo pipefail\`) if specified; assumes
    variable \"\${safe_mode}\" is defined
    
    :param \"\${safe_mode}\": value assigned to variable within script <lgl>
    :return: NA

    #TODO Check that params are not empty or inappropriate formats or strings
	"""
	case "$(convert_chr_lower "${safe_mode}")" in
	    true | t) \
	        printf "%s\n" "-u: \"Safe mode\" is TRUE."
	        set -Eeuxo pipefail
	        ;;
	    false | f) \
	        printf "%s\n" "\"Safe mode\" is FALSE." ;;
	    *) \
	        printf "%s\n" "Exiting: \"Safe mode\" must be TRUE or FALSE."
	        # exit 1
	        ;;
	esac
}


check_argument_threads() {
	what="""
	check_argument_threads()
	---------------
	Check the value assigned to \"\${threads}\" in script; assumes variable
	\"\${threads}\" is defined

	:param \"\${threads}\": value assigned to variable within script <int >= 1>
	:return: NA

	#TODO Checks...
	"""
	case "${threads}" in
	    '' | *[!0-9]*) \
	        printf "%s\n" "Exiting: \"\${threads}\" must be an integer >= 1."
	        # exit 1
	        ;;
	    *) : ;;
	esac
}


check_dependency() {
	what="""
	check_dependency()
	------------------
    Check if program is available in "\${PATH}"; exit if not
    
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


check_exists_file() {
	what="""
	check_exists_file()
	-------------------
	Check that a file exists; exit if it doesn't
	
	:param 1: file, including path <chr>
	:return: NA
	"""
	if [[ -z "${1}" ]]; then
		printf "%s\n" "${what}"
	elif [[ ! -f "${1}" ]]; then
        printf "%s\n\n" "Exiting: File '${1}' does not exist."
        # exit 1
    else
    	:
    fi
}


check_exists_directory() {  #TODO Fix this function
	what="""
	check_exists_directory()
	------------------------
	Check that a directory exists; if it doesn't, then either make it or exit
	
	:param 1: create directory if not found: "TRUE" or "FALSE"
	          <lgl; default: FALSE>
	:param 2: directory, including path <chr>
	"""
	case "$(convert_chr_lower "${1}")" in
        true | t) \
            [[ -f "${2}" ]] ||
			    {
			        printf "%s\n" "${2} doesn't exist; mkdir'ing it."
        			mkdir -p "${2}"
			    }
            ;;
        false | f) \
            [[ -f "${2}" ]] ||
			    {
			        printf "%s\n" "Exiting: ${2} does not exist."
			        # exit 1
			    }
            ;;
        *) \
            printf "%s\n" "Exiting: param 1 is not \"TRUE\" or \"FALSE\"."
            printf "%s\n" "${what}"
            # exit 1
            ;;
    esac
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


convert_chr_lower() {
	what="""
	convert_chr_lower()
	-------------------
	Convert alphabetical characters in a string to lowercase letters
	
	:param 1: string <chr>
	:return: converted string <stdout>
	"""
	if [[ -z "${1}" ]]; then
		printf "%s\n" "${what}"
	else
		string_in="${1}"
		string_out="$(printf %s "${1}" | tr '[:upper:]' '[:lower:]')"

		echo "${string_out}"
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


print_usage() {
    what="""
    print_usage()
    -------------
    Print the script's help message and exit; assumes variable \"\${help}\" is
    defined

    :param \"\${help}\": help message assigned to a variable within script
    :return: help message <stdout>

    #TODO Checks...
    """
    echo "${help}"
    exit 1
}
