<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<c:set var="fileInputMaxCount" value="3" />

<script>
let ReplyWrite__submitFormDone = false;
function ReplyWrite__submitForm(form) {
	if ( ReplyWrite__submitFormDone ) {
		return;
	}
	form.body.value = form.body.value.trim();
	if ( form.body.value.length == 0 ) {
		alert('내용을 입력해주세요.');
		form.body.focus();
		return;
	}
	form.submit();
	ReplyWrite__submitFormDone = true;
}
</script>

<script>
let ReplyUpdate__submitFormDone = false;
function ReplyUpdate__submitForm(form) {
	if ( ReplyWrite__submitFormDone ) {
		return;
	}
	form.body.value = form.body.value.trim();
	if ( form.body.value.length == 0 ) {
		alert('내용을 입력해주세요.');
		form.body.focus();
		return;
	}
	form.submit();
	ReplyUpdate__submitFormDone = true;
}
</script>

<script>
function Delete__Article__Confirm()
{
	const result = confirm('정말로 삭제하시겠습니까?');
	
	if(result){
		location.href='delete?aid=${article.aid}&boardCode=${article.boardCode}';
	}
}
</script>

<script>
function Delete__Reply__Confirm(btn)
{
	const result = confirm('정말로 삭제하시겠습니까?');
	
	if(result){
		const $clicked = $(btn);
		const $target = $clicked.closest('[data-id]');
		const rid = $target.attr('data-id');
		
		$.post(
			'../reply/doDeleteAjax',
			{
				rid: rid
			},
			function(data) {
				if ( data.success ) {
					$target.remove();
				}
				else {
					if ( data.msg ) {
						alert(data.msg);
					}
					$clicked.text('삭제실패');
				}
			},
			'json'
		);
	}
}
</script>

<script>
function ReplyList__goToReply(btn) {
	const $target = $('.repliesList');
	const targetOffset = $target.offset().top;
	$(window).scrollTop(targetOffset);
}
</script>

<script>
function ReplyForm__changeSubmit() {
	const form = $('.formAddReply').get(0);
	
	form.body.value = form.body.value.trim();
	if(form.body.value.length > 0) {
		// 입력버튼 활성화 등등
	}
}
		
$(function() {
	$('.replyInput').keyup(ReplyForm__changeSubmit);
});
</script>

