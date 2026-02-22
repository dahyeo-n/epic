<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입 테스트</title>
</head>
<body>
  <h1>회원가입 테스트</h1>

  <form id="signupForm">
    <div>
      <label for="email">이메일 (필수)</label>
      <input type="email" id="email" name="email" required>
    </div>
    <div>
      <label for="password">비밀번호 (필수, 영문+숫자+특수문자(,.!?) 10자 이상)</label>
      <input type="password" id="password" name="password" required>
    </div>
    <div>
      <label for="nickname">닉네임 (필수)</label>
      <input type="text" id="nickname" name="nickname" required>
    </div>
    <div>
      <label for="description">설명</label>
      <input type="text" id="description" name="description">
    </div>
    <div>
      <label for="imageUrl">이미지 URL</label>
      <input type="url" id="imageUrl" name="imageUrl">
    </div>
    <button type="submit">가입하기</button>
  </form>

  <div id="message"></div>

  <script>
    document.getElementById('signupForm').addEventListener('submit', function(e) {
      e.preventDefault();
      var payload = {
        email: document.getElementById('email').value,
        password: document.getElementById('password').value,
        nickname: document.getElementById('nickname').value,
        description: document.getElementById('description').value || null,
        imageUrl: document.getElementById('imageUrl').value || null
      };
      var msgEl = document.getElementById('message');
      fetch('/epic/api/users/signup.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      })
      .then(function(res) {
        if (res.ok) {
          return res.json().then(function(id) {
            msgEl.textContent = '가입 완료. 사용자 ID: ' + id;
          });
        }
        return res.text().then(function(text) {
          msgEl.textContent = '오류: ' + (text || res.status);
        });
      })
      .catch(function(err) {
        msgEl.textContent = '오류: ' + err.message;
      });
    });
  </script>
</body>
</html>
