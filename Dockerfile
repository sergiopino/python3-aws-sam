FROM ubuntu:18.10
LABEL maintainer="Sergio PINO <srmpino@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean && apt-get -y update && apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8
RUN export LC_ALL LANG
RUN apt-get install -y python3 python3-dev python3-pip
RUN python3 --version
RUN pip3 install aws-sam-cli --upgrade
RUN pip3 install uwsgi
# Find your Python User Base path (where Python --user will install packages/scripts)
RUN ["/bin/bash", "-c", "source ~/.profile"]
RUN echo "# Pip installed" && pip3 --version
RUN echo "# SAM installed" && sam --version

RUN echo 'Install Complete'

