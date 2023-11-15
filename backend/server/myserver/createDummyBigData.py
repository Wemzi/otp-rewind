import json
from rewind.userData import GetUserData


userJson = """[
        { 
            "id" :  1,
            "name" : "Kis János",
            "country" : "Hungary",
            "birthdate" : "1999-07-21",
            "balance" : 2351612
        },
        { 
            "id" :  2,
            "name" : "Apró Jancsika",
            "country" : "Hungary",
            "birthdate" : "1989-11-11",
            "balance" : 4000135
        },
        { 
            "id" :  3,
            "name" : "Little Jhonny",
            "country" : "England",
            "birthdate" : "1979-01-10",
            "balance" : 555123
        },
        { 
            "id" :  4,
            "name" : "Lil Jhon",
            "country" : "USA",
            "birthdate" : "1988-12-21",
            "balance" : 4420042
        },
        { 
            "id" :  5,
            "name" : "Petit Jean",
            "country" : "France",
            "birthdate" : "1976-06-07",
            "balance" : 1234567
        },
        { 
            "id" :  6,
            "name" : "Kicsi Jónás",
            "country" : "Hungary",
            "birthdate" : "2000-04-30",
            "balance" : 782
        }
]"""
users = json.loads(userJson)

print("[")
for user in users:
    userdata = GetUserData(user)
    print(userdata)
    print(",")
print("]")