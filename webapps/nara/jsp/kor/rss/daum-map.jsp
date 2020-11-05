<%@ page language="java" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://apis.daum.net/maps/maps.js?apikey=" charset="utf-8"></script>
</head>
<style type="text/css">
*{margin:0;padding:0;}
</style>
<body>
        <div id="map" style="width:600px;height:400px;"></div>
        <script type="text/javascript">
                var map =null;
                setTimeout(function(){
                 map = new DMap("map", {point:new DLatLng(37.3403, 126.5850), level:2}); 
                 map.addControl(new DIndexMapControl());
				 map.addControl(new DZoomControl());
               }, 1000);
        </script>
</body>
</html>