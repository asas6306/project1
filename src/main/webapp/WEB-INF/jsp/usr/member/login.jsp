<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHeader.jspf"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	const LoginForm__checkAndSubmitDone = false;
	function LoginForm__checkAndSubmit(form) {
		if(LoginForm__checkAndSubmitDone)
			return;
	
	form.ID.value = form.ID.value.trim();
	form.PWInput.value = form.PWInput.value.trim();
	
	if(form.ID.value.length == 0) {
		alert('아이디를 입력해주세요.');
		form.ID.focus();
		
		return;
	}
	
	if(form.PWInput.value.length == 0) {
		alert('비밀번호를 입력해주세요.');
		form.PWInput.focus();
		
		return;
	}
	form.PW.value = sha256(form.PWInput.value);
	form.PWInput.value = '';
	
	form.submit();
	LoginForm__checkAndSubmitDone = true;
}
</script>

<section class="flex justify-center">
	<div class="member-box container p-4">
		<div class="border-2 border-blue-300 rounded-xl p-4">
			<div class="text-center text-4xl font-bold text-bold">로그인</div>
			<form action="doLogin" method="post" onsubmit="LoginForm__checkAndSubmit(this); return false;">
				<input type="hidden" name="redirectUri" value="${param.redirectUri}" />
				<input type="hidden" name="PW">
				<div class="text-gray-900 text-xl">
					<div class="mt-2">
						<input type="text" name="ID" placeholder="아이디" class="border-2 rounded w-full p-2 hover:border-blue-300" />
					</div>
					<div class="my-2">
						<input type="password" name="PWInput" placeholder="비밀번호" class="border-2 rounded w-full p-2 hover:border-blue-300" />
					</div>
					<div>
						<input type="submit" value="로그인" class="h-12 w-full hover:bg-blue-300"/>
					</div>
					<div class="flex justify-center text-gray-300 text-sm mt-2">
						<a href="signup" class="hover:text-gray-500">
							<span>회원가입</span>
						</a>
						<span class="mx-2">|</span>
						<a href="findID" class="hover:text-gray-500">
							<span>아이디 찾기</span>
						</a>
						<span class="mx-2">|</span>
						<a href="findPW" class="hover:text-gray-500">
							<span>비밀번호 찾기</span>
						</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>