### 0. Set up an environment for gff3 processing
#### Get situated
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

tmux new -s install
tmux attach -t install
grabnode  # 1, defaults

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
```
</details>
<br />

#### Set up gff3_env
Need the following packages:

- https://anaconda.org/bioconda/agat
- https://anaconda.org/bioconda/gffcompare]
- https://anaconda.org/bioconda/subread (`featureCounts`)
- https://anaconda.org/bioconda/htseq (`htseq-count`)
- https://anaconda.org/bioconda/bioconductor-rtracklayer
- https://anaconda.org/bioconda/bioconductor-genomicranges
- https://anaconda.org/conda-forge/r-tidyverse

##### Code
<details>
<summary><i>Code: Set up gff3_env</i></summary>

```bash
#!/bin/bash

# conda config --add channels defaults
# conda config --add channels bioconda
# conda config --add channels conda-forge
# conda config --set channel_priority strict

mamba create -n gff3_env \
    -c bioconda \
    --yes \
        agat \
        gffcompare \
        subread \
        htseq \
        bioconductor-rtracklayer \
        bioconductor-genomicranges

source activate gff3_env

mamba install \
    -c conda-forge \
        markdown \
        r-markdown \
        r-tidyverse \
        bioconductor-rtracklayer==1.58.0
```
</details>
<br />

<details>
<summary><i>Printed: Set up gff3_env</i></summary>

```txt
❯ mamba create -n gff3_env \
>     -c bioconda \
>     --yes \
>         agat \
>         gffcompare \
>         subread \
>         htseq \
>         bioconductor-rtracklayer \
>         bioconductor-genomicranges

                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['agat', 'gffcompare', 'subread', 'htseq', 'bioconductor-rtracklayer', 'bioconductor-genomicranges']

bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
pkgs/main/linux-64                                            No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/gff3_env

  Updating specs:

   - agat
   - gffcompare
   - subread
   - htseq
   - bioconductor-rtracklayer
   - bioconductor-genomicranges


  Package                                   Version  Build                Channel                    Size
