
#  collate_sea-tsv.sh
#  KA

#  Note: Change (hardcode) variables labeled #ARGUMENT as necessary


#  Initialize variables, arrays -----------------------------------------------
#  Run "check"/safety code below
checks=TRUE  #ARGUMENT

#  Include only the first part of the directory names; below, we use wildcard
#+ matching (*) to find all related directories
p_nab3="${HOME}/tsukiyamalab/alisong/KA.2023-0315.sacCer3_fasta/automate_try1/nab3"  #ARGUMENT
p_nrd1="${HOME}/tsukiyamalab/alisong/KA.2023-0315.sacCer3_fasta/automate_try1/nrd1"  #ARGUMENT

#  Path to, and including, outfile directory
p_out="${HOME}/tsukiyamalab/alisong/KA.2023-0315.sacCer3_fasta/automate_try1"  #ARGUMENT
[[ "${checks}" == TRUE ]] &&
    {
        if [[ ! -d "${p_out}" ]]; then
            echo "Outfile dirctory \"p_out\" does not exist"
            exit 1
        fi
    }

#  Names of outfile dataframes
df_nab3="df_sea_nab3.tsv"  #ARGUMENT
df_nrd1="df_sea_nrd1.tsv"  #ARGUMENT

#  Initialize an array of all sea.tsv files assoc. with the Nab3 experiments
unset sea_nab3
typeset -a sea_nab3
while IFS=" " read -r -d $'\0'; do
    sea_nab3+=( "${REPLY}" )
