<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/loginLayoutHeader.jspf"%>

<section class="border-2 border-blue-300 rounded h-56">
	<div class="p-4">
		<form action="doLogin" method="post">
			<div class="text-gray-900 text-xl">
				<div class="mt-2">
					<input type="text" name="ID" placeholder="아이디" class="border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div class="my-2">
					<input type="text" name="PW" placeholder="비밀번호" class="border-2 rounded w-full h-12 hover:border-blue-300" />
				</div>
				<div>
					<input type="submit" value="로그인" class="h-12 w-full hover:bg-blue-300"/>
				</div>
				<div class="flex justify-center text-gray-300 text-sm mt-2">
					<a href="/adm/member/signup" class="hover:text-gray-500">회원가입</a>
					<span class="mx-2">|</span>
					<a href="/adm/member/find" class="hover:text-gray-500">회원찾기</a>
				</div>
			</div>
		</form>
	</div>
</section>


<%@ include file="../part/loginLayoutFooter.jspf"%>