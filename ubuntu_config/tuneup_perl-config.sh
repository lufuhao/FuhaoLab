#!/bin/bash

### cpan
#若你已经用过cpan了，将~/.cpan/CPAN/MyConfig.pm中的'urllist'的值改为
'urllist' => [q[http://mirrors.ustc.edu.cn/CPAN/ https://mirrors.tuna.tsinghua.edu.cn/CPAN]],
#OR
cpan
#cpan[1]> o conf urllist push https://mirrors.tuna.tsinghua.edu.cn/CPAN
#cpan[1]> o conf urllist push ftp://cpan.cs.utah.edu/CPAN/
#cpan[1]> o conf urllist push https://mirrors.aliyun.com/CPAN/
#cpan[2]> o conf commit
#OR
cpan[1]> o conf urllist https://mirrors.tuna.tsinghua.edu.cn/CPAN http://mirror.waia.asn.au/pub/cpan/ ftp://mirrors.coopvgg.com.ar/CPAN/
cpan[2]> o conf commit

o conf prerequisites_policy follow
o conf commit
