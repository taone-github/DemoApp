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
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
EntityFormHandler form = EAFManualUtil.getEntityForm(request);
MasterFormHandler MasterForm = EAFManualUtil.getModuleForm(request, form.getMainModuleID());
Vector vShowColumns = MasterForm.getVShowColumnsSearch();
Vector vShowSearchRecs = MasterForm.getVShowSearchRecord();
	
EntityM entityM  = form.getEntityM();

/*
 * 23-06-2014 plug with access control V.1.0
 */
int countNoAccess = 0;
/*
* 09-09-2014 FT027_HighlightRow
*/
Vector<String> vHighlightFieldID = new Vector<String>();

for (int i= 0;i < vShowColumns.size();i++) {
	ModuleFieldM moduleM = (ModuleFieldM)vShowColumns.get(i); 
	
	/*
	 * 23-06-2014 plug with access control V.1.0
	 */
	if(moduleM.isAclFlag() && AccessControlM.ACCESS_MODE.NO_ACCESS.equals(moduleM.getAclMode())) {
		FT024_AccessControl.debug("# skip column:" + moduleM.getFieldID() + " by access control");
		countNoAccess++;
		continue;
	}
	
	/*
	* 09-09-2014 FT027_HighlightRow
	*/
	if(moduleM.isHighlight()) {
		vHighlightFieldID.add(moduleM.getFieldID());
		continue;
	}	
} 

//Case No Data
int allColumn = 0;
//if (entityM.isShowCheckBox() || entityM.isShowRadio()) {
//	allColumn++;	
//}
allColumn = allColumn + vShowColumns.size()+1;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
String noRecordMsg = MessageResourceUtil.getTextDescription(request, "DEFAULT_ROW_SEARCH");
if (form.isClickSearch()) {
	noRecordMsg = FT040_MultiLang.getInstance().displayMultiLang(MasterConstant.LANG_OBJECT_TYPE.SYSTEM_MESSAGE, MasterConstant.LANG_OBJECT_ID.DEFAULT_ROW_NO_DATA_FOUND, "", "", request);
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
request.setAttribute("vShowColumns", vShowColumns);
request.setAttribute("vShowSearchRecs", vShowSearchRecs);
request.setAttribute("NO_DATA_FOUND_MSG", noRecordMsg);
request.setAttribute("allTableColCount", allColumn-1-countNoAccess-(vHighlightFieldID.size()>0 ? 1 : 0));
request.setAttribute("searchEntityM", new SearchEntityM(request));
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%>	

<c:if test="${fn:length(vShowSearchRecs) eq 0}">
	<table class="table table-hover">
		<tr>
			<td class="text-center" colspan="${ allTableColCount }">
				${ fn:escapeXml(NO_DATA_FOUND_MSG) }
			</td>
		</tr>
	</table>
</c:if>

<c:forEach items="${ searchEntityM.searchResultRecMs }" var="searchResultRecM">
	<div class="container bck-container">
		<div class="row bck-row">
			
			<div class="text-center seart col-md-2 col-sm-4 col-xs-12 __ROW_NUMBER_col" style="padding-top: 10px;">
				<div class="text-header">
					<c:if test="${ searchEntityM.showCheckBox }">
						<input type="checkbox" name="checkRow" value ="${ searchResultRecM.queryString }">&nbsp;
					</c:if>
					<c:if test="${ searchEntityM.showRadio }">\
						<input type="radio" name="checkRow" value ="${ searchResultRecM.queryString }">&nbsp;
					</c:if>
					${ searchEntityM.itemNoStr }&nbsp;
					${ searchResultRecM.itemNo }
				</div>
			</div>
			
			<c:forEach items="${ searchResultRecM.searchResultColMs }" var="searchResultColM" varStatus="searchResultColMloop">
				<div align="${ searchResultColM.alignment }" ${ searchResultRecM.onclickEvent }  
					 
					class="seart col-md-2 col-sm-4 col-xs-12 ${ searchResultColM.moduleFieldM.moduleID }_${ searchResultColM.moduleFieldM.fieldID }_col" 
					style="padding-bottom: 10px;padding-top: 10px;
					<c:if test="${ not empty searchResultRecM.onclickEvent}">cursor:pointer;</c:if> 
					<c:if test="${ not empty searchResultColM.alignment}">text-align: ${ searchResultColM.alignment };</c:if>" 
					>
					
					<div class="text-header">
						${ fn:escapeXml(searchResultColM.displayFieldName) }
					</div>
					
					<div ${ searchResultRecM.onclickEvent } 
						class ="showElement" id="${ searchResultColM.moduleFieldM.fieldID }_${ searchResultColMloop.index }"  
						<c:if test="${ not empty searchResultColM.alignment}">style="margin-right:15px ;/*padding-left: 3px;*/"</c:if> >
						
						<span title="${ fn:escapeXml(searchResultColM.strSearchResult) }">
							<c:choose>
								<c:when test="${ not empty searchResultColM.strSearchResult}">${ fn:escapeXml(searchResultColM.strSearchResult) }</c:when>
								<c:otherwise>&nbsp;</c:otherwise>
							</c:choose>
						</span>
						
					</div>
				</div>
			</c:forEach>
			
		</div>
	</div>
</c:forEach>

