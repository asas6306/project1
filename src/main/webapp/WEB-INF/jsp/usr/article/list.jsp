<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

<section class="flex justify-center">
	<div class="container max-w-5xl w-full auto-cols-auto">
		<div>
			<div class="">
				<span class="flex text-4xl font-bold p-3">
					<c:choose>
						<c:when test="${boardCode == 0}">
							전체게시물
						</c:when>
						<c:otherwise>
							
						</c:otherwise>
					</c:choose>
				</span>
			</div>
			<div class="border-b-4 border-t-4 rounded border-blue-700">
				<c:forEach var="article" items="${articles}">
					<div class="border-b">
						<div class="flex">
							<div class="flex justify-center items-center w-12">
								<span class="text-sm">${article.aid}</span>
							</div>
							<div class="flex justify-center items-center">
								<span class="text-lg">${article.title}</span>
							</div>
						</div>
						<div class="grid grid-cols-2 lg:grid-cols-4 px-4 font-thin">
							<div class="flex">
								<span class="flex justify-center items-center text-sm">작성자 : </span>
								<span>&nbsp${article.nickname}</span>
							</div>
							<div class="flex">
								<span class="flex justify-center items-center text-sm">작성자 : </span>
								<span>&nbsp${article.nickname}</span>
							</div>
							<div class="flex">
								<span class="flex justify-center items-center text-sm">작성일 : </span>
								<span>&nbsp${Util.dateFormat(article.regDate)}</span>
							</div>
							<div class="flex">
								<span class="flex justify-center items-center text-sm">수정일 : </span>
								<span>&nbsp${Util.dateFormat(article.updateDate)}</span>
							</div>
						</div>
						<div>
							<div class="px-4">
								<span class="text-lg">${article.body}</span>
							</div>
						</div>
						<div class="grid grid-cols-2 px-4 font-thin">
							<div class="flex">
								<span class="flex justify-center items-center text-sm">조회수 : </span>
								<span>&nbsp${Util.numberFormat(article.hit)}</span>
							</div>
							<div class="flex">
								<span class="flex justify-center items-center text-sm">추천수 : </span>
								<span>&nbsp${Util.numberFormat(article.like)}</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>