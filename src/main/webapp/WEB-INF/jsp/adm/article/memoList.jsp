<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.controller.AdmArticleController"%>

<c:set var="fileInputMaxCount" value="3" />

<section class="flex justify-center">
	<div>
		<c:choose>
			<c:when test="${boardCode == '31'}">
				<c:set var="boardName" value="웹" />
				<div class="flex items-center justify-center h-20 text-4xl font-bold">${boardName}</div>
			</c:when>
			<c:when test="${boardCode == '32'}">
				<c:set var="boardName" value="정보처리기사" />
				<div class="flex items-center justify-center h-20 text-4xl font-bold">${boardName}</div>
			</c:when>
			<c:otherwise>
				<c:set var="boardName" value="메모장" />
				<div class="flex items-center justify-center h-20 text-4xl font-bold">${boardName}</div>
			</c:otherwise>
		</c:choose>
		<div class="flex border-b-2 border-t-2 border-gray-500 text-center text-lg">
			<div class="Article-Width flex">
				<div class="w-96 bg-gray-100">제목</div>
				<div class="w-20">작성자</div>
				<div class="w-36 bg-gray-100">작성일</div>
				<div class="w-10">조회</div>
				<div class="w-32 bg-gray-100 border-l-2 border-gray-500">게시판</div>
			</div>
		</div>
		<div class="flex justify-center border-b-2 border-gray-500">
			<div class="w-full">
				<c:choose>
					<c:when test="${articlesCnt == 0}">
						<div class="flex h-full justify-center items-center">
							<span>게시물이 존재하지 않습니다. 크크루삥뽕</span>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="article" items="${articles}">
							<div class="border-b-2">
								<div class="mx-2 mt-1 text-sm mt-2 text-gray-500">
									<a href="/adm/article/list?boardCode=${article.boardCode}" class="">${article.boardName} ></a>
								</div>
								<div class="text-3xl border-gray-300">
									<a href="detail?aid=${article.aid}&boardCode=${article.boardCode}&articleType=memo" class="mx-2">${article.title}</a>
								</div>
								<div class="flex w-full items-center">
									<div class="mx-2">
										<!-- 사진을 갖고와서 넣어야댐 ㅎㅎ -->
										<img src="" alt="사진" class="w-10 h-10 rounded-full bg-gray-300" />
									</div>
									<div>
										<div class="">${article.nickname}</div>
										<div class="text-sm text-gray-500">${article.regDate}</div>
									</div>
								</div>
								<div class="border rounded mx-2 text-lg mb-2">
									<div class="m-2">${article.body}</div>
									<div>
										<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
											<c:set var="fileNo" value="${String.valueOf(inputNo)}"></c:set>
											<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}"></c:set>
											<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
												<div class="flex">
													<a href="${file.forPrintUrl}" target="_blank" title="자세히 보기">
														<img class="w-60" src="${file.forPrintUrl}" />
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
			<nav class="w-32 border-l-2 border-gray-500 flex-shrink-0">
				<ul>
					<a href="/adm/article/list?articleType=memo" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
						<span>메모장(${allArticlesCnt})</span>
					</a>
					<a href="/adm/article/list?boardCode=31&articleType=memo" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
						<span>웹</span>
					</a>
					<a href="/adm/article/list?boardCode=32&articleType=memo" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
						<span>정보처리기사</span>
					</a>
					<div class="pb-1"></div>
				</ul>
			</nav>
		</div>
		<div class="flex">
			<div class="w-24"> <!-- 공백용 -->
			</div>
			<div class="flex justify-center w-full text-lg text-gray-700">
				<a href="/adm/article/list?boardCode=${boardCode}&page=1&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">처음</a>
				<a href="/adm/article/list?boardCode=${boardCode}&page=${printPageIndexDown}&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">이전</a>
				<c:forEach items='${printPageIndexs}' var='printPageIndex'>
					<c:choose>
						<c:when test="${printPageIndex == page}">
							<a href="/adm/article/list?boardCode=${boardCode}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 text-black underline">${printPageIndex}</a>
						</c:when>
						<c:otherwise>
							<a href="/adm/article/list?boardCode=${boardCode}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">${printPageIndex}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<a href="/adm/article/list?boardCode=${boardCode}&page=${printPageIndexUp}&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">다음</a>
				<a href="/adm/article/list?boardCode=${boardCode}&page=1000000&searchType=${searchType}&searchKeyword=${searchKeyword}&articleType=memo" class="p-2 hover:text-black hover:underline">끝</a>
			</div>
			<div class="flex justify-center items-center w-24">
				<input type="button" value="글쓰기" class="bg-blue-300 w-20 h-10 border hover:bg-blue-500 rounded" onclick="location.href='/adm/article/add?boardCode=${boardCode}&articleType=memo'" />
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