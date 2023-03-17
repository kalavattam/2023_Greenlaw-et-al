
`tutorial_Singularity.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Learning to use `Singularity` \(2022-1123\)](#learning-to-use-singularity-2022-1123)
    1. [Notes from FHCC Bioinformatics' *"Using `Singularity` Containers"*](#notes-from-fhcc-bioinformatics-using-singularity-containers)
    1. [Introduction](#introduction)
    1. [Using `Singularity`](#using-singularity)
    1. [Using Docker Containers with Singularity](#using-docker-containers-with-singularity)
        1. [Example: Convert and run latest `R` `Docker` container with `Singularity`](#example-convert-and-run-latest-r-docker-container-with-singularity)
    1. [Container Customization](#container-customization)
        1. [Example: Add `R` libraries to the base container](#example-add-r-libraries-to-the-base-container)
            1. [Build](#build)
            1. [Set up a Sylabs account](#set-up-a-sylabs-account)
            1. [*Try building again*](#try-building-again)
            1. [Verify](#verify)
    1. [Access to Storage](#access-to-storage)
        1. [Example: Bind Local File Systems](#example-bind-local-file-systems)
            1. [Create Mount Points](#create-mount-points)
            1. [Rebuild](#rebuild)
            1. [Run with Bind](#run-with-bind)
            1. [Verify](#verify-1)
    1. [The Build Environment](#the-build-environment)
        1. [The Image Cache](#the-image-cache)
        1. [Build Temporary Files](#build-temporary-files)
    1. [Related FHCC Bioinformatics links](#related-fhcc-bioinformatics-links)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="learning-to-use-singularity-2022-1123"></a>
## Learning to use `Singularity` (2022-1123)
...in order to use `Trinity` and `PASA`, etc.

<a id="notes-from-fhcc-bioinformatics-using-singularity-containers"></a>
### Notes from FHCC Bioinformatics' *"Using `Singularity` Containers"*
- [Link to FHCC Bioinformatics' *"Using `Singularity` Containers"*](https://sciwiki.fredhutch.org/compdemos/Singularity/)
- Below, notes from me are in *italicized text*

<a id="introduction"></a>
### Introduction
¶1  
...

¶2  
<mark>`Singularity` allows us to run containers&mdash;including `Docker` containers&mdash;on our shared systems.</mark> <mark>`Docker` requires a number of administrative privileges which makes it unusable in shared multi-user environments with networked storage. `Singularity` remedies these problems allowing individual, non-root, users to run containers.</mark>

¶3  
...


<a id="using-singularity"></a>
### Using `Singularity`
¶1  
`Singularity` is available on the `rhino` and `gizmo` compute hosts. Please use a `gizmo` node if your task will be computationally intensive. `Singularity` containers can be run interactively (via `grabnode`) and in batch processing.

¶2  
...  
```bash
#EXAMPLEFROMTUTORIAL
ml Singularity
```

¶3  
Use `ml spider` to see available versions *(e.g., `ml spider Singularity`)*. Sylabs provides a library of built images that can be used directly:
```bash
#EXAMPLEFROMTUTORIAL
singularity pull --arch amd64 library://sylabsed/examples/lolcow:latest
```

<details>
<summary><i>Code: Test it out</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

pwd
# /home/kalavatt

ml Singularity

singularity pull --arch amd64 library://sylabsed/examples/lolcow:latest
#  79.91 MiB / 79.91 MiB [============================================================================================================] 100.00% 702.84 KiB/s 1m56s
# WARNING: unable to verify container: lolcow_latest.sif
# WARNING: Skipping container verification

singularity run ./lolcow_latest.sif
# / A Tale of Two Cities LITE(tm)         \
# |                                       |
# | -- by Charles Dickens                 |
# |                                       |
# | A man in love with a girl who loves   |
# | another man who looks just            |
# |                                       |
# | like him has his head chopped off in  |
# | France because of a mean              |
# |                                       |
# | lady who knits.                       |
# |                                       |
# | Crime and Punishment LITE(tm)         |
# |                                       |
# | -- by Fyodor Dostoevski               |
# |                                       |
# | A man sends a nasty letter to a       |
# | pawnbroker, but later                 |
# |                                       |
# | feels guilty and apologizes.          |
# |                                       |
# | The Odyssey LITE(tm)                  |
# |                                       |
# | -- by Homer                           |
# |                                       |
# | After working late, a valiant warrior |
# \ gets lost on his way home.            /
#  ---------------------------------------
#         \   ^__^
#          \  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||

ls -lhaFG
# total 108M
# drwxr-x--- 17 kalavatt  800 Nov 23 07:45 ./
# drwxr-xr-x  5 root        0 Nov 23 07:43 ../
# -rw-rw----  1 kalavatt 4.0K Nov 21 12:33 .bash_aliases
# -rw-rw----  1 kalavatt 3.2K Nov 20 13:21 .bash_functions
# -rw-------  1 kalavatt 564K Nov 23 07:45 .bash_history
# -rw-rw----  1 kalavatt  308 Oct 20 11:18 .bash_profile
# -rw-rw----  1 kalavatt 6.0K Nov  7 15:05 .bashrc
# drwxrwx---  9 kalavatt 6.4K Oct  5 17:22 bbmap/
# drwx------  4 kalavatt   87 Oct 20 11:42 .cache/
# drwxr-x---  2 kalavatt   34 Oct 20 10:28 .conda/
# drwxrwx---  5 kalavatt   75 Oct 28 15:14 .config/
# drwxrwx---  3 kalavatt   23 Oct 20 11:42 Downloads/
# drwxrwx--- 10 kalavatt  335 Nov  7 13:14 genomes/
# -rw-rw----  1 kalavatt   88 Oct 21 14:04 .gitconfig
# drwx------  3 kalavatt   35 Oct 17 10:57 .gnupg/
# drwxrwx---  3 kalavatt   23 Nov  7 15:06 .java/
# drwx------  7 kalavatt  113 Nov  1 09:09 .local/
# -rwxr-x---  1 kalavatt  80M Nov 23 07:37 lolcow_latest.sif*
# drwxr-x--- 20 kalavatt  570 Nov 22 07:44 miniconda3/
# drwxr-x--- 15 kalavatt  524 Oct 20 09:57 .oh-my-bash/
# drwxrwx---  2 kalavatt   44 Nov  1 12:54 .oracle_jre_usage/
# -rw-r-----  1 kalavatt   17 Nov 17 08:49 .osh-update
# -rw-rw----  1 kalavatt  726 Nov  1 09:20 picardmetrics.conf
# -rw-r-----  1 kalavatt    0 Nov 23 07:35 .sdirs
# drwx------  3 kalavatt   23 Nov 23 07:35 .singularity/
# drwxrwx---  6 kalavatt  148 Nov  1 09:09 src/
# drwx------  2 kalavatt   62 Oct 20 13:03 .ssh/
# lrwxrwxrwx  1 root       37 Oct 17 10:44 tsukiyamalab -> /fh/fast/tsukiyama_t/grp/tsukiyamalab/
# -rw-------  1 kalavatt  46K Nov 22 14:54 .viminfo
# -rw-rw----  1 kalavatt  215 Oct 20 10:33 .wget-hsts
# -rw-------  1 kalavatt   50 Nov 17 15:27 .Xauthority

#NOTE lolcow_latest.sif is saved to "$(pwd)"
```
</details>
<br />

