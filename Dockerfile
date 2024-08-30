FROM golang:1.21 AS build

WORKDIR /app

COPY go.mod /app/

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=build /app/main .

COPY --from=build /app/static /static

EXPOSE 8080

CMD ["./main"]
