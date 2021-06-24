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
			<a href="list?boardCode=${boardCode}">${article.boardName}</a>
		</div>
		<div class="border-b-4 border-t-4 rounded border-blue-700">
			<div class="flex p-4">
				<div class="w-full">
					<div class="">
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
									<img src="${file.forPrintUrl}" alt="" class="w-16 h-16 rounded-full bg-gray-300" />
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
							<div class="border-b">
								<c:set var="fileNo" value="${String.valueOf(inputNo)}"></c:set>
								<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}"></c:set>
								<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
									<div>
										<a href="${file.forPrintUrl}" target="_blank" title="자세히 보기">
											<img class="w-60" src="${file.forPrintUrl}" />
										</a>
									</div>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div>
				<div class="flex border-b">
					<span class="flex w-full bg-gray-100 justify-center">댓글</span>
				</div>
				<div>
					<c:set var="replyCnt" value="3"></c:set>
					<c:forEach items='${replies}' var='reply'>
						<div class="flex items-center">
							<div>
								<span class="font-extrabold text-lg justify-center mr-2">${reply.nickname}</span>
							</div>
							<span>${reply.body}
								<span class="text-sm text-gray-500">${reply.regDate}</span>
							</span>
						</div>
					</c:forEach>
					<form action="doAddReply" method="post">
						<input type="hidden" name="aid" value="${article.aid}" />
						<div class="border rounded">
							<span class="flex mx-2">${loginedMember.nickname}</span>
							<input type="text" name="body" placeholder="댓글을 남겨보세요." class="w-full" autocomplete="off" />
							<div class="flex justify-end">
								<input type="submit" value="등록" class="px-1 rounded bg-white hover:bg-blue-300" />
							</div>
						</div>
					</form>
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