───────────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex                               0.1  conda_forge          conda-forge/linux-64     Cached
  + _openmp_mutex                               4.5  2_gnu                conda-forge/linux-64     Cached
  + _r-mutex                                  1.0.1  anacondar_1          conda-forge/noarch       Cached
  + agat                                      1.0.0  pl5321hdfd78af_0     bioconda/noarch           440kB
  + argcomplete                               3.0.5  pyhd8ed1ab_0         conda-forge/noarch         38kB
  + binutils_impl_linux-64                     2.40  hf600244_0           conda-forge/linux-64     Cached
  + bioconductor-biobase                     2.58.0  r42hc0cfd56_0        bioconda/linux-64           2MB
  + bioconductor-biocgenerics                0.44.0  r42hdfd78af_0        bioconda/noarch           665kB
  + bioconductor-biocio                       1.8.0  r42hdfd78af_0        bioconda/noarch           429kB
  + bioconductor-biocparallel                1.32.5  r42hc247a5b_0        bioconda/linux-64           2MB
  + bioconductor-biostrings                  2.66.0  r42hc0cfd56_0        bioconda/linux-64          14MB
  + bioconductor-data-packages             20230202  hdfd78af_0           bioconda/noarch           144kB
  + bioconductor-delayedarray                0.24.0  r42hc0cfd56_0        bioconda/linux-64           2MB
  + bioconductor-genomeinfodb                1.34.8  r42hdfd78af_0        bioconda/noarch             4MB
  + bioconductor-genomeinfodbdata             1.2.9  r42hdfd78af_0        bioconda/noarch             8kB
  + bioconductor-genomicalignments           1.34.0  r42hc0cfd56_0        bioconda/linux-64           2MB
  + bioconductor-genomicranges               1.50.0  r42hc0cfd56_0        bioconda/linux-64           2MB
  + bioconductor-iranges                     2.32.0  r42hc0cfd56_0        bioconda/linux-64           3MB
  + bioconductor-matrixgenerics              1.10.0  r42hdfd78af_0        bioconda/noarch           353kB
  + bioconductor-rhtslib                      2.0.0  r42hc0cfd56_0        bioconda/linux-64           2MB
  + bioconductor-rsamtools                   2.14.0  r42hc247a5b_0        bioconda/linux-64           4MB
  + bioconductor-rtracklayer                 1.58.0  r42h171f361_1        bioconda/linux-64           6MB
  + bioconductor-s4vectors                   0.36.0  r42hc0cfd56_0        bioconda/linux-64           2MB
  + bioconductor-summarizedexperiment        1.28.0  r42hdfd78af_0        bioconda/noarch             3MB
  + bioconductor-xvector                     0.38.0  r42hc0cfd56_0        bioconda/linux-64         738kB
  + bioconductor-zlibbioc                    1.44.0  r42hc0cfd56_0        bioconda/linux-64          74kB
  + brotli                                    1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + brotli-bin                                1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + bwidget                                  1.9.14  ha770c72_1           conda-forge/linux-64     Cached
  + bzip2                                     1.0.8  h7f98852_4           conda-forge/linux-64     Cached
  + c-ares                                   1.18.1  h7f98852_0           conda-forge/linux-64     Cached
  + ca-certificates                       2022.12.7  ha878542_0           conda-forge/linux-64     Cached
  + cairo                                    1.16.0  ha61ee94_1014        conda-forge/linux-64     Cached
  + certifi                               2022.12.7  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + contourpy                                 1.0.7  py310hdf3cbec_0      conda-forge/linux-64      216kB
  + curl                                     7.87.0  h6312ad2_0           conda-forge/linux-64     Cached
  + cycler                                   0.11.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + expat                                     2.5.0  h27087fc_0           conda-forge/linux-64     Cached
  + font-ttf-dejavu-sans-mono                  2.37  hab24e00_0           conda-forge/noarch       Cached
  + font-ttf-inconsolata                      3.000  h77eed37_0           conda-forge/noarch       Cached
  + font-ttf-source-code-pro                  2.038  h77eed37_0           conda-forge/noarch       Cached
  + font-ttf-ubuntu                            0.83  hab24e00_0           conda-forge/noarch       Cached
  + fontconfig                               2.14.2  h14ed4e7_0           conda-forge/linux-64     Cached
  + fonts-conda-ecosystem                         1  0                    conda-forge/noarch       Cached
  + fonts-conda-forge                             1  0                    conda-forge/noarch       Cached
  + fonttools                                4.39.2  py310h1fa729e_0      conda-forge/linux-64        2MB
  + freetype                                 2.12.1  hca18f0e_1           conda-forge/linux-64     Cached
  + fribidi                                  1.0.10  h36c2ea0_0           conda-forge/linux-64     Cached
  + gcc_impl_linux-64                        12.2.0  hcc96c02_19          conda-forge/linux-64     Cached
  + gettext                                  0.21.1  h27087fc_0           conda-forge/linux-64     Cached
  + gffcompare                               0.12.6  h9f5acd7_0           bioconda/linux-64         178kB
  + gfortran_impl_linux-64                   12.2.0  h55be85b_19          conda-forge/linux-64     Cached
  + graphite2                                1.3.13  h58526e2_1001        conda-forge/linux-64     Cached
  + gsl                                         2.7  he838d99_0           conda-forge/linux-64     Cached
  + gxx_impl_linux-64                        12.2.0  hcc96c02_19          conda-forge/linux-64     Cached
  + harfbuzz                                  6.0.0  h8e241bc_0           conda-forge/linux-64     Cached
  + htseq                                     2.0.2  py310ha14a713_0      bioconda/linux-64         392kB
  + icu                                        70.1  h27087fc_0           conda-forge/linux-64     Cached
  + jpeg                                         9e  h0b41bf4_3           conda-forge/linux-64     Cached
  + jq                                          1.5  0                    bioconda/linux-64           1MB
  + kernel-headers_linux-64                  2.6.32  he073ed8_15          conda-forge/noarch       Cached
  + keyutils                                  1.6.1  h166bdaf_0           conda-forge/linux-64     Cached
  + kiwisolver                                1.4.4  py310hbf28c38_1      conda-forge/linux-64       77kB
  + krb5                                     1.20.1  hf9c8cef_0           conda-forge/linux-64     Cached
  + lcms2                                      2.14  h6ed2654_0           conda-forge/linux-64     Cached
  + ld_impl_linux-64                           2.40  h41732ed_0           conda-forge/linux-64     Cached
  + lerc                                      4.0.0  h27087fc_0           conda-forge/linux-64     Cached
  + libblas                                   3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libbrotlicommon                           1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + libbrotlidec                              1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + libbrotlienc                              1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + libcblas                                  3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libcurl                                  7.87.0  h6312ad2_0           conda-forge/linux-64     Cached
  + libdb                                    6.1.26  0                    bioconda/linux-64          23MB
  + libdeflate                                 1.13  h166bdaf_0           conda-forge/linux-64     Cached
  + libedit                            3.1.20191231  he28a2e2_2           conda-forge/linux-64     Cached
  + libev                                      4.33  h516909a_1           conda-forge/linux-64     Cached
  + libffi                                    3.4.2  h7f98852_5           conda-forge/linux-64     Cached
  + libgcc                                    7.2.0  h69d50b8_2           conda-forge/linux-64     Cached
  + libgcc-devel_linux-64                    12.2.0  h3b97bd3_19          conda-forge/linux-64     Cached
  + libgcc-ng                                12.2.0  h65d4601_19          conda-forge/linux-64     Cached
  + libgfortran-ng                           12.2.0  h69a702a_19          conda-forge/linux-64     Cached
  + libgfortran5                             12.2.0  h337968e_19          conda-forge/linux-64     Cached
  + libglib                                  2.74.1  h606061b_1           conda-forge/linux-64     Cached
  + libgomp                                  12.2.0  h65d4601_19          conda-forge/linux-64     Cached
  + libiconv                                   1.17  h166bdaf_0           conda-forge/linux-64     Cached
  + liblapack                                 3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libnghttp2                               1.51.0  hdcd2b5c_0           conda-forge/linux-64     Cached
  + libnsl                                    2.0.0  h7f98852_0           conda-forge/linux-64     Cached
  + libopenblas                              0.3.21  pthreads_h78a6416_3  conda-forge/linux-64     Cached
  + libpng                                   1.6.39  h753d276_0           conda-forge/linux-64     Cached
  + libsanitizer                             12.2.0  h46fd767_19          conda-forge/linux-64     Cached
  + libsqlite                                3.40.0  h753d276_0           conda-forge/linux-64     Cached
  + libssh2                                  1.10.0  haa6b8db_3           conda-forge/linux-64     Cached
  + libstdcxx-devel_linux-64                 12.2.0  h3b97bd3_19          conda-forge/linux-64     Cached
  + libstdcxx-ng                             12.2.0  h46fd767_19          conda-forge/linux-64     Cached
  + libtiff                                   4.4.0  h0e0dad5_3           conda-forge/linux-64     Cached
  + libuuid                                  2.32.1  h7f98852_1000        conda-forge/linux-64     Cached
  + libwebp-base                              1.3.0  h0b41bf4_0           conda-forge/linux-64     Cached
  + libxcb                                     1.13  h7f98852_1004        conda-forge/linux-64     Cached
  + libxml2                                  2.10.3  hca2bb57_4           conda-forge/linux-64      714kB
  + libzlib                                  1.2.13  h166bdaf_4           conda-forge/linux-64     Cached
  + make                                        4.3  hd18ef5c_1           conda-forge/linux-64     Cached
  + matplotlib-base                           3.7.1  py310he60537e_0      conda-forge/linux-64        7MB
  + munkres                                   1.0.7  py_1                 bioconda/noarch          Cached
  + ncurses                                     6.3  h27087fc_1           conda-forge/linux-64     Cached
  + numpy                                    1.24.2  py310h8deb116_0      conda-forge/linux-64        7MB
  + openjpeg                                  2.5.0  h7d73246_1           conda-forge/linux-64     Cached
  + openssl                                  1.1.1t  h0b41bf4_0           conda-forge/linux-64     Cached
  + packaging                                  23.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pango                                   1.50.14  hd33c08f_0           conda-forge/linux-64      438kB
  + pcre2                                     10.40  hc3806b6_0           conda-forge/linux-64     Cached
  + perl                                     5.32.1  2_h7f98852_perl5     conda-forge/linux-64     Cached
  + perl-apache-test                           1.43  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-app-cpanminus                       1.7046  pl5321hd8ed1ab_0     conda-forge/noarch       Cached
  + perl-b-cow                                0.007  pl5321h166bdaf_0     conda-forge/linux-64       20kB
  + perl-base                                  2.23  pl5321hdfd78af_2     bioconda/noarch          Cached
  + perl-bioperl-core                         1.7.8  pl5321h9ee0642_0     bioconda/linux-64           2MB
  + perl-business-isbn                        3.007  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-business-isbn-data            20210112.006  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-carp                                  1.38  pl5321hdfd78af_4     bioconda/noarch          Cached
  + perl-class-inspector                       1.36  pl5321hdfd78af_0     bioconda/noarch            16kB
  + perl-class-load                            0.25  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-class-load-xs                         0.10  pl5321h9f5acd7_6     bioconda/linux-64        Cached
  + perl-class-methodmaker                     2.24  pl5321hec16e2b_3     bioconda/linux-64         293kB
  + perl-clone                                 0.46  pl5321hec16e2b_0     bioconda/linux-64          16kB
  + perl-compress-raw-zlib                    2.105  pl5321h87f3376_0     bioconda/linux-64        Cached
  + perl-constant                              1.33  pl5321hdfd78af_2     bioconda/noarch          Cached
  + perl-cpan-meta-check                      0.014  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-cpan-meta-requirements               2.140  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-data-dumper                          2.183  pl5321hec16e2b_1     bioconda/linux-64        Cached
  + perl-data-optlist                         0.113  pl5321ha770c72_0     conda-forge/linux-64     Cached
  + perl-devel-globaldestruction               0.14  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-devel-overloadinfo                   0.007  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-devel-stacktrace                      2.04  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-digest-hmac                           1.04  pl5321hdfd78af_0     bioconda/noarch            11kB
  + perl-digest-md5                            2.58  pl5321hec16e2b_1     bioconda/linux-64          20kB
  + perl-dist-checkconflicts                   0.11  pl5321hdfd78af_3     bioconda/noarch          Cached
  + perl-encode                                3.19  pl5321hec16e2b_1     bioconda/linux-64        Cached
  + perl-encode-locale                         1.05  pl5321hdfd78af_7     bioconda/noarch          Cached
  + perl-eval-closure                          0.14  pl5321h9f5acd7_6     bioconda/linux-64        Cached
  + perl-exporter                              5.72  pl5321hdfd78af_2     bioconda/noarch          Cached
  + perl-exporter-tiny                     1.002002  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-extutils-makemaker                    7.70  pl5321hd8ed1ab_0     conda-forge/noarch        157kB
  + perl-file-listing                          6.15  pl5321hdfd78af_0     bioconda/noarch            14kB
  + perl-file-share                            0.25  pl5321hdfd78af_3     bioconda/noarch            10kB
  + perl-file-sharedir                        1.118  pl5321hdfd78af_0     bioconda/noarch            16kB
  + perl-file-sharedir-install                 0.13  pl5321hdfd78af_1     bioconda/noarch            13kB
  + perl-file-spec                          3.48_01  pl5321hdfd78af_2     bioconda/noarch          Cached
  + perl-getopt-long                           2.54  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-graph                               0.9725  pl5321hdfd78af_0     bioconda/noarch            71kB
  + perl-heap                                  0.80  pl5321hdfd78af_1     bioconda/noarch            23kB
  + perl-html-parser                           3.80  pl5321h9f5acd7_0     bioconda/linux-64        Cached
  + perl-html-tagset                           3.20  pl5321hdfd78af_4     bioconda/noarch          Cached
  + perl-http-cookies                          6.10  pl5321hdfd78af_0     bioconda/noarch            22kB
  + perl-http-daemon                           6.15  pl5321hdfd78af_0     bioconda/noarch            22kB
  + perl-http-date                             6.05  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-http-message                          6.36  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-http-negotiate                        6.01  pl5321hdfd78af_4     bioconda/noarch            15kB
  + perl-io-html                              1.004  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-io-socket-ssl                        2.074  pl5321hdfd78af_0     bioconda/noarch           166kB
  + perl-libwww-perl                           6.39  pl5321hdfd78af_1     bioconda/noarch            98kB
  + perl-list-moreutils                       0.430  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-list-moreutils-xs                    0.430  pl5321hec16e2b_1     bioconda/linux-64        Cached
  + perl-lwp-mediatypes                        6.04  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-lwp-protocol-https                    6.10  pl5321hdfd78af_0     bioconda/noarch            11kB
  + perl-lwp-simple                            6.39  pl5321h9ee0642_5     bioconda/linux-64           6kB
  + perl-mime-base64                           3.16  pl5321hec16e2b_2     bioconda/linux-64        Cached
  + perl-module-implementation                 0.09  pl5321hdfd78af_3     bioconda/noarch          Cached
  + perl-module-metadata                   1.000037  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-module-runtime                       0.016  pl5321hdfd78af_2     bioconda/noarch          Cached
  + perl-module-runtime-conflicts             0.003  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-moose                               2.2202  pl5321hec16e2b_0     bioconda/linux-64        Cached
  + perl-mozilla-ca                        20211001  pl5321hdfd78af_0     bioconda/noarch           136kB
  + perl-mro-compat                            0.15  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-net-http                              6.22  pl5321hdfd78af_0     bioconda/noarch            22kB
  + perl-net-ssleay                            1.92  pl5321h0e0aaa8_1     bioconda/linux-64         309kB
  + perl-ntlm                                  1.09  pl5321hdfd78af_5     bioconda/noarch            16kB
  + perl-package-deprecationmanager            0.17  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-package-stash                         0.40  pl5321h87f3376_1     bioconda/linux-64        Cached
  + perl-package-stash-xs                      0.30  pl5321h0b41bf4_0     conda-forge/linux-64     Cached
  + perl-params-util                          1.102  pl5321h9f5acd7_1     bioconda/linux-64        Cached
  + perl-parent                               0.236  pl5321hdfd78af_2     bioconda/noarch          Cached
  + perl-pathtools                             3.75  pl5321hec16e2b_3     bioconda/linux-64        Cached
  + perl-pod-escapes                           1.07  pl5321hdfd78af_2     bioconda/noarch            13kB
  + perl-safe                                  2.37  pl5321hdfd78af_2     bioconda/noarch             6kB
  + perl-scalar-list-utils                     1.62  pl5321hec16e2b_1     bioconda/linux-64        Cached
  + perl-set-object                            1.42  pl5321hec16e2b_1     bioconda/linux-64          41kB
  + perl-socket                               2.027  pl5321hec16e2b_3     bioconda/linux-64          34kB
  + perl-sort-naturally                        1.03  pl5321hdfd78af_3     bioconda/noarch            16kB
  + perl-storable                              3.15  pl5321hec16e2b_3     bioconda/linux-64        Cached
  + perl-sub-exporter                         0.988  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-sub-exporter-progressive          0.001013  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-sub-identify                          0.14  pl5321hec16e2b_2     bioconda/linux-64        Cached
  + perl-sub-install                          0.928  pl5321hdfd78af_3     bioconda/noarch          Cached
  + perl-sub-name                              0.21  pl5321hec16e2b_3     bioconda/linux-64        Cached
  + perl-term-progressbar                      2.22  pl5321hdfd78af_1     bioconda/noarch            22kB
  + perl-test                                  1.26  pl5321hdfd78af_2     bioconda/noarch            17kB
  + perl-test-fatal                           0.016  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-test-harness                          3.44  pl5321hdfd78af_0     bioconda/noarch            87kB
  + perl-test-requiresinternet                 0.05  pl5321hdfd78af_1     bioconda/noarch            10kB
  + perl-time-local                            1.30  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-timedate                              2.33  pl5321hdfd78af_2     bioconda/noarch          Cached
  + perl-try-tiny                              0.31  pl5321hdfd78af_1     bioconda/noarch          Cached
  + perl-uri                                   5.12  pl5321hdfd78af_0     bioconda/noarch          Cached
  + perl-url-encode                            0.03  pl5321h9ee0642_0     bioconda/linux-64        Cached
  + perl-version                             0.9924  pl5321hec16e2b_2     bioconda/linux-64        Cached
  + perl-www-robotrules                        6.02  pl5321hdfd78af_4     bioconda/noarch            15kB
  + perl-xsloader                              0.24  pl5321hd8ed1ab_0     conda-forge/noarch       Cached
  + perl-yaml                                  1.30  pl5321hdfd78af_0     bioconda/noarch          Cached
  + pillow                                    9.2.0  py310h454ad03_3      conda-forge/linux-64       47MB
  + pip                                      23.0.1  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pixman                                   0.40.0  h36c2ea0_0           conda-forge/linux-64     Cached
  + pthread-stubs                               0.4  h36c2ea0_1001        conda-forge/linux-64     Cached
  + pyparsing                                 3.0.9  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pysam                                    0.20.0  py310hff46b53_0      bioconda/linux-64           3MB
  + python                                   3.10.8  h257c98d_0_cpython   conda-forge/linux-64       23MB
  + python-dateutil                           2.8.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + python_abi                                 3.10  3_cp310              conda-forge/linux-64     Cached
  + pyyaml                                      6.0  py310h5764c6d_5      conda-forge/linux-64      176kB
  + r-base                                    4.2.2  h6b4767f_2           conda-forge/linux-64     Cached
  + r-bh                                   1.81.0_1  r42hc72bb7e_0        conda-forge/noarch         11MB
  + r-bitops                                  1.0_7  r42h06615bd_1        conda-forge/linux-64       46kB
  + r-codetools                              0.2_19  r42hc72bb7e_0        conda-forge/noarch        108kB
  + r-cpp11                                   0.4.3  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-crayon                                  1.5.2  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-formatr                                  1.14  r42hc72bb7e_0        conda-forge/noarch        165kB
  + r-futile.logger                           1.4.3  r42hc72bb7e_1004     conda-forge/noarch        111kB
  + r-futile.options                          1.0.1  r42hc72bb7e_1003     conda-forge/noarch         29kB
  + r-lambda.r                                1.2.4  r42hc72bb7e_2        conda-forge/noarch        124kB
  + r-lattice                               0.20_45  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-matrix                                  1.5_3  r42h5f7b363_0        conda-forge/linux-64     Cached
  + r-matrixstats                            0.63.0  r42h06615bd_0        conda-forge/linux-64      445kB
  + r-rcurl                               1.98_1.10  r42h133d619_0        conda-forge/linux-64      817kB
  + r-restfulr                               0.0.15  r42h73dbb54_1        bioconda/linux-64         400kB
  + r-rjson                                  0.2.21  r42h7525677_2        conda-forge/linux-64      166kB
  + r-snow                                    0.4_4  r42hc72bb7e_1        conda-forge/noarch        117kB
  + r-xml                                 3.99_0.14  r42hb43fdd4_0        conda-forge/linux-64        2MB
  + r-yaml                                    2.3.7  r42h133d619_0        conda-forge/linux-64     Cached
  + readline                                    8.2  h8228510_1           conda-forge/linux-64      281kB
  + sed                                         4.8  he412f7d_0           conda-forge/linux-64     Cached
  + setuptools                               67.6.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + six                                      1.16.0  pyh6c4a22f_0         conda-forge/noarch       Cached
  + subread                                   2.0.3  h7132678_1           bioconda/linux-64          25MB
  + sysroot_linux-64                           2.12  he073ed8_15          conda-forge/noarch       Cached
  + tk                                       8.6.12  h27826a3_0           conda-forge/linux-64     Cached
  + tktable                                    2.10  hb7b940f_3           conda-forge/linux-64     Cached
  + toml                                     0.10.2  pyhd8ed1ab_0         conda-forge/noarch         18kB
  + tzdata                                    2023b  h71feb2d_0           conda-forge/noarch        118kB
  + unicodedata2                             15.0.0  py310h5764c6d_0      conda-forge/linux-64      512kB
  + wheel                                    0.40.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + xmltodict                                0.13.0  pyhd8ed1ab_0         conda-forge/noarch         14kB
  + xorg-kbproto                              1.0.7  h7f98852_1002        conda-forge/linux-64     Cached
  + xorg-libice                              1.0.10  h7f98852_0           conda-forge/linux-64     Cached
  + xorg-libsm                                1.2.3  hd9c2040_1000        conda-forge/linux-64     Cached
  + xorg-libx11                               1.8.4  h0b41bf4_0           conda-forge/linux-64      830kB
  + xorg-libxau                               1.0.9  h7f98852_0           conda-forge/linux-64     Cached
  + xorg-libxdmcp                             1.1.3  h7f98852_0           conda-forge/linux-64     Cached
  + xorg-libxext                              1.3.4  h0b41bf4_2           conda-forge/linux-64       50kB
  + xorg-libxrender                          0.9.10  h7f98852_1003        conda-forge/linux-64     Cached
  + xorg-libxt                                1.2.1  h7f98852_2           conda-forge/linux-64     Cached
  + xorg-renderproto                         0.11.1  h7f98852_1002        conda-forge/linux-64     Cached
  + xorg-xextproto                            7.3.0  h0b41bf4_1003        conda-forge/linux-64       30kB
  + xorg-xproto                              7.0.31  h7f98852_1007        conda-forge/linux-64     Cached
  + xz                                        5.2.6  h166bdaf_0           conda-forge/linux-64     Cached
  + yaml                                      0.2.5  h7f98852_2           conda-forge/linux-64     Cached
  + yq                                        3.1.1  pyhd8ed1ab_0         conda-forge/noarch         23kB
  + zlib                                     1.2.13  h166bdaf_4           conda-forge/linux-64     Cached
  + zstd                                      1.5.2  h3eb15da_6           conda-forge/linux-64     Cached

  Summary:

  Install: 269 packages

  Total download: 213MB

