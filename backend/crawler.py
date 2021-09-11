import sys
sys.path.append('/usr/lib/python3/dist-packages')

from urllib.parse import urlencode, unquote
import requests
import json

requests.packages.urllib3.disable_warnings()
requests.packages.urllib3.util.ssl_.DEFAULT_CIPHERS += ':HIGH:!DH:!aNULL'
try:
    requests.packages.urllib3.contrib.pyopenssl.util.ssl_.DEFAULT_CIPHERS += ':HIGH:!DH:!aNULL'
except AttributeError:
    # no pyopenssl support used / needed / available
    pass

url = "https://openapi.mnd.go.kr/3935313630333536343431323332303830/json/DS_TB_MNDT_DATEBYMLSVC_8623/11/12/"
queryString = "?" + urlencode(
{
  "Key": 3935313630333536343431323332303830,
  "TYPE": "json",
  "SERVICE": "DS_TB_MNDT_DATEBYMLSVC_8623",
  "START_INDEX": 0,
  "END_INDEX": 5
}
)
queryURL = url + queryString
response = requests.get(queryURL)
jsonObject = json.loads(response.text)
print(jsonObject.get("DS_TB_MNDT_DATEBYMLSVC_8623").get("row")[1].get("lunc"))
"""
print("=== response json data start ===")
print(response.text)
print("=== response json data end ===")
print()
"""