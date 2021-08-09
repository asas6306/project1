<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.example.demo.util.Util"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<section class="main-setting flex justify-center">
	<div class="flex justify-center container">
		<div class="max-w-5xl">
			<div>
				<div class="">
					<img src="/gen/home/banner/banner__1.jpg" />
				</div>
			</div>
			<div class="flex mx-2 py-2">
				<div class="w-full">
					<div class="flex">
						<a class="w-full border-b-2 border-blue-300 px-2 py-1 text-xl">
							<i class="far fa-list-alt"></i>
							<span>게시판</span>
						</a>
					</div>
					<div class="text-lg font-thin pt-1">
						<c:forEach var="article" items="${articles}">
							<div class="flex">
								<a href="../article/list?boardCode=${article.boardCode}" class="text-center w-12">${Util.setBoardName(article.boardName)}</a>
								<a href="../article/detail?aid=${article.aid}">${article.title}</a>
							</div> <!-- 한 라인 초과되는 부분 ...으로 표시 -->
						</c:forEach>
					</div>
				</div>
				<div class="w-full">
					<div class="flex">
						<a class="w-full border-b-2 border-blue-300 px-2 py-1 text-xl">
							<i class="fas fa-list-ul"></i>
							<span>메모장</span>
						</a>
					</div>
					<div class="text-lg font-thin pt-1">
						<c:forEach var="article" items="${articlesOfMemo}">
							<div class="flex">
								<a href="../article/list?articleType=memo&boardCode=${article.boardCode}" class="text-center w-12">${Util.setBoardName(article.boardName)}</a>
								<a href="../article/detail?aid=${article.aid}">${article.title}</a>
							</div> <!-- 한 라인 초과되는 부분 ...으로 표시 -->
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>