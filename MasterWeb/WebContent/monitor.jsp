<%@ taglib uri="WEB-INF/tld/tailtaglib.tld" prefix="t" %> 
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<!-- read last 50 rows and print them --> 
<t:tail file="${ param.f }" count="${ param.l }" id="S"> 
  <br><%=S%>
</t:tail>