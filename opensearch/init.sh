#!/usr/bin/env sh
set -e
until curl -sf http://opensearch:9200 >/dev/null; do sleep 3; done
curl -sf -X PUT http://opensearch:9200/books -H 'Content-Type: application/json' --data-binary @/mappings/books.json || true
curl -sf -X POST http://opensearch:9200/books/_bulk -H 'Content-Type: application/x-ndjson' --data-binary $'{"index":{"_id":"BOOK-001"}}\n{"isbn":"9780000000011","title":"Distributed Systems in Practice","author":"Marta Silva","description":"A practical guide to distributed databases and event-driven systems.","category":"Technical","year":2024,"keywords":["databases","distributed","kafka"]}\n{"index":{"_id":"BOOK-002"}}\n{"isbn":"9780000000028","title":"SQL Fundamentals","author":"Rui Costa","description":"Relational modelling, SQL queries, indexes and transactions.","category":"Technical","year":2023,"keywords":["sql","relational"]}\n'
