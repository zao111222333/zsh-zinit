# docker build --network host -t zao111222333/zsh:zinit-centos -f Dockerfile-centos7 .
# history -p
# docker push zao111222333/zsh:zinit-centos
# docker run -it -e "TERM=xterm-256color" --rm zao111222333/zsh:zinit-centos
# docker run -it -e "TERM=xterm-256color" --rm zao111222333/zsh:zinit-centos-build

FROM centos:7
# zsh
COPY --from=zao111222333/zsh:zinit-centos-build /usr/local/bin/zsh /usr/local/bin/zsh
COPY --from=zao111222333/zsh:zinit-centos-build /usr/local/lib/zsh /usr/local/lib/zsh
COPY --from=zao111222333/zsh:zinit-centos-build /usr/local/share/zsh /usr/local/share/zsh
COPY --from=zao111222333/zsh:zinit-centos-build /usr/share/zsh /usr/share/zsh
COPY --from=zao111222333/zsh:zinit-centos-build /root/.zsh.d /root/.zsh.d
COPY --from=zao111222333/zsh:zinit-centos-build /root/.zshrc /root/.zshrc
ENV TERM="xterm-256color"
ENV FPATH=$FPATH:/usr/local/share/zsh/site-functions:/usr/local/share/zsh/5.9/functions
RUN usermod --shell /usr/local/bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile
SHELL ["/usr/local/bin/zsh", "-c"] 
RUN source /root/.zshrc

ENTRYPOINT ["/usr/local/bin/zsh"]