<%@page import="com.master.util.MasterUtil"%>
<%@page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="com.master.util.MasterConstant"%>
<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="com.eaf40.model.view.ManyModuleM"%>
<%@page import="com.avalant.feature.FT040_MultiLang"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include flush="true" page="../manyRelationEventScript.jsp"/>

<% 
String module = (String)request.getSession().getAttribute("module");
if(request.getParameter("requestModule") != null) {
	module = request.getParameter("requestModule");
}

MasterFormHandler MasterForm = EAFManualUtil.getModuleForm(request, module); 

request.setAttribute("manyModuleM", new ManyModuleM(module, request));
request.setAttribute("form", EAFManualUtil.getEntityForm(request));
request.setAttribute("DEFAULT_ROW_ADD_MSG", FT040_MultiLang.getInstance().displayMultiLang(MasterConstant.LANG_OBJECT_TYPE.SYSTEM_MESSAGE, MasterConstant.LANG_OBJECT_ID.DEFAULT_ROW_ADD, "", "", request));

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* FIX : 20170808 : (MSIG) add toggle module
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

String isToggleMD = "";
String collapseModule = "";
if("Y".equals(MasterForm.getModuleM().getIsCollapseMD())){
	isToggleMD = " onclick=\"toggle"+module+"()\" ";
	if(null!=request.getSession().getAttribute(module+"CollapseMD")){
		collapseModule = (String)request.getSession().getAttribute(module+"CollapseMD");
	}else if("Y".equals(MasterForm.getModuleM().getDfCollapseMD())){
		collapseModule = "Y";
	}
}

%>

<div class="boxboldbelow box-body">

	<c:if test="${ manyModuleM.insertOnTable }">
		<jsp:include flush="true" page="many/insertFieldMany.jsp"/>
	</c:if>
	
	<input type="hidden" name="${ manyModuleM.moduleID }_orderBy" id="${ manyModuleM.moduleID }_orderBy" value="">
	<input type="hidden" name="${ manyModuleM.moduleID }_orderByType" id="${ manyModuleM.moduleID }_orderByType" value="">	
	
	
	<!-- DIALOG -->
	<div id="many_${ manyModuleM.moduleID }_dialog" class="manyDialog">
	${ fn:escapeXml(manyModuleM.masterForm.moduleM.moduleName) }
	</div>
	
	<script type="text/javascript">
		$('#many_<%=MasterForm.getModuleM().getModuleID()%>_dialog').dialog({
			width: 790,
			autoOpen: false,
			height: 500,
			modal: true,
			create: function (event, ui) {
				$(event.target).parent().css('position', 'relative');
			},
			title: '<%=MasterUtil.displayModuleName(MasterForm.getModuleM(), request)%>',
			close: function(ev, ui) {
			  
			   $('#many_<%=MasterForm.getModuleM().getModuleID()%>_dialog').html('');
			   $("body").css("overflow", "auto");
			   // after overflow back it can't to scroll up so use this below for scroll
			   var scrTop = document.documentElement.scrollTop;
			   $('html, body').animate({ scrollTop: scrTop -1 }, 'fast');
			   $('html, body').animate({ scrollTop: scrTop }, 'fast');
			   
			}
		});
		
		<%
		boolean oldDate = com.avalant.feature.ExtendFeature.getInstance().useFeature("OLD_DATE");
		if(oldDate) {
		%>
		$('#many_<%=MasterForm.getModuleM().getModuleID()%>_dialog').bind('dialogclose', function(event) {
		    try{
		    	hideCalendar();
		    }catch(e){}
		});
		<%}%>
	</script>
	
	
			<% 
			
			
			/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			* FIX : 201708031420 : (YBAT) change pagination to bootstrap style
			* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
			
			
			%>
