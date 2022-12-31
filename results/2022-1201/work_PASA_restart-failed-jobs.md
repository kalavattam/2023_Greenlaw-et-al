
`#work_PASA_restart-failed-jobs.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Restarting jobs](#restarting-jobs)
	1. [Messages with BH](#messages-with-bh)
		1. [Me → BH, `2022-1227, 1206`](#me-%E2%86%92-bh-2022-1227-1206)
		1. [BH → me, `2022-1227, 1221`](#bh-%E2%86%92-me-2022-1227-1221)
	1. [`files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local`](#files_pasa_un_trim_trim-rcor_stringent-alignment-overlap-500trinity_5781-5782_q_ip_mergedun_multi-hit-mode_10_local)
	1. [`files_PASA_un_trim_trim-rcor_gene-overlap-70.0/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd`](#files_pasa_un_trim_trim-rcor_gene-overlap-700trinity_5781-5782_q_ip_mergedtrim-rcormulti-hit-mode_100_endtoend)
	1. [`files_PASA_un_trim_trim-rcor_gene-overlap-20.0/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd`](#files_pasa_un_trim_trim-rcor_gene-overlap-200trinity_5781-5782_q_ip_mergedtrim-rcormulti-hit-mode_10_endtoend)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="restarting-jobs"></a>
## Restarting jobs
<a id="messages-with-bh"></a>
### Messages with BH
<a id="me-%E2%86%92-bh-2022-1227-1206"></a>
#### Me → BH, `2022-1227, 1206`
Hi Brian,

I'm encountering an error after trying to relaunch PASA: scripts/assembly_db_loader.dbi will not connect to the SQLite database. However, the database exists at the path listed below and is not an empty file. Do you have any advice on this?

Thanks,
Kris

Final portion of STDERR:
```txt
* [Tue Dec 27 08:54:15 2022] Running CMD: /usr/local/src/PASApipeline/scripts/assembly_db_loader.dbi -M '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.pasa.sqlite' > pasa_run.log.dir/alignment_assembly_loading.out
DBI connect('database=/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.pasa.sqlite;host=localhost','root',...) failed: unable to open database file at /usr/local/src/PASApipeline/PerlLib/DB_connect.pm line 72.
Cannot connect to /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.pasa.sqlite: unable to open database file at /usr/local/src/PASApipeline/scripts/assembly_db_loader.dbi line 51.
Error, cmd: /usr/local/src/PASApipeline/scripts/assembly_db_loader.dbi -M '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.pasa.sqlite' > pasa_run.log.dir/alignment_assembly_loading.out died with ret 65280 No such file or directory at /usr/local/src/PASApipeline/PerlLib/Pipeliner.pm line 187.
        Pipeliner::run(Pipeliner=HASH(0x55d8719355c0)) called at /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl line 1047
```

<a id="bh-%E2%86%92-me-2022-1227-1221"></a>
#### BH → me, `2022-1227, 1221`
Hi Kris,

so if you run:

   ls /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.pasa.sqlite

does it show the file?

If yes, then maybe the path is too long for it.  Try copying the file to /tmp and see if it'll find it there.

best,

~b

<a id="files_pasa_un_trim_trim-rcor_stringent-alignment-overlap-500trinity_5781-5782_q_ip_mergedun_multi-hit-mode_10_local"></a>
### `files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local`
Setting things up (`tmp/`) for `files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local`
```bash
#!/bin/bash
#DONTRUN


#  Get things set up ----------------------------------------------------------
grabnode  # 1 core, corresponding defaults

cd "${HOME}/2022_transcriptome-construction_2022-1201" \
	|| echo "cd'ing failed; check on this"

cd \
	"files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local" \
		|| echo "cd'ing failed; check on this"


#  Clean out the Tsukiyama Lab scratch directory ------------------------------
cd "/fh/scratch/delete30/tsukiyama_t" \
	|| echo "cd'ing failed; check on this"

rm -- pasa.16717*

mkdir -p a/


#  Copy the SQLite database, etc. to the Tsukiyama Lab scratch directory ------
cd -- -
# /home/kalavatt/2022_transcriptome-construction_2022-1201/files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

