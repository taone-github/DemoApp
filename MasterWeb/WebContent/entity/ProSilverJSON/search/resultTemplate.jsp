<%@ page contentType="text/html;charset=UTF-8"%>
<%
out.print(com.avalant.display.SearchResultDisplay.getInstance().resultHTMLByTemplate(request));
%>
<script type="text/javascript">
	$(document).ready( function() {
		$('.swapBtn').show();
	});
</script>