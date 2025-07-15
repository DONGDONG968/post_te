function login() {
  const username = document.getElementById("username").value.trim();
  const password = document.getElementById("password").value.trim();
  const errorDiv = document.getElementById("errorMsg");

  const validUser = "admin";
  const validPass = "1234";

  if (username === validUser && password === validPass) {
    alert("로그인 성공!");
    window.location.href = "index.jsp"; // 게시판 메인으로 이동
  } else {
    errorDiv.textContent = "아이디 또는 비밀번호가 잘못되었습니다.";
  }
}

const NAVER_CLIENT_ID   ='your_js_key'; 
const NAVER_REDIRECT    ='your_redirect';

const naverLogin = new naver_id_login(
		NAVER_CLIENT_ID,
		NAVER_REDIRECT
);
const NAVER_STATE = naverLogin.getUniqState(); 

  /* SDK가 가진 파라미터로 직접 authorize URL 생성 */
const authURL =
  `https://nid.naver.com/oauth2.0/authorize` +
  `?response_type=code` +
  `&client_id=${NAVER_CLIENT_ID}` +
  `&redirect_uri=${encodeURIComponent(NAVER_REDIRECT)}` +
  `&state=${NAVER_STATE}`;


function init() {
	
	Kakao.init('your_js_key'); // Kakao 앱의 JavaScript 키
	document.getElementById('kakao-login-btn')
	        .addEventListener('click', () => {
	  Kakao.Auth.authorize({
	    redirectUri: 'your_redirect'
	  });
	});
	
	document.getElementById('naver-login-btn')
	        .addEventListener('click', () => {
		window.location.href = authURL;
		});
}

function inspection() {
	alert("점검 중.. 잠시후 다시 시도해 주세요");
}
