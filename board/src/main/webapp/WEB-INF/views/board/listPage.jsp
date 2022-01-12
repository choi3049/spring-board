<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert title here</title>
</head>
<style>
	b {color:blue;}
</style>
<body>



<div id="nav">
 <%@ include file="../include/nav.jsp" %>
</div>
		<table>
 <thead>
  <tr>
   <th>번호</th>
   <th>제목</th>
   <th>작성일</th>
   <th>작성자</th>
   <th>조회수</th>
  </tr>
 </thead>
 
 <tbody>
  
  <c:forEach items="${list}" var="list">
 <tr>
  <td>${list.bno}</td>
  <td>
    <a href="/board/view?bno=${list.bno}">${list.title}</a>
</td>
  <td>${list.regDate}</td>
  <td>${list.writer}</td>
  <td>${list.viewCnt}</td>
 </tr>
</c:forEach>
  
 </tbody>

</table>

<div>

<c:if test="${prev}">
 <span>[ <a href="/board/listPage?num=${firstPageNum}${searchTypeKeyword}"><<</a> ]</span>
</c:if>

<c:if test="${prev}">
 <span>[ <a href="/board/listPage?num=${select - 1}${searchTypeKeyword}"><</a> ]</span>
</c:if>

<c:forEach begin="${startPageNum}" end="${endPageNum}" var="num">
 <span>
 
  <c:if test="${select != num}">
   <a href="/board/listPage?num=${num}${searchTypeKeyword}">${num}</a>
  </c:if>    
  
  <c:if test="${select == num}">
   <b>${num}</b>
  </c:if>
    
 </span>
</c:forEach>

<c:if test="${next}">
 <span>[ <a href="/board/listPage?num=${select + 1}${searchTypeKeyword}">></a> ]</span>
</c:if>

<c:if test="${next}">
 <span>[ <a href="/board/listPage?num=${endPageNum_tmp}${searchTypeKeyword}">>></a> ]</span>
</c:if>


 <%-- <c:forEach begin="1" end="${pageNum}" var="num">
    <span>
     <a href="/board/listPage?num=${num}">${num}</a>
  </span>
 </c:forEach> --%>
 
<div>
 <select name="searchType">
     <option value="title" <c:if test="${searchType eq 'title'}">selected</c:if>>제목</option>
        <option value="content" <c:if test="${searchType eq 'content'}">selected</c:if>>내용</option>
     <option value="title_content" <c:if test="${searchType eq 'title_content'}">selected</c:if>>제목+내용</option>
     <option value="writer" <c:if test="${searchType eq 'writer'}">selected</c:if>>작성자</option>
 </select>
 
 <input type="text" name="keyword" value="${keyword}"/>
 
 <button type="button" id="searchBtn">검색</button>
</div>
 
</div>

<script>

 document.getElementById("searchBtn").onclick = function () {
    
  let searchType = document.getElementsByName("searchType")[0].value;
  let keyword =  document.getElementsByName("keyword")[0].value;
  
  location.href = "/board/listPage?num=1" + "&searchType=" + searchType + "&keyword=" + keyword;
 };
</script>

</body>
</html>