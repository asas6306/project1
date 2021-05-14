<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.util.Util"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	const uid = parseInt("${loginedMember.uid}");
</script>

<script>
MemberUpdate__submited = false;
function MemberUpdate__checkAndSubmit(form) {
	if ( MemberUpdate__submited ) {
		alert('처리중입니다.');
		return;
	}
	
	form.PW.value = form.PW.value.trim();
	form.PWCheck.value = form.PWCheck.value.trim();
	if ( form.PW.value != form.PWCheck.value) {
		alert('비밀번호가 일치하지 않습니다.');
		form.PW.focus();
		return false;
	}
	
	form.nickname.value = form.nickname.value.trim();
	if ( form.nickname.value.length == 0 ) {
		alert('닉네임을 입력해주세요.');
		form.nickname.focus();
		return false;
	}
	
	form.email.value = form.email.value.trim();
	if ( form.email.value.length == 0 ) {
		alert('이메일을 입력해주세요.');
		form.email.focus();
		return false;
	}
	
	form.phoneNo.value = form.phoneNo.value.trim();
	if ( form.phoneNo.value.length == 0 ) {
		alert('연락처를 입력해주세요.');
		form.phoneNo.focus();
		return false;
	}
	
	var maxSizeMb = 50;
	var maxSize = maxSizeMb * 1024 * 1024;
	
	
	const input = form["file__member__" + uid + "__common__profile__0"];

	if (input.value) {
		if (input.files[0].size > maxSize) {
			alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
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
	MemberUpdate__submited = true;
	startUploadFiles(startSubmitForm);
}
</script>

<section class="flex justify-center">
	<div>
		<span class="flex items-center justify-center h-20 text-4xl font-bold">마이페이지</span>
		<form onsubmit="MemberUpdate__checkAndSubmit(this); return false;" action="doUpdate" method="post" enctype="multipart/form-data" class="border-t-2 border-b-2">
			<input type="hidden" name="genFileIdsStr" value="" /> 
			<input type="hidden" name="uid" value="${loginedMember.uid}" />
			<input type="hidden" name="ID" value="${loginedMember.ID}" />
			<div class="flex">
				<div class="input-file-wrap">
					<c:set var="file" value="${loginedMember.extra.file__common__profile['0']}"></c:set>
					<img alt="" src="${file.forPrintUrl}" class="w-40 h-40 rounded-full bg-gray-300">
					<input type="file" name="file__member__${loginedMember.uid}__common__profile__0" class="w-20" />
					<input type="checkbox" onclick="$(this).closest('.input-file-wrap').find(' > input[type=file]').val('')" 
					name="deleteFile__member__${loginedMember.uid}__common__profile__0" value="Y" /> <span>삭제</span>
				</div>
				<div class="mx-4 my-2 w-96">
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">아이디 : </span>
						<span>${loginedMember.ID}</span>
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">비밀번호 : </span>
						<input type="password" name="PW" value="${loginedMember.PW}" class="border" />
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">비밀번호확인 : </span>
						<input type="password" name="PWCheck" value="${loginedMember.PW}" class="border" />
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">닉네임 : </span>
						<input type="text" name="nickname" value="${loginedMember.nickname}" class="border" />
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">이메일 : </span>
						<input type="text" name="email" value="${loginedMember.email}" class="border" />
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">연락처 : </span>
						<input type="text" name="phoneNo" value="${loginedMember.phoneNo}" class="border" />
					</div>
				</div>
			</div>
			<div class="flex justify-center items-center w-24 w-full">
				<input type="submit" value="수정" class="bg-blue-300 w-12 p-1 border hover:bg-blue-500 rounded" />
				<input type="button" value="취소" class="bg-red-300 w-12 p-1 mx-1 border hover:bg-red-500 rounded" onclick="history.back()" />
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>