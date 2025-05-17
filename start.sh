#!/bin/bash

if [ -z "$PG_CONNECTION_STRING" ]; then
	echo "PG_CONNECTION_STRING is not set"
	exit 1
fi

psql -Atx $PG_CONNECTION_STRING \
	-c "CREATE SCHEMA IF NOT EXISTS neon_control_plane" \
	-c "CREATE TABLE neon_control_plane.endpoints (endpoint_id VARCHAR(255) PRIMARY KEY, allowed_ips VARCHAR(255))"

./neon-proxy --help

./neon-proxy \
  -c /etc/neon/neon.pem \
  -k /etc/neon/neon.key \
  --auth-backend=postgres \
  --auth-endpoint=$PG_CONNECTION_STRING \
  --wss=0.0.0.0:4445
