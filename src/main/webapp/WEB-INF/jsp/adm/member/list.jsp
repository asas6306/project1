<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

<section class="section-1 base-higth flex justify-center">
	<div>
		<div class="flex items-center justify-center h-20 text-4xl font-bold">회원관리</div>
		<div class="flex border-b-2 border-t-2 border-gray-500 text-center text-lg">
			<div class="Article-Width flex items-center bg-gray-100">
				<span class="w-16 text-base">회원번호</span>
				<span class="w-16 mr-4"></span>
				<span class="w-32 text-left">ID(닉네임)</span>
				<span class="w-20">권한</span>
				<span class="w-48">연락처</span>
				<span class="w-24 mr-2">가입일</span>
				<div class="w-32 bg-gray-100 border-l-2 border-gray-500">게시판</div>
			</div>
		</div>
		<div class="flex justify-center border-b-2 border-gray-500">
			<div class="w-full">
				<c:choose>
					<c:when test="${membersCnt == 0}">
						<div class="flex h-full justify-center items-center">
							<span>회원이 존재하지 않습니다. 크크루삥뽕</span>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach items='${members}' var='member'>
							
							<c:set var="memberAuthLevel" value="${String.valueOf(member.authLevel)}" />
							<div class="flex items-center border-b h-20">
								<span class="text-center w-16 text-xl">${member.uid}</span>
								<img src="${member.profileImgUri}" onerror="${member.profileFallbackImgOnErrorHtmlAttr}" class="h-16 w-16 mr-4 border rounded-full" />
								<a href="userpage?uid=${member.uid}" class="text-lg w-32">
									<span>${member.ID}</span>
									<div>(${member.nickname})</div>
								</a>
								<span class="w-20">${member.authName}</span>
								<div class="w-48 text-center ">
									<span>${member.email}</span>
									<div>${member.phoneNo}</div>
								</div>
								<div class="text-center w-24 mr-2">${Util.dateFormat(member.regDate)}</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<nav class="w-32 border-l-2 border-gray-500 flex-shrink-0">
				<ul>
					<a href="/adm/member/list" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
						<span>전체회원(${allMembersCnt})</span>
					</a>
					<c:forEach var='auth' items='${auths}'>
						<a href="/adm/member/list?authLevel=${auth.authLevel}" class="flex justify-center items-center text-gray-700 h-8 hover:text-black">
							<span>${auth.authName}</span>
						</a>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<div class="flex">
			<div class="w-24"> <!-- 공백용 -->
			</div>
			<div class="flex justify-center w-full text-lg text-gray-700">
				<a href="/adm/member/list?authLevel=${authLevel}&page=1&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">처음</a>
				<a href="/adm/member/list?authLevel=${authLevel}&page=${printPageIndexDown}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">이전</a>
				<c:forEach items='${printPageIndexs}' var='printPageIndex'>
					<c:choose>
						<c:when test="${printPageIndex == page}">
							<a href="/adm/member/list?authLevel=${authLevel}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 text-black underline">${printPageIndex}</a>
						</c:when>
						<c:otherwise>
							<a href="/adm/member/list?authLevel=${authLevel}&page=${printPageIndex}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">${printPageIndex}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<a href="/adm/member/list?authLevel=${authLevel}&page=${printPageIndexUp}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">다음</a>
				<a href="/adm/member/list?authLevel=${authLevel}&page=1000000&searchType=${searchType}&searchKeyword=${searchKeyword}" class="p-2 hover:text-black hover:underline">끝</a>
			</div>
			<div class="w-24">
			</div>
		</div>
		<div class="search-box-member">
			<form action="list" method="get" class="flex justify-center">
				<input type="hidden" name="authLevel" value="${authLevel}">
				<select name="searchType" class="border text-gray-700">
					<option value="ID">아이디</option>
					<option value="nickname">닉네임</option>
					<option value="phoneAndEmail">연락처</option>
				</select>
				<script>
						$('.search-box-member form [name="searchType"]').val('${searchType}')
				</script>
				<input type="text" name="searchKeyword" class="border w-60 border-gray-300"/>
				<input type="submit" value="검색" class="w-16 bg-blue-300 hover:bg-blue-500"/>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>