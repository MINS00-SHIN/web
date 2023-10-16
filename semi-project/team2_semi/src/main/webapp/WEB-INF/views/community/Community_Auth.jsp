<!--그냥 통째로 갈아엎어주세요-->
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Stylesheets -->
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/default.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-header.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-search-result.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-ranking-and-postlist.css">
<!-- External Libraries -->
<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    .page {
        text-align: center;
        /* 텍스트와 인라인 요소 중앙 정렬 */
        display: flex;
        /* Flexbox 사용 */
        justify-content: center;
        /* 수평 중앙 정렬 */
        align-items: center;
        /* 수직 중앙 정렬 */
    }

    .page ul {
        list-style-type: none;
        /* 목록 스타일 제거 */
        padding: 0;
        /* 패딩 제거 */
        display: inline-flex;
        /* 인라인 Flexbox로 만들어 요소들을 한 줄로 배치 */
    }

    .page li {
        margin: 0 5px;
        /* 각 항목 주위에 약간의 마진 추가 */
    }
</style>


<body>
<!-- #region start -->
<header>
    <!-- 게시판 알려주는 박스 -->
    <div class="intro-board"
         style="background-image: url(${pageContext.servletContext.contextPath}/img/Auth_Banner.png);">
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
            <select name="category" id="second-cat" value="${pVO.category}">
                <option value="0" ${pagingVO.category=='0' ? 'selected' : '' }>카테고리</option>
                <option value="1" ${pagingVO.category=='1' ? 'selected' : '' }>상체</option>
                <option value="2" ${pagingVO.category=='2' ? 'selected' : '' }>하체</option>
            </select>
            <div class="check-post"></div>
            <div class="check-post">
            </div>
        </div>
        <!-- 게시글 목록 -->
        <div class="post-list">
            <div class="post-list-head">
                <div class="post-sort">
                    <div style="color: #464d86;">정렬</div>
                    <select name="post-sort" id="post-sort-select" value="${pVO.postSort}"
                            onchange="updateURL();">">
                        <option value="1" ${pagingVO.postSort=='1' ? 'selected' : '' }>최신순</option>
                        <option value="2" ${pagingVO.postSort=='2' ? 'selected' : '' }>좋아요순</option>
                        <option value="3" ${pagingVO.postSort=='3' ? 'selected' : '' }>조회순</option>
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
                    <a
                            href="${pageContext.servletContext.contextPath}/board/view?post_id=${bVO.post_id}">
                        <div class="first-line">${bVO.title}</div>
                        <div class="second-line">
                            <div class="post-content" data-bodypart="${bVO.bodypart}"></div>
                            <div class="rate">
                                <div class="comment-seper">${bVO.commentsCount}</div>
                                <div class="like-seper">${bVO.like}</div>
                                <div class="view-seper">${bVO.views}</div>
                                <div class="date">${bVO.write_date}</div>
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
                <div class="search flex-container"> <!-- Add a class to make this a flex container -->
                    <form method="get" action="${pageContext.servletContext.contextPath}/AuthCommunity/list"
                          onsubmit="return searchCheck()">
                        <select name="searchKey">
                            <option value="title" ${pVO.searchKey=='title' ? 'selected' : '' }>제목</option>
                            <option value="content" ${pVO.searchKey=='content' ? 'selected' : '' }>글내용
                            </option>
                            <option value="userid" ${pVO.searchKey=='userid' ? 'selected' : '' }>글쓴이
                            </option>
                        </select>
                        <input type="search" name="searchWord" id="inboard-search" value="${pVO.searchWord}"
                               class="inboard-search" placeholder="자유게시판 내 검색">
                        <input type="submit" value="search" class="post-button" id="search-button">
                    </form>
                    <c:if test="${LogStatus=='Y'}">
                        <a href="${pageContext.servletContext.contextPath}/AuthCommunity/write">
                            <input type="button" value="글 작성" class="post-button" id="write-button">
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
        <c:url var="prevUrl" value="/AuthCommunity/list">
            <c:param name="nowPage" value="${pVO.nowPage-1}" />
            <c:param name="searchKey" value="${pVO.searchKey}" />
            <c:param name="searchWord" value="${pVO.searchWord}" />
            <c:param name="category" value="${pVO.category}" />
            <c:param name="postSort" value="${pVO.postSort}" />
        </c:url>

        <c:url var="nextUrl" value="/AuthCommunity/list">
            <c:param name="nowPage" value="${pVO.nowPage+1}" />
            <c:param name="searchKey" value="${pVO.searchKey}" />
            <c:param name="searchWord" value="${pVO.searchWord}" />
            <c:param name="category" value="${pVO.category}" />
            <c:param name="postSort" value="${pVO.postSort}" />
        </c:url>
        <div class="paging">
            <ul>
                <!-- prev 페이지 -->
                <c:choose>
                    <c:when test="${pVO.nowPage == 1}">
                        <li>prev</li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${prevUrl}">prev</a></li>
                    </c:otherwise>
                </c:choose>

                <!-- 번호 페이지 -->
                <c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}"
                           step="1">
                    <c:if test="${p <= pVO.totalPage}">
                        <c:url var="pageNumUrl" value="/AuthCommunity/list">
                            <c:param name="nowPage" value="${p}" />
                            <c:param name="searchKey" value="${pVO.searchKey}" />
                            <c:param name="searchWord" value="${pVO.searchWord}" />
                            <c:param name="category" value="${pVO.category}" />
                            <c:param name="postSort" value="${pVO.postSort}" />
                        </c:url>
                        <c:choose>
                            <c:when test="${p == pVO.nowPage}">
                                <li class="paging-button active">${p}</li>
                            </c:when>
                            <c:otherwise>
                                <li class="paging-button">
                                    <a href="${pageNumUrl}">${p}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
                <!-- next 페이지 -->
                <c:choose>
                    <c:when test="${pVO.nowPage < pVO.totalPage}">
                        <li><a href="${nextUrl}">next</a></li>
                    </c:when>
                    <c:otherwise>
                        <li>next</li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function() {
        $('.post-content').each(function() {
            var originalString = $(this).data('bodypart');
            var parts = originalString.split('/');

            for (var i = 0; i < parts.length; i++) {
                switch(parts[i]) {
                    case "chest":
                        parts[i] = "#가슴";
                        break;
                    case "shoulder":
                        parts[i] = "#어깨";
                        break;
                    case "back":
                        parts[i] = "#등";
                        break;
                    case "arm":
                        parts[i] = "#팔";
                        break;
                    case "stomach":
                        parts[i] = "#복부";
                        break;
                    case "waist":
                        parts[i] ="#허리";
                        break;
                    case "thigh":
                        parts[i] ="#허벅지";
                        break;
                    case  "hip":
                        parts[i]= "#엉덩이";
                        break;
                    case  "calf":
                        parts[i] = "#종아리";
                        break;
                }
            }

            var newString = parts.join(' ');

            $(this).text(newString);
        });
    });
