<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<section class="flex justify-center">
	<div class="w-2/5">
		<div class="flex items-center justify-center h-20 text-4xl font-bold">
			<a href="list?boardCode=${boardCode}" class="hover:underline">${article.boardName}</a>
		</div>
		<div class="flex border-b-2 border-t-2 border-gray-500 text-center">
			<div class="w-full">
				<div class="flex text-xl border-b">
					<span class="flex w-16 bg-gray-100 justify-center">제목</span>
					<span class="mx-2">${article.title}</span>
				</div>
				<div class="flex border-b">
					<span class="flex w-16 bg-gray-100 justify-center">작성자</span>
					<span class="mx-2">${article.nickname}</span>
				</div>
				<div class="flex border-b">
					<span class="flex w-16 bg-gray-100 justify-center">내용</span>
					<span class="mx-2">${article.body}</span>
				</div>
				<div class="flex">
					<span class="flex w-16 bg-gray-100 justify-center">첨부파일</span> <span>img</span>
				</div>
			</div>
		</div>
		<div class="flex justify-end mt-1">
			<input type="button" value="수정" onclick="location.href='update?aid=${article.aid}'" class="m-1 h-8 w-16 rounded bg-blue-300 hover:bg-blue-500" />
			<input type="button" value="삭제" onclick="location.href='delete?aid=${article.aid}'" class="m-1 h-8 w-16 rounded bg-red-300 hover:bg-red-500" />
			<input type="button" value="목록으로" onclick="location.href='list?boardCode=${article.boardCode}'" class="m-1 h-8 w-16 rounded bg-gray-100 hover:bg-gray-300" />
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>