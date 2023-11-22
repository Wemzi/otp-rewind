import json
import requests
from translate import Translator
from deep_translator import GoogleTranslator

headers = {"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYjhmOTdmMDItN2JkNS00NDZkLTgzODMtMWU5ZjM3NjEwYTY2IiwidHlwZSI6ImFwaV90b2tlbiJ9.C6QKw3-54iH5bZOLWObLeli5okI8bAxSwriD7gvGXjk"}
url ="https://api.edenai.run/v2/text/generation"
translator1 = Translator(to_lang="hu")
translator2 = GoogleTranslator(source='auto', target='hu')

def GetTranslation(originalText) -> str :
    translation = translator1.translate(originalText)
    if(translation.lower().find("you used all available free translation") != -1):
        translation = translator2.translate(originalText)
    return translation


def GetGenAdvice(name, type):
    if type == "vendor":
        return GetGenTextFromVendor(name)
    if type == "category":
        return GetGenTextFromCategory(name)
    if type == "country":
        return GetGenTextFromCountry(name)

def GetGenTextFromVendor(vendor):
    payload = {
        "providers": "openai",
        "text": f"Generate funny advice to someone spending too much in {vendor}. One sentences max.",
        "temperature" : 1.0,
        "max_tokens" : 100
        }

    response = requests.post(url, json=payload, headers=headers)
    result = json.loads(response.text)
    print(result)
    print('-----')
    return GetTranslation(result['openai']['generated_text'])


def GetGenTextFromCountry(country):
    payload = {
        "providers": "openai",
        "text": f"Generate funny advice to someone spending too much when staying in {country}. One sentences max.",
        "temperature" : 1.0,
        "max_tokens" : 100
        }

    response = requests.post(url, json=payload, headers=headers)
    result = json.loads(response.text)
    print('-----')
    print(result)
    return GetTranslation(result['openai']['generated_text'])



def GetGenTextFromCategory(category):
    payload = {
        "providers": "openai",
        "text": f"Generate funny advice to someone spending too much on {category}. One sentences max.",
        "temperature" : 1.0,
        "max_tokens" : 100
        }

    response = requests.post(url, json=payload, headers=headers)
    result = json.loads(response.text)
    print('-----')
    print(result)
    return GetTranslation(result['openai']['generated_text'])



