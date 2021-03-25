# Base image
FROM alpine:3.12.4

# Maintainer information
LABEL maintainer="Maksim Stojkovic <https://github.com/maksimstojkovic>"
LABEL org.opencontainers.image.source https://github.com/maksimstojkovic/docker-duckdns-local

# Default environment variables
ENV DUCKDNS_DELAY=5

# Install tools required
RUN apk add --no-cache curl

# Copy scripts
COPY ./scripts /scripts
WORKDIR /scripts
RUN chmod -R +x /scripts

# Image starting command
CMD ["/bin/sh", "/scripts/start.sh"]
