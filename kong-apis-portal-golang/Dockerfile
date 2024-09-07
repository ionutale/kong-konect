FROM golang:1.22.6-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY . .

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download
RUN go vet -v
RUN go test -v


COPY main.go .

# Build the Go app
RUN CGO_ENABLED=0 go build -o main .

# Start a new stage from scratch
FROM gcr.io/distroless/static-debian12:latest

WORKDIR /app

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/main .
COPY --from=builder /app/.env .

# Expose port 8080 to the outside world
EXPOSE 3001

# Command to run the executable
CMD ["./main"]