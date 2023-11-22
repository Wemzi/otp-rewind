from  rewind.bigdata.dataprovider import GetData
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
        groupdata["topPercent"] = round(((currentUser.rank) / usersnum * 100), 1)
        groupdata["amount"] = currentUser.allAmount
        groupdata["type"] = groupName
        groupsdata.append(groupdata)
    return groupsdata


def GetAverage(df,user_id, groupName):
    groupsdata = {}
    monthlyAvgPerUser =  df.groupBy(["id", df[groupName].alias("name"), month("date").alias("month")])\
                .agg(sum("balance").alias("amount"))\
                    .groupBy(["id","name"])\
                    .agg(avg("amount").alias("amount"))
    AllAvg = monthlyAvgPerUser.groupBy("name")\
                                .agg(avg("amount").alias("amount"))
    groups = monthlyAvgPerUser.filter(df.id == user_id).select(["name","amount"])
    collectData = groups.alias("Current")\
                        .join(AllAvg.alias("ALL"), (AllAvg.name == groups.name), how="left")\
                        .withColumn("rate", groups.amount / AllAvg.amount * 100)\
                        .select(["Current.name", "Current.amount", "rate"]).collect()
    for data in collectData:
         groupsdata[data.name] = { 
                                    "amount" : int(round(data.amount)),
                                    "globalRate" : round(data.rate, 1)
                                }
    return groupsdata        
 
def GetDetailsData(user_id : int) :
    print(f"Get details for user_id: {user_id}")
    df = GetData()
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
    
