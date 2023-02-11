#!/bin/bash

#  functions.sh
#  KA


check_exit() {
    what="""
    check_exit()
    ------------
    Check the exit code of a child process
    
    #TODO Check that params are not empty or inappropriate formats or strings

    :param 1: exit code <int >= 0>
    :param 2: program/package <chr>
    :return: message <chr>
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
    
    #TODO Check that param is not empty or inappropriate format or string
    
    :param 1: program/package <chr>
    :return: error message (stdout) <chr>
    """
    echo "${1} exited unexpectedly"
    # exit 1
}


check_arguments_mode() {
    what="""
    check_arguments_mode()
    ----------------------
    Calculate run time for chunk of code

    :param 1: start time in \$(date +%s) format
    :param 2: end time in \$(date +%s) format
    :param 3: message to be displayed when printing the run time <chr>
    :return: message <chr>
    """
    case "$(convert_chr_lower "${mode_1}")" in
        true | t | 1) \
            case "$(convert_chr_lower "${mode_2}")" in
                true | t | 1) \
                    echo "Exiting: Both modes 1 and 2 are TRUE."
                    echo "         Only one of the modes can be TRUE."
                    exit 1
                    ;;
                false | f | 0) \
                    case "$(convert_chr_lower "${mode_3}")" in
                        true | t | 1) \
                            echo "Exiting: Both modes 1 and 3 are TRUE."
                            echo "         Only one of the modes can be TRUE."
                            exit 1
                            ;;
                        false | f | 0) \
                            echo "Running 'mode_1'"
                            mode=1
                            ;;
                        *) \
                            printf "%s\n" "Exiting: Mode 3 is neither T nor F."
                            exit 1
                    esac
                    ;;
                *) \
                    printf "%s\n" "Exiting: 'mode_2' is neither T nor F."
                    exit 1
                    ;;
            esac
            ;;
        false | f | 0) \
            case "$(convert_chr_lower "${mode_2}")" in
                true | t | 1) \
                    case "$(convert_chr_lower "${mode_3}")" in
                        true | t | 1) \
                            echo "Exiting: Both modes 2 and 3 are TRUE."
                            echo "         Only one of the modes can be TRUE."
                            exit 1
                            ;;
                        false | f | 0) \
                            echo "Running 'mode_2'"
                            mode=2
                            ;;
                        *) \
                            printf "%s\n" "Exiting: Mode 2 is neither T nor F."
                            exit 1
                    esac
                    ;;
                false | f | 0) \
                    case "$(convert_chr_lower "${mode_3}")" in
                        true | t | 1) \
                            echo "Running 'mode_3'"
                            mode=3
                            ;;
                        false | f | 0) \
                            echo "Exiting: Modes 1, 2, and 3 are all FALSE."
                            echo "         One of the modes must be TRUE."
                            exit 1
                            ;;
                        *) \
                            printf "%s\n" "Exiting: Mode 3 is neither T nor F."
                            exit 1
                    esac
                    ;;
                *) \
                    printf "%s\n" "Exiting: Mode 1 is neither T nor F."
                    exit 1
                    ;;
            esac
            ;;
        *) \
            printf "%s\n" "Exiting: Mode 1 is neither T nor F."
            exit 1
            ;;
    esac
}




