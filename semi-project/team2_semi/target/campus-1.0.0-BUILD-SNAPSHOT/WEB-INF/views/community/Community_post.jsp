<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/default.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-header.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-ranking-and-postlist.css">
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-post.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
        <!-- ck에디터  -->
        <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/super-build/ckeditor.js"></script>

        <script>
            function boardDel() {
                if (confirm("게시글을 정말 삭제하시겠습니까?")) {
                    location.href = "/campus/board/delete?no=${vo.no}"
                }
            }

            //ajax를 이용한 댓글등록, 수정, 삭제, 목록
            //목록
            function replyList() {
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/boardReply/list',
                    data: { no: "${vo.no}" },
                    type: 'GET',
                    success: function (result) {
                        var tag = "";
                        $(result).each(function (i, rVO) {
                            tag += "<div class='comments-block'>";
                            tag += "<a class='media-left' href='MiniHome_Home.html'><img class='img-circle img-sm' alt='Profile Picture' src='" + "${pageContext.servletContext.contextPath}/img/profile4.png" + "'></a>";
                            tag += "<div class='media-body'>";
                            tag += "<div class='mar-btm'>";
                            tag += "<a href='MiniHome_Home.html' class='btn-link text-semibold media-heading box-inline'>" + rVO.userid + "</a>";
                            tag += "<p class='text-muted text-sm'><i class='fa fa-mobile fa-lg'></i> " + rVO.writedate + "</p>";
                            tag += "</div>";
                            tag += "<p>" + rVO.comment + "</p>";

                            if ('${logId}' == rVO.userid) {
                                tag += "<a class='btn btn-sm btn-default btn-hover-primary' href='#'>Edit</a>";
                                tag += "<a class='btn btn-sm btn-default btn-hover-danger' title='" + rVO.replyno + "' href='#'>Del</a>";
                            }

                            tag += "<div class='pad-ver'>";
                            tag += "<span class='tag tag-sm'><i class='fa fa-heart text-danger'></i> 250 좋아요</span>";
                            tag += "<div class='btn-group'>";
                            tag += "<a class='btn btn-sm btn-default btn-hover-success' href='#'><i class='fa fa-thumbs-up'></i></a>";
                            tag += "<a class='btn btn-sm btn-default btn-hover-danger' href='#'><i class='fa fa-thumbs-down'></i></a>";
                            tag += "</div>";
                            tag += "<a class='btn btn-sm btn-default btn-hover-primary' href='#'>답글 작성</a>";
                            tag += "</div>";

                            tag += "<hr></div></div>";
                        });

                        $("#replyList").html(tag);
                    },
                    error: function (error) {
                        console.log(error.responseText);
                    }
                });

            }

            //등록
            $(function () {
                $("#replyForm").submit(function () {
                    //form태그의 action 중지
                    event.preventDefault();

                    //comment 입력 유무 확인
                    if ($("#comment").val() == "") {
                        alert("댓글을 입력 후 등록하세요");
                        return false;
                    }

                    //form의 데이터를 query로 만들기
                    var params = $(this).serialize();
                    //         = "no="+$("no").val()+"&comment="+$("#comment").val()
                    $.ajax({
                        url: "/campus/boardReply/write",
                        data: params,
                        type: "POST",
                        success: function (result) {
                            $("#comment").val("");
                            //목록 새로 출력
                            replyList();
                        },
                        error: function (error) {
                            console.log(error.responseText);
                        }
                    });
                });
                //수정 폼 띄우기
                $(document).on('click', '#replyList input[value=Edit]', function () {
                    $(this).parent().css('display', 'none');//부모 숨기기(댓글 내용)
                    $(this).parent().next().css('display', 'block');

                });
                //수정(DB)
                $(document).on('submit', '#replyList form', function () {
                    event.preventDefault();
                    var params = $(this).serialize();
                    var url = "${pageContext.servletContext.contextPath}/boardReply/editOk";
                    $.ajax({
                        url: url,
                        data: params,
                        type: 'POST',
                        success: function (result) {
                            if (result == "0") {
                                alert("댓글 수정 실패!");
                            } else {
                                replyList();
                            }
                        },
                        error: function (error) {
                            console.log(error.responseText);
                            alert("댓글 수정 실패!");
                        }

                    });
                });
                $(document).on('click', '#replyList input[value=Del]', function () {
                    if (confirm("삭제하시겠습니까?")) {
                        //삭제할 레코드 번호
                        var replyno = $(this).attr("title");

                        $.ajax({
                            url: "${pageContext.servletContext.contextPath}/boardReply/delete",
                            data: {
                                replyno: replyno
                            },
                            type: "GET",
                            success: function (result) {
                                replyList();
                            },
                            error: function (error) {
                                console.log(error.responseText);
                            }
                        });
                    }

                });
                //목록출력
                replyList();
            });


        </script>

        <main>
            <jsp:include page="header.jspf" />
            <!-- #게시물 선택 바 시작-->
            <div class="check-post">
                <a href="">전체 게시물</a>&nbsp;&nbsp;&nbsp;
                <a href="Community_Show_MyPost.html">내 게시물</a>
                <hr>
            </div>
            <!-- #게시물 선택 바 끝/-->
            <!-- 부위 카테고리 리스트 시작 -->
            <div class="muscle-categories">
                <p>부위 카테고리</p>
            </div>
            <!-- 부위 카테고리 리스트 끝 -->
            <div class="post_div">
                <div class="content">
                    <div class="content_title">
                        <h1>${vo.subject}</h1>
                        <h4>게시판 : <span><a href="#">자유게시판</a></span><br>글쓴이 : ${vo.userid}, 조회수 : ${vo.hit}, 등록일 :
                            ${vo.writedate}</h4>
                        <hr>
                    </div>
                    <div class="content_post">
                        <p>${vo.content}</p>
                    </div>

                    <div class="content-post-tail" id="comment-anchor">
                        <a href="#"><img src="${pageContext.servletContext.contextPath}/img/thumbs-up.png" alt=""
                                class="icon">&nbsp;&nbsp;좋아요</a>
                        <a href="#"><img src="${pageContext.servletContext.contextPath}/img/share-icon.jpg" alt=""
                                class="icon">&nbsp;&nbsp;공유</a>
                        <hr style="margin-top:10px;">
                    </div>
                    <div>
                        <a href="/campus/board/list?nowPage=${pVO.nowPage}<c:if test="
                            ${pVO.searchWord!=null}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>
                            ">목록</a>
                        <!-- 현재 글쓴이, 로그인 아이디 같으면 출력-->
                        <c:if test="${vo.userid==logId}">
                            <a href="/campus/board/edit?no=${vo.no}">수정</a>
                            <a href="javascript:boardDel()">삭제</a>
                        </c:if>
                    </div>

                    <!-- 댓글 -->
                    <div id="replyArea">
                        <!-- 로그인 상태일때 댓글쓰기 -->
                        <c:if test="${logStatus=='Y'}">
                            <div class="panel">
                                <div class="panel-body">
                                    <form method="POST" id="replyForm">
                                        <!-- 원글 글 번호 -->
                                        <input type="hidden" name="no" value="${vo.no}">
                                        <textarea class="form-control" rows="2" placeholder="댓글을 입력하세요." name="comment"
                                            id="comment"></textarea>
                                        <div class="mar-top clearfix">
                                            <button class="btn btn-sm btn-primary pull-right" type="submit"><i
                                                    class="fa fa-pencil fa-fw"></i> 작성</button>
                                            <!-- Optionally, add the provided icons if needed -->
                                            <a class="btn btn-trans btn-icon fa fa-video-camera add-tooltip"
                                                href="#"></a>
                                            <a class="btn btn-trans btn-icon fa fa-camera add-tooltip" href="#"></a>
                                            <a class="btn btn-trans btn-icon fa fa-file add-tooltip" href="#"></a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:if>
                        <!-- 댓글 목록-->
                        <div style="background-color: #FFF3FE">댓글 목록</div>
                        <ul id="replyList">
                        </ul>
                    </div>
                </div>
            </div>
            <div class="content_side_div">
                <div class="comment_button_side">
                    <button onclick="scrollToElement('comment-anchor')">댓글</button>
                </div>

                <div class="follow_button">
                    <button>작성자 팔로우</button>
                </div>

                <div class="like_comment_count">
                    <div class="item">
                        <img src="${pageContext.servletContext.contextPath}/img/view.png" alt="조회수">
                        <p>조회수 : 10</p>
                    </div>
                    <div class="item">
                        <img src="${pageContext.servletContext.contextPath}/img/comment.png" alt="댓글">
                        <p>댓글 : 20</p>
                    </div>
                </div>
            </div>

            <script src="${pageContext.servletContext.contextPath}/js/community-post.js"></script>
            <script src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>
            <jsp:include page="footer.jspf" />
        </main>