FROM python:alpine

LABEL \
  org.opencontainers.image.title="Home Assistant Add-on: CoE to HTTP server" \
  org.opencontainers.image.description="An addon to allows interaction with a C.M.I. as a CoE device, using a HTTP API." \
  org.opencontainers.image.licenses="MIT License"

# Install build dependencies
RUN apk add --no-cache --virtual .build-dependencies \
    build-base linux-headers gcc python3-dev git cargo

# Clone project - with variable branch specification
ARG PROJECT_TAG=v2.1.4
RUN git clone --depth 1 --branch ${PROJECT_TAG} \
    https://gitlab.com/DeerMaximum/ta-coe.git /opt/ta-coe

WORKDIR /opt/ta-coe

# Install Python dependencies
RUN AIOHTTP_NO_EXTENSIONS=1 pip install --no-cache-dir -r requirements.txt

# Remove build dependencies
RUN apk del --no-cache --purge .build-dependencies

# Declare ports
EXPOSE 9000 5441/udp 5442/udp
