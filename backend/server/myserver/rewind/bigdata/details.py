from  rewind.bigdata.dataprovider import getData
from pyspark.sql.functions import col, sum, desc, lit, monotonically_increasing_id, month, avg, min, max

    
def GetTopPercent(df, user_id, groupName):
    groups = df.select(col(groupName).alias("name")).distinct().collect()
    groupsdata = []
    for group in groups:
        groupdata = {}
        ranking = df.filter(df[groupName] == group.name)\
            .groupBy("id")\
            .agg(sum("balance").alias("allAmount"))\
            .orderBy(desc("allAmount"))\
            .withColumn("rank", lit(monotonically_increasing_id()+1))
        usersnum = ranking.count()
        currentUser = ranking.filter(ranking.id == user_id).collect()[0]
        groupdata["name"] = group.name
        groupdata["topPercent"] = (currentUser.rank) / usersnum * 100
        groupdata["amount"] = currentUser.allAmount
        groupdata["type"] = groupName
        groupsdata.append(groupdata)
    return groupsdata


def GetAverage(df,user_id, groupName):
    groups = df.select(col(groupName).alias("name")).distinct().collect()
    groupsdata = {}
    for group in groups:
        avgAmount = df.filter(df.id == user_id)\
                    .filter(df[groupName] == group.name)\
                    .groupBy(month("date").alias("month"))\
                    .agg(sum("balance").alias("allAmount"))\
                    .select(avg("allAmount").alias("avgAmount")).collect()[0].avgAmount
        groupsdata[group.name] = avgAmount
    return groupsdata        
 
def GetDetailsData(user_id : int) :
    df = getData()
    monthOrder = df.filter(df.id == user_id).groupBy(month("date").alias("month")).agg(sum("balance").alias("amount")).orderBy(desc("amount")).collect()
    return {
        "vendorDatas" :  GetTopPercent(df,user_id,"vendor"),
        "categoryDatas" :  GetTopPercent(df,user_id,"category"),
        "countryDatas" :  GetTopPercent(df,user_id,"country"),
        "visitedCountriesThisYear" : df.filter(df.id == user_id).select("country").distinct().count(),
        "hardestMounth" : monthOrder[0].month,
        "easiestMounth" : monthOrder[0].month,
        "favoriteCountry" : df.filter(df.id == user_id).groupBy("country").agg(sum(df.balance).alias("amount")).orderBy(desc("amount")).collect()[0].country,
        "favoriteVendor" : df.filter(df.id == user_id).groupBy("vendor").agg(sum(df.balance).alias("amount")).orderBy(desc("amount")).collect()[0].vendor,
        "vendorAvgDatas" :  GetAverage(df,user_id,"vendor"),
        "categoryAvgDatas" :  GetAverage(df,user_id,"category"),
        "countryAvgDatas" :  GetAverage(df,user_id,"country"),
        "averageSpend" :  df.filter(df.id == user_id).groupBy(month("date").alias("month")).agg(sum("balance").alias("amount")).select(avg("amount").alias("avgamount")).collect()[0].avgamount
    }
    