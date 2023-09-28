# docker build --network host -t zao111222333/zsh-zinit:centos7-build -f centos7-build.dockerfile .
# docker run -it --rm --name centos7-install zao111222333/zsh-zinit:centos7-build
# docker commit centos7-install zao111222333/zsh-zinit:centos7-install
# docker run -it --rm zao111222333/zsh-zinit:centos7-install
# docker push zao111222333/zsh-zinit:centos7-build
# docker push zao111222333/zsh-zinit:centos7-install
FROM centos:7
RUN yum -y update \
 && yum makecache \
 && yum install -y \
    git \
    ca-certificates \
    less \
    curl \
    wget

RUN cd / \ 
 && wget http://mirror.ghettoforge.org/distributions/gf/el/7/plus/x86_64/zsh-5.1-1.gf.el7.x86_64.rpm \
 && rpm -i zsh-5.1-1.gf.el7.x86_64.rpm

# zsh
RUN rm -rf /tmp/zsh
COPY zsh /tmp/zsh
RUN usermod --shell /usr/local/bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile \
 && bash /tmp/zsh/install.sh \
 && rm /root/.bashrc
SHELL ["/usr/bin/zsh", "-c"] 
ENV TERM="xterm-256color"
RUN source /root/.zshrc\
 && zinit update

RUN rm -rf /tmp/* \
 && yum -y clean all
ENTRYPOINT ["/usr/bin/zsh"]