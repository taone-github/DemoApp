<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.Public"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<html>
<head>

</head>
<body>
	<div class="process-header">
		<span class="text-process-span">PROCESS</span>
	    <a class="fa fa-angle-down pull-right angle-process" data-toggle="collapse" href="#collapse1" ></a>
    </div>
   	<div class="process-name" id="collapse1">
		<ul class="nav text-process">
       	<%
	 		int i = 1;
       		Map<Object,Integer> process = new LinkedHashMap<Object,Integer> ();

       	%> 	
       		<c:forEach var="todolistM" items="${ todolistListMs }" varStatus="loop">
       			<c:set var="procressName" value="${ todolistM.processName }"></c:set>
				<%
					process.put(pageContext.getAttribute("procressName"), i++);							
				%>
       		</c:forEach>
       		
       		<%-- ${fn:trim(string1)} --%>
		<%
		request.setAttribute("map", process);
		%>
        	<c:forEach var="map" items="${map}" varStatus="loop">
			     <li class="label label-default">
		         	<a class="process" href="javascript:void(0)" onclick="searchProcessName('${ map.key }')">
		         	   <img src="<c:url value="../eaf40/todolist/resources/images/process.png" />" class="col-1-img pull-left">
		               	<span class="process-name-text" id="${fn:trim(map.key)}" data-toggle="tooltip" title="${fn:trim(map.key)}"><c:out value="${ fn:trim(map.key) }"></c:out>              
						</span>
		               <span class="number pull-right"><c:out value="${ map.value}"></c:out></span>
		         	</a>
		       	</li>
			</c:forEach>	       		
    	</ul>
    </div>
    <hr>
</body>

<script>	
   function searchProcessName(id){ 
     var textSearch = id;//document.getElementById(id).innerHTML;
     //var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.asset.person.SearchProcessName";
     var uri = "<%=request.getContextPath()%>/todolist/init";
       dataString = "processName=" + encodeURIComponent(textSearch);
       
       refreshPanel($('.column2'), '<%=request.getContextPath()%>/eaf40/todolist/loadData.jsp');
       
       jQuery.ajax({
         type: "POST",
         url: uri,
         data: dataString,
         success: function(data){  
             refreshPanel($('.column2'), '<%=request.getContextPath()%>/eaf40/todolist/todolistColumn2.jsp');
             
           }
       });   	
   }
   
</script>
</html>