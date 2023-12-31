# docker build --network host -t zao111222333/zsh-zinit:debian12-build -f debian12-build.dockerfile .
# docker run -it --name debian12-install zao111222333/zsh-zinit:debian12-build
# docker commit debian12-install zao111222333/zsh-zinit:debian12-install
# docker run -it --rm zao111222333/zsh-zinit:debian12-install
# docker push zao111222333/zsh-zinit:debian12-build
# docker push zao111222333/zsh-zinit:debian12-install
FROM debian:bookworm
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
 && bash /tmp/zsh/install.sh
SHELL ["/bin/zsh", "-c"] 
ENV TERM="xterm-256color"
RUN source /root/.zshrc\
 && zinit update

RUN rm -rf /tmp/* \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean
ENTRYPOINT ["/bin/zsh"]