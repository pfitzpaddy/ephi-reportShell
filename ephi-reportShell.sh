# #######################################################
# #
# # Ubuntu LTS 16.04 (ubuntu/xenial64)
# # 
# # Description: ephiPulse platform build script
# #
# # Notes: 
# #  - 
# #
# #######################################################


# ####################################################### REFRESH CACHE
# apt update
echo "------------ APT UPDATE ------------" 
echo "------------ " 
sudo apt update

# ####################################################### INSTALL UTILITIES
# utilities
echo "------------ INSTALL UTILITIES ------------" 
echo "------------ " 

# git
sudo apt install -y git
# check version
git --version

# install unzip
sudo apt install -y zip unzip




# ####################################################### ODK Aggregate
### INSTALL ODK AGGREGATE (https://docs.opendatakit.org/aggregate-tomcat/)
echo "------------ INSTALL ODK Aggregate ------------" 
echo "------------ " 

# ####################################################### Tomcat8
# 1), 2) & 3)
echo "------------ install tomcat8 ------------" 
echo "------------ " 
	# https://www.linode.com/docs/development/frameworks/apache-tomcat-on-ubuntu-16-04/
sudo apt-get install -y tomcat8 tomcat8-docs tomcat8-examples tomcat8-admin tomcat8-user # (OpenJDK installed as dependency)
# add tomcat admin page
sudo sed -i 's|</tomcat-users>|<role rolename="manager-gui"/><role rolename="admin-gui"/><user username="ephiadmin" password="ephiadmin" roles="manager-gui,admin-gui"/></tomcat-users>|' /var/lib/tomcat8/conf/tomcat-users.xml
# start tomcat8 (start, stop, restart)
sudo systemctl start tomcat8
sudo systemctl restart tomcat8

# ####################################################### Network && SSL
# 4) & 5) configured later

# ####################################################### PostgreSQL && PostGIS
# 6) install PostgreSQL && spatial databases
echo "------------ install PostgreSQL && PostGIS ------------"
echo "------------ " 
 # https://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS24UbuntuPGSQL10Apt
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt xenial-pgdg main" >> /etc/apt/sources.list'
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y postgresql-10-postgis-2.4 postgresql-contrib
sudo apt install -y postgis
# create PostGIS extensions && ephiadmin postgresql user for SCHEMA admin && phem
sudo -u postgres psql -c "CREATE ROLE ephiadmin WITH LOGIN SUPERUSER PASSWORD 'ephiadmin';"
sudo -u postgres psql -c "CREATE DATABASE ephi WITH OWNER ephiadmin;"
sudo -u postgres psql -d ephi -c "CREATE EXTENSION postgis;"
sudo -u postgres psql -d ephi -c "CREATE SCHEMA admin;"
sudo -u postgres psql -d ephi -c "CREATE SCHEMA phem;"
sudo -u postgres psql -d ephi -c "ALTER SCHEMA admin OWNER TO ephiadmin;"
sudo -u postgres psql -d ephi -c "ALTER SCHEMA phem OWNER TO ephiadmin;"
sudo -u postgres psql -d ephi -c "GRANT ALL PRIVILEGES ON SCHEMA admin TO ephiadmin;"
sudo -u postgres psql -d ephi -c "GRANT ALL PRIVILEGES ON SCHEMA phem TO ephiadmin;"
# udpate listen_address (to access from host machine)
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/10/main/postgresql.conf
# update pg_hba.conf (to enable connection)
sudo sed -i '$a host    all             all             0.0.0.0/0               md5' /etc/postgresql/10/main/pg_hba.conf
# allow connection on localhost cmd line without password
sudo sed -i "s|peer|trust|" /etc/postgresql/10/main/pg_hba.conf

echo "------------ restart PostgreSQL ------------"
echo "------------ "
# restart (to update changes)
sudo /etc/init.d/postgresql restart

# ####################################################### Spatial DB
# 6a) backup spatial databases
echo "------------ restore administrative spatial db tables ------------"
echo "------------ " 
# admin 1, 2, 3 && health facilities
psql -U ephiadmin -d ephi -f /home/ubuntu/data/sql/eth_admin_1.sql
psql -U ephiadmin -d ephi -f /home/ubuntu/data/sql/eth_admin_2.sql
psql -U ephiadmin -d ephi -f /home/ubuntu/data/sql/eth_admin_3.sql
psql -U ephiadmin -d ephi -f /home/ubuntu/data/sql/eth_adminsites.sql

