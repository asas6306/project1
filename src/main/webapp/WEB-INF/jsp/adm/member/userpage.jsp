<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.util.Util"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.example.demo.util.Util"%>

<script>
function Delete__Articles__Confirm() {
	const result = confirm('정말로 삭제하시겠습니까?');
	if(result){
		onSuccess();
		return;
	}
}
</script>

<section class="base-higth flex justify-center">
	<div class="mypage-width">
		<div>
			<div class="flex">
				<span class="flex items-center justify-center h-20 text-4xl font-bold px-1">유저페이지</span>
			</div>
			<div class="flex border-t-4 border-blue-500 rounded p-2">
				<div class="p-2 flex-shrink-0">
					<img src="${member.profileImgUri}" onerror="${member.profileFallbackImgOnErrorHtmlAttr}" class="border w-32 h-32 sm:w-40 sm:h-40 rounded-full bg-gray-300">
				</div>
				<div class="p-2 text-xl w-full">
					<div class="flex justify-between text-4xl">
						<div class="sm:flex">
							<div>
								<span>${member.ID}</span>
							</div>
							<div>
								<span>(${member.nickname})</span>
							</div>
						</div>
						<div class="flex items-center">
							<a href="userUpdate?uid=${member.uid}" class="bg-blue-300 hover:bg-blue-500 rounded-full p-1 text-sm">회원수정</a>
						</div>
					</div>
					<div>
						<span>${member.authName}</span>
					</div>
					<div class="w-min p-2 hidden sm:block">
						<div class="flex text-xl">
							<div class="flex grid-cols-3">
								<div class="text-center border-b border-blue-300 w-32">
									<a href="userpage?uid=${param.uid}&call=article">게시물</a>
								</div>
								<div class="text-center border-b border-blue-300 w-32">
									<a href="userpage?uid=${param.uid}&call=memo">메모</a>
								</div>
								<div class="text-center border-b border-blue-300 w-32">
									<a href="userpage?uid=${param.uid}&call=reply">댓글</a>
								</div>
							</div>
						</div>
						<div class="flex text-xl">
							<div class="flex grid-cols-3">
								<div class="text-center w-32">
									<a href="userpage?uid=${param.uid}&call=article">${Util.numberFormat(articleCnt)}</a>
								</div>
								<div class="text-center w-32">
									<a href="userpage?uid=${param.uid}&call=memo">${Util.numberFormat(memoCnt)}</a>
								</div>
								<div class="text-center w-32">
									<a href="userpage?uid=${param.uid}&call=reply">${Util.numberFormat(replyCnt)}</a>
								</div>
							</div>
						</div>
					</div>
					<div class="sm:hidden p-2 w-36">
						<div class="flex">
							<span class="w-16 text-right">게시물 : </span>
							<span>
								<a href="userpage?uid=${param.uid}&call=article">&nbsp${Util.numberFormat(articleCnt)}</a>
							</span>
						</div>
						<div class="flex">
							<span class="w-16 text-right">메모 : </span>
							<span>
								<a href="userpage?uid=${param.uid}&call=memo">&nbsp${Util.numberFormat(memoCnt)}</a>
							</span>
						</div>
						<div class="flex">
							<span class="w-16 text-right">댓글 : </span>
							<span>
								<a href="userpage?uid=${param.uid}&call=reply">&nbsp${Util.numberFormat(replyCnt)}</a>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="flex justify-between px-2">
			<div>
				<c:choose>
					<c:when test="${call == 'article'}"><span class="text-2xl">게시물</span></c:when>
					<c:when test="${call == 'memo'}"><span class="text-2xl">메모</span></c:when>
					<c:when test="${call == 'reply'}"><span class="text-2xl">댓글</span></c:when>
				</c:choose>
			</div>
			<div class="flex justify-center items-end text-sm font-thin text-center invisible sm:visible px-1">
				<div class="hidden sm:inline sm:visible sm:w-16 text-thin">
					<span>작성일</span>
				</div>
				<c:if test="${call != 'reply'}">
					<div class="hidden sm:inline sm:w-8 text-thin">
						<span>조회</span>
					</div>
				</c:if>
			</div>
		</div>
		<div class="border-t-2 border-blue-500">
			<div class="border-b-4 border-blue-500 rounded">
				<c:forEach var="item" items="${items}">
					<div class="flex items-center border-b">
						<div class="">
							<c:choose>
								<c:when test="${call == 'reply'}">
									<input type="checkbox" name="delete__${num}" class="flex justify-center items-center" value="${item.rid}"/>
								</c:when>
								<c:otherwise>
									<input type="checkbox" name="delete__${num}" class="flex justify-center items-center" value="${item.aid}"/>
								</c:otherwise> 
							</c:choose>
						</div>
						<div class="w-full text-lg font-thin px-2">
							<c:choose>
								<c:when test="${call == 'reply'}">
									<div class="w-full sm:flex sm:justify-between">
										<div>
											<span class="text-base">${Util.numberFormat(item.rid)}</span>
											<span class="text-xl">${item.body}</span>
										</div>
										<div class="grid grid-cols-2 sm:flex sm:justify-center sm:items-center text-sm sm:text-center">
											<div class="sm:w-16">
												<span class="sm:hidden">등록일 : </span>
												<span>${Util.dateFormat(item.regDate)}</span>
											</div>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="w-full sm:flex sm:justify-between">
										<div>
											<span class="text-base">${Util.setBoardName(item.boardName)}</span>
											<span class="text-xl">${item.title}</span>
										</div>
										<div class="grid grid-cols-2 sm:flex sm:justify-center sm:items-center text-sm sm:text-center">
											<div class="sm:w-16">
												<span class="sm:hidden">등록일 : </span>
												<span>${Util.dateFormat(item.regDate)}</span>
											</div>
											<div class="sm:w-8">
												<span class="sm:hidden">조회수 : </span>
												<span>${Util.numberFormat(item.hit)}</span>
											</div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="flex">
				<div class="flex justify-center w-full text-lg text-gray-700">
					<a href="/usr/member/mypage?page=1&call=${call}" class="p-2 hover:text-black hover:underline">처음</a>
					<a href="/usr/member/mypage?page=${printPageIndexDown}&call=${call}" class="p-2 hover:text-black hover:underline">이전</a>
					<c:forEach items='${printPageIndexs}' var='printPageIndex'>
						<c:choose>
							<c:when test="${printPageIndex == page}">
								<a href="/usr/member/mypage?page=${printPageIndex}&call=${call}" class="p-2 text-black underline">${printPageIndex}</a>
							</c:when>
							<c:otherwise>
								<a href="/usr/member/mypage?page=${printPageIndex}&call=${call}" class="p-2 hover:text-black hover:underline">${printPageIndex}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<a href="/usr/member/mypage?page=${printPageIndexUp}&call=${call}" class="p-2 hover:text-black hover:underline">다음</a>
					<a href="/usr/member/mypage?page=1000&call=${call}" class="p-2 hover:text-black hover:underline">끝</a>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>