<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.util.Util"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	const uid = parseInt("${rq.loginedMember.uid}");
</script>
<script>
let UpdateForm__validNickname = '';
function UpdateForm__checkNicknameDup() {
	const form = $('.formUpdate').get(0);

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
			UpdateForm__validNickname = data.body.nickname;
		}
	}, 'json');
}

$(function() {
	$('.inputNickname').change(function() {
		UpdateForm__checkNicknameDup();
	});
});
</script>


<script>
let UpdateForm__validPW = '';
function UpdateForm__checkPWDup() {
	const form = $('.formUpdate').get(0);

	form.PWInput.value = form.PWInput.value.trim();

	if (form.PWInput.value.length == 0) {
		return;
	}

	$.get('getPWDup', {
		PW : form.PWInput.value
	}, function(data) {
		let colorClass = 'text-green-500';

		if (data.fail) {
			colorClass = 'text-red-500';
		}

		$('.PWInputMsg').html(
				"<span class='" + colorClass + "'>" + data.msg);

		if (data.fail) {
			form.PWInput.focus();
		} else {
			UpdateForm__validPW = data.body.PWInputw;
		}
	}, 'json');
}

$(function() {
	$('.inputPW').keyup(_.debounce(UpdateForm__checkPWDup, 500));
});
</script>

<script>
function UpdateForm__checkPWCheckDup() {
	const form = $('.formUpdate').get(0);

	form.PWInput.value = form.PWInput.value.trim();
	form.PWCheck.value = form.PWCheck.value.trim();

	if (form.PWInput.value.length == 0) {
		return;
	}
	if (form.PWCheck.value.length == 0) {
		return;
	}
	
	let colorClass = 'text-red-500';
	if ( form.PWInput.value != form.PWCheck.value ) {
		$('.PWCheckInputMsg').html(
				"<span class='" + colorClass + "'>" + "??????????????? ???????????? ????????????");
		form.PWCheck.focus();
	} else {
		$('.PWCheckInputMsg').html('');
	}
}

$(function() {
	$('.inputPWCheck').change(function() {
		UpdateForm__checkPWCheckDup();
	});
});
</script>

<script>
MemberUpdate__submited = false;
function MemberUpdate__checkAndSubmit(form) {
	if ( MemberUpdate__submited ) {
		alert('??????????????????.');
		return;
	}
	
	form.PWInput.value = form.PWInput.value.trim();
	form.PWCheck.value = form.PWCheck.value.trim();
	if ( form.PWInput.value != form.PWCheck.value) {
		alert('??????????????? ???????????? ????????????.');
		form.PWInput.focus();
		return false;
	}
	
	form.nickname.value = form.nickname.value.trim();
	if ( form.nickname.value.length == 0 ) {
		alert('???????????? ??????????????????.');
		form.nickname.focus();
		return false;
	}
	
	form.email.value = form.email.value.trim();
	if ( form.email.value.length == 0 ) {
		alert('???????????? ??????????????????.');
		form.email.focus();
		return false;
	}
	
	form.phoneNo.value = form.phoneNo.value.trim();
	if ( form.phoneNo.value.length == 0 ) {
		alert('???????????? ??????????????????.');
		form.phoneNo.focus();
		return false;
	}
	
	var maxSizeMb = 50;
	var maxSize = maxSizeMb * 1024 * 1024;
	
	
	const input = form["file__member__" + uid + "__common__profile__0"];

	if (input.value) {
		if (input.files[0].size > maxSize) {
			alert(maxSizeMb + "MB ????????? ????????? ????????? ????????????.");
			input.focus();
			
			return;
		}
	}
	
	const startSubmitForm = function(data) {
		if (data && data.body && data.body.genFileIdsStr) {
			form.genFileIdsStr.value = data.body.genFileIdsStr;
		}
		
		const input = form["file__member__" + uid + "__common__profile__0"];
		input.value = '';
		
		form.submit();
	};
	
	const startUploadFiles = function(onSuccess) {
		var needToUpload = false;
		const input = form["file__member__" + uid + "__common__profile__0"];
		
		if ( input.value.length > 0 ) {
			needToUpload = true;
		}
		
		if ( needToUpload == false ) {
			const input = form["deleteFile__member__" + uid + "__common__profile__0"];
			if ( input && input.checked ) {
				needToUpload = true;
			}
		}
		
		if (needToUpload == false) {
			onSuccess();
			return;
		}
		
		var fileUploadFormData = new FormData(form);
		$.ajax({
			url : '/common/genFile/doUpload',
			data : fileUploadFormData,
			processData : false,
			contentType : false,
			dataType : "json",
			type : 'POST',
			success : onSuccess
		});
	}
	
	if(form.PWInput.value.length != 0) {
		form.PW.value = sha256(form.PWInput.value);
	}
	form.PWInput.value = '';
	form.PWCheck.value = '';
	
	MemberUpdate__submited = true;
	startUploadFiles(startSubmitForm);
}
</script>

