<p align="center"><img src = "./logo_helpmeal.png" width="350" heigt="350"/></p>

## 💻 프로젝트 소개
__당신의 군 생활동안 식사에 대한 크고 작은 고민들을 해결해줄 수 있는 작은 도우미, \'헬프밀(HelpMeal)\'입니다.__
- - -

### 기획의도
- 고생하는 장병들에게 맛있는 한 끼 식사를 대접하기 위해, 조리병을 비롯하여 식단을 편성하고 요리하는 인원들은 밤낮없이 일하고 있습니다.  
- 그럼에도 불구하고 수많은 장병들을 만족시키기에는 부족할 뿐더러 영양소 불균형이나 부족한 양 등과 관련한 문제가 지속적으로 제기되고 있습니다.  
- 본 프로젝트는 이러한 문제들을 타파하기 위해 장병들의 식단에 대한 피드백을 효과적으로 전달하는 것을 목적으로 하고 있습니다.

### 기대효과
 - 장병들의 피드백이 반영되어 더 만족도 높은 식단을 구성할 수 있을 것입니다.
 - 위와 같이 장병들의 식단에 대한 만족도가 높아진다면, 버려지는 음식 때문에 생기는 연간 약 1000억원에 달하는 국방비를 절감할 수 있을 것입니다.
 - 각 부대 홈페이지에서 일정 주기마다 식단표를 확인해야 하는 번거로움을 줄일 수 있을 것입니다.
<br/>

> 군대는 잘 먹어야 진격한다.  
>   
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 나폴레옹 보나파르트

<br/><br/><br/>
### 발표자료
<a href="https://github.com/osamhack2021/AI_APP_helpmeal_helpmeal/blob/master/helpmeal_presentation.pdf"><img src="https://user-images.githubusercontent.com/58851365/138083743-6e278d95-41b9-4e4d-a57f-c103386c7344.png" width="400"></a>

### 프로젝트 설명 영상
[<img src = "https://user-images.githubusercontent.com/56298375/138110054-3a68a277-1214-4b5e-9153-7b8386efd93d.PNG" width="400" heigt="400"/>](https://www.youtube.com/watch?v=PZjvaPWjHr0?t=0s)

## 🖥 주요 기능
 - 메뉴(식단표)를 열람하고, 등록되지 않은 해당 부대의 식단을 수정 및 업데이트할 수 있습니다.  
 - 알레르기와 같이 장병들이 병영식을 이용하는데 불편할 수 있는 점에 대해 장병들에게 알려줄 수 있습니다.  
 - 장병들이 각각의 메뉴에 대해 별점과 리뷰를 남길 수 있도록 하여 어떤 부분이 만족스럽고, 미흡한지 확인할 수 있습니다.  
 - 개선되었으면 하는 점이 있다면, '건의하기'를 통해 담당자에게 의견을 남길 수 있습니다.
 - AI 리뷰 분석을 통해 담당자는 좋은 점과 개선되었으면 하는 점을 확인할 수 있습니다.
| <img src = "./APP\(Android\)/myapp/test/create_modify.png" width="250">  | <img src = "./APP\(Android\)/myapp/test/inquiry.png" width="250"> |
|--|--|
| <img src = "./APP\(Android\)/myapp/test/score_review.png" width="250"> | <img src = "./APP\(Android\)/myapp/test/suggestion.png" width="250"> |
|--|--|
| <img src = "./APP\(Android\)/myapp/test/notice.png" width="250"> | <img src = "./APP\(Android\)/myapp/test/analysis.png" width="250"> |

## ⏰ 개발 과정
### 개발 일정
<img src = "https://github.com/osamhack2021/AI_APP_helpmeal_helpmeal/blob/master/APP(Android)/myapp/test/development_schedule.jpg?raw=true" width="1000" heigt="445"/>

### Frontend
#### 개발 중점 요소
- 간편한 부대 설정 : 어떤 부대에 소속되었는지에 관계없이 직관적으로 선택할 수 있도록 구현하였습니다.
- 사용자 친화적 UI : 사용자가 이용하는데 불편함이나 위화감을 느끼지 않도록 인터페이스를 구성하였습니다.
- WordCloud : 리뷰 데이터를 가공 후 분석하여 한 눈에 식단의 장단점을 확인하여 피드백이 용이하도록 고안하였습니다.

### Backend
#### 설계
- ER 다이어그램
<img src = "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/3737328e-5a9f-4c7d-b7ad-9f59a6c80026/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAT73L2G45O3KS52Y5%2F20211020%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20211020T143945Z&X-Amz-Expires=86400&X-Amz-Signature=00540c356956679cd27c74d47556f881407688aec94d493114e9f7b7efc2b302&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22" width="895" heigt="505"/>

#### 식단표 구성 방법
- 공공데이터포털의 식단표 데이터를 크롤링하여 제공 ➡️ 데이터가 부족하며, 정확도가 떨어짐
- 따라서, 사용자 또는 담당자가 식단을 추가하거나 수정할 수 있는 기능을 제공
#### AI 리뷰 분석 흐름도
<img src = "https://github.com/osamhack2021/AI_APP_helpmeal_helpmeal/blob/master/APP(Android)/myapp/test/flowchart.jpg?raw=true" width="895" heigt="505"/>

## 💡 프로젝트 전망 및 개발 가능성
- 식단 API 개방
  - 등록되지 않은 부대의 식단을 수정 및 업데이트하는 기능을 통해 공공데이터포털 등에서 확인할 수 없는 식단까지 알 수 있습니다.
- 평가 분석의 고도화
  - 식단에 대한 장병들의 반응을 실시간으로 분석하여 제공할 수 있습니다.
- 병영식 담당자들간의 공간 형성
  - 병영식 담당자들 사이에서도 노하우를 공유하면서 피드백이 가능해질 것입니다.

## 📱 필요한 소프트웨어
* Android : Android 11(sdk level 30) 이상

## ⚙ 기술 스택 (Technique Used) 
### Server(back-end)
 - Node.js, MYSQL, ERD
 
### AI
 - azure cloud service text-analytics, konlpy

### APP(Front-end)
 - flutter, dart, getx

## 🔎 설치 안내 (Installation Process)
- flutter SDK가 먼저 깔려있어야 합니다!
```bash
$ git clone osamhack2021/AI_APP_helpmeal_helpmeal
$ cd 'APP(Android)'
$ flutter run
```

또는 아래 링크에서 apk파일을 받아서 실행하면 됩니다.
- <a href="https://drive.google.com/drive/folders/1KvTIeQwEkmsak6yaYFCTMqRVySkW0r_O">앱 다운로드</a>
<br/><br/><br/>
 
## 팀 정보 (Team Information)
- 양건희 (abab_1212@naver.com) Github ID : [yangbaechu](https://github.com/yangbaechu), __팀장 및 Backend(Server & AI)__
- 김준형 (rla5764v@naver.com) Github ID : [JunHyeongKim73](https://github.com/JunHyeongKim73), __Frontend__
- 김민석 (mhn07001@naver.com) Github ID : [star8041](https://github.com/star8041), __Frontend__

## 저작권 및 사용권 정보 (Copyleft / End User License)
 * [GPL 3.0](https://github.com/osamhack2021/AI_APP_helpmeal_helpmeal/blob/master/license.md)

This project is licensed under the terms of the GNU General Public License v3.0 license.
