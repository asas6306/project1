<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<section class="flex justify-center">
	<div>
		<c:choose>
			<c:when test="${boardCode == '1'}">
				<c:set var="boardName" value="공지사항" />
				<div class="flex items-center justify-center h-20 text-4xl font-bold">${boardName}</div>
			</c:when>
			<c:when test="${boardCode == '2'}">
				<c:set var="boardName" value="자유게시판" />
				<div class="flex items-center justify-center h-20 text-4xl font-bold">${boardName}</div>
			</c:when>
			<c:otherwise>
				<c:set var="boardName" value="전체글보기" />
				<div class="flex items-center justify-center h-20 text-4xl font-bold">${boardName}</div>
			</c:otherwise>
		</c:choose>
		<div class="flex border-b-2 border-t-2 border-gray-500 text-center text-lg">
			<div class="flex w-full">
				<div class="w-96 bg-gray-100">제목</div>
				<div class="w-20">작성자</div>
				<div class="w-36 bg-gray-100">작성일</div>
				<div class="w-10">조회</div>
			</div>
			<div class="w-32 bg-gray-100 border-l-2 border-gray-500 flex-shrink-0">게시판</div>
		</div>
		<div class="flex justify-center border-b-2 border-gray-500">
			<div class="w-full">
				<c:choose>
					<c:when test="${articles.size() == 0}">
						<div class="flex h-full justify-center items-center">
							<span>게시물이 존재하지 않습니다.</span>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach items='${articles}' var='article'>
							<c:set var="detailUrl" value="detail?aid=${article.aid}" />
						<c:set var="thumbFileNo" value="${String.valueOf(1)}" />
						<c:set var="thumbFile" value="${article.extra.file__common__attachment[thumbFileNo]}" />
						<c:set var="thumbUrl" value="${thumbFile.getForPrintUrl()}" />
							<div class="flex border-b">
								<div class="w-96 flex">
									<c:choose>
										<c:when test="${boardCode ==  0}">
											<a href="list?boardCode=${article.boardCode}" class="text-center w-20 bg-gray-100 hover:underline">${article.boardName}</a>
										</c:when>
										<c:otherwise>
											<span class="text-center w-20 bg-gray-100">${article.aid}</span>
										</c:otherwise>
									</c:choose>
									&nbsp&nbsp
									<a href="${detailUrl}" class="hover:underline">${article.title}
										<c:if test="${thumbUrl != null}">
											<i class="far fa-image text-gray-700" ></i>
										</c:if>
									</a>
								</div>
								<div class="bg-gray-100 text-center w-20">${article.nickname}</div>
								<div class="text-center w-36">${article.regDate}</div>
								<div class="bg-gray-100 text-center w-10">${article.hit}</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<nav class="w-32 border-l-2 border-gray-500 flex-shrink-0">
				<ul>
					<a href="/adm/article/list" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
						<span>전체글보기(${allArticlesCnt})</span>
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
		<div class="flex">
			<div class="w-24"> <!-- 공백용 -->
			</div>
			<div class="flex justify-center w-full text-lg text-gray-700">
				<a href="/adm/article/list?boardCode=${boardCode}&page=1&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">처음</a>
				<a href="/adm/article/list?boardCode=${boardCode}&page=${printPageIndexDown}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">이전</a>
				<c:forEach items='${printPageIndexs}' var='printPageIndex'>
					<c:choose>
						<c:when test="${printPageIndex == page}">
							<a href="/adm/article/list?boardCode=${boardCode}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 text-black underline">${printPageIndex}</a>
						</c:when>
						<c:otherwise>
							<a href="/adm/article/list?boardCode=${boardCode}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">${printPageIndex}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<a href="/adm/article/list?boardCode=${boardCode}&page=${printPageIndexUp}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">다음</a>
				<a href="/adm/article/list?boardCode=${boardCode}&page=1000000&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">끝</a>
			</div>
			<div class="flex justify-center items-center w-24">
				<input type="button" value="글쓰기" class="bg-blue-300 w-20 h-10 border hover:bg-blue-500 rounded" onclick="location.href='/adm/article/add?boardCode=${boardCode}'" />
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