FROM nginx:1.13

COPY certs/localhost.crt /etc/nginx/localhost.crt
COPY certs/localhost.key /etc/nginx/localhost.key
COPY nginx-default.conf /etc/nginx/conf.d/default.conf
COPY run.sh /run.sh

ENV REMOTE_URL="http://localhost:8080/"

CMD ["/run.sh"]