───────────────────────────────────────────────────────────────────────────────────────────────────────────


readline                                           281.5kB @   3.6MB/s  0.1s
xorg-xextproto                                      30.3kB @ 296.5kB/s  0.1s
xorg-libx11                                        829.9kB @   8.1MB/s  0.1s
libxml2                                            713.9kB @   5.3MB/s  0.1s
perl-b-cow                                          19.8kB @  95.9kB/s  0.2s
perl-digest-md5                                     19.9kB @  95.9kB/s  0.1s
perl-socket                                         33.6kB @ 120.0kB/s  0.2s
perl-net-ssleay                                    308.8kB @   1.1MB/s  0.2s
perl-safe                                            5.9kB @  19.5kB/s  0.1s
perl-ntlm                                           16.5kB @  54.1kB/s  0.0s
perl-heap                                           22.7kB @  63.0kB/s  0.2s
perl-pod-escapes                                    13.2kB @  32.1kB/s  0.2s
r-rjson                                            166.1kB @ 335.5kB/s  0.1s
bioconductor-zlibbioc                               74.5kB @ 138.0kB/s  0.1s
r-formatr                                          165.2kB @ 276.5kB/s  0.1s
perl-file-listing                                   14.0kB @  22.0kB/s  0.4s
r-snow                                             117.0kB @ 179.3kB/s  0.1s
argcomplete                                         38.2kB @  42.1kB/s  0.3s
r-futile.logger                                    111.1kB @ 121.3kB/s  0.3s
perl-www-robotrules                                 14.7kB @  14.0kB/s  0.1s
perl-http-daemon                                    22.0kB @  20.8kB/s  0.1s
kiwisolver                                          77.4kB @  66.0kB/s  0.2s
pyyaml                                             176.3kB @ 146.3kB/s  0.2s
bioconductor-biocparallel                            1.7MB @   1.2MB/s  0.3s
pysam                                                2.7MB @   1.7MB/s  0.5s
bioconductor-xvector                               737.8kB @ 449.9kB/s  0.2s
r-bh                                                11.4MB @   6.7MB/s  1.1s
perl-libwww-perl                                    97.8kB @  58.1kB/s  0.1s
python                                              23.2MB @  13.4MB/s  1.5s
bioconductor-biocio                                429.4kB @ 231.9kB/s  0.3s
perl-lwp-simple                                      6.2kB @   3.3kB/s  0.2s
agat                                               440.2kB @ 233.5kB/s  0.1s
bioconductor-genomeinfodb                            4.3MB @   2.2MB/s  0.3s
perl-extutils-makemaker                            157.3kB @  77.2kB/s  0.2s
gffcompare                                         178.0kB @  86.9kB/s  0.2s
libdb                                               22.5MB @  10.8MB/s  2.1s
perl-mozilla-ca                                    135.8kB @  65.0kB/s  0.2s
perl-sort-naturally                                 16.1kB @   7.7kB/s  0.2s
perl-digest-hmac                                    10.7kB @   4.8kB/s  0.2s
perl-file-sharedir                                  16.1kB @   7.1kB/s  0.2s
perl-file-sharedir-install                          12.8kB @   5.6kB/s  0.2s
perl-file-share                                      9.9kB @   4.4kB/s  0.2s
r-codetools                                        108.1kB @  47.2kB/s  0.0s
r-futile.options                                    28.8kB @  12.5kB/s  0.0s
jq                                                   1.2MB @ 509.5kB/s  0.4s
bioconductor-rhtslib                                 2.4MB @   1.1MB/s  0.2s
perl-class-methodmaker                             293.3kB @ 118.9kB/s  0.3s
contourpy                                          215.7kB @  86.6kB/s  0.2s
htseq                                              391.7kB @ 156.2kB/s  0.2s
bioconductor-s4vectors                               2.3MB @ 832.3kB/s  0.5s
yq                                                  22.6kB @   8.2kB/s  0.3s
bioconductor-data-packages                         144.5kB @  52.2kB/s  0.3s
perl-lwp-protocol-https                             11.4kB @   4.1kB/s  0.3s
numpy                                                6.7MB @   2.4MB/s  0.6s
tzdata                                             117.7kB @  40.5kB/s  0.3s
perl-set-object                                     40.7kB @  13.9kB/s  0.3s
r-bitops                                            45.7kB @  14.8kB/s  0.3s
r-matrixstats                                      444.8kB @ 144.2kB/s  0.4s
bioconductor-genomicalignments                       2.4MB @ 743.8kB/s  0.6s
r-xml                                                1.7MB @ 518.5kB/s  0.4s
bioconductor-biocgenerics                          664.5kB @ 198.5kB/s  0.3s
bioconductor-matrixgenerics                        352.7kB @ 105.3kB/s  0.3s
unicodedata2                                       512.2kB @ 149.1kB/s  0.3s
bioconductor-rtracklayer                             5.6MB @   1.5MB/s  0.9s
fonttools                                            2.1MB @ 578.7kB/s  0.5s
perl-bioperl-core                                    1.9MB @ 446.4kB/s  0.7s
perl-io-socket-ssl                                 166.0kB @  39.1kB/s  0.5s
bioconductor-rsamtools                               4.1MB @ 940.4kB/s  0.8s
pango                                              437.6kB @  98.4kB/s  0.3s
matplotlib-base                                      6.8MB @   1.5MB/s  1.2s
r-rcurl                                            817.2kB @ 177.0kB/s  0.5s
xmltodict                                           13.6kB @   2.9kB/s  0.3s
perl-term-progressbar                               21.6kB @   4.7kB/s  0.3s
bioconductor-biobase                                 2.5MB @ 515.0kB/s  0.5s
bioconductor-genomeinfodbdata                        7.9kB @   1.6kB/s  0.3s
bioconductor-genomicranges                           2.3MB @ 441.1kB/s  0.6s
perl-graph                                          71.4kB @  13.3kB/s  0.4s
r-lambda.r                                         123.9kB @  23.1kB/s  0.4s
r-restfulr                                         400.2kB @  69.3kB/s  0.6s
bioconductor-iranges                                 2.5MB @ 431.4kB/s  0.7s
bioconductor-delayedarray                            2.5MB @ 423.9kB/s  0.7s
perl-test-requiresinternet                           9.5kB @   1.5kB/s  0.3s
perl-test                                           17.1kB @   2.7kB/s  0.3s
toml                                                18.4kB @   3.0kB/s  0.3s
perl-test-harness                                   86.6kB @  13.4kB/s  0.2s
bioconductor-biostrings                             14.2MB @   2.2MB/s  1.8s
perl-clone                                          15.6kB @   2.4kB/s  0.3s
perl-class-inspector                                16.2kB @   2.5kB/s  0.3s
perl-net-http                                       21.5kB @   3.3kB/s  0.2s
xorg-libxext                                        50.1kB @   7.5kB/s  0.3s
perl-http-negotiate                                 14.7kB @   2.2kB/s  0.3s
perl-http-cookies                                   22.2kB @   3.2kB/s  0.6s
bioconductor-summarizedexperiment                    2.8MB @ 392.5kB/s  0.5s
pillow                                              47.5MB @   5.3MB/s  5.7s
subread                                             24.7MB @   2.7MB/s  2.5s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate gff3_env

