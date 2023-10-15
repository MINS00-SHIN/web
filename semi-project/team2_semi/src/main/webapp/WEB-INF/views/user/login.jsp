<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="../css/community-nav.css">
<link rel="stylesheet" href="../css/login.css">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css"
	rel="stylesheet">
	
	<script>
	function loginCheck(){
		if(document.getElementById("userid").value==""){
			alert("아이디를 입력후 로그인 하세요..");
			return false;
		}
		if(document.getElementById("userpwd").value==""){
			alert("비밀번호를 입력하세요..");
			return false;
		}
		return true;
	}
</script>

<div class="sign-in-area">
	<div class="input-area">
		<h1>로그인</h1>
		<form action="${pageContext.servletContext.contextPath}/user/loginOk" method="post" class="input-area" onsubmit="return loginCheck()">
			<input type="text" name="userid" id="userid" class="userid" placeholder="아이디">
			<input type="password" name="userpwd" id="userpwd" class="userpwd" placeholder="비밀번호">
			<div class="sign-in-up">
				<a href="${pageContext.servletContext.contextPath}/userForm">회원가입</a> <a href="${pageContext.servletContext.contextPath}/user/userFind">아이디/비밀번호
					찾기</a>
			</div>
			<input type="submit" value="로그인" class="login-submit">
		</form>
	</div>
</div>

<script
	src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>