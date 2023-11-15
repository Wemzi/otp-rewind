from  pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()

df = spark.read.options(inferSchema=True, header=True).csv("/home/pi/server/db/bigdata/rewind_history.csv")
def getData():
    return df