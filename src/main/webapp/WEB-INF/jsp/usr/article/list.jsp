<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

<c:set var="fileInputMaxCount" value="3" />

<section class="flex justify-center">
	<div class="max-w-5xl">
		<div>
			<div class="flex justify-between">
				<span class="flex text-4xl font-bold p-3">
					<c:choose>
						<c:when test="${boardCode == 0}">
							전체게시물
						</c:when>
						<c:otherwise>
							<c:forEach var="board" items="${boards}">
								<c:if test="${board.boardCode.equals(boardCode)}">
									${board.boardName}
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</span>
				<div class="flex justify-center items-center p-1">
					<c:if test="${rq.logined}">
						<a href="add?boardCode=${boardCode}" class="text-gray-900 p-1 px-2 rounded bg-blue-300 hover:bg-blue-500 hover:text-white">글쓰기</a>
					</c:if>
				</div>
			</div>
			<div class="border-b-4 border-t-4 rounded border-blue-700">
				<c:forEach var="article" items="${articles}">
					<div class="border-b-2 border-blue-500 py-3">
						<div class="flex border-b">
							<div class="flex justify-center items-center w-12">
								<c:choose>
									<c:when test="${boardCode == 0}">
										<a href="list?boardCode=${article.boardCode}" class="text-sm">${Util.setBoardName(article.boardName)}</a>
									</c:when>
									<c:otherwise>
										<span class="text-sm">${article.aid}</span>
									</c:otherwise>
								</c:choose>
								
							</div>
							<div class="flex justify-center items-center">
								<a href="detail?aid=${article.aid}&boardCode=${param.boardCode}" class="text-lg font-bold hover:text-blue-700">${article.title}</a>
							</div>
						</div>
						<div class="grid grid-cols-2 lg:grid-cols-4 px-4 font-thin">
							<div class="flex items-center">
								<div>
									<img src="${article.writerProfileImgUri}" onerror="${article.writerProfileFallbackImgOnErrorHtmlAttr}" class="w-10 h-10 rounded-full" />
								</div>
								<span>&nbsp${article.nickname}</span>
							</div>
							<div class="flex items-center">
								<span class="text-sm">작성일 : </span>
								<span class="">&nbsp${Util.dateFormat(article.regDate)}</span>
							</div>
							<div class="flex items-center">
								<span class="text-sm">수정일 : </span>
								<span>&nbsp${Util.dateFormat(article.updateDate)}</span>
							</div>
							<div class="flex items-center">
								<span class="text-sm">조회수 : </span>
								<span>&nbsp${Util.numberFormat(article.hit)}</span>
							</div>
						</div>
						<div>
							<div class="flex">
								<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
									<div class="">
										<c:set var="fileNo" value="${String.valueOf(inputNo)}"></c:set>
										<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}"></c:set>
										<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
											<div>
												<a href="${file.forPrintUri}" target="_blank" title="자세히 보기">
													<img class="h-40 w-40 sm:h-48 sm:w-48 lg:h-60 lg:w-60 rounded-lg object-cover" src="${file.forPrintUri}" />
												</a>
											</div>
										</c:if>
									</div>
								</c:forEach>
							</div>
							<div class="px-4 border rounded p-1">
								<span class="text-lg">${article.body}</span>
							</div>
						</div>
						<div class="grid grid-cols-2 px-4 font-thin">
							<div class="flex">
								<span class="flex justify-center items-center text-sm">댓글수 : </span>
								<span>&nbsp${Util.numberFormat(article.extra.replyCnt)}</span>
							</div>
							<div class="flex">
								<span class="flex justify-center items-center text-sm">추천수 : </span>
								<span>&nbsp${Util.numberFormat(article.like)}</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="flex">
			<div class="flex justify-center text-lg flex-grow text-gray-700">
				<a href="/usr/article/list?boardCode=${boardCode}&page=1&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:text-blue-500">처음</a>
				<a href="/usr/article/list?boardCode=${boardCode}&page=${printPageIndexDown}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:text-blue-500">이전</a>
				<c:forEach items='${printPageIndexs}' var='printPageIndex'>
					<c:choose>
						<c:when test="${printPageIndex == page}">
							<a href="/usr/article/list?boardCode=${boardCode}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 text-black font-extrabold">${printPageIndex}</a>
						</c:when>
						<c:otherwise>
							<a href="/usr/article/list?boardCode=${boardCode}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:text-blue-500">${printPageIndex}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<a href="/usr/article/list?boardCode=${boardCode}&page=${printPageIndexUp}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:text-blue-500">다음</a>
				<a href="/usr/article/list?boardCode=${boardCode}&page=1000000&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:text-blue-500">끝</a>
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