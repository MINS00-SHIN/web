<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/community-nav.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/userFind.css">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css"
	rel="stylesheet">


<!-- 아이디 찾기 -->
<script>
    function findId() { //함수 선언, 서버에 사용자가 입력한 email로 아이디 조회 요청을 보냄
        var userEmailV = document.getElementById("useremail").value; //html문서에서 id가 useremail인 요소의 값을 가져와 userEmailV 변수에 저장함.

        // 이메일 유효성 검사를 위해 만들어둔 isValidEmail 함수를 호출하여 값을 넣어줌. 유효하지않으면 경고창을 띄우고 함수를 종료함.
        if (!isValidEmail(userEmailV)) {
            alert("유효한 이메일 주소를 입력해주세요.");
            return;
        }

        // AJAX를 사용하여 서버로 이메일 전송
        var xhr = new XMLHttpRequest(); // XMLHttpRequest객체를 생성하여 xhr 변수에 저장 -> 이 객체는 서버와 비동기적으로 데이터를 교환하게 해줌
        xhr.open("POST",
            "${pageContext.servletContext.contextPath}/user/findId", true);// 객체의 open메소드를 통해 POST 방식의 URL로 비동기 요청을 설정함
        xhr.setRequestHeader("Content-Type",
            "application/x-www-form-urlencoded"); // 전송될 데이터가 URL 인코딩된 형태임을 서버에 알려줌

        xhr.onreadystatechange = function () { //onreadystatechange 속성은 요청 상태 변화 시마다 호출됨, 4(완료) && 200(성공)일 때 서버로부터 받은 응답을 처리함.
            if (xhr.readyState === 4 && xhr.status === 200) {
                var result = xhr.responseText;
                if (result !== "") {
                    // 아이디를 찾았을 경우 (응답 텍스트 o)
                    var maskedResult = maskId(result);
                    document.querySelector('.show-id').innerText = "아이디는 "
                        + maskedResult + " 입니다.";
                } else { //응답 텍스트 x
                    alert("해당 이메일에 대응하는 아이디를 찾을 수 없습니다.");
                }
            }
        };

        // 서버로 이메일 전송
        var params = "email=" + userEmailV; // "email=" 매개변수와 userEmailV(사용자 입력값)을 연결한 문자열을 params 변수에 저장
		console.log(params);
        xhr.send(params); //XMLHttpRequest 객체의 send 메소드 인자로 넘겨 요청을 보냄냄
    }

    function isValidEmail(email) {
        // 간단한 이메일 유효성 검사를 수행
        var emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.(com|co\.kr)$/i;
        return emailRegex.test(email);
    }

    function maskId(id) {
        // ID의 앞 3글자와 뒤 3글자만 남기고 나머지는 *로 바꿈.
        return id.substr(0, 3) + "*".repeat(id.length - 6) + id.substr(-3);
    }
</script>