<!-- 		<div id="module-many-button" style="width:98% ;height:100%" class="module-many-button"> -->
			<div id="module-many-heading" style="height:100%" class="module-many-heading" <%=isToggleMD%> >
			<div class="panel-subheading02" style="width:600px;">
			<% if("Y".equals(MasterForm.getModuleM().getIsCollapseMD())){ %>
				<div id='${ manyModuleM.moduleID }-arrow' style='float:left;font-size:1.5em;margin-top:0.1em;padding-right:0.15em' class='fa fa-minus'></div>
			<% } %>
				<div class="subheading"><%=MasterUtil.displayModuleName(MasterForm.getModuleM(), request)%>
				</div>
			</div>
			
			
			</div>
			
			<div id="${ manyModuleM.moduleID }-many-button" class="module-many-button" >
			<c:if test="${ manyModuleM.unEditMany == false }">
				<%=com.master.button.DisplayButton.displayResponsiveDivButton(request,MasterForm.getModuleM().getModuleID(),"SUB_SEARCH")%>
			</c:if>
			</div>
		
		
		<%
	/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* FIX : 201708031420 : (YBAT) change pagination to bootstrap style
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	%>
	<div id="${ manyModuleM.moduleID }-content" class="module-many-content"  >
		<!-- FILTER -->
	<c:if test="${ fn:length(manyModuleM.filterFields) gt 0 && 'UPDATE' eq form.currentMode }">
		<div class="tableForm">
			<c:forEach items="${ manyModuleM.filterHiddenFields }" var="filterHiddenM"  varStatus="filterHiddenLoop">
				${ filterHiddenM.htmlTag }
			</c:forEach>
			<c:forEach items="${ manyModuleM.filterFields }" var="filterFieldM"  varStatus="filterFieldLoop">
				<c:if test="${ filterFieldLoop.index == 0 || filterFieldLoop.index mod 2 == 0 }">
					<div class="row">
				</c:if>
				
				<div class="col-xs-12 col-sm-6">
					<div class="col-sm-2" id="${ manyModuleM.moduleID }_${ filterFieldM.moduleFieldM.fieldID }_<%=MasterConstant.NAMING.LABEL_FIELD %>">
						<label>${ fn:escapeXml(filterFieldM.label) }</label>
					</div>
					<div class="col-sm-10 margintable" id="${ manyModuleM.moduleID }_${ filterFieldM.moduleFieldM.fieldID }_FILTER"> 
						${ filterFieldM.htmlTag }
					</div>
				</div>
				
				<c:if test="${ filterFieldLoop.index mod 2 == 1 || filterFieldLoop.index + 1 == fn:length(manyModuleM.filterFields) }"> 
					</div>
				</c:if>
			</c:forEach>
		</div>
	</c:if>
	<!-- END FILTER -->
	
		<div class="box-header">	
			<!-- PAGGING -->
			<% //<div id="module-many-pagging" style="float:right; margin-top:-25px; width:50%;" pagging="${manyModuleM.paging}">  %>
			<div id="module-many-pagging" class="box-tools" >
				<c:if test="${ manyModuleM.paging  }">
					<jsp:include flush="true" page="paggingMany.jsp"/>
				</c:if>
			</div>
		</div>	
			<!-- ORDER -->
			<c:if test="${ manyModuleM.ordering  }">
				<jsp:include flush="true" page="../orderingManyEventScript.jsp"/>
			</c:if>
		
		
		<!-- DATA-TABLE -->
		<div id="${ manyModuleM.moduleID }Many" align="center" class="table-responsive" >
			<table class="table table-hover" >
				<thead>
					<tr>
						<c:if test="${ fn:length(manyModuleM.searchResultRecMs) gt 0 && manyModuleM.unEditMany == false }">
							<th width="3%" height="19" class="text-center"><input type="checkbox" name="${ manyModuleM.moduleID }checkAll" onclick="selectedAllCheckBox('${ manyModuleM.moduleID }')" /></th>
						</c:if>
						
						<c:forEach items="${ manyModuleM.headerCols }" var="headerColM" varStatus="i">
							<th class="${ manyModuleM.moduleID }_${ headerColM.moduleFieldM.fieldID }_header">
							
							<c:choose>
								<c:when test="${ manyModuleM.ordering && 'UPDATE' eq form.currentMode && manyModuleM.viewMode}">
									<div class="orderColumnDiv" id = "orderColumnDivID" >
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<div class="fontheadtable1">${ fn:escapeXml(headerColM.displayFieldName) }</div>
												</td>
												<td class="orderDivArea">
												<c:if test="${ fn:length(manyModuleM.searchResultRecMs) gt 0  }">
													<div  id ="orderASCDivID_${ i.index }" class="orderASCDiv" onclick="${ manyModuleM.moduleID }ManyOrder('${ headerColM.moduleFieldM.fieldID }', 'ASC');"></div>
													<div  id ="orderDESCDivID_${ i.index }" class="orderDESCDiv" onclick="${ manyModuleM.moduleID }ManyOrder('${ headerColM.moduleFieldM.fieldID }', 'DESC');"></div>
												</c:if>
												</td>
											</tr>
										</table>
									</div>
								</c:when>
								<c:otherwise>
									<div class="text-center">${ fn:escapeXml(headerColM.displayFieldName) }</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:if test="${ fn:length(manyModuleM.searchResultRecMs) gt 0 
							&& ((!manyModuleM.unEditMany && !manyModuleM.hideEdit && !manyModuleM.unEditInLine) || manyModuleM.alwaysShowEditBtn) }">
							<th class="${ manyModuleM.moduleID }_edit_button_header"><div style="display: block; width: 30px" >&nbsp;</div></th>
						</c:if>
						
					</tr>
				</thead>
				
				<tbody>
					<c:choose>
						<c:when test="${ fn:length(manyModuleM.searchResultRecMs) == 0 }">
							<tr>
								<td class="text-center" colspan="${ manyModuleM.allTableColCount }">
									<span>${ fn:escapeXml(DEFAULT_ROW_ADD_MSG) }</span>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${ manyModuleM.searchResultRecMs }" var="searchResultRecM"  varStatus="searchResultRecMloop">
								<tr 
								class="${ searchResultRecM.highlightClassName } gumaygrey2"
								onmouseover="this.className='${ searchResultRecM.highlightClassName } gumaygrey2'" 
								onmouseout="this.className='${ searchResultRecM.highlightClassName } gumaygrey2'"
								>
									
									<c:if test="${ manyModuleM.unEditMany == false }">
										<td class="text-center" width="3%"><input type="checkbox" name="${ manyModuleM.moduleID }deleteRow" value ="${ searchResultRecMloop.index }" onClick="${ manyModuleM.moduleID }checkList()"></td>
									</c:if>
									
									<c:forEach items="${ searchResultRecM.searchResultColMs }" var="searchResultColM" varStatus="searchResultColMloop">
										<td 
										data-label="${ fn:escapeXml(searchResultColM.displayFieldName) }"
										align="${ searchResultColM.alignment }" 
										class="datatable-many ${ manyModuleM.moduleID }_${ searchResultColM.moduleFieldM.fieldID }_col" ${ searchResultColM.linkTD } >
											<div 
												id="${ manyModuleM.moduleID }_${ searchResultColM.moduleFieldM.fieldID }_${searchResultRecMloop.index}DisplayField" 
												class="showElement ${ searchResultColM.alignment } <c:if test="${ not empty searchResultColM.linkEditInline }" >eaf-inline-editable</c:if>"
												${ searchResultColM.linkEditInline }>
												<span title="${ fn:escapeXml(searchResultColM.strSearchResult) }">
													<c:choose>
														<c:when test="${ not empty searchResultColM.htmlSearchResult }">
															${ searchResultColM.htmlSearchResult }
														</c:when>
														<c:when test="${ not empty searchResultColM.strSearchResult }">
															${ searchResultColM.strSearchResult }
														</c:when>
														<c:otherwise>&nbsp;</c:otherwise>
													</c:choose>
												</span>
												<c:if test="${ not empty searchResultColM.linkGoEntity }">
													<input type="button" name="go" value="G" onclick="${ searchResultColM.linkGoEntity }" />
												</c:if>
											</div>
											<div id="${ manyModuleM.moduleID }_${ searchResultColM.moduleFieldM.fieldID }_${searchResultRecMloop.index}EditableField" 
												class="hideElement"></div>
										</td>
									</c:forEach>
									
									<c:if test="${ (!manyModuleM.unEditMany && !manyModuleM.hideEdit && !manyModuleM.unEditInLine) || manyModuleM.alwaysShowEditBtn }">
										<td class="${ manyModuleM.moduleID }_edit_button_col">
											<div id="${ manyModuleM.moduleID }_BUTTON_EDIT_${searchResultRecMloop.index}" class="showElement">
												<c:choose>
													<c:when test="${ not empty searchResultRecM.onclickEvent }">
														<button type="button" 
															class="btn btn-default btn-edt btn-xs addicon-many las"
															name="${ manyModuleM.moduleID }ButtonRowET" 
															${ searchResultRecM.onclickEvent } >
															<span class="glyphicon glyphicon-pencil las" aria-hidden="true"></span>
														</button>
													</c:when>
													<c:otherwise>
														<div class="showElement"></div>
													</c:otherwise>
												</c:choose>
												
											</div>
										</td>
									</c:if>
									
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			
	<!-- 		TOTAL -->
			<div id="totalManyID" class="totalManyClass" ></div>
			
			${ manyModuleM.hiddenField }
			
		</div>
	</div>
