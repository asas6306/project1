<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHeader.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	const AuthenticationForm__checkAndSubmitDone = false;
	function AuthenticationForm__checkAndSubmit(form) {
		if(AuthenticationForm__checkAndSubmitDone)
			return;
	
	form.PWInput.value = form.PWInput.value.trim();
	if(form.PWInput.value.length == 0) {
		alert('비밀번호를 입력해주세요.');
		form.PWInput.focus();
		
		return;
	}
	
	form.PW.value = sha256(form.PWInput.value);
	form.PWInput.value = '';
	
	form.submit();
	AuthenticationForm__checkAndSubmitDone = true;
}
</script>

<section class="flex justify-center">
	<div class="member-box container p-4">
		<div class="border-2 border-blue-300 rounded-xl p-4">
			<div class="text-center text-4xl font-bold text-bold">사용자 인증</div>
			<form action="doAuthentication" method="post" onsubmit="AuthenticationForm__checkAndSubmit(this); return false;">
				<input type="hidden" name="redirectUri" value="${param.afterUri}" />
				<input type="hidden" name="PW" />
				<div class="text-gray-900 text-xl">
					<div class="my-2">
						<input type="password" name="PWInput" placeholder="비밀번호" class="border-2 rounded w-full p-2 hover:border-blue-300" />
					</div>
					<div class="flex justify-center">
						<input type="submit" value="확인" class="rounded p-1 px-2 bg-blue-300 hover:bg-blue-500"/>
						<div class="p-1"></div>
						<input type="button" value="취소" onclick="history.back()" class="rounded p-1 px-2 bg-red-300 hover:bg-red-500"/>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>