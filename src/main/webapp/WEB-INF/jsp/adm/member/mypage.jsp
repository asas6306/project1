<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../part/mainLayoutHeader.jspf"%>

<section class="flex justify-center">
	<div>
		<span class="flex items-center justify-center h-20 text-4xl font-bold">마이페이지</span>
		<div class="border-t-2 border-b-2">
			<div class="flex">
				<img alt="" src="프로필사진" class="w-40 h-40 rounded-full bg-gray-300">
				<div class="mx-4 my-2 w-96">
					<div class="flex justify-between">
						<span class="text-4xl">${loginedMember.nickname} (${loginedMember.ID})</span>
						<div class="flex justify-center items-center">
							<a href="adm/member/update" class="p-1 rounded-full text-sm bg-gray-300 hover:bg-blue-300">회원수정</a>
						</div>
					</div>
					<div class="text-lg">${loginedMember.authName}</div>
					<div class="text-lg">${loginedMember.email}</div>
					<div class="text-lg">${loginedMember.phoneNo}</div>
					<div class="text-lg">authKey : ${loginedMember.authKey}</div>
				</div>
			</div>
			<div class="flex justify-center text-xl font-bold">
				<div class="text-center border-b w-44">게시물</div>
				<div class="text-center border-b mx-4 w-44">메모</div>
				<div class="text-center border-b w-44">댓글</div>
			</div>
			<div class="flex justify-center text-xl">
				<div class="text-center border-b w-44">
					<a href="#" class="hover:underline">1,234개</a>
				</div>
				<div class="text-center border-b mx-4 w-44">
					<a href="#" class="hover:underline">1,234개</a>
				</div>
				<div class="text-center border-b w-44">
					<a href="#" class="hover:underline">1,234개</a>
				</div>
			</div>
			<div>
				<div class="flex border-b-2 mt-4">
					<span class="text-center w-96">제목</span>
					<span class="text-center w-40">작성일</span>
					<span class="text-center w-16">조회수</span>
				</div>
				<div class="flex">
					<div class="flex w-96">
						<span class="flex items-center justify-center w-16 text-sm">1</span>
						<span>title</span>
					</div>
					<span class="text-center w-40">regDate</span>
					<span class="text-center w-16">hit</span>
				</div>
			</div>
		</div>
	</div>
	
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>