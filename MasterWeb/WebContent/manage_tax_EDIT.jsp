<%@ page import="java.util.Vector"; %>
<%@ page import="java.util.HashMap"; %>
<%@ page import="com.oneweb.j2ee.pattern.util.DisplayFormatUtil"; %>
<HTML sizset="0" sizcache07209820749109468="0">
<HEAD><TITLE>Avalant</TITLE>
<style type="text/css">
	.group-container {height:100%;}
	.textbox1 {overflow:hidden !important; height: auto !important;}
	.textbox50left .textbox1,.textbox50right .textbox1  {overflow:hidden; height:30px !important;}
	.textbox50left,.textbox50right {/*overflow:hidden;*/height:auto !important;}
	.table_data tr td {border:1px #C0C0C0 solid;}
	.headerFontStyle {font-family : "Droid Sans", sans-serif; font-size : 9pt; font-weight : bold;}
</style>
<SCRIPT language=javascript src="/MasterWeb/javascript/field_property/money.js"></SCRIPT>
<!-- EAF Version 3.3.30 use  jquery-1.7.2
<script language="javascript" src="/MasterWeb/javascript/custom_framework/jquery-1.3.2.js"></script>
 -->
<SCRIPT language=JavaScript src="/MasterWeb/javascript/3_3_30/jquery-1.7.2.min.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/javascript/custom_framework/jqueryEditInLineDivTheme.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/javascript/custom_framework/jqueryScrollingNavigator.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/javascript/custom_framework/jqueryUtil.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/javascript/custom_framework/blockScreen.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/javascript/custom_framework/jquery.blockUI.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/javascript/constant.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/date-picker.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/DateFormat.js"></SCRIPT>

<SCRIPT language=javascript src="/MasterWeb/popcalendar.js"></SCRIPT>
<script language="JavaScript" src="/MasterWeb/javascript/3_3_30/jquery-ui-1.8.23.custom.min.js"></script>
<script language="JavaScript" src="/MasterWeb/javascript/3_3_30/jquery-radio-0.0.1.js"></script>
<script language="JavaScript" src="/MasterWeb/javascript/3_3_30/jquery-checkbox-0.0.1.js"></script>
<script language="JavaScript" src="/MasterWeb/javascript/3_3_30/jquery-listbox-0.0.1.js"></script>
<script language="JavaScript" src="/MasterWeb/javascript/3_3_30/jquery-ui-1.8.10.offset.datepicker.min.js"></script>
<script language="JavaScript" src="/MasterWeb/javascript/3_3_30/eafObject.js"></script>
<script type="text/javascript" src="/MasterWeb/manual/js/entity/manage_tax_function_EDIT.js"></script>
<script type="text/javascript" src="/MasterWeb/manual/js/entity/manage_tax_function.js"></script>

<% String taxNO = (String)request.getSession().getAttribute("TAX_NO"); 
	HashMap InterfaceHeader = (HashMap)request.getSession().getAttribute("InterfaceHeader"); 
	String Inv_No = InterfaceHeader.get("INVOICE_NO").toString();
	String Cus_Name = InterfaceHeader.get("CUSTOMER_NAME").toString();
	String Ref_No = InterfaceHeader.get("REF_NO").toString();
	String TNet_Price = InterfaceHeader.get("TOTAL_NET_PRICE").toString();
	String FPrice = InterfaceHeader.get("FREIGHT_PRICE").toString();
	String TBeforeVat = InterfaceHeader.get("TOTAL_BEFORE_VAT").toString();
	String Vat = InterfaceHeader.get("VAT").toString();
	String GTotal = InterfaceHeader.get("GRAND_TOTAL").toString();
	String Cost_Margin = InterfaceHeader.get("COST_MARGIN").toString();
	String Status = InterfaceHeader.get("STATUS_DESC").toString();
	String DOTotal = InterfaceHeader.get("GRAND_TOTAL_PRICE").toString();
	String Cus_ID = InterfaceHeader.get("CUSTOMER_ID").toString();
	String Tax_Inv_Date = InterfaceHeader.get("TAX_DATE").toString();
 	String Mag_Inv_Date = InterfaceHeader.get("MANAGE_TAX_DATE").toString();
%>

<script type="text/javascript">
var tableresult;
$(document).ready(function(){
	var sessionresult = "<%= taxNO %>";
	//getCurrentMS(sessionresult);
	//stockdumitemOnLoad();
	//getHeader('<%=taxNO %>');
	//unitCostMargin4Dummy();
	//CalcostMarginWithUCost();
	textfieldCal();
	taxinvtextfieldCal();
});


</script>


<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Calendar" %>
<%-- <%@ page import="com.tcrb.accounting.dao.AccountingDAOImpl"; %> --%>
<%-- <%@ page import="com.tcrb.accounting.dao.AccountingDAO"; %> --%>
<%@ page import="java.util.Vector"; %>
<%@ page import="java.util.HashMap"; %>
</HEAD>
<%
	DecimalFormat dformat = new DecimalFormat("00");
	Calendar c = java.util.Calendar.getInstance();

	StringBuffer date = new StringBuffer();
	date.append(dformat.format(c.get(Calendar.DAY_OF_MONTH))).append("/");
	date.append(dformat.format(c.get(Calendar.MONTH) + 1)).append("/");
	date.append(c.get(Calendar.YEAR));
	date.toString();
%>

<BODY style="HEIGHT: 100%; OVERFLOW: hidden; CURSOR: auto" sizset="0" sizcache07209820749109468="0">
<DIV style="Z-INDEX: 998; POSITION: absolute; DISPLAY: none; VISIBILITY: hidden" id=calendar onclick=bShow=true>
	<TABLE style="BORDER-BOTTOM: #a0a0a0 1px solid; BORDER-LEFT: #a0a0a0 1px solid; FONT-FAMILY: arial; FONT-SIZE: 11px; BORDER-TOP: #a0a0a0 1px solid; BORDER-RIGHT: #a0a0a0 1px solid" width=220 bgColor=#ffffff>
	<TBODY>
	<TR bgColor=#f1daaf>
		<TD>
			<TABLE width=218>
				<TBODY>
					<TR>
						<TD style="PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 2px; FONT-FAMILY: arial; FONT-SIZE: 11px; PADDING-TOP: 2px"><FONT color=#754c24><B><SPAN id=caption><SPAN style="BORDER-BOTTOM: #a0a0a0 1px solid; BORDER-LEFT: #a0a0a0 1px solid; BORDER-TOP: #a0a0a0 1px solid; CURSOR: pointer; BORDER-RIGHT: #a0a0a0 1px solid" id=spanLeft onmouseup=clearTimeout(timeoutID1);clearInterval(intervalID1) onmouseover='swapImage("changeLeft","left2.gif");this.style.borderColor="#88AAFF";window.status="Click to scroll to previous month. Hold mouse button to scroll automatically."' onmouseout='clearInterval(intervalID1);swapImage("changeLeft","left1.gif");this.style.borderColor="#A0A0A0";window.status=""' onmousedown='clearTimeout(timeoutID1);timeoutID1=setTimeout("StartDecMonth()",500)' onclick=javascript:decMonth()>&nbsp;<IMG id=changeLeft border=0 src="http://localhost:9080/MasterWeb/images/calendar/left1.gif">&nbsp;</SPAN>&nbsp;<SPAN style="BORDER-BOTTOM: #a0a0a0 1px solid; BORDER-LEFT: #a0a0a0 1px solid; BORDER-TOP: #a0a0a0 1px solid; CURSOR: pointer; BORDER-RIGHT: #a0a0a0 1px solid" id=spanRight onmouseup=clearTimeout(timeoutID1);clearInterval(intervalID1) onmouseover='swapImage("changeRight","right2.gif");this.style.borderColor="#88AAFF";window.status="Click to scroll to next month. Hold mouse button to scroll automatically."' onmouseout='clearInterval(intervalID1);swapImage("changeRight","right1.gif");this.style.borderColor="#A0A0A0";window.status=""' onmousedown='clearTimeout(timeoutID1);timeoutID1=setTimeout("StartIncMonth()",500)' onclick=incMonth()>&nbsp;<IMG id=changeRight border=0 src="http://localhost:9080/MasterWeb/images/calendar/right1.gif">&nbsp;</SPAN>&nbsp;<SPAN style="BORDER-BOTTOM: #a0a0a0 1px solid; BORDER-LEFT: #a0a0a0 1px solid; BORDER-TOP: #a0a0a0 1px solid; CURSOR: pointer; BORDER-RIGHT: #a0a0a0 1px solid" id=spanMonth onmouseover='swapImage("changeMonth","drop2.gif");this.style.borderColor="#88AAFF";window.status="Click to select a month."' onmouseout='swapImage("changeMonth","drop1.gif");this.style.borderColor="#A0A0A0";window.status=""' onclick=popUpMonth()></SPAN>&nbsp;<SPAN style="BORDER-BOTTOM: #a0a0a0 1px solid; BORDER-LEFT: #a0a0a0 1px solid; BORDER-TOP: #a0a0a0 1px solid; CURSOR: pointer; BORDER-RIGHT: #a0a0a0 1px solid" id=spanYear onmouseover='swapImage("changeYear","drop2.gif");this.style.borderColor="#88AAFF";window.status="Click to select a year."' onmouseout='swapImage("changeYear","drop1.gif");this.style.borderColor="#A0A0A0";window.status=""' onclick=popUpYear()></SPAN>&nbsp;&nbsp;<A href="javascript:setBlank();"><SPAN style="FONT-FAMILY: arial; COLOR: #754c24; FONT-SIZE: 11px" id=lblToday>Clear</SPAN></A>&nbsp;</SPAN></B></FONT></TD>
						<TD align=right>
							<A href="javascript:hideCalendar();">
							<IMG border=0 alt="Close the Calendar" src="/MasterWeb/images/calendar/close.gif" width=15 height=13>
							</A>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</TD>
	</TR>
	<TR>
		<TD style="PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 2px; PADDING-TOP: 2px" bgColor=#ffffff>
			<SPAN id=content></SPAN>
		</TD>
	</TR>
	<TR bgColor=#f0f0f0>
		<TD style="PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px" align=middle>
		<SPAN style="FONT-FAMILY: arial; COLOR: #9e0b0e; FONT-SIZE: 11px" id=lblToday>Today is <A style="FONT-FAMILY: arial; COLOR: #303030; FONT-SIZE: 11px; TEXT-DECORATION: none" onmousemove='window.status="Go To Current Month"' title="Go To Current Month" onmouseout='window.status=""' href="javascript:monthSelected=monthNow;yearSelected=yearNow;constructCalendar();">Mon, 17 Dec 2012</A>
		</SPAN>
		</TD>
	</TR>
	</TBODY>
	</TABLE>
</DIV>
<DIV style="Z-INDEX: 999; POSITION: absolute; VISIBILITY: hidden" id=selectMonth></DIV>
<DIV style="Z-INDEX: 999; POSITION: absolute; VISIBILITY: hidden" id=selectYear></DIV><!-- script language="JavaScript" src="date-picker.js" type="text/javascript"></script> --><!-- <script language="JavaScript" src="DateFormat.js" type="text/javascript"></script> -->
<SCRIPT language=JavaScript type=text/javascript src="masterJS.js"></SCRIPT>

<SCRIPT language=JavaScript type=text/javascript src="Ajax.js"></SCRIPT>

<SCRIPT language=JavaScript type=text/javascript src="openDialog.js"></SCRIPT>

<SCRIPT language=JavaScript type=text/javascript src="tiny_mce/tiny_mce.js"></SCRIPT>

<SCRIPT language=javascript src="manual/js/manualAvale.js"></SCRIPT>

<SCRIPT language=JavaScript type=text/javascript src="sessionTimeOut.js"></SCRIPT>

<SCRIPT language=JavaScript type=text/javascript src="javascript/checkBoxUtil.js"></SCRIPT>

<SCRIPT language=JavaScript src="javascript/3_3_30/jquery-ui-1.8.23.custom.min.js"></SCRIPT>

<SCRIPT language=JavaScript src="javascript/3_3_30/jquery-radio-0.0.1.js"></SCRIPT>

<SCRIPT language=JavaScript src="javascript/3_3_30/jquery-checkbox-0.0.1.js"></SCRIPT>

<SCRIPT language=JavaScript src="javascript/3_3_30/jquery-listbox-0.0.1.js"></SCRIPT>

<SCRIPT language=JavaScript src="javascript/3_3_30/jquery-ui-1.8.10.offset.datepicker.min.js"></SCRIPT>

<SCRIPT language=JavaScript src="javascript/3_3_30/eafObject.js"></SCRIPT>

<!-- 
	Sam add for Timeout 
	17/11/2011
 --><INPUT value=1800 type=hidden name=sessiontimeout jQuery17205468099930550848="49"> 
<DIV style="POSITION: relative; WIDTH: 100%; HEIGHT: 100%; OVERFLOW: auto" id=container>
<TABLE class=BackgroudColour border=0 cellSpacing=0 cellPadding=0 width="100%" height="100%">
<TBODY>
<TR>
<TD style="padding:0px;">
<TABLE style="margin:0px;position:absolute;top:0px;" border=0 cellSpacing=0 cellPadding=0  width="100%" align=center height="100%">
<TBODY>
<TR>
<TD vAlign=top>
<LINK rel=StyleSheet type=text/css href="theme/init_Style.css">
<LINK rel=StyleSheet type=text/css href="/MasterWeb/theme/ProSilver_back/PS1_Style.css">
<LINK rel=StyleSheet type=text/css href="/MasterWeb/theme/ProSilver_back/PS1_Navigation_Style.css">
<LINK rel=StyleSheet type=text/css href="/MasterWeb/theme/ProSilver_back/PS1_Custom_Style.css">

<DIV id=EN_01_NEW427Div class=insertScreen>
<FORM method=post name=masterForm action=FrontController>
<INPUT type=hidden name=action jQuery17205468099930550848="50"> 
<INPUT type=hidden name=handleForm jQuery17205468099930550848="51"> 
<INPUT type=hidden name=sessionForm jQuery17205468099930550848="52"> 
<INPUT type=hidden name=currentTab jQuery17205468099930550848="53"> 
<INPUT type=hidden name=goEntity jQuery17205468099930550848="54"> 
<INPUT type=hidden name=goEntityTab jQuery17205468099930550848="55"> 
<INPUT type=hidden name=keyForSearch jQuery17205468099930550848="56"> 
<INPUT type=hidden name=goEntityKey jQuery17205468099930550848="57"> 
<INPUT type=hidden name=goEntityField jQuery17205468099930550848="58"> 
<INPUT type=hidden name=nextTab jQuery17205468099930550848="59"> 
<INPUT type=hidden name=nextEntity jQuery17205468099930550848="60"> 
<INPUT type=hidden name=backEntityTab jQuery17205468099930550848="61"> 
<INPUT type=hidden name=interfaceParam jQuery17205468099930550848="62"> 
<INPUT type=hidden name=saveDraftFlag jQuery17205468099930550848="63"> 

<INPUT type=hidden name=entityID jQuery17205468099930550848="64" value=""> 
<INPUT type=hidden name=tabID jQuery17205468099930550848="65" value=""> 
<INPUT type=hidden name=searchForUpdate jQuery17205468099930550848="66" value=""> 

<DIV class=rightcontent>
<DIV class=spacetop><!-- Top 10 px --></DIV>
<DIV class=left-white-10px><!-- left 10 px --><!-- 2 Layer Tab -->

<!--  Header -->
<DIV class=bgtabrightmenu>
	<DIV class=tabend></DIV><!-- For support span <div class="taballs"></div> -->
	<DIV class=generalTab>
		<SPAN class=tabno1Current></SPAN>
		<SPAN class=tabno2Current>
			<SPAN id=TAB_ID_1121432178 class=textontabGeneral>Manage Tax Invoice </SPAN>
		</SPAN>
		<SPAN class=tabno3Current></SPAN>
	</DIV>
</DIV>



<br>
<fieldset>
<legend class="headerFontStyle">Tax Invoice</legend>

<DIV class=textbox1>
	<DIV class=textbox50left>
	
	<div class=textbox1>	
		
			<DIV class=componentSelect></DIV>
			<DIV id=TAX_INVOICE_LabelField class=componentNameDiv>Tax Invoice : </DIV>
			<DIV id=TAX_INVOICE_InputField class=componentDiv>
			<INPUT name="Tax_Inv" class="listboxtype" type="textbox" readOnly="readonly" value="<%= taxNO %>">
			</DIV>
		
	</div>
	
	<div class=textbox1>	
			<DIV class=componentSelect></DIV>
			<DIV id=DE_ORDER_NO_LabelField class=componentNameDiv>Invoice No. : </DIV>
			<DIV id=DE_ORDER_NO_InputField class=componentDiv>
			<INPUT class="listboxtype" name="DE_ORDER_NO" type=textbox readOnly="readonly" value="<%=Inv_No %>">
			</DIV>
	</div>
	
	<div class=textbox1>
 		
			<DIV class=componentSelect></DIV>
			<DIV id=MANAGE_TAX_DATE_LabelField class=componentNameDiv>Manage Tax Date : </DIV>
			<DIV id=MANAGE_TAX_DATE_InputField class=componentDiv>
				<INPUT title="Manage Tax Date" readOnly="readonly" type="textbox" class="listboxtype" name="MAG_TAX_DATE" value="<%=Mag_Inv_Date %>">
				<!-- <INPUT title="System current date" readonly="readonly" onblur=javascript:checkDate(this,false) onkeydown="javascript:DateFormat(this,this.value,event,false,'1')" id=M_DATE class="calendarEN" type=textbox name=MAG_TAX_DATE>
				<IMG class=ui-datepicker-trigger title=... alt=... src="images/calendar_new.gif" width=18 height=18/>
				-->
			</DIV>
		
	</div>
	
	<div class=textbox1>	
			<DIV class=componentSelect></DIV>
			<DIV id=STATUS_LabelField class=componentNameDiv>Status : </DIV>
			<DIV id=STATUS_InputField class=componentDiv>
				<INPUT class="listboxtype" name="STATUS" type="textbox" readOnly="readonly" value="<%=Status %>">
			</DIV>
	</div>
	
			
	</DIV>
	<DIV class=textbox50right>
	
	<div class=textbox1>
		
			<DIV class=componentSelect></DIV>
			<DIV id=TAX_INVOICE_DATE_LabelField class=componentNameDiv>Tax Invoice Date : </DIV>
			<DIV id=TAX_INVOICE_DATE_InputField class=componentDiv>
				<INPUT title="Tax Invoice Date" readOnly="readonly" type="textbox" class="listboxtype" name="TAX_INV_DATE" value="<%=Tax_Inv_Date %>">
				<!-- <INPUT readonly="readonly" onblur=javascript:checkDate(this,false) onkeydown="javascript:DateFormat(this,this.value,event,false,'1')" id=T_DATE class="calendarEN" onkeypress=javascript:keyPressInteger() maxLength=20 size=30 type=textbox name=TAX_INV_DATE >
					<IMG class=ui-datepicker-trigger title=... alt=... src="images/calendar_new.gif" width=18 height=18 jQuery17205468099930550848="134"/>
				-->
			</DIV>
		
	</div>
	
	<div class=textbox1>
		
			<DIV class=componentSelect></DIV>
			<DIV id=CUSTOMER_LabelField class=componentNameDiv>Customer</DIV>
			<DIV id=CUSTOMER_InputField class=componentDiv>
				<INPUT name="Customer_01" class="listboxtype" type="textbox" readOnly="readonly" value="<%=Cus_Name %>">
				<INPUT style="display: none;" name="CusID" class="listboxtype" type="textbox" readOnly="readonly" value="<%=Cus_ID %>">
			</DIV>
		
	</div>

	<div class=textbox1>
		
			<DIV class=componentSelect></DIV>
			<DIV id=INVOICE_NO_LabelField class=componentNameDiv>Ref No. : </DIV>
			<DIV id=INVOICE_NO_InputField class=componentDiv>
				<INPUT title="Enter Reference Number" name="Sale_Order_No" class="listboxtype" type="textbox" size="30" maxLenght="20" value="<%=Ref_No %>">
			</DIV>
		
	</div>
	
		
	</DIV>	
</DIV>

</fieldset>
<br>
<fieldset>
<legend class="headerFontStyle">Compare Price</legend>

<DIV class=textbox1>
	<div class=textbox50left>
	<fieldset>
	<legend class="headerFontStyle">Delivery Order</legend>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxLeft_0 class=textbox50left>
					<DIV class=componentSelect></DIV>
					<DIV id=TOTAL_LabelField class=componentNameDiv>Total </DIV>
					<DIV id=TOTAL_InputField class=componentDiv>
					<INPUT id="CP_TOTAL" name="Total" class="listboxtype" type="textbox" readOnly="readonly" value="0" value="<%=DOTotal %>">
					</DIV>
			</DIV>
		</DIV>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxLeft_1 class=textbox50left>
					<DIV class=componentSelect></DIV>
					<DIV id=F_O_CHARGE_LabelField class=componentNameDiv>Freight & Other Charge </DIV>
					<DIV id=F_O_CHARGE_InputField class=componentDiv>
						<INPUT title="Enter number to calculate" name="Fre_Other_Charge" class="listboxtype" type="textbox" value="0" onkeypress="return isNumberic(event,this)" onfocus="if (this.value=='0')this.value=''" onblur="if (this.value=='')this.value='0';isNull(this);textfieldCal(this);taxinvtextfieldCal(this);">
					</DIV>
			</DIV>
		</DIV>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxLeft_2 class=textbox50left>
					<DIV class=componentSelect></DIV>
					<DIV id=GRAND_TOTAL_LabelField class=componentNameDiv>Grand Total </DIV>
					<DIV id=GRAND_TOTAL_InputField class=componentDiv>
						<INPUT name="Grand_Total" class="listboxtype" type="textbox" readOnly="readonly" value="0">
					</DIV>
			</DIV>
		</DIV>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxLeft_3 class=textbox50left>
					<DIV class=componentSelect></DIV>
					<DIV id=ADV_PAY_LabelField class=componentNameDiv>Advance Payment </DIV>
					<DIV id=ADV_PAY_InputField class=componentDiv>
						<INPUT title="Enter number to calculate" name="Adv_Payment" class="listboxtype" type="textbox" value="0" onfocus="if (this.value=='0')this.value=''" onblur="if (this.value=='')this.value='0';isNull(this);textfieldCal(this)">
					</DIV>
			</DIV>
		</DIV>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxLeft_4 class=textbox50left>
					<DIV class=componentSelect></DIV>
					<DIV id=BALANCE_LabelField class=componentNameDiv>Balance </DIV>
					<DIV id=BALANCE_InputField class=componentDiv>
					<INPUT name="Balance" class="listboxtype" type="textbox" readOnly="readonly" value="0">
					</DIV>
			</DIV>
		</DIV>
	</fieldset>
	</div>
	
			
	<div class=textbox50right>
	<fieldset >
	<legend class="headerFontStyle">Tax Invoice</legend>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxRight_0 class=textbox50right>
					<DIV class=componentSelect></DIV>
					<DIV id=TOTAL_LabelField class=componentNameDiv>Total </DIV>
					<DIV id=TOTAL_InputField class=componentDiv>
					<INPUT name="Total_Inv" class="listboxtype" type="textbox" onclick="TaxInv_Total(this);"	readOnly="readonly" value="<%=TNet_Price %>">
					</DIV>
			</DIV>
		</DIV>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxRight_1 class=textbox50right>
					<DIV class=componentSelect></DIV>
					<DIV id=F_O_CHARGE_LabelField class=componentNameDiv>Freight & Other Charge </DIV>
					<DIV id=F_O_CHARGE_InputField class=componentDiv>
					<INPUT onblur="TESTvalue(this)" name="Tax_Fre_Other_Charge" class="listboxtype" type="textbox" readOnly="readonly" value="<%=FPrice %>">
					</DIV>
			</DIV>
		</DIV>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxRight_2 class=textbox50right>
					<DIV class=componentSelect></DIV>
					<DIV id=TOTAL_BE_VAT_LabelField class=componentNameDiv>Total Before Vat </DIV>
					<DIV id=TOTAL_BE_VAT_InputField class=componentDiv>
					<INPUT name="Total_Before_Vat" class="listboxtype" type="textbox" readOnly="readonly" value="<%=TBeforeVat %>">
					</DIV>
			</DIV>
		</DIV>
		<DIV class=textbox1>
					<DIV class=componentSelect></DIV>
					<DIV id=MD1121432801_VAT_LabelField class=componentNameDiv>Vat </DIV>
					<select id="taxinv_Vat" onchange="calVat(this)" style="left: 55px; top: 4px; position: relative">
				 		<!--option value="1">5</option>
				 		<option value="2">10</option-->
				 		<%
				 		Vector vVat = (Vector)request.getSession().getAttribute("M_VAT");
				 		for(int i = 0; i < vVat.size(); i++)
						{
	    					HashMap hResult = (HashMap)vVat.get(i);%>
				 		 <option value="<%=DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hResult.get("VAT_RATE"))) %>">
							<%=DisplayFormatUtil.addSlashAtFrontOfSpecialChar(DisplayFormatUtil.displayHTML((String)hResult.get("VAT_DESC"))) %>
						</option>
				 		 <%} %>
				 	</select>
															
					<DIV id=MD1121432801_VAT_InputField class=componentDiv>
					<INPUT name="Vat" style="left: 160px; top: -18px; width: 250px; float: left; display: block; position: relative;" type="textbox" readOnly="readonly" value="<%=Vat %>">
					</DIV>
			
		</DIV>
		<DIV class=textbox1>
			<DIV id=MD1121432801boxRight_4 class=textbox50right>
					<DIV class=componentSelect></DIV>
					<DIV id=GRAND_TOTAL_LabelField class=componentNameDiv>Grand Total </DIV>
					<DIV id=GRAND_TOTAL_InputField class=componentDiv>
					<INPUT name="Grand_Total_Inv" class="listboxtype" type="textbox" readOnly="readonly" value="<%=GTotal %>">
					</DIV>
			</DIV>
		</DIV>
	</fieldset>
	</div>
	
</DIV>
</fieldset>

<br>
<!-- Add Cost Margin(%) -->
<div class=textbox1>
	<DIV id=MD1121432801boxLeft_4 class=textbox50left>
		<DIV class=componentSelect></DIV>
		<DIV id=ADD_COST_LabelField class=componentNameDiv>Add Cost Margin(%) </DIV>
		<DIV id=ADD_COST_InputField class=componentDiv>
		<INPUT title="Enter margin cost" value="<%=Cost_Margin %>" name="Add_Cost" class="margintextbox" onkeypress="return isNumberic(event,this)" onblur="betweenNumber(this);unitCostMargin4Dummy(this);CalcostMarginWithUCost(this);" type="textbox" size="30" maxLenght="20">
		</DIV>
	</DIV>
</div>


<br>
<fieldset>
<legend class="headerFontStyle">Move to Stock</legend>

	<DIV class=textbox1>
		<table border="0">
			<tr>
				<td  width="45%">
		<DIV id=MD1121042150boxLeft_0 class="group-container">
		<fieldset>
		<legend class="headerFontStyle">Current</legend>
			
				
			<div class=textbox1>
				
					<DIV class=componentSelect></DIV>
						<!--DIV id=MD1121432801_PRODUCT_CODE_LabelField class=componentNameDiv>Product Code. : </DIV-->
						<DIV id=MD1121432801_PRODUCT_CODE_InputField class=componentDiv>
						<!--INPUT title="Enter Product Code" name="Product_Code" type="textbox" class="productcodebox">
						<INPUT title="Enter Product Name" name="Product_Name" type="textbox" class="productsearchbox"-->
						<table border="0" ><tr>
							<td><DIV id=MD1121432801_PRODUCT_CODE_LabelField class="componentNameDiv" style="position:relative;">Product Code. : </DIV></td>
							<td><INPUT title="Enter Product Code" name="Product_Code" type="textbox" class="productcodebox"></td>
							<td><INPUT title="Enter Product Name" name="Product_Name" type="textbox" class="productsearchbox"></td>
							<td><INPUT onclick="searchProduct(this)" value=Search type=button name="Search" ></td>
						</tr></table>					
						</DIV>
						<!--div align=right><INPUT onclick="searchProduct(this)" value=Search type=button name="Search" style="position:relative; top:5px"></div-->
				</div>
			
			
			<div class=textbox1>
				<DIV class=componentSelect></DIV>
					<DIV id="ms_current" >
						<table  border="0" class="table_data" cellpadding="0" cellspacing="0">
							<thead>
							<tr>
								<td><input id="ID_MSCurrent" type="checkbox" name="MSCurrent_ChBox"></td><td class="headerFontStyle" style="display:none;">ITEM_ORDER</td><td class="headerFontStyle">Product Code</td><td class="headerFontStyle">Product Name</td><td class="headerFontStyle">Reference Code</td><td class="headerFontStyle">Qty</td><td class="headerFontStyle">Unit Cost</td><td class="headerFontStyle">Total(LC)</td><td class="headerFontStyle">Dummy Qty</td><td class="headerFontStyle" style="display:none;">REF_ITEM_ORDER_HIDDEN</td><td class="headerFontStyle" style="display:none;">UNIT_COST_HIDDEN</td>
								
							</tr>
							</thead>
							<tbody id="move_to_stock">
							<%
									Vector vTaxInvoiceItem  = new Vector();
									try {
										vTaxInvoiceItem = (Vector)request.getSession().getAttribute("TaxInvoiceItem");
									}catch (Exception e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
									
									StringBuffer html = new StringBuffer();
									HashMap hTaxInvoiceItem = new HashMap();
									if(vTaxInvoiceItem.size() > 0) {
										for(int i = 0; i < vTaxInvoiceItem.size(); i++)
										{
											hTaxInvoiceItem = (HashMap) vTaxInvoiceItem.get(i);
											html.append("<tr>");
									 		html.append("<td id=\"TD_CHECK_BOX" +i+ "\" name=\"TD_CHECK_BOX" +i+ "\">" + "<input type=\"checkbox\" id=HD_CHECK_BOX"+i+" name=\"TD_CHECK_BOX" +i+ "\"></td>");
									 		html.append("<td style=\"display:none;\" id=\"TD_ITEM_ORDER" + i + "\" >" + "<input type=hidden id=HD_ITEM_ORDER"+i+" value=\""+hTaxInvoiceItem.get("ITEM_ORDER")+"\"/> <div id=TEXT_ITEM_ORDER"+i+">"+hTaxInvoiceItem.get("ITEM_ORDER") + "</div></td>");
									 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TD_PRODUCT_CODE"+i+"\" name=\"TD_PRODUCT_CODE"+i+"\" >" + "<input name=\"HD_PRODUCT_CODE"+i+"\" type=hidden id=HD_PRODUCT_CODE"+i+" value=\"" + hTaxInvoiceItem.get("PRODUCT_CODE") + "\"/> <div id=TEXT_PRODUCT_CODE"+i+">" + hTaxInvoiceItem.get("PRODUCT_CODE") + "</div></td>");
									 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TD_PRODUCT_NAME"+i+"\" name=\"TD_PRODUCT_NAME"+i+"\" >" + "<input name=\"HD_PRODUCT_NAME"+i+"\" type=hidden id=HD_PRODUCT_NAME"+i+" value=\"" + hTaxInvoiceItem.get("PRODUCT_NAME") + "\"/> <div id=TEXT_PRODUCT_NAME"+i+">" + hTaxInvoiceItem.get("PRODUCT_NAME") + "</div></td>");
									 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TD_REF_CODE"+i+"\" name=\"TD_REF_CODE"+i+"\" >" + "<input name=\"HD_REF_CODE"+i+"\" type=hidden id=HD_REF_CODE"+i+" value=\"" + hTaxInvoiceItem.get("REF_CODE") + "\"/> <div id=TEXT_REF_CODE"+i+">" + hTaxInvoiceItem.get("REF_CODE") + "</div></td>");
									 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TD_QTY"+i+"\" name=\"TD_QTY"+i+"\" >" + "<input name=\"HD_QTY"+i+"\" type=hidden id=HD_QTY"+i+" value=\"" + hTaxInvoiceItem.get("QUANTITY") + "\"/> <div id=TEXT_QTY"+i+">" + hTaxInvoiceItem.get("QUANTITY") + "</div></td>");
									 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TD_UNIT_COST"+i+"\" name=\"TD_UNIT_COST"+i+"\" >" + "<input name=\"HD_UNIT_COST"+i+"\" type=\"textbox\" style=\"width: 80px\" onkeypress=\"return isNumberic(event,this)\" onblur=\"CalcostMarginWithTextFieldUCost(this);taxinvtextfieldCal(this);\" id=HD_UNIT_COST"+i+" value=\"" + hTaxInvoiceItem.get("UNIT_COST") + "\"/> <div style=\"display:none;\" id=TEXT_UNIT_COST"+i+">" + hTaxInvoiceItem.get("UNIT_COST") + "</div></td>");
									 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TD_TOTAL"+i+"\" name=\"TD_TOTAL"+i+"\" >" + "<input name=\"HD_TOTAL"+i+"\" type=hidden id=HD_TOTAL"+i+" value=\"" + hTaxInvoiceItem.get("TOTAL_LC") + "\"/> <div id=TEXT_TOTAL"+i+">" + hTaxInvoiceItem.get("TOTAL_LC") + "</div></td>");
									 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"DUMMY_QTY"+i+"\" name=\"DUMMY_QTY"+i+"\">"+"<input name=\"DUMMY1_QTY"+i+"\" id=DUMMY_QTY"+i+" type=\"textbox\" style=\"width: 80px\" value=\"0\" onkeypress=\"return magTaxDummy(event)\" onchange=\"dummynotmoreqty(this)\" onblur=\"nulltozero(this);unchecknull(this);dummyCal(this)\" onfocus=\"checkChBox(this)\"> </td>");
									 		html.append("<td style=\"display:none;\" id=\"TD_REF_ITEM_ORDER_HIDDEN"+i+"\" name=\"TD_REF_ITEM_ORDER_HIDDEN"+i+"\" >" + "<input name=\"HD_REF_ITEM_ORDER_HIDDEN"+i+"\" type=hidden id=HD_REF_ITEM_ORDER_HIDDEN"+i+" value=\"" + hTaxInvoiceItem.get("REF_ITEM_ORDER") + "\"/> <div id=TEXT_REF_ITEM_ORDER_HIDDEN"+i+">" + hTaxInvoiceItem.get("REF_ITEM_ORDER_HIDDEN") + "</div></td>");
									 		html.append("<td style=\"display:none;\" id=\"TD_NET_HIDDEN"+i+"\" name=\"TD_NET_HIDDEN"+i+"\" >" + "<input name=\"HD_NET_HIDDEN"+i+"\" type=hidden id=HD_NET_HIDDEN"+i+" value=\"" + hTaxInvoiceItem.get("HIDDEN_UNIT_COST") + "\"/> <div id=TEXT_NET_HIDDEN"+i+">" + hTaxInvoiceItem.get("HIDDEN_UNIT_COST") + "</div></td>");
									 		html.append("</tr>");
										}
									}
									out.println(String.valueOf(html));
								 %>
							</tbody>
						</table>
					</DIV>	
			</div>
		</fieldset>
		</DIV>
			</td width="5%">
			<td>	
					<DIV style="FLOAT: left; VERTICAL-ALIGN: middle" id=1121043385_XXX_DIV_C>
						<DIV>&nbsp; </DIV>
						<DIV>&nbsp; </DIV>
						<DIV>&nbsp;&nbsp;<INPUT onclick="LTR_moveCheckValue(this)" value="&#62;" type=button>&nbsp;&nbsp;</DIV>
						<DIV>&nbsp;&nbsp;<INPUT onclick="RTL_moveCheckValue(this)" value="&#60;" type=button>&nbsp;&nbsp;</DIV>
					</DIV>
		</td><td width="45%">
		<DIV id=MD1121042150boxRight_0 class="group-container">
		<fieldset>
		<legend class="headerFontStyle">Stock (Dummy)</legend>
		
		<div class=textbox1>
		</div>
		
		<div class=textbox1>
			<DIV class=componentSelect></DIV>
				<DIV id="ms_stock_dummy" >
					<table  border="0" class="table_data" cellpadding="0" cellspacing="0">
						<thead>
						<tr>
							<td><input id="ID_MS_StockDummy_ChBox" type="checkbox" name="MS_StockDummy_ChBox"></td><td class="headerFontStyle" style="display:none;">ITEM_ORDER</td><td class="headerFontStyle">Product Code</td><td class="headerFontStyle">Product Name</td><td class="headerFontStyle">Reference Code</td><td class="headerFontStyle">Qty</td><td class="headerFontStyle">Unit Cost</td><td class="headerFontStyle">Total(LC)</td><td class="headerFontStyle" style="display:none;">REF_ITEM_ORDER_HIDDEN</td><td class="headerFontStyle" style="display:none;">UNIT_COST_HIDDEN</td>
						</tr>
						</thead>
						<tbody id="BODY_MS_Stock_Dummy">
						
						</tbody>
					</table>
				</DIV>
		</div>
		</fieldset>
		</DIV>
	</td>
			</tr>
		</table>	
				
	</DIV>
