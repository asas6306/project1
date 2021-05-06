<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

<c:set var="fileInputMaxCount" value="3" />
<script>
	ArticleUpdate__fileInputMaxCount = parseInt("${fileInputMaxCount}");
	const aid = parseInt("${article.aid}");
</script>

<script>
ArticleUpdate__submited = false;
function ArticleUpdate__checkAndSubmit(form) {
	if ( ArticleUpdate__submited ) {
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
	for ( let inputNo = 1; inputNo <= ArticleUpdate__fileInputMaxCount; inputNo++ ) {
		const input = form["file__article__" + aid + "__common__attachment__" + inputNo];
		
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
		
		for (let inputNo = 1; inputNo <= ArticleUpdate__fileInputMaxCount; inputNo++) {
			const input = form["file__article__" + aid + "__common__attachment__" + inputNo];
			input.value = '';
		}
		
		for(let inputNo = 1; inputNo <= ArticleUpdate__fileInputMaxCount; inputNo++){
			const input = form["deleteFile__article__" + aid + "__common__attachment__" + inputNo];
			
			if ( input ) {
				input.checked = false;
			}
		}
		
		form.submit();
	};
	
	const startUploadFiles = function(onSuccess) {
		var needToUpload = false;
		for ( let inputNo = 1; inputNo <= ArticleUpdate__fileInputMaxCount; inputNo++ ) {
			const input = form["file__article__" + aid + "__common__attachment__" + inputNo];
			if ( input.value.length > 0 ) {
				needToUpload = true;
				break;
			}
		}
		
		if ( needToUpload == false ) {
			for ( let inputNo = 1; inputNo <= ArticleUpdate__fileInputMaxCount; inputNo++ ) {
				const input = form["deleteFile__article__" + aid + "__common__attachment__" + inputNo];
				if ( input && input.checked ) {
					needToUpload = true;
					break;
				}
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
	ArticleUpdate__submited = true;
	startUploadFiles(startSubmitForm);
}
</script>

<section class="section-add flex justify-center">
	<div class="w-1/2">
		<div class="flex items-center justify-center h-20 text-4xl font-bold">게시물 수정</div>
		<form onsubmit="ArticleUpdate__checkAndSubmit(this); return false;" action="doUpdate" method="post">
			<input type="hidden" name="genFileIdsStr" value="" /> 
			<input type="hidden" name="aid" value="${article.aid}" />
			<div class="flex border-b-2 border-t-2 border-gray-500">
				<div class="flex justify-center w-24 bg-gray-100">
					<span>게시판 선택</span>
				</div>
				<div class="w-full">
					<select name="boardCode" class="select-board mx-2">
						<option value="0">=== 게시판선택 ===</option>
						<c:choose>
							<c:when test="${article.articleType == 'memo'}">
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
						$('.section-add .select-board').val(${article.boardCode});
					</script>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center w-24 bg-gray-100">
					<span>제목</span>
				</div>
				<div class="w-full">
					<input type="text" name="title" value="${article.title}" placeholder="제목을 입력해주세요." autofocus="autofocus" class="w-full"/>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center w-24 bg-gray-100">
					<span>내용</span>
				</div>
				<div class="w-full">
					<textarea name="body" placeholder="내용을 입력해주세요." class="w-full h-40">${article.body}</textarea>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center items-center w-24 bg-gray-100">
					<span>첨부파일</span>
				</div>
				<div class="w-full">
					<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
						<div class="input-file-wrap border-b">
							<c:set var="fileNo" value="${String.valueOf(inputNo)}"></c:set>
							<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}"></c:set>
							<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
								<div>
									<a href="${file.forPrintUrl}" target="_blank" title="자세히 보기">
										<img class="max-w-sm" src="${file.forPrintUrl}" />
									</a>
								</div>
								<div>
									<a class="hover:underline" href="${file.downloadUrl}"
										target="_blank">${file.originFileName}</a>
									(${Util.numberFormat(file.fileSize)} Byte)
								</div>
								<div>
									<label> 
										<input type="checkbox"
										onclick="$(this).closest('.input-file-wrap').find(' > input[type=file]').val('')"
										name="deleteFile__article__${article.aid}__common__attachment__${fileNo}"
										value="Y" /> <span>삭제</span>
									</label>
								</div>
							</c:if>
							<input class="form-row-input w-full" type="file"
								name="file__article__${article.aid}__common__attachment__${inputNo}" />
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="flex w-full justify-center">
				<input type="submit" value="수정" class="bg-blue-300 h-8 w-16 mt-2 mr-1 hover:bg-blue-500 rounded" />
				<input type="button" value="취소" onclick="history.back()" class="bg-red-300 h-8 w-16 mt-2 ml-1 hover:bg-red-500 rounded" />
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>