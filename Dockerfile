FROM debian:jessie

MAINTAINER "Matias Esteban" <estebanmatias92@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HHVM_VERSION HHVM-3.4.2

# Install dependencies
RUN apt-get update -y \
    && apt-get install -y git-core cmake gawk libmysqlclient-dev \
        libxml2-dev libmcrypt-dev libicu-dev openssl build-essential binutils-dev \
        libcap-dev zlib1g-dev libtbb-dev libonig-dev libpcre3-dev \
        autoconf libtool libcurl4-openssl-dev wget memcached \
        libreadline-dev libncurses5-dev libmemcached-dev libbz2-dev \
        libc-client2007e-dev php5-mcrypt php5-imagick libgoogle-perftools-dev \
        libcloog-ppl-dev libelf-dev libdwarf-dev libunwind8-dev subversion \
        libtbb2 g++-4.8 gcc-4.8 libjemalloc-dev \
        libc6-dev libmpfr4 libgcc1 binutils \
        libc6 libc-dev-bin libc-bin libgomp1 \
        libstdc++-4.8-dev libstdc++6 \
        libarchive13 cmake-data libacl1 libattr1 \
        g++ cpp gcc make libboost-thread1.55.0 \
        libboost-thread-dev libgd2-xpm-dev \
        pkg-config libboost-system1.55-dev \
        libboost-program-options1.55-dev libboost-filesystem1.55-dev libboost-regex1.55-dev \
        libmagickwand-dev libiberty-dev libevent-dev libxslt-dev libgoogle-glog-dev \
        automake libldap2-dev libkrb5-dev libyaml-dev ocaml-native-compilers \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y

# Download and build from source
RUN git clone git://github.com/facebook/hhvm.git /tmp/hhvm \
    && cd /tmp/hhvm \
    && git checkout tags/${HHVM_VERSION} \
    && git submodule update --init --recursive \
    && cmake . \
    && make -j $(( $(nproc)/2 )) \
    && make install \
    && rm -rf $(pwd) \
    && cd -

# Set hhvm link
# You can run php binaries without prefix the hhvm binary
RUN /usr/bin/update-alternatives --install /usr/bin/php php /usr/local/bin/hhvm 60

ENTRYPOINT ["/usr/local/bin/hhvm"]

CMD ["--help"]
