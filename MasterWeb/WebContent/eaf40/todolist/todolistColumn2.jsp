<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>

</head>
<body>
	<div class="container-fluid">
         <div class="row">
            <div class="col-md-12">
	            <div class="input-group stylish-input-group input-append" id="searchGroup">
                    <input type="text" class="form-control" id="textSearch" placeholder="Search" value="${criteria}" >
                    <span class="input-group-addon">
                        <button type="submit" id="btnSearch" onclick="search()">
                            <span class="fa fa-search icon-search-col2"></span>
                        </button>  
                    </span>
                </div>
            </div>
         </div>  
     </div>
     <div class="container-fluid column2">      
		<c:if test="${ todolistListMs == null || todolistListMs.size() == 0 }">
			<div class="sortby">
				<div class="row" >
					<h5 style="text-align: center;">No item found.</h5>
				</div>
			</div>
		</c:if>

		<c:forEach var="todolistM" items="${ todolistListMs }" varStatus="loop">
	 		<div class="sortby">
				<div class="row row-col2">
		              <div class="col2 card">
			                <div class="col-sm-3">
			                  	<img class="img-column" src="${pageContext.request.contextPath}/eaf40/todolist/resources/images/analytics.png">
			                </div>
			                <div class="col-sm-7">
				                  <h5 class="title"><c:out value="${ todolistM.name }"></c:out></h5>				                  
				                  <p class="p1"><c:out value="${ todolistM.createDate }"></c:out></p>
			                </div>
			                <div class="col-sm-2">
			                  	<span class="fa fa-bolt bolt2" aria-hidden="true"></span>
			                  	<a href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()%>/PDMonitor/frontWeb/taskMonitoring.html?taskId=${todolistM.id}&processName=${todolistM.processName}&instanceId=${todolistM.instanceId}"
			                  	   target="todolistMainPage">
				                  	<img class="ic-dashboard" src="${pageContext.request.contextPath}/eaf40/todolist/resources/images/icon_openmonitor.svg" >
		                  		</a>
				                <c:choose>
				                	<c:when test="${ todolistM.loadlinkEntityId != null && todolistM.loadlinkParam != null }">
				                		<!-- <a href="${pageContext.request.contextPath}/todolist/openEntity?id=${ todolistM.id }&processKey=${ todolistM.processName }&entityID=${ todolistM.loadlinkEntityId }&entityLinkParams=${ todolistM.loadlinkParam }" target="todolistMainPage"> -->
				                			<c:url value="/todolist/openEntity" var="url">
												<c:param name="id" value="${ todolistM.id }"></c:param>
												<c:param name="processKey" value="${ todolistM.processName }"></c:param>
												<c:param name="entityID" value="${ todolistM.loadlinkEntityId }"></c:param>
												<c:param name="entityLinkParams" value="${ todolistM.loadlinkParam }"></c:param>
											</c:url>
										
										<a href="${url}">
						                 	<img class="ic-dashboard" src="${pageContext.request.contextPath}/eaf40/todolist/resources/images/icon_form.svg">
					                 	</a>
				                	</c:when>
				                	<c:otherwise>
				                		<a href="javascript:alert('Colud not redirect to target page, no entity and parameters set');">
						                 	<img class="ic-dashboard" src="${pageContext.request.contextPath}/eaf40/todolist/resources/images/icon_form.svg">
					                 	</a>
				                	</c:otherwise>
				                </c:choose>
				               
			                </div>                 
		              </div>
		     	</div>
	      	 </div>
		  </c:forEach>  
		  
	  </div>
</body>
<script>

function search(){
    var textSearch = document.getElementById('textSearch').value 
    var uri = "<%=request.getContextPath()%>/todolist/init";
      dataString = "criteria=" + encodeURIComponent(textSearch);
      
      refreshPanel($('.column2'), '<%=request.getContextPath()%>/eaf40/todolist/loadData.jsp');
      
      jQuery.ajax({
        type: "POST",
        url: uri,
        data: dataString,
        success: function(data) {
            refreshPanel($('.column2'), '<%=request.getContextPath()%>/eaf40/todolist/todolistColumn2.jsp');
          }
      });   	
}
</script>
</html>