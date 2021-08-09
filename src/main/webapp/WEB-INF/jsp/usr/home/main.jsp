<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<section class="main-setting flex justify-center">
	<div class="flex justify-center container">
		<div class="max-w-5xl">
			<div>
				<div class="">
					<img src="/gen/home/banner/banner__1.jpg" />
				</div>
			</div>
			<div class="flex mx-2">
				<div class="w-full">
					<div class="border-b-2 border-blue-300 px-2 py-1">
						<span class="text-xl">게시판</span>
					</div>
					<div>
						<c:forEach var="article" items="${articles}">
							<div>${article.title}</div>
						</c:forEach>
					</div>
				</div>
				<div class="w-full">
					<div class="border-b-2 border-blue-300 px-2 py-1">
						<span class="text-xl">메모장</span>
					</div>
					<div>
						<c:forEach var="article" items="${articlesOfMemo}">
							${article.title}
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>