<script>
function resize(obj) {
	  var textEle = $(obj);
	  textEle[0].style.height = 'auto';
	  var textEleHeight = textEle.prop('scrollHeight');
	  textEle.css('height', textEleHeight);
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
							<img src="${article.writerProfileImgUri}" onerror="${article.writerProfileFallbackImgOnErrorHtmlAttr}" class="w-16 h-16 rounded-full bg-gray-300" />
						</div>
						<div class="flex justify-center items-center px-2">
							<div>
								<div>
									<span class="text-lg font-bold">${article.nickname}</span>
									<span class="text-gray-700 px-1">${article.authName}</span>
								</div>
								<div class="font-thin flex">
									<span>${article.regDate}</span>
									<span class="px-3">조회 ${article.hit}</span>
									<span class="cursor-pointer" onclick="ReplyList__goToReply(this);">댓글 ${replies.size()}</span>
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
					<div class="likeAct font-thin">
						<div class="flex justify-between items-center">
							<div class="flex">
							<div class="p-2">
								<a href="doLike?aid=${article.aid}&isLike=${isLike}" class="text-red-500 text-lg">
									<c:choose>
										<c:when test="${isLike}">
											<i class="fas fa-heart"></i>
										</c:when>
										<c:otherwise>
											<i class="far fa-heart"></i>
										</c:otherwise>
									</c:choose>
								</a>
								<input type="button" class="bg-white font-thin cursor-pointer" value="좋아요 ${likes.size()}" onclick="Article__Like(this)" >
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
						<div class="likeListForm hidden flex">
							<c:forEach var="like" items="${likes}">
								<div class="mx-1">
									<div class="flex justify-center">
										<img src="${like.likerProfileImgUri}" onerror="${like.likerProfileFallbackImgOnErrorHtmlAttr}" class="w-12 h-12 rounded-full bg-gray-500" />
									</div>
									<div class="flex justify-center">
										<span>${like.nickname}</span>
									</div>
								</div>
							</c:forEach>
						</div>
						<script>
						function Article__Like(btn) {
							const $clicked = $(btn);
							const target = $clicked.closest('.likeAct').find('.likeListForm');
							if(btn.name == 'true') {
								btn.name = false;
								target.css('display', 'none');
							} else {
								btn.name = true;
								target.css('display', 'flex');
							}
						}
						</script>
					</div>
				</div>
			</div>
			<div class="p-4">
				<div class="w-full">
					<div class="repliesList">
						<span class="text-xl">댓글</span>
					</div>
					<c:set var="replyCnt" value="3"></c:set>
					<c:forEach items='${replies}' var='reply'>
						<div data-id="${reply.rid}" class="flex border-b">
							<div class="p-2">
								<c:set var="file" value="${reply.extra.file__common__profile['0']}"></c:set>
								<img src="${file.forPrintUri}" onerror="${article.writerProfileFallbackImgOnErrorHtmlAttr}" class="w-12 h-12 rounded-full bg-gray-300" />
							</div>
							<div class="p-2 w-full">
								<div>
									<span class="text-lg">${reply.nickname}</span>
								</div>
								<div>
									<div>
										<span class="font-thin">${reply.body}</span>
									</div>
									<div class="rep font-thin text-sm text-gray-700">
										<span>${reply.regDate}</span>
										<c:if test="${rq.loginedMemberUid == reply.uid}">
											<a onclick="Reply__Update(this)" class="hover:text-blue-500 hover:underline cursor-pointer">수정</a>
											<a onclick="Delete__Reply__Confirm(this); return false;" class="hover:text-red-500 hover:underline cursor-pointer">삭제</a>
											<div class="replyUpdateForm hidden">
												<form action="../reply/doUpdate" class="formUpdateReply w-full" method="post" onsubmit="ReplyUpdate__submitForm(this); return false;">
													<input type="hidden" name="rid" value="${reply.rid}" />
													<textarea onkeydown="resize(this)" onkeyup="resize(this)" name="body" class="w-full border rounded outline-none">${reply.body}</textarea>
													<div class="flex justify-end gap-1">
														<input type="submit" value="수정" class="bg-blue-300 hover:bg-blue-500 rounded py-1 px-2">
														<input type="button" onclick="Reply__Update(this)" value="취소" class="bg-red-300 hover:bg-red-500 rounded py-1 px-2">
													</div>
												</form>
											</div>
											<script>
											function Reply__Update(btn) {
												const $clicked = $(btn);
												const target = $clicked.closest('.rep').find('.replyUpdateForm');
												if(btn.value == '취소')
													target.css('display', 'none');
												else
													target.css('display', 'flex');
											}
											</script>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<form action="../reply/doAdd" class="formAddReply" method="post" onsubmit="ReplyWrite__submitForm(this); return false;">
						<input type="hidden" name="relTypeCode" value="article" />
						<input type="hidden" name="relId" value="${article.aid}" />
						<input type="hidden" name="redirectUri" value="${rq.currentUri}" />
						<c:choose>
							<c:when test="${rq.notLogined}">
								<span class="p-2 text-lg">댓글 작성기능은 로그인 후 이용하실 수 있습니다.</span>
							</c:when>
							<c:otherwise>
								<div>
									<span class="flex px-2 border-b text-lg">${rq.loginedMember.nickname}</span>
									<textarea onkeydown="resize(this)" onkeyup="resize(this)" name="body" class="replyInput w-full outline-none" placeholder="댓글을 남겨보세요."></textarea>
									<div class="flex justify-end">
										<input type="submit" value="등록" class="replySubmit px-1 rounded bg-white hover:bg-blue-300 mr-2 mb-2" />
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</form>
				</div>
			</div>
		</div>
		<div class="flex justify-end mt-1">
			<c:if test="${rq.loginedMemberUid == article.uid}">
				<input type="button" value="수정" onclick="location.href='update?aid=${article.aid}'" class="m-1 h-8 w-16 rounded bg-blue-300 hover:bg-blue-500" />
				<input type="button" value="삭제" onclick="Delete__Article__Confirm();" class="m-1 h-8 w-16 rounded bg-red-300 hover:bg-red-500" />
			</c:if>
			<input type="button" value="목록으로" onclick="location.href='list?boardCode=${article.boardCode}'" class="m-1 h-8 w-16 rounded bg-gray-100 hover:bg-gray-300" />
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>