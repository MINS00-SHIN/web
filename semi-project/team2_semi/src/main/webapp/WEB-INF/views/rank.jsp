<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<script>
    function fetchData() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'YOUR_SERVER_ENDPOINT_URL', true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var data = JSON.parse(xhr.responseText);
                // data 배열에 따라 HTML 업데이트
                updateRanking(data);
            }
        };
        xhr.send();
    }

    function updateRanking(data) {
        var ranks = ["🥇", "🥈", "🥉"]; // 1,2,3등의 특수문자
        var rankingList = document.querySelector(".follow-ranking ul");
        for (var i = 0; i < data.followers.length; i++) {
            var rank = ranks[i] || "#" + (i + 1) + " :"; // 4등 이상은 순서대로
            rankingList.children[i+2].querySelector("a").textContent = rank + " " + data.followers[i].name;
        }
    }

    // 페이지 로드 시 데이터 가져오기
    window.onload = fetchData;
</script>

        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-ranking-and-postlist.css">
        <div class="left">
            <div class="left">
                <div class="follow-ranking">
                    <ul>
                        <li class="ranking-head">팔로워 랭킹 🏆 </li>
                        <li>&nbsp;</li>
                        <li><a href="MiniHome_Home.html">#🥇 하이룽</a></li>
                        <li><a href="MiniHome_Home.html">#🥈 2등입니다.</a></li>
                        <li><a href="MiniHome_Home.html">#🥉 내아래로메달없음</a></li>
                        <li><a href="MiniHome_Home.html">#4 : 진자억울하다</a></li>
                        <li><a href="MiniHome_Home.html">#5 : 근육돼지</a></li>
                        <li><a href="MiniHome_Home.html">#6 : 아침은닭가슴살사과쉐이크</a></li>
                        <li><a href="MiniHome_Home.html">#7 : 금잔디명예소방관</a></li>
                        <li><a href="MiniHome_Home.html">#8 : 인생최대업적롤플레</a></li>
                        <li><a href="MiniHome_Home.html">#9 : 닭가슴살도시락소믈리에</a></li>
                    </ul>
                </div>
                <div class="like-ranking">
                    <ul>
                        <li class="ranking-head">인기글 랭킹 🏆 </li>
                        <li>&nbsp;</li>
                        <li><a href="Community_post.html">#🥇 어깨가 너무 아파요</a></li>
                        <li><a href="Community_post.html">#🥈 오늘 기록 갱신</a></li>
                        <li><a href="Community_post.html">#🥉 닭가슴살 1+1+1 행사</a></li>
                        <li><a href="Community_post.html">#4 : 프로틴 이 맛이 맞아요?</a></li>
                        <li><a href="Community_post.html">#5 : 정보)스트랩 추천</a></li>
                        <li><a href="Community_post.html">#6 : 집 앞 헬스장 시설 수준</a></li>
                        <li><a href="Community_post.html">#7 : 입원했는데, 누워있으면 근손실옴?</a></li>
                        <li><a href="Community_post.html">#8 : 헬스장 불났다</a></li>
                        <li><a href="Community_post.html">#9 : 눈바디 어떰?</a></li>
                    </ul>
                </div>
            </div>
        </div>
