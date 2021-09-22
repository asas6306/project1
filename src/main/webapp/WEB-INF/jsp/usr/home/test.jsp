<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.example.demo.util.Util"%>
<%@ include file="../part/mainLayoutHeader.jspf"%>

<section class="main-setting flex justify-center">
	<div class="flex justify-center container">
		<div class="w-full">
			<div class="w-full">hi</div>
			<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=yfaodwt4aq"></script>
			<div id="map" style="width:100%;height:400px;"></div>

			<script>
			var mapOptions = {
			    center: new naver.maps.LatLng(36.28844821350354, 127.24170138246308),
			    zoom: 19
			};
			
			var map = new naver.maps.Map('map', mapOptions);
			</script>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFooter.jspf"%>