<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHeader.jspf"%>

<script>
	const FindPWForm__checkAndSubmitDone = false;
	function FindPWForm__checkAndSubmit(form) {
		if(FindPWForm__checkAndSubmitDone)
			return;
	
	form.ID.value = form.ID.value.trim();
	form.PW.value = form.PW.value.trim();
	
	if(form.ID.value.length == 0) {
		alert('아이디를 입력해주세요.');
		form.ID.focus();
		
		return;
	}
	
	if(form.email.value.length == 0) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		
		return;
	}
	
	form.submit();
	FindPWForm__checkAndSubmitDone = true;
}
</script>

<section class="flex justify-center">
	<div class="member-box container p-4">
		<div class="border-2 border-blue-300 rounded-xl p-4">
			<div class="text-center text-4xl font-bold text-bold">비밀번호 찾기</div>
			<form action="doFindPW" method="post" onsubmit="FindPWForm__checkAndSubmit(this); return false;">
				<input type="hidden" name="redirectUri" value="${param.redirectUri}" />
				<div class="text-gray-900 text-xl">
					<div class="mt-2">
						<input type="text" name="ID" placeholder="아이디" class="border-2 rounded w-full p-2 hover:border-blue-300" />
					</div>
					<div class="my-2">
						<input type="email" name="email" placeholder="이메일" class="border-2 rounded w-full p-2 hover:border-blue-300" />
					</div>
					<div class="flex justify-center">
						<input type="submit" value="찾기" class="rounded p-1 px-2 bg-blue-300 hover:bg-blue-500"/>
						<div class="p-1"></div>
						<input type="button" value="취소" onclick="history.back()" class="rounded p-1 px-2 bg-red-300 hover:bg-red-500"/>
					</div>
					<div class="flex justify-center text-gray-300 text-sm mt-2">
						<a href="signup" class="hover:text-gray-500">회원가입</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>