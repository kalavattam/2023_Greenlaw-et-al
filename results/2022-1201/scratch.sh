#!/bin/bash
#DONTRUN

threads=""
rep_1=""
rep_2=""
outfile=""

#  Run echo tests ---------------------
parallel --header : --colsep " " -k -j 1 echo \\
"samtools merge \\
    -@ {threads} \\
    {rep_1} \\
    {rep_2} \\
    -o {outfile}" \\
::: threads "\${threads}" \\
::: rep_1 "\${rep_1}" \\
:::+ rep_2 "\${rep_2}" \\
:::+ outfile "\${outfile}"

parallel --header : --colsep " " -k -j 1 echo \\
"samtools index \\
    -@ {threads} \\
    {outfile}" \\
::: threads "\${threads}" \\
::: outfile "\${outfile}"

parallel --header : --colsep " " -k -j 1 echo \\
"samtools sort \\
    -@ {threads} \\
    {outfile} \\
    -o {outfile_sorted}" \\
::: threads "\${threads}" \\
:::+ outfile "\${outfile}" \\
:::+ outfile_sorted "\${outfile%.bam}.sorted.bam"

#  Run commands -----------------------
parallel --header : --colsep " " -k -j 1 \\
"samtools merge \\
    -@ {threads} \\
    {rep_1} \\
    {rep_2} \\
    -o {outfile}" \\
::: threads "\${threads}" \\
::: rep_1 "\${rep_1}" \\
:::+ rep_2 "\${rep_2}" \\
:::+ outfile "\${outfile}"

# utcc.utoronto.ca/~cks/space/blog/programming/BourneIfCanSetVars
if [[ \$(\\
	parallel --header : --colsep " " -k -j 1 \\
	"samtools index \\
	    -@ {threads} \\
	    {outfile}" \\
	::: threads "\${threads}" \\
	::: outfile "\${outfile}" \\
) -ne 0 ]]; then
	parallel --header : --colsep " " -k -j 1 \\
	"samtools sort \\
	    -@ {threads} \\
	    {outfile} \\
	    -o {outfile_sorted}" \\
	::: threads "\${threads}" \\
	:::+ outfile "\${outfile}" \\
	:::+ outfile_sorted "\${outfile%.bam}.sorted.bam"

	mv -f \\
		"\${outfile%.bam}.sorted.bam" \\
		"\${outfile}"

	parallel --header : --colsep " " -k -j 1 \\
	"samtools index \\
	    -@ {threads} \\
	    {outfile}" \\
	::: threads "\${threads}" \\
	::: outfile "\${outfile}"
fi

# if [[ -f "\${outfile}" ]]; then
# 	parallel --header : --colsep " " -k -j 1 \\
# 	"samtools index \\
# 	    -@ {threads} \\
# 	    {outfile}" \\
# 	::: threads "${threads}" \\
# 	::: outfile "${outfile}"
#
# 	if [[ ! $? -eq 0 ]]; then
# 		parallel --header : --colsep " " -k -j 1 \\
# 		"samtools sort \\
# 		    -@ {threads} \\
# 		    {outfile} \\
# 		    -o {outfile_sorted}" \\
# 		::: threads "${threads}" \\
# 		:::+ outfile "${outfile}" \\
# 		:::+ outfile_sorted "${outfile%.bam}.sorted.bam"
#
# 		parallel --header : --colsep " " -k -j 1 \\
# 		"samtools index \\
# 		    -@ {threads} \\
# 		    {outfile}" \\
# 		::: threads "${threads}" \\
# 		::: outfile "${outfile}"
# 	fi
# fi
