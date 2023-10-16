<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/minihome-default.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/memo_posting.css">
<script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>

<style>
    .minihome-area {
        background-image: url("${pageContext.servletContext.contextPath}/img/minihome-background.png");
        padding: 25px 22px;
        width: 1000px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        margin-top: 60px;
    }

    .erase-button > a {
        cursor: pointer;
    }
</style>
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
        height: 300px;
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

    /**************** ckEditor5 커스터마이징 끝 ****************/
</style>
<script>
    $(document).on('click',"#today-attend", function(){
        window.location.href = '${pageContext.servletContext.contextPath}/minihome/memo/write';
    });
    $(document).ready(function () {
        $(".year-month-day").text(${year} +"년 " + ${month} +"월 " + ${day} +"일 출석");

        var email = "${uVO.email}" ; //프로필 사진 주인의 이메일을 받고
        var hash = CryptoJS.MD5(email.trim().toLowerCase());
        //resourse->header.jspf에 포함됨, email을 MD5해시값으로 변경
        var gravatarUrl = "https://www.gravatar.com/avatar/" + hash + "?s=200&d=retro";
        $("#home-image").attr("src", gravatarUrl);//id가 home-image인 img태그의 src속성에 url입력
    });
    $(document).on('click', '#un-follow-button', function () {
        var ownerid = '${uVO.userid}';//값 잘 넘어옴
        if (confirm("정말" + ownerid + "님 팔로우를 해제하시겠습니까?")) {
            if(${LogStatus == "" || LogStatus==null || LogStatus!='Y'}){
                alert("로그인 후에 진행해주세요. 로그인 화면으로 이동합니다.");
                window.location.href = "${pageContext.servletContext.contextPath}/";
            }
            $.ajax({
                url: "${pageContext.servletContext.contextPath}/minihome/unfollow",
                data: {
                    ownerid: ownerid
                },
                type:'POST',
                success:function (result){
                    if(result==1){
                        alert(ownerid+"님 언팔로우 성공");
                        location.reload();
                    }else{
                        alert("알 수 없는 오류가 발생했습니다.");
                    }
                },
                error:function (error){
                    console.log(error.responseText);
                }
            });
        }

    });

    $(document).on('click',"#edit-button", function(){
        window.location.href = '${pageContext.servletContext.contextPath}/myPage';
    });

    $(document).on('click', '#follow-button', function () {
        var ownerid = '${uVO.userid}';//값 잘 넘어옴
        var test = $("#follow-button");
        if(test.isEmpty){
            console.log("test");
        }else{
            console.log("hi");
        }
        if (confirm("정말" + ownerid + "님을 팔로우하시겠습니까?")) {
            if(${LogStatus == "" || LogStatus==null || LogStatus!='Y'}){
                alert("로그인 후에 진행해주세요. 로그인 화면으로 이동합니다.");
                window.location.href = "${pageContext.servletContext.contextPath}/";
            }
            $.ajax({
                url: "${pageContext.servletContext.contextPath}/minihome/follow",
                data: {
                    ownerid: ownerid
                },
                type:'POST',
                success:function (result){
                    if(result==1){
                        alert("팔로우 성공");
                        location.reload();
                    }else{
                        alert("알 수 없는 오류가 발생했습니다.");
                    }
                },
                error:function (error){
                    console.log(error.responseText);
                }
            });
        }

    });
