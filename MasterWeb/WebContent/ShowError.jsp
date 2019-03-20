<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isErrorPage="true" %>
<html>
<body>
    <b>Error:</b>${pageContext.exception}
    <br/><b>URL:</b>${pageContext.request.requestURI}
    
    <br/><b>Trace:</b>
    <c:forEach var="trace" items="${pageContext.exception.stackTrace}">
        <p>${trace}</p>
    </c:forEach>
</body>
</html>