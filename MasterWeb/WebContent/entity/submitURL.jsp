<% 
	String keyForLink = (String)request.getSession().getAttribute("keyForLink");
	String url = (String)request.getSession().getAttribute("linkURL");
	url = url +"&"+keyForLink;
	System.out.println("url==>"+url);
%>

<script type="text/javascript">

window.location = "<%=url%>";

</script>