</fieldset>
<br>
<fieldset>
<legend class="headerFontStyle">Stock to Tax Invoice</legend>
	<div class=textbox1>
	<table border="0">
		<tr>
		<td width="45%">
		<div class="group-container">
			<fieldset>
			<legend class="headerFontStyle">Stock (Dummy)</legend>
			
			<div class=textbox1>
				
					<DIV class=componentSelect></DIV>
						<!--DIV id=MD1121432801_PRODUCT_CODE_LabelField class=componentNameDiv>Product Code. : </DIV-->
						<DIV id=MD1121432801_PRODUCT_CODE_InputField class=componentDiv>
						<!--<INPUT title="Enter Product Code" name="Dummy_Product_Code" class="productcodebox" type="textbox">
						<INPUT title="Enter Product Name" name="Dummy_Product_Search" class="productsearchbox" type="textbox">-->
						<table border="0"><tr>
							<td><DIV id=MD1121432801_PRODUCT_CODE_LabelField class="componentNameDiv" style="position:relative;">Product Code. : </DIV></td>
							<td><INPUT title="Enter Product Code" name="Dummy_Product_Code" class="productcodebox" type="textbox"></td>
							<td><INPUT title="Enter Product Name" name="Dummy_Product_Search" class="productsearchbox" type="textbox"></td>
							<td><INPUT onclick="searchDummyProduct(this)" value=Search type=button name="Dummy_Search" ></td>
						</tr></table>
						</DIV>
						<!--div align="right"><INPUT onclick="searchDummyProduct(this)" value=Search type=button name="Dummy_Search" style="position:relative; top:5px"></div-->
			</div>
			
			<div class=textbox1>
				<DIV class=componentSelect></DIV>
				<DIV id="TABLE_STOCK_DUMMY" >
					<table  border="0" class="table_data" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td><input id="Left_Dummy_Header_CheckBox" name="Left_Dummy_Header_CheckBox_Name" type="checkbox"></td><td class="headerFontStyle">Product Code</td><td class="headerFontStyle">Product Name</td><td class="headerFontStyle">Reference Code</td><td class="headerFontStyle">Qty</td><td class="headerFontStyle">Unit Cost</td><td class="headerFontStyle">Total(LC)</td><td class="headerFontStyle">Dummy Qty</td><td class="headerFontStyle" style="display:none;">REF_ITEM_ORDER_HIDDEN</td><td class="headerFontStyle" style="display:none;">UNIT_COST_HIDDEN</td>
						</tr>
					</thead>
					<tbody id="BODY_STOCK_DUMMY">
					<%
						Vector vDummyRecord  = new Vector();
