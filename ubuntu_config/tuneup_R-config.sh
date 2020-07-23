#!/bin/bash

### add mirror to accelerate download speed
### Alternative sites
##北京外国语大学镜像站（新）
#https://mirrors.bfsu.edu.cn/
##清华大学
#https://irrors.tuna.tsinghua.edu.cn


echo "options(BioC_mirror=\"https://mirrors.tuna.tsinghua.edu.cn/bioconductor\")" >> ~/.Rprofile
echo "options(repos=structure(c(CRAN=\"https://mirrors.tuna.tsinghua.edu.cn/CRAN/\"))) " >> ~/.Rprofile

###CRAN
#https://mirrors.tuna.tsinghua.edu.cn/CRAN/ 	TUNA Team, Tsinghua University
#https://mirrors.bfsu.edu.cn/CRAN/ 	Beijing Foreign Studies University
#https://mirrors.ustc.edu.cn/CRAN/ 	University of Science and Technology of China
#https://mirror-hk.koddos.net/CRAN/ 	KoDDoS in Hong Kong
#https://mirrors.e-ducation.cn/CRAN/ 	Elite Education
#https://mirror.lzu.edu.cn/CRAN/ 	Lanzhou University Open Source Society
#https://mirrors.nju.edu.cn/CRAN/ 	eScience Center, Nanjing University
#https://mirrors.tongji.edu.cn/CRAN/ 	Tongji University 

### Bioconductor
### China
#    TUNA Mirror Site, Tsinghua University    URLs: https://mirrors.tuna.tsinghua.edu.cn/bioconductor/; http://mirrors.tuna.tsinghua.edu.cn/bioconductor/
### China2
#    eScience Center, Nanjing University    URLs: https://mirrors.nju.edu.cn/bioconductor/; https://mirrors.nju.edu.cn/bioconductor/

