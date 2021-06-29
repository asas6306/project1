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
	<div>
		<div class="flex items-center justify-center h-20 text-4xl font-bold">
			<a href="list?boardCode=${boardCode}">${article.boardName}</a>
		</div>
		<div class="flex border-b-2 border-t-2 border-gray-500 text-center">
			<div class="Article-Width">
				<div class="flex text-xl border-b">
					<span class="flex w-20 bg-gray-100 justify-center flex-shrink-0">제목</span>
					<span class="mx-2">${article.title}</span>
				</div>
				<div class="flex border-b">
					<div class="flex w-full">
						<span class="flex w-20 bg-gray-100 justify-center">작성자</span>
						<span class="mx-2 w-40 text-left">${article.nickname}</span>
					</div>
					<div class="flex">
						<sapn class="bg-gray-100 w-20">작성날짜</sapn>
						<sapn class="w-40">${article.regDate}</sapn>
						<sapn class="bg-gray-100 w-16">조회수</sapn>
						<sapn class="w-12">${article.hit}</sapn>
					</div>
					
				</div>
				<div class="flex border-b">
					<span class="flex w-20 bg-gray-100 items-center justify-center flex-shrink-0">내용</span>
					<span class="text-left mx-2 max-w-2xl my-4">${article.body}</span>
				</div>
				<div class="flex">
					<span class="flex w-20 bg-gray-100 justify-center">첨부파일</span>
					<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
						<div class="border-b">
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
						<input type="text" name="body" placeholder="댓글을 남겨보세요." class="w-full"/>
						<div class="flex justify-end">
							<input type="submit" value="등록" class="px-1 rounded bg-white hover:bg-blue-300" />
						</div>
					</div>
				</form>
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