To deactivate an active environment, use

     $ mamba deactivate


❯ source activate gff3_env


❯ mamba install \
>     -c conda-forge \
>         markdown \
>         r-markdown \
>         r-tidyverse \
>         bioconductor-rtracklayer==1.58.0

                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['markdown', 'r-markdown', 'r-tidyverse', 'bioconductor-rtracklayer==1.58.0']

conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
pkgs/main/linux-64                                            No change
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/gff3_env

  Updating specs:

   - markdown
   - r-markdown
   - r-tidyverse
   - bioconductor-rtracklayer==1.58.0
   - ca-certificates
   - certifi
   - openssl


  Package                Version  Build             Channel                    Size
─────────────────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────────────────

  + importlib-metadata     6.1.0  pyha770c72_0      conda-forge/noarch         25kB
  + markdown               3.4.3  pyhd8ed1ab_0      conda-forge/noarch         71kB
  + pandoc                 3.1.1  h32600fe_0        conda-forge/linux-64       27MB
  + r-askpass                1.1  r42h06615bd_3     conda-forge/linux-64     Cached
  + r-assertthat           0.2.1  r42hc72bb7e_3     conda-forge/noarch       Cached
  + r-backports            1.4.1  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-base64enc            0.1_3  r42h06615bd_1005  conda-forge/linux-64     Cached
  + r-bit                  4.0.5  r42h06615bd_0     conda-forge/linux-64     Cached
  + r-bit64                4.0.5  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-blob                 1.2.4  r42hc72bb7e_0     conda-forge/noarch         66kB
  + r-broom                1.0.4  r42hc72bb7e_0     conda-forge/noarch          2MB
  + r-bslib                0.4.2  r42hc72bb7e_0     conda-forge/noarch       Cached
  + r-cachem               1.0.7  r42h133d619_0     conda-forge/linux-64       75kB
  + r-callr                3.7.3  r42hc72bb7e_0     conda-forge/noarch       Cached
  + r-cellranger           1.1.0  r42hc72bb7e_1005  conda-forge/noarch       Cached
  + r-cli                  3.6.1  r42h38f115c_0     conda-forge/linux-64        1MB
  + r-clipr                0.8.0  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-colorspace           2.1_0  r42h133d619_0     conda-forge/linux-64     Cached
  + r-commonmark           1.9.0  r42h133d619_0     conda-forge/linux-64      136kB
  + r-curl                 4.3.3  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-data.table          1.14.8  r42h133d619_0     conda-forge/linux-64     Cached
  + r-dbi                  1.1.3  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-dbplyr               2.3.2  r42hc72bb7e_0     conda-forge/noarch          1MB
  + r-digest              0.6.31  r42h38f115c_0     conda-forge/linux-64     Cached
  + r-dplyr                1.1.1  r42h38f115c_0     conda-forge/linux-64        1MB
  + r-dtplyr               1.3.1  r42hc72bb7e_0     conda-forge/noarch        357kB
  + r-ellipsis             0.3.2  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-evaluate              0.20  r42hc72bb7e_0     conda-forge/noarch       Cached
  + r-fansi                1.0.4  r42h133d619_0     conda-forge/linux-64     Cached
  + r-farver               2.1.1  r42h7525677_1     conda-forge/linux-64     Cached
  + r-fastmap              1.1.1  r42h38f115c_0     conda-forge/linux-64       70kB
  + r-forcats              1.0.0  r42hc72bb7e_0     conda-forge/noarch       Cached
  + r-fs                   1.6.1  r42h38f115c_0     conda-forge/linux-64     Cached
  + r-gargle               1.3.0  r42h785f33e_0     conda-forge/noarch       Cached
  + r-generics             0.1.3  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-ggplot2              3.4.1  r42hc72bb7e_0     conda-forge/noarch       Cached
  + r-glue                 1.6.2  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-googledrive          2.1.0  r42hc72bb7e_0     conda-forge/noarch          1MB
  + r-googlesheets4        1.1.0  r42h785f33e_0     conda-forge/noarch        508kB
  + r-gtable               0.3.3  r42hc72bb7e_0     conda-forge/noarch        221kB
  + r-haven                2.5.2  r42h38f115c_0     conda-forge/linux-64      379kB
  + r-highr                 0.10  r42hc72bb7e_0     conda-forge/noarch       Cached
  + r-hms                  1.1.3  r42hc72bb7e_0     conda-forge/noarch        107kB
  + r-htmltools            0.5.5  r42h38f115c_0     conda-forge/linux-64      355kB
  + r-httr                 1.4.5  r42hc72bb7e_0     conda-forge/noarch        488kB
  + r-ids                  1.0.1  r42hc72bb7e_2     conda-forge/noarch       Cached
  + r-isoband              0.2.7  r42h38f115c_1     conda-forge/linux-64     Cached
  + r-jquerylib            0.1.4  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-jsonlite             1.8.4  r42h133d619_0     conda-forge/linux-64     Cached
  + r-knitr                 1.42  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-labeling             0.4.2  r42hc72bb7e_2     conda-forge/noarch       Cached
  + r-lifecycle            1.0.3  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-lubridate            1.9.2  r42h133d619_1     conda-forge/linux-64      970kB
  + r-magrittr             2.0.3  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-markdown               1.5  r42hc72bb7e_0     conda-forge/noarch        122kB
  + r-mass              7.3_58.3  r42h133d619_0     conda-forge/linux-64        1MB
  + r-memoise              2.0.1  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-mgcv                1.8_42  r42he1ae0d6_0     conda-forge/linux-64        3MB
  + r-mime                  0.12  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-modelr              0.1.11  r42hc72bb7e_0     conda-forge/noarch        221kB
  + r-munsell              0.5.0  r42hc72bb7e_1005  conda-forge/noarch       Cached
  + r-nlme               3.1_162  r42hac0b197_0     conda-forge/linux-64     Cached
  + r-openssl              2.0.5  r42hb1dc35e_0     conda-forge/linux-64      635kB
  + r-pillar               1.9.0  r42hc72bb7e_0     conda-forge/noarch        617kB
  + r-pkgconfig            2.0.3  r42hc72bb7e_2     conda-forge/noarch       Cached
  + r-prettyunits          1.1.1  r42hc72bb7e_2     conda-forge/noarch       Cached
  + r-processx             3.8.0  r42h06615bd_0     conda-forge/linux-64     Cached
  + r-progress             1.2.2  r42hc72bb7e_3     conda-forge/noarch       Cached
  + r-ps                   1.7.3  r42h133d619_0     conda-forge/linux-64      312kB
  + r-purrr                1.0.1  r42h133d619_0     conda-forge/linux-64     Cached
  + r-r6                   2.5.1  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-rappdirs             0.3.3  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-rcolorbrewer         1.1_3  r42h785f33e_1     conda-forge/noarch       Cached
  + r-rcpp                1.0.10  r42h38f115c_0     conda-forge/linux-64     Cached
  + r-readr                2.1.4  r42h38f115c_0     conda-forge/linux-64     Cached
  + r-readxl               1.4.2  r42h81ef4d7_0     conda-forge/linux-64     Cached
  + r-rematch              1.0.1  r42hc72bb7e_1005  conda-forge/noarch       Cached
  + r-rematch2             2.1.2  r42hc72bb7e_2     conda-forge/noarch       Cached
  + r-reprex               2.0.2  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-rlang                1.1.0  r42h38f115c_0     conda-forge/linux-64        2MB
  + r-rmarkdown             2.14  r42h6115d3f_0     pkgs/r/noarch               3MB
  + r-rstudioapi            0.14  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-rvest                1.0.3  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-sass                 0.4.5  r42h38f115c_0     conda-forge/linux-64     Cached
  + r-scales               1.2.1  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-selectr              0.4_2  r42hc72bb7e_2     conda-forge/noarch       Cached
  + r-stringi             1.7.12  r42h1ae9187_0     conda-forge/linux-64     Cached
  + r-stringr              1.5.0  r42h785f33e_0     conda-forge/noarch       Cached
  + r-sys                  3.4.1  r42h06615bd_0     conda-forge/linux-64     Cached
  + r-tibble               3.2.1  r42h133d619_1     conda-forge/linux-64      611kB
  + r-tidyr                1.3.0  r42h38f115c_0     conda-forge/linux-64     Cached
  + r-tidyselect           1.2.0  r42hc72bb7e_0     conda-forge/linux-64     Cached
  + r-tidyverse            1.3.2  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-timechange           0.2.0  r42h38f115c_0     conda-forge/linux-64     Cached
  + r-tinytex               0.44  r42hc72bb7e_0     conda-forge/noarch       Cached
  + r-tzdb                 0.3.0  r42h7525677_1     conda-forge/linux-64     Cached
  + r-utf8                 1.2.3  r42h133d619_0     conda-forge/linux-64     Cached
  + r-uuid                 1.1_0  r42h06615bd_1     conda-forge/linux-64     Cached
  + r-vctrs                0.6.1  r42h38f115c_0     conda-forge/linux-64        1MB
  + r-viridislite          0.4.1  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-vroom                1.6.1  r42h38f115c_0     conda-forge/linux-64     Cached
  + r-withr                2.5.0  r42hc72bb7e_1     conda-forge/noarch       Cached
  + r-xfun                  0.38  r42h38f115c_0     conda-forge/linux-64      419kB
  + r-xml2                 1.3.3  r42h044e5c7_2     conda-forge/linux-64     Cached
  + zipp                  3.15.0  pyhd8ed1ab_0      conda-forge/noarch       Cached

  Summary:

  Install: 105 packages

  Total download: 51MB

