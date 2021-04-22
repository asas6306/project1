<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<script>
ArticleAdd__submited = false;
function ArticleAdd__checkAndSubmit(form) {
	if ( ArticleAdd__submited ) {
		alert('처리중입니다.');
		return;
	}
	alert('1');
	if ( form.boardCode.value == 0 ) {
		alert('게시판을 선택해주세요.');
		form.boardCode.focus();
		return false;
	}
	alert('2');
	form.title.value = form.title.value.trim();
	if( form.title.value.length == 0 ) {
		alert('제목을 입력해주세요');
		form.title.focus();
		return false;
	}
	alert('3');
	form.body.value = form.body.value.trim();
	if( form.body.value.length == 0 ) {
		alert('내용을 입력해주세요');
		form.body.focus();
		return false;
	}
	alert('4');
	ArticleAdd__submited = true;
	alert('5');
}
</script>

<section class="section-add flex justify-center">
	<div class="w-1/2">
		<div class="flex items-center justify-center h-20 text-4xl font-bold">글쓰기</div>
		<form onsubmit="ArticleAdd__checkAndSubmit(this); return false;" action="doAdd" method="post">
			<div class="flex border-b-2 border-t-2 border-gray-500">
				<div class="flex justify-center w-24 bg-gray-100">
					<span>게시판 선택</span>
				</div>
				<div class="w-full">
					<select name="boardCode" class="select-board mx-2">
						<option value="0">=== 게시판선택 ===</option>
						<option value="1">공지사항</option>
						<option value="2">자유게시판</option>
					</select>
					<script>
						$('.section-add .select-board').val(${boardCode});
					</script>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center w-24 bg-gray-100">
					<span>제목</span>
				</div>
				<div class="w-full">
					<input type="text" name="title" placeholder="제목을 입력해주세요." autofocus="autofocus" class="w-full"/>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center w-24 bg-gray-100">
					<span>내용</span>
				</div>
				<div class="w-full">
					<textarea name="body" placeholder="내용을 입력해주세요." class="w-full h-40"></textarea>
				</div>
			</div>
			<div class="flex border-b-2 border-gray-500">
				<div class="flex justify-center w-24 bg-gray-100">
					<span>첨부파일</span>
				</div>
				<div class="w-full">
					<input type="file" name="genFile" />
				</div>
			</div>
			<div class="flex w-full justify-center">
				<input type="submit" value="작성" class="bg-blue-300 h-8 w-16 mt-2 mr-1 hover:bg-blue-500" />
				<input type="button" value="취소" onclick="history.back()" class="bg-red-300 h-8 w-16 mt-2 ml-1 hover:bg-red-500" />
			</div>
		</form>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>