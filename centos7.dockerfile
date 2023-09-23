# docker build --network host -t zao111222333/zsh-zinit:centos7 -f centos7.dockerfile .
# history -p
# docker push zao111222333/zsh-zinit:centos7
# docker run -it --rm zao111222333/zsh:zinit-centos
# docker run -it --rm zao111222333/zsh:zinit-centos-build

FROM centos:7
# zsh
COPY --from=zao111222333/zsh-zinit:centos7-build /usr/local/bin/zsh /usr/local/bin/zsh
COPY --from=zao111222333/zsh-zinit:centos7-build /usr/local/lib/zsh /usr/local/lib/zsh
COPY --from=zao111222333/zsh-zinit:centos7-build /usr/local/share/zsh /usr/local/share/zsh
COPY --from=zao111222333/zsh-zinit:centos7-build /usr/share/zsh /usr/share/zsh
COPY --from=zao111222333/zsh-zinit:centos7-build /root/.zsh.d /root/.zsh.d
COPY --from=zao111222333/zsh-zinit:centos7-build /root/.zshrc /root/.zshrc
ENV FPATH=$FPATH:/usr/local/share/zsh/site-functions:/usr/local/share/zsh/5.9/functions
RUN usermod --shell /usr/local/bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile
SHELL ["/usr/local/bin/zsh", "-c"] 
ENV TERM="xterm-256color"
RUN source /root/.zshrc

ENTRYPOINT ["/usr/local/bin/zsh"]