FROM debian:bookworm

COPY --from=zao111222333/zsh-zinit:debian12 /root/.zsh.d /root/.zsh.d
COPY --from=zao111222333/zsh-zinit:debian12 /root/.zshrc /root/.zshrc
ENV TERM="xterm-256color"
RUN usermod --shell /bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile \
 && rm /root/.profile /root/.bashrc \
 && mkdir -p /etc/profile.d \
 && touch /etc/profile.d/null.sh
SHELL ["/bin/zsh", "-c"] 
RUN source /root/.zshrc
ENTRYPOINT ["/bin/zsh"]