import csv
import json

path="/home/pi/server/db/otpusers/user.csv"
with open(path) as f:
        users = []
        reader = csv.reader(f)
        first = True
        for row in reader:
            if first:
                first = False
                continue
            user = {
            "pk": int(row[0])+1,
            "model": "rewind.user",
            "fields" :{
                "id":       int(row[0])+1,
                "name":     row[1] + " " + row[2],
                "country":  row[3],
                "birthdate":row[4],
                "balance":  int(row[5]) 
                }
            }
            users.append(user)
        print(json.dumps(users, indent=2))
