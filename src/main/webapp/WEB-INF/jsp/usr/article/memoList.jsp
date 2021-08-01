<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.controller.AdmArticleController"%>

<c:set var="fileInputMaxCount" value="3" />

<section class="flex justify-center">
	<div class="max-w-5xl w-full">
		<div>
			<div class="flex justify-between">
				<div></div>
				<span class="flex text-4xl font-bold p-6">
					<c:choose>
						<c:when test="${boardCode == 0}">
							전체메모
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
		</div>
		<div class="flex justify-center border-t-2 border-blue-500">
			<div class="w-full">
				<c:choose>
					<c:when test="${articlesCnt == 0}">
						<div class="flex h-full justify-center items-center">
							<span>게시물이 존재하지 않습니다. 크크루삥뽕</span>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="article" items="${articles}">
							<div class="border-b-2 border-blue-500 py-3">
								<div class="mx-2 mt-1 text-sm mt-2 text-gray-500">
									<a href="/usr/article/list?boardCode=${article.boardCode}" class="">${article.boardName} ></a>
								</div>
								<div class="text-3xl">
									<a href="detail?aid=${article.aid}&boardCode=${article.boardCode}&articleType=memo&hit=true" class="px-2">${article.title}</a>
								</div>
								<div class="flex w-full items-center">
									<div class="p-2">
										<img src="${article.writerProfileImgUri}" onerror="${article.writerProfileFallbackImgOnErrorHtmlAttr}" class="w-10 h-10 rounded-full bg-gray-300" />
									</div>
									<div>
										<a href="../member/userpage?uid=${article.uid}" class="text-center w-20">${article.nickname}</a>
										<div class="text-sm text-gray-500">${article.regDate}</div>
									</div>
								</div>
								<div class="w-full border rounded text-lg">
									<div class="flex">
										<span class="p-3">${article.body}</span>
									</div>
									<div>
										<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
											<c:set var="fileNo" value="${String.valueOf(inputNo)}"></c:set>
											<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}"></c:set>
											<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
												<div class="flex">
													<a href="${file.forPrintUri}" target="_blank" title="자세히 보기">
														<img class="w-60" src="${file.forPrintUri}" />
													</a>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="flex">
			<div class="flex justify-center w-full text-lg text-gray-700">
				<a href="/usr/article/list?boardCode=${boardCode}&page=1&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">처음</a>
				<a href="/usr/article/list?boardCode=${boardCode}&page=${printPageIndexDown}&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">이전</a>
				<c:forEach items='${printPageIndexs}' var='printPageIndex'>
					<c:choose>
						<c:when test="${printPageIndex == page}">
							<a href="/usr/article/list?boardCode=${boardCode}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 text-black underline">${printPageIndex}</a>
						</c:when>
						<c:otherwise>
							<a href="/usr/article/list?boardCode=${boardCode}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">${printPageIndex}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<a href="/usr/article/list?boardCode=${boardCode}&page=${printPageIndexUp}&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">다음</a>
				<a href="/usr/article/list?boardCode=${boardCode}&page=1000000&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">끝</a>
			</div>
		</div>
		<form action="list" method="get" class="flex justify-center">
			<input type="hidden" name="boardCode" value="${boardCode}">
			<select name="searchType" class="border text-gray-700">
				<option value="titleAndBody">제목+내용</option>
				<option value="title">제목</option>
				<option value="nickname">작성자</option>
			</select>
			<input type="text" name="searchKeyword" class="border w-60 border-gray-300"/>
			<input type="submit" value="검색" class="w-16 bg-blue-300 hover:bg-blue-500"/>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>