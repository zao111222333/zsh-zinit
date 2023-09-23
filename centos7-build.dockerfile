# docker build --network host -t zao111222333/zsh-zinit:centos7-build -f centos7-build.dockerfile .
# docker run -it --rm \
# zao111222333/zsh:zinit-centos-origin
# docker push zao111222333/zsh:zinit-origin
# history -p
# docker run -it --name zsh-centos-build zao111222333/zsh:zinit-centos-origin
# docker commit zsh-centos-build zao111222333/zsh:zinit-centos-build
# docker push zao111222333/zsh:zinit-centos

FROM centos:7
RUN yum -y update \
 && yum makecache \
 && yum install -y \
    git \
    make \
    ncurses-devel \
    gcc \
    autoconf \
    man \
    ca-certificates \
    less \
    curl \
    wget

RUN git clone -b zsh-5.9 https://github.com/zsh-users/zsh.git /tmp/zsh
RUN cd /tmp/zsh \
 && ./Util/preconfig \
 && ./configure --without-tcsetpgrp \
 && make -j 20 install.bin install.modules install.fns

# zsh
COPY zsh /tmp/zsh
RUN usermod --shell /usr/local/bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile \
 && bash /tmp/zsh/install.sh \
 && rm /root/.bashrc
SHELL ["/usr/local/bin/zsh", "-c"] 
ENV TERM="xterm-256color"
RUN source /root/.zshrc\
 && zinit update

RUN rm -rf /tmp/* \
 && yum -y clean all
ENTRYPOINT ["/usr/local/bin/zsh"]