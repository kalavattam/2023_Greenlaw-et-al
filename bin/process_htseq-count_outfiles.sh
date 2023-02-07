#!/bin/bash

#  process_htseq-count_outfiles.sh
#  KA


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
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "${2} doesn't exist; mkdir'ing it."
                    mkdir -p "${2}"
                }
            ;;
        false | f) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "Exiting: ${2} does not exist."
                    exit 1
                }
            ;;
        *) \
            printf "%s\n" "Exiting: param 1 is not \"TRUE\" or \"FALSE\"."
            printf "%s\n" "${what}"
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


print_usage() {
    what="""
    print_usage()
    -------------
    Print the script's help message and exit; assumes variable \"\${help}\" is
    defined

    :param \"\${help}\": help message assigned to a variable within script
    :return: help message <stdout>

    #TODO Checks...
    #TODO Change to :param #: input
    """
    echo "${help}"
    exit 1
}


check_etc() {
    #  ------------------------------------
    #  Check and make variable assignments 
    #  ------------------------------------
    #  Check for necessary dependencies; exit if not found
    check_dependency paste
    check_dependency sed

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode

    #  Check that "${dir_q}" exists
    check_exists_directory FALSE "${dir_q}"

    #  If TRUE exist, then make "${dir_o}" if it does not exist; if FALSE,
    #+ then exit if "${dir_o}" does not exist
    check_exists_directory TRUE "${dir_o}"

    #  Check on the specified value for "${string}"
    case "$(echo "${string}" | tr '[:upper:]' '[:lower:]')" in
        antisense_transcript | cut | mrna | nuts | rrna | snorna | snrna | \
        srat | sut | trna | xut) \
            :
            ;;
        *) \
            message="""
            Exiting: -s \"\${string}\" must be one of the following:
                - antisense_transcript
                - CUT
                - mRNA
                - NUTs
                - rRNA
                - snoRNA
                - snRNA
                - SRAT
                - SUT
                - tRNA
                - XUT
            """
            printf "%s\n\n" "${message}"
            exit 1
            ;;
    esac

    echo ""
}


