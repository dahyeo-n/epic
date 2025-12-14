<a id = "top"></a>

# 프로젝트 생성 및 개발 환경 세팅

[인덱스로 돌아가기](../README.md)

이 문서는 Maven을 이용하여 Epic 프로젝트 생성, 개발 환경 세팅, 프로젝트 실행까지 단계별로 안내합니다.

- **지원 운영체제:**  
  - WSL(Windows Subsystem for Linux)  
  - Mac

- **개발 도구:**  
  - Visual Studio Code

## 목차

1. [SDKMAN! 설치](#1-sdkman-설치)
2. [Maven 설치 및 JSP & Servlet 기반 Maven Web 프로젝트 생성](#2-maven-설치-및-jsp--servlet-기반-maven-web-프로젝트-생성)
3. [프로젝트 빌드 및 실행](#3-프로젝트-빌드-및-실행)

## 1. SDKMAN! 설치

### 1-1. SDKMAN! 설치

SDKMAN!은 JDK와 빌드 도구 설치·버전 전환을 간편하게 할 수 있게 해주는 도구입니다.

다음 단계에 따라 SDKMAN!을 설치합니다:

1. WSL 환경인 경우 curl을 설치합니다:
```bash
sudo apt-get update
sudo apt-get install curl
```

2. SDKMAN!을 설치합니다:
```bash
curl -s "https://get.sdkman.io" | bash
```

3. 현재 shell에서 SDKMAN!을 활성화합니다:
```bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

4. 설치가 완료되었는지 확인합니다:
```bash
sdk version
```

### 1-2. Java 1.8 설치 및 적용

다음 단계에 따라 Java 1.8을 설치하고 적용합니다:

1. Java 1.8 버전 목록을 확인합니다 (Vendor: OpenJDK, Zulu, Oracle 등):
```bash
sdk list java
```

2. Java 1.8 버전을 설치합니다 (여기서는 Zulu 8 버전을 예시로 사용합니다):
```bash
sdk install java 8.0.452-zulu
```

3. Java 1.8을 적용합니다:
```bash
sdk use java 8.0.452-zulu
```

4. Java 버전이 올바르게 적용되었는지 확인합니다:
```bash
java -version
```

## 2. Maven 설치 및 JSP & Servlet 기반 Maven Web 프로젝트 생성

### 2-1. Maven 설치

Maven은 보통 SDKMAN!을 통해 Java와 함께 설치하는 것이 가장 간편합니다.

다음 단계에 따라 Maven을 설치합니다:

1. Maven 버전 목록을 확인합니다:
```bash
sdk list maven
```

2. Maven을 설치합니다:
```bash
sdk install maven 3.9.11
```

3. Maven 버전을 적용합니다:
```bash
sdk use maven 3.9.11
```

4. Maven이 올바르게 설치되었는지 확인합니다:
```bash
mvn --version
```

### 2-2. Tomcat 설치

Tomcat도 SDKMAN!을 통해 설치할 수 있습니다.

다음 단계에 따라 Tomcat을 설치합니다:

1. Tomcat 버전 목록을 확인합니다:
```bash
sdk list tomcat
```

2. Tomcat을 설치합니다:
```bash
sdk install tomcat 9.0.88
```

3. Tomcat 버전을 적용합니다:
```bash
sdk use tomcat 9.0.88
```

4. Tomcat이 올바르게 설치되었는지 확인합니다:
```bash
tomcat version
```

**Tomcat 실행 방법:**

Tomcat을 실행하는 방법은 다음과 같습니다:

- **Tomcat 시작:** `~/servers/tomcat9/bin/startup.sh` 명령어를 실행합니다.
- **Tomcat 중지:** `~/servers/tomcat9/bin/shutdown.sh` 명령어를 실행합니다.
- **Tomcat 상태 확인:** 기본 포트 8080으로 `curl http://localhost:8080` 명령어를 실행하여 확인합니다.

### 2-3. Maven Web 프로젝트 생성 후 해당 프로젝트 진입

JSP 및 서블릿 기반의 웹 프로젝트 구조를 Maven의 archetype을 사용하여 생성합니다.

다음 단계에 따라 Maven Web 프로젝트를 생성합니다:

1. 프로젝트를 생성할 디렉토리(workspace)로 이동합니다:
```bash
cd workspace
```

2. 프로젝트 이름과 내 이름을 변수로 설정합니다 (⚠️ 커스텀 필요):
```bash
PROJECT_NAME="epic"
MY_NAME="cbj"
```

3. 그룹 아이디를 설정합니다 (개인 프로젝트 그룹 아이디 정할 시 `me.${user.name}.${project.name}` 형식으로 정합니다):
```bash
PROJECT_GROUP_ID="me.${MY_NAME}.${PROJECT_NAME}"
```

4. 아티팩트 아이디를 설정합니다 (프로젝트 이름):
```bash
PROJECT_ARTIFACT_ID="${PROJECT_NAME}"
```

5. Maven Web App Archetype을 사용하여 프로젝트를 생성합니다:
```bash
mvn archetype:generate \
  -DgroupId=$PROJECT_GROUP_ID \
  -DartifactId=$PROJECT_ARTIFACT_ID \
  -DarchetypeArtifactId=maven-archetype-webapp \
  -DinteractiveMode=false
```

6. 생성된 프로젝트 디렉토리로 이동한 후 Visual Studio Code로 엽니다:
```bash
cd $PROJECT_ARTIFACT_ID
code .
```

### 2-4. 프로젝트별 SDK 버전 자동 적용 설정 (.sdkmanrc 파일 생성)

프로젝트에 진입할 때마다 `sdk use java`, `sdk use maven`, `sdk use tomcat` 명령어를 일일이 실행하는 대신, 프로젝트 루트에 `.sdkmanrc` 파일을 생성하여 자동으로 특정 버전을 사용하도록 설정할 수 있습니다.

**VSCode에서 .sdkmanrc 파일 생성:**

다음 단계에 따라 `.sdkmanrc` 파일을 생성합니다:

1. VSCode의 파일 탐색기에서 프로젝트 루트 디렉토리를 확인합니다.

2. 파일 탐색기에서 우클릭하여 **새 파일(New File)**을 선택합니다.

3. 파일 이름을 `.sdkmanrc`로 입력하여 생성합니다.

4. 생성된 `.sdkmanrc` 파일에 다음 내용을 작성합니다:

```plaintext
# Enable auto-env through the sdkman_auto_env config
# Add key=value pairs of SDKs to use below
java=8.0.452-zulu
maven=3.9.11
tomcat=9.0.88
```

5. 파일을 저장합니다 (Ctrl + S 또는 Cmd + S).

**프로젝트 진입 시 SDK 버전 활성화 방법:**

프로젝트 진입 시 SDK 버전을 활성화하는 방법은 다음과 같습니다:

**방법 1: 프로젝트 디렉토리 진입 시 수동으로 실행 (한 번만 실행)**
```bash
cd $PROJECT_ARTIFACT_ID
sdk env
```

**방법 2: 자동 활성화 설정 (한 번만 설정하면 됨)**
```bash
sdk config
# 설정 화면에서 sdkman_auto_env=true 로 설정
```

자동 활성화 설정 후에는 프로젝트 디렉토리 진입 시 자동으로 적용됩니다:
```bash
cd $PROJECT_ARTIFACT_ID  # 자동으로 .sdkmanrc의 버전이 적용됨
```

**참고:**
- `sdk env` 명령어는 현재 디렉토리에서 `.sdkmanrc` 파일을 찾아 자동으로 해당 버전을 활성화합니다.
- `sdkman_auto_env=true`로 설정하면 프로젝트 디렉토리 진입 시 자동으로 활성화됩니다.
- 프로젝트를 벗어날 때는 `sdk env clear` 명령어로 원래 버전으로 되돌릴 수 있습니다.

### 2-5. pom.xml 설정

pom.xml은 프로젝트의 라이브러리 의존성, 빌드 설정, 플러그인, 메타정보 등을 관리하는 Maven의 핵심 설정 파일입니다.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

  <!-- Maven 모델 버전, 항상 4.0.0 사용 -->
  <modelVersion>4.0.0</modelVersion>

  <!-- 그룹 아이디 (프로젝트의 전체 그룹/도메인, 예: me.cbj.epic) -->
  <groupId>me.cbj.epic</groupId>

  <!-- 아티팩트 아이디 (프로젝트의 이름) -->
  <artifactId>epic</artifactId>

  <!-- 패키징 방식: war(웹 애플리케이션 Archive) -->
  <packaging>war</packaging>

  <!-- 프로젝트 버전 -->
  <version>1.0-SNAPSHOT</version>

  <!-- 프로젝트 이름 -->
  <name>epic</name>

  <!-- 빌드 관련 전역 속성 정의 -->
  <properties>
    <!-- 자바 소스 컴파일 버전 -->
    <maven.compiler.source>1.8</maven.compiler.source>
    
    <!-- 자바 바이트코드 타겟 버전 -->
    <maven.compiler.target>1.8</maven.compiler.target>
    
    <!-- web.xml 파일이 없어도 빌드 실패하지 않도록 -->
    <failOnMissingWebXml>false</failOnMissingWebXml>
    
    <!-- 서블릿 스펙 버전 (3.1.0) -->
    <servlet.version>3.1.0</servlet.version>
    
    <!-- JSP 스펙 버전 (2.3.1) -->
    <jsp.version>2.3.1</jsp.version>

    <!-- 컨텍스트 경로 -->
    <context.path>/epic</context.path>
  </properties>

  <!-- 프로젝트에서 사용할 라이브러리 목록 -->
  <dependencies>
    <!-- 서블릿 API 의존성 (제공되는 컨테이너에서 처리하도록 scope=provided) -->
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>${servlet.version}</version>
      <scope>provided</scope>
    </dependency>

    <!-- JSP API 의존성 (scope=provided) -->
    <dependency>
      <groupId>javax.servlet.jsp</groupId>
      <artifactId>javax.servlet.jsp-api</artifactId>
      <version>${jsp.version}</version>
      <scope>provided</scope>
    </dependency>

    <!-- JSTL(표준 태그 라이브러리) 의존성 -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>

    <!-- JUnit(단위테스트 라이브러리), scope=test -->
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.13.2</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <!-- 빌드 설정 및 플러그인 관리 -->
  <build>
    <plugins>
      <!-- maven-compiler-plugin: 자바 소스/타겟 버전 지정용 -->
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.8.1</version>
        <configuration>
          <source>${maven.compiler.source}</source>
          <target>${maven.compiler.target}</target>
        </configuration>
      </plugin>

      <!-- Cargo Maven Plugin: Tomcat 실행용 (tomcat7-maven-plugin 대체, 더 최신이고 안정적) -->
      <plugin>
        <groupId>org.codehaus.cargo</groupId>
        <artifactId>cargo-maven3-plugin</artifactId>
        <version>1.9.0</version>
        <configuration>
          <container>
            <containerId>tomcat9x</containerId>
            <type>embedded</type>
          </container>
          <configuration>
            <properties>
              <cargo.servlet.port>8080</cargo.servlet.port>
              <cargo.protocol>servlet3</cargo.protocol>
              <!-- 디버그 모드 설정 -->
              <cargo.jvmargs>-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005</cargo.jvmargs>
            </properties>
          </configuration>
          <deployables>
            <deployable>
              <type>war</type>
              <properties>
                <context>${context.path}</context>
              </properties>
            </deployable>
          </deployables>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```

## 3. 프로젝트 빌드 및 실행

### 3-1. 프로젝트 빌드

프로젝트 디렉토리로 이동 후 Maven을 사용하여 프로젝트를 빌드하고 WAR 파일을 생성합니다.

다음 단계에 따라 프로젝트를 빌드합니다:

1. SDK 버전을 활성화합니다 (처음 한 번만):
```bash
sdk env
```

2. 프로젝트를 빌드하여 WAR 파일을 생성합니다:
```bash
mvn clean package
```

3. 빌드 결과를 확인합니다:
```bash
ls -la target/*.war
```

**빌드 성공 시:**
빌드가 성공하면 `target` 디렉토리에 `epic-1.0-SNAPSHOT.war` 파일이 생성됩니다.

### 3-2. Tomcat에 프로젝트 배포 및 실행

**방법 1: Tomcat webapps 디렉토리에 직접 배포**

다음 단계에 따라 Tomcat webapps 디렉토리에 직접 배포합니다:

1. Tomcat 설치 경로를 확인합니다:
```bash
sdk home tomcat
# 또는
echo $CATALINA_HOME
```

2. WAR 파일을 Tomcat의 webapps 디렉토리로 복사합니다:
```bash
cp target/epic-1.0-SNAPSHOT.war $CATALINA_HOME/webapps/
```

3. Tomcat을 시작합니다:
```bash
$CATALINA_HOME/bin/startup.sh
```

4. Tomcat이 정상적으로 실행되었는지 확인합니다:
```bash
curl http://localhost:8080
```

**방법 2: Cargo Maven 플러그인 사용 (권장)**

pom.xml 설정 단계에서 이미 Cargo 플러그인을 추가했으므로, 다음 단계에 따라 간편하게 실행할 수 있습니다:

1. SDK 버전을 활성화합니다 (처음 한 번만):
```bash
sdk env
```

2. Cargo 플러그인으로 프로젝트를 실행합니다 (Tomcat 9 embedded):
```bash
mvn cargo:run
```

**방법 3: VSCode 디버거 모드로 실행**

VSCode에서 디버깅을 위해 `.vscode/launch.json` 파일을 생성합니다.

**VSCode에서 디버그 설정 파일 생성:**

다음 단계에 따라 디버그 설정 파일을 생성합니다:

1. VSCode의 파일 탐색기에서 프로젝트 루트 디렉토리를 확인합니다.

2. `.vscode` 폴더가 없으면 생성합니다 (파일 탐색기에서 우클릭 → **새 폴더(New Folder)** → `.vscode` 입력).

3. `.vscode` 폴더 안에 `launch.json` 파일을 생성합니다 (우클릭 → **새 파일(New File)** → `launch.json` 입력).

4. `launch.json` 파일에 다음 내용을 작성합니다:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "⭐ local: Debug Epic Application",
      "request": "attach",
      "hostName": "localhost",
      "port": 5005,
      "projectName": "epic",
      "sourcePaths": [
        "${workspaceFolder}/src/main/java"
      ],
      "preLaunchTask": "Start Tomcat in Debug Mode",
      "timeout": 30000
    }
  ]
}
```

5. 파일을 저장합니다 (Ctrl + S 또는 Cmd + S).

6. `.vscode` 폴더 안에 `tasks.json` 파일을 생성합니다 (우클릭 → **새 파일(New File)** → `tasks.json` 입력).

7. `tasks.json` 파일에 다음 내용을 작성합니다:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Start Tomcat in Debug Mode",
      "type": "shell",
      "command": "bash",
      "args": [
        "-c",
        "source \"$HOME/.sdkman/bin/sdkman-init.sh\" && sdk env && export MAVEN_OPTS=\"-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005\" && mvn cargo:run"
      ],
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "isBackground": true,
      "problemMatcher": {
        "pattern": {
          "regexp": "^(.*)$",
          "file": 1
        },
        "background": {
          "activeOnStart": true,
          "beginsPattern": ".*Listening for transport dt_socket.*|.*address: 5005.*|.*Tomcat.*started.*|.*Server startup.*",
          "endsPattern": ".*Tomcat.*started.*|.*Server startup.*|.*Started.*Server.*"
        }
      },
      "presentation": {
        "reveal": "always",
        "panel": "new",
        "focus": false,
        "clear": false
      }
    }
  ]
}
```

8. 파일을 저장합니다 (Ctrl + S 또는 Cmd + S).

**디버그 모드로 실행:**

다음 단계에 따라 디버그 모드로 실행합니다:

1. VSCode에서 디버거를 실행합니다:
   - VSCode 좌측 사이드바에서 **실행 및 디버그(Run and Debug)** 아이콘을 클릭합니다 (또는 `Ctrl + Shift + D`).
   - 상단 드롭다운에서 **"⭐ local: Debug Epic Application"**을 선택합니다.
   - **실행 및 디버그(F5)** 버튼을 클릭하거나 `F5` 키를 누릅니다.
   - `preLaunchTask`가 설정되어 있으면 자동으로 SDKMAN이 활성화되고, `.sdkmanrc`의 SDK 버전이 적용된 후 Tomcat이 디버그 모드로 시작되고 디버거에 연결됩니다.

2. 브레이크포인트를 설정하려면 코드 라인 번호 왼쪽을 클릭합니다.

**참고:**
- `launch.json`의 `preLaunchTask`가 `tasks.json`의 "Start Tomcat in Debug Mode" 태스크를 자동으로 실행합니다. F5를 누르면 자동으로 SDKMAN이 활성화되고, `.sdkmanrc`의 SDK 버전이 적용된 후 Tomcat이 디버그 모드로 시작되고 디버거에 연결됩니다.
- `tasks.json`의 bash 명령어에서 SDKMAN을 자동으로 활성화(`source "$HOME/.sdkman/bin/sdkman-init.sh"`)하고, `.sdkmanrc` 파일의 SDK 버전을 적용(`sdk env`)한 후 Maven을 실행합니다.
- `tasks.json`의 bash 명령어에서 `MAVEN_OPTS` 환경 변수로 디버그 포트(5005)가 설정되어 있습니다.
- VSCode에서 Java 디버깅을 사용하려면 **Extension for Java** 확장 프로그램이 설치되어 있어야 합니다.
- 디버그 모드로 실행하면 코드에 설정한 브레이크포인트에서 실행이 멈추고 변수 값을 확인할 수 있습니다.
- `tasks.json`의 `problemMatcher` 설정으로 Tomcat 시작 완료를 자동으로 감지하여 디버거 연결 시점을 최적화합니다.

### 3-3. 프로젝트 접속 확인

프로젝트가 정상적으로 실행되면 브라우저에서 다음 주소로 접속할 수 있습니다:

- **컨텍스트 경로:** `http://localhost:8080/epic/` (pom.xml의 `context.path` 설정에 따라 `/epic`으로 설정됩니다)

### 3-4. Tomcat 중지

Tomcat을 중지하는 방법은 다음과 같습니다:

**방법 1: Cargo 플러그인으로 실행한 경우**
터미널에서 `Ctrl + C`를 눌러 중지합니다.

**방법 2: shutdown 스크립트 사용 (직접 배포한 경우)**
```bash
$CATALINA_HOME/bin/shutdown.sh
```

**참고:**
- Tomcat 기본 포트는 8080입니다. 포트를 변경하려면 pom.xml의 `cargo.servlet.port` 속성을 수정하면 됩니다.
- 컨텍스트 경로는 pom.xml의 `context.path` 속성으로 설정됩니다 (현재 `/epic`으로 설정됨).
- 프로젝트 코드를 수정한 후에는 다시 빌드(`mvn clean package`)하고 Cargo를 재시작해야 변경사항이 반영됩니다.

[맨 위로 가기](#top)