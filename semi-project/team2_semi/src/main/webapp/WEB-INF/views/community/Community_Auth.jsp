<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <script>
            function searchCheck() {
                if (document.getElementById("searchWord").value == "") {
                    alert("검색어를 입력해주세요");
                    return false;
                }
            }
        </script>

        <!-- Stylesheets -->
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/default.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-header.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-search-result.css">
        <!-- External Libraries -->
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        
        <style>
     	   .page {
    			text-align: center; /* 텍스트와 인라인 요소 중앙 정렬 */
	    		display: flex; /* Flexbox 사용 */
 		   		justify-content: center; /* 수평 중앙 정렬 */
 		   		align-items: center; /* 수직 중앙 정렬 */
			}

			.page ul {
  			    list-style-type: none; /* 목록 스타일 제거 */
 				padding: 0; /* 패딩 제거 */
   				display: inline-flex; /* 인라인 Flexbox로 만들어 요소들을 한 줄로 배치 */
			}

			.page li {
    			margin: 0 5px; /* 각 항목 주위에 약간의 마진 추가 */
			}
        
        </style>


        <body>
            <!-- #region start -->
            <header>
                <!-- 게시판 알려주는 박스 -->
                <div class="intro-board"
                    style="background-image: url(${pageContext.servletContext.contextPath}/img/Free_Banner.png);">
                    <div class="board-name">인증게시판</div>
                </div>
            </header>
            <!-- #endregion -->
            <!-- #region start -->
            <!-- 랭킹영역 -->
            <!-- #region start -->
            <div class="content">
                <jsp:include page="/resources/rank.jsp" />
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
                                <div style="color: #464d86;">정렬</div>
                                <select name="post-sort" id="post-sort-select" class="post-sort-select">
                                    <option value="1">최신순</option>
                                    <option value="2">좋아요순</option>
                                    <option value="3">조회순</option>
                                </select>
                            </div>
                            <hr>
                        </div>
                        <!-- 제목, 댓글, 따봉, 조회, 날짜 -->
                        <div class="second-head">
                            <div class="second-title">글 제목</div>
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
                        <c:forEach var="bVO" items="${list}">
                            <li class="posts-li">
                                <a href="/campus/board/view?post_id=${bVO.post_id}">
                                    <div class="first-line">${bVO.title}</div>
                                    <div class="second-line">
                                        <div class="post-content">${bVO.bodypart}</div>
                                        <div class="rate">
                                            <div class="comment-seper">${bVO.commentsCount}</div>
                                            <div class="like-seper">${bVO.like}</div>
                                            <div class="view-seper">${bVO.views}</div>
                                            <div class="date">${bVO.writedate}</div>
                                        </div>
                                    </div>
                                    <div class="third-line">
                                        <div class="writer">${bVO.userid}</div>
                                        <div class="board">인증게시판</div>
                                    </div>
                                </a>
                                <hr class="inbox">
                            </li>
                        </c:forEach>
                    </div>
                    <!-- 검색박스 -->
                    <div class="post-end-line">
                        <div class="inboard-search-area">
                            <div class="search">
                                <form method="get" action="/campus/board/list" onsubmit="return searchCheck()">
                                    <select name="searchKey">
                                        <option value="title">제목</option>
                                        <option value="content">글내용</option>
                                        <option value="userid">글쓴이</option>
                                    </select>
                                    <input type="text" name="searchWord" id="searchWord">
                                    <input type="submit" value="search">
                                </form>
                            </div>
                            <c:if test="${LogStatus!=''&&LogStatus=='Y'}">
                                <div><a href="">글쓰기</a></div>
                            </c:if>
                        </div>
                    </div>
                    <div class="page">
                        <ul>
                            <!--현재 보는 페이지 기준으로 -1-->
                            <c:if test="${pVO.nowPage==1}">
                                <li>prev</li>
                            </c:if>
                            <c:if test="${pVO.nowPage>1}">
                                <li><a href="/campus/board/list?post_idwPage=${pVO.nowPage-1}<c:if test="
                                        ${pVO.searchWord!=null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
                            </c:if>">prev</a></li>
                            </c:if>

                            <c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}"
                                step="1">
                                <c:if test="${p<=pVO.totalPage}"> <!-- 출력할 페이지 번호가 총페이지수보다 작거나 같을 때만-->
                                    <c:if test="${p==pVO.nowPage}"><!-- 현재페이지라면 -->
                                        <li style="background-color: #ddd">
                                    </c:if>
                                    <c:if test="${p!=pVO.nowPage}">
                                        <li>
                                    </c:if>
                                    <a href="/campus/board/list?post_idwPage=${p}<c:if test="
                                        ${pVO.searchWord!=null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
                                </c:if>">${p}</a></li>
                                </c:if>
                            </c:forEach>
                            <!-- next 페이지 -->
                            <c:if test="${pVO.nowPage<pVO.totalPage}">
                                <li><a href="/campus/board/list?post_idwPage=${pVO.nowPage+1}<c:if test="
                                        ${pVO.searchWord!=null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
                            </c:if>">next</a></li>
                            </c:if>
                            <c:if test="${pVO.nowPage>=pVO.totalPage}">
                                <li>next</li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
            <script src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>
            <script src="${pageContext.servletContext.contextPath}/js/community-post-paging.js"></script>
        </body>