# Technical Report Outline — Library Hub

## 1. Requirements and workload analysis
Describe the Library Hub scenario, users, required operations, and the query-first design method. Include the required M1–M6, C1–C2, G1–G3, Redis, S1–S2, and A1–A3 evidence.

## 2. Database selection
Explain why each technology is used for a distinct workload:

- **MySQL:** authoritative relational state for members, physical copies, and loans. Foreign keys, indexes, transactions, row locking, and the stored procedure enforce borrowing rules.
- **MongoDB:** authoritative catalogue documents. Embedded `attributes` demonstrate category-specific fields without nullable columns or a rigid table hierarchy.
- **Kafka:** asynchronous transport for library events. It decouples event producers from activity consumers; broker administration is outside the assessment scope.
- **Cassandra:** denormalised, append-oriented activity read models. Partitioning by member or book and descending event-time clustering make recent activity queries efficient without filtering.
- **Redis:** low-latency derived availability counts. It is not authoritative and is reconstructed from MySQL copies.
- **OpenSearch:** full-text and structured catalogue search. MongoDB remains the source of truth and the index is rebuildable.
- **ClickHouse:** append-oriented analytical loan facts and aggregation queries. It is not used for transactional updates.

## 3. Data modelling and query evidence
For every database use the chain `requirement → query → workload → model → keys/indexes → result`.

### MySQL
Explain `members`, `books`, `copies`, and `loans`; primary/foreign keys; indexes; the trigger; and `borrow_book`. Show BEFORE → TRANSACTION → AFTER and the failed double-loan attempt.

### Cassandra
Explain both tables, partition keys, clustering columns, denormalisation, and why the two access paths are separate tables. Include C1 and C2 returned rows.

### MongoDB
Explain embedded `attributes`, variable document shape, indexes, and the three queries. Include returned documents.

### Redis
Document key `BOOK:AVAILABLE:<book_id>`, integer value, update operations, MySQL authority, and rebuild query. Explain cache loss and stale values.

### OpenSearch
Document the index mapping, source-of-truth relationship, indexing process, text relevance, and category filter. Include total hits and selected fields.

### ClickHouse
Explain the `loan_facts` analytical representation, `MergeTree`, ordering key, and the results for daily, top-book, and category aggregations.

## 4. Kafka integration
Show `application → library-events → Cassandra` with one event payload, producer output, consumer output, and destination rows. Explain asynchronous propagation and duplicate/replay considerations.

## 5. Architecture
Include the Mermaid diagram from the README or export it as an image. Label authoritative and derived data and all seven technologies.

## 6. Consistency and transactions
Explain MySQL row locking, the copy status transition, the trigger, and why Redis/Cassandra/OpenSearch/ClickHouse are eventually consistent read or analytical models.

## 7. Failure and recovery analysis
- MySQL unavailable: loans and authoritative availability stop; derived reads may remain stale; recover from backups.
- MongoDB unavailable: catalogue writes and authoritative catalogue reads stop; search may continue with stale data; rebuild OpenSearch from MongoDB backup.
- Kafka unavailable: new event propagation pauses; MySQL transactions can continue if designed independently; replay queued/retained events later.
- Cassandra unavailable: activity history reads stop; source events can be replayed.
- Redis unavailable: fast availability reads stop or fall back to MySQL; rebuild counts from `copies`.
- OpenSearch unavailable: search stops; catalogue remains available through MongoDB; reindex catalogue documents.
- ClickHouse unavailable: reports stop; reload loan facts from MySQL.

## 8. One-database discussion
A single relational database would simplify deployment, joins, backup, and strong consistency. It would compromise flexible catalogue documents, low-latency cache access, text relevance, scalable event history, and analytical workload isolation. The seven-component design increases operational complexity but makes workload choices explicit and independently optimisable.

## 9. Reproducibility
Record Docker version, startup commands, initialization order, sample data commands, query commands, and actual output screenshots/tables. The report must describe any manual readiness wait required by Cassandra, Kafka, or OpenSearch.