<section class="base-higth flex justify-center">
	<div>
		<span class="flex items-center justify-center h-20 text-4xl font-bold">???????????????</span>
		<form onsubmit="MemberUpdate__checkAndSubmit(this); return false;" action="doUpdate" method="post" enctype="multipart/form-data" class="formUpdate border-t-2 border-b-2">
			<input type="hidden" name="genFileIdsStr" value="" /> 
			<input type="hidden" name="checkPasswordAuthCode" value="${param.checkPasswordAuthCode}" />
			<input type="hidden" name="PW" />
			<div class="flex">
				<div class="input-file-wrap">
					<img src="${rq.loginedMember.profileImgUri}" class="w-40 h-40 rounded-full bg-gray-300">
					<input type="file" accept="image/gif, image/jpeg, image/png" name="file__member__${rq.loginedMember.uid}__common__profile__0" class="w-20" />
					<input type="checkbox" onclick="$(this).closest('.input-file-wrap').find(' > input[type=file]').val('')"
					name="deleteFile__member__${rq.loginedMember.uid}__common__profile__0" value="Y" /> <span>??????</span>
				</div> <!-- ????????? ?????? ??? ?????? ?????? ??? ?????? ???????????? ??????????????? ?????? -->
				<div class="mx-4 my-2 w-96">
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">????????? : </span>
						<span>${rq.loginedMember.ID}</span>
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">???????????? : </span>
						<input type="password" name="PWInput" class="inputPW border" />
					</div>
					<div class="PWInputMsg text-sm text-center"></div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">?????????????????? : </span>
						<input type="password" name="PWCheck" class="inputPWCheck border" />
					</div>
					<div class="PWCheckInputMsg text-sm text-center"></div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">????????? : </span>
						<input type="text" name="nickname" value="${rq.loginedMember.nickname}" class="inputNickname border" />		
					</div>
					<div class="nicknameInputMsg text-sm text-center"></div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">????????? : </span>
						<input type="email" name="email" value="${rq.loginedMember.email}" class="border" />
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">????????? : </span>
						<input type="text" name="phoneNo" value="${rq.loginedMember.phoneNo}" class="border" />
					</div>
				</div>
			</div>
			<div class="flex justify-center items-center w-24 w-full m-2">
				<input type="submit" value="??????" class="bg-blue-300 w-12 p-1 border hover:bg-blue-500 rounded" />
				<input type="button" value="??????" class="bg-red-300 w-12 p-1 mx-1 border hover:bg-red-500 rounded" onclick="history.back()" />
			</div>
			<div class="flex justify-center text-gray-300 text-sm my-2">
				<a href="../member/authentication?afterUri=${Util.getUriEncoded('../member/delete')}" class="hover:text-gray-500">
					<span>????????????</span>
				</a>
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>