<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/comment.css" rel="stylesheet">
        <div class="body-content">
            <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
            <div class="comments_container bootdey">
                <div class="col-md-12 bootstrap snippets">
                    <div class="panel">
                        <div class="panel-body">
                            <textarea class="form-control" rows="2" placeholder="댓글을 입력하세요."></textarea>
                            <div class="mar-top clearfix">
                                <button class="btn btn-sm btn-primary pull-right" type="submit"><i
                                        class="fa fa-pencil fa-fw"></i> 작성</button>
                                <a class="btn btn-trans btn-icon fa fa-video-camera add-tooltip" href="#"></a>
                                <a class="btn btn-trans btn-icon fa fa-camera add-tooltip" href="#"></a>
                                <a class="btn btn-trans btn-icon fa fa-file add-tooltip" href="#"></a>
                            </div>
                        </div>
                    </div>
                    <div class="panel">
                        <div class="panel-body">

                            <!-- 답글 작성 폼 -->
                            <div class="reply-form" style="display: none;">
                                <textarea class="form-control" rows="2" placeholder="답글을 입력하세요."></textarea>
                                <div class="mar-top clearfix">
                                    <button class="btn btn-sm btn-primary pull-right reply-submit-btn" type="submit"><i
                                            class="fa fa-pencil fa-fw"></i> 작성</button>
                                </div>
                            </div>

                            <div class="comments-block">
                                <a class="media-left" href="#"><img class="img-circle img-sm" alt="Profile Picture"
                                        src="${pageContext.servletContext.contextPath}/web/img/profile1.png"></a>
                                <div class="media-body">
                                    <div class="mar-btm">
                                        <a href="#" class="btn-link text-semibold media-heading box-inline">로니콜먼2</a>
                                        <p class="text-muted text-sm"><i class="fa fa-mobile fa-lg"></i> 11분 전</p>
                                    </div>
                                    <p>와 몸 진짜 좋으세요 어떤 운동하세요?</p>
                                    <div class="pad-ver">
                                        <div class="btn-group">
                                            <a class="btn btn-sm btn-default btn-hover-success" href="#"><i
                                                    class="fa fa-thumbs-up"></i></a>
                                            <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i
                                                    class="fa fa-thumbs-down"></i></a>
                                        </div>
                                        <a class="btn btn-sm btn-default btn-hover-primary" href="#">답글 작성</a>
                                    </div>
                                    <hr>

                                    <div>
                                        <div class="comments-block reply">
                                            <a class="media-left" href="#"><img class="img-circle img-sm"
                                                    alt="Profile Picture"
                                                    src="${pageContext.servletContext.contextPath}/web/img/profile2.png"></a>
                                            <div class="media-body">
                                                <div class="mar-btm">
                                                    <a href="#"
                                                        class="btn-link text-semibold media-heading box-inline">월미도질주남</a>
                                                    <p class="text-muted text-sm"><i class="fa fa-mobile fa-lg"></i> 7분
                                                        전</p>
                                                </div>
                                                <p>와 등 미쳤다${pageContext.servletContext.contextPath}</p>
                                                <div class="pad-ver">
                                                    <div class="btn-group">
                                                        <a class="btn btn-sm btn-default btn-hover-success active"
                                                            href="#"><i class="fa fa-thumbs-up"></i> 좋아요 완료</a>
                                                        <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i
                                                                class="fa fa-thumbs-down"></i></a>
                                                    </div>
                                                    <a class="btn btn-sm btn-default btn-hover-primary" href="#">답글
                                                        작성</a>
                                                </div>
                                                <hr>
                                            </div>
                                        </div>
                                        <div class="comments-block reply">
                                            <a class="media-left" href="#"><img class="img-circle img-sm"
                                                    alt="Profile Picture"
                                                    src="${pageContext.servletContext.contextPath}/web/img/profile3.png">
                                            </a>
                                            <div class="media-body">
                                                <div class="mar-btm">
                                                    <a href="#"
                                                        class="btn-link text-semibold media-heading box-inline">퉁퉁이</a>
                                                    <p class="text-muted text-sm"><i class="fa fa-globe fa-lg"></i> 2분 전
                                                    </p>
                                                </div>
                                                <p>비가 와도 멈추지않아.</p>
                                                <div class="pad-ver">
                                                    <div class="btn-group">
                                                        <a class="btn btn-sm btn-default btn-hover-success" href="#"><i
                                                                class="fa fa-thumbs-up"></i></a>
                                                        <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i
                                                                class="fa fa-thumbs-down"></i></a>
                                                    </div>
                                                    <a class="btn btn-sm btn-default btn-hover-primary" href="#">답글
                                                        작성</a>
                                                </div>
                                                <hr>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>




                            <div class="comments-block">
                                <a class="media-left" href="#"><img class="img-circle img-sm" alt="Profile Picture"
                                        src="${pageContext.servletContext.contextPath}/web/img/profile4.png"></a>
                                <div class="media-body">
                                    <div class="mar-btm">
                                        <a href="#" class="btn-link text-semibold media-heading box-inline">별 거 없네</a>
                                        <p class="text-muted text-sm"><i class="fa fa-mobile fa-lg"></i> 11분 전</p>
                                    </div>
                                    <p>솔직히 제 몸이 더 좋죠?</p>
                                    <img class="img-responsive thumbnail"
                                        src="${pageContext.servletContext.contextPath}/web/img/body1.jpg" alt="Image">
                                    <div class="pad-ver">
                                        <span class="tag tag-sm"><i class="fa fa-heart text-danger"></i> 250 좋아요</span>
                                        <div class="btn-group">
                                            <a class="btn btn-sm btn-default btn-hover-success" href="#"><i
                                                    class="fa fa-thumbs-up"></i></a>
                                            <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i
                                                    class="fa fa-thumbs-down"></i></a>
                                        </div>
                                        <a class="btn btn-sm btn-default btn-hover-primary" href="#">답글 작성</a>
                                    </div>
                                    <hr>

                                    <div>
                                        <div class="comments-block reply">
                                            <a class="media-left" href="#"><img class="img-circle img-sm"
                                                    alt="Profile Picture"
                                                    src="${pageContext.servletContext.contextPath}/web/img/profile5.png"></a>
                                            <div class="media-body">
                                                <div class="mar-btm">
                                                    <a href="#"
                                                        class="btn-link text-semibold media-heading box-inline">성실남</a>
                                                    <p class="text-muted text-sm"><i class="fa fa-globe fa-lg"></i> 2분 전
                                                    </p>
                                                </div>
                                                <p>왜 그렇게 삐뚤어지셨어요${pageContext.servletContext.contextPath} 근데 몸 진짜 좋으시네요
                                                    ㄷㄷ</p>
                                                <div>
                                                    <div class="btn-group">
                                                        <a class="btn btn-sm btn-default btn-hover-success" href="#"><i
                                                                class="fa fa-thumbs-up"></i></a>
                                                        <a class="btn btn-sm btn-default btn-hover-danger" href="#"><i
                                                                class="fa fa-thumbs-down"></i></a>
                                                    </div>
                                                    <a class="btn btn-sm btn-default btn-hover-primary" href="#">답글
                                                        작성</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
            <script type="text/javascript">
                $(document).ready(function () {
                    fetchCommentList();
            
                    // 댓글 작성 버튼 클릭 이벤트 처리
                    $('.btn-primary.pull-right').click(function (e) {
                        e.preventDefault();
                        var commentText = $(this).siblings('textarea').val();
                        $.ajax({
                            type: 'POST',
                            url: '/CommunityReply/write',
                            data: {
                                comment: commentText
                            },
                            success: function (response) {
                                if (response.success) {
                                    alert('댓글이 작성되었습니다.');
                                    fetchCommentList();
                                } else {
                                    alert('댓글 작성 실패');
                                }
                            },
                            error: function () {
                                alert('서버 에러');
                            }
                        });
                    });
            
                    // 답글 '작성' 버튼 클릭 이벤트 처리
                    $(document).on('click', '.reply-submit-btn', function (e) {
                        e.preventDefault();
                        var replyText = $(this).siblings('textarea').val();
                        $.ajax({
                            type: 'POST',
                            url: '/CommunityReply/writeReply',
                            data: {
                                reply: replyText
                            },
                            success: function (response) {
                                if (response.success) {
                                    alert('답글이 작성되었습니다.');
                                    fetchCommentList();
                                } else {
                                    alert('답글 작성 실패');
                                }
                            },
                            error: function () {
                                alert('서버 에러');
                            }
                        });
                    });
                });
            
                function fetchCommentList() {
                    $.ajax({
                        type: 'GET',
                        url: '/CommunityReply/list',
                        dataType: 'json',
                        success: function (response) {
                            // 댓글 목록을 화면에 렌더링하는 코드 추가 (예: DOM 조작)
                            // 'response' 변수에 서버에서 반환된 댓글 데이터가 들어있습니다.
                            // 이 데이터를 사용하여 댓글 목록을 동적으로 생성합니다.
                        },
                        error: function () {
                            alert('댓글 목록 로드 실패');
                        }
                    });
                }
            </script>