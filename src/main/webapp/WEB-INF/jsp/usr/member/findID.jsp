<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHeader.jspf"%>

<script>
const FindIDForm__checkAndSubmitDone = false;
function FindIDForm__checkAndSubmit(form) {
	if(FindIDForm__checkAndSubmitDone)
		return;
	
	if(form.name.value.length == 0) {
		alert('이름을 입력해주세요.');
		form.name.focus();
		
		return;
	}
	
	if(form.email.value.length == 0) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		
		return;
	}

form.submit();
FindIDForm__checkAndSubmitDone = true;
}
</script>

<section class="flex justify-center">
	<div class="member-box container p-4">
		<div class="border-2 border-blue-300 rounded-xl p-4">
			<div class="text-center text-4xl font-bold text-bold">아이디 찾기</div>
			<form action="doFindID" method="post" onsubmit="FindIDForm__checkAndSubmit(this); return false;">
				<div class="text-gray-900 text-xl">
					<div class="my-2">
						<input type="text" name="name" placeholder="이름을 입력해주세요." autocomplete="off" class="border-2 rounded w-full p-2 hover:border-blue-300" />
					</div>
					<div class="my-2">
						<input type="text" name="email" placeholder="이메일을 입력해주세요." autocomplete="off" class="border-2 rounded w-full p-2 hover:border-blue-300" />
					</div>
					<div class="flex justify-center">
						<input type="submit" value="찾기" class="rounded p-1 px-2 bg-blue-300 hover:bg-blue-500"/>
						<div class="p-1"></div>
						<input type="button" value="취소" onclick="location.href='login'" class="rounded p-1 px-2 bg-red-300 hover:bg-red-500"/>
					</div>
					<div class="flex justify-center text-gray-300 text-sm mt-2">
						<a href="signup" class="hover:text-gray-500">비밀번호 찾기</a>
						<span class="mx-2">|</span>
						<a href="signup" class="hover:text-gray-500">회원가입</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>