#  ------------------------------------
#  Handle arguments, assign variables
#  ------------------------------------
help="""
#  ------------------------------------
#  process_htseq-count_outfiles.sh
#  ------------------------------------
Search user-specified directory for sample-specific htseq-count outfiles
containing strings for specific features (e.g.,the feature
'mRNA', the feature 'antisense_transcript', etc.) in their filenames; if found,
then combine all sample-specific files for the feature into a single tabular
dataframe (with features as rows, samples as columns, and counts as cells).
Order of columns (samples) is determined by an alphanumeric sort of sample-
specific file names; the script assumes that rows in sample-wise htseq-count
outfiles are ordered in the same way (i.e., it doesn't change or check for the
order of the rows).

The following feature strings are supported (uppercase, lowercase, or mixed
format is accepted):
    - antisense_transcript
    - CUT
    - mRNA
    - NUTs
    - rRNA
    - snoRNA
    - snRNA
    - SRAT
    - SUT
    - tRNA
    - XUT

Outfiles have this general format:
    \${dir_o}/htseq-count.combined.\${identifier}.\${string}.txt

Dependencies:
    - Linux paste (GNU or BSD)
    - Linux sed (GNU or BSD)

Arguments:
    -u  safe_mode   use safe mode: \"TRUE\" or \"FALSE\" <lgl> [default: FALSE]
    -d  dir_q       directory to examine (query), including path <chr>
    -o  dir_o       outfile directory, including path; if not found, program
                    will mkdir it <chr>
    -i  identifier  string to be included in the outfile name <chr>
    -s  string      string to query; options: antisense_transcript, CUT, mRNA,
                    NUTs, rRNA, snoRNA, snRNA, SRAT, SUT, tRNA, XUT <chr>
                    [default: mRNA]


#  ------------------------------------
#  Example call and results
#  ------------------------------------
❯ bash process_htseq-count_outfiles.sh \\
	-u FALSE \\
	-d \".\" \\
	-o \"./out\" \\
	-i \"timecourse\" \\
	-s \"antisense_transcript\"
#  Outfile will be \"./out/htseq-count.combined.timecourse.antisense_transcript.txt\"

❯ head \"./out/htseq-count.combined.timecourse.antisense_transcript.txt\"
BM1_DSm2_5781_sorted_sorted2antisense_transcript.txt	BM2_DSm2_7080_sorted_sorted2antisense_transcript.txt	BM3_DSm2_7079_sorted_sorted2antisense_transcript.txt	BM4_DSp2_5781_sorted_sorted2antisense_transcript.txt	BM5_DSp2_7080_sorted_sorted2antisense_transcript.txt	BM6_DSp2_7079_sorted_sorted2antisense_transcript.txt	BM7_DSp24_5781_sorted_sorted2antisense_transcript.txt	BM8_DSp24_7080_sorted_sorted2antisense_transcript.txt	BM9_DSp24_7079_sorted_sorted2antisense_transcript.txt	BM10_DSp48_5781_sorted_sorted2antisense_transcript.txt	BM11_DSp48_7080_sorted_sorted2antisense_transcript.txt	Bp1_DSm2_5782_sorted_sorted2antisense_transcript.txt	Bp2_DSm2_7081_sorted_sorted2antisense_transcript.txt	Bp3_DSm2_7078_sorted_sorted2antisense_transcript.txt	Bp4_DSp2_5782_sorted_sorted2antisense_transcript.txt	Bp5_DSp2_7081_sorted_sorted2antisense_transcript.txt	Bp6_DSp2_7078_sorted_sorted2antisense_transcript.txt	Bp7_DSp24_5782_sorted_sorted2antisense_transcript.txt	Bp8_DSp24_7081_sorted_sorted2antisense_transcript.txt	Bp9_DSp24_7078_sorted_sorted2antisense_transcript.txt	Bp10_DSp48_5782_sorted_sorted2antisense_transcript.txt	Bp11_DSp48_7081_sorted_sorted2antisense_transcript.txt	Bp12_DSp48_7078_sorted_sorted2antisense_transcript.txt
Unit10	6	41	61	70	199	149	46	194	146	123	345	6	27	58	73	212	190	55	223	124	101	305	269
Unit100	875	790	1399	614	715	977	660	720	1060	566	575	610	807	914	536	761	903	600	847	849	565	535	951
Unit101	170	95	145	21	45	71	39	76	54	9	8	129	92	82	28	33	55	16	47	52	9	12	11
Unit102	357	490	626	198	384	418	90	277	230	128	182	282	470	433	178	373	427	82	209	171	115	183	157
Unit103	221	470	613	495	421	475	70	375	231	44	295	150	508	449	652	472	320	66	318	196	56	261	192
Unit104	66	125	170	19	112	93	8	106	73	18	91	52	156	134	21	80	73	8	120	50	23	169	29
Unit105	5	33	61	13	36	44	10	45	32	7	31	3	39	53	8	32	29	6	52	40	11	25	18
Unit106	35	80	179	13	84	129	7	57	62	6	34	30	106	130	18	81	136	14	58	62	6	21	26
Unit107	36	151	253	39	169	270	74	316	232	174	329	19	111	212	53	215	233	91	324	205	150	390	329

❯ tail \"./out/htseq-count.combined.timecourse.antisense_transcript.txt\"
Unit95	91	64	85	30	77	70	39	84	56	28	47	76	92	68	55	79	76	56	82	40	21	36	37
Unit96	40	105	122	9	61	54	13	49	49	2	32	27	121	100	15	74	60	9	90	43	4	36	16
Unit97	40	57	116	33	193	234	86	442	238	592	2386	30	72	94	24	197	252	92	647	191	507	1952	1291
Unit98	23	83	158	7	34	58	5	24	20	1	15	24	82	94	8	35	48	1	30	24	3	13	10
Unit99	781	716	1252	590	653	940	591	801	1093	525	553	553	743	897	673	676	914	589	798	862	537	522	900
__no_feature	10883361	10636972	11055170	8816313	10510602	10163454	6195421	7878710	7845727	4141391	4815582	8314800	9764870	8592440	8968118	11251758	9509848	6613218	8055458	5985487	3853393	4600992	5291018
__ambiguous	140	245	337	77	180	188	57	133	148	53	102	110	250	244	99	219	223	63	155	108	40	129	120
__too_low_aQual	6208937	6762356	6657561	6189830	7992973	6610857	7121099	6959077	6245814	6669217	5737359	5418116	6305014	5251447	7109843	7353005	6005371	6760985	7201603	5448027	5762715	6193437	6767390
__not_aligned	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
__alignment_not_unique	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
"""

