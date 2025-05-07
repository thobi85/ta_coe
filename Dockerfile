FROM python:3.12-alpine

LABEL \
  org.opencontainers.image.title="Home Assistant Add-on: CoE to HTTP server" \
  org.opencontainers.image.description="An addon to allows interaction with a C.M.I. as a CoE device, using a HTTP API." \
  org.opencontainers.image.licenses="MIT License"

# Arch- und projektbezogene Variablen
ARG TEMPIO_VERSION=2021.09.0
ARG TARGETARCH
ARG PROJECT_BRANCH=2.14

# Install tempio (arch-spezifisch)
RUN curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${TARGETARCH}" \
    && chmod +x /usr/bin/tempio

# Build-Abhängigkeiten installieren
RUN apk add --no-cache --virtual .build-dependencies \
    build-base linux-headers gcc python3-dev git cargo

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
