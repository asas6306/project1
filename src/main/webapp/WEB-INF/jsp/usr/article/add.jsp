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
</script>

<section class="section-add flex justify-center">
	<div class="">
		<div class="flex items-center justify-center h-20 text-4xl font-bold">글쓰기</div>
		<form onsubmit="ArticleAdd__checkAndSubmit(this); return false;" action="doAdd" method="post" enctype="multipart/form-data">
			<input type="hidden" name="genFileIdsStr" value="" />
			<input type="hidden" name="articleType" value="${articleType}" />
			<div class="">
				<div class="add-board w-full">
					<select name="boardCode" class="select-board p-2 font-thin text-lg outline-none border border-blue-500">
						<option value="0" class="font-thin">=== 게시판선택 ===</option>
						<c:choose>
							<c:when test="${articleType == 'memo'}">
								<c:forEach var="board" items="${boards}">
									<option value="${board.boardCode}" class="font-thin">${board.boardName}</option>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach var="board" items="${boards}">
									<option value="${board.boardCode}" class="font-thin">${board.boardName}</option>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</select>
					<script>
						$('.section-add .select-board').val(${boardCode});
					</script>
				</div>
			</div>
			<div class="flex border-b border-blue-500">
				<div class="w-full">
					<input type="text" name="title" placeholder="제목을 입력해주세요." autofocus="autofocus" autocomplete="off" class="w-full h-12 text-2xl p-2 outline-none"/>
				</div>
			</div>
			<div class="flex border-b border-blue-500">
				<div class="w-full">
					<textarea name="body" placeholder="내용을 입력해주세요." class="w-full h-40 p-2 text-xl outline-none"></textarea>
				</div>
			</div>
			<div class="flex border-b border-blue-500">
				<div class="flex justify-center items-center w-20 bg-blue-100 ">
					<span>첨부파일</span>
				</div>
				<div class="">
				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
					<div>
						<input class="form-row-input w-full" type="file" accept="image/gif, image/jpeg, image/png"
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