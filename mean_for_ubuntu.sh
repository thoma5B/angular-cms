# NOTE: when using MongoDB 32 bit, you are limited to about 2 gigabytes of data

sudo mkdir www
cd www/

sudo wget https://nodejs.org/dist/v4.1.1/node-v4.1.1-linux-x86.tar.gz
sudo tar xvzf node-v4.1.1-linux-x86.tar.gz 
sudo ln -s /var/www/angular_cms/node-v4.1.1-linux-x86/bin/node /usr/bin/node
sudo ln -s /var/www/angular_cms/node-v4.1.1-linux-x86/bin/npm /usr/bin/npm

sudo apt-get update
sudo apt-get install git make

cd /var/www/
sudo git clone https://github.com/jonniespratley/angular-cms.git
npm install
cd angular-cms/
sudo npm install
sudo npm install
sudo npm install -g bower
sudo npm install connect-livereload

sudo ln -s /var/www/angular_cms/node-v4.1.1-linux-x86/lib/node_modules/bower/bin/bower /usr/local/bin/bower


bower install
sudo npm install -g grunt grunt-cli

# change host:port???


sudo grunt serve #127.0.0.1:8000
cd /var/www/angular_cms/angular-cms
sudo sh bin/db.sh 
sudo sh node_modules/grunt-cli/bin/grunt serve

