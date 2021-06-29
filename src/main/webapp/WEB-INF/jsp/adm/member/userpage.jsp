<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.util.Util"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="base-higth flex justify-center">
	<div>
		<span class="flex items-center justify-center h-20 text-4xl font-bold">유저페이지</span>
		<div class="userpage-width border-t-2 border-b-2">
			<div class="flex">
				<c:set var="file" value="${member.extra.file__common__profile['0']}"></c:set>
				<img alt="" src="${file.forPrintUri}" class="w-40 h-40 border rounded-full bg-gray-300">
				<div class="mx-4 my-2 w-96">
					<div class="flex justify-between">
						<span class="text-4xl">${member.nickname} (${member.ID})</span>
						<div class="flex justify-center items-center">
							<a href="userUpdate?uid=${member.uid}" class="p-1 rounded-full text-sm bg-gray-300 hover:bg-blue-300">정보수정</a>
						</div>
					</div>
					<div class="text-lg">${member.authName}</div>
					
				</div>
			</div>
			<div>
				<c:choose>
					<c:when test="${call == 'reply'}">
						<div class="flex justify-center border-b-2 mt-4">
							<span class="text-center w-96">제목</span>
							<span class="text-center w-12"></span>
							<span class="text-center w-40">작성일</span>
						</div>
					</c:when>
					<c:otherwise>
						<div class="flex justify-center border-b-2 mt-4">
							<span class="text-center w-96">제목</span>
							<span class="text-center w-40">작성일</span>
							<span class="text-center w-12">조회수</span>
						</div>
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="call" value="${call}" />
				<div>
					<c:choose>
						<c:when test="${call == 'reply'}">
							<c:forEach var='item' items='${items}'>
								<div class="flex justify-center">
									<div class="flex h-6 w-96">
										<span class="flex items-center justify-center w-12 text-sm">${item.rid}</span>
										<a href="../article/detail?aid=${item.relId}">${item.body}</a>
									</div>
									<span class="text-center w-12"></span>
									<span class="text-center w-40">${Util.dateFormat(item.regDate)}</span>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var='item' items='${items}'>
								<div class="flex justify-center">
									<div class="flex w-96">
										<span class="flex items-center justify-center w-12 text-sm">${item.aid}</span>
										<a href="../article/detail?aid=${item.aid}">${item.title}</a>
									</div>
									<span class="text-center w-40">${Util.dateFormat(item.regDate)}</span>
									<span class="text-center w-12">${item.hit}</span>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="flex">
				<div class="w-24"> <!-- 공백용 -->
				</div>
				<div class="flex justify-center w-full text-lg text-gray-700">
					<a href="/adm/member/mypage?page=1&call=${call}" class="p-2 hover:text-black hover:underline">처음</a>
					<a href="/adm/member/mypage?page=${printPageIndexDown}&call=${call}" class="p-2 hover:text-black hover:underline">이전</a>
					<c:forEach items='${printPageIndexs}' var='printPageIndex'>
						<c:choose>
							<c:when test="${printPageIndex == page}">
								<a href="/adm/member/mypage?page=${printPageIndex}&call=${call}" class="p-2 text-black underline">${printPageIndex}</a>
							</c:when>
							<c:otherwise>
								<a href="/adm/member/mypage?page=${printPageIndex}&call=${call}" class="p-2 hover:text-black hover:underline">${printPageIndex}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<a href="/adm/member/mypage?page=${printPageIndexUp}&call=${call}" class="p-2 hover:text-black hover:underline">다음</a>
					<a href="/adm/member/mypage?page=1000&call=${call}" class="p-2 hover:text-black hover:underline">끝</a>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>