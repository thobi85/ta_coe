FROM python:3.12-alpine

LABEL \
  org.opencontainers.image.title="Home Assistant Add-on: CoE to HTTP server" \
  org.opencontainers.image.description="An addon to allows interaction with a C.M.I. as a CoE device, using a HTTP API." \
  org.opencontainers.image.licenses="MIT License"

# Build-Abhängigkeiten installieren
RUN apk add --no-cache --virtual .build-dependencies \
    build-base linux-headers gcc python3-dev git cargo

# projektbezogene Variablen
ARG PROJECT_BRANCH=2.14

# Projekt klonen – mit variabler Branch-Angabe
RUN git clone --depth 1 --branch ${PROJECT_BRANCH} \
    https://gitlab.com/DeerMaximum/ta-coe.git /opt/ta-coe

WORKDIR /opt/ta-coe

# Python-Abhängigkeiten installieren
RUN AIOHTTP_NO_EXTENSIONS=1 pip install --no-cache-dir -r requirements.txt

# Build-Abhängigkeiten entfernen
RUN apk del --no-cache --purge .build-dependencies

# Optional: Ports deklarieren
EXPOSE 9000 5441/udp 5442/udp
