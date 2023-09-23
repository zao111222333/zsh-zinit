# docker build --network host -t zao111222333/zsh-zinit:debian12-build -f debian12-build.dockerfile .
# docker push zao111222333/zsh:zinit-origin
# history -p
# docker run -it --name zsh-build zao111222333/zsh:zinit-origin
# docker commit zsh-build zao111222333/zsh:zinit
# docker push zao111222333/zsh:zinit
# docker run -it --rm zao111222333/zsh:zinit
FROM debian:bookworm
# COPY sources.list /etc/apt/sources.list
RUN rm -Rf /var/lib/apt/lists/* \
 && apt-get update -y && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    zsh \
    less \
    curl \
    wget

# zsh
COPY zsh /tmp/zsh
RUN usermod --shell /bin/zsh root \
 && echo "export LC_ALL=C" >> /etc/profile \
 && bash /tmp/zsh/install.sh \
 && rm /root/.profile /root/.bashrc

RUN rm -rf /tmp/* \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean
ENTRYPOINT ["/bin/zsh"]