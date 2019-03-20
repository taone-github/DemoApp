<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<script type="text/javascript">
	function mapValueToComponent(fieldName, fieldValue){
		if(document.getElementById(fieldName)){
			if(document.getElementById(fieldName).value == null || document.getElementById(fieldName).value == ""){
				document.getElementById(fieldName).value = fieldValue;
			}
		}
	}
	function manualJSInterface(){
		/* your code here */
	}
</script>

<%
	try{
		HashMap hmDefaultInsert = (HashMap) request.getSession().getAttribute("hmDefaultInsert_session");
		if(null != hmDefaultInsert && hmDefaultInsert.size() > 0){
			ArrayList keyDefaultInsert =  new ArrayList(hmDefaultInsert.keySet());
			if(null != keyDefaultInsert && keyDefaultInsert.size() > 0){
				for(int i=0; i<keyDefaultInsert.size(); i++){
					String fieldName = (String) keyDefaultInsert.get(i);
					String fieldValue = (String) hmDefaultInsert.get(keyDefaultInsert.get(i));
%>
					<script type="text/javascript">
						mapValueToComponent('<%=fieldName%>', '<%=fieldValue%>');
					</script>
<%
				}
%>
					<script type="text/javascript">
						manualJSInterface();
					</script>
<%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>