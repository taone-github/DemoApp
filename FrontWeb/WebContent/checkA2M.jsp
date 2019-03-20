<%@page import="com.a2m.ejb.service.A2MProxy"%>
<%@page import="com.a2m.service.proxy.ServiceProxyManager"%>
<%
ServiceProxyManager proxy = A2MProxy.getServiceProxyManager();
String Role = proxy.getRole("admin");
out.print("<B>Role: "+Role);
%>