done < <(
    find "${p_nab3}"* \
        -type f \
        -name "sea.tsv" \
        -print0 \
            | sort -z
)
[[ "${checks}" == TRUE ]] && 
    {
        if [[ ${#sea_nab3[@]} -gt 0 ]]; then
            echo "Array \"sea_nab3\" contains the following elements:"
            for i in "${sea_nab3[@]}"; do echo "    - ${i}"; done
            echo ""
        else
            echo "Oops, something went wrong... Array \"sea_nab3\" is empty"
            exit 1
        fi
        
    }

#  Initialize an array of all sea.tsv files assoc. with the Nrd1 experiments
unset sea_nrd1
typeset -a sea_nrd1
while IFS=" " read -r -d $'\0'; do
    sea_nrd1+=( "${REPLY}" )
done < <(
    find "${p_nrd1}"* \
        -type f \
        -name "sea.tsv" \
        -print0 \
            | sort -z
)
[[ "${checks}" == TRUE ]] &&
    {
        if [[ ${#sea_nrd1[@]} -gt 0 ]]; then
            echo "Array \"sea_nrd1\" contains the following elements:"
            for i in "${sea_nrd1[@]}"; do echo "    - ${i}"; done
            echo ""
        else
            echo "Oops, something went wrong... Array \"sea_nrd1\" is empty"
            exit 1
        fi
        
    }


#  Write dataframe for Nab3 information ---------------------------------------
echo "Begin work with Nab3"

#  If a "${df_nab3}" file already exists in "${p_out}", delete it 
if [[ -f "${p_out}/${df_nab3}" ]]; then rm "${p_out}/${df_nab3}"; fi

#  Initialize a new, empty "${df_nab3}" in "${p_out}"
touch "${p_out}/${df_nab3}"
[[ "${checks}" == TRUE ]] \
    && ls -lhaFG "${p_out}/${df_nab3}" \
    && cat "${p_out}/${df_nab3}" \
    && printf "\n"

h=0
for i in "${sea_nab3[@]}"; do
    #  Initialize changing variables
    tmp_dirname="$(dirname "${i}")"
    samp="$(basename "${tmp_dirname}")"

    #  Count iterations, printing steps in pipeline as they begin
    let h++
    echo "#  -------------------------------------"
    printf "Iteration '%d'\n" "${h}"

    echo "    - Adding column of sample names (written to disc)"
    if [[ -f "${p_out}/tmp_A.txt" ]]; then rm "${p_out}/tmp_A.txt"; fi
    echo "${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}" \
        > "${p_out}/tmp_A.txt"

    echo "    - Adding columns of sample values, metrics (written to disc)"
    if [[ -f "${p_out}/tmp_B.txt" ]]; then rm "${p_out}/tmp_B.txt"; fi
    cat "${i}" | head -n -4 | tail -n -10 | cut -f 1-3,5-17 \
        > "${p_out}/tmp_B.txt"
    
    echo "    - Binding columns and appending to \"\${p_out}/\${df_nab3}\""
    paste "${p_out}/tmp_A.txt" "${p_out}/tmp_B.txt" >> "${p_out}/${df_nab3}"

    echo "    - Removing temporary files"
    rm "${p_out}/tmp_A.txt" "${p_out}/tmp_B.txt"

    printf "\n\n"
done

#  Give "${df_nab3}" a header of column names
echo "Appending header of column names to \"\${p_out}/\${df_nab3}\""
echo ""

if [[ -f "${p_out}/tmp.tsv" ]]; then rm "${p_out}/tmp.tsv"; fi
echo "sample"$'\t'"rank"$'\t'"db"$'\t'"id"$'\t'"consensus"$'\t'"tp"$'\t'"tp%"$'\t'"fp"$'\t'"fp%"$'\t'"enr_ratio"$'\t'"score_thr"$'\t'"pvalue"$'\t'"log_pvalue"$'\t'"evalue"$'\t'"log_evalue"$'\t'"qvalue"$'\t'"log_qvalue" \
    | cat - "${p_out}/${df_nab3}" \
    >> "${p_out}/tmp.tsv"

[[ -s "${p_out}/tmp.tsv" ]] && exit_no="$(echo $?)"
if [[ ${exit_no} -eq 0 ]]; then
    mv -f "${p_out}/tmp.tsv" "${p_out}/${df_nab3}"
else
    echo "Oops, something went wrong... File \"\${p_out}/tmp.tsv\" is empty"
    exit 1
fi


#  Write dataframe for Nrd1 information ---------------------------------------
echo "Begin work with Nrd1"

#  If a "${df_nrd1}" file already exists in "${p_out}", delete it 
if [[ -f "${p_out}/${df_nrd1}" ]]; then rm "${p_out}/${df_nrd1}"; fi

#  Initialize a new, empty "${df_nrd1}" in "${p_out}"
touch "${p_out}/${df_nrd1}"
[[ "${checks}" == TRUE ]] \
    && ls -lhaFG "${p_out}/${df_nrd1}" \
    && cat "${p_out}/${df_nrd1}" \
    && printf "\n"

h=0
for i in "${sea_nrd1[@]}"; do
    #  Initialize changing variables
    tmp_dirname="$(dirname "${i}")"
    samp="$(basename "${tmp_dirname}")"

    #  Count iterations, printing steps in pipeline as they begin
    let h++
    echo "#  -------------------------------------"
    printf "Iteration '%d'\n" "${h}"

    echo "    - Adding column of sample names (written to disc)"
    if [[ -f "${p_out}/tmp_A.txt" ]]; then rm "${p_out}/tmp_A.txt"; fi
    echo "${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}"$'\n'"${samp}" \
        > "${p_out}/tmp_A.txt"

    echo "    - Adding columns of sample values, metrics (written to disc)"
    if [[ -f "${p_out}/tmp_B.txt" ]]; then rm "${p_out}/tmp_B.txt"; fi
    cat "${i}" | head -n -4 | tail -n -10 | cut -f 1-3,5-17 \
        > "${p_out}/tmp_B.txt"
    
    echo "    - Binding columns and appending to \"\${p_out}/\${df_nrd1}\""
    paste "${p_out}/tmp_A.txt" "${p_out}/tmp_B.txt" >> "${p_out}/${df_nrd1}"

    echo "    - Removing temporary files"
    rm "${p_out}/tmp_A.txt" "${p_out}/tmp_B.txt"

    printf "\n\n"
done

#  Give "${df_nrd1}" a header of column names
echo "Appending header of column names to \"\${p_out}/\${df_nrd1}\""
echo ""

if [[ -f "${p_out}/tmp.tsv" ]]; then rm "${p_out}/tmp.tsv"; fi
echo "sample"$'\t'"rank"$'\t'"db"$'\t'"id"$'\t'"consensus"$'\t'"tp"$'\t'"tp%"$'\t'"fp"$'\t'"fp%"$'\t'"enr_ratio"$'\t'"score_thr"$'\t'"pvalue"$'\t'"log_pvalue"$'\t'"evalue"$'\t'"log_evalue"$'\t'"qvalue"$'\t'"log_qvalue" \
    | cat - "${p_out}/${df_nrd1}" \
    >> "${p_out}/tmp.tsv"

[[ -s "${p_out}/tmp.tsv" ]] && exit_no="$(echo $?)"
if [[ ${exit_no} -eq 0 ]]; then
    mv -f "${p_out}/tmp.tsv" "${p_out}/${df_nrd1}"
else
    echo "Oops, something went wrong... File \"\${p_out}/tmp.tsv\" is empty"
    exit 1
fi

exit 0