─────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
r-rlang                                              1.5MB @  20.3MB/s  0.1s
r-xfun                                             419.1kB @   4.7MB/s  0.1s
r-cli                                                1.3MB @  12.8MB/s  0.1s
r-htmltools                                        354.7kB @   3.2MB/s  0.0s
importlib-metadata                                  24.9kB @ 200.3kB/s  0.0s
markdown                                            70.9kB @ 563.9kB/s  0.1s
r-vctrs                                              1.2MB @   7.0MB/s  0.1s
r-hms                                              106.7kB @ 594.8kB/s  0.1s
r-tibble                                           610.7kB @   2.5MB/s  0.1s
r-dtplyr                                           357.4kB @   1.4MB/s  0.1s
r-dbplyr                                             1.1MB @   4.4MB/s  0.1s
r-commonmark                                       136.3kB @ 468.1kB/s  0.3s
r-fastmap                                           70.0kB @ 209.3kB/s  0.1s
r-cachem                                            74.5kB @ 179.4kB/s  0.2s
r-mgcv                                               3.2MB @   7.2MB/s  0.2s
r-pillar                                           617.4kB @   1.4MB/s  0.2s
r-googledrive                                        1.2MB @   2.1MB/s  0.2s
r-mass                                               1.1MB @   1.7MB/s  0.2s
r-haven                                            378.9kB @ 544.4kB/s  0.3s
r-blob                                              66.0kB @  85.2kB/s  0.1s
r-dplyr                                              1.4MB @   1.8MB/s  0.1s
r-ps                                               312.1kB @ 389.3kB/s  0.1s
r-googlesheets4                                    507.7kB @ 572.1kB/s  0.2s
r-openssl                                          635.3kB @ 668.8kB/s  0.2s
r-broom                                              1.8MB @   1.8MB/s  0.2s
r-modelr                                           220.6kB @ 219.3kB/s  0.2s
r-markdown                                         122.1kB @ 113.7kB/s  0.1s
r-gtable                                           221.3kB @ 196.7kB/s  0.1s
r-lubridate                                        969.6kB @ 860.2kB/s  0.1s
r-httr                                             488.0kB @ 427.2kB/s  0.1s
pandoc                                              27.5MB @  23.9MB/s  1.2s
r-rmarkdown                                          2.8MB @   2.4MB/s  0.8s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

