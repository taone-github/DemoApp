<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="com.a2m.ejb.service.A2MEJBService"%>
<%@page import="com.a2m.ejb.user.UserDetailManager"%>
<%@page import="com.a2m.ejb.service.A2MProxy"%>
<%@page import="com.a2m.service.proxy.ServiceProxyManager"%>
<%@page import="com.master.model.ConstantSystemM"%>
<%@page import="com.master.constant.ConstantSystem"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.oneweb.j2ee.system.LoadXML"%>
<%@page import="com.schedulerEAF.propertires.EAFSchedulerReadProperties"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<link rel="stylesheet" href="/theme/dist/css/skins/skin-blue.min.css"/>
<link rel="stylesheet" href="/theme/dist/css/AdminLTE.min.css"/>
<h3>Setup</h3>
<%
String strutName = "EAFCoreMaster";
String EAF_DATA_SOURCE = EAFSchedulerReadProperties.EAF_DATA_SOURCE;
String JAVA_ENV = LoadXML.getLoadXML(strutName).getJavaENV();
String EAFSchemaName = LoadXML.getLoadXML(strutName).getSchemaName();
String EAFSchemaNameSql = !StringUtils.isEmpty(EAFSchemaName) ? EAFSchemaName+"." : EAFSchemaName;

InitialContext ctx = new InitialContext();
DataSource dataSource = (DataSource)ctx.lookup(JAVA_ENV + EAF_DATA_SOURCE);

JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
List<Map<String, Object>> systemList = (List<Map<String, Object>>)jdbcTemplate.queryForList("select * from " +  EAFSchemaNameSql + "M_METAB_SYSTEM");
ConstantSystem constantSystem = new ConstantSystem("EAF", strutName);
%>
<table border="1">
	<tr>
		<td>JAVA_ENV</td><td><%=JAVA_ENV %></td>
	</tr>
	<tr>
		<td>EAF_DATA_SOURCE</td><td><%=EAF_DATA_SOURCE %></td>
	</tr>
	<tr>
		<td>schemaName</td><td><%=EAFSchemaName %></td>
	</tr>
	<tr>
		<td>METAB_SYSTEM</td>
		<td>
			<table border="1">
			<tr>
				<th>SYSTEM_CODE</th><th>JNDI_NAME</th><th>SCHEMA_NAME</th><th>Valid</th>
			</tr>
			<% 
			for(Map map : systemList) {
				String eStr = "";
				boolean valid = false;
				Connection c = null;
				try {
					DataSource dataSource_2 = (DataSource)ctx.lookup((String)map.get("JNDI_NAME")); 
					c = dataSource_2.getConnection();
					valid = true;
				} catch(Exception e) {
					eStr = "[" +e.getLocalizedMessage() +"]";
					e.printStackTrace();
				} finally {
					if(c != null) {
						c.close();
						c = null;
					}
				}
				%>
				<tr>
					<td><%=map.get("SYSTEM_CODE") %></td><td><%=map.get("JNDI_NAME") %></td><td><%=map.get("SCHEMA_NAME") %></td><td><%=valid + " " + eStr%></td>
				</tr>
				<%
			}
			%>
			</table>
		</td>
	</tr>
	<tr>
		<td>METAB_CONSTANT</td>
		<td>
			<table border="1">
			<tr>
				<th>CONSTANT_NAME</th><th>CONSTANT_VALUE</th>
			</tr>
			<tr>
				<td>USE_IAS</td><td><%=((ConstantSystemM)ConstantSystem.constantList.get("USE_IAS")).getConStantValue() %></td>
			</tr>
			<tr>
				<td>IAS_VERSION</td><td><%=((ConstantSystemM)ConstantSystem.constantList.get("IAS_VERSION")).getConStantValue() %></td>
			</tr>
			<tr>
				<td>LOG_CONFIG_FRONT</td><td><%=((ConstantSystemM)ConstantSystem.constantList.get("LOG_CONFIG_FRONT")).getConStantValue() %></td>
			</tr>
			<tr>
				<td>LOG_CONFIG_MASTER</td><td><%=((ConstantSystemM)ConstantSystem.constantList.get("LOG_CONFIG_MASTER")).getConStantValue() %></td>
			</tr>
			<tr>
				<td>SECURITY_LEVEL</td><td><%=((ConstantSystemM)ConstantSystem.constantList.get("SECURITY_LEVEL")).getConStantValue() %></td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>A2M</td>
		<td>
			<table border="1">
				<tr>
					<td>ServiceProxyManager</td>
					<td>
					<% 
					boolean a2m = false;
					String a2mError = "";
					try {
						ServiceProxyManager proxy = A2MProxy.getServiceProxyManager();
						a2m = proxy != null;
					} catch(Exception e) {
						e.printStackTrace();
						a2mError = "["+e.getLocalizedMessage()+"]";
					}
					%>
					<%=a2m %> <%=a2mError %>
					</td>
				</tr>
				<tr>
					<td>UserDetailManager</td>
					<td>
					<% 
					a2m = false;
					a2mError = "";
					try {
						UserDetailManager userManager = A2MEJBService.getUserDetailManager();
						a2m = userManager != null;
					} catch(Exception e) {
						e.printStackTrace();
						a2mError = "["+e.getLocalizedMessage()+"]";
					}
					%>
					<%=a2m %> <%=a2mError %>
					</td>
				</tr>
			</table>
		
		</td>
	</tr>
</table>