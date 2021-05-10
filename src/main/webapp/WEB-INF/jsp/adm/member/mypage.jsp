<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.util.Util"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="flex justify-center">
	<div>
		<span class="flex items-center justify-center h-20 text-4xl font-bold">마이페이지</span>
		<div class="border-t-2 border-b-2">
			<div class="flex">
				<img alt="" src="프로필사진" class="w-40 h-40 rounded-full bg-gray-300">
				<div class="mx-4 my-2 w-96">
					<div class="flex justify-between">
						<span class="text-4xl">${loginedMember.nickname} (${loginedMember.ID})</span>
						<div class="flex justify-center items-center">
							<a href="adm/member/update" class="p-1 rounded-full text-sm bg-gray-300 hover:bg-blue-300">회원수정</a>
						</div>
					</div>
					<div class="text-lg">${loginedMember.authName}</div>
					<div class="text-lg">${loginedMember.email}</div>
					<div class="text-lg">${loginedMember.phoneNo}</div>
					<div class="text-lg">authKey : ${loginedMember.authKey}</div>
				</div>
			</div>
			<div class="flex justify-center text-xl font-bold">
				<div class="text-center border-b w-44">게시물</div>
				<div class="text-center border-b mx-4 w-44">메모</div>
				<div class="text-center border-b w-44">댓글</div>
			</div>
			<div class="flex justify-center text-xl">
				<div class="text-center border-b w-44">
					<a href="mypage?call=article" class="hover:underline">${Util.numberFormat(articleCnt)}</a>
				</div>
				<div class="text-center border-b mx-4 w-44">
					<a href="mypage?call=memo" class="hover:underline">${Util.numberFormat(memoCnt)}</a>
				</div>
				<div class="text-center border-b w-44">
					<a href="mypage?call=reply" class="hover:underline">${Util.numberFormat(replyCnt)}</a>
				</div>
			</div>
			<div>
				<div class="flex border-b-2 mt-4">
					<span class="text-center w-96">제목</span>
					<span class="text-center w-40">작성일</span>
					<span class="text-center w-16">조회수</span>
				</div>
				<div class="flex">
					<div class="flex w-96">
						<span class="flex items-center justify-center w-16 text-sm">1</span>
						<span>title</span>
					</div>
					<span class="text-center w-40">regDate</span>
					<span class="text-center w-16">hit</span>
				</div>
				<div>
					<c:choose>
						<c:when test="${call == 'reply'}">
							<c:forEach var='reply' items='${itemsReply}'>
								<div>${reply.body}</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var='item' items='${items}'>
								<div>${item.title}</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
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
			<div class="flex justify-center items-center w-24">
				<input type="button" value="글쓰기" class="bg-blue-300 w-20 h-10 border hover:bg-blue-500 rounded" onclick="location.href='/adm/article/add?articleType=article'" />
			</div>
		</div>
			</div>
		</div>
	</div>
	
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>