¶4  
The error about container verification is not necessarily critical&mdash;if you would like to do a bit-by-bit validation of the download, [additional steps](https://sylabs.io/guides/3.5/user-guide/signNverify.html) are required.

<a id="using-docker-containers-with-singularity"></a>
### Using Docker Containers with Singularity
¶1  
As indicated earlier, `Singularity` can run `Docker` container images. However, <mark>`Docker` container images must first be converted to be usable by `Singularity`</mark>.

¶2  
<mark>The conversion step is only necessary the first time you convert a `Docker` container to a `Singularity` container or when you want to update your Singularity container</mark> (e.g., to a newer version of a `Docker` container).

<a id="example-convert-and-run-latest-r-docker-container-with-singularity"></a>
#### Example: Convert and run latest `R` `Docker` container with `Singularity`
¶1  
...

<details>
<summary><i>Code: Try it out</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

pwd
# /home/kalavatt

ml Singularity

singularity build r-base-latest.sif docker://r-base
# INFO:    Starting build...
# WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
# WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
# Getting image source signatures
# Copying blob ebbe46658ae1 done
# Copying blob ae8780930e7e done
# Copying blob 48f11b798771 done
# Copying blob ced6bc7d0fb6 done
# Copying blob b6e2154a522a done
# Copying blob 36a417257f63 done
# Copying config 935885ce10 done
# Writing manifest to image destination
# Storing signatures
# 2022/11/23 07:47:41  info unpack layer: sha256:ebbe46658ae1eddd748e3222cbc9dd7109f9fd7f279a4b2f9d6a32d0a58b4c16
# 2022/11/23 07:47:42  info unpack layer: sha256:ae8780930e7e7b18116589a863916682a85c45bec3c738dab17f8740830988b5
# 2022/11/23 07:47:42  info unpack layer: sha256:48f11b798771daf119baa7f2f3d5b9c4363b0aec5d12e488fbb2e07a0cf0be79
# 2022/11/23 07:47:43  info unpack layer: sha256:ced6bc7d0fb644dbcbeecc374d4904ae5df8f303707c30aa60514e3d929fd644
# 2022/11/23 07:47:43  info unpack layer: sha256:b6e2154a522a29fd10fe63922ee826f4d42e1e474ad08bc2f8c71e811e7f0127
# 2022/11/23 07:47:43  info unpack layer: sha256:36a417257f633cd58de6c3b59ec8c55c5bb04296fa387da3daa9cc1cba037116
# INFO:    Creating SIF file...
# INFO:    Build complete: r-base-latest.sif

#NOTE It ran for 2-3 minutes before completing

singularity exec r-base-latest.sif R
# R version 4.2.2 (2022-10-31) -- "Innocent and Trusting"
# Copyright (C) 2022 The R Foundation for Statistical Computing
# Platform: x86_64-pc-linux-gnu (64-bit)
#
# R is free software and comes with ABSOLUTELY NO WARRANTY.
# You are welcome to redistribute it under certain conditions.
# Type 'license()' or 'licence()' for distribution details.
#
#   Natural language support but running in an English locale
#
# R is a collaborative project with many contributors.
# Type 'contributors()' for more information and
# 'citation()' on how to cite R or R packages in publications.
#
# Type 'demo()' for some demos, 'help()' for on-line help, or
# 'help.start()' for an HTML browser interface to help.
# Type 'q()' to quit R.
#
# >

getwd()
# [1] "/home/kalavatt"

quit()
# Save workspace image? [y/n/c]: n

if [[ -f test-script.R ]]; then rm test-script.R; fi
touch test-script.R
echo -e '#!/usr/bin Rscript \n' >> test-script.R
echo 'getwd()' >> test-script.R
echo 'list.files()' >> test-script.R
# vi test-script.R

singularity exec r-base-latest.sif Rscript test-script.R
# [1] "/home/kalavatt"
#  [1] "bbmap"              "Downloads"          "genomes"
#  [4] "lolcow_latest.sif"  "miniconda3"         "picardmetrics.conf"
#  [7] "r-base-latest.sif"  "src"                "test-script.R"
# [10] "tsukiyamalab"
if [[ -f test-script.R ]]; then rm test-script.R; fi
```
</details>
<br />

<a id="container-customization"></a>
### Container Customization
¶1  
Containers can be customized by using a base container image then <mark>adding desired changes via a "definition file" that has necessary steps for modifying the base container</mark>.

¶2  
Root access is typically required to build `Singularity` containers. <mark>Sylabs' remote builder provides an option to build your container in Sylabs' sandbox cloud infrastructure. Once the container finishes building, it will be automatically downloaded to your working directory where it can be run</mark>.

¶3  
To use the remote builder option in `Singularity` you need a Sylabs account and key. The steps to set up remote builder can be found [here](https://sylabs.io/guides/3.5/user-guide/endpoint.html).

¶4  
You will need to generate a new key every 30 days when using Sylabs' remote builder option.



<a id="example-add-r-libraries-to-the-base-container"></a>
#### Example: Add `R` libraries to the base container
¶1  
In this example, we are going to build a more complex `Singularity` container using the latest `R` `Docker` image. To the base container, we will add additional `R` modules using a `Singularity` definition file and then build using Sylabs’ tools.

¶2  
...

<details>
<summary><i>Code: Try it out</i></summary>

```bash
#!/bin/bash
#DONTRUN

# grabnode  # Lowest and default settings
#
# pwd
# # /home/kalavatt
#
# ml Singularity
#
# singularity build r-base-latest.sif docker://r-base

def="my.r.singularity.build.def"

if [[ -f "${def}" ]]; then rm "${def}"; fi
touch "${def}"

echo -e \
	'BootStrap: docker\nFrom: r-base\n' \
		>> "${def}"
echo -e \
	"%post\nR --no-echo -e 'install.packages(\"devtools\", repos=\"https://cloud.r-project.org/\")'" \
		>> "${def}"
# # vi "${def}"
# BootStrap: docker
# From: r-base
#
# %post
# R --no-echo -e 'install.packages("devtools", repos="https://cloud.r-project.org/")'
```
</details>
<br />

¶3  
This file indicates that `Docker` is used to build the container from a `Docker` image named `r-base`. The `%post` section defines the steps we want to take to modify that original container&mdash;in this case, using `R` to install the `devtools` packages.

¶4  
More information about `Singularity` definition files is available [here](https://sylabs.io/guides/3.6/user-guide/definition_files.html).

<a id="build"></a>
##### Build
¶5  
...
```bash
#CONTINUE
singularity build --remote my_r_container.sif my.r.singularity.build.def
# FATAL:   Unable to submit build job: no authentication token, log in with `singularity remote login`
```

<a id="set-up-a-sylabs-account"></a>
##### Set up a Sylabs account
The following is not part of the FHCC tutorial and is instead text and *my notes* on material at [this page](https://docs.sylabs.io/guides/3.5/user-guide/endpoint.html).
1. Go to: https://cloud.sylabs.io/
2. Click "Sign in to Sylabs" and follow the sign in steps.
	- Linked Sylabs to my [GitHub account](https://github.com/kalavattam)
	- Sylabs username is `kalavattam`
3. ~~Click on your login ID (same and updated button as the sign-in one).~~ Log in.
4. Select “Access Tokens” from the ~~drop down~~ menu.
5. Enter a name for your new access token, such as “test token”
    - Named it "`test-token`"
6. Click the "Create Access Token" button.
    - The following was printed to the [browser]()
7. Click "Copy Token to Clipboard" ~~from the "New API Token" page~~.
    - Also, downloaded the token to `~/Downloads/_Kris` as `sylabs-token_test-token.txt`
8. Run `singularity remote login` and [paste the access token at the prompt]().

```bash
#CONTINUE
singularity remote login  # Paste token at prompt 'API Key:'
# INFO:    Authenticating with default remote.
# Generate an API Key at https://cloud.sylabs.io/auth/tokens, and paste here:
# API Key:
# INFO:    API Key Verified!
```

<a id="try-building-again"></a>
##### *Try building again*

<details>
<summary><i>Code: Try building again</i></summary>

```bash
#CONTINUE
singularity build --remote my_r_container.sif my.r.singularity.build.def
#NOTE  Building took >10 minutes

# ...  # (A massive amount of text...)
# ERROR: dependencies ‘usethis’, ‘pkgdown’, ‘rcmdcheck’, ‘roxygen2’, ‘rversions’, ‘urlchecker’ are not available for package ‘devtools’
# * removing ‘/usr/local/lib/R/site-library/devtools’
#
# The downloaded source packages are in
# 	‘/tmp/Rtmp6SudoW/downloaded_packages’
# There were 17 warnings (use warnings() to see them)
# INFO:    Creating SIF file...
# INFO:    Build complete: /tmp/image-1862359741
# INFO:    Performing post-build operations
# INFO:    Generating SBOM for /tmp/image-1862359741
# INFO:    Adding SBOM to SIF
# INFO:    Calculating SIF image checksum
# INFO:    Uploading image to library...
# WARNING: Skipping container verification
# INFO:    Uploading 382403001 bytes
# INFO:    Image uploaded successfully.

#NOTE 1/3 Message was just hanging here, not providing a prompt and or exiting;
#NOTE 2/3 so, I input ^C after hitting ↵ once (besides making a newline,
#NOTE 3/3 nothing happened)

#  After inputting ^C, the following printed to terminal:
# Shutting down due to signal: interrupt
# INFO:    Build complete: my_r_container.sif
```
</details>
<br />

<a id="verify"></a>
##### Verify
¶1  
Launch the `R` editor on our new `Singularity` container with the following command: ... And then check all of the user installed `R` packages with the following command: ...

```bash
#CONTINUE
singularity exec my_r_container.sif R
# R version 4.2.2 (2022-10-31) -- "Innocent and Trusting"
# Copyright (C) 2022 The R Foundation for Statistical Computing
# Platform: x86_64-pc-linux-gnu (64-bit)
#
# R is free software and comes with ABSOLUTELY NO WARRANTY.
# You are welcome to redistribute it under certain conditions.
# Type 'license()' or 'licence()' for distribution details.
#
#   Natural language support but running in an English locale
#
# R is a collaborative project with many contributors.
# Type 'contributors()' for more information and
# 'citation()' on how to cite R or R packages in publications.
#
# Type 'demo()' for some demos, 'help()' for on-line help, or
# 'help.start()' for an HTML browser interface to help.
# Type 'q()' to quit R.
#
# >
```
```R
#CONTINUE
ip <- as.data.frame(installed.packages()[,c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
print(ip, row.names=FALSE)
```
<details>
<summary><i>The following was printed to terminal:</i></summary>

```txt
     Package Version
     askpass     1.1
   base64enc   0.1-3
        brew   1.0-8
        brio   1.1.3
       bslib   0.4.1
      cachem   1.0.6
       callr   3.7.3
         cli   3.4.1
       clipr   0.8.0
  commonmark   1.8.1
       cpp11   0.4.3
      crayon   1.5.2
        desc   1.4.2
     diffobj   0.3.5
      digest  0.6.30
     downlit   0.4.2
    ellipsis   0.3.2
    evaluate    0.18
       fansi   1.0.3
     fastmap   1.1.0
 fontawesome   0.4.0
          fs   1.5.2
    gitcreds   0.1.2
        glue   1.6.2
       highr     0.9
   htmltools   0.5.3
 htmlwidgets   1.5.4
      httpuv   1.6.6
         ini   0.3.1
   jquerylib   0.1.4
    jsonlite   1.8.3
       knitr    1.41
       later   1.3.0
   lifecycle   1.0.3
    magrittr   2.0.3
     memoise   2.0.1
        mime    0.12
      miniUI 0.1.1.1
      pillar   1.8.1
    pkgbuild   1.3.1
   pkgconfig   2.0.3
     pkgload   1.3.2
      praise   1.0.0
 prettyunits   1.1.1
    processx   3.8.0
     profvis   0.3.7
    promises 1.2.0.1
          ps   1.7.2
       purrr   0.3.5
          R6   2.5.1
    rappdirs   0.3.3
        Rcpp   1.0.9
    rematch2   2.1.2
     remotes   2.4.2
       rlang   1.0.6
   rmarkdown    2.18
   rprojroot   2.0.3
  rstudioapi    0.14
        sass   0.4.3
 sessioninfo   1.2.2
       shiny   1.7.3
 sourcetools   0.1.7
     stringi   1.7.8
     stringr   1.4.1
         sys   3.4.1
    testthat   3.1.5
      tibble   3.1.8
     tinytex    0.42
        utf8   1.2.2
       vctrs   0.5.1
       waldo   0.4.0
     whisker     0.4
       withr   2.5.0
        xfun    0.35
       xopen   1.0.0
      xtable   1.8-4
        yaml   2.3.6
         zip   2.2.2
      docopt   0.7.1
     littler  0.3.16
```
</details>

```R
#CONTINUE
quit()
# Save workspace image? [y/n/c]: n
```

¶2  
We can now see all of the newly installed `R` libraries. There are two `R` libraries in the base `R` `Docker` container&mdash;now you should see many more than that.

<a id="access-to-storage"></a>
### Access to Storage
¶1  
Storage on the host where you are running the container can be made available via a bind command into the container. Many local paths are bound into the container by default. For example, the current working directory and your home are available in the container by default.

¶2  
When I indicate "local path", I am including network paths mounted locally&mdash;so even though fast and scratch are not technically local to the host, they appear local.

¶3  
If you need access to other storage paths (e.g., `/fh/scratch`, `/fh/fast`) you will need to provide mount points (directories) in the container and explicitly bind paths to those mount points as part of running the container. Note that your HutchNet ID will need permissions to this storage, but root privileges are not necessary.

<a id="example-bind-local-file-systems"></a>
#### Example: Bind Local File Systems
¶4  
In this example, we'll make the biodata files maintained by `Shared Resources` available in our container on the path `/mnt/data`.

<a id="create-mount-points"></a>
##### Create Mount Points
¶5  
Modify the definition file we created earlier (`my.r.singularity.build.def`), adding a command to the `%post` section to create the directory where we will mount biodata:
```txt
BootStrap: docker
From: r-base

%post
R --no-echo -e 'install.packages("devtools", repos="https://cloud.r-project.org/")'
mkdir -p /mnt/data
```
```bash
#CONTINUE
ls -lhaFG my.r.singularity.build.def
# -rw-rw---- 1 kalavatt 122 Nov 23 08:14 my.r.singularity.build.def

echo "mkdir -p /mnt/data" >> my.r.singularity.build.def
vi my.r.singularity.build.def  # Looks the same as above
```
<a id="rebuild"></a>
##### Rebuild
¶6  
Rebuild the container as above:

```bash
#CONTINUE
singularity build --remote my_r_container.sif my.r.singularity.build.def
# Build target already exists. Do you want to overwrite? [N/y] y

# INFO:    Starting build...
# INFO:    Setting maximum build duration to 1h0m0s
# INFO:    Remote "cloud.sylabs.io" added.
# INFO:    Access Token Verified!
# INFO:    Token stored in /root/.singularity/remote.yaml
# INFO:    Remote "cloud.sylabs.io" now in use.
# INFO:    Starting build...
# Getting image source signatures
# Copying blob sha256:36a417257f633cd58de6c3b59ec8c55c5bb04296fa387da3daa9cc1cba037116
# Copying blob sha256:ebbe46658ae1eddd748e3222cbc9dd7109f9fd7f279a4b2f9d6a32d0a58b4c16
# Copying blob sha256:48f11b798771daf119baa7f2f3d5b9c4363b0aec5d12e488fbb2e07a0cf0be79
# Copying blob sha256:ced6bc7d0fb644dbcbeecc374d4904ae5df8f303707c30aa60514e3d929fd644
# Copying blob sha256:b6e2154a522a29fd10fe63922ee826f4d42e1e474ad08bc2f8c71e811e7f0127
# Copying blob sha256:ae8780930e7e7b18116589a863916682a85c45bec3c738dab17f8740830988b5
# Copying config sha256:935885ce101110cb4f94cbce7784d9536f3d26ff65e4017d141f6e0b80ede0f6
# Writing manifest to image destination
# Storing signatures
# 2022/11/23 17:20:21  info unpack layer: sha256:ebbe46658ae1eddd748e3222cbc9dd7109f9fd7f279a4b2f9d6a32d0a58b4c16
# 2022/11/23 17:20:24  info unpack layer: sha256:ae8780930e7e7b18116589a863916682a85c45bec3c738dab17f8740830988b5
# 2022/11/23 17:20:24  info unpack layer: sha256:48f11b798771daf119baa7f2f3d5b9c4363b0aec5d12e488fbb2e07a0cf0be79
# 2022/11/23 17:20:24  info unpack layer: sha256:ced6bc7d0fb644dbcbeecc374d4904ae5df8f303707c30aa60514e3d929fd644
# 2022/11/23 17:20:24  info unpack layer: sha256:b6e2154a522a29fd10fe63922ee826f4d42e1e474ad08bc2f8c71e811e7f0127
# 2022/11/23 17:20:24  info unpack layer: sha256:36a417257f633cd58de6c3b59ec8c55c5bb04296fa387da3daa9cc1cba037116
# INFO:    Running post scriptlet
# ...  # (Mountains of text printed to screen)
# ...  # (Text is mostly from compiling/gcc)
# ...
# ERROR: dependencies ‘usethis’, ‘pkgdown’, ‘rcmdcheck’, ‘roxygen2’, ‘rversions’, ‘urlchecker’ are not available for package ‘devtools’
# * removing ‘/usr/local/lib/R/site-library/devtools’
#
# The downloaded source packages are in
# 	‘/tmp/RtmpCkV9WN/downloaded_packages’
# There were 17 warnings (use warnings() to see them)
# + mkdir -p /mnt/data
# INFO:    Creating SIF file...
# INFO:    Build complete: /tmp/image-294748900
# INFO:    Performing post-build operations
# INFO:    Generating SBOM for /tmp/image-294748900
# INFO:    Adding SBOM to SIF
# INFO:    Calculating SIF image checksum
# INFO:    Uploading image to library...
# WARNING: Skipping container verification
# INFO:    Uploading 382403000 bytes
# INFO:    Image uploaded successfully.
# Shutting down due to signal: interrupt
#
#
#
# ^CINFO:    Build complete: my_r_container.sif
```

*After inputting `^C` and waiting several minutes, still no exit, so input `↵ ↵ ↵ ^C`; was still left waiting... It completed after some 10 minutes; seems you just have to wait*

<a id="run-with-bind"></a>
##### Run with Bind
Once the container has been rebuilt, we just need to run the container, adding additional instructions to bind the local path (on the host where you are running `Singularity`) to the directory we created.

There are two ways to bind these paths into the container&mdash;on the command line: `$ singularity exec --bind /shared/biodata:/mnt/data my_r_container.sif R`  
...or via environment variables:

```bash
#EXAMPLEFROMTUTORIAL
export SINGULARITY_BIND=/shared/biodata:/mnt/data
singularity exec my_r_container.sif R
```

<a id="verify-1"></a>
##### Verify
You can verify the bind of those paths with shell. Start a shell in the container and run:

```bash
#CONTINUE
export SINGULARITY_BIND=/shared/biodata:/mnt/data
singularity shell my_r_container.sif
#  Have a new kind of prompt now: Singularity> 

ls /mnt/data
# example_data  gmap-gsnap  humandb  microbiome  ncbi-blast  ngs	seq  tmp

t="/mnt/data"
ls -lhaFG $t
# total 0
# drwxr-xr-x 11 root  0 Sep 10 16:02 ./
# drwxr-xr-x  3 root 27 Nov 23 09:33 ../
# dr-xr-xr-x  2 root  0 Sep 10 16:02 example_data/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 gmap-gsnap/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 humandb/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 microbiome/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 ncbi-blast/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 ngs/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 reference/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 seq/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 tmp

cd $t/example_data
pwd
/mnt/data/example_data

ls -lhaFG
# total 160K
# drwxrwsr-x  4 59162  80 Apr 19  2021 ./
# drwxr-xr-x 11 root    0 Sep 10 16:02 ../
# drwxrwsr--  4 59162  46 Mar 18  2021 data/
# -rw-rw-r--  1 59162 264 Mar 18  2021 README.md
# drwxrwsr--  2 59162   0 Apr 19  2021 rna_seq_class/

#  Interesting...
exit
#  Loss of new prompt (Singularity> )

ls /mnt/data
# ls: cannot access '/mnt/data': No such file or directory

singularity shell my_r_container.sif
ls /mnt/data
# example_data  gmap-gsnap  humandb  microbiome  ncbi-blast  ngs	reference  seq	tmp

ls
# bbmap	   genomes	      miniconda3	  my.r.singularity.build.def  r-base-latest.sif  tsukiyamalab
# Downloads  lolcow_latest.sif  my_r_container.sif  picardmetrics.conf	      src

exit

echo $t
# 
#  Makes sense: variable 't' is not in the main shell; it was in the
#+ Singularity shell

singularity shell my_r_container.sif
t="/mnt/data"
cd $t
ls -lhaFG
total 32K
# drwxr-xr-x 11 root   0 Sep 10 16:02 ./
# drwxr-xr-x  3 root  27 Nov 23 09:33 ../
# drwxrwsr-x  4 59162 80 Apr 19  2021 example_data/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 gmap-gsnap/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 humandb/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 microbiome/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 ncbi-blast/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 ngs/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 reference/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 seq/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 tmp/

cd seq
# total 320K
# drwxrwsr-x  4 37019  48 Sep  8  2016 ./
# drwxr-xr-x 11 root    0 Sep 10 16:02 ../
# drwxrwsr-x  3 37019 23K Jul 12  2021 blastdb/
# drwxr-sr-x  3 37019  22 Feb  4  2016 Broad/

exit
```

<a id="the-build-environment"></a>
### The Build Environment
<a id="the-image-cache"></a>
#### The Image Cache
¶1  
Singularity caches data to speed future operations. By default, the cache is in your home directory in a directory named `.singularity`. This cache can be moved depending on your need&mdash;this can be controlled with the environment variable `SINGULARITY_CACHEDIR`.
```bash
#EXAMPLEFROMTUTORIAL
export SINGULARITY_CACHEDIR=${HOME}/.my_cachedir
singularity build my.r.singularity.build.def
```

¶2  
Note that you will need to set this environment variable every time you wish to use this cache path.

<a id="build-temporary-files"></a>
#### Build Temporary Files
¶1  
Two environment variables (and one command-line option) can be used to control where the build is done. This includes extraction of the various downloads and other build steps necessary to create the container.

¶2  
The command line option `--tmpdir` takes precedence over the environment variables:
```bash
#EXAMPLEFROMTUTORIAL
singularity build --tmpdir=${HOME}/tmp my.r.singularity.build.def
```

¶3  
<mark>The environment variables `SINGULARITY_TMPDIR` and `TMPDIR` are used if the command line option isn't set. `SINGULARITY_TMPDIR` takes precedence over `TMPDIR`</mark>.

IMPORTANT: If you set this build directory path to a location in the Scratch file system, you may encounter errors like "operation not permitted" when building the container. This file system does not support file operations used by some container builds (e.g., hard links and some attributes).

<a id="related-fhcc-bioinformatics-links"></a>
### Related FHCC Bioinformatics links
- [Using Docker at Fred Hutch](https://sciwiki.fredhutch.org/compdemos/Docker/)
	+ [On the SciComp Test Environment](https://sciwiki.fredhutch.org/compdemos/Docker/#on-the-scicomp-test-environment)
		* "You can deploy your own docker machine on the `Proxmox` virtual test environment in *ca* 60 sec using the `prox` command. This environment uses multiple large memory machines (16 cores, 384GB memory each) which are re-purposed previous generation `Rhino` class machines."
	+ [Using pre-made Docker images with application stacks](https://sciwiki.fredhutch.org/compdemos/Docker/#using-pre-made-docker-images-with-application-stacks)
	+ [Create your own Docker image and put your software inside](https://sciwiki.fredhutch.org/compdemos/Docker/#create-your-own-docker-image-and-put-your-software-inside)
- [General information about Docker and its use at FHCC](https://sciwiki.fredhutch.org/scicomputing/compute_environments/#docker-containers)
- [Building Software Containers (Hutch Data Core)](https://sciwiki.fredhutch.org/hdc/hdc_building_containers/)
