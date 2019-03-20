<%@page import="com.eaf40.model.view.SearchEntityM"%>
<%@page import="com.avalant.feature.FT027_HighlightRow"%>
<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="com.avalant.feature.v2.FT024_AccessControl"%>
<%@page import="com.avalant.rules.j2ee.AccessControlM"%>
<%@page import="com.master.model.EntityM"%>
<%@page import="com.master.form.EntityFormHandler"%>
<%@page import="com.oneweb.j2ee.pattern.util.MessageResourceUtil"%>
<%@page import="java.util.Vector"%>
<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="com.master.model.ModuleFieldM"%>
<%@page import="com.master.util.MasterUtil"%>
<%@page import="com.master.util.CheckBoxUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.master.util.MasterConstant"%>
<%@page import="com.avalant.feature.FT040_MultiLang"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	EntityFormHandler form = EAFManualUtil.getEntityForm(request);
	MasterFormHandler MasterForm = EAFManualUtil.getModuleForm(request, form.getMainModuleID());
	Vector vShowColumns = MasterForm.getVShowColumnsSearch();
	Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();

	EntityM entityM = form.getEntityM();

	/*
	 * 23-06-2014 plug with access control V.1.0
	 */
	int countNoAccess = 0;
	/*
	* 09-09-2014 FT027_HighlightRow
	*/
	Vector<String> vHighlightFieldID = new Vector<String>();

	for (int i = 0; i < vShowColumns.size(); i++) {
		ModuleFieldM moduleM = (ModuleFieldM) vShowColumns.get(i);

		/*
		 * 23-06-2014 plug with access control V.1.0
		 */
		if (moduleM.isAclFlag() && AccessControlM.ACCESS_MODE.NO_ACCESS.equals(moduleM.getAclMode())) {
			FT024_AccessControl.debug("# skip column:" + moduleM.getFieldID() + " by access control");
			countNoAccess++;
			continue;
		}

		/*
		* 09-09-2014 FT027_HighlightRow
		*/
		if (moduleM.isHighlight()) {
			vHighlightFieldID.add(moduleM.getFieldID());
			continue;
		}
	}

	//Case No Data
	int allColumn = 0;
	if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
		allColumn++;	
	}
	allColumn = allColumn + vShowColumns.size() + 1;

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	String noRecordMsg = MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_SEARCH");
	if (form.isClickSearch()) {
		noRecordMsg = FT040_MultiLang.getInstance().displayMultiLang(MasterConstant.LANG_OBJECT_TYPE.SYSTEM_MESSAGE, MasterConstant.LANG_OBJECT_ID.DEFAULT_ROW_NO_DATA_FOUND, "", "", request);
	}

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	request.setAttribute("entityID", form.getEntityM().getEntityID());
	request.setAttribute("vShowColumns", vShowColumns);
	request.setAttribute("vShowSearchRecs", vShowSearchRecs);
	request.setAttribute("NO_DATA_FOUND_MSG", noRecordMsg);
	request.setAttribute("allTableColCount", allColumn - countNoAccess - (vHighlightFieldID.size() > 0 ? 1 : 0));
	request.setAttribute("vAllSearchResultData", MasterForm.getAllSearchResultData());
	
	request.setAttribute("searchEntityM", new SearchEntityM(request));
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%>

