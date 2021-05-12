<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.util.Util"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="flex justify-center">
	<div>
		<span class="flex items-center justify-center h-20 text-4xl font-bold">마이페이지</span>
		<form action="doUpdate" method="post" class="border-t-2 border-b-2">
			<div class="flex">
				<div>
					<img alt="" src="프로필사진" class="w-40 h-40 rounded-full bg-gray-300">
					<input type="file" name="profile__img" value="#" class="w-40" />
				</div>
				<div class="mx-4 my-2 w-96">
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">아이디 : </span>
						<span>${loginedMember.ID}</span>
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">비밀번호 : </span>
						<input type="password" name="PW1" class="border" />
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">비밀번호확인 : </span>
						<input type="password" name="PW1" class="border" />
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">닉네임 : </span>
						<input type="text" name="nickname" value="${loginedMember.nickname}" class="border" />
					</div>
					<div class="flex text-xl">
						<span class="w-32 text-right mr-2">이메일 : </span>
						<input type="text" name="eamil" value="${loginedMember.email}" class="border" />
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