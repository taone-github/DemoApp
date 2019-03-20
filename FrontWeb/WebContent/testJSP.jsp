
<html>
<body>
<%
long used  = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
%>

<%=used%>
</body>
</html>