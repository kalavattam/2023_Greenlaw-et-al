#!/bin/bash

#  work_PASA_un_trim_trim-rcor_stringent-alignment-overlap_preprocessed-rcor-only.sh
#  KA
#  2022-1229


#  Create an array of files of interest, including relative paths -------------
#  "rcor-only processed" genome-guided .fastas ------------
#  EndToEnd
unset GG_rcor_EndToEnd
typeset -a GG_rcor_EndToEnd
while IFS=" " read -r -d $'\0'; do
    GG_rcor_EndToEnd+=( "${REPLY}" )
done < <(\
    find "files_Trinity_genome-guided/files_processed-rcor-only" \
        -type f \
        -name "*EndToEnd.Trinity-GG.fasta" \
        -print0 |
            sort -z
)
# echoTest "${GG_rcor_EndToEnd[@]}"

#  Local
unset GG_rcor_Local
typeset -a GG_rcor_Local
while IFS=" " read -r -d $'\0'; do
    GG_rcor_Local+=( "${REPLY}" )
done < <(\
    find "files_Trinity_genome-guided/files_processed-rcor-only" \
        -type f \
        -name "*Local.Trinity-GG.fasta" \
        -print0 |
            sort -z
)
# echoTest "${GG_rcor_Local[@]}"

unset T_rcor
typeset -A T_rcor

#  EndToEnd
GF_rcor_EndToEnd="files_Trinity_genome-free/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta"
for i in "${GG_rcor_EndToEnd[@]}"; do
    # echo "Working with ${i}..."
    T_rcor["${i}"]+="${GF_rcor_EndToEnd}"
    echo ""
done

#  Local
GF_rcor_Local="files_Trinity_genome-free/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local.Trinity.fasta"
for i in "${GG_rcor_Local[@]}"; do
    # echo "Working with ${i}..."
    T_rcor["${i}"]+="${GF_rcor_Local}"
    echo ""
done


#  How do the assignments look? -----------------------------------------------
message="""
#  'rcor-only processed' genome-guided .fastas ------------
#+ Keys (genome-guided Trinity files)
$(echoTest "${!T_rcor[@]}")

#+ Values (genome-free Trinity files)
$(echoTest "${T_rcor[@]}")
"""
echo "${message}"


#  Establish functions for setting up names of directories, files, etc. -------
name_tx_db() {
    # This function parses pertinent path and filename info to determine the
    # name of a transcriptome database; it's highly dependent on the context of
    # these particular sets of experiments
    #
    # :param 1: associate array "keys" <e.g., "${!T_full[*]}">
    # :param 2: number of key to work with <int 1-3; e.g., "3">
    echo "${1}" \
        | cut -d ' ' -f "${2}" \
        | cut -d '/' -f 3- \
        | rev \
        | cut -b 18- \
        | rev
}


get_key_or_value() {
	#TODO Documentation
	echo "${1}" | cut -d ' ' -f "${2}"
}


get_GG_or_GF() {
	#TODO Documentation
	echo "${1}" | cut -d ',' -f "${2}"
}


#  Make an associative array that connects the information for... -------------
#+ Trinity-GF .fastas, Trinity-GG .fastas, and PASA databases
unset info_tx_db
typeset -A info_tx_db
for i in "T_rcor"; do
	for j in $(seq 1 6); do
		# i="T_rcor"
		# j=1
		echo "#  -------------------------------------"
		old_key="get_key_or_value \"\${!${i}[*]}\" ${j}"
		echo "${old_key}"
		eval "${old_key}"
		echo ""

		old_value="get_key_or_value \"\${${i}[*]}\" ${j}"
		echo "${old_value}"
		eval "${old_value}"
		echo ""

		name_of_db="name_tx_db \"\${!${i}[*]}\" ${j}"
		echo "${name_of_db}"
		eval "${name_of_db}"
		echo ""
		
		new_key="$(echo "$(eval "${name_of_db}")")"
		new_val="$(echo "$(eval "${old_key}"),$(eval "${old_value}")")"
		info_tx_db["${new_key}"]="${new_val}"
		echo ""
	done
done

#  Make sure everything is correctly associated
for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""
done


#  Get a .gff3 ready for precursor and main commands --------------------------
#TODO Test that *.gff3.gz is present as well
if [[ ! -f "${HOME}/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3" ]]; then
	zcat "${HOME}/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz" \
		> "${HOME}/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3"
fi


