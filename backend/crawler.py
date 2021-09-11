import sys
sys.path.append('/usr/lib/python3/dist-packages')

from urllib.parse import urlencode, unquote
import requests
import json
import pandas as pd

#SSL: DH_KEY_TOO_SMALL 오류 해결
requests.packages.urllib3.disable_warnings()
requests.packages.urllib3.util.ssl_.DEFAULT_CIPHERS += ':HIGH:!DH:!aNULL'
try:
    requests.packages.urllib3.contrib.pyopenssl.util.ssl_.DEFAULT_CIPHERS += ':HIGH:!DH:!aNULL'
except AttributeError:
    # no pyopenssl support used / needed / available
    pass

#데이터 크롤링하고 csv 파일 형태로 저장
url = "https://openapi.mnd.go.kr/3935313630333536343431323332303830/json/DS_TB_MNDT_DATEBYMLSVC_8623/1/100/"

response = requests.get(url)
jsonObject = json.loads(response.text).get('DS_TB_MNDT_DATEBYMLSVC_8623').get('row')
print(jsonObject)
df = pd.json_normalize(jsonObject)
print(df.sort_values(by='dates')[:10])
df.to_csv("samplecsv.csv")