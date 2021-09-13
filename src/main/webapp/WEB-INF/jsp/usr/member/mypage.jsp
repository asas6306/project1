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

<script>
function del__checkAll(btn) {
	if(btn.checked) {
		for(let i = 1; i <= 20; i++) {
			if(document.getElementsByName("delete__" + i)[0].getAttribute('type') == 'checkbox'){
	            document.getElementsByName("delete__" + i)[0].checked = true;
	        }
		}
	} else {
		for(let i = 1; i <= 20; i++) { 
			if(document.getElementsByName("delete__" + i)[0].getAttribute('type') == 'checkbox'){
	            document.getElementsByName("delete__" + i)[0].checked = false;
	        }
			//더 나은 방법은 ?
			//$(btn).closest('.mypage-width').find(' > input[name=delete__0]').removeAttr("checked");
			//$find(':input[name=delete__0]').removeAttr("checked");
			//.attr("checked", "checked")
		}
	}
}
</script>

<section class="base-higth flex justify-center">
	<div class="mypage-width">
		<div>
			<div class="flex justify-between">
				<span class="flex items-center justify-center h-20 text-4xl font-bold px-1">마이페이지</span>
				<div class="flex justify-center items-center">
					<a href="../member/authentication?afterUri=${Util.getUriEncoded('../member/update')}" class="p-1 h-7 rounded-full text-sm bg-blue-300 hover:bg-blue-500 flex-shrink-0">
						<i class="fas fa-user-edit"></i>
						<span>정보수정</span>
					</a>
				</div>
			</div>
			<div class="flex border-t-4 border-blue-500 rounded p-2">
				<div class="p-2">
					<img src="${rq.loginedMember.profileImgUri}" onerror="${rq.loginedMember.profileFallbackImgOnErrorHtmlAttr}" class="border w-32 h-32 sm:w-40 sm:h-40 rounded-full bg-gray-300">
				</div>
				<div class="p-2 text-xl">
					<div class="sm:flex text-4xl">
						<div>
							<span>${rq.loginedMember.ID}</span>
						</div>
						<div>
							<span>(${rq.loginedMember.nickname})</span>
						</div>
					</div>
					<div>
						<span>${rq.loginedMember.authName}</span>
					</div>
					<div>
						<span>${rq.loginedMember.email}</span>
					</div>
					<div>
						<span>${rq.loginedMember.phoneNo}</span>
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
		<div class="flex justify-between pr-2">
			<div class="flex items-center">
				<div class="px-1">
					<input type="checkbox" name="del__checkAll" value="Y" onchange="del__checkAll(this)" />
				</div>
				<div>
					<c:choose>
						<c:when test="${param.call == 'memo'}"><span class="text-2xl">메모</span></c:when>
						<c:when test="${param.call == 'reply'}"><span class="text-2xl">댓글</span></c:when>
						<c:otherwise><span class="text-2xl">게시물</span></c:otherwise>
					</c:choose>
				</div>
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
			<form action="mypageDoDelete" class="p-1">
			<input type="hidden" name="call" value="${param.call}" />
				<div class="flex border-b-4 border-blue-500 rounded">
					<div>
						<c:forEach begin="1" end="${items.size()}" var="num">
							<div class="flex items-center h-7">
								<c:choose>
									<c:when test="${param.call == 'reply'}">
										<input type="checkbox" name="delete__${num}" class="flex justify-center items-center h-6" value="${items.get(num-1).rid}"/>
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="delete__${num}" class="flex justify-center items-center h-6" value="${items.get(num-1).aid}"/>
									</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</div>
					<div class="w-full">
						<c:if test="${items.size() == 0}">
							<div class="flex justify-center">
								<span class="text-2xl font-bold p-8">게시물이 존재하지 않습니당 ㅎㅎ!</span>
							</div>
						</c:if>
						
						<c:forEach var="item" items="${items}">
							<div class="flex items-center border-b h-7">
								<div class="w-full text-lg font-thin px-2">
									<c:choose>
										<c:when test="${param.call == 'reply'}">
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