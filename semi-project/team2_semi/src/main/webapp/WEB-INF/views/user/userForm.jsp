<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-nav.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/userForm.css">
<link
        href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css"
        rel="stylesheet">

<script>
    $(function () {
        $("#id-check").click(function () {
            var idformat = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
            var inputid = $("#userid").val()
            var that = $(this);
            console.log(inputid);
            if (inputid == "") {
                alert("아이디를 입력 후 중복검사하세요.");
                return;
            }
            if(!idformat.test(String(inputid).toLowerCase())){
                alert("아이디 형식이 올바르지 않습니다.");
                return
            }
            $.ajax({
               url:"${pageContext.servletContext.contextPath}/user/idCheck",
               type:'post',
               data: {
                   inputid:inputid
               },
                success:function(result){
                   if(result==0){
                       $("#userid").attr("disabled",true);
                       var tag = $('<input type="hidden" name="userid" value="'+inputid+'"/>');
                       that.after(tag);
                       that.remove();
                   }else{
                       $("#warning").text(inputid+"는 사용중인 아이디입니다.");
                   }
                },
                error:function(error){

                }
            });
        });

        $("#email-check").click(function () {
            var inputemail = $("#email").val();
            var emailFormat = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            var that = $(this);
            console.log(inputemail);
            if (inputemail == "") {
                alert("이메일을 입력 후 중복검사하세요.");
                return;
            }
            if(!emailFormat.test(String(inputemail).toLowerCase())){
                alert("이메일 형식이 올바르지 않습니다");
                return;
            }
            $.ajax({
                url:"${pageContext.servletContext.contextPath}/user/idEmail",
                type:'post',
                data: {
                    inputemail:inputemail
                },
                success:function(result){
                    console.log(result);
                    if(result==0){
                        $("#email").attr("disabled",true);
                        var tag = $('<input type="hidden" name="email" value="'+inputemail+'"/>');
                        that.after(tag);
                        that.remove();
                    }else{
                        $("#warning").text(inputemail+"는 사용중인 이메일입니다.");
                    }
                },
                error:function(error){

                }
            });
        });


    });

</script>
<h1>회원가입</h1>

<div id="warning"></div>

<div class="signup-area">
    <div class="signup-area2">
        <form method="post" action="${pageContext.servletContext.contextPath}/userFormOK" id="userFrm">
            <div class="id-input">
                <label for="userid">아이디</label>
                <input type="text" name="userid" id="userid" placeholder="8~16글자의 대소문자, 숫자만 지원합니다." class="inputtext">
                <input type="button" value="확인" class="id-check" id="id-check" style=" width: 50px; height: 30px;">
            </div>

            <div class="pwd-input">
                <label for="userpwd">비밀번호</label>
                <input type="password" name="userpwd" id="userpwd" class="inputtext"
                       placeholder="8~16글자의 대소문자, 숫자, 특수문자 중 2가지 이상 사용">
            </div>

            <div class="name-input">
                <label for="username">닉네임 </label>
                <input type="text" name="username" id="username" class="inputtext" placeholder="">
            </div>

            <div class="email-input">
                <label label for="email"> 이메일 </label>
                <input type="text" name="email" id="email" class="inputtext" placeholder="">
                <input type="button" value="확인" class="email-check" id="email-check" style="width: 50px; height: 30px;"/>
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
            <div class="agree">
                <p>개인정보 수집 및 이용 동의</p>
                <input type="checkbox" name="agree" id="agree"/>
            </div>
            <input type="submit" value="회원가입" class="signup-submit"/>

        </form>
    </div>
</div>
<script src="${pageContext.servletContext.contextPath}/js/signup-checkinput.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/signup-submitcheck.js"></script>