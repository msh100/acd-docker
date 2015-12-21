FROM ubuntu:14.04
MAINTAINER Marcus Hughes <hello@msh100.uk>

# Update apt and install encfs
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y python3-pip git fuse

RUN pip3 install --upgrade git+https://github.com/yadayada/acd_cli.git

ADD mount.sh /
RUN chmod +x /mount.sh

CMD ["/mount.sh"]

