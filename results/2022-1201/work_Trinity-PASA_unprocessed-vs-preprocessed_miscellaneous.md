
# `work_Trinity-PASA_unprocessed-vs-preprocessed_miscellaneous.md`

<!-- MarkdownTOC -->

1. [Work from 2022-1207](#work-from-2022-1207)
	1. [Update `Trinity` `Docker` installation \(as handled by `Singularity`\)](#update-trinity-docker-installation-as-handled-by-singularity)
		1. [Initial attempt with `singularity pull`: Unsuccessful](#initial-attempt-with-singularity-pull-unsuccessful)
			1. [What is the current version of `Trinity`?](#what-is-the-current-version-of-trinity)
		1. [Attempt to update with `singularity build`: Successful](#attempt-to-update-with-singularity-build-successful)
			1. [Now, what is the current version of `Trinity`? `2.15.0`](#now-what-is-the-current-version-of-trinity-2150)
	1. [Attempt to resolve `perl: warning: Setting locale failed`: Unsuccessful](#attempt-to-resolve-perl-warning-setting-locale-failed-unsuccessful)
1. [Initial work from 2022-1201-1202](#initial-work-from-2022-1201-1202)

<!-- /MarkdownTOC -->
<br />

<a id="work-from-2022-1207"></a>
## Work from 2022-1207
<a id="update-trinity-docker-installation-as-handled-by-singularity"></a>
### Update `Trinity` `Docker` installation (as handled by `Singularity`)
<a id="initial-attempt-with-singularity-pull-unsuccessful"></a>
#### Initial attempt with `singularity pull`: Unsuccessful
```bash
#!/bin/bash
#DONTRUN #CONTINUE

ml Singularity

cd ~/singularity-docker-etc
pwd  # /home/kalavatt/singularity-docker-etc
.,
# total 4.5G
# drwxrwx---  3 kalavatt  227 Nov 23 12:35 ./
# drwxr-x--- 20 kalavatt  960 Dec  7 10:18 ../
# -rwxr-x---  1 kalavatt  80M Nov 23 07:37 lolcow_latest.sif*
# -rwxrwx---  1 kalavatt 365M Nov 23 09:48 my_r_container.sif*
# -rw-rw----  1 kalavatt  141 Nov 23 09:14 my.r.singularity.build.def
# drwxrwx---  2 kalavatt  110 Nov 23 11:51 PASA/
# -rwxr-x---  1 kalavatt 418M Nov 23 12:15 PASA.sif*
# -rwxr-x---  1 kalavatt 310M Nov 23 07:49 r-base-latest.sif*
# -rwxr-x---  1 kalavatt 2.5G Nov 23 12:35 Trinity.sif*

singularity pull --arch amd64 library://sylabsed/examples/lolcow:latest
# FATAL:   Image file already exists: "lolcow_latest.sif" - will not overwrite

#NOTE 1/2 Singularity can't be run on Rhino nodes; if you try to do so, you
#NOTE 2/2 get the error copied to the subsequent txt cell

singularity run ./lolcow_latest.sif
#  ________________________________________
# / It is easy to find fault, if one has   \
# | that disposition. There was once a man |
# | who, not being able to find any other  |
# | fault with his coal, complained that   |
# | there were too many prehistoric toads  |
# | in it.                                 |
# |                                        |
# | -- Mark Twain, "Pudd'nhead Wilson's    |
# \ Calendar"                              /
#  ----------------------------------------
#         \   ^__^
#          \  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||
```

Error fr/attempting to run `Singularity` on a `rhino` node
```txt
Singularity is not allowed on Rhino nodes as it may cause
stability problems.
Please run singularity via sbatch or run grabnode and request at least 4 cores.
```

<a id="what-is-the-current-version-of-trinity"></a>
##### What is the current version of `Trinity`?
If I run `Trinity.sif`, what version does it say the program is?
```bash
#!/bin/bash
#DONTRUN #CONTINUE

singularity shell Trinity.sif
#  Now, inside the container, where the CL prompt begins with "Singularity>"

pwd
# /home/kalavatt

which Trinity
# /usr/local/bin/Trinity

Trinity --version
# perl: warning: Setting locale failed.
# perl: warning: Please check that your locale settings:
# 	LANGUAGE = "en_US:",
# 	LC_ALL = (unset),
# 	LC_CTYPE = "en_US.UTF-8",
# 	LANG = "en_US.UTF-8"
#     are supported and installed on your system.
# perl: warning: Falling back to the standard locale ("C").
# Trinity version: Trinity-v2.14.0
# ** NOTE: Latest version of Trinity is Trinity-v2.15.0, and can be obtained at:
# 	https://github.com/trinityrnaseq/trinityrnaseq/releases
```

<a id="attempt-to-update-with-singularity-build-successful"></a>
#### Attempt to update with `singularity build`: Successful
- `singularity pull` did not work with `lolcow:latest`, but maybe that's because it does not need to be updated? 
- Anyway, go ahead and try to update `Trinity`, but use `singularity build` instead of `singularity pull`, which is in keeping with how one would update the container if using `docker` and not `singularity`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

singularity build Trinity.sif docker://trinityrnaseq/trinityrnaseq
# Build target already exists. Do you want to overwrite? [N/y] y
```

<details>
<summary><i>Messages printed to terminal from the call to singularity build</i></summary>

```txt
INFO:    Starting build...
Getting image source signatures
Copying blob eaead16dc43b done
Copying blob b9ce8acf07aa done
Copying blob f4d6a0dff05b done
Copying blob 2fc7d344512b done
Copying blob 165c23a8af11 done
Copying blob 05a6a82dccfc done
Copying blob e63c3daa921e done
Copying blob eed576ee1975 done
Copying blob cc02f0003f80 done
Copying blob ae705a27311c done
Copying blob c5b89da1d080 done
Copying blob e56e00fefb23 done
Copying blob ff5394cc38fd done
Copying blob 16d80274d5a5 done
Copying blob dce5b858b2f8 done
Copying blob 62d61a56e5b4 done
Copying blob 04a8210c5993 done
Copying blob 5b5b5b672a12 done
Copying blob a8cfb322034a done
Copying blob 355a687f4472 done
Copying blob ab56a1a07b27 done
Copying blob 442a52dcc4a8 done
Copying blob b8b16d9816ee done
Copying blob b2774999d455 done
Copying blob 832afdbe384d done
Copying blob a63ead56dad8 done
Copying blob df979e91fe48 done
Copying blob 053cc478afb9 done
Copying blob 937e1a38d6eb done
Copying blob 320a2951a89f done
Copying blob 9c229ab8fe48 done
Copying blob 46c7b04f9cc3 done
Copying blob 3dd3417628c9 done
Copying blob cf95a0a242fa done
Copying blob 5b7ace73427a done
Copying blob e4063d3a165f done
Copying blob 177adb613988 done
Copying blob b5c520afd5b1 done
Copying blob 4e72e75bcfd9 done
Copying blob afc4d5614b46 done
Copying blob 9dc3a85b1d81 done
Copying blob 5f6776a3da99 done
Copying blob ddd8f41a2f34 done
Copying blob 8a98dff63bd3 done
Copying blob 159675122a51 done
Copying blob be707f88e655 done
Copying blob e0e890bd7efb done
Copying blob 1a1f412485ce done
Copying blob 07fba2275c42 done
Copying blob a916db2a0331 done
Copying blob b32406748860 done
Copying config e7ead7ee51 done
Writing manifest to image destination
Storing signatures
2022/12/07 11:19:23  info unpack layer: sha256:eaead16dc43bb8811d4ff450935d607f9ba4baffda4fc110cc402fa43f601d83
2022/12/07 11:19:24  info unpack layer: sha256:b9ce8acf07aa452c31a55d832a34da8dafe7f76234decccdf2c56393d8964e32
2022/12/07 11:19:41  info unpack layer: sha256:f4d6a0dff05b1aefff2ab5ac5d93ded574f1ea665749547bd62d6ff6ad43ba32
2022/12/07 11:19:41  info unpack layer: sha256:2fc7d344512b273515051e9b0bb9fa599d6ec74a552b44cce632880c50df07b7
2022/12/07 11:19:41  info unpack layer: sha256:165c23a8af119a130c02d4350e69440d767eabcaeaa804237a3bb80d63665690
2022/12/07 11:19:41  info unpack layer: sha256:05a6a82dccfc630ff1e730113a607cde55cffdcce769f34b4ed96252aa9ad01a
2022/12/07 11:19:46  info unpack layer: sha256:e63c3daa921e687bcbdc8a040fcc426a9f0fae40ea3668248dfc8952481e3127
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/KernSmooth.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/MASS.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/Matrix.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/boot.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/class.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/cluster.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/codetools.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/foreign.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/lattice.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/mgcv.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/nlme.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/nnet.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/rpart.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/spatial.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:49  warn rootless{usr/local/src/R-4.2.0/src/library/Recommended/survival.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:50  warn rootless{usr/local/src/R-4.2.0/tests/Pkgs/pkgA} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/12/07 11:19:51  info unpack layer: sha256:eed576ee19753481a0593a1861c39f17f4f2516cc41ad6bf870a56bbc1ba9964
2022/12/07 11:19:51  info unpack layer: sha256:cc02f0003f80d81e8eb61c3b2272cb0f09a48c12ce0837b278fedfe9b0e0543e
2022/12/07 11:19:53  info unpack layer: sha256:ae705a27311c947fad1b6c34cdbca677c05fbefb8ab0db998795d1a50ed8a58a
2022/12/07 11:19:53  info unpack layer: sha256:c5b89da1d0805ad765d756c131a35dc7e80bbda033ddd380490f3f75be7ea532
2022/12/07 11:19:57  info unpack layer: sha256:e56e00fefb23fad94d22f016f6dab5b869b2b5feec9599b01fbedc4e577295a5
2022/12/07 11:19:57  info unpack layer: sha256:ff5394cc38fd3bf9b25529c368bf94e272a5c97e93a16f966ad3fd43b40d53ed
2022/12/07 11:19:57  info unpack layer: sha256:16d80274d5a52cd9a6bb914b51371b520526ecad67411be617ff9be417bdd5b2
2022/12/07 11:19:57  info unpack layer: sha256:dce5b858b2f89d3187cc4ac641d3d87b1985065f0d440c45bd33525ae5691cca
2022/12/07 11:19:57  info unpack layer: sha256:62d61a56e5b40148a3cbbf354c04336a1af5fcb84df96369c5d163977a6dda30
2022/12/07 11:19:57  info unpack layer: sha256:04a8210c59932cab2a156daedca5e57a630a4bab43d9ec5d165726dae70cfc9b
2022/12/07 11:19:59  info unpack layer: sha256:5b5b5b672a1204981f78a5f55efa6c218431e609c475e4cfe30eb23936c60584
2022/12/07 11:20:00  info unpack layer: sha256:a8cfb322034ade76c8aa168c5a301f7757d05ba7317f7ab1062fc6196f23c414
2022/12/07 11:20:00  info unpack layer: sha256:355a687f447237e441dfa7269ae166e7076683bb6cd6ebd97ad6918d72b18099
2022/12/07 11:20:00  info unpack layer: sha256:ab56a1a07b27a6a36bef6bc251f07cac7cb0798668147d3b48eebba8548ad046
2022/12/07 11:20:00  info unpack layer: sha256:442a52dcc4a8927ba91b3ad6523567184105dbe759bdf7fd3f2e663be3b4cd58
2022/12/07 11:20:00  info unpack layer: sha256:b8b16d9816ee46548d10ba9ad62327ace27fb560c849b39862981abb204b18f9
2022/12/07 11:20:00  info unpack layer: sha256:b2774999d4551e28c40f14f6fd989032ddbab66d1ac14ea2a4c7a039a5ba1c4e
2022/12/07 11:20:00  info unpack layer: sha256:832afdbe384d38ff24c05293808f7f4209517cf418cd8566cdb481cd70a0d437
2022/12/07 11:20:03  info unpack layer: sha256:a63ead56dad8d9fa1cc20a911b50d4945d3c8a5d01a8edc1a1de99d30a7e2300
2022/12/07 11:20:03  info unpack layer: sha256:df979e91fe487dcefa5a0f37348d94b26e1394083789fe4d170f51cdc0a8b8bb
2022/12/07 11:20:03  info unpack layer: sha256:053cc478afb9190f7251d19d8ee06265e6e9b54a2949d5622594f04f13d5a2a1
2022/12/07 11:20:04  info unpack layer: sha256:937e1a38d6eb73475fd33354f4c7ccecbbefb209293a4bbcedd239bd1c8d44ea
2022/12/07 11:20:06  info unpack layer: sha256:320a2951a89faeca0dccf3a5b5b2fd28a033dc504757b9734250764f9f5e8dd7
2022/12/07 11:20:07  info unpack layer: sha256:9c229ab8fe486850b3be7138b44f3f85d980ef2039128220c540a420a6dd8a08
2022/12/07 11:20:08  info unpack layer: sha256:46c7b04f9cc3e2ab87bd026d5250f75a109e22ff4b6d3ac29e99708e03374244
2022/12/07 11:20:08  info unpack layer: sha256:3dd3417628c9341a7316bc0511504b6dde6e7619f830292af36af842e044a368
2022/12/07 11:20:08  info unpack layer: sha256:cf95a0a242fa2b94634745633c6f8b311c7f0c41b32c59a0d545aa3bb003b22c
2022/12/07 11:20:09  info unpack layer: sha256:5b7ace73427a7d29fb1ea0adef59d6760cc0a2561945ec5096bfe425837be958
2022/12/07 11:20:09  info unpack layer: sha256:e4063d3a165fd76710e3e5b6077fd4b9d0b70abab1d8f611f91e99571e1689ba
2022/12/07 11:20:16  info unpack layer: sha256:177adb613988b2455f7c783af160237421c029fd7dd1aaba8fd25667ce33c5ad
2022/12/07 11:20:18  info unpack layer: sha256:b5c520afd5b1cb5328442da92b33bb1122f7f536705da2a7c23ae818f4a6325b
2022/12/07 11:20:19  info unpack layer: sha256:4e72e75bcfd92f11bf805e36aed1884501e79fd7ab5e93382b692c99b91a03ec
2022/12/07 11:20:19  info unpack layer: sha256:afc4d5614b46beb2b755fa91e2cd1754d9a6fe7d25b3bfabdb0ed2488064f69d
2022/12/07 11:20:21  info unpack layer: sha256:9dc3a85b1d81f6e688df8712a6f7f307363f22be816a3f793f362c70a951b17c
2022/12/07 11:20:23  info unpack layer: sha256:5f6776a3da99faead64e0645d0625e5f0903924dfd8a18635d691950bb963c30
2022/12/07 11:20:26  info unpack layer: sha256:ddd8f41a2f3418b198bd40ee741f20fe5939511389d658ab19cb668509da02aa
2022/12/07 11:20:26  info unpack layer: sha256:8a98dff63bd3a4ad02a522cf602c4b55b3f8cbcc7db9bb12cf0452acb2abfc6b
2022/12/07 11:20:27  info unpack layer: sha256:159675122a51d88da718f02935ee98e8025ab32614c54a2975358fbd4db0d95f
2022/12/07 11:20:33  info unpack layer: sha256:be707f88e65524b1d37eb5be067a24e4e98def376df9e15223d724aa52801084
2022/12/07 11:20:33  info unpack layer: sha256:e0e890bd7efb455d77714ee720054ce903b060d11fe6e677a3f85eb46758810d
2022/12/07 11:20:35  info unpack layer: sha256:1a1f412485ce43fdea38e9acd2e2d21b683946685f9464fa700883bc128f9036
2022/12/07 11:20:37  info unpack layer: sha256:07fba2275c42a938950996b721ebd514a5f6238a2a804ab88c32dccac80464e1
2022/12/07 11:20:38  info unpack layer: sha256:a916db2a03318b58f6e77249757570f5a505592fa435cffac9f677b0bcd9d6c6
2022/12/07 11:20:38  info unpack layer: sha256:b32406748860151555f7fa8e202d17a064c81f15f27f52c99ccefb1bb066d44d
INFO:    Creating SIF file...
INFO:    Build complete: Trinity.sif
```
</details>
<br />

<a id="now-what-is-the-current-version-of-trinity-2150"></a>
##### Now, what is the current version of `Trinity`? `2.15.0`
Now, check on the version `Trinity` in `Trinity.sif`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

singularity shell Trinity.sif

Singularity> Trinity --version
# perl: warning: Setting locale failed.
# perl: warning: Please check that your locale settings:
# 	LANGUAGE = "en_US:",
# 	LC_ALL = (unset),
# 	LC_CTYPE = "en_US.UTF-8",
# 	LANG = "en_US.UTF-8"
#     are supported and installed on your system.
# perl: warning: Falling back to the standard locale ("C").
# Trinity version: Trinity-v2.15.0
# -currently using the latest production release of Trinity.
```

<a id="attempt-to-resolve-perl-warning-setting-locale-failed-unsuccessful"></a>
### Attempt to resolve `perl: warning: Setting locale failed`: Unsuccessful
How to resolve "`perl: warning: Setting locale failed`"?
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Still in the Trinity.sif shell...
Singularity> cd /

Singularity> ls -lhaFG
# total 936K
# drwxr-xr-x    1 kalavatt   60 Dec  7 11:25 ./
# drwxr-xr-x    1 kalavatt   60 Dec  7 11:25 ../
# lrwxrwxrwx    1 root       27 Dec  7 11:20 .exec -> .singularity.d/actions/exec*
# lrwxrwxrwx    1 root       26 Dec  7 11:20 .run -> .singularity.d/actions/run*
# lrwxrwxrwx    1 root       28 Dec  7 11:20 .shell -> .singularity.d/actions/shell*
# drwxr-xr-x    5 root      127 Dec  7 11:20 .singularity.d/
# lrwxrwxrwx    1 root       27 Dec  7 11:20 .test -> .singularity.d/actions/test*
# lrwxrwxrwx    1 root        7 Oct 19 09:47 bin -> usr/bin/
# drwxr-xr-x    2 root        3 Apr 15  2020 boot/
# drwxr-xr-x   19 root     4.4K Nov 27 00:17 dev/
# lrwxrwxrwx    1 root       36 Dec  7 11:20 environment -> .singularity.d/env/90-environment.sh*
# drwxr-xr-x   55 root     1.9K Dec  3 05:46 etc/
# drwxr-xr-x    1 kalavatt   60 Dec  7 11:25 home/
# lrwxrwxrwx    1 root        7 Oct 19 09:47 lib -> usr/lib/
# lrwxrwxrwx    1 root        9 Oct 19 09:47 lib32 -> usr/lib32/
# lrwxrwxrwx    1 root        9 Oct 19 09:47 lib64 -> usr/lib64/
# lrwxrwxrwx    1 root       10 Oct 19 09:47 libx32 -> usr/libx32/
# drwxr-xr-x    2 root        3 Oct 19 09:47 media/
# drwxr-xr-x    2 root        3 Oct 19 09:47 mnt/
# drwxr-xr-x    2 root        3 Oct 19 09:47 opt/
# dr-xr-xr-x 1609 root        0 Nov 21 11:09 proc/
# drwx------    5 root      136 Dec  1 10:34 root/
# drwxr-xr-x    5 root       67 Oct 19 09:50 run/
# lrwxrwxrwx    1 root        8 Oct 19 09:47 sbin -> usr/sbin/
# lrwxrwxrwx    1 root       24 Dec  7 11:20 singularity -> .singularity.d/runscript*
# drwxr-xr-x    2 root        3 Oct 19 09:47 srv/
# dr-xr-xr-x   13 root        0 Dec  6 12:27 sys/
# drwxrwxrwt  199 root     932K Dec  7 11:26 tmp/
# drwxr-xr-x   14 root      241 Nov 30 06:37 usr/
# drwxr-xr-x   11 root      160 Oct 19 09:50 var/

Singularity> cat environment
# #!/bin/sh
# # Custom environment shell code should follow

# medium.com/@khushalbisht/how-to-fix-perl-warning-setting-locale-failed-a16a6dedc3dd
# touch test.txt
# echo "LANGUAGE=en_US.UTF-8" >> test.txt
# echo "LANG=en_US.UTF-8" >> test.txt
# echo "LC_ALL=en_US.UTF-8" >> test.txt
# echo "" >> test.txt
# cat test.txt
# # LANGUAGE=en_US.UTF-8
# # LANG=en_US.UTF-8
# # LC_ALL=en_US.UTF-8
# # 
# rm test.txt

#NOTE 1/2 If I try to do the above in the *.sif, the following messages are
#NOTE 2/2 printed to terminal
# Singularity> touch test.txt
# touch: cannot touch 'test.txt': Read-only file system
# Singularity> echo "LANGUAGE=en_US.UTF-8" >> test.txt
# bash: test.txt: Read-only file system
# Singularity> echo "LANG=en_US.UTF-8" >> test.txt
# bash: test.txt: Read-only file system
# Singularity> echo "LC_ALL=en_US.UTF-8" >> test.txt
# bash: test.txt: Read-only file system
# Singularity> echo "" >> test.txt
# bash: test.txt: Read-only file system
# Singularity> cat test.txt
# cat: test.txt: No such file or directory

#  The problem may not be solvable, or at least it'll take too long to figure
#+ it out now, so come back to it later
Singularity> exit
```
<br />
<br />

<a id="initial-work-from-2022-1201-1202"></a>
## Initial work from 2022-1201-1202

<details>
<summary><i>Initial work from 2022-1201-1202</i></summary>

Symlink or copy the files from `2022-1101/` necessary for running `Trinity`

a. Set up and `cd` into the directory for these experiments, `2022-1201/`
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

transcriptome

#  Coming from the previous results/ directory, 2022-1101/ to establish this
#+ new one: 2022-1201/
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction

if [[ -d ./results/2022-1201 ]]; then
    cd ./results/2022-1201/
else
    cd .. \
        && mkdir -p ./results/2022-1201/ \
        && cd ./results/2022-1201/
fi

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201
```

b. The following approach to run Trinity/PASA tests with data generated in `results/2022-1101/` was started but ultimately cut because of bugs and inconsistencies with the datasets that result from the rough-draft work of `results/2022-1101/`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Set up directories necessary for experiments (can trim this later)
mkdir -p data/{fastqs,bams}/{unprocessed,preprocessed}/{multi-hit-mode,rna-star}


#  Set up symlinks ------------------------------------------------------------
d_base="${HOME}/tsukiyamalab/kalavatt"
d_November="${d_base}/2022_transcriptome-construction/results/2022-1101"
d_December="${d_base}/2022_transcriptome-construction/results/2022-1201"


# -------------------------------------
#  Bam: unprocessed, multi-hit-mode ---
# -------------------------------------
d_N_unproc="${d_November}/exp_alignment_STAR_tags"
d_N_unproc_multi="${d_N_unproc}/multi-hit-mode/files_bams"
# ., "${d_N_unproc_multi}"

d_unproc="${d_December}/data/bams/unprocessed"
d_D_unproc_multi="${d_unproc}/multi-hit-mode"
# ., "${d_D_unproc_multi}"

ln -s \
	"${d_N_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam" \
	"${d_D_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"

ln -s \
	"${d_N_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai" \
	"${d_D_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai"
# ., "${d_D_unproc_multi}"


# -------------------------------------
#  Bam: preprocessed, multi-hit-mode --
# -------------------------------------
d_N_prepro="${d_November}/exp_preprocessing"
d_N_prepro_multi="${d_N_prepro}/04b_star-genome-guided"
# ., "${d_N_prepro_multi}"

d_D_prero="${d_December}/data/bams/preprocessed"
d_D_prepro_multi="${d_D_prero}/multi-hit-mode"
# ., "${d_D_prepro_multi}"

ln -s \
	"${d_N_prepro_multi}/5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.sc_all.bam" \
	"${d_D_prepro_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"

ln -s \
	"${d_N_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai" \
	"${d_D_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai"
# ., "${d_D_prepro_multi}"


# -------------------------------------
#  Bam: unprocessed, rna-star --------- ### Not going to use these files ###
# -------------------------------------
d_rna="${d_N_unproc}/rna-star/files_bams"
# ., "${d_rna}"

d_unproc_rna="${d_unproc}/rna-star"
# ., "${d_unproc_rna}"

ln -s \
	"${d_rna}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam" \
	"${d_unproc_rna}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"

ln -s \
	"${d_rna}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai" \
	"${d_unproc_rna}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai"
# ., "${d_unproc_rna}"

# -------------------------------------
#  Bam: preprocessed, rna-star -------- ### These files do not exist ###
# -------------------------------------
# d_prero_rna=


```

c. Observations, next steps when considering the above  
- `#NOTE` `#IMPORTANT` Somehow this missed my observations until now: for the `exp_alignment_STAR_tags/` experiments, I used `*_G1_*.fastq.gz`, and not `*_Q_*.fastq.gz` files...
- `#DONE` Let's take the alignment and un- and preprocessing anew, from the beginning...
	+ `results/2022-1201/work_generate-data_unprocessed.md`
	+ `results/2022-1201/work_generate-data_preprocessed.md`
	+ `results/2022-1201/work_generate-data_preprocessed-full.md`
</details>
