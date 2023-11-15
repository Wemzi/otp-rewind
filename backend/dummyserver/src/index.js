const express = require("express");

const PORT = process.env.PORT || 4242;

const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());


fixdatas = 
[
    {
      "id": 1,
      "name": "Kis János",
      "country": "Hungary",
      "birthdate": "1999-07-21",
      "balance": 2351612,
      "extendedDataYearly": {
        "favouriteCountry": "Hungary",
        "visitedCountriesThisYear": 7,
        "easiestMonth": 798477,
        "hardestMonth": 1399755,
        "favouriteVendor": "Gucci",
        "topFacts": [
          {
            "name": "Slovenia",
            "topPercent": 2,
            "amount": 1887737,
            "type": "country"
          },
          {
            "name": "Hungary",
            "topPercent": 3.50,
            "amount": 4870455,
            "type": "country"
          },
          {
            "name": "Gucci",
            "topPercent": 4.5,
            "amount": 1310201,
            "type": "vendor"
          },
          {
            "name": "Clothing",
            "topPercent": 6.5,
            "amount": 2325021,
            "type": "category"
          },
          {
            "name": "Croatia",
            "topPercent": 9.5,
            "amount": 1675184,
            "type": "country"
          },
          {
            "name": "Lidl",
            "topPercent": 24,
            "amount": 1123031,
            "type": "vendor"
          },
          {
            "name": "Taxi",
            "topPercent": 24.5,
            "amount": 1062458,
            "type": "vendor"
          },
          {
            "name": "Dm",
            "topPercent": 25.5,
            "amount": 1068170,
            "type": "vendor"
          }
        ]
      },
      "averages": {
        "averageSpend": 1163019.63,
        "spentOnCategories": {
          "Home": 166510.54,
          "Groceries": 345584.63,
          "Clothing": 211365.54,
          "HealthBeauty": 170662.81,
          "Going_out": 81434.81,
          "Transport": 187461.27
        },
        "vendors": {
          "Praktiker": 77422,
          "Gucci": 119109.18,
          "Lidl": 102093.72,
          "Taxi": 96587.09,
          "Spar": 82988.27,
          "Rossmann": 73556.45,
          "Dm": 97106.36,
          "Tesco": 73046.72,
          "Rizmajer": 81434.81,
          "BKK": 90874.18,
          "Auchan": 87455.90,
          "Obi": 89088.54,
          "Hm": 92256.36
        },
        "countries": {
          "Turkey": 113011.72,
          "Germany": 88344.63,
          "Croatia": 152289.45,
          "Denmark": 99415.54,
          "Slovenia": 171612.45,
          "Austria": 105134.9,
          "Hungary": 442768.63
        }
      }
    },
    {
      "id": 2,
      "name": "Apró Jancsika",
      "country": "Hungary",
      "birthdate": "1989-11-11",
      "balance": 4000135,
      "extendedDataYearly": {
        "favouriteCountry": "Hungary",
        "visitedCountriesThisYear": 7,
        "easiestMonth": 771127,
        "hardestMonth": 1394097,
        "favouriteVendor": "Tesco",
        "topFacts": [
          {
            "name": "Austria",
            "topPercent": 3,
            "amount": 1762369,
            "type": "country"
          },
          {
            "name": "Tesco",
            "topPercent": 3.50,
            "amount": 1326662,
            "type": "vendor"
          },
          {
            "name": "Groceries",
            "topPercent": 3.50,
            "amount": 4468459,
            "type": "category"
          },
          {
            "name": "Rossmann",
            "topPercent": 13,
            "amount": 1149926,
            "type": "vendor"
          },
          {
            "name": "BKK",
            "topPercent": 22,
            "amount": 1097004,
            "type": "vendor"
          },
          {
            "name": "Denmark",
            "topPercent": 25,
            "amount": 1535627,
            "type": "country"
          },
          {
            "name": "Auchan",
            "topPercent": 29.5,
            "amount": 1040365,
            "type": "vendor"
          },
          {
            "name": "Lidl",
            "topPercent": 34.5,
            "amount": 1064243,
            "type": "vendor"
          }
        ]
      },
      "averages": {
        "averageSpend": 1084693.63,
        "spentOnCategories": {
          "Home": 126843.45,
          "Groceries": 406223.54,
          "Clothing": 126206.27,
          "HealthBeauty": 173591.09,
          "Going_out": 74137.72,
          "Transport": 177691.54
        },
        "vendors": {
          "Praktiker": 67984.09,
          "Gucci": 69503.5,
          "Lidl": 96749.36,
          "Taxi": 77963.90,
          "Spar": 94289.90,
          "Rossmann": 104538.72,
          "Dm": 75957.6,
          "Tesco": 120605.63,
          "Rizmajer": 74137.72,
          "BKK": 99727.63,
          "Auchan": 94578.63,
          "Obi": 80931.62,
          "Hm": 77026
        },
        "countries": {
          "Turkey": 104027.54,
          "Germany": 130821.36,
          "Croatia": 104121.72,
          "Denmark": 139602.45,
          "Slovenia": 100177.36,
          "Austria": 160215.36,
          "Hungary": 345727.81
        }
      }
    },
    {
      "id": 3,
      "name": "Little Jhonny",
      "country": "England",
      "birthdate": "1979-01-10",
      "balance": 555123,
      "extendedDataYearly": {
        "favouriteCountry": "Hungary",
        "visitedCountriesThisYear": 7,
        "easiestMonth": 488693,
        "hardestMonth": 1550859,
        "favouriteVendor": "Spar",
        "topFacts": [
          {
            "name": "Spar",
            "topPercent": 3,
            "amount": 1326062,
            "type": "vendor"
          },
          {
            "name": "Rizmajer",
            "topPercent": 6.5,
            "amount": 1254586,
            "type": "vendor"
          },
          {
            "name": "Going_out",
            "topPercent": 6.5,
            "amount": 1254586,
            "type": "category"
          },
          {
            "name": "Groceries",
            "topPercent": 23.5,
            "amount": 4174099,
            "type": "category"
          },
          {
            "name": "Obi",
            "topPercent": 27.50,
            "amount": 1073642,
            "type": "vendor"
          },
          {
            "name": "Austria",
            "topPercent": 28.99,
            "amount": 1491950,
            "type": "country"
          },
          {
            "name": "Home",
            "topPercent": 31,
            "amount": 2064103,
            "type": "category"
          },
          {
            "name": "Turkey",
            "topPercent": 32.5,
            "amount": 1453095,
            "type": "country"
          }
        ]
      },
      "averages": {
        "averageSpend": 1124809,
        "spentOnCategories": {
          "Home": 187645.72,
          "Groceries": 379463.54,
          "Clothing": 161446.72,
          "HealthBeauty": 144552.72,
          "Going_out": 114053.27,
          "Transport": 151411.7
        },
        "vendors": {
          "Praktiker": 90041.90,
          "Gucci": 69962.27,
          "Lidl": 75489.63,
          "Taxi": 86491.22,
          "Spar": 120551.09,
          "Rossmann": 67196.7,
          "Dm": 83464.81,
          "Tesco": 94024.36,
          "Rizmajer": 114053.27,
          "BKK": 73569.6,
          "Auchan": 89398.45,
          "Obi": 97603.81,
          "Hm": 91484.45
        },
        "countries": {
          "Turkey": 132099.54,
          "Germany": 118203.09,
          "Croatia": 123736.54,
          "Denmark": 125757,
          "Slovenia": 130209.63,
          "Austria": 135631.81,
          "Hungary": 359171.36
        }
      }
    },
    {
      "id": 4,
      "name": "Lil Jhon",
      "country": "USA",
      "birthdate": "1988-12-21",
      "balance": 4420042,
      "extendedDataYearly": {
        "favouriteCountry": "Hungary",
        "visitedCountriesThisYear": 7,
        "easiestMonth": 729287,
        "hardestMonth": 1431563,
        "favouriteVendor": "BKK",
        "topFacts": [
          {
            "name": "Denmark",
            "topPercent": 2,
            "amount": 1894738,
            "type": "country"
          },
          {
            "name": "BKK",
            "topPercent": 8.5,
            "amount": 1245680,
            "type": "vendor"
          },
          {
            "name": "Spar",
            "topPercent": 13,
            "amount": 1169091,
            "type": "vendor"
          },
          {
            "name": "Rossmann",
            "topPercent": 18.5,
            "amount": 1120181,
            "type": "vendor"
          },
          {
            "name": "Transport",
            "topPercent": 19.5,
            "amount": 2155448,
            "type": "category"
          },
          {
            "name": "Germany",
            "topPercent": 32.5,
            "amount": 1487673,
            "type": "country"
          },
          {
            "name": "Gucci",
            "topPercent": 46.5,
            "amount": 1004280,
            "type": "vendor"
          },
          {
            "name": "Clothing",
            "topPercent": 47,
            "amount": 1942310,
            "type": "category"
          }
        ]
      },
      "averages": {
        "averageSpend": 1114208.90,
        "spentOnCategories": {
          "Home": 145941.45,
          "Groceries": 340447.90,
          "Clothing": 176573.63,
          "HealthBeauty": 173024.72,
          "Going_out": 90498.5,
          "Transport": 195949.81
        },
        "vendors": {
          "Praktiker": 94218.2,
          "Gucci": 100428,
          "Lidl": 82015.18,
          "Taxi": 82706.18,
          "Spar": 106281,
          "Rossmann": 101834.63,
          "Dm": 87010.11,
          "Tesco": 84160.66,
          "Rizmajer": 90498.5,
          "BKK": 113243.63,
          "Auchan": 83293,
          "Obi": 60288.54,
          "Hm": 85275.45
        },
        "countries": {
          "Turkey": 122501.90,
          "Germany": 135243,
          "Croatia": 111651.63,
          "Denmark": 172248.90,
          "Slovenia": 110495.09,
          "Austria": 118385.18,
          "Hungary": 343683.18
        }
      }
    },
    {
      "id": 5,
      "name": "Petit Jean",
      "country": "France",
      "birthdate": "1976-06-07",
      "balance": 1234567,
      "extendedDataYearly": {
        "favouriteCountry": "Hungary",
        "visitedCountriesThisYear": 7,
        "easiestMonth": 1018654,
        "hardestMonth": 1601311,
        "favouriteVendor": "Rizmajer",
        "topFacts": [
          {
            "name": "Slovenia",
            "topPercent": 1,
            "amount": 1969031,
            "type": "country"
          },
          {
            "name": "Rizmajer",
            "topPercent": 2,
            "amount": 1395435,
            "type": "vendor"
          },
          {
            "name": "Going_out",
            "topPercent": 2,
            "amount": 1395435,
            "type": "category"
          },
          {
            "name": "Taxi",
            "topPercent": 2.5,
            "amount": 1349870,
            "type": "vendor"
          },
          {
            "name": "Home",
            "topPercent": 4,
            "amount": 2469550,
            "type": "category"
          },
          {
            "name": "Rossmann",
            "topPercent": 6,
            "amount": 1220632,
            "type": "vendor"
          },
          {
            "name": "Germany",
            "topPercent": 6,
            "amount": 1733361,
            "type": "country"
          },
          {
            "name": "Turkey",
            "topPercent": 6.5,
            "amount": 1731894,
            "type": "country"
          }
        ]
      },
      "averages": {
        "averageSpend": 1287306.63,
        "spentOnCategories": {
          "Home": 224504.54,
          "Groceries": 361166.72,
          "Clothing": 185197.81,
          "HealthBeauty": 186904.09,
          "Going_out": 126857.72,
          "Transport": 202675.72
        },
        "vendors": {
          "Praktiker": 115925.09,
          "Gucci": 93009.90,
          "Lidl": 91529.36,
          "Taxi": 122715.45,
          "Spar": 96672,
          "Rossmann": 110966.54,
          "Dm": 75937.54,
          "Tesco": 76220.81,
          "Rizmajer": 126857.72,
          "BKK": 79960.27,
          "Auchan": 106419,
          "Obi": 108579.45,
          "Hm": 92187.90
        },
        "countries": {
          "Turkey": 157444.90,
          "Germany": 157578.27,
          "Croatia": 124111.45,
          "Denmark": 142516.63,
          "Slovenia": 179002.81,
          "Austria": 121896.72,
          "Hungary": 404755.81
        }
      }
    },
    {
      "id": 6,
      "name": "Kicsi Jónás",
      "country": "Hungary",
      "birthdate": "2000-04-30",
      "balance": 782,
      "extendedDataYearly": {
        "favouriteCountry": "Hungary",
        "visitedCountriesThisYear": 7,
        "easiestMonth": 899403,
        "hardestMonth": 1623290,
        "favouriteVendor": "Lidl",
        "topFacts": [
          {
            "name": "Groceries",
            "topPercent": 8,
            "amount": 4381537,
            "type": "category"
          },
          {
            "name": "Turkey",
            "topPercent": 8.5,
            "amount": 1721044,
            "type": "country"
          },
          {
            "name": "Slovenia",
            "topPercent": 10,
            "amount": 1709464,
            "type": "country"
          },
          {
            "name": "Lidl",
            "topPercent": 11,
            "amount": 1202684,
            "type": "vendor"
          },
          {
            "name": "Rossmann",
            "topPercent": 11.5,
            "amount": 1179016,
            "type": "vendor"
          },
          {
            "name": "Taxi",
            "topPercent": 12,
            "amount": 1202102,
            "type": "vendor"
          },
          {
            "name": "Praktiker",
            "topPercent": 15,
            "amount": 1181861,
            "type": "vendor"
          },
          {
            "name": "Tesco",
            "topPercent": 21.5,
            "amount": 1118324,
            "type": "vendor"
          }
        ]
      },
      "averages": {
        "averageSpend": 1175825.09,
        "spentOnCategories": {
          "Home": 177381.90,
          "Groceries": 398321.54,
          "Clothing": 161323.09,
          "HealthBeauty": 187971.81,
          "Going_out": 65618.63,
          "Transport": 185208.09
        },
        "vendors": {
          "Praktiker": 107441.90,
          "Gucci": 91973,
          "Lidl": 109334.90,
          "Taxi": 109282,
          "Spar": 89268.09,
          "Rossmann": 107183.27,
          "Dm": 88867.4,
          "Tesco": 111832.4,
          "Rizmajer": 65618.63,
          "BKK": 83518.7,
          "Auchan": 98052.72,
          "Obi": 69940,
          "Hm": 69350.09
        },
        "countries": {
          "Turkey": 156458.54,
          "Germany": 140038.90,
          "Croatia": 113636.63,
          "Denmark": 106323.36,
          "Slovenia": 155405.81,
          "Austria": 124199.18,
          "Hungary": 379762.63
        }
      }
    }
  ];

app.listen(PORT, ()=>{
    //console.log(`Server listening on ${PORT}`);
});

app.param('index', function(req,res,next,index) {
  const modified = parseInt(index)
  req.index = modified
  next()
});

app.get('/isReady', async (req, res) => {
    res.send({
        ready: true
    });
});


app.get('/:index', async (req, res) => {
    res.send({
         "currentUser": fixdatas[req.index - 1]
    })
});

