from rewind.bigdata.details import GetDetailsData
from rewind.ai.genText import GetGenAdvice

def GetUserData(user):
    bigdata = GetDetailsData(user["id"])
    topFacts = []
    [topFacts.append(x) for x in sorted(bigdata["vendorDatas"], key=lambda x: x["topPercent"])[:5]]
    [topFacts.append(x) for x in sorted(bigdata["categoryDatas"], key=lambda x: x["topPercent"])[:5]]
    [topFacts.append(x) for x in sorted(bigdata["countryDatas"], key=lambda x: x["topPercent"])[:5]]
    topFacts = sorted(topFacts, key=lambda x: x["topPercent"])[:8]
    for fact in topFacts:
        fact["advice"] = GetGenAdvice(fact["name"], fact["type"])
    return {
        "id": user["id"],
        "name": user["name"],
        "country": user["country"],
        "birthdate": user["birthdate"],
        "balance": user["balance"],
        "extendedDataYearly":{
            "favouriteCountry":bigdata["favoriteCountry"],
            "visitedCountriesThisYear":bigdata["visitedCountriesThisYear"],
            "easiestMonth":bigdata["easiestMounth"],
            "hardestMonth":bigdata["hardestMounth"],
            "favouriteVendor":bigdata["favoriteVendor"],
            "topFacts": topFacts
        },
        "averages":{
            "averageSpend":bigdata["averageSpend"],
            "spentOnCategories": bigdata["categoryAvgDatas"],
            "vendors": bigdata["vendorAvgDatas"],
            "countries":bigdata["countryAvgDatas"]
        }   
    }