// 						AccountingDAOImpl AccountingDAO = new AccountingDAOImpl();
// 						try {
// 							vDummyRecord = (Vector)request.getSession().getAttribute("DummyRecord");
// 						}catch (Exception e) {
// 							// TODO Auto-generated catch block
// 							e.printStackTrace();
// 						}
						
						html = new StringBuffer();
						HashMap hDummyRecord = new HashMap();
						if(vDummyRecord.size() > 0) {
							for(int i = 0; i < vDummyRecord.size(); i++)
							{
								hDummyRecord = (HashMap) vDummyRecord.get(i);
								html.append("<tr>");
						 		html.append("<td id=\"TDD_CHECK_BOX" + i + "\" name=\"TDD_CHECK_BOX" +i+ "\">" + "<input name=\"HDD_CHECK_BOX" +i+ "\" type=\"checkbox\" id=\"HDD_CHECK_BOX"+i+"\"></td>");
						 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TDD_PRODUCT_CODE" + i + "\" name=\"TDD_PRODUCT_CODE" + i + "\" >" + "<input name=\"HDD_PRODUCT_CODE" + i + "\" type=hidden id=HDD_PRODUCT_CODE"+i+" value=\"" + hDummyRecord.get("PRODUCT_CODE") + "\"/> <div id=TTEXT_PRODUCT_CODE"+i+">" + hDummyRecord.get("PRODUCT_CODE") + "</div></td>");
						 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TDD_PRODUCT_NAME" + i + "\" name=\"TDD_PRODUCT_NAME" + i + "\" >" + "<input name=\"HDD_PRODUCT_NAME" + i + "\" type=hidden id=HDD_PRODUCT_NAME"+i+" value=\"" + hDummyRecord.get("PRODUCT_NAME") + "\"/> <div id=TTEXT_PRODUCT_NAME"+i+">" + hDummyRecord.get("PRODUCT_NAME") + "</div></td>");
						 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TDD_REF_CODE" + i + "\" name=\"TDD_REF_CODE" + i + "\" >" + "<input name=\"HDD_REF_CODE" + i + "\" type=hidden id=HDD_REF_CODE"+i+" value=\"" + hDummyRecord.get("REF_CODE") + "\"/> <div id=TTEXT_REF_CODE"+i+">" + hDummyRecord.get("REF_CODE") + "</div></td>");
						 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TDD_QTY" + i + "\" name=\"TDD_QTY" + i + "\" >" + "<input name=\"HDD_QTY" + i + "\" type=hidden id=HDD_QTY"+i+" value=\"" + hDummyRecord.get("QUANTITY") + "\"/> <div id=TTEXT_QTY"+i+">" + hDummyRecord.get("QUANTITY") + "</div></td>");
						 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TDD_UNIT_COST" + i + "\" name=\"TDD_UNIT_COST" + i + "\" >" + "<input name=\"HDD_UNIT_COST" + i + "\" type=hidden id=HDD_UNIT_COST"+i+" value=\"" + hDummyRecord.get("UNIT_COST") + "\"/> <div id=TTEXT_UNIT_COST"+i+">" + hDummyRecord.get("UNIT_COST") + "</div></td>");
						 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"TDD_TOTAL" + i + "\" name=\"TDD_TOTAL" + i + "\" >" + "<input name=\"HDD_TOTAL" + i + "\" type=hidden id=HDD_TOTAL"+i+" value=\"" + hDummyRecord.get("TOTAL_LC") + "\"/> <div id=TTEXT_TOTAL"+i+">" + hDummyRecord.get("TOTAL_LC") + "</div></td>");
						 		html.append("<td style=\"font-size: 9pt; font-weight: bold;\" id=\"DDUMMY_QTY"+i+"\" name=\"DDUMMY_QTY"+i+"\">"+"<input name=\"DDUMMY_QTY"+i+"\" id=DDUMMY_QTY"+i+" type=\"textbox\" style=\"width: 80px\" value=\"0\" onkeypress=\"return magTaxDummy(event)\" onchange=\"Dummydummynotmoreqty(this)\" onblur=\"nulltozero(this);Dummyunchecknull(this)\" onfocus=\"DummycheckChBox(this)\"> </td>");
						 		html.append("<td style=\"display:none;\" id=\"TDD_DUMMY_ID" + i + "\" name=\"TDD_DUMMY_ID" + i + "\" >" + "<input name=\"HDD_DUMMY_ID" + i + "\" type=hidden id=HDD_DUMMY_ID"+i+" value=\"" + hDummyRecord.get("DUMMY_ID") + "\"/> <div id=TTEXT_DUMMY_ID"+i+">" + hDummyRecord.get("DUMMY_ID") + "</div></td>");
						 		html.append("<td style=\"display:none;\" id=\"TDD_REF_ITEM_ORDER_HIDDEN" + i + "\" name=\"TDD_REF_ITEM_ORDER_HIDDEN" + i + "\" >" + "<input name=\"HDD_REF_ITEM_ORDER_HIDDEN" + i + "\" type=\"hidden\" id=\"HDD_REF_ITEM_ORDER_HIDDEN"+i+"\" value=\"" + hDummyRecord.get("REF_ITEM_ORDER") + "\"/> <div id=TTEXT_REF_ITEM_ORDER_HIDDEN"+i+">" + hDummyRecord.get("REF_ITEM_ORDER") + "</div></td>");
						 		html.append("<td style=\"display:none;\" id=\"TDD_NET_HIDDEN" + i + "\" name=\"TDD_NET_HIDDEN" + i + "\" >" + "<input name=\"HDD_NET_HIDDEN" + i + "\" type=hidden id=HDD_NET_HIDDEN"+i+" value=\"" + hDummyRecord.get("UNIT_COST") + "\"/> <div id=TTEXT_NET_HIDDEN"+i+">" + hDummyRecord.get("UNIT_COST") + "</div></td>");
						 		html.append("</tr>");
							}
						}
						else { 
							html.append("<tr>");
							html.append("<td colspan=\"8\" align=\"center\">No Dummy Record</td>");
							html.append("</tr>");
						}
						out.println(String.valueOf(html));
					 %>
					</tbody>
					</table>
				</DIV>
			</div>	
			</fieldset>
		</div>
		</td>
		<td width="5%">
		<DIV style="FLOAT: left; VERTICAL-ALIGN: middle" id=1121043385_XXX_DIV_C>
			<DIV>&nbsp; </DIV>
			<DIV>&nbsp; </DIV>
			<DIV>&nbsp;&nbsp;<INPUT onclick="LTR_moveCheckValueDummy(this);TaxInv_Total();" value="&#62;" type=button>&nbsp;&nbsp;</DIV>
			<DIV>&nbsp;&nbsp;<INPUT onclick="RTL_moveCheckValueDummy(this);TaxInv_Total();" value="&#60;" type=button>&nbsp;&nbsp;</DIV>
		</DIV>
		</td width="45%">
		<td>
		<div class="group-container">
			<fieldset>
			<legend class="headerFontStyle">Tax Invoice</legend>
			<div class=textbox1>
			</div>
			
			<div class=textbox1>
				<DIV class=componentSelect></DIV>
				<DIV id="TABLE_DATA_FROM_DUMMYTABLE" >
					<table  border="0" class="table_data" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td><input id="Right_Dummy_Header_CheckBox" name="Right_Dummy_Header_CheckBox_Name" type="checkbox"></td><td class="headerFontStyle">Product Code</td><td class="headerFontStyle">Product Name</td><td class="headerFontStyle">Reference Code</td><td class="headerFontStyle">Qty</td><td class="headerFontStyle">Unit Cost</td><td class="headerFontStyle">Total(LC)</td><td class="headerFontStyle" style="display:none;">REF_ITEM_ORDER_HIDDEN</td><td class="headerFontStyle" style="display:none;">UNIT_COST_HIDDEN</td>
						</tr>
					</thead>
					<tbody id="BODY_DATA_FROM_DUMMYTABLE">
					
					</tbody>
					</table>
				</DIV>
			</div>
			</fieldset>
		</div>
		</td>
			</tr>
		</table>
	</div>
</fieldset>

<div align=center>
	<INPUT onclick="editManageTax(this);" value="Edit" type="button" name="edit_btn">
	<INPUT onclick="cancelManageTax(this)" value="Cancel" type="button" name="cancel_btn">
	<!--INPUT onclick="gen_tax_invManageTax(this)" value="Generate Tax Invoice" type="button" name="gen_tax_inv_btn"-->
	
 	
</div>

</BODY>
</HTML>