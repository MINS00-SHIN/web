<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!-- Stylesheets -->
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/footer.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/default.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-nav.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-header.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-ranking-and-postlist.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-search-result.css">
        <!-- External Libraries -->
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>


        <div class="body-content">

            <!-- #region start -->
            <nav>
                <!-- 로고, 로그인, 회원가입, 마이페이지, 유저아이콘 -->
                <div class="nav-01">
                    <div class="logo-area">
                        <a href="index.html"><img src="${pageContext.servletContext.contextPath}/img/Logo.png"
                                class="logo"></a><!-- 로고 이미지 -->
                    </div>
                    <div class="banner_login">
                        <a href="MiniHome_Home.html"><img src="${pageContext.servletContext.contextPath}/img/User.png"
                                class="user-icon"></a><!-- 여기 링크는 뭐들어가요?? 미니홈피?? -->
                        <a href="Sign_In.html" class="login-button">로그인</a><!-- 이거 # 로그인으로 바꿔야함 -->
                    </div>
                </div>
                <!-- 홈, 자유게시판${pageContext.servletContext.contextPath}${pageContext.servletContext.contextPath} 카테고리 + 검색버튼 -->
                <div class="nav-02">
                    <div class="category">
                        <a href="index.html">홈</a><!-- 홈 -->
                        <a href="Community_Free.html">자유게시판</a><!-- 자유게시판 -->
                        <a href="Community_Auth.html">인증게시판</a><!-- 인증게시판 -->
                        <a href="Community_QNA.html">Q&A게시판</a><!-- Q&A게시판 -->
                        <a href="Community_Map.html">헬스장찾기</a><!-- 헬스장찾기 -->
                    </div>
                    <div class="main-search-box">
                        <input type="search" name="main-search" id="main-search" class="main-search"
                            placeholder="전체 게시물 검색"><!-- 상단 검색박스 -->
                        <!-- 이건 이쁜거 있으면 그때 수정하는걸로 일단 input:search로 넣어둠 -->
                    </div>
                </div>
            </nav>
            <hr>
            <!-- #endregion -->


            <!-- 랭킹영역 -->
            <!-- #region start -->
            <div class="content">
                <div class="left">
                    <div class="follow-ranking">
                        <ul>
                            <li class="ranking-head">팔로워 랭킹 🏆 </li>
                            <li>&nbsp;</li>
                            <li><a href="MiniHome_Home.html">#🥇 하이룽</a></li>
                            <li><a href="MiniHome_Home.html">#🥈 2등입니다.</a></li>
                            <li><a href="MiniHome_Home.html">#🥉 내아래로메달없음</a></li>
                            <li><a href="MiniHome_Home.html">#4 : 진자억울하다</a></li>
                            <li><a href="MiniHome_Home.html">#5 : 근육돼지</a></li>
                            <li><a href="MiniHome_Home.html">#6 : 아침은닭가슴살사과쉐이크</a></li>
                            <li><a href="MiniHome_Home.html">#7 : 금잔디명예소방관</a></li>
                            <li><a href="MiniHome_Home.html">#8 : 인생최대업적롤플레</a></li>
                            <li><a href="MiniHome_Home.html">#9 : 닭가슴살도시락소믈리에</a></li>
                        </ul>
                    </div>
                    <div class="like-ranking">
                        <ul>
                            <li class="ranking-head">인기글 랭킹 🏆 </li>
                            <li>&nbsp;</li>
                            <li><a href="Community_post.html">#🥇 어깨가 너무 아파요</a></li>
                            <li><a href="Community_post.html">#🥈 오늘 기록 갱신</a></li>
                            <li><a href="Community_post.html">#🥉 닭가슴살 1+1+1 행사</a></li>
                            <li><a href="Community_post.html">#4 : 프로틴 이 맛이 맞아요?</a></li>
                            <li><a href="Community_post.html">#5 : 정보)스트랩 추천</a></li>
                            <li><a href="Community_post.html">#6 : 집 앞 헬스장 시설 수준</a></li>
                            <li><a href="Community_post.html">#7 : 입원했는데, 누워있으면 근손실옴?</a></li>
                            <li><a href="Community_post.html">#8 : 헬스장 불났다</a></li>
                            <li><a href="Community_post.html">#9 : 눈바디 어떰?</a></li>
                        </ul>
                    </div>
                </div>
                <!-- 게시글 영역 -->
                <div class="right">
                    <!-- 2차카테고리, 전체글, 내글 버튼 -->
                    <div class="second-category">
                        <select name="2nd-category" id="second-cat">
                            <!-- 이 부분 디자인은 나중에 바꿔야하나? 싶어요
                    일단 완성해두고 셀렉트 디자인 찾아볼게요. -->
                            <option value="none">부위 카테고리</option>
                            <option value="1">상체</option>
                            <option value="2">하체</option>
                        </select>
                        <div class="check-post"><a href="">전체 게시물</a></div>
                        <div class="check-post"><a href="Community_Show_MyPost.html">내 게시물</a></div>
                    </div>

                    <!-- 게시글 목록 -->
                    <div class="post-list">
                        <div class="post-list-head">
                            <div class="post-sort">
                                <div class="board-name-area">
                                    자유게시판
                                </div>

                            </div>
                            <hr>
                        </div>
                        <!-- 제목, 댓글, 따봉, 조회, 날짜 -->
                        <div class="second-head">
                            <div class="second-title">글 제목
                            </div>
                            <div class="second-comment">
                                <img src="${pageContext.servletContext.contextPath}/img/comment.png">
                            </div>
                            <div class="second-like">
                                <img src="${pageContext.servletContext.contextPath}/img/thumbs-up.png">
                            </div>
                            <div class="second-view">
                                <img src="${pageContext.servletContext.contextPath}/img/view.png">
                            </div>
                            <div class="second-post-date">작성일</div>
                        </div>
                        <hr class="inbox">

                        <div class="posts">
                            <ul class="posts-ul">
                                <!-- 게시글 동적 로딩-->
                                <c:forEach var="post" items="${postList}">
                                    <li class="posts-li">
                                        <a href="Community_post.jsp?postId=${post.id}">
                                            <div class="first-line">${post.title}</div>
                                            <div class="second-line">
                                                <div class="post-content">${post.content}</div>
                                                <div class="rate">
                                                    <div class="comment-seper">${post.commentCount}</div>
                                                    <div class="like-seper">${post.likeCount}</div>
                                                    <div class="view-seper">${post.viewCount}</div>
                                                    <div class="date">${post.date}</div>
                                                </div>
                                            </div>
                                            <div class="third-line">
                                                <div class="writer">${post.writer}</div>
                                                <div class="board">${post.board}</div>
                                            </div>
                                        </a>
                                        <hr class="inbox">
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                    <div class="show-result-area">
                        <input type="button" value="인증게시판 검색 결과 전체 보기" class="show-result-all"
                            onclick="window.location.href = 'Community_Auth.html'">
                    </div>

                    <div class="post-list">
                        <div class="post-list-head">
                            <div class="post-sort">
                                <div class="board-name-area">
                                    Q&A게시판
                                </div>
                            </div>
                            <hr>
                        </div>
                        <!-- 제목, 댓글, 따봉, 조회, 날짜 -->
                        <div class="second-head">
                            <div class="second-title">글 제목
                            </div>
                            <div class="second-comment">
                                <img src="${pageContext.servletContext.contextPath}/img/comment.png">
                            </div>
                            <div class="second-like">
                                <img src="${pageContext.servletContext.contextPath}/img/thumbs-up.png">
                            </div>
                            <div class="second-view">
                                <img src="${pageContext.servletContext.contextPath}/img/view.png">
                            </div>
                            <div class="second-post-date">작성일</div>
                        </div>
                        <hr class="inbox">
                        <!-- 여기서부터 더미데이터 채우면 됨 -->
                        <div class="posts">
                            <ul class="posts-ul">
                                <!-- 글을 불러와서 html에 적을 때 여기서부터-->
                                <li class="posts-li">
                                    <a href="Community_post.html">
                                        <div class="first-line">제 운동계획 어떤가요?</div>
                                        <div class="second-line">
                                            <div class="post-content">하체 이틀조지니까 팔로 걸어다녀야하는디 ㄷㄷ</div>
                                            <div class="rate">
                                                <div class="comment-seper">2</div>
                                                <div class="like-seper">5</div>
                                                <div class="view-seper">5</div>
                                                <div class="date">04:32</div>
                                            </div>
                                        </div>
                                        <div class="third-line">
                                            <div class="writer">로니 콜먼</div>
                                            <div class="board">Q&A게시판</div>

                                        </div>
                                    </a>
                                    <hr class="inbox">
                                </li>
                                <li class="posts-li">
                                    <a href="Community_post.html">
                                        <div class="first-line">A사 프로틴 이거 괜찮음?</div>
                                        <div class="second-line">
                                            <div class="post-content">맛은 있는데, 인지도가 너무 없어서 물어봄. 괜찮음??</div>
                                            <div class="rate">
                                                <div class="comment-seper">11</div>
                                                <div class="like-seper">2</div>
                                                <div class="view-seper">20</div>
                                                <div class="date">01:33</div>
                                            </div>
                                        </div>
                                        <div class="third-line">
                                            <div class="writer">고든 램지</div>
                                            <div class="board">Q&A게시판</div>

                                        </div>
                                    </a>
                                    <hr class="inbox">
                                </li>
                                <li class="posts-li">
                                    <a href="Community_post.html">
                                        <div class="first-line">렛 풀 다운 자세 이거 맞음?</div>
                                        <div class="second-line">
                                            <div class="post-content">이래도 되는거 맞나?? 하고나니까 어깨가 자아를 가진 것
                                                같은데?....
                                                레고마냥 팔 빠질
                                                듯</div>
                                            <div class="rate">
                                                <div class="comment-seper">5</div>
                                                <div class="like-seper">3</div>
                                                <div class="view-seper">23</div>
                                                <div class="date">09-12</div>
                                            </div>
                                        </div>
                                        <div class="third-line">
                                            <div class="writer">헬린이</div>
                                            <div class="board">Q&A게시판</div>

                                        </div>
                                    </a>
                                    <hr class="inbox">
                                </li>

                                <!-- 여기까지 -->
                            </ul>
                        </div>
                    </div>
                    <div class="show-result-area">
                        <input type="button" value="Q&A 게시판 검색 결과 전체 보기" class="show-result-all"
                            onclick="window.location.href = 'Community_QNA.html'">
                    </div>

                    <div class="margin-for-search-result"></div>


                </div>
                <!-- 이거 날리고 css 다시넣어야함 -->

            </div>


        </div>
        <script src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>