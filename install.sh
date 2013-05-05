#!/bin/bash
#Date Started: 5/5/2013
#Date Modified: 5/5/2013
#Create by: Derek Harget

#Variables
UROOT=0 #Root



####################Don't Edit Below This line##############################



#check is user is root.

if [ "$UID" -ne "$UROOT" ]
then
  echo "Must be root to run this script."
  exit
fi  

if [ -f "/djh/config/INSTALLED" ]
then
    echo "System Already Install"
    exit
fi

#Update the Users System

yum -y upgrade

#Install all the packages the user needs

yum -y install wget gcc pcre-devel zlib-devel nano libxml2-devel openssl-devel bzip2-devel curl-devel gd-devel mysql-devel

#Create directories for installation/web folders

mkdir /djh
mkdir /djh/web
mkdir /djh/ins
mkdir /djh/configs

#move to proper directory

cd /djh/ins/

#Download needed files for installation

wget http://nginx.org/download/nginx-1.4.0.tar.gz
wget http://us2.php.net/distributions/php-5.4.14.tar.gz

#untar the files

tar -xvzf nginx-1.4.0.tar.gz
tar -xvzf php-5.4.14.tar.gz

#Enter nginx, configure and install

cd nginx-1.4.0
./configure --without-http_access_module --without-http_auth_basic_module --without-http_autoindex_module --without-http_browser_module --without-http_empty_gif_module --without-http_geo_module --without-http_limit_req_module --without-http_map_module --without-http_memcached_module --without-http_proxy_module --without-http_referer_module --without-http_scgi_module --without-http_split_clients_module --without-http_ssi_module --without-http_upstream_ip_hash_module --without-http_userid_module
make -j2
make install
../

#Install PHP
cd /djh/ins/php-5.4.14
./configure --enable-fastcgi --enable-fpm --with-mysql --with-pdo-mysql --with-zlib --with-bz2 --enable-zip --with-openssl --with-mhash --with-curl --with-gd --with-jpeg-dir --with-png-dir --with-ttf --enable-ftp --enable-exif --with-freetype-dir --enable-calendar --enable-soap --enable-mbstring --with-libxml-dir=/usr/lib --with-mysqli --with-xmlrpc --enable-intl 
make -j4
make install

#configure php.ini
cp -fr /djh/ins/php-5.4.14/php.ini-production /usr/local/lib/php.ini

#start APC install
pecl install apc

#PHP-FPM
cd /usr/local/etc/
cp -fr php-fpm.conf.default php-fpm.conf


#etc etc
#prevent it from being install twice
cd /djh/config
echo "INSTALLED" > INSTALLED
