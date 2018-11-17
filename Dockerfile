FROM opensuse:42.3
COPY ./start.sh /start.sh
RUN zypper -n update --skip-interactive --no-recommends \
 && zypper -n install \
    wget \
    tar \
    zip \
    unzip \
    curl \
    which \
    hostname \
    glibc-locale \
    libnuma1 \
    libltdl7 \
 && chmod +x /start.sh
CMD /start.sh
EXPOSE 4390 8090 39013 39015 39017 39018 39041 59013 59014
