FROM ubuntu:trusty

ENV LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 LC_CTYPE=ja_JP.UTF-8 BUNDLER_VERSION=1.11.2
WORKDIR /root
EXPOSE 22
CMD /sshd.sh
ADD sshd.sh /sshd.sh
RUN : \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      openssh-server \
      ca-certificates \
      git \
      make \
      python \

 && apt-get install -y software-properties-common \
 && apt-add-repository ppa:brightbox/ruby-ng \
 && apt-add-repository ppa:ubuntu-mozilla-security/ppa \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      bzip2 \
      ca-certificates \
      build-essential \
      language-pack-ja-base \
      language-pack-ja \
      fontconfig \
      unzip \
      curl \
      libffi-dev \
      libgdbm3 \
      libssl-dev \
      libyaml-dev \
      procps \
      zlib1g-dev \
      ruby2.2 \
      ruby2.2-dev \
      firefox \
      xvfb \
 && apt-get clean \

 && mkdir -p /usr/share/fonts/truetype \
 && cd /usr/share/fonts/truetype \
 && curl -SLO http://dl.ipafont.ipa.go.jp/IPAfont/ipagp00303.zip \
 && unzip ipagp00303.zip \
 && rm -f ipagp00303.zip \
 && fc-cache -fv \
 && update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja \

# skip installing gem documentation
 && mkdir -p /usr/local/etc \
 && echo -e 'install: --no-document\nupdate: --no-document' >> /usr/local/etc/gemrc \

 && gem install bundler --version "$BUNDLER_VERSION" \

 && :