#### Add appropriate shortcut to `.zaliases`
##### Code
<details>
<summary><i>Code: Add appropriate shortcut to .zaliases</i></summary>

```bash
#!/bin/bash

alias R-gff3="(
    source activate gff3_env
    open -na /Applications/RStudio.app
)"
```
</details>
<br />

#### Copy in files of interest
##### Code
<details>
<summary><i>Code: Copy in files...</i></summary>

```bash
#!/bin/bash

#  Already ----------------------------
p_gen="${HOME}/genomes"
p_gtf="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/infiles_gtf-gff3/already"

mkdir -p "${p_gtf}"

cp \
    "${p_gen}/combined_AG/gtf/combined_AG.gtf" \
    "${p_gtf}"

cp \
    "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL_20S.gff3" \
    "${p_gtf}"

cp \
    "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL.gff3" \
    "${p_gtf}"

cp \
    "${p_gen}/kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3" \
    "${p_gtf}"

cp \
    ., "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf" \
    "${p_gtf}"

cp \
    ., "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf" \
    "${p_gtf}"


#  Trinity-GG -------------------------
p_trinity="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_GMAP_rough-draft/Trinity-GG"
p_gtf="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/infiles_gtf-gff3"

cp -r "${p_trinity}" "${p_gtf}"
```
</details>
<br />

