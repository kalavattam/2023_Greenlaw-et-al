#!/bin/bash
#DONTRUN

singularity run \
    --bind /loc/scratch \
    --bind $(pwd) \
    ~/singularity-docker-etc/Trinity.sif \
    	Trinity --version

# WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
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

