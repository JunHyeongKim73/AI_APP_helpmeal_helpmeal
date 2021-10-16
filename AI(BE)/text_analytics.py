import pymysql
import pandas as pd
from konlpy.tag import Okt
import math
from azure.ai.textanalytics import TextAnalyticsClient
from azure.core.credentials import AzureKeyCredential

key = "d0beafe94e1c44a08b7ef74a8ead50ee"
endpoint = "https://helpmeal.cognitiveservices.azure.com/"
##DB 연결
my_db = pymysql.connect(
    user='yangbchu',
    passwd='mynumber14',
    host='127.0.0.1',
    port=3306,
	db='helpmeal',
    charset='utf8'
)
cursor = my_db.cursor(pymysql.cursors.DictCursor)
sql = 'SELECT * FROM ai_test'
cursor.execute(sql)
text = cursor.fetchall()
text = pd.DataFrame(text)
okt = Okt()

def authenticate_client():
    ta_credential = AzureKeyCredential(key)
    text_analytics_client = TextAnalyticsClient(
            endpoint=endpoint, 
            credential=ta_credential)
    return text_analytics_client

client = authenticate_client();

def sentiment_analysis(client, text):
	documents = []
	
	for i in range(len(text)):
		dic = {}
		dic['text'] = text.iloc[[i][0]]
		dic['id'] = str(i+1)
		dic['language'] = 'ko'
		#print(dic['text'])
		documents.append(dic)

	responeses = []
	for i in range(math.ceil(len(text)/10)):
		start = i*10
		end = min([i*10 + 10, len(text)])
		response = client.analyze_sentiment(documents=documents[start:end])
		responeses.extend(response)
	
	for doc in responeses:
		print("Overall sentiment: {}".format(doc.sentiment))
		'''
		print("Scores: positive={}; neutral={}; negative={} \n".format(
			doc.confidence_scores.positive,
			doc.confidence_scores.neutral,
			doc.confidence_scores.negative,
		))
	'''
	return responeses
#문장을 형태소별로 나누고 필요한 단어(명사, 형용사, 동사)만 남긴 뒤 개수 세는 함수 
def count_word(texts):
	word_list = []
	for i in range(len(texts)):
		word_list.extend(okt.nouns(texts.iloc[[i][0]]))
	
	word_list = pd.Series(word_list)
	result = word_list.value_counts().head(20)	
	return result

def split_by_sentiment(text, sentimental_response):
	for i in range(10):
		text['sentiment'] = sentimental_response[i].sentiment

	negative_text_row = text['sentiment'] == "negative"
	negative_text = text[negative_text_row]
	positive_text = text[text['sentiment'] == "positive"]
	return positive_text, negative_text

def insert_word_number(word_number, sentiment):
	insert_queries = []
	for i in range(len(negative_word_number)):
		insert_queries.append(f'INSERT INTO helpmeal.review_data(word, count, day, sentiment, troop_id) VALUES("{word_number.index[i]}", {word_number[i]}, "2021-10-16", sentiment, 1);')
		cursor.execute(insert_queries[i])
		my_db.commit()

#DB에서 분석 대상 데이터 추출
cursor = my_db.cursor(pymysql.cursors.DictCursor)
sql = 'SELECT comment FROM ai_test'
cursor.execute(sql)
text = cursor.fetchall()
text = pd.DataFrame(text)

sentimental_response = sentiment_analysis(client, text['comment'])

positive_text, negative_text = split_by_sentiment(text, sentimental_response)

negative_word_number = count_word(negative_text['comment'])
positive_word_number = count_word(positive_test['comment'])

insert_word_number(negative_word_number, "negative")
insert_word_number(positive_word_number, "positive")
#insertQuery = f'INSERT INTO helpmeal.review_data(word_count, sentiment) VALUES({result}, negative);'
#cursor.execute(insertQuery)
#my_db.commit()
