<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/minihome-default.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/calendar-module.css">
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
<script>
    $(document).on('click',"#edit-button", function(){
        window.location.href = '${pageContext.servletContext.contextPath}/myPage';
    });
    $(document).on('click', "#today-attend", function () {
        window.location.href = '${pageContext.servletContext.contextPath}/minihome/memo/write';
    });
    $(function () {

        var email = "${uVO.email}" ; //프로필 사진 주인의 이메일을 받고
        var hash = CryptoJS.MD5(email.trim().toLowerCase());
        //resourse->header.jspf에 포함됨, email을 MD5해시값으로 변경
        var gravatarUrl = "https://www.gravatar.com/avatar/" + hash + "?s=200&d=retro";
        $("#home-image").attr("src", gravatarUrl);//id가 home-image인 img태그의 src속성에 url입력

        $(document).on('submit', '#commentForm', function () {//방명록 등록 눌렀을 때 호출 함수
            event.preventDefault();
            if ($("#comment-input").val() == "") {
                alert("방명록 내용 작성 후 시도해주세요!");
                return false;
            }
            if (${LogStatus==null || LogStatus=="N"}) {
                alert("로그인 후 다시 시도해주세요!");
                window.location.href = "${pageContext.servletContext.contextPath}/";
                return false;
            }
            var content = $("#comment-input").val();
            var target_home = '${uVO.userid}';
            $.ajax({
                url: "${pageContext.servletContext.contextPath}/minihome/guestbookWrite",
                data: {
                    content: content,
                    target_home: target_home
                },
                type: 'POST',
                success: function (result) {
                    if (result > 0) {
                        $("#comment-input").val("");//글작성 폼 초기화
                        loadGuestbookList();
                    }
                },
                error: function (error) {
                    console.log(error.responseText);
                }
            });
        });

        function loadGuestbookList() {
            var target_home = '${uVO.userid}';
            $.ajax({
                url: "${pageContext.servletContext.contextPath}/minihome/reload",
                data: {
                    target_home: target_home
                },
                type: 'POST',
                dataType: 'json',
                success: function (guestbooklist) {
                    $('.commnet-list').empty(); // 기존 리스트 삭제
                    $(guestbooklist).each(function (index, guestVO) {
                        var writeDateStr = guestVO.write_date;
                        var year = parseInt(writeDateStr.split('년 ')[0]);
                        var month = parseInt(writeDateStr.split('년 ')[1].split('월 ')[0]) - 1;
                        var day = parseInt(writeDateStr.split('월 ')[1].split('일')[0]);
                        var writeDate = new Date(year, month, day);

                        var now = new Date();
                        now.setHours(now.getHours() + 9);

                        if (now.getFullYear() === writeDate.getFullYear()) {
                            writeDateString = (writeDate.getMonth() + 1) + '월' + writeDate.getDate() + '일';
                        } else {
                            writeDateString = writeDate.getFullYear() + '년' + (writeDate.getMonth() + 1) + '월' +
                                writeDate.getDate() + '일';
                        }


                        // li 태그 생성 및 내용 추가
                        var listItemHtml =
                            '<li class="dummydata">' +
                            '<div class="first-line-comment">' +
                            '<div class="comment">' + guestVO.content + '</div>';

                        if ('${LogStatus}' === 'Y' && ('${LogId}' === '${uVO.userid}' || '${LogId}' === guestVO.userid)) {
                            listItemHtml += "<div class='erase-button'><a href='' title='" + guestVO.guestbookID + "'>삭제</a></div>";
                        }

                        listItemHtml +=
                            '</div>' +
                            '<div class="second-line-comment">' +
                            '<div class="comment-writer-section">작성자 :&nbsp<a href="${pageContext.servletContext.contextPath}/minihome?id='
                            + guestVO.userid + '">' + guestVO.userid + '</a>&nbsp작성일자 : ' + writeDateString +
                            '</div>' +
                            '</div>' +
                            '</li>';

                        // 생성한 li 태그를 ul에 추가
                        $('.commnet-list').append(listItemHtml);
                    });
                },
                error: function () {
                    console.log('Error occurred while loading guestbook list.');
                }
            });
        }

        loadGuestbookList();

        $(document).on('click', '.erase-button a', function () {
            if (confirm("정말로 삭제하시겠습니까?")) {
                var guestbookid = $(this).attr("title");
                console.log(guestbookid);
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/minihome/guestbookDelete',
                    data: {
                        guestbookid: guestbookid
                    },
                    type: 'post',
                    success: function (result) {
                        if (result < 1) {
                            alert("삭제 실패했습니다.");
                        } else {
                            alert("삭제 되었습니다!");
                            loadGuestbookList();
                        }
                    },
                    error: function (error) {
                        console.log(error.responseText);
                    }
                });
            }
        });

        $(document).on('click', '#un-follow-button', function () {
            var ownerid = '${uVO.userid}';//값 잘 넘어옴
            if (confirm("정말" + ownerid + "님 팔로우를 해제하시겠습니까?")) {
                if (${LogStatus == "" || LogStatus==null || LogStatus!='Y'}) {
                    alert("로그인 후에 진행해주세요. 로그인 화면으로 이동합니다.");
                    window.location.href = "${pageContext.servletContext.contextPath}/";
                }
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/minihome/unfollow",
                    data: {
                        ownerid: ownerid
                    },
                    type: 'POST',
                    success: function (result) {
                        if (result == 1) {
                            alert(ownerid + "님 언팔로우 성공");
                            location.reload();
                        } else {
                            alert("알 수 없는 오류가 발생했습니다.");
                        }
                    },
                    error: function (error) {
                        console.log(error.responseText);
                    }
                });
            }

        });

        $(document).on('click', '#follow-button', function () {
            var ownerid = '${uVO.userid}';//값 잘 넘어옴
            if (confirm("정말" + ownerid + "님을 팔로우하시겠습니까?")) {
                if (${LogStatus == "" || LogStatus==null}) {
                    alert("로그인 후에 진행해주세요. 로그인 화면으로 이동합니다.");
                    window.location.href = "${pageContext.servletContext.contextPath}/";
                }
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/minihome/follow",
                    data: {
                        ownerid: ownerid
                    },
                    type: 'POST',
                    success: function (result) {
                        if (result == 1) {
                            alert("팔로우 성공");
                            location.reload();
                        } else {
                            alert("알 수 없는 오류가 발생했습니다.");
                        }
                    },
                    error: function (error) {
                        console.log(error.responseText);
                    }
                });
            }

        });


    });

