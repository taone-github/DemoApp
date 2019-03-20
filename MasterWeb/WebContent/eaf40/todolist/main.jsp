<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../style.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/3_3_30/jquery-custom-a.min.js"></script>
<script>
//Prevent auto-execution of scripts when no explicit dataType was provided (See gh-2432)
jQuery.ajaxPrefilter( function( s ) {
    if ( s.crossDomain ) {
        s.contents.script = false;
    }
});
</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/tododemo.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/material-dashboard.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/main.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/font-awesome.min.css" type="text/css" />


<style type="text/css">
.lb { width: 10%; display: inline-block; margin: 2px }
.ip { width: 80%; display: inline-block; margin: 2px }
</style>

</head>
<body>
	<div class="bodytodolist">
	
	   <!--  Colum 1 -->
	   <div class="col-md-3 column1">
	   	     <jsp:include flush="true" page="todolistColumn1.jsp"/>  
      </div>
      <!-- End column1 -->
      
      <!-- column2 -->
      <div class="col-md-3 column2" id="a1">
	        <jsp:include flush="true" page="todolistColumn2.jsp"/> 
      </div>
      <!-- end column2 -->
      
      <!-- column3 -->
      <div class="col-md-6 col3-column3" id='column3-form'>
      		<!-- <div class="row"><i class="fa fa-angle-double-right" aria-hidden="true" onclick="slideProcessShow()"></i></div> -->
	        <%-- <jsp:include flush="true" page="todolistColumn3.jsp"/> --%> 
	        <iframe src="${pageContext.request.contextPath}/eaf40/todolist/todolistColumn3.jsp"
	        	name="todolistMainPage" id="todolistMainPage" width="100%" height="100%" frameborder="0">
        	</iframe>
      </div>
      <!-- end column3 -->
	</div>
</body>

<script>
   function refreshPanel(container, jspPath) {
     var uri = jspPath;
        
     jQuery.ajax({
       type: "POST",
       url: uri,
       success: function(data){  
         $(container).html(data);
       }
     }); 
   }
   function slideProcessShow() {
		$('.column1').slideToggle();		
		$('.column2').slideToggle();
	}
</script>


</html>