# Use Debian as the base image
FROM debian:latest

# Set environment variables to make Chrome run without complaints
ENV DEBIAN_FRONTEND=noninteractive


# Install necessary packages and dependencies for Chrome and xvfb
RUN apt-get update && apt-get install -y xvfb chromium \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]


CMD ["xvfb-run", "chromium", "--no-sandbox", "--remote-debugging-port=9222" ]