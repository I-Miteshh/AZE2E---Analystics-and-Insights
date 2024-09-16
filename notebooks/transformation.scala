// Import required Spark libraries
import org.apache.spark.sql.{SparkSession, DataFrame}
import org.apache.spark.sql.functions._

// Define the Spark session
val spark = SparkSession.builder
  .appName("AZE2E Uber Pickup Transformation")
  .getOrCreate()

// Load the dataset from Azure Data Lake
val uberPickupsDF = spark.read.option("header", "true")
  .csv("dbfs:/mnt/your_adls/uber-pickups.csv")

// Basic transformation: Filter data for a specific day and group by hour
val filteredDF = uberPickupsDF.filter(col("pickup_date") === "2021-01-01")
val hourlyPickupsDF = filteredDF.groupBy(hour(col("pickup_time")))
  .count()
  .orderBy(col("hour(pickup_time)").asc)

// Show the result of the transformation
hourlyPickupsDF.show()

// Write transformed data to Azure SQL Database
hourlyPickupsDF.write
  .format("jdbc")
  .option("url", "jdbc:sqlserver://your_server.database.windows.net;database=your_db")
  .option("dbtable", "dbo.hourly_pickups")
  .option("user", "your_username")
  .option("password", "your_password")
  .save()

spark.stop()
