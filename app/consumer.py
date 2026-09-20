import json
from kafka import KafkaConsumer
from cassandra.cluster import Cluster

cluster = Cluster(['localhost'])
session = cluster.connect('libraryhub')
consumer = KafkaConsumer('library-events', bootstrap_servers='localhost:9092', value_deserializer=lambda v: json.loads(v.decode()), auto_offset_reset='earliest', enable_auto_commit=True, group_id='library-cassandra-writer')
for message in consumer:
 e = message.value
 session.execute('INSERT INTO member_activity (member_id,event_time,event_id,event_type,book_id,details) VALUES (%s,%s,%s,%s,%s,%s)', (e['member_id'], e['event_time'], e['event_id'], e['event_type'], e['book_id'], e.get('details','')))
 session.execute('INSERT INTO book_activity (book_id,event_time,event_id,event_type,member_id,details) VALUES (%s,%s,%s,%s,%s,%s)', (e['book_id'], e['event_time'], e['event_id'], e['event_type'], e['member_id'], e.get('details','')))
 print('Persisted', e['event_id'])
