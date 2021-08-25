<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

<c:set var="fileInputMaxCount" value="3" />

<section class="flex justify-center">
	<div class="max-w-5xl w-full">
		<div>
			<div class="flex">
				<div>
					<span class="flex text-4xl font-bold p-3">쪽지함</span>
				</div>
				<div class="flex items-end p-2 gap-3">
					<c:choose>
						<c:when test="${param.noteType == 'send'}">
							<a href="list?noteType=resive&page=${page}" class="text-gray-500">받은 쪽지함</a>
							<span class="font-bold border-b-2 border-blue-500">보낸 쪽지함</span>
						</c:when>
						<c:otherwise>
							<span class="font-bold border-b-2 border-blue-500">받은 쪽지함</span>
							<a href="list?noteType=send&page=${page}" class="text-gray-500">보낸 쪽지함</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="border-b-4 border-t-4 rounded border-blue-700">
				<c:forEach var="note" items="${notes}">
					<div class="border-b">
						<div class="grid grid-cols-4">
							<span class="">수신인 : ${note.nickname}</span>
							
						</div>
						<div>
							<span class="px-4">${note.body}</span>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="flex">
			<div class="flex justify-center text-lg flex-grow text-gray-700">
				<a href="list?page=1" class="p-2 hover:text-black hover:text-blue-500">처음</a>
				<a href="list?page=${printPageIndexDown}" class="p-2 hover:text-black hover:text-blue-500">이전</a>
				<c:forEach items='${printPageIndexs}' var='printPageIndex'>
					<c:choose>
						<c:when test="${printPageIndex == page}">
							<a href="list?page=${printPageIndex}" class="p-2 text-black font-extrabold">${printPageIndex}</a>
						</c:when>
						<c:otherwise>
							<a href="list?page=${printPageIndex}" class="p-2 hover:text-black hover:text-blue-500">${printPageIndex}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<a href="list?page=${printPageIndexUp}" class="p-2 hover:text-black hover:text-blue-500">다음</a>
				<a href="list?page=1000000" class="p-2 hover:text-black hover:text-blue-500">끝</a>
			</div>
		</div>
		<div class="search-box-article">
			<form action="list" method="get" class="flex justify-center">
				<input type="hidden" name="boardCode" value="${boardCode}">
				<select name="searchType" class="border text-gray-700">
					<option value="titleAndBody">제목+내용</option>
					<option value="title">제목</option>
					<option value="nickname">작성자</option>
				</select>
				<script>
					$('.search-box-article form [name="searchType"]').val('${searchType}')
				</script>
				<input type="text" name="searchKeyword" class="border w-60 border-gray-300"/>
				<input type="submit" value="검색" class="w-16 bg-blue-300 hover:bg-blue-500"/>
			</form>
		</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>