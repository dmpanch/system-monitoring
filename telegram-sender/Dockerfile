# Initial stage: download modules
FROM golang:1.15 as builder

RUN mkdir -p /pbot
ADD . /pbot
WORKDIR /pbot

RUN go get -v github.com/inCaller/prometheus_bot && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o /pbot/bin/telegram-bot  github.com/inCaller/prometheus_bot

# Final stage: Run the binary
FROM scratch

# and finally the binary
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /pbot/bin/telegram-bot /pbot
COPY --from=builder /pbot/config.yaml /config.yaml

EXPOSE 9087/tcp

ENTRYPOINT ["/pbot"]
