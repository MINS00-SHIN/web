document
    .querySelector(".signup-submit")
    .addEventListener("click", function (e) {
        e.preventDefault(); // form의 기본 submit 이벤트를 막습니다.

        var warning = document.getElementById("warning");

        var userid = document.getElementById("userid");
        var userpwd = document.getElementById("userpwd");
        var email = document.getElementById("email");
        var pwd_q = document.getElementById("pwd_q");
        var pwd_a = document.getElementById("pwd_a");
        var agree = document.getElementById("agree");

        if (!$("#userid").prop("disabled")) {
            alert("아이디 중복검사를 진행해주세요");
            return;
        }
        if(!$("#email").prop("disabled")){
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

        // checkbox가 체크되어야 함
        if (!agree.checked) {
            warning.innerText = "약관에 동의해주세요.";
            return;
        }

        // 모든 검증을 통과했으므로 form 제출
        e.target.form.submit();
    });
