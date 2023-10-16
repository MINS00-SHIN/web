<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-nav.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-header.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-ranking-and-postlist.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-post.css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/super-build/ckeditor.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/ckeditor_for_comment.js"></script>
<script>
    let editor;
    window.onload = function () {
        CKEDITOR.ClassicEditor.create(document.getElementById("editor"), option)
            .then( newEditor => {
            editor = newEditor;
        } )
    .catch( error => {
            console.error( error );
        } );
    }
    $(function () {
        $("#main-reply").submit(function () {
            event.preventDefault();
            if (!$("#editor").val()) {
                alert("댓글을 입력 후 시도해주세요");
                event.preventDefault();
            } else {
                var params = $(this).serialize();
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/CommunityReply/write",
                    data: params,
                    type: 'post',
                    success: function (result) {
                        console.log(result);
                        if(editor) {
                            editor.setData("");
                        }
                        commentList();
                    },
                    error: function (error) {
                        console.log(error.responseText);
                    }
                });
            }
        });

        $(document).on('click','#edit-post',function(){
           var postid = ${vo.post_id};
           window.location.href="${pageContext.servletContext.contextPath}/board/edit?post_id="+postid ;
        });

        $(document).on('click','#delete-post', function(){
           var postid = ${vo.post_id};
           if(confirm("정말로 게시글을 삭제하시겠습니까?")){
               window.location.href="${pageContext.servletContext.contextPath}/board/delete?post_id="+postid;
           }
        });

        $(document).on('click','#increse-like',function(){
            var postid=${vo.post_id};
            $.ajax({
                url : "${pageContext.servletContext.contextPath}/board/like",
                type:'post',
                data:{
                    post_id:postid
                },
                success:function(result){
                    //result에 갱신한 like수가 올거임.
                    var newHtml = '<img src="${pageContext.servletContext.contextPath}/img/thumbs-up.png" alt="" class="icon">&nbsp;&nbsp;좋아요 ' + result;
                    $('#increse-like').html(newHtml);
                },
                error:function(error){
                    console.log(error.responseText);
            }
            });
        });
    });
</script>
<style>
    /**************** ckEditor5 커스터마이징 시작  ****************/

    /* 크기 및 위치 */
    .ck.ck-editor {
        max-width: 950px;
        overflow: hidden; /* 스크롤바 제거 */
        border: 1.6px solid var(--blue-basic-color); /* 테두리 */
        border-radius: 10px; /* 테두리 둥글게 */
        margin: 0 auto !important; /* 가운데 정렬 */
    }

    /* 크기 및 위치 */
    .ck-editor__editable {
        height: 150px;
        margin: 0 auto;
    }

    /* 툴바_배경색 변경 */
    .ck.ck-editor .ck-toolbar {
        background-color: #464d86;
    }

    /* 툴바_버튼 변경 */
    .ck.ck-toolbar .ck-button {
        background-color: #464d86; /* 원하는 버튼 배경색으로 변경 */
        color: white; /* 원하는 버튼 텍스트 색상으로 변경 */
        border: #ffffff;
        padding: 4px 7px; /* 버튼 내용을 감싸는 여백 조절 (위아래 10px, 좌우 15px) */
        font-size: 11px; /* 버튼 텍스트 크기 조절 */
    }

    /* 툴바_폰트 색상 변경 */
    .ck.ck-editor .ck-content {
        color: #000000; /* 원하는 폰트 색상으로 변경 */
    }

    /* 툴바_버튼에 마우스를 올렸을 때 색상 변경 */
    .ck.ck-toolbar .ck-button:hover {
        background-color: #ffffff; /* 마우스를 올렸을 때 배경색 변경 */
        color: #464d86; /* 마우스를 올렸을 때 텍스트 색상 변경  */
    }

    /* 툴바_선택된 버튼 스타일 */
    .ck.ck-toolbar .ck-button.ck-on {
        background-color: rgb(255, 255, 255); /* 선택된 상태의 배경색 */
        color: #464d86; /* 선택된 상태의 텍스트 색상  */
    }

    .comments-block #contentdiv img {
        max-width: 100%;
        height: auto;
    }

    /**************** ckEditor5 커스터마이징 끝 ****************/
