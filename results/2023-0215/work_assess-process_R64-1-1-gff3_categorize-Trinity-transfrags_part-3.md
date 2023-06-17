
`#work_assess-process_R64-1-1-gff3_categorize-Trinity-transfrags_part-3.md`
<br />
<br />

<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
	1. [Code](#code)

<!-- /MarkdownTOC -->
<br />
<br />

<a id="get-situated"></a>
## Get situated
<a id="code"></a>
### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

# tmux new -s htseq
# tmux a -t htseq

transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

source activate gff3_env
```
</details>
<br />
<br />

