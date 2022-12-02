
# 2022-11
<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [Links on how to do miscellaneous things](#links-on-how-to-do-miscellaneous-things)
    1. [System](#system)
    1. [Bash](#bash)
    1. [Vi/Vim](#vivim)
    1. [Sublime](#sublime)
        1. [On making Sublime plugins](#on-making-sublime-plugins)
    1. [Markdown](#markdown)
    1. [HTML](#html)
    1. [Slack](#slack)
    1. [Shell scripting](#shell-scripting)
    1. [Yeast genomics](#yeast-genomics)
    1. [Python](#python)
    1. [SLURM](#slurm)
    1. [FHCC Data Science](#fhcc-data-science)
    1. [`Singularity`, `Docker`](#singularity-docker)
    1. [Tmux](#tmux)
    1. [Awk](#awk)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="links-on-how-to-do-miscellaneous-things"></a>
## Links on how to do miscellaneous things
<a id="system"></a>
### System
- [How to shut off auto-period with double space](https://stackoverflow.com/questions/42566449/avoid-auto-period-character-after-quick-type-space-in-sublime-text-3) (in particular, see comment #2, which gives a command-line input answer)
- [Check if file exists relative to current script](https://stackoverflow.com/questions/69418076/check-if-file-exist-relative-to-current-script-one-level-up)
- [On listing functions defined in shell](https://stackoverflow.com/questions/4471364/how-do-i-list-the-functions-defined-in-my-shell)
    + `declare -F`
- [On using printf](https://linuxize.com/post/bash-printf-command/)

<a id="bash"></a>
### Bash
- [Choosing between $0 and $BASH_SOURCE](https://stackoverflow.com/questions/35006457/choosing-between-0-and-bash-source)
- 

<a id="vivim"></a>
### Vi/Vim
- [Searching and replacing](https://docs.oracle.com/cd/E19253-01/806-7612/editorvi-62/index.html)
- [Page up/down keystrokes](https://alvinalexander.com/linux-unix/vi-vim-page-up-page-down-keys-keystrokes/)

<a id="sublime"></a>
### Sublime
- [Shortcuts to change text case (upper or lower)](https://www.nobledesktop.com/blog/change-text-case-in-sublime-text)
    + Convert to upper case: `cmd k` the `cmd u`
    + Convert to lower case: `cmd k` the `cmd l`
- [Shortcuts for more complicated case conversions](https://github.com/jdavisclark/CaseConversion)
    + dash-case: `ctrl alt c`, `ctrl alt h`
    + separate words: `ctrl alt c`, `ctrl alt w`
    + [more options](https://github.com/jdavisclark/CaseConversion#keybindings)
    + [`stackoverflow.com` post](https://stackoverflow.com/questions/68735093/insert-hyphens-between-each-space-on-sublime-text)
- [Shortcut for split view (duplicate of the same file)](https://stackoverflow.com/questions/69201917/how-to-create-a-keyboard-shortcut-for-split-view-duplicate-of-the-same-file-in)
    + Non-shortcut way: `File` > `Split View`
- https://github.com/randy3k/SendCode#sendcode-for-sublime-text
- https://www.reddit.com/r/SublimeText/comments/gwcug3/how_to_run_only_selected_lines_of_code_in_sublime/
- [How to see installed packages](https://forum.sublimetext.com/t/sublime-text3-how-to-see-installed-packages/21939/2)
    + `Package Control: List Packages`
- [How to uninstall packages](https://superuser.com/questions/840527/how-to-uninstall-remove-package-control-from-sublime-text-3)
    + `Package Control: Remove Package`
- [How to change the theme](https://www.technipages.com/how-to-change-the-theme-in-sublime-text-3)
- [Getting Sublime kitted out](https://rowannicholls.github.io/sublime_text.html)

<a id="on-making-sublime-plugins"></a>
#### On making Sublime plugins
- [Basic tutorial from Sublime](https://docs.sublimetext.io/guide/extensibility/plugins/)
- [Another tutorial](https://betterprogramming.pub/how-to-create-your-own-sublime-text-plugin-2731e75f52d5)
- [Google search results](https://www.google.com/search?q=how+to+write+a+sublime+plugin&oq=how+to+write+a+sublime+plugin&aqs=chrome..69i57j33i160j33i22i29i30l3.6346j0j7&sourceid=chrome&ie=UTF-8)
- [An example plugin](https://github.com/liangzr/WDMLMarkup/blob/master/encode_html_entities.py)
- [On creating keybindings to plugins](https://forum.sublimetext.com/t/how-to-create-key-binding-to-python-script/4589)

<a id="markdown"></a>
### Markdown
- [Sublime MarkdownEditing](MarkdownEditing)
- [Markdown Extended Syntax](https://www.markdownguide.org/extended-syntax)
- [How to add new line in markdown presentation](https://stackoverflow.com/questions/33191744/how-to-add-new-line-in-markdown-presentation)
- [How do I display local image in Markdown?](https://stackoverflow.com/questions/41604263/how-do-i-display-local-image-in-markdown)
- [How to link to headers](https://stackoverflow.com/questions/51221730/markdown-link-to-header)
- [How to reference a section in another file](https://stackoverflow.com/questions/51187658/markdown-reference-to-section-from-another-file)
- [How to highlight text in a Markdown document](https://stackoverflow.com/questions/25104738/text-highlight-in-markdown)
- [Get underlined text with Markdown](https://stackoverflow.com/questions/3003476/get-underlined-text-with-markdown)
- [Set up spellcheck for files with `.md` extension](https://stackoverflow.com/questions/28986782/sublime-text-spell-check-but-only-certain-file-extensions)
- [Quickly generate a TOC](https://stackoverflow.com/questions/11948245/markdown-to-create-pages-and-table-of-contents)
- [Markdown Preview Documentation](https://facelessuser.github.io/MarkdownPreview/usage/)
- [Add a collapsible header to Markdown](https://stackoverflow.com/questions/31562552/collapsible-header-in-markdown-to-html)
- [Changing the sizes of embedded images](https://stackoverflow.com/questions/14675913/changing-image-size-in-markdown)

<a id="html"></a>
### HTML
- [How to change font size](https://kb.iu.edu/d/abai)

<a id="slack"></a>
### Slack
- [fhbig.slack.com](https://fhbig.slack.com/)

<a id="shell-scripting"></a>
### Shell scripting
- [Scripting Tips for Bioinformatics](https://informatics.fas.harvard.edu/scripting-tips-for-bioinformatics.html)
- [Use bash to multiply floats](https://stackoverflow.com/questions/26003503/utilizing-bash-to-multiply-an-interger-by-a-float-with-an-if-statement)

<a id="yeast-genomics"></a>
### Yeast genomics
- [SGD Wiki](https://wiki.yeastgenome.org/index.php/Main_Page)

<a id="python"></a>
### Python
- [Set up Sublime to work with Python (including interactive mode)](https://www.youtube.com/watch?v=rIl0mmYSPIc)

<a id="slurm"></a>
### SLURM
- [Print the number of CPUs in use per job in SLURM](https://stackoverflow.com/questions/64928381/print-the-number-of-cpus-in-use-per-job-in-slurm)
    + The `squeue` command has two parameters that allow choosing the columns displayed in the output, `--format` and `--Format`
        * Each has an option (respectively `%c` and `NumCPUs`) to display the number of cores requested by the job
    + Try with `squeue -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R %c"`
        * This will show the default columns and add the number of cores as the last column
        * You can fiddle with the format string to arrange the columns as you want
        * Then, when you are happy with the output, you can set it as the value of the `SQUEUE_FORMAT` variable in your `.bash_profile` or `.bashrc`
        * e.g., `export SQUEUE_FORMAT='%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R %c'`
    + See the `squeue` man page for more details

<a id="fhcc-data-science"></a>
### FHCC Data Science
- [Information on computing environments and containers](https://sciwiki.fredhutch.org/scicomputing/compute_environments/)
- [Leave issues at this repo to install or change packages on the HPC](https://github.com/FredHutch/easybuild-life-sciences)
- [Using Singularity containers](https://sciwiki.fredhutch.org/compdemos/Singularity/)
- [Running workflows on Gizmo](https://sciwiki.fredhutch.org/hdc/workflows/running/on_gizmo/)
- [Background on workflows](https://sciwiki.fredhutch.org/hdc/workflows/workflow_background/)

<a id="singularity-docker"></a>
### `Singularity`, `Docker`
- [How to build a `Singularity` container from a `dockerfile`](https://stackoverflow.com/questions/60314664/how-to-build-singularity-container-from-dockerfile)

<a id="tmux"></a>
### Tmux
- [How to scroll in tmux](https://superuser.com/questions/209437/how-do-i-scroll-in-tmux)

<a id="awk"></a>
### Awk
- https://stackoverflow.com/questions/2961635/using-awk-to-print-all-columns-from-the-nth-to-the-last
- https://stackoverflow.com/questions/11312359/awk-printing-characters-between-fields
- https://stackoverflow.com/questions/10776679/how-to-split-string-on-forward-slash-in-bash
- 
