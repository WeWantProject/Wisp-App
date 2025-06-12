# Wisp

Flutter 기반 프로젝트입니다.

## CI/CD 설정

이 프로젝트는 GitHub Actions를 사용하여 CI/CD 파이프라인이 구성되어 있습니다.

### 워크플로우

- **Flutter CI (`flutter-ci.yml`)**: 코드 테스트, 분석 및 빌드 자동화
- **Flutter CD (`flutter-cd.yml`)**: 태그 푸시 시 자동 배포 (Firebase, TestFlight)
- **버전 관리 (`version-bump.yml`)**: 앱 버전 자동 관리
- **코드 품질 (`code-quality.yml`)**: 정적 분석 및 테스트 커버리지 측정

### 사용 방법

#### 버전 업데이트
GitHub Actions 탭에서 `Version Bump` 워크플로우를 수동으로 실행하여 앱 버전을 업데이트할 수 있습니다.
버전 유형(patch, minor, major)을 선택하면 자동으로 버전이 업데이트되고 태그가 생성됩니다.

#### 배포
1. 버전 업데이트 후 생성된 태그(v*)가 푸시되면 `Flutter CD` 워크플로우가 자동으로 실행됩니다.
2. 배포 워크플로우는 APK 및 App Bundle을 빌드하고 설정된 배포 채널(Firebase, TestFlight 등)에 업로드합니다.

#### 필요한 비밀값 설정
다음 비밀값들을 GitHub 저장소 Settings > Secrets and variables > Actions에 추가해야 합니다:

- `GH_PAT`: GitHub Personal Access Token (버전 업데이트 푸시용)
- `FIREBASE_APP_ID`: Firebase 앱 ID
- `FIREBASE_TOKEN`: Firebase CLI 토큰
- `FASTLANE_USER`: Apple ID
- `FASTLANE_PASSWORD`: Apple ID 비밀번호
- `MATCH_PASSWORD`: Fastlane Match 암호화 비밀번호

## 설정 방법

프로젝트를 클론하고 설정하는 방법:

```bash
git clone <저장소 URL>
cd wisp
flutter pub get
```

## 개발 시작하기

```bash
flutter run
```
