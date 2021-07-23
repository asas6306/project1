<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<c:set var="fileInputMaxCount" value="3" />

<script>
function Delete__Article__Confirm()
{
	const result = confirm('정말로 삭제하시겠습니까?');
	
	if(result){
		location.href='delete?aid=${article.aid}&boardCode=${article.boardCode}';
	} 
}
</script>

  
<section class="flex justify-center">
	<div class="container lg:w-2/3 2xl:w-1/2">
		<div class="text-4xl font-bold p-3">
			<input type="button" value="<" onclick="history.back()" class="bg-white cursor-pointer"/>
			<a href="list?boardCode=${boardCode}">${article.boardName}</a>
		</div>
		<div class="border-b-4 border-t-4 rounded border-blue-700">
			<div class="flex p-4 border-b">
				<div class="w-full">
					<div>
						<span class="p-3 text-4xl">${article.title}</span>
					</div>
					<div class="flex border-b py-2">
						<div>
							<c:set var="file" value="${article.extra.file__common__profile['0']}"></c:set>
							<c:choose>
								<c:when test="${file == null}">
									<img src="/gen/member/non_profile.png?updateDate=2021-05-14 21:30:52" alt="" class="w-16 h-16 rounded-full bg-gray-300" />
								</c:when>
								<c:otherwise>
									<img src="${file.forPrintUri}" alt="" class="w-16 h-16 rounded-full bg-gray-300" />
								</c:otherwise>
							</c:choose>
						</div>
						<div class="flex justify-center items-center px-2">
							<div>
								<div>
									<span class="text-lg font-bold">${article.nickname}</span>
									<span class="text-gray-700 px-1">${article.authName}</span>
								</div>
								<div class="font-thin">
									<span>${article.regDate}</span>
									<span class="px-1">조회 ${article.hit}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="flex pt-4">
						<div>
							<span class="text-2xl font-thin">${article.body}</span>
						</div>
					</div>
					<div class="flex">
						<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
							<div>
								<c:set var="fileNo" value="${String.valueOf(inputNo)}"></c:set>
								<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}"></c:set>
								<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
									<div>
										<a href="${file.forPrintUri}" target="_blank" title="자세히 보기">
											<img class="w-60" src="${file.forPrintUri}" />
										</a>
									</div>
								</c:if>
							</div>
						</c:forEach>
					</div>
					<div class="flex justify-between items-center font-thin">
						<div class="flex">
							<div class="p-2">
								<a href="#" class="text-red-500 text-lg">
									<c:choose>
										<c:when test="false"><!-- 좋아요 눌렀다면 빨간하트 출력되게 -->
											<i class="fas fa-heart"></i>
										</c:when>
										<c:otherwise>
											<i class="far fa-heart"></i>
										</c:otherwise>
									</c:choose>
								</a>
								<a href=""><!-- 좋아요 리스트 출력 -->
									<span>좋아요</span>
									<span>${article.like}</span>
								</a>
							</div>
							<div class="p-2">
								<a class="text-lg">
									<i class="far fa-comment-dots"></i>
								</a>
								<span>댓글</span>
								<span>${replies.size()}</span>
							</div>
						</div>
						<div>
							<a href="" class="p-2">
								<i class="fas fa-share-square text-lg"></i>
								<span>공유</span>
							</a>
							<span> | </span>
							<a href="" class="p-2">신고</a>
						</div>
					</div>
				</div>
			</div>
			<div class="p-4">
				<div class="w-full">
					<div>
						<span class="text-xl">댓글</span>
					</div>
					<c:set var="replyCnt" value="3"></c:set>
					<c:forEach items='${replies}' var='reply'>
						<div class="flex border-b">
							<div class="p-2">
								<c:set var="file" value="${reply.extra.file__common__profile['0']}"></c:set>
								<c:choose>
									<c:when test="${file == null}">
										<img src="/gen/member/non_profile.png?updateDate=2021-05-14 21:30:52" alt="" class="w-12 h-12 rounded-full bg-gray-300" />
									</c:when>
									<c:otherwise>
										<img src="${file.forPrintUri}" alt="" class="w-12 h-12 rounded-full bg-gray-300" />
									</c:otherwise>
								</c:choose>
							</div>
							<div class="p-2">
								<div>
									<span class="text-lg">${reply.nickname}</span>
								</div>
								<div>
									<span class="font-thin">${reply.body}</span>
								</div>
								<div class="font-thin text-sm text-gray-700">
									<span>${reply.regDate}</span>
									<c:if test="${rq.loginedMemberUid == reply.uid}">
										<a href="" class="hover:text-blue-500 hover:underline">수정</a>
										<a href="" class="hover:text-red-500 hover:underline">삭제</a>
									</c:if>
								</div>
							</div>
						</div>
					</c:forEach>
					<form action="../reply/doAddReply" method="post">
						<input type="hidden" name="aid" value="${article.aid}" />
						<c:choose>
							<c:when test="${rq.isNotLogined()}">
								<span class="p-2 text-lg">댓글 작성기능은 로그인 후 이용하실 수 있습니다.</span>
							</c:when>
							<c:otherwise>
								<div class="border rounded">
									<span class="flex mx-2">${rq.loginedMember.nickname}</span>
									<input type="text" name="body" placeholder="댓글을 남겨보세요." class="outline-none w-full mx-2" autocomplete="off" />
									<div class="flex justify-end">
										<input type="submit" value="등록" class="px-1 rounded bg-white hover:bg-blue-300 mr-2 mb-2" />
									</div><!-- 스크립트로 입력 받았을 시 색 변화주는것 강의에도 있었던듯 찾아보그래이 -->
								</div>
							</c:otherwise>
						</c:choose>
					</form><!-- 깃헙 테스트 -->
				</div>
			</div>
		</div>
		<div class="flex justify-end mt-1">
			<input type="button" value="수정" onclick="location.href='update?aid=${article.aid}'" class="m-1 h-8 w-16 rounded bg-blue-300 hover:bg-blue-500" />
			<input type="button" value="삭제" onclick="Delete__Article__Confirm();" class="m-1 h-8 w-16 rounded bg-red-300 hover:bg-red-500" />
			<input type="button" value="목록으로" onclick="location.href='list?boardCode=${article.boardCode}'" class="m-1 h-8 w-16 rounded bg-gray-100 hover:bg-gray-300" />
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>