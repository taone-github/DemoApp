<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.avalant.feature.FT039_SmartImageViewer"%>
<%@page import="com.master.util.MasterCacheUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
pageContext.setAttribute("version", "?v=" + MasterCacheUtil.time);
pageContext.setAttribute("images", FT039_SmartImageViewer.getImageJsonString(request));
%>

<script src="<c:url value="/eaf40/image-viewer/js/jquery.mousewheel.min.js"/>${version}" ></script>
<script src="<c:url value="/eaf40/image-viewer/js/smart-data.min.js"/>${version}" ></script>
<script src="<c:url value="/eaf40/image-viewer/js/smart-data-main.min.js"/>${version}" ></script>

<section id="smart_data" style="height: 700px"></section>

<script>
var SmartDataEntry = {
			isShow : true,
			show : function(e) {
				$('.SmartDataEntry').removeClass('collapse');
				if (e != false) {
					SmartDataEntry.isShow = true;
				}
			},
			hide : function(e) {
				$('.SmartDataEntry').addClass('collapse');
				if (e != false) {
					SmartDataEntry.isShow = false;
				}
			},
			toggle : function() {
				$('.SmartDataEntry').toggleClass('collapse');
				if ($('.SmartDataEntry').hasClass('collapse')) {
					SmartDataEntry.isShow = false;
				} else {
					SmartDataEntry.isShow = true;
				}
			}
		};
		
		$(function(){
			var images = <%=FT039_SmartImageViewer.getImageJsonString(request)%>;
			var templateId = "1";
			$.MasterWeb._smartData.instance = SmartInitializer.init(templateId, images, "#smart_data");//Located in main.js
		});

	</script>