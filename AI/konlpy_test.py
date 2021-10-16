# -*- coding: utf-8 -*- 

from konlpy.tag import Okt
import pandas as pd

text = "안녕하세요 저는 이제 형태소를 분석해볼거에요"
okt = Okt()
text_list = okt.morphs(text)

print(text_list)