### 1. Run AGAT
#### Get situated
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

# tmux new -s install
# tmux attach -t install
grabnode  # 8, defaults

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate gff3_env
```
</details>
<br />

#### Make associated storage directory
##### Code
<details>
<summary><i>Code: Make associated storage directory</i></summary>

```bash
#!/bin/bash

mkdir -p outfiles_gtf-gff3/{already,Trinity-GG}
mkdir -p outfiles_gtf-gff3/Trinity-GG/{G_N,Q_N}
```
</details>
<br />

#### Create an array of relevant files
##### Code
<details>
<summary><i>Code: Create an array of relevant files</i></summary>

```bash
#!/bin/bash

unset stems
typeset -a stems
while IFS=" " read -r -d $'\0'; do
    stems+=( "${REPLY%.gff3}" )
done < <(\
        find . \
            -type f \
            -name "trinity*.gff3" \
            -print0 \
                | sort -z\
)
echo_test "${stems[@]}"
echo "${#stems[@]}"  # 12
```
</details>
<br />

#### Loop through array elements with agat_convert_sp_gff2gtf.pl
##### Code
<details>
<summary><i>Code: Loop through array elements with agat_convert_sp_gff2gtf.pl</i></summary>

```bash
#!/bin/bash

for i in "${stems[@]}"; do
    in="${i}.gff3"
    out="$(echo "${i}" | sed 's/infiles/outfiles/g' - )"
    echo "Running agat_convert_sp_gff2gtf.pl"
    echo "     in   ${in}"
    echo "    out  ${out}.gtf"
    echo ""
    
    agat_convert_sp_gff2gtf.pl \
        --gff "${in}" \
        -o "${out}.gtf" \
            > >(tee -a "${i}.stdout.txt") \
            2> >(tee -a "${i}.stderr.txt")
done
```
</details>
<br />

### 2. Run GffCompare
#### Loop through array elements with gffcompare
##### Code
<details>
<summary><i>Code: Loop through array elements with gffcompare</i></summary>

```bash
#!/bin/bash

for i in "${gff3s[@]}"; do
    gtf_in="${i%.gff3}.gtf"
    gtf_out="${i%.gff3}.collapsed.gtf"
    gffcompare -C "${gtf_in}" -o "${gtf_out}" \
        > >(tee -a "${gtf_out%.gtf}.stdout.txt") \
        2> >(tee -a "${gtf_out%.gtf}.stderr.txt")
done
```
</details>
<br />

### 3. Run featureCounts
#### Run featureCounts on bams in bams_renamed/ with combined_SC_KL.antisense.gff3
##### Code
<details>
<summary><i>Code: Loop through array elements with gffcompare</i></summary>

```bash
#!/bin/bash

for i in "${gff3s[@]}"; do
    
done
```
</details>
<br />