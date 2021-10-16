"use strict";

const conn = require('./config/database.js');

const { TextAnalyticsClient, AzureKeyCredential } = require("@azure/ai-text-analytics");
const key = 'd0beafe94e1c44a08b7ef74a8ead50ee';
const endpoint = 'https://helpmeal.cognitiveservices.azure.com/';
const textAnalyticsClient = new TextAnalyticsClient(endpoint,  new AzureKeyCredential(key));
const {Tagger} = require('koalanlp/proc');
const {EUNJEON} = require('koalanlp/API');
async function sentimentAnalysis(client, text){
    const document = [];
	for(let i = 0; i < 10; i++){
		const obj = {};
		console.log(text[i].comment, i.toString());
		obj.text = text[i].comment;
		obj.id = (i+1).toString();
		obj.language = 'ko';
		document.push(obj);
		//console.log(`document ${i}: ${document[i]}`);
	}
	const result  = await client.analyzeSentiment(document);
    console.log(result);
	/*sentimentResult.forEach(result => {
        console.log(`ID: ${result.id}`);
        console.log(`\tDocument Sentiment: ${result.sentiment}`);
        });*/
}

async function main() {
	try{
		conn.query(`SELECT comment FROM helpmeal.ai_test`, function(err, texts, field){
			//console.log(texts);
			sentimentAnalysis(textAnalyticsClient, texts);
		let tagger = new Tagger(EUNJEON);		
		
		tagger("문단을 분석합니다. 자동으로 분리되어 목록을 만듭니다.")  // 또는 tagger.tag(...)
    .then((result) => {
        /* Result는 string[] 타입입니다. */
        console.log(result[0].singleLineString()); // "문단을 분석합니다."의 품사분석 결과 출력
    }, (error) => console.error('Error occurred!', error));		
		})	
	}
	catch(error){
		console.log(error);
	}

}
main();
