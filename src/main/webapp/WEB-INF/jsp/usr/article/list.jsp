<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

<section class="flex justify-center">
	<div class="container max-w-5xl w-full auto-cols-auto">
		<div>
			<div class="">
				<span class="flex text-4xl font-bold p-3">
					
				</span>
			</div>
			<div class="border-b-4 border-t-4 rounded border-blue-700">
				<c:forEach var="article" items="${articles}">
					<div class="border-b">
						<div class="flex">
							<div class="flex justify-center items-center w-12">
								<span class="text-sm">${article.aid}</span>
							</div>
							<div class="flex justify-center items-center">
								<span class="text-lg">${article.title}</span>
							</div>
						</div>
						<div>
							<div>
								<span>${article.nickname}</span>
							</div>
						</div>
						<div>
							<div>
								<span>${article.body}</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>