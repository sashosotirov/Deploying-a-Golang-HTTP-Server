FROM golang:1.14.2-alpine AS builder
WORKDIR /goapp
COPY main.go .
RUN go env -w GO111MODULE=off
RUN go build -o main .

FROM alpine AS runtime
WORKDIR /goapp
COPY --from=builder /goapp/main .
ENTRYPOINT ["./main"]
EXPOSE 8080



