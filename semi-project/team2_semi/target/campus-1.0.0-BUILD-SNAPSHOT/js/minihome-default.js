document
  .getElementById("main-search")
  .addEventListener("keydown", function (e) {
    if (e.key === "Enter") {
      if (this.value === "") {
        alert("검색어를 입력해주세요");
      } else {
        window.location.href = "Community_Search_Result.html";
      }
    }
  });
