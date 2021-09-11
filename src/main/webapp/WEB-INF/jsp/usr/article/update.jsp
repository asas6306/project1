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
	<div class="container lg:w-2/3 2xl:w-1/2">
		<form onsubmit="ArticleUpdate__checkAndSubmit(this); return false;" action="doUpdate" method="post">
			<input type="hidden" name="genFileIdsStr" value="" /> 
			<input type="hidden" name="aid" value="${article.aid}" />
			<div class="text-4xl font-bold p-3">
				<input type="button" value="<" onclick="history.back()" class="bg-white cursor-pointer"/>
				<a href="list?boardCode=${boardCode}">게시물 수정</a>
			</div>
			<div class="border-b-4 border-t-4 rounded border-blue-700">
				<div class="p-4">
					<div class="grid gap-2 w-full">
						<div class="w-min">
							<select name="boardCode" class="select-board p-1 text-lg font-thin">
								<option value="0">=== 게시판선택 ===</option>
								<c:forEach var="board" items="${boards}">
									<option value="${board.boardCode}">${board.boardName}</option>
								</c:forEach>
							</select>
							<script>
								$('.section-add .select-board').val(${article.boardCode});
							</script>
						</div>
						<div class="border rounded">
							<input type="text" name="title" value="${article.title}" placeholder="제목을 입력해주세요." autofocus="autofocus" autocomplete="off" class="w-full p-3 text-4xl" autocomplete="off" />
						</div>
						<div class="flex border rounded">
							<textarea name="body" placeholder="내용을 입력해주세요." class="w-full h-40 text-2xl font-thin p-3">${article.bodyForUpdate}</textarea>
						</div>
						<div class="flex border rounded">
							<div class="flex justify-center items-center w-24">
								<span>첨부파일</span>
							</div>
							<div class="w-full">
								<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
									<div class="input-file-wrap">
										<c:set var="fileNo" value="${String.valueOf(inputNo)}"></c:set>
										<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}"></c:set>
										<c:if test="${file != null && file.fileExtTypeCode == 'img'}">
											<div>
												<a href="${file.forPrintUri}" target="_blank" title="자세히 보기">
													<img class="max-w-sm max-h-60" src="${file.forPrintUri}" />
												</a>
											</div>
											<div>
												<a class="hover:underline" href="${file.downloadUri}"
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
										<input class="form-row-input w-full" type="file" accept="image/gif, image/jpeg, image/png"
											name="file__article__${article.aid}__common__attachment__${inputNo}" />
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="flex justify-end mt-1">
				<input type="submit" value="수정" class="m-1 h-8 w-16 rounded bg-blue-300 hover:bg-blue-500" />
				<input type="button" value="취소" onclick="history.back()" class="m-1 h-8 w-16 rounded bg-red-300 hover:bg-red-500" />
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>