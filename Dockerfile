FROM alpine:latest

RUN mkdir -p /output && chmod 777 /output
COPY crontab /etc/crontabs/root
RUN crontab /etc/crontabs/root

CMD ["crond", "-f", "-s"]