<!-- 비밀번호 -->
<script>
    $(function () {
        $(document).on('click', '.find-pw-button', function () {
            console.log("도달함");
            var useridV = document.getElementById("userid").value;
            var useremailV = document.getElementById("useremail2").value;
            var pwd_qV = document.getElementById("pwd_q").value;
            var pwd_aV = document.getElementById("pwd_a").value;

            if (!isValidEmail(useremailV)) {
                alert("유효한 이메일 주소를 입력해주세요.");
                return;
            }

            if (pwd_qV === "none") {
                alert("비밀번호 찾기 질문을 선택해주세요.");
                return;
            }

            $.ajax({
                url: "${pageContext.servletContext.contextPath}/user/checkUserInfo",
                data: {
                    userid: useridV,
                    email: useremailV,
                    pwd_q: pwd_qV,
                    pwd_a: pwd_aV
                },
                type: "post",
                success: function (result) { //result = userid
                    if (result == '') {
                        alert("일치하는 정보가 없습니다.");
                    } else {
                        var tag = $('<div class="change-password">'
                            + '<p>비밀번호 변경하기</p>'
                            + '<form method="post" id="editpwd">'
                            + '<input type="password" name="change-password-input"  id="change-password-input" class="change-password-input" placeholder="새로운 비밀번호"/>'
                            + '<input type = "hidden" name = "userid" value = "' + result + '"/>'
                            + '<input type="button" value="비밀번호 변경"' +
                            'class="change-password-button">'
                            + '<form/>' + '</div>');
                        $(".find-pw-button").after(tag);
                        $(".find-pw-button").attr(
                            "disabled", true);


                        //비밀번호 변경 폼 이벤트


                        $(document).on('click', '.change-password-button', function () {
                            var changepwd = $('#change-password-input').val();

                            // 영어 대문자, 소문자, 숫자, 특수 문자 각각에 대한 정규식
                            var upperCaseLetters = /[A-Z]/g;
                            var lowerCaseLetters = /[a-z]/g;
                            var numbers = /[0-9]/g;
                            var specialCharacters = /[^a-zA-Z0-9]/g;

                            // 길이 확인
                            if (changepwd.length < 8 || changepwd.length > 16) {
                            	 alert('비밀번호는 8~16자 사이여야 합니다.');
                                console.log("비밀번호는 8~16자 사이여야 합니다.");
                            } else {
                                // 각 조건별 충족 여부 확인
                                var conditionsMet = [upperCaseLetters.test(changepwd), lowerCaseLetters.test(changepwd), numbers.test(changepwd), specialCharacters.test(changepwd)].filter(Boolean).length;

                                if (conditionsMet < 3) {
                                	 alert('비밀번호는 영어 대문자, 소문자, 숫자, 특수 문자 중 최소 세 가지를 포함해야 합니다.');
                                    console.log("비밀번호는 영어 대문자, 소문자, 숫자, 특수 문자 중 최소 세 가지를 포함해야 합니다.");
                                } else {
                                    $.ajax({
                                        url: "${pageContext.servletContext.contextPath}/user/changepwd",
                                        data: {
                                            changepwd: changepwd,
                                            useridV: useridV
                                        },
                                        type: 'post',
                                        success: function (result) {
                                            console.log(result);
                                            alert('비밀번호가 변경되었습니다. 로그인 화면으로 이동합니다.');
                                            window.location.href = "${pageContext.servletContext.contextPath}/user/login";
                                        },
                                        error: function () {

                                        }
                                    });
                                }
                            }
                        });
                    }
                }, error: function (error) {
					alert("오류발생");
                }
            });

        });

    });


    function isValidEmail(email) {
        // 간단한 이메일 유효성 검사를 수행
        var emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.(com|co\.kr)$/i;
        return emailRegex.test(email);
    }
</script>


<div class="find-container">
	<div class="find-area-left">
		<h1>아이디 찾기</h1>
		<div class="email-input">
			<input type="text" name="useremail" id="useremail" class="inputtext"
				placeholder="가입당시 이메일 입력">
		</div>
		<button type="button" class="find-id-button" onclick="findId()">아이디
			찾기</button>
		<!-- 아이디 표시 부분 -->
		<div id='show-id' class='show-id'></div>
	</div>

	<div class="find-area-right">
		<h1>비밀번호 찾기</h1>
		<div class="id-input">
			<input type="text" name="userid" id="userid" placeholder="아이디"
				class="inputtext">
		</div>
		<div class="email-input">
			<input type="text" name="useremail2" id="useremail2"
				class="inputtext" placeholder="이메일">
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

			<input type="text" name="pwd_a" id="pwd_a" class="inputtext"
				placeholder="비밀번호 찾기 답">
		</div>
		<button class="find-pw-button">비밀번호 변경 폼 요청</button>

		<!--평소에는 안 보이다가 비밀번호 찾기 요청 시 나올 부분 -->

	</div>
</div>