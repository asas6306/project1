<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>
<%@ page import="com.example.demo.util.Util"%>

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
			<form action="noteDelete" class="noteDelete__form">
				<input type="hidden" name="noteType" value="${param.noteType}" />
				<c:if test="${param.page != null}">
					<input type="hidden" name="page" value="${param.page}" />
				</c:if>
				<c:if test="${param.noteType != null}">
					<input type="hidden" name="noteType" value="${param.noteType}" />
				</c:if>
				<div class="flex justify-between px-1">
					<div>
						<input type="checkbox" onchange="del__checkAll(this)" />
						<span>전체선택</span>
					</div>
					<script>
					function del__checkAll(btn){
						if(btn.checked) {
							$("input[type=checkbox][id=delBox]").prop("checked", true);								
						} else {
							$("input[type=checkbox][id=delBox]").prop("checked", false);
						}
					}
					</script>
					<div class="flex items-center">
						<input type="submit" value="삭제" class="px-1 rounded bg-red-300 hover:bg-red-500" />
					</div>
				</div>
				<div class="border-b-4 border-t-4 rounded border-blue-700 px-1">
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
								<c:choose>
									<c:when test="${note.read}">
										<span class="px-4" onclick="location.reload();">${note.body}</span>
									</c:when>
									<c:otherwise>
										<span class="px-4 font-bold" onclick="open__note(${note.nid});">${note.body}</span>
									</c:otherwise>
								</c:choose>
								<script>
								function open__note(nid) {
									window.open("detail?nid=" + nid + "&type=receive", "", "width=400 height=375 left=500 top=100, location=no, resizable=no");
									location.reload();
								}
								</script>
							</div>
						</div>
					</c:forEach>
				</div>
			</form>
			<div class="flex">
				<div class="flex justify-center text-lg flex-grow text-gray-700">
					<a href="list?noteType=${param.noteType}&page=1" class="p-2 hover:text-black hover:text-blue-500">처음</a>
					<a href="list?noteType=${param.noteType}&page=${printPageIndexDown}" class="p-2 hover:text-black hover:text-blue-500">이전</a>
					<c:forEach items='${printPageIndexs}' var='printPageIndex'>
						<c:choose>
							<c:when test="${printPageIndex == page}">
								<a href="list?noteType=${param.noteType}&page=${printPageIndex}" class="p-2 text-black font-extrabold">${printPageIndex}</a>
							</c:when>
							<c:otherwise>
								<a href="list?noteType=${param.noteType}&page=${printPageIndex}" class="p-2 hover:text-black hover:text-blue-500">${printPageIndex}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<a href="list?noteType=${param.noteType}&page=${printPageIndexUp}" class="p-2 hover:text-black hover:text-blue-500">다음</a>
					<a href="list?noteType=${param.noteType}&page=1000000" class="p-2 hover:text-black hover:text-blue-500">끝</a>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>