FROM ubuntu:jammy-20240627.1
RUN apt update && apt install curl wget git gnupg apt-transport-https -y
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN apt-get update -y && apt-get install helm=3.15.2-1 -y 
RUN helm plugin install https://github.com/jkroepke/helm-secrets
RUN helm plugin install https://github.com/databus23/helm-diff
RUN cd /tmp && \
    curl -O -L -C - https://github.com/helmfile/helmfile/releases/download/v0.153.1/helmfile_0.153.1_linux_amd64.tar.gz && \
    tar -xzvf helmfile_0.153.1_linux_amd64.tar.gz && \
    mv helmfile /usr/bin/helmfile
RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 && \
    chmod +x /usr/local/bin/yq
