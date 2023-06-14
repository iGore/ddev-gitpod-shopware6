FROM gitpod/workspace-base as workspace-base
SHELL ["/bin/bash", "-c"]

RUN sudo apt-get -qq update

# Install dialog (interactive script)
RUN sudo apt-get -qq install -y dialog

# Install DDEV
USER gitpod
RUN curl -fsSL https://apt.fury.io/drud/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ddev.gpg > /dev/null
RUN echo "deb [signed-by=/etc/apt/trusted.gpg.d/ddev.gpg] https://apt.fury.io/drud/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list
RUN sudo apt update && sudo apt install -y ddev

# Install GitUI (terminal-ui for git)
RUN wget https://github.com/extrawurst/gitui/releases/download/v0.22.1/gitui-linux-musl.tar.gz -P /tmp
RUN sudo tar xzf /tmp/gitui-linux-musl.tar.gz -C /usr/bin

# End workspace-base

FROM scratch as drupalpod-gitpod-base
SHELL ["/bin/bash", "-c"]
COPY --from=workspace-base / /