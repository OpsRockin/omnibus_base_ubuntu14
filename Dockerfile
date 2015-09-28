FROM ubuntu:14.04
MAINTAINER sawanoboriyu@higanworks.com

RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-confdef" upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
RUN apt-get -y autoremove

RUN apt-get -y update
RUN apt-get -y install curl git

## Chef DK
RUN curl -s chef.sh | bash -s -- -P chefdk

## Prepare for omnibus
RUN mkdir /root/chefrepo
ADD files/Berksfile /root/chefrepo/Berksfile
WORKDIR /root/chefrepo
RUN berks vendor cookbooks
RUN chef-client -z -o "omnibus::default"

ADD files/bash_with_env.sh /home/omnibus/bash_with_env.sh

CMD ["/home/omnubus/bash_with_env.sh"]
