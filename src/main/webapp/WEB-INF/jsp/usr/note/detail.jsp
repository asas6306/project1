<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/header.jspf"%>

<script>
NoteSend__submited = false;
function NoteSend__checkAndSubmit(form) {
	if ( NoteSend__submited ) {
		alert('처리중입니다.');
		return;
	}
	
	form.body.value = form.body.value.trim();
	if ( form.body.value.length == 0 ) {
		alert('내용을 입력해주세요.');
		form.body.focus();
		return false;
	}

	NoteSend__submited = true;
	startUploadFiles(startSubmitForm);
}
</script>

<section class="flex justify-center" style="width : 400px;">
	<div class="w-full">
		<div class="w-full p-1 text-center border-b">
			<span class="text-lg">쪽지보기</span>
		</div>
		<div class="flex justify-center items-center gap-4 p-2 border-b">
			<span>${rq.loginedMember.nickname}</span>
			<span class="text-bold text-xl"><i class="fas fa-angle-double-right"></i></span>
			<span>${note.nickname}</span>
		</div>
		<div>
			<div class="border-b max-w-md h-60 py-1 px-2">
				<span>${note.body}</span>
			</div>
			<div class="flex justify-center p-2 gap-2 border-b">
				<c:choose>
					<c:when test="${param.noteType == 'send'}">
						<c:if test="${!note.read}">
							<input type="button" value="전송취소" onclick="location.href='noteCancel?nid=${note.nid}'" class="px-2 py-1 rounded bg-blue-300 hover:bg-blue-500" />
						</c:if>
						<input type="button" value="닫기" onclick="window.close()" class="px-2 py-1 rounded bg-red-300 hover:bg-red-500" />
					</c:when>
					<c:otherwise>
						<input type="button" value="답장" onclick="location.href='send?uid=${note.SUid}'" class="px-2 py-1 rounded bg-blue-300 hover:bg-blue-500" />
						<input type="button" value="닫기" onclick="window.close()" class="px-2 py-1 rounded bg-red-300 hover:bg-red-500" />
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/footer.jspf"%>