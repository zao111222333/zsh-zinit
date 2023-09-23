FROM debian:bookworm
# zsh
COPY --from=zao111222333/zsh-zinit:debian-build /root/.zsh.d /root/.zsh.d
COPY --from=zao111222333/zsh-zinit:debian-build /root/.zshrc /root/.zshrc
RUN usermod --shell /bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile \
 && rm /root/.profile /root/.bashrc \
 && mkdir -p /etc/profile.d \
 && touch /etc/profile.d/null.sh
SHELL ["/bin/zsh", "-c"] 
ARG TERM="xterm-256color"
RUN source /root/.zshrc
ENTRYPOINT ["/bin/zsh"]