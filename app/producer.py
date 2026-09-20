import json, time
from kafka import KafkaProducer

producer = KafkaProducer(bootstrap_servers='localhost:9092', value_serializer=lambda v: json.dumps(v).encode())
events = [
 {'event_id':'evt-app-1','event_type':'BOOK_VIEWED','member_id':'MEMBER-002','book_id':'BOOK-002','event_time':'2026-09-21T10:00:00Z','details':'search result'},
 {'event_id':'evt-app-2','event_type':'BOOK_BORROWED','member_id':'MEMBER-002','book_id':'BOOK-002','event_time':'2026-09-21T10:01:00Z','details':'copy 201'}
]
for event in events:
 producer.send('library-events', event)
producer.flush()
print(f'Sent {len(events)} events')
