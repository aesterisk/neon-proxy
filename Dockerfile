ARG NEON_RELEASE_TAG=release-7845

FROM rust:bookworm AS rust-builder
ARG NEON_RELEASE_TAG

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
	apt-get update -qq \
	&& apt-get install -qq --no-install-recommends -o DPkg::Options::=--force-confold -o DPkg::Options::=--force-confdef \
	build-essential \
	pkg-config \
	git \
	libssl-dev \
	&& apt-get clean -qq && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 --branch $NEON_RELEASE_TAG https://github.com/neondatabase/neon.git
WORKDIR /neon

# caches rustup downloads
RUN cargo clean

RUN cargo build --bin proxy --release --features "testing"

FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
	apt-get update -qq \
	&& apt-get install -qq --no-install-recommends -o DPkg::Options::=--force-confold -o DPkg::Options::=--force-confdef \
	curl \
	ca-certificates \
	openssl \
	postgresql-client \
	&& apt-get clean -qq && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=rust-builder /neon/target/release/proxy ./neon-proxy

COPY ./start.sh start.sh

RUN chmod +x start.sh

EXPOSE 4445
ENTRYPOINT ["./start.sh"]

LABEL org.opencontainer.image.source=https://github.com/aesterisk/neon-proxy
LABEL org.opencontainer.image.description="Serverless Postgres for everyone."
LABEL org.opencontainer.image.licenses=Apache-2.0
