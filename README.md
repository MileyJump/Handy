# 프로젝트 소개
*" 당신의 손길로 만든 작품들을 세상에 전하고, 같은 꿈을 가진 이들과 함께 이야기를 나누어보세요! "*
> 사용자가 직접 만든 핸드메이드 작품을 판매하거나 구매할 수 있으며, 같은 취미를 가진 사람들과 소통할 수 있는 앱
<p align="center">
  <img src="https://github.com/user-attachments/assets/e4f01808-bc29-4ca8-acfa-16ddcd8959b9" width="200" />
  <img src="https://github.com/user-attachments/assets/ec1226fc-d01f-484e-96bb-28ca6a08c222" width="200" />
  <img src="https://github.com/user-attachments/assets/b596469d-064d-4938-800e-23e201a502e8" width="200" />
  <img src="https://github.com/user-attachments/assets/e0e4e7a5-b611-43ac-8aa9-547ddfa12357" width="200" />
</p>

# 프로젝트 개발 환경
- 개발 인원 : iOS 개발자 1명
- 개발 기간 :  -   24.08.17 - 24.08.31 ( 15일 )
- iOS 최소 버전 : iOS 16.0

# 주요 기능

-   카테고리 별로 핸드메이드 작품을 구매할 수 있는 메인 화면
-   판매 작품을 확인하고, 리뷰와 구매를 할 수 있는 상세 화면
-   취미를 공유할 수 있는 커뮤니티 화면
-   저장한 구매 화면과 커뮤니티 화면을 확인할 수 있는 화면
-   직접 만든 작품을 판매할 수 있는 판매글 작성 화면
-   소통할 수 있는 글을 작성할 수 있는 화면

# 디렉토링 구조
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
# 주요 기술
  - **iOS**: 
	  -  Swift (최소 버전 16.0)
    
-   **UI**: 
	- CodeBase로 SnapKit을 사용하여 자동 레이아웃을 구현하고, 코드 기반으로 유연하고 직관적인 사용자 인터페이스를 제공했습니다.
    
-   **Architecture**: 
	- MVVM(Model-View-ViewModel) 패턴을 적용하여 뷰와 비즈니스 로직의 분리를 통해 코드의 유지보수성과 재사용성을 높였습니다.
-   **Reactive**:
	- RxSwift와 RxCocoa를 통해 비동기 작업과 이벤트 기반 프로그래밍을 구현하여 사용자 경험을 향상 시켰습니다.


-   **Network**
	- Kingfisher를 이용하여 네트워크에서 이미지를 효율적으로 로드하고 캐싱했습니다.
	-  Alamofire를 사용해 서버와의 통신 및 데이터 요청을 처리했습니다.
    
-   **Utility**: 
	- Then 라이브러리를 사용하여 코드의 가독성을 높였습니다.
  	- Tabman과 Pageboy로 탭 인터페이스를 구현하여 사용자에게 직관적인 네비게이션을 제공하고, 페이지 전환을 부드러운 애니매이션 효과를 추가했습니다. 스와이프 가능한 페이지 전환을 지원하여 콘텐츠를 쉽게 탐색할 수 있도록 했습니다.


# 구현 사항
- 결제 
- 커서 기반 페이지네이션
- 사진 업로드

# 트러블 슈팅

### 1. 마지막 페이지에 도달했음에도 페이지네이션이 계속 되는 현상
**문제 인식** : 

HomeViewController의 판매글 목록을 불러오는 과정에서 커서 기반 페이지네이션을 구현했으나, 마지막 페이지에 도달했음에도 추가 데이터 요청이 반복되는 문제가 발생했습니다. 이로 인해 데이터 로딩이 무한히 반복되는 현상이 나타났으며, 사용자 경험에 불편을 초래하는 상황이었습니다.

**고민 및 설계** :
1. nextCursor가 0일 경우 처리
- 마지막 페이지에 도달했을 때 서버가 nextCursor를 어떻게 전달하는지 확인하기 위해 print문을 통해 디버깅을 시도했습니다. 이 과정에서 nextCursor가 0으로 전달되었음에도 첫 번째 페이지의 데이터를 반복하여 전송하고 있는 것을 발견했고, 이로 인해 데이터가 무한히 로드되는 문제가 발생했습니다.
- 이를 해결하기 위해 nextCursor가 0일 경우 추가 데이터 요청을 중단하는 로직을 추가했습니다.
  
**해결 방법**
1. .... 
