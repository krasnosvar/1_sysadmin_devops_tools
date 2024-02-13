# pip3 install kafka-python
from kafka.admin import KafkaAdminClient, NewTopic


admin_client = KafkaAdminClient(
    bootstrap_servers="FQDN-kafka-server:9094", 
    client_id='test'
)

topic_list = []
topic_list.append(NewTopic(name="example_topic", num_partitions=1, replication_factor=1))
admin_client.create_topics(new_topics=topic_list, validate_only=False)


# from kafka import KafkaProducer
# import os


# producer = KafkaProducer(security_protocol="PLAINTEXT",
#                          bootstrap_servers=os.environ.get('KAFKA_HOST', '10.8.153.7:9094'))
