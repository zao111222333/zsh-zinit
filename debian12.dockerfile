# docker build --network host -t zao111222333/zsh-zinit:debian12 -f debian12.dockerfile .
# docker run -it --rm zao111222333/zsh-zinit:debian12
# docker push zao111222333/zsh-zinit:debian12

FROM debian:bookworm
# zsh
RUN apt-get update -y && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
    zsh \
COPY --from=zao111222333/zsh-zinit:debian12-install /root/.zsh.d /root/.zsh.d
COPY --from=zao111222333/zsh-zinit:debian12-install /root/.zshrc /root/.zshrc
ENV TERM="xterm-256color"
RUN usermod --shell /bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile \
 && mkdir -p /etc/profile.d \
 && touch /etc/profile.d/null.sh
SHELL ["/bin/zsh", "-c"] 
RUN source /root/.zshrc

RUN rm -rf /tmp/* \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean
ENTRYPOINT ["/bin/zsh"]