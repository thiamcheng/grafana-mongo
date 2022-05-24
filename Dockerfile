FROM grafana/grafana

USER root

RUN apk update && \
    apk upgrade && \
    apk add --no-cache npm && \ 
    wget https://github.com/JamesOsgood/mongodb-grafana/archive/master.tar.gz -O - | tar xz -C $GF_PATHS_PLUGINS && \
    cd  $GF_PATHS_PLUGINS/mongodb-grafana-master && \
    npm install --silent && \
    npm cache clean --force && \
     echo "finished"
    
USER grafana

ENTRYPOINT ["/bin/sh", "-c" , "npm run server --prefix $GF_PATHS_PLUGINS/mongodb-grafana-master & /run.sh"]