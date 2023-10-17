<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.servletContext.contextPath}/img/top2.jpg" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/swiper-bundle.min.css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/styles.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <title>헬스엔에스</title>


</head>

<body>
<header class="header" id="header">
    <nav class="nav container">
        <a href="${pageContext.servletContext.contextPath}/home" class="nav__logo">헬스엔에스</a>

        <div class="nav__menu" id="nav-menu">
            <ul class="nav__list">
                <li class="nav__item">
                    <a href="#top" class="nav__link active-link">소개</a>
                </li>
                <li class="nav__item">
                    <a href="#community" class="nav__link">커뮤니티</a>
                </li>
                <li class="nav__item">
                    <a href="#miniHome" class="nav__link">마이 홈</a>
                </li>
                <li class="nav__item">
                    <c:if test="${LogStatus =='Y'}">
                        <a href="${pageContext.servletContext.contextPath}/user/logout" class="nav__link">로그아웃</a>
                    </c:if>
                    <c:if test="${LogStatus !='Y'}">
                        <a href="${pageContext.servletContext.contextPath}/user/login" class="nav__link">로그인</a>
                    </c:if>

                </li>
            </ul>

        </div>

    </nav>
</header>

<main class="main">
    <section class="top" id="top">
        <img src="${pageContext.servletContext.contextPath}/img/top1.jpg" alt="" class="top__img">

        <div class="top__container container grid">
            <div class="top__data">

                <h1 class="top__data-title">당신의 건강한 삶은 <br/> <span><b>헬스엔에스</b></span>와 함께 <br/> 시작합니다.</h1>
                <a href="${pageContext.servletContext.contextPath}/FreeCommunity/list" class="button"
                   style="color: white">살펴보기</a>

            </div>

            <div class="top__social">
                <a href="https://www.facebook.com/" target="_blank" class="top__social-link">
                    <i class="ri-facebook-box-fill"></i>
                </a>
                <a href="https://www.instagram.com/" target="_blank" class="top__social-link">
                    <i class="ri-instagram-fill"></i>
                </a>
                <a href="https://twitter.com/" target="_blank" class="top__social-link">
                    <i class="ri-twitter-fill"></i>
                </a>
            </div>

            <div class="top__info">
                <div>
                    <span class="top__info-title">헬스엔에스</span>
                    <a href="${pageContext.servletContext.contextPath}/FreeCommunity/list"
                       class="button button--flex button--link top__info-button" style="color: white">
                        바로가기 <i class="ri-arrow-right-line"></i>
                    </a>
                </div>

                <div class="top__info-overlay">
                    <a href="Sign_In.html"><img src="${pageContext.servletContext.contextPath}/img/top2.jpg" alt=""
                                                class="top__info-img"></a>
                </div>
            </div>
        </div>
    </section>

    <section class="community section" id="community">
        <div class="community__container container grid">
            <div class="community__data">
                <h2 class="section__title community__title">커뮤니티, <br/> 정보를 공유하세요!</h2>
                <p class="community__description">
                    같은 목표를 가진 사람들과 경험과 지식을 나누며 함께 성장할 수 있습니다. 지금 바로 시작해보세요!
                </p>
                <a href="${pageContext.servletContext.contextPath}/FreeCommunity/list" class="button"
                   style="color: white">커뮤니티 둘러보기</a>
            </div>

            <div class="community__img">
                <div class="community__img-overlay">
                    <img src="${pageContext.servletContext.contextPath}/img/community1.jpg" alt=""
                         class="community__img-one">
                </div>

                <div class="community__img-overlay">
                    <img src="${pageContext.servletContext.contextPath}/img/community2.jpg" alt=""
                         class="community__img-two">
                </div>
            </div>
        </div>
        <div class="community_line">
            <hr>
        </div>
    </section>

    <section class="cmt section" id="cmt">
        <h2 class="section__title">다양한 게시판을 이용해보세요 <br><br> 운동은 꾸준한 것이 좋습니다!</h2>
        <div class="discover__container container swiper-container">
            <div class="swiper-wrapper">
                <div class="cmt__card swiper-slide">
                    <a href="${pageContext.servletContext.contextPath}/FreeCommunity/list">
                        <img src="${pageContext.servletContext.contextPath}/img/cmt1.jpg" alt="" class="cmt__img">
                    </a>
                    <div class="cmt__data">
                        <h2 class="cmt__title">자유 게시판</h2>
                        <span class="cmt__description">자유로운 주제</span>
                    </div>
                </div>
                <div class="cmt__card swiper-slide">
                    <a href="${pageContext.servletContext.contextPath}/QaCommunity/list"><img
                            src="${pageContext.servletContext.contextPath}/img/cmt2.jpg" alt="" class="cmt__img"></a>
                    <div class="cmt__data">
                        <h2 class="cmt__title">Q&A 게시판</h2>
                        <span class="cmt__description">무엇이든 질문하세요</span>
                    </div>
                </div>
                <div class="cmt__card swiper-slide">
                    <a href="../html/Community_Map.html"><img
                            src="${pageContext.servletContext.contextPath}/img/cmt4.jpg" alt="" class="cmt__img"/></a>
                    <div class="cmt__data">
                        <h2 class="cmt__title">헬스장 찾기</h2>
                        <span class="cmt__description">주변 헬스장 어디있지?</span>
                    </div>
                </div>
                <div class="cmt__card swiper-slide">
                    <a href="${pageContext.servletContext.contextPath}/AuthCommunity/list"><img
                            src="${pageContext.servletContext.contextPath}/img/cmt3.jpg" alt="" class="cmt__img"></a>
                    <div class="cmt__data">
                        <h2 class="cmt__title">인증 게시판</h2>
                        <span class="cmt__description">꾸준히 인증하세요!</span>
                    </div>
                </div>
            </div>
        </div>

    </section>
    <section class="miniHome section" id="miniHome">
        <h2 class="section__title">나만의 미니 홈<br></h2>

        <div class="miniHome__container container grid">
            <div class="miniHome__content grid">
                <div class="miniHome__data">
                    <h2 class="miniHome__number">프로필</h2>
                    <span class="miniHome__description">나를 소개합니다<br>오늘 기분은?</span>
                </div>

                <div class="miniHome__data">
                    <h2 class="miniHome__number">캘린더</h2>
                    <span class="miniHome__description">이모지를 통해 <br> 간단하게</span>
                </div>

                <div class="miniHome__data">
                    <h2 class="miniHome__number">메모</h2>
                    <span class="miniHome__description">성실한 기록 <br> 헬스의 기본!</span>
                </div>
            </div>

            <div class="miniHome__img grid">
                <div class="miniHome__overlay">
                    <img src="${pageContext.servletContext.contextPath}/img/miniHome1.jpg" alt=""
                         class="miniHome__img-one">
                </div>

                <div class="miniHome__overlay">
                    <img src="${pageContext.servletContext.contextPath}/img/miniHome2.jpg" alt=""
                         class="miniHome__img-two">
                </div>
            </div>
        </div>
        <div class="dummyDiv">

        </div>

    </section>

    <section class="miniHome2img section" id="miniHome2">
        <h2 class="section__title">출석하고, 기록하자</h2>
        <div class="miniHome2__container container">
            <p class="miniHome2__description">캘린더, 메모 기능을 통해 쉽고 간단하게 기록해봐요.</p>
            <div class="miniHome2__content">
                <img src="${pageContext.servletContext.contextPath}/img/HH.jpg" alt="" class="miniHome__img-two">
            </div>
        </div>
        <div class="dummyDiv">

        </div>
    </section>


    <div class="miniHome_line">
        <hr>
    </div>
    <section class="miniHome_search_bar section">
        <div class="miniHome_search_bar__bg">
            <div class="miniHome_search_bar__container container">
                <h2 class="section__title miniHome_search_bar__title">프로필<br> 검색하기</h2>
                <p class="miniHome_search_bar__description">헬스인의 닉네임, 아이디를 검색하여 미니 홈으로 방문해보세요!
                </p>

                <form action="http://localhost:8080/healthsns/minihome" method="GET" class="miniHome_search_bar__form">
                    <input type="text" name="id" placeholder="닉네임 및 아이디를 입력해주세요" class="miniHome_search_bar__input"/>
                
                    <button class="button">
                        검색
                    </button>
                </form>                
            </div>
        </div>
    </section>

    <section class="sponsor section">
        <div class="sponsor__container container grid">
            <div class="sponsor__content">
                <img src="${pageContext.servletContext.contextPath}/img/sponsors1.png" alt="" class="sponsor__img1">
            </div>
            <div class="sponsor__content">
                <img src="${pageContext.servletContext.contextPath}/img/sponsors2.png" alt="" class="sponsor__img2">
            </div>
            <div class="sponsor__content">
                <img src="${pageContext.servletContext.contextPath}/img/sponsors3.png" alt="" class="sponsor__img3">
            </div>
            <div class="sponsor__content">
                <img src="${pageContext.servletContext.contextPath}/img/sponsors4.png" alt="" class="sponsor__img4">
            </div>
            <div class="sponsor__content">
                <img src="${pageContext.servletContext.contextPath}/img/sponsors5.png" alt="" class="sponsor__img5">
            </div>
        </div>
    </section>
</main>


<a href="#" class="scrollup" id="scroll-up">
    <i class="ri-arrow-up-line scrollup__icon"></i>
</a>
<script src="${pageContext.servletContext.contextPath}/js/scrollreveal.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/swiper-bundle.min.js"></script>

<script src="${pageContext.servletContext.contextPath}/js/main.js"></script>
