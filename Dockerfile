FROM ubuntu:trusty
MAINTAINER sawanoboriyu@higanworks.com

RUN apt-get -y update && \
    apt-get -y install curl git

## Chef Client and librarian
RUN eval "$(curl chef.sh)" && \
    /opt/chef/embedded/bin/gem install librarian-chef --no-ri --no-rdoc

## Prepare for omnibus
RUN mkdir /root/chefrepo
ADD files/Cheffile /root/chefrepo/Cheffile
WORKDIR /root/chefrepo
RUN /opt/chef/embedded/bin/librarian-chef install && \
    rm -rf tmp

RUN chef-client -z -o "omnibus::default" && \
    rm -rf /var/chef

ADD files/Gemfile /root/Gemfile
ADD files/prebundle.sh /root/prebundle.sh
WORKDIR /root
RUN ./prebundle.sh

ADD files/bash_with_env.sh /home/omnibus/bash_with_env.sh
ADD files/build.sh /home/omnibus/build.sh

ENV HOME /home/omnibus

ONBUILD ADD . /home/omnibus/omnibus-project
ONBUILD VOLUME ["pkg", "/home/omnibus/omnibus-project/pkg"]

WORKDIR /home/omnibus/omnibus-project
ONBUILD RUN bash -c 'source /home/omnibus/load-omnibus-toolchain.sh ; bundle install --binstubs bundle_bin --without development test'

CMD ["/home/omnibus/build.sh"]
