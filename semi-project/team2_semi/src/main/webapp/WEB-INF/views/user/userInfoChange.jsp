<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet"
      href="${pageContext.servletContext.contextPath}/css/community-nav.css">
<link rel="stylesheet"
      href="${pageContext.servletContext.contextPath}/css/userInfoChange.css">
<link
        href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css"
        rel="stylesheet">
<script>
    $(function () {
        $("#id-check").click(function () {
            var idformat = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
            var sessionid = '${LogId}';
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
                url: "${pageContext.servletContext.contextPath}/user/idCheck",
                type: 'post',
                data: {
                    inputid: inputid
                },
                success: function (result) {
                    if (result == 0 && sessionid != inputid) {
                        $("#userid").attr("disabled", true);
                        var tag = $('<input type="hidden" name="userid" value="' + inputid + '"/>');
                        that.after(tag);
                        that.remove();
                    } else if (result == 1 && sessionid == inputid) {
                        $("#userid").attr("disabled", true);
                        var tag = $('<input type="hidden" name="userid" value="' + inputid + '"/>');
                        that.after(tag);
                        that.remove();
                    } else {
                        $("#warning").text(inputid + "는 사용중인 아이디입니다.");
                    }
                },
                error: function (error) {

                }
            });
        });

        $("#email-check").click(function () {
            var emailFormat = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            var sessionemail;
            var inputemail = $("#useremail").val()
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
                url: "${pageContext.servletContext.contextPath}/getuseremail",
                type: 'post',
                success: function (result) {
                    sessionemail = result;
                    $.ajax({
                        url: "${pageContext.servletContext.contextPath}/user/idEmail",
                        type: 'post',
                        data: {
                            inputemail: inputemail
                        },
                        success: function (result) {
                            console.log(result + "result");
                            console.log(inputemail + "input")
                            if (result == 0 && sessionemail != inputemail) {
                                $("#useremail").attr("disabled", true);
                                var tag = $('<input type="hidden" name="email" value="' + inputemail + '"/>');
                                that.after(tag);
                                that.remove();
                            } else if (result == 1 && sessionemail == inputemail) {
                                $("#useremail").attr("disabled", true);
                                var tag = $('<input type="hidden" name="email" value="' + inputemail + '"/>');
                                that.after(tag);
                                that.remove();
                            } else {
                                $("#warning").text(inputemail + "는 사용중인 이메일입니다.");
                            }
                        },
                        error: function (error) {

                        }
                    });
                },
                error: function (error) {
                    console.log(error.responseText);
                }
            });

        });


    });
</script>


<h1>회원 정보 수정</h1>

<div id="warning"></div>

<div class="signup-area">
    <div class="signup-area2">
        <form method="post" action="${pageContext.servletContext.contextPath}/user/editprofile" class="editprofileform"
              id="userFrm">
            <div class="id-input">
                <label for="userid">아이디</label>
                <input type="text" name="userid" id="userid" placeholder="8~16글자의 대소문자, 숫자만 지원합니다." class="inputtext"
                       value="${uservo.userid}">
                <input type="button" value="확인" class="id-check" id="id-check" style="width: 50px; height: 30px;">

            </div>

            <div class="pwd-input">
                <label for="userpwd">기존 비밀번호</label>
                <input type="password" name="userpwd" id="userpwd" class="inputtext"
                       placeholder="">
            </div>

            <div class="pwd2-input">
                <label for="userpwd2">새로운 비밀번호</label>
                <input type="password" name="userpwd2" id="userpwd2" class="inputtext"
                       placeholder="8~16글자 대문자, 소문자, 숫자, 특수문자 중 2가지 이상 사용">
            </div>

            <div class="name-input">
                <label for="username">닉네임 </label>
                <input type="text" name="username" id="username" class="inputtext" placeholder=""
                       value="${uservo.username}">
            </div>

            <div class="email-input">
                <label label for="useremail"> 이메일 </label>
                <input type="text" name="email" id="useremail" class="inputtext" placeholder="" value="${uservo.email}">
                <input type="button" value="확인" class="email-check" id="email-check" style="width: 50px; height: 30px;">
            </div>
            <div class="Question">
                <select name="pwd_q" id="pwd_q" class="pwd_q">
                    <option value="none">비밀번호 찾기 질문</option>
                    <option value="내가 태어난 도시 이름은?"
                            <c:if test="${uservo.pwd_q=='내가 태어난 도시 이름은?'}">
                                selected
                            </c:if>
                    >내가 태어난 도시 이름은?
                    </option>
                    <option value="어릴 적 다닌 초등학교 이름은?"
                            <c:if test="${uservo.pwd_q=='어릴 적 다닌 초등학교 이름은?'}">
                                selected
                            </c:if>
                    >어릴 적 다닌 초등학교 이름은?
                    </option>
                    <option value="어머니 이름은?"
                            <c:if test="${uservo.pwd_q=='어머니 이름은?'}">
                                selected
                            </c:if>
                    >어머니 이름은?
                    </option>
                    <option value="아버지 이름은?"
                            <c:if test="${uservo.pwd_q=='아버지 이름은?'}">
                                selected
                            </c:if>
                    >아버지 이름은?
                    </option>
                    <option value="본인의 좌우명?"
                            <c:if test="${uservo.pwd_q=='본인의 좌우명?'}">
                                selected
                            </c:if>
                    >본인의 좌우명?
                    </option>
                </select>
            </div>
            <div class="Answer">
                <input type="text" name="pwd_a" id="pwd_a" class="inputtext" placeholder="비밀번호 찾기 답"
                       value="${uservo.pwd_a}">
            </div>
            <div class="comment-input">
                <label label for="comment"> 한마디 </label>
                <input type="text" name="comment" id="comment" class="inputtext" placeholder=""
                       value="${uservo.comment}">
            </div>

            <input type="submit" value="수정 완료" class="signup-submit">

        </form>
    </div>
