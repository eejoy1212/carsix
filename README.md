<a href="https://club-project-one.vercel.app/" target="_blank">
<img src="https://github.com/user-attachments/assets/daa622b9-7c69-4786-8db3-4996b7f140be" alt="배너" width="100%"/>
</a>

<br/>
<br/>

# 0. Getting Started (시작하기)
```bash
$ npm start
```
[서비스 링크](https://club-project-one.vercel.app/)

<br/>
<br/>

# 1. Project Overview (프로젝트 개요)
- 프로젝트 이름: 카식스 차량 조명 제어 앱
- 프로젝트 설명: 블루투스 연동을 이용한 차량 조명 제어 앱

<br/>
<br/>

# 2. Key Features (주요 기능)
- **디비 저장**:
  - sqflite에 즐겨찾기 색상, 최근 선택한 모드 , 디바이스 정보 등을 저장 합니다.

- **날씨 정보 받아오기**:
  - WeatheraAPI를 이용해 날씨 정보를 받아와 그에 맞는 커맨드를 하드웨어에 날리면 날씨에 알맞는 조명이 나옵니다.
  - 

<br/>
<br/>

# 3. Technology Stack (기술 스택)
##3.1 Language
|  |  |
|-----------------|-----------------|
| Flutter(Dart)    |<img src="https://github.com/user-attachments/assets/2e122e74-a28b-4ce7-aff6-382959216d31" alt="HTML5" width="100">| 



# 6. Project Structure (프로젝트 구조)
```plaintext
project/
├── public/
│   ├── index.html           # HTML 템플릿 파일
│   └── favicon.ico          # 아이콘 파일
├── src/
│   ├── assets/              # 이미지, 폰트 등 정적 파일
│   ├── components/          # 재사용 가능한 UI 컴포넌트
│   ├── hooks/               # 커스텀 훅 모음
│   ├── pages/               # 각 페이지별 컴포넌트
│   ├── App.js               # 메인 애플리케이션 컴포넌트
│   ├── index.js             # 엔트리 포인트 파일
│   ├── index.css            # 전역 css 파일
│   ├── firebaseConfig.js    # firebase 인스턴스 초기화 파일
│   package-lock.json    # 정확한 종속성 버전이 기록된 파일로, 일관된 빌드를 보장
│   package.json         # 프로젝트 종속성 및 스크립트 정의
├── .gitignore               # Git 무시 파일 목록
└── README.md                # 프로젝트 개요 및 사용법
```

<br/>
<br/>



