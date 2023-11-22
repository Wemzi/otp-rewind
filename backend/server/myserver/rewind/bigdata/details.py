from  rewind.bigdata.dataprovider import getData
from pyspark.sql.functions import col, sum, desc, lit, monotonically_increasing_id, month, avg, min, max
from rewind.ai.genText import GetGenAdvice
    
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
        groupdata["topPercent"] = round(((currentUser.rank) / usersnum * 100), 1)
        groupdata["amount"] = currentUser.allAmount
        groupdata["type"] = groupName
        groupdata["advice"] = GetGenAdvice(group.name, groupName)
        groupsdata.append(groupdata)
    return groupsdata


def GetAverage(df,user_id, groupName):
    groupsdata = {}
    groups = df.filter(df.id == user_id).groupBy([df[groupName].alias("name"), month("date").alias("month")]).agg(sum("balance").alias("amount")).groupBy("name").agg(avg("amount").alias("avgAmount")).collect() 

    for group in groups:
        groupsdata[group.name] = int(round(group.avgAmount))
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
        "easiestMounth" : monthOrder[-1].month,
        "favoriteCountry" : df.filter(df.id == user_id).groupBy("country").agg(sum(df.balance).alias("amount")).orderBy(desc("amount")).collect()[0].country,
        "favoriteVendor" : df.filter(df.id == user_id).groupBy("vendor").agg(sum(df.balance).alias("amount")).orderBy(desc("amount")).collect()[0].vendor,
        "vendorAvgDatas" :  GetAverage(df,user_id,"vendor"),
        "categoryAvgDatas" :  GetAverage(df,user_id,"category"),
        "countryAvgDatas" :  GetAverage(df,user_id,"country"),
        "averageSpend" :  df.filter(df.id == user_id).groupBy(month("date").alias("month")).agg(sum("balance").alias("amount")).select(avg("amount").alias("avgamount")).collect()[0].avgamount
    }
    
    
