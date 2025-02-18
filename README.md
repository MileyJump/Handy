# ☁️ Handy
<p align="center">
  <img src="https://github.com/user-attachments/assets/43b20d83-4126-4d7c-9ca3-9e272b518532" alt="appstore" width="200"/>
</p>

<p align="center">
	 <img src="https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/iOS-16.0-lightgrey?style=flat&color=181717" alt="iOS 16.0" />
  <img src="https://img.shields.io/badge/Swift-5.0-F05138.svg?style=flat&color=F05138" alt="Swift 5.0" />
  <img src="https://img.shields.io/badge/Xcode-14.0-147EFB.svg?style=flat&color=147EFB" alt="Xcode 14.0" />
</p>



## 프로젝트 소개
*" 당신의 손길로 만든 작품들을 세상에 전하고, 같은 꿈을 가진 이들과 함께 이야기를 나누어보세요! "*
> 사용자가 직접 만든 핸드메이드 작품을 판매하거나 구매할 수 있으며, 같은 취미를 가진 사람들과 소통할 수 있는 앱
<p align="center">
  <img src="https://github.com/user-attachments/assets/e4f01808-bc29-4ca8-acfa-16ddcd8959b9" width="200" />
  <img src="https://github.com/user-attachments/assets/ec1226fc-d01f-484e-96bb-28ca6a08c222" width="200" />
  <img src="https://github.com/user-attachments/assets/b596469d-064d-4938-800e-23e201a502e8" width="200" />
  <img src="https://github.com/user-attachments/assets/e0e4e7a5-b611-43ac-8aa9-547ddfa12357" width="200" />
</p>

# 프로젝트 목적
### 기획 의도
- 사용자들이 자신이 직접 만든 독창적인 작품을 판매하거나, 다른 사람들이 만든 작품을 구매할 수 있도록 돕고자 기획하게 되었습니다.
- 커뮤니티 기능을 통해 사용자들이 경험을 공유하고, 서로의 작품에 대해 피드백을 주고 받으며, 다양한 DIY 아이디어를 나누는 공간을 제공했습니다.
- 핸드메이드 문화의 발전을 기여하고, 사람들과 함께 다양한 핸드메이드에 대한 아이디어를 이야기 나누는 것을 목표로 기획 했습니다.

### 대상 사용자
- 핸디(Handy)는 개인의 창작자와 개인 소비자를 타겟으로 구현했습니다. 
- 자신의 창작물을 다른 다람과 공유하고 판매하고 싶은 개인과 DIY에 관련된 정보와 팁을 얻고, 자신의 경험을 나누며 소통하고 싶은 개인을 중점으로 기획 했습니다.

### 주요 화면
-   카테고리 별로 핸드메이드 작품을 구매할 수 있는 메인 화면
-   판매 작품을 확인하고, 리뷰와 구매를 할 수 있는 상세 화면
-   취미를 공유할 수 있는 커뮤니티 화면
-   저장한 구매 화면과 커뮤니티 화면을 확인할 수 있는 화면
-   직접 만든 작품을 판매할 수 있는 판매글 작성 화면
-   소통할 수 있는 글을 작성할 수 있는 화면

# 프로젝트 개발 환경

-   개발 인원
    -   기획 + 디자인 + iOS 개발자 1명
    -   서버 1명
-   개발 기간
    -   24.08.17 - 24.08.31 (15일)
-   iOS 최소 버전
    -   iOS 16.0+
    
## 주요 기능


<!--
## 디렉토링 구조
```
Movielity
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Base.lproj
│   └── LaunchScreen.storyboard
├── Global
│   ├── UserDefaultsManager.swift
│   ├── Components
│   ├── Extensions
│   ├── Protocols
│   └── Resources
├── Info.plist
├── Network
│   ├── Base
│   ├── NetworkManager.swift
│   ├── RequestModel
│   └── ResponsesModel
└── Presentation
    ├── Base
    ├── Signup
    ├── Login
    ├── Profile
    ├── Home
    ├── SearchPage
    ├── WritePost
    ├── Save    
    ├── MyPage
	├── Community
    └── TabBar
```
-->

## 사용 기술 (Tech Stack)
> ### Architectur & Design Pattern
- MVVM, Input-Output
- Routor, Singleton

> ### Swift Framework
- UIKit

> ### OpenSource Libaries
- RxSwift, RxCocoa
- Alamofire
- Kingfisher
- SnapKit, Then
- Tabman, Pageboy

> ### Management
- Git, Github
<br/> <br/>

## 주요 기능 (Main Feature)
#### 홈 화면
   - 사용자가 게시한 판매글 확인
     
#### 구매 화면
   - 홈에서 선택한 판매글의 상세페이지
   - PG연동을 통해 해당 물품을 구매 가능
     
#### 커뮤니티 화면
   - 취미를 공유할 수 있는 커뮤니티 화면
   - 커뮤니티 글 게시 작성 및 확인
     
#### 저장 목록 화면
   - 상단 탭바를 통해, 판매글 및 커뮤니티 저장 목록 구분하여 확인

#### 판매글 자성 화면
   - 직접 만든 핸드메이드 작품 판매 게시글 작성

## 주요 기술
> ### 아키텍쳐 (Architecture)
- View와 Business Logic을 분리하여 ViewController 간결화 <br/> 
- MVVM Input-Output 패턴을 적용해 ViewModel에서 데이터를 변환하고 UI 상태를 관리하도록 구현 <br/> 
- Router Pattern을 활용해 API 요청을 구조화하고, 반복되는 네트워크 작업을 추상화 <br/> 
<br/>

> ### PG 기반 결제 시스템 구현
- PG연동을 통해 결제 시스템을 구현
- 결제 데이터를 전달하여 웹뷰 기반 결제 화면을 제공
<br/>

> ### JWT와 엑세스 토큰을 활용한 사용자 인증 기능
- 사용자가 로그인 후 서버에서 발급 받은 엑세스 토큰을 UserDefaults에 저장해, 관리하고 API 통신 시 헤더에 포함시켜 인증을 처리

<p align="center">
    <img src="https://github.com/user-attachments/assets/56163d3a-1a3b-4581-afa7-245dfbae515b" width="600"/>
</p>


> ### Access Token 갱신 및 RefreshToken 만료 처리
- 엑세스 토큰이 만료되면 서버에서 상태 오류 코드를 반환하여 만료된 토큰을 확인하고, 저장된 RefreshToken을 사용해 새로운 엑세스 토큰을 요청
- RefreshToken이 만료되었을 경우, 자동으로 로그인 화면으로 전환되어 재로그인 할 수 있도록 구현

> ### Multipart/form-data 형식의 이미지 전송
- 게시글 작성 화면에서 선택한 이미지를 Data 형식으로 변환하고, Multipart/form-data 형식으로 이미지와 텍스트를 동시에 서버에 전송할 수 있도록 구현

## 회고
> ### JWT 토큰 - Access Token과 Refresh Token
- JWT 토큰 기반 로그인 기능을 처음 구현하면서, Access Token과 Refresh Token을 왜 분리하는지 궁금했으나, 개인정보를 다루는 만큼 보안이 중요한 요소이며, 이를 고려해 토큰을 분리해서 관리한다는 점을 이해하게 되었다.
- 처음에는 Token을 UserDefaults에 저장하는 방법을 사용 했지만, 과연 UserDefaults에 저장하는 방법이 보안 측면에서 좋은 방법일지에 대해 고민을 하게 되었다.
- 추후에는 UserDefaults 대신 Keychain을 활용해 보안을 강화하는 방식으로 개선해보고 싶다고 생각했다.



