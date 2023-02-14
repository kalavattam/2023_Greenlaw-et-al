
`work_Trinity-GF_optimization_submit-jobs.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [PRE Set up the experiment directory](#pre-set-up-the-experiment-directory)
	1. [Symlink to datasets](#symlink-to-datasets)
		1. [Code](#code)
	1. [Printed](#printed)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="pre-set-up-the-experiment-directory"></a>
## <u>PRE</u> Set up the experiment directory
<a id="symlink-to-datasets"></a>
### Symlink to datasets
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Symlink to datasets</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir -p {FastQC,fastqs}_UMI-dedup/
mkdir -p fastqs_UMI-dedup/{symlinks,umi-tools_extract}
mkdir -p fastqs_UMI-dedup/

cd fastqs_UMI-dedup/symlinks \
    || echo "cd'ing failed; check on this..."

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}
```
</details>
<br />

<a id="printed"></a>
### Printed
<details>
<summary><i>Printed: Symlink to datasets</i></summary>

```txt


```
</details>
<br />