</script>
<script>
    function searchCheck() {
        let searchWord = $("#inboard-search").val();
        if (searchWord === "") {
            alert("검색어를 입력해주세요");
            return false;
        }
        return true;
    }

    function updateURL() {
        const selectedValue = document.getElementById("post-sort-select").value;
        const currentURL = window.location.href;
        const newURL = currentURL + (currentURL.includes("?") ? "&" : "?") + "postSort=" + selectedValue;
        window.location.href = newURL;
    }

    function constructUrl() {
        let currentParams = new URLSearchParams(window.location.search);

        let category = $("#second-cat").val();
        let postSort = $("#post-sort-select").val();
        let searchWord = $("#inboard-search").val();

        if(category||category!="0"){
            currentParams.set('category', category);
        }
        if(postSort){
            currentParams.set('postSort', postSort);
        }else{
            currentParams.set('postSort', "1");
        }
        /*if(searchWord){
            currentParams.set('searchWord', encodeURIComponent(searchWord));
        }*/

        let url = "${pageContext.servletContext.contextPath}/AuthCommunity/list";
        url += "?" + currentParams.toString();

        return url;
    }

    // 페이지가 로드되면 현재 URL의 값을 사용하여 드롭다운 값을 설정합니다.
    $(document).ready(function() {
        let params = new URLSearchParams(window.location.search);

        if (params.has('category')) {
            $('#second-cat').val(params.get('category'));
        }
        if (params.has('postSort')) {
            $('#post-sort-select').val(params.get('postSort'));
        }
    });

    $("#second-cat, #post-sort-select").change(function () {
        window.location.href = constructUrl();
    });

</script>
        