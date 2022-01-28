<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

</head>
<style>
body {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	height: 100%;
	width: 100%;
	height: 100%;
	justify-content: center;
	flex-direction: column;
}

table {
	margin: 20px;
	border-top: 1px solid black;
	border-bottom: 1px solid gray;
	width: 80%;
	height: 100%;
}

.tableHaead {
	margin: 10px;
	width: 100%;
	border-bottom: 1px solid black;
}

.tableBox {
	border-bottom: 1px solid black;
}

td, th {
	padding: 4px 7px;
	text-align: center;
	border-bottom: 1px solid #f2f2f2;
}

a {
	text-decoration-line: none;
	color: black;
}

b {
	color: blue;
}
</style>



<body>

	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>


	<div>
		From: <input type="text" name="fromDate" id="fromDate"
			value="${fromDate}">&nbsp;&nbsp; To: <input type="text"
			name="toDate" id="toDate" value="${toDate}">
	</div>

	<table>
		<thead class=tableHaead>
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
				<tr class=tableBox>
					<td>${list.bno}</td>
					<td><a href="/board/view?bno=${list.bno}">${list.title}</a></td>
					<td><fmt:formatDate pattern="yyyy/MM/dd"
							value="${list.regDate}" /></td>
					<td>${list.writer}</td>
					<td>${list.viewCnt}</td>
				</tr>
			</c:forEach>

		</tbody>

	</table>

	<div>

		<c:if test="${prev}">
			<span>[ <a
				href="/board/listPage?num=${firstPageNum}${searchTypeKeyword}"><<</a>
				]
			</span>
		</c:if>

		<c:if test="${prev}">
			<span>[ <a
				href="/board/listPage?num=${select - 1}${searchTypeKeyword}"><</a> ]
			</span>
		</c:if>

		<c:forEach begin="${startPageNum}" end="${endPageNum}" var="num">
			<span> <c:if test="${select != num}">
					<a href="/board/listPage?num=${num}${searchTypeKeyword}">${num}</a>
				</c:if> <c:if test="${select == num}">
					<b>${num}</b>
				</c:if>

			</span>
		</c:forEach>

		<c:if test="${next}">
			<span>[ <a
				href="/board/listPage?num=${select + 1}${searchTypeKeyword}">></a> ]
			</span>
		</c:if>

		<c:if test="${next}">
			<span>[ <a
				href="/board/listPage?num=${endPageNum_tmp}${searchTypeKeyword}">>></a>
				]
			</span>
		</c:if>


		<%-- <c:forEach begin="1" end="${pageNum}" var="num">
    <span>
     <a href="/board/listPage?num=${num}">${num}</a>
  </span>
 </c:forEach> --%>

		<div>
			<select name="searchType">
				<option value="title"
					<c:if test="${searchType eq 'title'}">selected</c:if>>제목</option>
				<option value="content"
					<c:if test="${searchType eq 'content'}">selected</c:if>>내용</option>
				<option value="title_content"
					<c:if test="${searchType eq 'title_content'}">selected</c:if>>제목+내용</option>
				<option value="writer"
					<c:if test="${searchType eq 'writer'}">selected</c:if>>작성자</option>
			</select> <input type="text" name="keyword" value="${keyword}" />

			<button type="button" id="searchBtn">검색</button>
		</div>
		<div>
			<a href="/board/write">글 작성</a>
		</div>
	</div>



	<script>
		document.getElementById("searchBtn").onclick = function() {

			let searchType = document.getElementsByName("searchType")[0].value;
			let keyword = document.getElementsByName("keyword")[0].value;
			let fromDate = document.getElementsByName("fromDate")[0].value;
			let toDate = document.getElementsByName("toDate")[0].value;

			location.href = "/board/listPage?num=1" + "&searchType="
					+ searchType + "&keyword=" + keyword + "&fromDate="
					+ fromDate + "&toDate=" + toDate;
		};

		/* 캘린더 설정 */
		$(function() {
			const config = {
				dateFormat : 'yy-mm-dd' // Input Display Format 변경
				,
				showOtherMonths : true // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
				,
				showMonthAfterYear : true // 년도 먼저 나오고, 뒤에 월 표시
				,
				changeYear : true // 콤보박스에서 년 선택 가능
				,
				changeMonth : true // 콤보박스에서 월 선택 가능
				,
				showOn : "both" // button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
				,
				buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" // 버튼 이미지 경로       ,buttonImageOnly: true // 기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
				,
				buttonText : "선택" // 버튼에 마우스 갖다 댔을 때 표시되는 텍스트
				,
				yearSuffix : "년" // 달력의 년도 부분 뒤에 붙는 텍스트
				,
				monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
						'9', '10', '11', '12' ] // 달력의 월 부분 텍스트
				,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
						'9월', '10월', '11월', '12월' ] // 달력의 월 부분 Tooltip 텍스트
				,
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] // 달력의 요일 부분 텍스트
				,
				dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ] // 달력의 요일 부분 Tooltip 텍스트
				,
				minDate : "-1Y" // 최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
				,
				maxDate : "+1Y" // 최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) });

			}

			/* 캘린더 */

			$("#fromDate").datepicker(config);
			$("#toDate").datepicker(config);

			$("#fromDate").datepicker('setDate', 'today')
			$("#toDate").datepicker('setDate', '+1D');

		});
	</script>

</body>
</html>