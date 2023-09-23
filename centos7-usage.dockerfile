FROM centos:7

COPY --from=zao111222333/zsh-zinit:centos7 /usr/local/bin/zsh /usr/local/bin/zsh
COPY --from=zao111222333/zsh-zinit:centos7 /usr/local/lib/zsh /usr/local/lib/zsh
COPY --from=zao111222333/zsh-zinit:centos7 /usr/local/share/zsh /usr/local/share/zsh
COPY --from=zao111222333/zsh-zinit:centos7 /usr/share/zsh /usr/share/zsh
COPY --from=zao111222333/zsh-zinit:centos7 /root/.zsh.d /root/.zsh.d
COPY --from=zao111222333/zsh-zinit:centos7 /root/.zshrc /root/.zshrc
ENV TERM="xterm-256color"
ENV FPATH=$FPATH:/usr/local/share/zsh/site-functions:/usr/local/share/zsh/5.9/functions
RUN usermod --shell /usr/local/bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile
SHELL ["/usr/local/bin/zsh", "-c"] 
RUN source /root/.zshrc

ENTRYPOINT ["/usr/local/bin/zsh"]