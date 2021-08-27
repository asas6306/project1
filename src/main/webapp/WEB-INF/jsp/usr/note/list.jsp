<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

<script>
function del__checkAll(btn) {
	alert('hihi');
	//if(btn.checked) {
	//	for(let i = 1; i <= 20; i++) {
	//		if(document.getElementsByName("delete__" + i)[0].getAttribute('type') == 'checkbox'){
	 //           document.getElementsByName("delete__" + i)[0].checked = true;
	  //      }
	//	}
	//} else {
	//	for(let i = 1; i <= 20; i++) { 
	//		if(document.getElementsByName("delete__" + i)[0].getAttribute('type') == 'checkbox'){
	 //           document.getElementsByName("delete__" + i)[0].checked = false;
	  //      }
	//	}
	//}
}
</script>

<section class="flex justify-center">
	<div class="max-w-5xl w-full">
		<div>
			<div class="flex">
				<div>
					<span class="flex text-4xl font-bold p-3">쪽지함</span>
				</div>
				<div class="flex items-end p-2 gap-3">
					<c:choose>
						<c:when test="${param.noteType == 'send'}">
							<a href="list?noteType=resive&page=${page}" class="text-gray-500">받은 쪽지함</a>
							<span class="font-bold border-b-2 border-blue-500">보낸 쪽지함</span>
						</c:when>
						<c:otherwise>
							<span class="font-bold border-b-2 border-blue-500">받은 쪽지함</span>
							<a href="list?noteType=send&page=${page}" class="text-gray-500">보낸 쪽지함</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<form action="noteDelete">
				<input type="hidden" name="noteType" value="${param.noteType}" />
				<div class="flex justify-between">
					<div>
						<input type="checkbox" name="del__checkAll" value="Y" onchange="del__checkAll(this)" />
						<span>전체선택</span>
					</div>
					<div>
						<input type="submit" value="삭제" />
					</div>
				</div>
				<div class="border-b-4 border-t-4 rounded border-blue-700">
					<c:forEach var="note" items="${notes}">
						<div class="border-b">
							<div class="grid lg:grid-cols-3 grid-cols-2">
								<div>
									<input id="delBox" type="checkbox" name="delete__${note.nid}" value="Y" />
									<c:choose>
										<c:when test="${param.noteType == 'send'}">
											<span>받는사람 : </span>
										</c:when>
										<c:otherwise>
											<span>보낸사람 : </span>
										</c:otherwise>
									</c:choose>
									<span>${note.nickname}</span>
								</div>
								<div>
									<span>날짜 : ${Util.dateFormat(note.regDate)}</span>
								</div>
							</div>
							<div>
								<span class="px-4">${note.body}</span>
							</div>
						</div>
					</c:forEach>
				</div>
			</form>
			<div class="flex">
				<div class="flex justify-center text-lg flex-grow text-gray-700">
					<a href="list?page=1" class="p-2 hover:text-black hover:text-blue-500">처음</a>
					<a href="list?page=${printPageIndexDown}" class="p-2 hover:text-black hover:text-blue-500">이전</a>
					<c:forEach items='${printPageIndexs}' var='printPageIndex'>
						<c:choose>
							<c:when test="${printPageIndex == page}">
								<a href="list?page=${printPageIndex}" class="p-2 text-black font-extrabold">${printPageIndex}</a>
							</c:when>
							<c:otherwise>
								<a href="list?page=${printPageIndex}" class="p-2 hover:text-black hover:text-blue-500">${printPageIndex}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<a href="list?page=${printPageIndexUp}" class="p-2 hover:text-black hover:text-blue-500">다음</a>
					<a href="list?page=1000000" class="p-2 hover:text-black hover:text-blue-500">끝</a>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>