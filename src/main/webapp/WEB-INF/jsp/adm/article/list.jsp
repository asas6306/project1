<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<div class="flex justify-center">
	<div class="w-3/5">
		<div class="flex items-center justify-center h-20 text-4xl font-bold">전체 게시물</div>
		<div class="flex border-b-2 border-t-2 border-gray-500 text-center">
			<div class="flex w-full">
				<div class="w-full bg-gray-100">제목</div>
				<div class="w-32">작성자</div>
				<div class="w-60 bg-gray-100">작성일</div>
				<div class="w-16">조회</div>
			</div>
			<div class="w-40 bg-gray-100 border-l-2 border-gray-500">게시판</div>
		</div>
		<div class="flex justify-center border-b-2 border-gray-500">
			<div class="w-full">
				<c:forEach items='${articles}' var='article'>
					<div class="flex border-b">
						<a href="/adm/article/detail?aid=${article.aid}" class="w-full hover:underline">${article.title}</a>
						<div class="bg-gray-100 text-center w-32">${article.nickname}</div>
						<div class="text-center w-60">${article.regDate}</div>
						<div class="bg-gray-100 text-center w-16">${article.hit}</div>
					</div>
				</c:forEach>
			</div>
			<nav class="w-40 border-l-2 border-gray-500">
				<ul>
					<a href="/adm/article/list" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
						<span>전체글보기</span>
					</a>
					<a href="/adm/article/list?boardCode=1" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
						<span>공지사항</span>
					</a>
					<a href="/adm/article/list?boardCode=2" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
						<span>자유게시판</span>
					</a>
					<div class="pb-1"></div>
				</ul>
			</nav>
		</div>
		<form action="doSearchArticle" method="post" class="flex justify-center mt-4">
			<input type="text" name="searchKeyword" class="border w-60 border-gray-300"/>
			<input type="submit" value="검색" class="w-16 bg-blue-300"/>
		</form>
	</div>
</div>

<%@ include file="../part/mainLayoutFooter.jspf"%>