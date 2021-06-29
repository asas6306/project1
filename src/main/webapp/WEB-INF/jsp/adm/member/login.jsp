<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/loginLayoutHeader.jspf"%>

<script>
	const LoginForm__checkAndSubmitDone = false;
	function LoginForm__checkAndSubmit(form) {
		if(LoginForm__checkAndSubmitDone)
			return;
	}
	
	form.ID.value = form.ID.value=trim();
	form.PW.value = form.PW.value=trim();
	
	if(form.ID.value.length == 0) {
		alert('아이디를 입력해주세요.');
		form.ID.focus();
		
		return;
	}
	
	if(form.PW.value.length == 0) {
		alert('비밀번호를 입력해주세요.');
		form.PW.focus();
		
		return;
	}
	
	form.submit();
	LoginForm__checkAndSubmitDone = true;
</script>

<section class="border-2 border-blue-300 rounded">
	<div class="p-4">
		<form action="doLogin" method="post" onsubmit="LoginForm__checkAndSubmit(this); return false;">
			<input type="hidden" name="redirectUri" value="${param.redirectUri}" />
			<div class="text-gray-900 text-xl">
				<div class="mt-2">
					<input type="text" name="ID" placeholder="아이디" class="border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div class="my-2">
					<input type="password" name="PW" placeholder="비밀번호" class="border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div>
					<input type="submit" value="로그인" class="h-12 w-full hover:bg-blue-300"/>
				</div>
				<div class="flex justify-center text-gray-300 text-sm mt-2">
					<a href="/adm/member/signup" class="hover:text-gray-500">회원가입</a>
					<span class="mx-2">|</span>
					<a href="/adm/member/find" class="hover:text-gray-500">회원찾기</a>
				</div>
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/loginLayoutFooter.jspf"%>