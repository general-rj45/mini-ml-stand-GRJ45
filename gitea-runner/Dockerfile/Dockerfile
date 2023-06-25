FROM ubuntu:20.04
RUN apt-get update && apt install -y wget curl

RUN wget https://dl.gitea.com/act_runner/0.2.0/act_runner-0.2.0-linux-amd64 -O act_runner && \
    chmod +x ./act_runner && \
    mv ./act_runner /usr/local/bin

RUN wget https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl -O kubectl && \
    chmod +x ./kubectl && \
    mv kubectl /usr/local/bin

WORKDIR /runner/data

COPY gitea-runner.conf /runner/gitea-runner.conf 

CMD if [ ! -f "/runner/data/.runner" ]; \
    then \
        act_runner register --instance $GITEA_HOST --token $GITEA_TOKEN -c /runner/gitea-runner.conf --labels self-hosted --no-interactive && \
        act_runner daemon -c /runner/gitea-runner.conf; \
    else \
        act_runner daemon -c /runner/gitea-runner.conf; \
    fi