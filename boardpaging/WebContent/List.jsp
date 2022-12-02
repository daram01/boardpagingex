<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="model1.board.BoardDTO" %>
<%@ page import="model1.board.BoardDAO" %>
<%
	//DAO를 생성해 DB에 연결한다.
	BoardDAO dao = new BoardDAO(application);

	//사용자가 입력한 검색 조건을 Map에 저장한다.
	Map<String, Object> param = new HashMap<String, Object>();
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	
	//param 변수에 사용자로부터 받아온 값을 담는다.
	if(searchWord != null){
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);		
	}
	
	int totalCount = dao.selectCount(param); // 게시물 수 확인
	List<BoardDTO> boardLists = dao.selectList(param); // 게시물 목록 받기
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 	<jsp:include page="./common/Link.jsp" /> --%>
	<h2>목록보기(List)</h2>
	<form method="get">
	<table border="1" width="90%">
	<tr>
		<td align="center">
			<select name="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option> 
			</select>
			<input type="text" name="searchWord" />
			<input type="submit" value="검색하기" />
		</td>
	</tr>
	</table>
	</form>
	
	<table border="1" width="90%">
		<tr>
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
		</tr>
		
<%
if(boardLists.isEmpty()){
%>
		<tr>
			<td colspan="5" align="center">
				등록된 게시물이 없습니다.^^*
			</td>
		</tr>
<%
} else {
	int virtualNum = 0; // 화면상에서의 게시물 번호
	for(BoardDTO dto : boardLists){
		virtualNum = totalCount--; // 전체 게시물 수에서 시작해서 1씩 감소
%>
		<tr align="center">
			<td><%= virtualNum %></td> 
			<td align="left">
				<a href="View.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a>
			</td>
			<td align="center"><%= dto.getId() %></td>
			<td align="center"><%= dto.getVisitcount() %></td>
			<td align="center"><%= dto.getPostdate() %></td>
		</tr>
<%
	}
}
%>
	</table>
	
	<table border="1" width="90%">
		<tr align="right">
			<td><button type="button" onclick="location.href='Write.jsp';">글쓰기</button></td>
		</tr>
	</table>
</body>
</html>