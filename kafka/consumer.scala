// Import Spark libraries
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._
import org.apache.spark.sql.SparkSession

// Create Spark session
val spark = SparkSession.builder
  .appName("Kafka Event Hub Consumer")
  .getOrCreate()

// Kafka parameters to connect to Event Hubs
val eventHubParams = Map(
  "kafka.bootstrap.servers" -> "your_eventhub_namespace.servicebus.windows.net:9093",
  "subscribe" -> "uber-pickups",
  "kafka.security.protocol" -> "SASL_SSL",
  "kafka.sasl.mechanism" -> "PLAIN",
  "kafka.sasl.jaas.config" -> s"org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"your_eventhub_connection_string\";"
)

// Read data from Kafka
val kafkaDF = spark
  .readStream
  .format("kafka")
  .options(eventHubParams)
  .load()

// Define schema for the incoming JSON data
val schema = new StructType()
  .add("pickup_time", StringType)
  .add("pickup_lat", DoubleType)
  .add("pickup_long", DoubleType)

// Parse JSON and extract relevant fields
val uberDF = kafkaDF.selectExpr("CAST(value AS STRING) as json")
  .select(from_json(col("json"), schema).as("data"))
  .select("data.*")

// Basic transformation: Group data by pickup time (hour)
val groupedDF = uberDF
  .withColumn("pickup_hour", hour(col("pickup_time")))
  .groupBy("pickup_hour")
  .count()

// Write transformed data to Azure SQL Database
groupedDF.writeStream
  .format("jdbc")
  .option("url", "jdbc:sqlserver://your_server.database.windows.net;database=your_db")
  .option("dbtable", "dbo.hourly_pickups")
  .option("user", "your_username")
  .option("password", "your_password")
  .start()

spark.streams.awaitAnyTermination()
