#!/bin/sh
 
apt-get -y install build-essential zlib1g-dev libpcre3 libpcre3-dev unzip > /dev/null
wget -nv https://github.com/pagespeed/ngx_pagespeed/archive/release-1.9.32.6-beta.zip 2>&1 >/dev/null
unzip release-1.9.32.6-beta.zip > /dev/null
cd ngx_pagespeed-release-1.9.32.6-beta/ > /dev/null
wget -nv https://dl.google.com/dl/page-speed/psol/1.9.32.6.tar.gz 2>&1 >/dev/null
tar -xzvf 1.9.32.6.tar.gz > /dev/null
cd ../
wget -nv http://nginx.org/download/nginx-1.8.0.tar.gz 2>&1 >/dev/null
tar -xvzf nginx-1.8.0.tar.gz > /dev/null
cd nginx-1.8.0
echo "Installing Nginx With PageSpeed"
./configure --add-module=../ngx_pagespeed-release-1.9.32.6-beta > /dev/null
make -j2 > /dev/null
make install > /dev/null
echo "Complete"
