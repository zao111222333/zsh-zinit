FROM centos:7

COPY --from=zao111222333/zsh-zinit:centos7-install /zsh-5.1-1.gf.el7.x86_64.rpm /tmp/zsh-5.1-1.gf.el7.x86_64.rpm
COPY --from=zao111222333/zsh-zinit:centos7-install /root/.zsh.d /root/.zsh.d
COPY --from=zao111222333/zsh-zinit:centos7-install /root/.zshrc /root/.zshrc
COPY --from=zao111222333/zsh-zinit:centos7-install /root/.cache /root/.cache
ENV TERM="xterm-256color"
RUN rpm -i /tmp/zsh-5.1-1.gf.el7.x86_64.rpm \
 && usermod --shell /usr/bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile
SHELL ["/usr/bin/zsh", "-c"] 
RUN source /root/.zshrc


ENTRYPOINT ["/usr/bin/zsh"]