</div>
${ manyModuleM.filterScriptFile }
<c:if test="${ not empty manyModuleM.manyScriptFile }">
	<script type="text/javascript" src="${ manyModuleM.manyScriptFile }"></script>
</c:if>

<script type="text/javascript">
function selectedAllCheckBox(moduleID){
	var isChecked = $("[name='"+moduleID+"checkAll']").is(":checked");
	$("[name='"+moduleID+"deleteRow']").attr('checked',isChecked).prop('checked', isChecked);
}
function toggle<%=module%>(){
	$("#<%=module%>-content").slideToggle(function(){

		if($("#<%=module%>-content").is(':hidden')){
			$("#<%=module%>-arrow").attr('class','fa fa-plus');
			$("#<%=module%>-many-button").hide();
			setSession<%=module%>Collapse("Y");

		}else{
			$("#<%=module%>-arrow").attr('class','fa fa-minus');
			$("#<%=module%>-many-button").show();
			setSession<%=module%>Collapse("N");
		}	
	});
	
}
function setSession<%=module%>Collapse(flag){

	var uri = "<%=request.getContextPath()%>/ManualServlet?className=com.avalant.display.many.ModuleManySession&moduleID=<%=module%>&collapseFlag="+flag;
		jQuery.ajax({
		type: "POST",
		url: uri,
		async: false,
		success: function(data){
			//console.log("collapse ===>"+data)
		}
	});
	
}

<% if("Y".equals(collapseModule)){ 
	//default collapse module
%>
toggle<%=module%>();
<% } %>

</script>
