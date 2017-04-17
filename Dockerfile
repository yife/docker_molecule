FROM python:2.7-slim
MAINTAINER fe yi

# locale
RUN apt-get update && apt-get -y upgrade && apt-get install -y locales && apt-get clean && apt-get autoremove
RUN echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV LANG ja_JP.UTF-8
ENV LC_MESSAGES C
ENV PYTHONIOENCODING utf-8

RUN set -x \
    && apt-get install -y apt-transport-https ca-certificates \
       curl software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce gcc libssl-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir ansible \
    && pip install --no-cache-dir molecule
