FROM golang:1.21-alpine as BUILDER

WORKDIR /app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
#COPY go.mod go.sum ./
#RUN go mod download && go mod verify

COPY main.go go.mod .
RUN go build -o fullCycle .

FROM scratch

COPY --from=BUILDER /app/fullCycle ./fullCycle

CMD ["./fullCycle"]