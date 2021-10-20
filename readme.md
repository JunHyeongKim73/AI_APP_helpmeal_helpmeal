# HelpMeal
<img src = "./logo_helpmeal.png" width="150" heigt="150"/>

## 💻 프로젝트 소개
__당신의 군 생활동안 식사에 대한 크고 작은 고민들을 해결해줄 수 있는 작은 도우미, \'헬프밀(HelpMeal)\'입니다.__
- - -

### 기획의도
고생하는 장병들에게 맛있는 한 끼 식사를 대접하기 위해, 조리병을 비롯하여 식단을 편성하고 요리하는 인원들은 밤낮없이 일하고 있습니다.  
그럼에도 불구하고 수십만에 달하는 장병들을 만족시키기에는 턱없이 부족할 뿐더러 영양소 불균형이나 부족한 양 등과 관련한 문제가 지속적으로 제기되고 있습니다.  
본 프로젝트는 이러한 문제들을 타파하기 위해 장병들의 병영식에 대한 만족도를 효율적으로 조사하고,
피드백을 할 수 있도록 하는 것과 장병들이 식사하는데 불편함이 없도록 하는 것을 목적으로 하고 있습니다.

### 기대효과
 - 장병들의 피드백이 반영되어 더 만족도 높은 식단을 구성할 수 있을 것입니다.
 - 위와 같이 장병들의 식단에 대한 만족도가 높아진다면, 버려지는 음식 때문에 생기는 연간 약 1000억원에 달하는 국방비를 절감할 수 있을 것입니다.
 - 각 부대 홈페이지에서 일정 주기마다 식단표를 확인해야 하는 번거로움을 줄일 수 있을 것입니다.

### 📖 발표자료
<a href="https://github.com/osamhack2021/AI_APP_helpmeal_helpmeal/blob/master/helpmeal_presentation.pdf"><img src="https://user-images.githubusercontent.com/58851365/138083743-6e278d95-41b9-4e4d-a57f-c103386c7344.png" width="400"></a>

### 🎬 프로젝트 설명 영상
[<img src = "https://user-images.githubusercontent.com/56298375/138110054-3a68a277-1214-4b5e-9153-7b8386efd93d.PNG" width="400" heigt="400"/>](https://www.youtube.com/watch?v=PZjvaPWjHr0?t=0s)


## 🖥 주요 기능
 - 메뉴(식단표)를 열람하고, 등록되지 않은 해당 부대의 식단을 수정 및 업데이트할 수 있습니다.  
 - 알레르기와 같이 장병들이 병영식을 이용하는데 불편할 수 있는 점에 대해 장병들에게 알려줄 수 있습니다.  
 - 장병들이 각각의 메뉴에 대해 별점과 리뷰를 남길 수 있도록 하여 어떤 부분이 만족스럽고, 미흡한지 확인할 수 있습니다.  
 - 개선되었으면 하는 점이 있다면, '건의하기'를 통해 담당자에게 의견을 남길 수 있습니다.
 - AI 리뷰 분석을 통해 담당자는 좋은 점과 개선되었으면 하는 점을 확인할 수 있습니다.

## 프로젝트 관리
### 개발 일정
<img src = "https://github.com/osamhack2021/AI_APP_helpmeal_helpmeal/blob/master/APP(Android)/myapp/test/development_schedule.jpg?raw=true" width="1000" heigt="445"/>

### 리뷰 분석 흐름도
<img src = "https://github.com/osamhack2021/AI_APP_helpmeal_helpmeal/blob/master/APP(Android)/myapp/test/flowchart.jpg?raw=true" width="895" heigt="505"/>

## 프로젝트 전망 및 개발 가능성
- 식단 API 개방
  - 등록되지 않은 부대의 식단을 수정 및 업데이트하는 기능을 통해 공공데이터포털 등에서 확인할 수 없는 식단까지 알 수 있습니다.
- 평가 분석의 고도화
  - 식단에 대한 장병들의 반응을 실시간으로 분석하여 제공할 수 있습니다.
- 병영식 담당자들간의 공간 형성
  - 병영식 담당자들 사이에서도 노하우를 공유하면서 피드백이 가능해질 것입니다.

## 📱 필요한 소프트웨어
* Android : Android 11(sdk level 30) 이상
* IOS : 제한 사항 없음

## 기술 스택 (Technique Used) 
### Server(back-end)
 - Node.js, MYSQL, ERD
 
### AI
 - azure cloud service text-analyze, konlpy

### APP(Front-end)
 - flutter, dart, getx

## 설치 안내 (Installation Process)
- flutter SDK가 먼저 깔려있어야 합니다!
```bash
$ git clone osamhack2021/AI_APP_helpmeal_helpmeal
$ cd 'APP(Android)'
$ flutter run
```

## 프로젝트 사용법 (Getting Started)
**마크다운 문법을 이용하여 자유롭게 기재**

아래 링크에서 apk파일을 받아서 실행
- <a href="https://drive.google.com/drive/folders/1KvTIeQwEkmsak6yaYFCTMqRVySkW0r_O">사용자 및 관리자 앱</a>
<br/><br/><br/><br/><br/>
 
## 팀 정보 (Team Information)
- 양건희 (abab_1212@naver.com) Github ID : [yangbaechu](https://github.com/yangbaechu), __팀장 및 Backend(Server & AI)__
- 김준형 (rla5764v@naver.com) Github ID : [JunHyeongKim73](https://github.com/JunHyeongKim73), __Frontend__
- 김민석 (mhn07001@naver.com) Github ID : [star8041](https://github.com/star8041), __Frontend__

## 저작권 및 사용권 정보 (Copyleft / End User License)
 * [GPL 3.0](https://github.com/osamhack2021/AI_APP_helpmeal_helpmeal/blob/master/license.md)

This project is licensed under the terms of the GNU General Public License v3.0 license.

> 군대는 잘 먹어야 진격한다.  
>   
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 나폴레옹 보나파르트
<br/><br/><br/>

<iframe width="640" height="360" src="https://www.youtube.com/embed/6Az2cNU7gUw" frameborder="0" gesture="media" allowfullscreen=""></iframe>