#  Set up and run loop for precursor commands ---------------------------------
values=(10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0)
for h in "${values[@]}"; do
	#  Define important variables --------------------------------------------------
	value="${h}"
	d_exp="files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-${value}"
	s_name="submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-${value}.sh"
	export PASAHOME="/usr/local/src/PASApipeline"

	echo "   \${value}: ${value}"
	echo "   \${d_exp}: ${d_exp}"
	echo "  \${s_name}: ${s_name}"
	echo "\${PASAHOME}: ${PASAHOME}"
	echo ""


	#  Set up and run loop for PASA precursor commands -----------------------------
	count=1
	for i in "${!info_tx_db[@]}"; do
		echo "#  ========================================================================"
		echo "#  Working with iteration ### ${count} ### ======================================="
		echo "#  ========================================================================"
		echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
		echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
		echo "DB: ${i}"
		echo "" && echo ""


		echo "#  ------------------------------------------------------------------------"
		echo "#  mkdir the experiment directory -----------------------------------------"
		echo "#  ------------------------------------------------------------------------"
		[[ -d "${d_exp}/${i}" ]] \
			|| mkdir -p "${d_exp}/${i}"
		echo "" && echo ""


		echo "#  ------------------------------------------------------------------------"
		echo "#  cat the .fastas from Trinity genome-free and genome-guided approaches --"
		echo "#  ------------------------------------------------------------------------"
		cmd="cat \
		$(get_GG_or_GF "${info_tx_db["${i}"]}" 1) \
		$(get_GG_or_GF "${info_tx_db["${i}"]}" 2) \
		> ${d_exp}/${i}/${i}.transcripts.fasta"
		echo "${cmd}"
		eval "${cmd}"
		echo "" && echo ""


		echo "#  ------------------------------------------------------------------------"
		echo "#  Create .txts for Trinity genome-free transcript accessions -------------"
		echo "#  ------------------------------------------------------------------------"
		parallel --header : --colsep " " -k -j 1 echo \
		"singularity run \
		    --no-home \
		    --bind {d_exp} \
		    ~/singularity-docker-etc/PASA.sif \
		        ${PASAHOME}/misc_utilities/accession_extractor.pl \
		            \< {genome_free_fasta} \
		            \> {genome_free_accessions}" \
		::: d_exp "$(pwd)" \
		::: genome_free_fasta "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" \
		:::+ genome_free_accessions "${d_exp}/${i}/$(basename "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" .fasta).accessions"
		
		parallel --header : --colsep " " -k -j 1 \
		"singularity run \
		    --no-home \
		    --bind {d_exp} \
		    ~/singularity-docker-etc/PASA.sif \
		        ${PASAHOME}/misc_utilities/accession_extractor.pl \
		            < {genome_free_fasta} \
		            > {genome_free_accessions}" \
		::: d_exp "$(pwd)" \
		::: genome_free_fasta "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" \
		:::+ genome_free_accessions "${d_exp}/${i}/$(basename "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" .fasta).accessions"
		echo "" && echo ""


		echo "#  ------------------------------------------------------------------------"
		echo "#  Clean the transcript sequences -----------------------------------------"
		echo "#  ------------------------------------------------------------------------"
		parallel --header : --colsep " " -k -j 1 echo \
		"singularity run \
		    --no-home \
		    --bind {d_exp} \
		    --bind {d_scr} \
		    ~/singularity-docker-etc/PASA.sif \
		        ${PASAHOME}/bin/seqclean \
		            {genome_combined}" \
		::: d_exp "$(pwd)" \
		::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
		::: genome_combined "${d_exp}/${i}/${i}.transcripts.fasta"
		
		cd "${d_exp}/${i}"
		parallel --header : --colsep " " -k -j 1 \
		"singularity run \
		    --no-home \
		    --bind {d_exp} \
		    --bind {d_scr} \
		    ~/singularity-docker-etc/PASA.sif \
		        ${PASAHOME}/bin/seqclean \
		            {genome_combined}" \
		::: d_exp "$(pwd)" \
		::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
		::: genome_combined "${i}.transcripts.fasta"
		cd -
		echo "" && echo ""


		echo "#  ------------------------------------------------------------------------"
		echo "#  Write .config files for the calls to PASA ------------------------------"
		echo "#  ------------------------------------------------------------------------"
cat << align_assembly > "./${d_exp}/${i}/${i}.align_assembly.config"
## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/${d_exp}/${i}/${i}.pasa.sqlite


#######################################################
# Parameters to specify to specific scripts in pipeline
# create a key = "script_name" + ":" + "parameter" 
# assign a value as done above.

#script validate_alignments_in_db.dbi
validate_alignments_in_db.dbi:--MIN_PERCENT_ALIGNED=75
validate_alignments_in_db.dbi:--MIN_AVG_PER_ID=95
validate_alignments_in_db.dbi:--NUM_BP_PERFECT_SPLICE_BOUNDARY=0