# cp -- *.sqlite "/fh/scratch/delete30/tsukiyama_t/a"
cp -- *.accessions "/fh/scratch/delete30/tsukiyama_t/a"
cp -- *.align_assembly.config "/fh/scratch/delete30/tsukiyama_t/a"
cp -- *.fasta "/fh/scratch/delete30/tsukiyama_t/a"
cp -- *.clean "/fh/scratch/delete30/tsukiyama_t/a"
cp -- *.cln "/fh/scratch/delete30/tsukiyama_t/a"

cd "/fh/scratch/delete30/tsukiyama_t/a" \
	|| echo "cd'ing failed; check on this"
.,
#NOTE 1/2 Adjust the *.align_assembly.config to point to the SQLite in the 
#NOTE 2/2 current temporary directory


#  Get ready to run the script of interest ------------------------------------
str_directory="/fh/scratch/delete30/tsukiyama_t/b"
str_experiment="trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local"
str_accessions="trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions"


#  Call the script of interest ------------------------------------------------
cd "${HOME}/2022_transcriptome-construction_2022-1201" \
	|| echo "cd'ing failed; check on this"
# /home/kalavatt/2022_transcriptome-construction_2022-1201

# sbatch \
# 	"sh_err_out/submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh" \
# 	"${str_directory}" \
# 	"${str_experiment}" \
# 	"${str_accessions}"

#NOTE 1/N Made a local version of
#NOTE 2/N submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh to
#NOTE 3/N be called from /fh/scratch/delete30/tsukiyama_t
cd "/fh/scratch/delete30/tsukiyama_t/a" \
	|| echo "cd'ing failed; check on this"

sbatch submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh
#  It seems to be running now; also, #NOTE that you should not quote the path
#+ to the SQLite database in the *.config file
```

*Reference: The previous way you called the script...*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch \
	sh_err_out/submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh \
    files_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0 \
    trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local \
    trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
```

<a id="files_pasa_un_trim_trim-rcor_gene-overlap-700trinity_5781-5782_q_ip_mergedtrim-rcormulti-hit-mode_100_endtoend"></a>
### `files_PASA_un_trim_trim-rcor_gene-overlap-70.0/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd`
Setting things up (`tmp/`) for `files_PASA_un_trim_trim-rcor_gene-overlap-70.0/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd`
```bash
#!/bin/bash
#DONTRUN


#  Get things set up ----------------------------------------------------------
grabnode  # 1 core, corresponding defaults

cd "${HOME}/2022_transcriptome-construction_2022-1201" \
	|| echo "cd'ing failed; check on this"

cd \
	"files_PASA_un_trim_trim-rcor_gene-overlap-70.0/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd" \
		|| echo "cd'ing failed; check on this"


#  Clean out the Tsukiyama Lab scratch directory ------------------------------
cd "/fh/scratch/delete30/tsukiyama_t" \
	|| echo "cd'ing failed; check on this"

mkdir -p b/
# .,


#  Copy the SQLite database, etc. to the Tsukiyama Lab scratch directory ------
cd -- -

# cp -- *.sqlite "/fh/scratch/delete30/tsukiyama_t/b"
cp -- *.accessions "/fh/scratch/delete30/tsukiyama_t/b"
cp -- *.align_assembly.config "/fh/scratch/delete30/tsukiyama_t/b"
cp -- *.fasta "/fh/scratch/delete30/tsukiyama_t/b"
cp -- *.clean "/fh/scratch/delete30/tsukiyama_t/b"
cp -- *.cln "/fh/scratch/delete30/tsukiyama_t/b"

cd "/fh/scratch/delete30/tsukiyama_t/b" \
	|| echo "cd'ing failed; check on this"
.,

cd "${HOME}/2022_transcriptome-construction_2022-1201" \
	|| echo "cd'ing failed; check on this"
cp sh_err_out/submit_PASA_un_trim_trim-rcor_gene-overlap-70.0.sh "/fh/scratch/delete30/tsukiyama_t/b"

cd "/fh/scratch/delete30/tsukiyama_t/b" \
	|| echo "cd'ing failed; check on this"
.,

#NOTE 1/2 Adjust the *.align_assembly.config to point to the SQLite in the 
#NOTE 2/2 current temporary directory


#  Get ready to run the script of interest ------------------------------------
str_directory="/fh/scratch/delete30/tsukiyama_t/b"
str_experiment="trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local"
str_accessions="trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions"


#  Call the script of interest ------------------------------------------------
cd "${HOME}/2022_transcriptome-construction_2022-1201" \
	|| echo "cd'ing failed; check on this"
# /home/kalavatt/2022_transcriptome-construction_2022-1201

# sbatch \
# 	"sh_err_out/submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh" \
# 	"${str_directory}" \
# 	"${str_experiment}" \
# 	"${str_accessions}"

#NOTE 1/N Made a local version of
#NOTE 2/N submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh to
#NOTE 3/N be called from /fh/scratch/delete30/tsukiyama_t
cd "/fh/scratch/delete30/tsukiyama_t/b" \
	|| echo "cd'ing failed; check on this"

sbatch submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh
#  It seems to be running now; also, #NOTE that you should not quote the path
#+ to the SQLite database in the *.config file
```

