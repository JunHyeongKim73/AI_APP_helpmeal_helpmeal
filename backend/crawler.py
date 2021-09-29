import sys
sys.path.append('/usr/lib/python3/dist-packages')

import requests
import json
import pandas as pd
import schedule

#SSL: DH_KEY_TOO_SMALL 오류 해결
requests.packages.urllib3.disable_warnings()
requests.packages.urllib3.util.ssl_.DEFAULT_CIPHERS += ':HIGH:!DH:!aNULL'
try:
    requests.packages.urllib3.contrib.pyopenssl.util.ssl_.DEFAULT_CIPHERS += ':HIGH:!DH:!aNULL'
except AttributeError:
    # no pyopenssl support used / needed / available
    pass

def crawler():

    troop_code_list = [8623, 9030, 6282, 1691, 2171, 7369, 3296, 5322, 6335, 3389, 8902, 6176]
    
    #각 부대 식단표 수집
    for troop_code in troop_code_list:

        #데이터 크롤링하고 parsing
        url = "https://openapi.mnd.go.kr/3935313630333536343431323332303830/json/DS_TB_MNDT_DATEBYMLSVC_" + str(troop_code) + "/1/100/"

        response = requests.get(url)
        service_name = 'DS_TB_MNDT_DATEBYMLSVC_' + str(troop_code)
        jsonObject = json.loads(response.text).get(service_name).get('row')
        print(jsonObject)

        #크롤링한 데이터 dataframe 형태로 저장
        df = pd.json_normalize(jsonObject)
        df.insert(0, "troop_code", troop_code)
        df = df.sort_values(by='dates')
        file_name = str(troop_code) + " menus.csv"
        df.to_csv(file_name)


crawler()
schedule.every().day.at("22:30").do(crawler())
