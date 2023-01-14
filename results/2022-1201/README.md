
How `Trinity` was called
- GF: `Trinity` genome-free mode
- GG: `Trinity` genome-guided mode
```txt
command_GF	command_GG	parameter	value
TRUE	TRUE	--max_memory	50G
TRUE	TRUE	--CPU	"\${SLURM_CPUS_ON_NODE}" (6)
TRUE	TRUE	--SS_lib_type	FR
TRUE	FALSE	--seqType	fq
TRUE	FALSE	--left	"\${f_free_1}"
TRUE	FALSE	--right	"\${f_free_2}"
TRUE	TRUE	--genome_guided_max_intron	"\${intron}" (1002)
TRUE	TRUE	--jaccard_clip	#SPECIFIED
TRUE	TRUE	--output	"\${outdir}/\${prefix}"
TRUE	TRUE	--full_cleanup	#SPECIFIED
TRUE	TRUE	--min_kmer_cov	1
TRUE	TRUE	--min_iso_ratio	0.05
TRUE	TRUE	--min_glue	2
TRUE	TRUE	--glue_factor	0.05
TRUE	TRUE	--max_reads_per_graph	200000
TRUE	TRUE	--normalize_max_read_cov	200
TRUE	TRUE	--group_pairs_distance	700
TRUE	TRUE	--min_contig_length	200
```