</script>
<div class="minihome-area">
    <div class="home-left">
        <div class="profile-area">
            <div class="profile-container">
                <div class="profile-pic">
                    <img id="home-image" style="height: 200px; width: 200px">
                </div>
                <div class="name-id-section">
                    <div id="username-div" class="username-section">${uVO.username}</div>
                    <p class="userid-section">@${uVO.userid}</p>
                </div>
                <div class="self-comment-section">
                    <div id="self-comment">
                        <div id="self-comment-editable" contentEditable='false'>${uVO.comment}</div>
                    </div>

                    <div class="follow-count-section">
                        <div class="follower">팔로워 :&nbsp<p class="follower-count">${follower_count}</p>
                        </div>
                        <div class="follow">팔로우 :&nbsp<p class="follow-count">${follow}</p>
                        </div>
                    </div>
                </div>
                <div class="edit-profile-section">
                    <c:if test="${LogId==uVO.userid}">
                        <input type="button" value="회원 정보 수정" class="edit-profile" id='edit-button'>
                    </c:if>
                    <c:if test="${LogId!=uVO.userid}">
                        <c:if test="${follower.contains(LogId)}">
                            <input type="button" value="팔로우 해제" class="un-follow-button" id='un-follow-button'
                                   style="color: white; background-color: var(--blue-basic-color); width: 152px; height: 40px; ">
                        </c:if>
                        <c:if test="${!follower.contains(LogId)}">
                            <input type="button" value="팔로우" class="follow-button" id='follow-button'
                                   style="color: white; background-color: var(--blue-basic-color); width: 152px; height: 40px; ">
                        </c:if>
                    </c:if>

                </div>
            </div>
        </div>
        <div class="count-area">
            <div class="count-area-container">
                <div class="today-attend-section" style="height: 40px">
                    <c:if test="${LogId==uVO.userid}">

                        <input type="button" value="출석체크" class="today-attend" id="today-attend"
                        <c:if test="${checkDate==0}">
                                disabled
                        </c:if>
                        >
                    </c:if>

                </div>
                <div class="memo-today-section">
                    <div class="memo">Memo :&nbsp<p class="memo-count">${memo_count}</div>
                    <div class="today">Today :&nbsp<p class="today-count">${today}</div>
                </div>
                <div class="check-mine-post">
                </div>
                <div class="reg-date">가입일자 :&nbsp<p>${uVO.date}</p>
                </div>
            </div>
        </div>

    </div>

    <!-- #endregion -->
    <div class="home-right">


        <form method="post" action="${pageContext.servletContext.contextPath}/minihome/memo/writeOk">
            <div class="maincontainer">
                <!-- 이 아래부터 수정 허용 -->
                <div class="memo-posting-left"><!-- 날짜, 부위선택, 본문, 이모지선택 -->
                    <p class="year-month-day"></p>
                    <div class="checkbox-section" style="align-content: space-between; display: flex">
                        <p><input type="checkbox" id="myCheck" name="myCheck" disabled
                        <c:if test="${mVO.add_auth==1}">
                            checked
                        </c:if>
                        />인증게시판 연동</p>
                    </div>
                    <div class="body-select" style="margin-top: 30px; margin-bottom: 30px">
                        <b>주요부위</b> &nbsp; &nbsp;
                        <c:if test="${mVO.cat=='upper'}">
                            상체 : <input type="radio" name="first-part" value="upper" checked disabled/>
                            하체 : <input type="radio" name="first-part" value="lower" disabled/>
                        </c:if>
                        <c:if test="${mVO.cat=='lower'}">
                            상체 : <input type="radio" name="first-part" value="upper" disabled/>
                            하체 : <input type="radio" name="first-part" value="lower" checked disabled/>
                        </c:if>
                        <hr/>
                        가슴 : <input type="checkbox" name="body-part" value="chest" disabled
                    <c:if test="${bodypart.contains('chest')}">
                                    checked
                    </c:if>
                    >
                        어깨 : <input type="checkbox" name="body-part" value="shoulder" disabled
                    <c:if test="${bodypart.contains('shoulder')}">
                                    checked
                    </c:if>>
                        등 : <input type="checkbox" name="body-part" value="back" disabled
                    <c:if test="${bodypart.contains('back')}">
                                   checked
                    </c:if>>
                        팔 : <input type="checkbox" name="body-part" value="arm" disabled
                    <c:if test="${bodypart.contains('arm')}">
                                   checked
                    </c:if>>
                        복부 : <input type="checkbox" name="body-part" value="stomach" disabled
                    <c:if test="${bodypart.contains('stomach')}">
                                    checked
                    </c:if>>

                        허리 : <input type="checkbox" name="body-part" value="waist" disabled
                    <c:if test="${bodypart.contains('waist')}">
                                    checked
                    </c:if>>
                        <br/>
                        허벅지 : <input type="checkbox" name="body-part" value="thigh" disabled
                    <c:if test="${bodypart.contains('thigh')}">
                                     checked
                    </c:if>>
                        엉덩이 : <input type="checkbox" name="body-part" value="hip" disabled
                    <c:if test="${bodypart.contains('hip')}">
                                     checked
                    </c:if>>
                        종아리 : <input type="checkbox" name="body-part" value="calf" disabled
                    <c:if test="${bodypart.contains('calf')}">
                                     checked
                    </c:if>>
                    </div>


                    <!-- 게시글 작성 영역 -->
                    <div id="editor" class="post-text-area" style="height: 300px; overflow-y: auto;">${mVO.content}</div>

                    <div id="bottom" style="display: flex">
                        <!-- 이모티콘 선택 영역-->
                        <div id="emoji-area" style="width: 400px">
                            <div id='emoji-selection-show'>
                                <div>😊</div>
                                <div>😂</div>
                                <div>😍</div>
                                <div>🤔</div>
                                <div>😥</div>
                            </div>
                            <div id="emoji-selection">
                                <input type='radio' name='emoji' value='1' disabled
                                <c:if test="${mVO.emoji==1}">
                                        checked
                                </c:if>
                                >
                                <input type='radio' name='emoji' value='2' disabled
                                <c:if test="${mVO.emoji==2}">
                                       checked
                                </c:if>
                                >
                                <input type='radio' name='emoji' value='3' disabled
                                <c:if test="${mVO.emoji==3}">
                                       checked
                                </c:if>
                                >
                                <input type='radio' name='emoji' value='4' disabled
                                <c:if test="${mVO.emoji==4}">
                                       checked
                                </c:if>
                                >
                                <input type='radio' name='emoji' value='5' disabled
                                <c:if test="${mVO.emoji==5}">
                                       checked
                                </c:if>
                                >
                            </div>
                        </div>
                        <div id="submit-button-area" style="margin-left: 50px">
                            <input type="button" value="홈으로 이동" class="submit-button" onclick="location.href='${pageContext.servletContext.contextPath}/minihome?id=${mVO.userid}'">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


<script src="${pageContext.servletContext.contextPath}/js/minihome-default.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>