<a id="files_pasa_un_trim_trim-rcor_gene-overlap-200trinity_5781-5782_q_ip_mergedtrim-rcormulti-hit-mode_10_endtoend"></a>
### `files_PASA_un_trim_trim-rcor_gene-overlap-20.0/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd`
Setting things up (`tmp/`) for `files_PASA_un_trim_trim-rcor_gene-overlap-20.0/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd`
```bash
#!/bin/bash
#DONTRUN


#  Get things set up ----------------------------------------------------------
grabnode  # 1 core, corresponding defaults

cd "${HOME}/2022_transcriptome-construction_2022-1201" \
	|| echo "cd'ing failed; check on this"

cd \
	"files_PASA_un_trim_trim-rcor_gene-overlap-20.0/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd" \
		|| echo "cd'ing failed; check on this"


#  Clean out the Tsukiyama Lab scratch directory ------------------------------
cd "/fh/scratch/delete30/tsukiyama_t" \
	|| echo "cd'ing failed; check on this"

mkdir -p c/
# .,


#  Copy the SQLite database, etc. to the Tsukiyama Lab scratch directory ------
cd -- -

# cp -- *.sqlite "/fh/scratch/delete30/tsukiyama_t/b"
cp -- *.accessions "/fh/scratch/delete30/tsukiyama_t/c"
cp -- *.align_assembly.config "/fh/scratch/delete30/tsukiyama_t/c"
cp -- *.fasta "/fh/scratch/delete30/tsukiyama_t/c"
cp -- *.clean "/fh/scratch/delete30/tsukiyama_t/c"
cp -- *.cln "/fh/scratch/delete30/tsukiyama_t/c"

cd "/fh/scratch/delete30/tsukiyama_t/c" \
	|| echo "cd'ing failed; check on this"
.,

cd "${HOME}/2022_transcriptome-construction_2022-1201" \
	|| echo "cd'ing failed; check on this"
cp sh_err_out/submit_PASA_un_trim_trim-rcor_gene-overlap-20.0.sh "/fh/scratch/delete30/tsukiyama_t/c"

cd "/fh/scratch/delete30/tsukiyama_t/c" \
	|| echo "cd'ing failed; check on this"
.,

#NOTE 1/2 Adjust the *.align_assembly.config to point to the SQLite in the 
#NOTE 2/2 current temporary directory


#  Get ready to run the script of interest ------------------------------------
str_directory="/fh/scratch/delete30/tsukiyama_t/c"
str_experiment="trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd"
str_accessions="trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions"


#  Call the script of interest ------------------------------------------------
cd "${HOME}/2022_transcriptome-construction_2022-1201" \
	|| echo "cd'ing failed; check on this"
# /home/kalavatt/2022_transcriptome-construction_2022-1201

# sbatch \
# 	"sh_err_out/submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh" \
# 	"${str_directory}" \
# 	"${str_experiment}" \
# 	"${str_accessions}"

#NOTE 1/N Made a local version of
#NOTE 2/N submit_PASA_un_trim_trim-rcor_stringent-alignment-overlap-50.0.sh to
#NOTE 3/N be called from /fh/scratch/delete30/tsukiyama_t
cd "/fh/scratch/delete30/tsukiyama_t/c" \
	|| echo "cd'ing failed; check on this"

sbatch submit_PASA_un_trim_trim-rcor_gene-overlap-20.0.sh
#  It seems to be running now; also, #NOTE that you should not quote the path
#+ to the SQLite database in the *.config file
```