while getopts "u:d:o:i:s" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        d) dir_q="${OPTARG}" ;;
        o) dir_o="${OPTARG}" ;;
		i) identifier="${OPTARG}" ;;
        s) string="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${dir_q}" ]] && print_usage
[[ -z "${dir_o}" ]] && print_usage
[[ -z "${identifier}" ]] && print_usage
[[ -z "${string}" ]] && string="mRNA"

#TEST  (2023-0206)
# safe_mode=FALSE
# dir_q="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/tmp"  # cd "${dir_q}"
# dir_o="${dir_q}/out"  # ., "${dir_o}"
# identifier="timecourse"
# string="antisense_transcript"
#
# echo "${safe_mode}"
# echo "${dir_q}"
# echo "${dir_o}"
# echo "${identifier}"
# echo "${string}"
#
# ls -lhaFG "${dir_q}"
# ls -lhaFG "${dir_o}"


#  ------------------------------------
#  Check on assignments, etc.
#  ------------------------------------
check_etc


#  ------------------------------------
#  Assign path and name for the tempfile and outfile
#  ------------------------------------
file_t="${dir_o}/htseq-count.combined.${identifier}.${string}.tmp.txt"  # echo "${file_t}"
file_o="${file_t/.tmp.txt/.txt}"  # echo "${file_o}"


#  ------------------------------------
#  If present, then remove the temp- and outfile
#  ------------------------------------
if [[ -f "${file_t}" ]]; then rm "${file_t}"; fi
if [[ -f "${file_o}" ]]; then rm "${file_o}"; fi


#  ------------------------------------
#  Collect all files (with paths) containing the selected string into an array
#  ------------------------------------
unset files
typeset -a files
while IFS=" " read -r -d $'\0'; do
    files+=( "${REPLY}" )
done < <(\
    find "${dir_q}" \
        -maxdepth 1 \
        -type f \
        -name "*${string}*" \
        -print0 \
            | sort -zV\
)
# echo_test "${files[@]}"
# echo "${#files[@]}"


#  ------------------------------------
#  Collect even indices into a comma-separated string; assign the string to
#+ variable 'joined'
#  ------------------------------------
unset evens
typeset -a evens
for (( i = 1; i <= $(( ${#files[@]} * 2 )); i++ )); do
   if [[ $(( i % 2 )) -eq 0 ]]; then
        evens+=( "${i}" )
   fi
done
# echo_test "${evens[@]}"

printf -v joined '%s,' "${evens[@]}"
# echo "${joined%,}"


#  ------------------------------------
#  Concatenate pertinent columns for individual htseq-count outfiles
#  ------------------------------------
paste ${files[*]} | cut -f "1,${joined%,}" > "${file_t}"
# head "${file_t}"
# tail "${file_t}"


#  ------------------------------------
#  Strip paths from individual files, then save the filenames into a new array,
#+ which will be used to name the columns in the outfile
#  ------------------------------------
unset filenames
typeset -a filenames
for i in "${files[@]}"; do
    filenames+=( "$(basename "${i}")" )
done
# echo_test "${filenames[@]}"


#  ------------------------------------
#  To the tempfile, add the filenames as column names
#  ------------------------------------
sed -i "1i\
$(echo ${filenames[*]})
" "${file_t}"
# head "${file_t}"


#  ------------------------------------
#  Currently, the tempfile is a mix of both single and multiple whitespaces,
#+ and tabs; replace all whitespaces and tabs with a single tab; save the
#+ results to the outfile
#  ------------------------------------
cat "${file_t}" \
    | sed 's/\t/ /g' \
    | sed 's/[ ][ ]*/ /g' \
    | sed 's/ /\t/g' \
        > "${file_o}"
# head "${file_o}"
# tail "${file_o}"
# echo "${file_o}"


#  ------------------------------------
#  If the outfile is present, then remove the tempfile
#  ------------------------------------
if [[ -f "${file_o}" ]]; then rm "${file_t}"; fi
