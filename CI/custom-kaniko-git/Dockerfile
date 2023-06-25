#https://github.com/Junyi-Xiao
FROM xiaojunyi/kaniko-bash:1.0.0
RUN apk add git
WORKDIR workdir
COPY build.sh /build.sh
CMD ["/build.sh"]
# ENTRYPOINT [/bin/bash]
# ENTRYPOINT [/kaniko/executor]