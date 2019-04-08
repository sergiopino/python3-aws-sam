FROM ubuntu:16.04

LABEL maintainer="Sergio Pino <srmpino@gmail.com>"


ENV DEBIAN_FRONTEND noninteractive
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8


# Using apt-get due to warning with apt:
# WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
RUN apt-get install -y apt-utils && \
    apt-get install -y \
        automake \
        build-essential \
        cdbs \
        dh-make \
        dh-python \
        devscripts \
        git \
        m4 \
        python3-dev \
        python3-pip \
        python3-distutils-extra \
	libx11-xcb-dev \
	curl \
    # Clean up!
    && rm -rf /var/lib/apt/lists/*

# Node related
# ------------

RUN echo "# Installing Nodejs" && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get install nodejs build-essential -y && \
    npm set strict-ssl false && \
    npm install -g npm@latest && \
    npm install -g bower grunt grunt-cli && \
    npm cache clear -f && \
    npm install -g n && \
    n stable


RUN echo "#installing pip aws ebcli" &&  \
    apt-get install -y python-dev && \
    apt-get install -y python-pip && \
    pip install awsebcli --upgrade && \
    pip install awscli --upgrade


RUN echo "#installing pip sam aws" &&  \
    pip install aws-sam-cli


RUN echo 'Install Requirements' && \
    pip install -r requirements.txt && \
    pip install pyarrow==0.12.1 --target . && \
    pip install pandas==0.24.1 --target . && \
    pip install ikp3db==1.1.4 --target . && \

RUN echo 'Install Complete'

