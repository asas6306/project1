<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<section class="main-setting flex justify-center">
	<div class="flex justify-center container">
		<div class="max-w-5xl">
			<div>
				<div class="">
					<img src="/gen/home/banner/banner__1.jpg" />
				</div>
			</div>
			<div class="flex justify-center">
				<span class="text-2xl p-2">게시물 수</span>
			</div>
			<div class="grid grid-cols-2 gap-4 mx-2 py-2 border-2 border-blue-300 text-center">
				<div class="px-2 w-full">
					<div class="flex justify-center">
						<span class="w-24">게시판</span>
						<span class="px-2">:</span>
						<span class="w-24">${allArticleCnt}</span>
					</div>
					<c:forEach var="board" items="${articleCnt}">
						<div class="flex justify-center">
							<span class="w-24">${board.boardName}</span>
							<span class="px-2">:</span>
							<span class="w-24">${board.articlesCnt}</span>
						</div>
					</c:forEach>
				</div>
				<div class="px-2 w-full">
					<div class="flex justify-center">
						<span class="w-24">메모</span>
						<span class="px-2">:</span>
						<span class="w-24">${allMemoCnt}</span>
					</div>
					<c:forEach var="board" items="${memoCnt}">
						<div class="flex justify-center">
							<span class="w-24">${board.boardName}</span>
							<span class="px-2">:</span>
							<span class="w-24">${board.articlesCnt}</span>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>