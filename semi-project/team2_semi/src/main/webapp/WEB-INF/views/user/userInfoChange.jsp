<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/community-nav.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/userInfoChange.css">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css"
	rel="stylesheet">

<h1>회원 정보 수정</h1>

<div id="warning"></div>

<div class="signup-area">
	<div class="signup-area2">
    <form method="post" action="" id="userFrm">
        <div class="id-input">
			<label for="userid">아이디</label>
            <input type="text" name="userid" id="userid" placeholder="8~16글자의 대소문자, 숫자만 지원합니다." class="inputtext">
            <input type="button" value="확인" class="id-check" id="id-check">
        </div>
        
		<div class="pwd-input">
                    <label for="userpwd">기존 비밀번호</label>
                    <input type="password" name="userpwd" id="userpwd" class="inputtext"
                        placeholder="">
                </div>

                <div class="pwd2-input">
                    <label for="userpwd2">새로운 비밀번호</label>
                    <input type="password" name="userpwd" id="userpwd2" class="inputtext"
                        placeholder="8~16글자 대문자, 소문자, 숫자, 특수문자 중 2가지 이상 사용">
                </div>
        
        <div class="name-input">
 			<label for="username">닉네임 </label>
            <input type="text" name="username" id="username" class="inputtext" placeholder="">
        </div>
        
        <div class="email-input">
			<label label for="useremail"> 이메일 </label>
            <input type="text" name="email" id="useremail" class="inputtext" placeholder="">
            <input type="button" value="확인" class="email-check" id="email-check">
        </div>
        <div class="Question">
            <select name="pwd_q" id="pwd_q" class="pwd_q">
                <option value="none">비밀번호 찾기 질문</option>
                <option value="내가 태어난 도시 이름은?">내가 태어난 도시 이름은?</option>
                <option value="어릴 적 다닌 초등학교 이름은?">어릴 적 다닌 초등학교 이름은?</option>
                <option value="어머니 이름은?">어머니 이름은?</option>
                <option value="아버지 이름은?">아버지 이름은?</option>
                <option value="본인의 좌우명?">본인의 좌우명?</option>
            </select>
        </div>
        <div class="Answer">
            <input type="text" name="pwd_a" id="pwd_a" class="inputtext" placeholder="비밀번호 찾기 답">
        </div>

        <input type="submit" value="수정 완료" class="signup-submit">

    </form>
    </div>
</div>

<script src="${pageContext.servletContext.contextPath}/js/signup-checkinput.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/signup-submitcheck.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>