# ####################################################### Deploy ODK Aggregate
# 
echo "------------ deploy ODK WAR ------------" 
echo "------------ " 
# default ODK log-in
  # username: ephiadmin
  # username: aggregate (until you change it via the Site Admin tab)
  # https://forum.opendatakit.org/t/failed-to-login-odk-aggregate/4469/8
sudo cp /home/ubuntu/data/war/ODK\ Aggregate/ODKAggregate.war /var/lib/tomcat8/webapps/
sudo systemctl restart tomcat8



echo "------------ INSTALL APP ENVIONRMENT ------------"
echo "------------ " 
# ####################################################### Nginx, Nodejs, Sailsjs, Pm2


# ####################################################### Nginx
# install nginx (https://www.nginx.com/)
sudo apt install -y nginx
nginx -v

# ####################################################### Nodejs
# install node
	# https://tecadmin.net/install-latest-nodejs-npm-on-ubuntu/
sudo curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt install -y nodejs
node -v
npm -v

# ####################################################### Sailsjs
# install sails
	# https://sailsjs.com/
sudo npm install sails@1.2.4 -g
sails -v

# ####################################################### Pm2
# install pm2
	# https://pm2.keymetrics.io/
sudo npm install -g pm2@4.2.3
pm2 -v


echo "------------ PULL ephi-reportPulse APP ------------"
echo "------------ " 
# ####################################################### ephi-reportPulse app
# go to nginx folder
cd /home/ubuntu/nginx/www/
# clone ephi-reportPulse app
git clone https://github.com/pfitzpaddy/ephi-reportPulse.git
# cd into folder
cd /home/ubuntu/nginx/www/ephi-reportPulse
# install dependencies (--no-bin-links to avoid 'npm ERR! code EPROTO')
  # https://github.com/laravel/homestead/issues/611
sudo npm install --no-bin-links


# ####################################################### ephi-reportPulse sails db connection
# local config to protect database connection string
echo "------------ CONFIGURE EPHI PULSE DB CONNECTION ------------" 
echo "------------ " 
# create local.js file (db connection strings, ignored in repo)
echo -e "/**
 * Local environment settings
 *
 * For more information, check out:
 */

module.exports.datastores = {
  default: {
    adapter: 'sails-postgresql',
    url: 'postgresql://ephiadmin:ephiadmin@127.0.0.1:5432/ephi',
    connectTimeout: 40000
  }
}" | sudo tee /home/ubuntu/nginx/www/ephi-reportPulse/config/local.js


# ####################################################### Nginx
# nginx (https://www.nginx.com/)
echo "------------ CONFIGURE NGINX WEB CONFIG ------------" 
echo "------------ " 
# set nginx conf
echo -e "##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# http://wiki.nginx.org/Pitfalls
# http://wiki.nginx.org/QuickStart
# http://wiki.nginx.org/Configuration
#
# Generally, you will want to move this file somewhere, and start with a clean
# file but keep this around for reference. Or just disable in sites-enabled.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

server {

  sendfile off;
  listen 80 default_server;
  listen [::]:80 default_server ipv6only=on;

  server_name ephiPulse.ephi.gov.et;

  location /images/ {
    alias /home/ubuntu/nginx/www/ephi-reportPulse/assets/images/; 
  }

  location / {
   proxy_bind \$server_addr;
   proxy_pass http://127.0.0.1:1337/;
   proxy_http_version 1.1;
   proxy_set_header Upgrade \$http_upgrade;
   proxy_set_header Connection 'upgrade';
   proxy_set_header Host \$host;
   proxy_set_header Access-Control-Allow-Origin *;
   proxy_cache_bypass \$http_upgrade;
   proxy_read_timeout 1080s; 
   proxy_send_timeout 1080s;
   proxy_connect_timeout 1080s;
   client_max_body_size 15M;
 }

}" | sudo tee /etc/nginx/sites-available/default
# symb link
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
# reload configuration
sudo service nginx restart
# chech conf
sudo nginx -t


# ####################################################### Start the APP!
# start ephiPulse
echo "------------ START THE APP ------------" 
echo "------------ " 
# app location
cd /home/ubuntu/nginx/www/ephi-reportPulse
# lift
# sudo sails lift


