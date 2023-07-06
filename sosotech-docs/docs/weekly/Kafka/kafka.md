# Kafka
Apache Kafka is a distributed event store and stream-processing platform.
Source Systems --> stream data to Kafka --> Kafka --> target systems consume the data dtored in Kafka

## Kafka and Zookeeper
Kafka and ZooKeeper work in conjunction to form a complete Kafka Cluster ⁠— with ZooKeeper providing 
the distributed clustering services, and Kafka handling the actual data streams and connectivity to clients.  

ZooKeeper kinda handles the leadership election of Kafka brokers and manages service discovery as well as 
cluster topology so each broker knows when brokers have entered or exited the cluster, when a broker dies 
and who the preferred leader node is for a given topic/partition pair. 
It also tracks when topics are created or deleted from the cluster and maintains a topic list. 
In general, ZooKeeper provides an in-sync view of the Kafka cluster.  

Kafka, on the other hand, is dedicated to handling the actual connections from the clients (producers and consumers) 
as well as managing the topic logs, topic log partitions, consumer groups ,and individual offsets.

## Forward messages from Pub/Sub to Kafka
- Use the gcloud CLI to create a Pub/Sub topic with a subscription. ...
- Open the file named /config/cps-source-connector.properties in a text editor. ...
- From the Kafka directory, run the following command: ...
- Use the gcloud CLI to publish a message to Pub/Sub. ...
- Read the message from Kafka.

## Streaming Kafka Messages to Google Cloud Pub/Sub
- Publisher publish messages that subscriber consumed.
- (a) Firstly, Configure the Pub/Sub topics to communicate with Kafka:
- Secondly to create a subscription for the to-kafka topic:
-  create a subscription for traffic published from Kafka for Data exchange between Kafka and Pub/Sub

## BigQuery 
is Google's fully managed, serverless data warehouse that enables scalable analysis over petabytes of data.
