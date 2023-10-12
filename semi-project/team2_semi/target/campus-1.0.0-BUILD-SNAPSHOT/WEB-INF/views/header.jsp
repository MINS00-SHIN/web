<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-nav.css">
        <nav>
            <!-- 로고, 로그인, 회원가입, 마이페이지, 유저아이콘 -->
            <div class="nav-01">
                <div class="logo-area">
                    <a href="index.html"><img src="${pageContext.request.contextPath}/img/Logo.png"
                            class="logo"></a><!-- 로고 이미지 -->
                </div>
                <div class="banner_login">
                    <a href="MiniHome_Home.html"><img src="${pageContext.request.contextPath}/img/User.png"
                            class="user-icon"></a><!-- 여기 링크는 뭐들어가요?? 미니홈피?? -->
                    <a href="Sign_In.html" class="login-button">로그인</a><!-- 이거 # 로그인으로 바꿔야함 -->
                </div>
            </div>
            <!-- 홈, 자유게시판${pageContext.request.contextPath}${pageContext.request.contextPath} 카테고리 + 검색버튼 -->
            <div class="nav-02">
                <div class="category">
                    <a href="index.html">홈</a><!-- 홈 -->
                    <a href="../Community_Free.jsp">자유게시판</a><!-- 자유게시판 -->
                    <a href="../Community_Auth.jsp">인증게시판</a><!-- 인증게시판 -->
                    <a href="../Community_QNA.jsp">Q&A게시판</a><!-- Q&A게시판 -->
                    <a href="Community_Map.html">헬스장찾기</a><!-- 헬스장찾기 -->
                </div>
                <div class="main-search-box">
                    <input type="search" name="main-search" id="main-search" class="main-search"
                        placeholder="전체 게시판 검색"><!-- 상단 검색박스 -->
                    <!-- 이건 이쁜거 있으면 그때 수정하는걸로 일단 input:search로 넣어둠 -->
                </div>
            </div>
        </nav>
        <hr>