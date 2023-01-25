FROM golang:bullseye AS builder
WORKDIR /goapp 

COPY main.go .
RUN  go mod init main.go && go build -o main .
RUN useradd -u 10001 exec

FROM alpine AS runtime
WORKDIR /goapp
COPY --from=builder /etc/passwd /etc/passwd
USER exec
COPY --from=builder /goapp/main .
CMD [./main]



