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
			<span class="text-lg">쪽지보내기</span>
		</div>
		<div class="flex items-center p-2 border-b">
			<span>받는사람</span>
			<span class="px-1">:</span>
			<span class="font-thin">${targetMember.nickname}</span>
		</div>
		<div>
			<form onsubmit="NoteSend__checkAndSubmit(this); return false;" action="doSend" method="post">
				<input type="hidden" name="uid" value="${targetMember.uid}">
				<div class="border-b">
					<textarea name="body" rows="7" placeholder="내용을 입력해주세요." class="w-full h-60 p-2 outline-none"></textarea>
				</div>
				<div class="flex justify-center p-2 gap-2 border-b">
					<input type="submit" value="전송" class="px-2 py-1 rounded bg-blue-300 hover:bg-blue-500" />
					<input type="button" value="취소" onclick="window.close()" class="px-2 py-1 rounded bg-red-300 hover:bg-red-500" />
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/footer.jspf"%>