</div>


<script>
    document
        .querySelector(".signup-submit")
        .addEventListener("click", function (e) {
            e.preventDefault(); // form의 기본 submit 이벤트를 막습니다.

            var warning = document.getElementById("warning");
            var userid = document.getElementById("userid");
            var userpwd = document.getElementById("userpwd");
            var email = document.getElementById("useremail");
            var pwd_q = document.getElementById("pwd_q");
            var pwd_a = document.getElementById("pwd_a");
            var newpwd = document.getElementById("userpwd2");

            if (newpwd.value) {
                if (
                    !/^(?:(?=.*\d)(?=.*[a-z])(?=.*[A-Z])|(?=.*\d)(?=.*[^a-zA-Z0-9\s])(?=.[a-z])|(?=.*[^a-zA-Z0-9\s])(?=.[a-z])(?=.[A-Z])|(?=.*\d)(?=.[^a-zA-Z0-9\s])(?=.[A-Z])).{8,16}$/.test(
                        newpwd.value
                    )
                ) {
                    warning.innerText =
                        "새로운 비밀번호는 영어 대문자, 소문자, 특수문자 및 숫자 중 최소 세 가지를 조합하고 8~16글자로 생성해야 합니다.";
                    return;
                }
            } else {
                warning.innerText = "";
            }

            if (!$("#userid").prop("disabled")) {
                alert("아이디 중복검사를 진행해주세요");
                return;
            }
            if (!$("#useremail").prop("disabled")) {
                alert("이메일 중복검사를 진행해주세요");
                return;
            }


            // 아이디 정규식 체크
            if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/.test(userid.value)) {
                warning.innerText =
                    "아이디는 8~16자의 영어 대문자, 소문자, 숫자만 사용할 수 있습니다.";
                return;
            }

            // 비밀번호 정규식 체크
            if (
                !/^(?:(?=.*\d)(?=.*[a-z])(?=.*[A-Z])|(?=.*\d)(?=.*[^a-zA-Z0-9\s])(?=.[a-z])|(?=.*[^a-zA-Z0-9\s])(?=.[a-z])(?=.[A-Z])|(?=.*\d)(?=.[^a-zA-Z0-9\s])(?=.[A-Z])).{8,16}$/.test(
                    userpwd.value
                )
            ) {
                warning.innerText =
                    "비밀번호는 영어 대문자, 소문자, 특수문자 및 숫자 중 최소 세 가지를 조합하고 8~16글자로 생성해야 합니다.";
                return;
            }

            if (username.value.trim() === "") {
                warning.innerText = "닉네임을 입력해주세요.";
                return;
            }

            // 이메일 정규식 체크
            if (
                !/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email.value)
            ) {
                warning.innerText = "유효한 이메일 주소를 입력하세요.";
                return;
            }

            // select의 option의 value가 none이 아니여야함
            if (pwd_q.value === "none") {
                warning.innerText = "비밀번호 찾기 질문을 선택해주세요.";
                return;
            }

            // useranswer가 비어있으면 안됨.
            if (pwd_a.value.trim() === "") {
                warning.innerText = "비밀번호 찾기 답을 입력해주세요.";
                return;
            }

            // 모든 검증을 통과했으므로 form 제출
            e.target.form.submit();
        });

</script>
<script>
    document.getElementById("userid").addEventListener("blur", function () {
        var regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
        var warning = document.getElementById("warning");

        if (!regex.test(this.value)) {
            warning.innerText =
                "아이디는 8~16자의 영어 대문자, 소문자, 숫자만 사용할 수 있습니다.";
        } else {
            warning.innerText = "";
        }
    });

    document.getElementById("userpwd").addEventListener("blur", function () {
        var regex =
            /^(?:(?=.*\d)(?=.*[a-z])(?=.*[A-Z])|(?=.*\d)(?=.*[^a-zA-Z0-9\s])(?=.*[a-z])|(?=.*[^a-zA-Z0-9\s])(?=.*[a-z])(?=.*[A-Z])|(?=.*\d)(?=.*[^a-zA-Z0-9\s])(?=.*[A-Z])).{8,16}$/;
        var warning = document.getElementById("warning");

        if (!regex.test(this.value)) {
            warning.innerText =
                "비밀번호는 영어 대문자, 소문자, 특수문자 및 숫자 중 최소 세 가지를 조합하여 생성해야 합니다.";
        } else {
            warning.innerText = "";
        }
    });

    document.getElementById("userpwd2").addEventListener("blur", function () {
        var regex =
            /^(?:(?=.*\d)(?=.*[a-z])(?=.*[A-Z])|(?=.*\d)(?=.*[^a-zA-Z0-9\s])(?=.*[a-z])|(?=.*[^a-zA-Z0-9\s])(?=.*[a-z])(?=.*[A-Z])|(?=.*\d)(?=.*[^a-zA-Z0-9\s])(?=.*[A-Z])).{8,16}$/;
        var warning = document.getElementById("warning");

        if (this.value) {
            console.log("들어옴");
            if (!regex.test(this.value)) {
                warning.innerText =
                    "비밀번호는 영어 대문자, 소문자, 특수문자 및 숫자 중 최소 세 가지를 조합하여 생성해야 합니다.";
            } else {
                warning.innerText = "";
            }
        } else {
            warning.innerText = "";
        }

    });

    document.getElementById("useremail").addEventListener("blur", function () {
        var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var warning = document.getElementById("warning");

        if (!regex.test(this.value)) {
            warning.innerText = "유효한 이메일 주소를 입력하세요.";
        } else {
            warning.innerText = "";
        }
    });

</script>