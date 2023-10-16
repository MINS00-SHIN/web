<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet"
      href="${pageContext.servletContext.contextPath}/css/default.css">
<link rel="stylesheet"
      href="${pageContext.servletContext.contextPath}/css/community-nav.css">
<link rel="stylesheet"
      href="${pageContext.servletContext.contextPath}/css/community-header.css">
<link rel="stylesheet"
      href="${pageContext.servletContext.contextPath}/css/community-ranking-and-postlist.css">
<link rel="stylesheet"
      href="${pageContext.servletContext.contextPath}/css/community-map.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=23bee51da0d0811f6f8880e96e9de62c&libraries=services"></script>

<header>
    <!-- 게시판 알려주는 박스 -->
    <div class="intro-board"
         style="background-image: url(${pageContext.servletContext.contextPath}/img/Map_Banner.png);">
        <div class="board-name">주변 헬스장 찾기</div>
    </div>
</header>

<!-- #region start -->
<!-- 랭킹영역 -->
<!-- #region start -->
<div class="content">
    <jsp:include page="/resources/rank.jsp"/>

    <!-- 지도 부분 -->

    <div class="right" style="margin-top: 110px;">
        <!--  <div id="search-box">
                    <input type="text" value="이태원" id="keyword" placeholder="장소 검색">
                    <button id="search-button" onclick="drawmap()">검색</button>
                </div>-->
        <div class=" map-container">
            <div class="map_wrap">
                <div id="map"
                     style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

                <div id="menu_wrap" class="bg_white">
                    <div class="option">
                        <div>
                            <form onsubmit="searchPlaces(); return false;">
                                키워드 : <input type="text" value="" id="keyword" size="15">
                                <button type="submit">검색</button>
                            </form>
                        </div>
                    </div>
                    <hr>
                    <ul id="placesList"></ul>
                    <div id="pagination"></div>
                </div>
            </div>
        </div>
        <div id="review-form" style="display: none; height: 200px;">
            <h2>
                <span id="place-name"></span>
            </h2>


            <form method="post">
                <label>별점:</label><br>
                <div class="star-rating">
                    <input type="radio" id="5-stars" name="rating" value="5"/> <label
                        for="5-stars" class="star">&#9733;</label> <input type="radio"
                                                                          id="4-stars" name="rating" value="4"/> <label
                        for="4-stars"
                        class="star">&#9733;</label> <input type="radio" id="3-stars"
                                                            name="rating" value="3"/> <label for="3-stars" class="star">&#9733;</label>
                    <input type="radio" id="2-stars" name="rating" value="2"/> <label
                        for="2-stars" class="star">&#9733;</label> <input type="radio"
                                                                          id="1-star" name="rating" value="1"/> <label
                        for="1-star"
                        class="star">&#9733;</label>
                </div>
                <input type="hidden" id="placeName" value="placeName"
                       name="placeName"/> <input type="hidden" id="x" value="x" name="x"/>
                <input type="hidden" id="y" value="y" name="y"/> <br>
                <textarea name='comment' id="comment"
                          style="width: 100%; height: 40px; border: 1px solid #CCCCCC; background-color: #FFFDD0;"
                          placeholder='리뷰를 남겨주세요'></textarea>

                <br/> <input type='button' id="writereview" value='등록'/>


            </form>

        </div>
        <div id="reviewBox"
             style="border: 1px solid #CCCCCC; background-color: #FFFDD0; width: 100%; overflow-y:auto; max-height: 300px; min-height: 100px; margin-top: 30px; display:none;">
            <!-- 여기에 리뷰 정보가 들어갑니다. -->
            <ul id="reviewlist">

            </ul>
        </div>
    </div>
</div>


<script>
    function fillForm(placeName, x, y) {
        document.getElementById('placeName').value = placeName;
        document.getElementById('x').value = x;
        document.getElementById('y').value = y;
    }
</script>


<script>


    function showReviewForm(y, x, placeName) {
        console.log(placeName);
        document.getElementById('review-form').style.display = 'block';
        document.getElementById('place-name').textContent = placeName;
        document.getElementById('placeName').value = placeName;
        var inputx = document.getElementById('x');
        var inputy = document.getElementById('y');
        inputx.value = x.toString();
        inputy.value = y.toString();
        getreview(y.toString(), x.toString(), placeName);

        $(document).on('click','#writereview',function(){
           var placeName = $("#placeName").val();
           var comment = $("#comment").val();
           var x = $("#x").val();
           var y = $("#y").val();
           var rating = $('input[name="rating"]:checked').val();
           if(comment && rating){
               //여기에 ajax
               $.ajax({
                  url: "${pageContext.servletContext.contextPath}/submit-review",
                   type:'post',
                   data: {
                      placeName:placeName,
                       comment:comment,
                       x:x,
                       y:y,
                       rating:rating
                   },
                   success:function(result){
                      if(result>0){
                          getreview(y,x,placeName);
                          $("#comment").val('');
                          $('input[name="rating"]').prop('checked',false);
                      }
                   },
                   error:function(error){
                      console.log(error);
                   }
               });
           }else{
               alert("별점과 리뷰를 모두 입력해주세요");
           }
        });
    }

    function getreview(y, x, placeName) {
        var reviewboxdiv = document.getElementById("reviewBox");
        reviewboxdiv.style.display = "block";
        $.ajax({
            url: "${pageContext.servletContext.contextPath}/getreview",
            data: {
                x: x,
                y: y,
                placeName: placeName
            },
            type: 'post',
            success: function (result) {
                $('#reviewlist').empty();
                $(result).each(function (index, reviewvo) {
                    var rating = reviewvo.rating;
                    console.log(reviewvo.comment);
                    var star = "";
                    for (var i = 0; i < rating; i++) {
                        star += "⭐";
                    }
                    var htmltag = "<li class='review' style='border-bottom:1px solid #ddd;'>";
                    htmltag += "<p class='rating'>" + star + "</p>";
                    htmltag += "<p class='comment'>" + reviewvo.review + "</p>";
                    htmltag += "<p class='author'><a href = '${pageContext.servletContext.contextPath}/minihome?id=" + reviewvo.userid + "'>" + reviewvo.userid + "</a></p>";
                    htmltag += "</li>";

                    $('#reviewlist').append(htmltag);
                });
            },
            error: function (error) {

            }
        });
    }
</script>


<script
        src="${pageContext.servletContext.contextPath}/js/community-map.js"></script>
