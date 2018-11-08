#!/usr/bin/env bash

# エラーが出た箇所で実行ストップ
set -e

# ファイル内に文字列が存在しない場合、追加でその文字列を書き込み
# [$1] 文字列
# [$2] ファイルのパス
function sudo_echo_if_not_exists {
  if ! [ "`cat $2 | grep "$1"`" ]; then
    sudo bash -c "echo $1 >> $2"
  fi
}

# コマンドが存在するかどうか調べる
# [$1] コマンド名
function command_exists {
  command -v "$1" >/dev/null 2>&1 ;
}

#基本的な必要ライブラリをインストール
echo "ライブラリをインストール中..."
yum install sudo
sudo yum -y install gcc
sudo yum -y install make
sudo yum -y install gcc-c++
sudo yum -y install zlib-devel
sudo yum -y install httpd-devel
sudo yum -y install openssl-devel
sudo yum -y install curl-devel
sudo yum -y --enablerepo=epel,remi,rpmforge install libxml2 libxml2-devel
sudo yum -y --enablerepo=epel,remi,rpmforge install libxslt libxslt-devel
sudo yum -y install wget
sudo yum -y update

# pdfへ変換する時に日本語出力するためのフォント
#sudo yum install -y ipa-gothic-fonts ipa-mincho-fonts ipa-pgothic-fonts ipa-pmincho-fonts

# gcc 最新バージョンインストール
if ! [ "`gcc --version | grep '4.4.7'`" ]; then
  sudo wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
  sudo yum -y install devtoolset-2-gcc devtoolset-2-binutils
  sudo yum -y install devtoolset-2-gcc-c++ devtoolset-2-gcc-gfortran
  echo 'export CC=/opt/rh/devtoolset-2/root/usr/bin/gcc' >> ~/.bash_profile
  echo 'export CPP=/opt/rh/devtoolset-2/root/usr/bin/cpp' >> ~/.bash_profile
  echo 'export CXX=/opt/rh/devtoolset-2/root/usr/bin/c++' >> ~/.bash_profile
fi
source ~/.bash_profile

# # redis
# cd
# if ! command_exists 'redis-server' ; then
#   wget http://download.redis.io/releases/redis-3.2.8.tar.gz
#   tar xzf redis-3.2.8.tar.gz
#   cd redis-3.2.8/
#   make
#   sudo make install
#   cd
#   cd redis-3.2.8/
#   sudo cp redis.conf /etc/
# fi
# source ~/.bash_profile

# # ファイアーウォール設定
# echo "ファイアーウォール設定中..."
# sudo chkconfig httpd on
# sudo service iptables stop
# sudo chkconfig iptables off

# CentOSに入ってるRubyはバージョンが古いのでアンインストール
echo "CentOSのRubyはバージョンが古いのでアンインストール"
sudo yum -y remove ruby

# gitをインストール
echo "gitインストール中..."
sudo yum -y install git

# # nodejsをインストール
# echo "nodejsインストール中..."
# if ! [ -s ~/.nvm ] ; then
#   git clone https://github.com/creationix/nvm.git ~/.nvm
# fi
# source ~/.nvm/nvm.sh
# nvm --version
# nvm install v7.7.2
# nvm use v7.7.2

# # npm
# echo "npmインストール中..."
# cd /var/www/html/front_end
# npm install

# # webpack
# npm install webpack -g

# source ~/.bash_profile
# source ~/.nvm/nvm.sh
# node --version

# rbenvインストール
echo "rbenvインストール中..."
if ! [ -e ~/.rbenv ]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  cd ~/.rbenv/plugins/ruby-build
  sudo ./install.sh
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
fi
source ~/.bash_profile
rbenv -v

# Rubyのインストール
echo "Rubyインストール中..."
if ! [ "`ruby -v | grep '2.4.0'`" ]; then
  yum install -y readline-devel
  rbenv install 2.4.0
  rbenv rehash
  rbenv global 2.4.0
fi
ruby -v
source ~/.bash_profile

# Railsのインストール
echo "Railsインストール中..."
rbenv exec gem install rails -v 5.0.7
rbenv rehash
source ~/.bash_profile

# echo "ImageMagickインストール中..."
# sudo yum -y install libjpeg-devel libpng-devel
# sudo yum -y install ImageMagick ImageMagick-devel
# # なんかよくわからんけどいるffi
# sudo yum -y install ruby-devel libffi-devel

sudo yum -y install mysql-devel
#sudo yum -y install mysql
sudo yum -y install mysql-server
# gem install mysql2 -v '0.3.21'
# bundle install
echo "bundle install..."
cd /work/project
bundle install --path vendor/bundle
source ~/.bash_profile

# node 入れる



#rbenv rehash
#source ~/.bash_profile
# source ~/.nvm/nvm.sh

echo "=======設定完了！========"