#script subcluster_builder.dbi
subcluster_builder.dbi:-m=50
align_assembly
		echo "" && echo ""


		echo "#  ------------------------------------------------------------------------"
		echo "#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --"
		echo "#  ------------------------------------------------------------------------"
		fasta_SC_orig="${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
		fasta_SC_sym="$(basename ${fasta_SC_orig})"
		cmd="ln -s ${fasta_SC_orig} ${fasta_SC_sym}"
		cd "${d_exp}/${i}"
		# unlink "${fasta_SC_sym}"
		echo "${cmd}"
		eval "${cmd}"
		cd -
		echo "" && echo ""


		echo "#  ------------------------------------------------------------------------"
		echo "#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---"
		echo "#  ------------------------------------------------------------------------"
		gff3_SC_orig="${HOME}/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3"
		gff3_SC_sym="$(basename ${gff3_SC_orig})"
		cmd="ln -s ${gff3_SC_orig} ${gff3_SC_sym}"
		cd "${d_exp}/${i}"
		# unlink "${gff3_SC_sym}"
		echo "${cmd}"
		eval "${cmd}"
		cd -
		echo "" && echo ""


		echo "#  ------------------------------------------------------------------------"
		echo "#  Print the contents of the given PASA experiment directory --------------"
		echo "#  ------------------------------------------------------------------------"	
		., "./${d_exp}/${i}"
		echo "" && echo ""
		echo "" && echo ""

		(( count++ ))
	done


	#  Set up a job submission script for `PASA` `Launch_PASA_pipeline.pl` ---------
	threads=8
	if [[ -f "./sh_err_out/${s_name}" ]]; then
	        rm "./sh_err_out/${s_name}"
	fi
cat << script > "./sh_err_out/${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${s_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${s_name%.sh}.%J.out.txt

#  ${s_name}
#  KA
#  $(date '+%Y-%m%d')

str_directory="\${1}"
str_experiment="\${2}"
str_accessions="\${3}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is \${PASAHOME}"
echo ""

cd "\${str_directory}/\${str_experiment}"
echo "Working directory from which the script is called: \$(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \\
	--no-home \\
	--bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
	--bind "\$(pwd)" \\
	--bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
	"\${HOME}/singularity-docker-etc/PASA.sif" \\
		"\${PASAHOME}/Launch_PASA_pipeline.pl" \\
			--CPU \${SLURM_CPUS_ON_NODE} \\
			-c "\${str_experiment}.align_assembly.config" \\
			-C \\
			-R \\
			-g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \\
			-I 1002 \\
			-t "\${str_experiment}.transcripts.fasta.clean" \\
			-T \\
			-u "\${str_experiment}.transcripts.fasta" \\
			--TDN "\${str_accessions}" \\
			--transcribed_is_aligned_orient \\
			--stringent_alignment_overlap ${value} \\
			--ALIGNERS "blat,gmap,minimap2" \\
				1> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stdout.log") \\
				2> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)

if [[ -f "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
	#  cyberciti.biz/faq/linux-unix-script-check-if-file-empty-or-not/
	if [[ -s "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
		singularity run \\
		    --no-home \\
		    --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
		    --bind "\$(pwd)" \\
		    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
		    "\${HOME}/singularity-docker-etc/PASA.sif" \\
		        \${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \\
		            -c "\${str_experiment}.align_assembly.config" \\
		            -t "\${str_experiment}.transcripts.fasta" \\
		            --prefix "\${str_experiment}.compreh_init_build" \\
		            --min_per_ID 95 \\
		            --min_per_aligned 30 \\
		                1> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stdout.log") \\
		                2> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stderr.log" >&2)
	else
		echo "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf is empty"
		echo "Check on things..."
	fi
fi

script
	# vi "sh_err_out/${s_name}"  # :q


	#  Run the job submission script for `PASA` `Launch_PASA_pipeline.pl` ----------
	for i in "${!info_tx_db[@]}"; do
		echo ""
		str_directory="${d_exp}"
		str_experiment="${i}"
		str_accessions="$(basename "$(get_GG_or_GF "${info_tx_db[${i}]}" 2)" .fasta).accessions"

		echo "#  ========================================================="
		echo "- \${str_directory} is ${str_directory}"
		echo "- \${str_experiment} is ${str_experiment}"
		echo "- \${str_accessions} is ${str_accessions}"
		echo ""

		sbatch "sh_err_out/${s_name}" "${str_directory}" "${str_experiment}" "${str_accessions}"
		sleep 0.25
		echo ""
		echo ""
	done
done
