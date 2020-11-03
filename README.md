# Area

AR 기반 아이폰 어플리케이션 “Area”	(20.7.29-20.8.7)
Xcode로 구현한 iPhone device 위에서 동작하는 AR 기반 Posting application. 

- 애플의 2020 애플 글라스 공개 소식을 듣고 프로젝트 주제 선정. 
- MongoDB, Mongoose 를 통한 백엔드 서버 개발.
- 갤러리에서 사진을 로딩하여 원하는 장소 (수평의 벽) 에 날짜와 함께 포스팅 할 수 있도록 구현. 
- 갤러리에서 사진 로딩시, 사진내 숫자패턴 분석 후, 날짜 자동 입력
- 포스팅을 하는 사람과, 포스팅을 보려는 일반 유저로 가입 가능. 
- 원하는 관심사의 포스터만 보이도록 설정 가능. 
- 즐겨찾기에 추가한 포스터 즐겨찾기 목록에서 확인 가능.

Tech Stack 
- (FE) Xcode (Storyboard) and Swift5, AR-kit, Alamofire
- (BE) MongoDB, Mongoose, Google ML-Kit 
- (VCS) git

Carthage
-Alaomofire

CocoaPods
- GTMSessionFetcher (1.4.0)
- GoogleDataTransport (7.1.0)
- GoogleMLKit (0.62.0)
- GoogleToolboxForMac (2.2.2)
- GoogleUtilities (6.7.1)
- GoogleUtilitiesComponents (1.0.0)
- MLKitCommon (0.62.0)
- MLKitTextRecognition (0.62.0)
- MLKitVision (0.62.0)
- PromisesObjC (1.2.9)
- Protobuf (3.12.0)
- nanopb (1.30905.0)
