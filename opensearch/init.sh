#!/usr/bin/env sh
set -e
OS=http://opensearch:9200
until curl -sf "$OS" >/dev/null; do echo "waiting for opensearch..."; sleep 3; done
# Create the index with explicit mappings (ignore "already exists" on re-runs).
curl -s -X PUT "$OS/books" -H 'Content-Type: application/json' --data-binary @/opensearch/mappings/books.json || true
echo
# Bulk-index catalogue documents copied from MongoDB (source of truth); _id makes this idempotent.
curl -sf -X POST "$OS/books/_bulk?refresh=true" -H 'Content-Type: application/x-ndjson' --data-binary @/opensearch/data/books.ndjson
echo
echo "opensearch init done"
