<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

<section class="flex justify-center bg-blue-300">
	<div class="relative container max-w-5xl w-full bg-blue-500 auto-cols-auto">
		<div>
			<c:forEach var="article" items="${articles}">
				<div>
					${article.title}
				</div>
			</c:forEach>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>