<table class="table table-hover">
	<thead>
		<tr>
			<c:choose>
				<c:when test="${ searchEntityM.showCheckBox || searchEntityM.showRadio }">
					<th class="text-center">
						<c:if test="${ searchEntityM.showCheckBox }">
							<input type="checkbox" name="checkRow" value="" onclick="checkedAllData(this)" />
						</c:if>
						<c:if test="${ searchEntityM.showRadio }">&nbsp;</c:if>
					</th>
				</c:when>
			</c:choose>
			
			<th class="text-center">${ searchEntityM.itemNoStr }</th>
			
			<c:forEach items="${ searchEntityM.headerCols }" var="headerColM" varStatus="i">
				<th class="text-center ${ searchEntityM.masterForm.moduleM.moduleID }_${ headerColM.moduleFieldM.fieldID }_header">
					<div class="orderColumnDiv" id = "orderColumnDivID" >
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>${ fn:escapeXml(headerColM.displayFieldName) }</td>
								<td class="orderDivArea">
								
									<c:if test="${fn:length(vShowSearchRecs) gt 0}">
										<div  id ="orderASCDivID_${ i.index }" class="orderASCDiv" onclick="sortTableAjax('orderASCDivID','${ i.index }','${ headerColM.moduleFieldM.fieldID }', 'ASC', '${ entityID }_resultSearchContainer');"></div>
										<div  id ="orderDESCDivID_${ i.index }" class="orderDESCDiv" onclick="sortTableAjax('orderDESCDivID','${ i.index }','${ headerColM.moduleFieldM.fieldID }', 'DESC', '${ entityID }_resultSearchContainer');"></div>
									</c:if>
								
								</td>
							</tr>
						</table>
					</div>
				</th>
			</c:forEach>
		</tr>
	</thead>

	<c:if test="${fn:length(vShowSearchRecs) eq 0}">
		<tr>
				<td class="text-center NO_DATA_col" id="${ searchEntityM.masterForm.moduleM.moduleID }_NO_DATA_col" colspan="${ allTableColCount }">${ fn:escapeXml(NO_DATA_FOUND_MSG) }
				</td>
			</tr>
	</c:if>
	
	<c:if test="${fn:length(vShowSearchRecs) gt 0}">
		
			<tbody>
				<c:forEach items="${ searchEntityM.searchResultRecMs }" var="searchResultRecM"  varStatus="searchResultRecMloop">
					<tr
					<c:if test="${ searchEntityM.masterForm.searchForUpdate == true }">
						
							<c:choose>
								<c:when test="${ searchResultRecMloop.index mod 2==0 }">class="${ searchResultRecM.highlightClassName } ROW"</c:when>
								<c:otherwise>class="${ searchResultRecM.highlightClassName } ROW_ALT"</c:otherwise>
							</c:choose>
							onmouseover="this.className='${ searchResultRecM.highlightClassName } ROW_HOVER'" 
							<c:choose>
								<c:when test="${ searchResultRecMloop.index mod 2==0 }">onmouseout="this.className='${ searchResultRecM.highlightClassName } ROW'"</c:when>
								<c:otherwise>onmouseout="this.className='${ searchResultRecM.highlightClassName } ROW_ALT'"</c:otherwise>
							</c:choose> 
							
						
					</c:if>
					<c:if test="${ searchEntityM.masterForm.searchForUpdate == false }">
						<c:choose>
								<c:when test="${ searchResultRecMloop.index mod 2==0 }">class="${ searchResultRecM.highlightClassName } ROW"</c:when>
								<c:otherwise>class="${ searchResultRecM.highlightClassName } ROW_ALT"</c:otherwise>
							</c:choose>
					</c:if>
					>
					
					<c:choose>
						<c:when test="${ searchEntityM.showCheckBox || searchEntityM.showRadio }">
							<td class="text-center checkRow_col ${ searchEntityM.masterForm.moduleM.moduleID }_checkRow_col">
								<c:if test="${ searchEntityM.showCheckBox }">
									<input type="checkbox" name="checkRow" id="checkRow_${ searchResultRecMloop.index }" value="${ searchResultRecM.queryString }" />
								</c:if>
								<c:if test="${ searchEntityM.showRadio }">
									<input type="radio" name="checkRow" id="checkRow_${ searchResultRecMloop.index }" value="${ searchResultRecM.queryString }" />
								</c:if>
							</td>
						</c:when>
					</c:choose>
					
					<td class="text-center" data-label="${ searchEntityM.itemNoStr }">${ searchResultRecM.itemNo}</td>
					
					<c:forEach items="${ searchResultRecM.searchResultColMs }" var="searchResultColM" varStatus="searchResultColMloop">
						<td 
						data-label="${ fn:escapeXml(searchResultColM.displayFieldName) }"
						align="${ searchResultColM.alignment }"
						class="${ searchEntityM.masterForm.moduleM.moduleID }_${ searchResultColM.moduleFieldM.fieldID }_col ${ searchResultColM.alignment }"  
						${ searchResultRecM.onclickEvent }
						<c:if test="${ searchEntityM.masterForm.searchForUpdate == true }">style="cursor:pointer"</c:if>
						>
							<div id="${ searchResultColM.moduleFieldM.fieldID }_${ searchResultRecMloop.index }" class="showElement  ${ searchResultColM.alignment }">
								<span title="${ fn:escapeXml(searchResultColM.strSearchResult) }">
									<c:choose>
										<c:when test="${ not empty searchResultColM.strSearchResult}">${ fn:escapeXml(searchResultColM.strSearchResult) }</c:when>
										<c:otherwise>&nbsp;</c:otherwise>
									</c:choose>
								</span>
							</div>
						</td>	
					</c:forEach>
					
					</tr>
				</c:forEach>
				
			</tbody>
		
	</c:if>

</table>



