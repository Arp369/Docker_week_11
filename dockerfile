FROM golang:1.23.3-alpine AS builder

WORKDIR /web
COPY . .
# Build the Go binary and confirm it's created
RUN CSG_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .

#RUN CSG_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .

FROM alpine:3.20
WORKDIR /srv
COPY --from=builder  /web/app .
COPY --from=builder  /web/templates ./templates

EXPOSE 80
CMD [ "./app" ]