</style>
<!-- #게시물 선택 바 끝/-->
<!-- 부위 카테고리 리스트 시작 -->
<div class="muscle-categories">
    <c:if test="${vo.cat=='lower'}">
        <p>하체</p>
    </c:if>
    <c:if test="${vo.cat=='upper'}">
        <p>상체</p>
    </c:if>
</div>
<!-- 부위 카테고리 리스트 끝 -->
<div class="post_div" style="margin: 0 auto">
    <div class="content">
        <div class="content_title">
            <h1>${vo.title}</h1>
            <c:if test="${vo.board_cat=='auth'}">
                <h4>게시판 : <span><a
                        href="${pageContext.servletContext.contextPath}/AuthCommunity/list">인증게시판</a></span><span
                        style="margin-left: 30px">글쓴이 : <a
                        href="${pageContext.servletContext.contextPath}/minihome?id=${vo.userid}">${vo.userid}</a></span>
                </h4>
            </c:if>
            <c:if test="${vo.board_cat=='free'}">
                <h4>게시판 : <span><a href="#">자유게시판</a></span><span style="margin-left: 30px">글쓴이 : <a
                        href="${pageContext.servletContext.contextPath}/minihome?id=${vo.userid}">${vo.userid}</a></span>
                </h4>
            </c:if>
            <c:if test="${vo.board_cat=='qna'}">
                <h4>게시판 : <span><a href="#">Q&A게시판</a></span><span style="margin-left: 30px">글쓴이 : <a
                        href="${pageContext.servletContext.contextPath}/minihome?id=${vo.userid}">${vo.userid}</a></span>
                </h4>
            </c:if>
            <hr>
        </div>
        <div class="content_post" style="min-height: 200px">
            ${vo.content}
        </div>
        <div class="content-post-tail" id="comment-anchor">
            <c:if test="${LogStatus == 'Y'}">
                <a style="cursor: pointer" id="increse-like"><img src="${pageContext.servletContext.contextPath}/img/thumbs-up.png" alt="" class="icon">&nbsp;&nbsp;좋아요 ${vo.like}</a>
            </c:if>
            <c:if test="${LogStatus != 'Y'}">
                <a><img src="${pageContext.servletContext.contextPath}/img/thumbs-up.png" alt="" class="icon">&nbsp;&nbsp;좋아요 ${vo.like}</a>
            </c:if>
            <a id="share" style="cursor: pointer"><img src="${pageContext.servletContext.contextPath}/img/share-icon.jpg" alt="" class="icon">&nbsp;&nbsp;공유</a>
            <c:if test="${vo.bodypart!=null}">
                <span style="margin-left: 10px; color: rgb(70,77,134)">${vo.bodypart}</span>
            </c:if>
            <c:if test="${LogId==vo.userid}">
                <div style="margin-top: 30px; color: rgb(70,77,134);"><span
                        id="edit-post" style="cursor: pointer">수정</span><span id="delete-post" style="margin-left: 30px; color: red; cursor: pointer">삭제</span>
                </div>
                <!-- a태그 바꿔서 링크넣든 해야함-->
            </c:if>
            <hr style="margin-top:10px;">
        </div>
        <div class="comment-area">
            <div class="comments_container bootdey">
                <div class="col-md-12 bootstrap snippets">
                    <c:if test="${LogStatus=='Y'}">
                        <form id="main-reply">
                            <input type="hidden" name="post_id" value="${vo.post_id}"/>
                            <input type="hidden" name="depth" value="0"/>
                            <div class="panel">
                                <div class="panel-body">
                                    <textarea class="form-control" name="content" id="editor" rows="2"
                                              placeholder="댓글을 입력하세요."></textarea>
                                    <div class="mar-top clearfix">
                                        <button class="btn btn-sm btn-primary pull-right" type="submit"><i
                                                class="fa fa-pencil fa-fw"></i> 작성
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <div class="panel">
                        <div class="panel-body panel-body-second">
                            <hr/>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
            <script>
                function commentList() {



                    var no = ${vo.post_id};
                    $.ajax({
                        url: "${pageContext.servletContext.contextPath}/CommunityReply/list",
                        data: {
                            no: no
                        },
                        type: 'post',
                        success: function (result) {
                            $('.panel-body-second').empty();
                            for (var i = 0; i < result.length; i++) {
                                var comment = result[i];
                                var email = comment.email;
                                var hash = CryptoJS.MD5(email.trim().toLowerCase());
                                var gravatarUrl = "https://www.gravatar.com/avatar/" + hash + "?s=200&d=retro";
                                var marginLeft = comment.depth == 1 ? '70px' : '10px';

                                var htmltag = '<div class="comments-block" style="margin-left:' + marginLeft + '">' +
                                    '<div class="media-left"><img class="img-circle img-sm" alt="Profile Picture" src="' + gravatarUrl + '"></div>' +
                                    '<div class="media-body" id="' + comment.comment_id + '">' +
                                    '<div class="mar-btm">' +
                                    '<a href="${pageContext.servletContext.contextPath}/minihome?id='+comment.writer+'" class="btn-link text-semibold media-heading box-inline">' + comment.writer + '</a>' +
                                    '<p class="text-muted text-sm">' + comment.write_date + '</p>' +
                                    '</div>' +
                                    '<div id="contentdiv">' + comment.content + '</div>' +
                                    '<div class="pad-ver">';
                                if (comment.depth == 0) {
                                    htmltag += '<a class="btn btn-sm btn-default btn-hover-primary replyreply" href="#">답글 작성</a>';
                                }

                                if ('${LogId}' == comment.writer) {
                                    htmltag += '<a class="btn btn-sm btn-default btn-hover-primary comment-edit" href="#" id="' + comment.comment_id + '" style="margin-left: 10px">수정</a>' + '<a class="btn btn-sm btn-default btn-hover-primary comment-delete" href="#" id="' + comment.comment_id + '"  style="color:red;margin-left: 10px"">삭제</a>';

                                }
                                if(comment.isdelete==1){
                                    htmltag = '<div class="comments-block" style="margin-left:' + marginLeft + '">' +
                                        '<div class="media-left"><img class="img-circle img-sm" alt="Profile Picture" src="' + gravatarUrl + '"></div>' +
                                        '<div class="media-body" id="' + comment.comment_id + '">' +
                                        '<div class="mar-btm">' +
                                        '<a href="${pageContext.servletContext.contextPath}/minihome?id='+comment.writer+'" class="btn-link text-semibold media-heading box-inline">' + comment.writer + '</a>' +
                                        '<p class="text-muted text-sm">' + comment.write_date + '</p>' +
                                        '</div>' +
                                        '<div id="contentdiv">' + comment.content + '</div>' +
                                        '<div class="pad-ver">';
                                }
                                htmltag += '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '<hr/>';
                                var commentBlock = $(htmltag);


                                $('.panel-body-second').append(commentBlock);
                            }
                            if(${LogStatus!='Y'}){
                                $(".replyreply").remove();
                            }
                        },
                        error: function (error) {
                            console.log(error.responseText);
                        }
                    });

                }

                $(document).ready(function () {
                    commentList();
                    $('.panel-body-second').on('click', '.replyreply', function (e) {
                        e.preventDefault();

                        // 기존의 열려있는 답글 폼이 있다면 제거
                        $('.reply-form').remove();

                        // 새로운 답글 폼 생성 및 삽입
                        var parentid = $(this).parent().parent().attr('id');
                        var targetpostid = ${vo.post_id};
                        console.log(parentid);
                        var replyForm = $(
                            '<div class="reply-form">' +
                            '<form id="reply-reply">' +
                            '<textarea class="form-control" rows="2" placeholder="답글을 입력하세요." id="content" name="content"></textarea>' +
                            `<input type="hidden" name="depth" value="1"/>` +
                            '<input type="hidden" name="target_parent" value="' + parentid + '"/>' +
                            '<input type="hidden" name="post_id" value="' + targetpostid + '"/>' +
                            '<div class="mar-top clearfix">' +
                            '<button class="btn btn-sm btn-primary pull-right reply-submit-btn"><i class=\"fa fa-pencil fa-fw\"></i> 작성</button>' +
                            '</div>' +
                            '</form>' +
                            '</div>'
                        );

                        $(this).parent().after(replyForm);

                        $("#reply-reply").submit(function () {
                            event.preventDefault();
                            var content = $(this).find('textarea[name="content"]').val().trim();
                            if (content === '') {
                                alert("댓글을 입력 후 시도해주세요");
                                event.preventDefault();
                            } else {
                                var params = $(this).serialize();
                                $.ajax({
                                    url: "${pageContext.servletContext.contextPath}/CommunityReply/write",
                                    data: params,
                                    type: 'post',
                                    success: function (result) {
                                        event.preventDefault();
                                        console.log(result);
                                        commentList();
                                        $('.reply-form').remove();
                                    },
                                    error: function (error) {
                                        console.log(error.responseText);
                                        event.preventDefault();
                                    }
                                });
                            }
                        });
                    });


                    $('.panel-body-second').on('click', '.comment-edit', function (e) {//댓글수정버튼
                        e.preventDefault();
                        var contentdiv = $(this).parent().parent().find('#contentdiv');
                        var contentText = contentdiv.html();
                        var commentid = $(this).attr("id");

                        var edithtmltag = $('<form id="edit-reply">' +
                            '<div class="panel"><div class="panel-body">' +
                            '<textarea class="form-control" name="content" id="editor-foredit" rows="2"' +
                            'placeholder="댓글을 입력하세요.">' + contentText + '</textarea>' +
                            '<div class="mar-top clearfix">' +
                            '<button class="btn btn-sm btn-primary pull-right" type="submit">' +
                            '<i class="fa fa-pencil fa-fw"></i> 작성 </button>' +
                            '</div>' +
                            '</div>' +
                            ' </div>' +
                            '</form>');
                        edithtmltag.insertAfter(contentdiv);
                        contentdiv.remove();

                        CKEDITOR.ClassicEditor.create(document.getElementById("editor-foredit"), option);

                        $("#edit-reply").submit(function () {
                            event.preventDefault();
                            if (!$("#editor-foredit").val()) {
                                alert("댓글을 입력 후 시도해주세요");
                            } else {
                                var editcontent = $("#editor-foredit").val();
                                $.ajax({
                                    url: "${pageContext.servletContext.contextPath}/CommunityReply/editOk",
                                    data: {
                                        editcontent:editcontent,
                                        commentid:commentid
                                    },
                                    type: 'post',
                                    success: function (result) {
                                        console.log(result);
                                        commentList();
                                        $('#edit-reply').remove();
                                    },
                                    error: function (error) {
                                        console.log(error.responseText);
                                    }
                                });

                            }
                        });
                    });
                    $('.panel-body-second').on('click', '.comment-delete', function (e) {//댓글삭제버튼
                        e.preventDefault();
                        var commentid = $(this).attr("id");
                        if(confirm("정말 댓글을 삭제하시겠습니까?")){
                            $.ajax({
                                url: "${pageContext.servletContext.contextPath}/CommunityReply/delete",
                                data: {
                                    commentid:commentid
                                },
                                type: 'post',
                                success: function (result) {
                                    console.log(result);
                                    commentList();
                                    e.preventDefault();
                                },
                                error: function (error) {
                                    console.log(error.responseText);
                                }
                            });

                        }
                        e.preventDefault();
                    });



                });

            </script>
        </div>

    </div>
    <div class="content_side_div" style="max-height: 300px">
        <div class="comment_button_side">
            <button onclick="scrollToElement('comment-anchor')">댓글</button>
        </div>

        <div class="like_comment_count">
            <div class="item">
                <img src="../img/view.png" alt="조회수">
                <c:if test="${vo.views>=1000}">
                    <p>조회수 : ${Math.round((vo.views/1000.0)*10)/10.0}K</p>
                </c:if>
                <c:if test="${vo.views<1000}">
                    <p>조회수 : ${vo.views}</p>
                </c:if>
            </div>
            <div class="item">
                <img src="${pageContext.servletContext.contextPath}/img/comment.png" alt="댓글">
                <p>댓글 : ${vo.commentsCount}</p>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.servletContext.contextPath}/js/community-post.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>