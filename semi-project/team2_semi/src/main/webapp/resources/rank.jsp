<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
    function fetchData() {
        fetchRanking('YOUR_FOLLOWERS_ENDPOINT_URL', updateFollowerRanking, '.follow-ranking ul');
        fetchRanking('YOUR_POSTS_ENDPOINT_URL', updatePostRanking, '.like-ranking ul');
    }

    function fetchRanking(url, callback, selector) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var data = JSON.parse(xhr.responseText);
                callback(data, selector);
            }
        };
        xhr.send();
    }

    function updateFollowerRanking(data, selector) {
        var ranks = ["🥇", "🥈", "🥉"];
        var rankingList = document.querySelector(selector);
        for (var i = 0; i < data.followers.length; i++) {
            var rank = ranks[i] || "#" + (i + 1) + " :";
            rankingList.children[i + 2].querySelector("a").textContent = rank + " " + data.followers[i].name;
        }
    }

    function updatePostRanking(data, selector) {
        var ranks = ["🥇", "🥈", "🥉"];
        var rankingList = document.querySelector(selector);
        for (var i = 0; i < data.posts.length; i++) {
            var rank = ranks[i] || "#" + (i + 1) + " :";
            rankingList.children[i + 2].querySelector("a").textContent = rank + " " + data.posts[i].title;
        }
    }

    // 페이지 로드 시 데이터 가져오기
    window.onload = fetchData;
</script>

<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/community-ranking-and-postlist.css">
<div class="left">
<!-- 팔로워 랭킹 리스트 -->
<div class="follow-ranking">
    <ul>
        <li class="ranking-head">팔로워 랭킹 🏆 </li>
        <li>&nbsp;</li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
    </ul>
</div>
<!-- 인기글 랭킹 리스트 -->
<div class="like-ranking">
    <ul>
        <li class="ranking-head">인기글 랭킹 🏆 </li>
        <li>&nbsp;</li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
        <li><a href="#">Loading...</a></li>
    </ul>
</div>
</div>
