FROM centos:centos7
MAINTAINER Jordi Prats

# TODO
# http://label-schema.org/rc1/#build-time-labels
LABEL org.label-schema.vendor="" \
      org.label-schema.url="" \
      org.label-schema.name="" \
      org.label-schema.license="" \
      org.label-schema.version=""\
      org.label-schema.vcs-url="" \
      org.label-schema.vcs-ref="" \
      org.label-schema.build-date="" \
      org.label-schema.schema-version=""

RUN mkdir -p /usr/local/bin/

COPY validatecsr.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/validatecsr.sh

#
# utils
#
RUN yum install openssl -y

#
# puppet install
#
RUN rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
RUN yum install puppetserver -y

#
# puppet config
#
COPY puppet.conf /etc/puppetlabs/puppet/puppet.conf
COPY logback.xml /etc/puppetlabs/puppetserver/logback.xml

# certname=puppet
# dns_alt_names=puppet.fqdn


# DFile=/var/run/puppetlabs/puppetserver/puppetserver.pid
# #set default privileges to -rw-r-----
# UMask=027
# ExecReload=/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver reload
# ExecStart=/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver start
# ExecStop=/opt/puppetlabs/server/apps/puppetserver/bin/puppetserver stop
# KillMode=process
# SuccessExitStatus=143
# StandardOutput=syslog


# /var/log/puppetlabs
# /etc/puppetlabs