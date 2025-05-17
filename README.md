# Aesterisk Neon Proxy

> This is a modified version of [`TimoWilhelm/local-neon-http-proxy ↗`](https://github.com/TimoWilhelm/local-neon-http-proxy)
> used for [`Aesterisk ↗`](https://github.com/aesterisk/aesterisk) development but built with portability in mind,
> and thus can be used for whatever project you want.

## About

The [`Neon Proxy ↗`](https://github.com/github.com/neondatabase/neon/tree/main/proxy)
is a way to use a regular [`PostgreSQL ↗`](https://github.com/postgres/postgres) database
hosted by yourself (including locally) with Neon's Serverless Postgres packages and
solutions (such as [`neondatabase/serverless ↗`](https://github.com/neondatabase/serverless)).

This is intended as a solution to **fully local** development purposes when building for
Serverless Postgres by Neon, and has not been tested for production reasons.

## Usage

1. Pull the Docker image at `ghcr.io/aesterisk/neon-proxy`.

2. Add an environment variable for your `PostgreSQL` connection string:
   - `PG_CONNECTION_STRING=postgresql://user:password@host:port/database`.

3. Bind your SSL certificate and key:
   - `./example.com.pem:/etc/neon/neon.pem`
   - `./example.com.key:/etc/neon/neon.key`

4. Profit!

## License

As this is just a wrapper Docker image, this is licensed the same as the actual code in
[`neondatabase/neon ↗`](https://github.com/neondatabase/neon), namely `Apache-2.0` (instead of [`aesterisk/aesterisk`](https://github.com/aesterisk/aesterisk)'s `AGPL-3.0`).

See [`LICENSE ↗`](https://github.com/aesterisk/neon-proxy/tree/main/LICENSE) for a copy.
