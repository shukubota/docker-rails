FROM centos:centos6
MAINTAINER kubota

RUN yum -y update
RUN yum -y install sudo

# set ruby version to be installed
#ENV ruby_ver="2.3.4"

#RUN yum -y update
#RUN yum -y install epel-release
#RUN yum -y install git make autoconf curl wget
#RUN yum -y install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel sqlite-devel bzip2
#RUN yum clean all

# install ruby & bundler
#RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
#RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

#RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
#RUN echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh
#RUN echo 'eval "$(rbenv init --no-rehash -)"' >> /etc/profile.d/rbenv.sh

#RUN source /etc/profile.d/rbenv.sh; rbenv install ${ruby_ver}; rbenv global ${ruby_ver}
# RUN source /etc/profile.d/rbenv.sh; gem update --system; gem install --no-ri --no-rdoc rails; gem install bundler

# make workdir for rails projects
RUN mkdir -p /work

