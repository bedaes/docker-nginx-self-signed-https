FROM nginx:1.13

WORKDIR /etc/nginx

COPY certs/localhost.crt localhost.crt
COPY certs/localhost.key localhost.key
COPY certs/ca/intermediate-ca.crt intermediate-ca.crt
RUN cat localhost.crt intermediate-ca.crt > localhost.bundle.crt
COPY nginx-default.conf conf.d/default.conf
COPY run.sh /run.sh

ENV REMOTE_URL="http://localhost:8080/"

CMD ["/run.sh"]
