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
			<div class="flex justify-between">
				<span class="flex items-center justify-center h-20 text-4xl font-bold px-1">마이페이지</span>
				<div class="flex justify-center items-center">
					<a href="authentication?page=update" class="p-1 h-7 rounded-full text-sm bg-blue-300 hover:bg-blue-500 flex-shrink-0">정보수정</a>
				</div>
			</div>
			<div class="flex border-t-4 border-blue-500 rounded p-2">
				<div class="p-2">
					<c:set var="file" value="${loginedMember.extra.file__common__profile['0']}"></c:set>
					<img alt="" src="${file.forPrintUri}" class="border w-32 h-32 sm:w-40 sm:h-40 rounded-full bg-gray-300">
				</div>
				<div class="p-2 text-xl">
					<div class="sm:flex text-4xl">
						<div>
							<span>${loginedMember.ID}</span>
						</div>
						<div>
							<span>(${loginedMember.nickname})</span>
						</div>
					</div>
					<div>
						<span>${loginedMember.authName}</span>
					</div>
					<div>
						<span>${loginedMember.email}</span>
					</div>
					<div>
						<span>${loginedMember.phoneNo}</span>
					</div>
					<div>
						<span>authKey : ${loginedMember.authKey}</span>
					</div>
				</div>
			</div>
			<div class="p-4">
				<div class="flex justify-center text-xl">
					<div class="flex justify-between w-4/5 sm:w-2/3 md:w-3/5">
						<div class="text-center border-b border-blue-300 w-16 sm:w-32">게시물</div>
						<div class="text-center border-b border-blue-300 w-16 sm:w-32">메모</div>
						<div class="text-center border-b border-blue-300 w-16 sm:w-32">댓글</div>
					</div>
				</div>
				<div class="flex justify-center text-xl">
					<div class="flex justify-between w-4/5 sm:w-2/3 md:w-3/5">
						<div class="text-center w-16 sm:w-32">
							<a href="mypage?call=article">${Util.numberFormat(articleCnt)}</a>
						</div>
						<div class="text-center w-16 sm:w-32">
							<a href="mypage?call=memo">${Util.numberFormat(memoCnt)}</a>
						</div>
						<div class="text-center w-16 sm:w-32">
							<a href="mypage?call=reply">${Util.numberFormat(replyCnt)}</a>
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
			<form action="myPageDoDelete" class="p-1">
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
					<div class="w-12 sm:inline sm:w-24"> <!-- 공백용 -->
					</div>
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
					<div class="sm:flex sm:justify-center sm:items-center hidden sm:w-24">
						<input type="submit" value="삭제하기" class="bg-red-300 p-1 border hover:bg-red-500 rounded" />
						<input type="button" value="글쓰기" class="bg-blue-300 p-1 border hover:bg-blue-500 rounded" onclick="location.href='/usr/article/add?articleType=article'" />
					</div>
					<div class="flex justify-center items-center sm:hidden w-12">
						<input type="submit" value="삭제" class="bg-red-300 p-1 border hover:bg-red-500 rounded" />
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>