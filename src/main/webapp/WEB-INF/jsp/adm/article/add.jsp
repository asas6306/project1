<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<c:set var="fileInputMaxCount" value="3" />
<script>
	ArticleAdd__fileInputMaxCount = parseInt("${fileInputMaxCount}");
</script>

<script>
ArticleAdd__submited = false;
function ArticleAdd__checkAndSubmit(form) {
	if ( ArticleAdd__submited ) {
		alert('처리중입니다.');
		return;
	}
	
	if ( form.boardCode.value == 0 ) {
		alert('게시판을 선택해주세요.');
		form.boardCode.focus();
		return false;
	}
	
	form.title.value = form.title.value.trim();
	if ( form.title.value.length == 0 ) {
		alert('제목을 입력해주세요.');
		form.title.focus();
		return false;
	}
	
	form.body.value = form.body.value.trim();
	if ( form.body.value.length == 0 ) {
		alert('내용을 입력해주세요.');
		form.body.focus();
		return false;
	}
	
	var maxSizeMb = 50;
	var maxSize = maxSizeMb * 1024 * 1024;
	for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
		const input = form["file__article__0__common__attachment__" + inputNo];
		
		if (input.value) {
			if (input.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				input.focus();
				
				return;
			}
		}
	}
	const startSubmitForm = function(data) {
		if (data && data.body && data.body.genFileIdsStr) {
			form.genFileIdsStr.value = data.body.genFileIdsStr;
		}
		
		for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
			const input = form["file__article__0__common__attachment__" + inputNo];
			input.value = '';
		}
		
		form.submit();
	};
	const startUploadFiles = function(onSuccess) {
		var needToUpload = false;
		for ( let inputNo = 1; inputNo <= ArticleAdd__fileInputMaxCount; inputNo++ ) {
			const input = form["file__article__0__common__attachment__" + inputNo];
			if ( input.value.length > 0 ) {
				needToUpload = true;
				break;
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
	ArticleAdd__submited = true;
	startUploadFiles(startSubmitForm);
}

//function confirm() {
//    msg = "실행하시겠습니까?";
//    if (confirm(msg)!=0) {
//         // Yes click
//    } else {
       // no click
//	}
//} // myconfirm
</script>

<section class="section-add flex justify-center">
	<div class="w-1/2">
		<div class="flex items-center justify-center h-20 text-4xl font-bold">글쓰기</div>
		<form onsubmit="ArticleAdd__checkAndSubmit(this); return false;" action="doAdd" method="post">
			<input type="hidden" name="genFileIdsStr" value="" />
			<input type="hidden" name="articleType" value="${articleType}" />
			<div class="flex border-b-2 border-t-2 border-gray-500">
				<div class="flex justify-center w-20 bg-gray-100 flex-shrink-0">
					<span>게시판 선택</span>
				</div>
				<div class="w-full">
					<select name="boardCode" class="select-board mx-2">
						<option value="0">=== 게시판선택 ===</option>
						<c:choose>
							<c:when test="${articleType == 'memo'}">
								<option value="31">웹</option>
								<option value="32">정보처리기사</option>
							</c:when>
							<c:otherwise>
								<option value="1">공지사항</option>
								<option value="2">자유게시판</option>
							</c:otherwise>
						</c:choose>
					</select>
					<script>
						$('.section-add .select-board').val(${boardCode});
					</script>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center w-20 bg-gray-100 flex-shrink-0">
					<span>제목</span>
				</div>
				<div class="w-full">
					<input type="text" name="title" placeholder="제목을 입력해주세요." autofocus="autofocus" class="w-full"/>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center w-20 bg-gray-100 flex-shrink-0">
					<span>내용</span>
				</div>
				<div class="w-full">
					<textarea name="body" placeholder="내용을 입력해주세요." class="w-full h-40"></textarea>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center items-center w-20 bg-gray-100 flex-shrink-0">
					<span>첨부파일</span>
				</div>
				<div class="w-full">
				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
					<div>
						<input class="form-row-input w-full" type="file"
								name="file__article__0__common__attachment__${inputNo}" />
					</div>
				</c:forEach>
				</div>
			</div>
			<div class="flex w-full justify-center">
				<input type="submit" value="작성" class="bg-blue-300 h-8 w-16 mt-2 mr-1 hover:bg-blue-500 rounded" />
				<input type="button" value="취소" onclick="history.back()" class="bg-red-300 h-8 w-16 mt-2 ml-1 hover:bg-red-500 rounded" />
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>