</script>
<!-- uVO -> 미니홈 주인 정보 VO-->

<div class="minihome-area">
    <div class="home-left">
        <div class="profile-area">
            <div class="profile-container">
                <div class="profile-pic">
                    <img id="home-image"><!-- 경로 수정해야함-->
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
                        <input type="button" value="회원 정보 수정" class="edit-profile" id='edit-button'
                               onclick='editProfile()'>
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
                        <input type="button" value="출석체크" class="today-attend" id="today-attend">
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

        <div class="maincontainer">
            <!-- 이 아래부터 수정 허용 -->
            <div class="calendar-whole-section">
                <div class="controller-year-month-section">
                    <input type="button" value="PREV" class="month-control-button" onclick="previousMonth()">
                    <div>
                        <h1 class="year-month" id="currentMonthYear"></h1>
                    </div>
                    <input type="button" value="NEXT" class="month-control-button" onclick="nextMonth()">
                </div>
                <table id="calendar">
                    <thead>
                    <tr>
                        <th style="color: red;">일</th>
                        <th>월</th>
                        <th>화</th>
                        <th>수</th>
                        <th>목</th>
                        <th>금</th>
                        <th style="color: blue;">토</th>
                    </tr>
                    </thead>
                    <tbody id="calendarBody">
                    </tbody>
                </table>
                <div class="emoji-menu" id="emojiMenu">
                    <button onclick="insertEmoji('👍')">👍</button>
                    <button onclick="insertEmoji('🤔')">🤔</button>
                    <button onclick="insertEmoji('😎')">😎</button>
                    <!-- 다른 이모티콘을 추가할 수 있습니다. -->
                </div>
            </div>
            <div class="visitor-comment-section">
                <form method="post" id="commentForm">
                    <div class="comment-write-section">
                        <input type="text" name="comment-input" id="comment-input" class="comment-input"
                               placeholder="'${uVO.username}' 님의 미니홈 방명록"
                        <c:if test="${LogStatus!='Y'}">
                               disabled
                        </c:if>
                        >
                        <input type="submit" value="방명록 등록" class="comment-post"
                        <c:if test="${LogStatus!='Y'}">
                               disabled
                        </c:if>
                        >
                    </div>

                </form>
                <div class="comment-list-section">
                    <ul class="commnet-list">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    const calendarBody = document.getElementById("calendarBody");
    const currentMonthYear = document.getElementById("currentMonthYear");
    const emojiMenu = document.getElementById("emojiMenu");
    let currentDate = new Date();
    let selectedCell = null;

    function generateCalendar(year, month) {
        calendarBody.innerHTML = "";
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const firstDay = new Date(year, month, 1).getDay();
        const monthText = getMonthText(month);
        currentMonthYear.textContent = monthText + " " + year;
        let day = 1;
        for (let i = 0; i < 6; i++) {
            const row = document.createElement("tr");
            for (let j = 0; j < 7; j++) {
                const cell = document.createElement("td");
                //
                if ((j + 1) % 7 === 1) {
                    cell.style.color = "red";
                } else if ((j + 1) % 7 === 0) {
                    cell.style.color = "blue";
                }
                //
                if (i === 0 && j < firstDay) {
                    cell.textContent = "";
                } else if (day > daysInMonth) {
                    cell.textContent = "";
                } else {
                    cell.textContent = day++;
                }

                row.appendChild(cell);
            }

            calendarBody.appendChild(row);
        }

        // 마지막 행 숨기기
        calendarBody.lastElementChild.style.display = "none";
        $.ajax({
            url: "${pageContext.servletContext.contextPath}/minihome/generateMemo",
            data: {
                userid: '${uVO.userid}',
                month: month,
                year: year
            },
            type: 'POST',
            dataType: 'json',
            success: function (memoList) {
                memoList.forEach(function (memoVO) {
                    var write_date = memoVO.write_date;
                    var cat = memoVO.cat;
                    if (cat == 'lower') {
                        cat = '2';
                    } else {
                        cat = '1';
                    }

                    const emoji = memoVO.emoji;
                    const memoid = memoVO.memoid;

                    let bgColor;
                    switch (cat) {
                        case '1':
                            bgColor = 'lightcoral';
                            break;
                        case '2':
                            bgColor = 'lightblue';
                            break;
                        default:
                    }

                    let emojiText;
                    switch (emoji) {
                        case 1:
                            emojiText = "😊";
                            break;
                        case 2:
                            emojiText = "😂";
                            break;
                        case 3:
                            emojiText = "😍";
                            break;
                        case 4:
                            emojiText = "🤔";
                            break;
                        case 5:
                            emojiText = "😥";
                            break;
                        default:
                            emojiText = "";
                    }


                    $('td').each(function () {
                        var dayValue = $(this).text();
                        var today_day = new Date();
                        today_day = today_day.getDate();


                        if (dayValue < 10) dayValue = "0" + dayValue;

                        if (dayValue == write_date) {
                            if (dayValue == today_day) {
                                console.log("도달!");
                                console.log("dayValue=" + dayValue + "today_day = " + today_day);
                                $("#today-attend").prop('disabled', true);
                            }
                            var memocell = $(this).text() + ' ' + emojiText;
                            var checkMark = document.createElement("span");
                            checkMark.className = "check-mark";
                            checkMark.textContent = "✓";

                            $(this).text(memocell);
                            $(this).css('background-color', bgColor);
                            $(this).append(checkMark);
                            checkMark.addEventListener("click", function () {
                                console.log("arrive");
                                window.location.href = "${pageContext.servletContext.contextPath}/minihome/memoView?no=" + memoid;
                            });
                        }
                    });
                });
            },
            error: function (error) {
                console.log(error.responseText);
            }
        });
    }


    function getMonthText(month) {
        const monthNames = [
            "JANUARY",
            "FEBRUARY",
            "MARCH",
            "APRIL",
            "MAY",
            "JUNE",
            "JULY",
            "AUGUST",
            "SEPTEMBER",
            "OCTOBER",
            "NOVEMBER",
            "DECEMBER",
        ];
        const monthIndex = Math.max(0, Math.min(month, 11));
        const monthText = monthNames[monthIndex];

        return monthText;
    }

    generateCalendar(currentDate.getFullYear(), currentDate.getMonth());

    function previousMonth() {
        currentDate.setMonth(currentDate.getMonth() - 1);
        generateCalendar(currentDate.getFullYear(), currentDate.getMonth());
    }

    function nextMonth() {
        currentDate.setMonth(currentDate.getMonth() + 1);
        generateCalendar(currentDate.getFullYear(), currentDate.getMonth());
    }

</script>


<script src="${pageContext.servletContext.contextPath}/js/community-default.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/minihome-calander.js"></script>
<script src="${pageContext.servletContext.contextPath}/js/minihome-default.js"></script>