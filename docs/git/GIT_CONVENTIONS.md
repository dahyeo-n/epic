<a id = "top"></a>

# Git Conventions 규칙

[인덱스로 돌아가기](../DOCS_INDEX.md)

## 형식
```
<type>(<scope>): <subject>

<body>

<footer>
```

## Type (필수)
- `feat`: 새로운 기능 추가
- `fix`: 버그 수정
- `docs`: 문서 수정
- `style`: 코드 포맷팅, 세미콜론 누락 등 (코드 변경 없음)
- `refactor`: 코드 리팩토링
- `test`: 테스트 코드 추가/수정
- `chore`: 빌드 업무 수정, 패키지 매니저 설정 등
- `perf`: 성능 개선
- `ci`: CI/CD 설정 변경

## Scope (선택)
- `servlet`: Servlet 관련
- `jsp`: JSP 관련
- `spring`: Spring Framework 관련
- `maven`: Maven 설정 관련
- `config`: 설정 파일 관련
- `ui`: UI/프론트엔드 관련
- `api`: API 관련

## Subject (필수)
- 50자 이내로 간결하게 작성
- 첫 글자는 대문자로 시작하지 않음
- 마지막에 마침표(.) 사용하지 않음
- 명령형으로 작성 (예: "추가" 대신 "add")

## Body (선택)
- 불릿 포인트(`-`) 형식으로만 작성
- 각 변경 사항을 한 줄씩 나열
- 무엇을, 왜 변경했는지 설명
- 어떻게 변경했는지는 코드로 확인 가능하므로 생략 가능

## Footer (선택)
- Breaking changes가 있는 경우 반드시 포함: `BREAKING CHANGE: 설명`
- Breaking changes가 없는 경우 Footer 생략 가능

## 예시
```plaintext
feat(servlet): 사용자 인증 서블릿 구현

- 로그인/로그아웃 기능 추가
- 세션 관리 기능 구현
- 에러 처리 로직 추가
```

```plaintext
refactor(spring): Spring MVC로 마이그레이션

- 기존 Servlet/JSP 구조를 Spring MVC로 전환
- 유지보수성과 확장성 개선
- web.xml 설정 변경

BREAKING CHANGE: web.xml 설정이 변경되었습니다.
```

```plaintext
fix(maven): Cargo 플러그인 버전 업데이트

- Tomcat 9 호환성 문제 해결
- Cargo Maven 플러그인 버전 업데이트
```

## 규칙 요약
1. Type은 필수이며 위 목록 중 하나를 선택
2. Subject는 간결하고 명확하게 작성
3. Body는 불릿 포인트 형식으로 변경 사항을 나열
4. Footer는 Breaking changes가 있는 경우에만 필수로 포함
5. 명령형으로 작성 (과거형 X)
6. 작성 시 언어는 한국어로 작성

[맨 위로 가기](#top)