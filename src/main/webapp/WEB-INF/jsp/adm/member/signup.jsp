<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/loginLayoutHeader.jspf"%>
<!-- debounce 사용을 위한 스크립트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<script>
const SignupForm__checkAndSubmitDone = false;

//로그인 아이디 중복체크 함수
let SignupForm__validID = '';
function SignupForm__checkIDDup() {
	const form = $('.formLogin').get(0);

	form.ID.value = form.ID.value.trim();

	if (form.ID.value.length == 0) {
		return;
	}

	$.get('getLoginIdDup', {
		ID : form.ID.value
	}, function(data) {
		let colorClass = 'text-green-500';

		if (data.fail) {
			colorClass = 'text-red-500';
		}

		$('.IDInputMsg').html(
				"<span class='" + colorClass + "'>" + data.msg);

		if (data.fail) {
			form.ID.focus();
		} else {
			SignupForm__validID = data.body.ID;
		}
	}, 'json');
}

$(function() {
	$('.inputLoginId').change(function() {
		SignupForm__checkIDDup();
	});
	$('.inputLoginId').keyup(_.debounce(SignupForm__checkIDDup, 500));
});

let SignupForm__validNickname = '';
function SignupForm__checkNicknameDup() {
	const form = $('.formLogin').get(0);

	form.nickname.value = form.nickname.value.trim();

	if (form.nickname.value.length == 0) {
		return;
	}

	$.get('getNicknameDup', {
		nickname : form.nickname.value
	}, function(data) {
		let colorClass = 'text-green-500';

		if (data.fail) {
			colorClass = 'text-red-500';
		}

		$('.nicknameInputMsg').html(
				"<span class='" + colorClass + "'>" + data.msg);

		if (data.fail) {
			form.nickname.focus();
		} else {
			SignupForm__validNickname = data.body.nickname;
		}
	}, 'json');
}

$(function() {
	$('.inputNickname').change(function() {
		SignupForm__checkNicknameDup();
	});
	$('.inputNickname').keyup(_.debounce(SignupForm__checkNicknameDup, 500));
});

MemberSignup__submited = false;
function MemberSignup__checkAndSubmit(form) {
	if ( MemberSignup__submited ) {
		alert('처리중입니다.');
		return;
	}
	if ( form.ID.value.length == 0 ) {
		alert('아이디를 입력해주세요.');
		form.ID.focus();
		return false;
	}
	if( form.PW.value.length == 0 ) {
		alert('비밀번호를 입력해주세요');
		form.PW.focus();
		return false;
	}
	if( form.PWCheck.value.length == 0 ) {
		alert('비밀번호 확인을 입력해주세요');
		form.PWCheck.focus();
		return false;
	}
	if( form.PW.value != form.PWCheck.value ){
		alert('비밀번호가 일치하지 않습니다.');
		form.PWCheck.focus();
		return false;
	}
	if( form.nickname.value.length == 0 ) {
		alert('닉네임을 입력해주세요');
		form.nickname.focus();
		return false;
	}
	if( form.email.value.length == 0 ) {
		alert('이메일을 입력해주세요');
		form.email.focus();
		return false;
	}
	if( form.phoneNo.value.length == 0 ) {
		alert('연락처를 입력해주세요');
		form.phoneNo.focus();
		return false;
	}
	
	form.submit();
	MemberSignup__submited = true;
}
</script>

<section class="border-2 border-blue-300 rounded">
	<div class="p-4">
		<form onsubmit="MemberSignup__checkAndSubmit(this); return false;" action="doSignup" method="post" class="formLogin" >
			<div class="text-gray-900 text-xl">
				<div class="flex justify-center">
					<span class="text-4xl">회원가입</span>
				</div>
				<div class="mt-2">
					<input type="text" name="ID" placeholder="아이디" class="inputLoginId border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div class="IDInputMsg text-sm text-center"></div>
				<div class="my-2">
					<input type="password" name="PW" placeholder="비밀번호" class="border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div class="my-2">
					<input type="password" name="PWCheck" placeholder="비밀번호 확인" class="border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div class="my-2">
					<input type="text" name="nickname" placeholder="닉네임" class="inputNickname border-2 rounded w-full h-12 hover:border-blue-300" />
					<div class="nicknameInputMsg text-sm text-center"></div>
				</div>
				<div class="my-2">
					<input type="text" name="email" placeholder="이메일" class="border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div class="my-2">
					<input type="text" name="phoneNo" placeholder="연락처" class="border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div class="flex">
					<input type="submit" value="가입" class="h-12 w-full hover:bg-blue-300 border mr-1 rounded"/>
					<input type="button" value="취소" onclick="history.back()" class="h-12 w-full hover:bg-red-300 ml-1 rounded"/>
				</div>
			</div>
		</form>
	</div>
</section>


<%@ include file="../part/loginLayoutFooter.jspf"%>