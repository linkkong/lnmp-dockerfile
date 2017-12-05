FROM ubuntu:16.04

MAINTAINER turtle "turtle@anasit.com"

COPY ./sources.list /sources.list

#RUN \
RUN     mv /etc/apt/sources.list /etc/apt/sources.list.old
RUN 	mv /sources.list /etc/apt/sources.list
RUN	apt-get -y update  
RUN	apt-get install -y software-properties-common  
RUN     apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db  
RUN     echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/testing multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list  
RUN	export LANG=C.UTF-8
RUN	add-apt-repository ppa:chris-lea/redis-server  
RUN	LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php  
RUN	apt-get -y update  
RUN     apt-get install -y mariadb-server mariadb-common  
RUN     apt-get install -y php7.1 php7.1-common php7.1-fpm php7.1-dev  
RUN	apt-get install -y php7.1-mbstring php7.1-xml  
RUN     apt-get install -y nginx  
RUN     apt-get install -y vim 
RUN     apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN     apt -y update
RUN	apt-get install -y mongodb-org
RUN	apt install -y libssh-dev
RUN	apt-get install -y build-essential libexpat1-dev libgeoip-dev libpng-dev libpcre3-dev libssl-dev libxml2-dev rcs zlib1g-dev libmcrypt-dev libcurl4-openssl-dev libjpeg-dev libpng-dev libwebp-dev pkg-config
RUN	pecl install mongodb  
RUN	echo "\nextension=mongodb.so" | tee /etc/php/7.1/cli/php.ini  
RUN	echo "\nextension=mongodb.so" | tee /etc/php/7.1/fpm/php.ini  
RUN	apt-get install -y redis-server  
RUN	apt-get install -y wget
RUN     wget https://getcomposer.org/composer.phar  
RUN	mv composer.phar composer && chmod +x composer
RUN     mv composer /usr/local/bin



# 配置nginx

#Copy ./default /etc/nginx/sites-available/default

# 添加启动脚本
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh


CMD /start.sh  tail -f

# Expose ports.
EXPOSE 3306
EXPOSE 80
EXPOSE 6379
EXPOSE 27017
