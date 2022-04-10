FROM golang:1.18.0-alpine AS builder
RUN apk add --no-cache git
RUN go install -v github.com/sviivyao/httpx/cmd/httpx@latest

FROM alpine:3.15.3
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates
COPY --from=builder /go/bin/httpx /usr/local/bin/

ENTRYPOINT ["httpx"]
