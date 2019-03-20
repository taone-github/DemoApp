<%@page import="com.master.form.MasterFormHandler"%>
<%@page import="com.master.util.EAFManualUtil"%>
<%@page import="com.eaf40.model.view.MatrixViewModuleM"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link rel="stylesheet" href="/MasterWeb/theme/Responsive2016/Matrix_Design_Style.css?v=1504248621584" type="text/css" />
<link rel="stylesheet" href="/MasterWeb/theme/Responsive2016/Matrix_Custom_Style.css?v=1504248621584" type="text/css" />
<style>


</style>
<% 
	String module = (String)request.getSession().getAttribute("module");
	String moduleParam = (String)request.getParameter("requestModule");
	if(null!=moduleParam ){
		module = moduleParam;
	}
	
	MasterFormHandler MasterForm = EAFManualUtil.getModuleForm(request, module); 

	request.setAttribute("matrixViewModuleM", new MatrixViewModuleM(module, request));
	request.setAttribute("form", EAFManualUtil.getEntityForm(request));

%>


<div class="boxboldbelow box-body">
	<div class="box box-primary">
	<div class="box-header">
		<h3 class="box-title">${ fn:escapeXml(matrixViewModuleM.masterForm.moduleM.moduleName) }</h3>
	</div>
	<div id="matrix-button" class="module-many-button" >
			
		<%=com.master.button.DisplayButton.displayResponsiveDivButton(request,MasterForm.getModuleM().getModuleID(),"SUB_SEARCH")%>

	</div>
	<!-- DIALOG -->
	<div id="matrix_column_${ matrixViewModuleM.moduleID }_dialog" class="manyDialog">
	</div>
	<!-- DIALOG -->
	<div id="matrix_row_${ matrixViewModuleM.moduleID }_dialog" class="manyDialog">
	</div>
	<!-- DIALOG -->
	<div id="many_${ matrixViewModuleM.moduleID }_dialog" class="manyDialog">
	</div>
	
	<script type="text/javascript">
		$('#matrix_column_<%=module%>_dialog').dialog({
			width: 790,
			autoOpen: false,
			height: 500,
			modal: true,
			title: 'MAIN',
			close: function(ev, ui) {
			   $('#matrix_column_<%=module%>_dialog').html('');
			   $("body").css("overflow", "auto");
			}
		});
		
		$('#matrix_row_<%=module%>_dialog').dialog({
			width: 790,
			autoOpen: false,
			height: 500,
			modal: true,
			title: 'MASTER',
			close: function(ev, ui) {
			   $('#matrix_row_<%=module%>_dialog').html('');
			   $("body").css("overflow", "auto");
			}
		});
		
		$('#many_<%=module%>_dialog').dialog({
			width: 790,
			autoOpen: false,
			height: 500,
			modal: true,
			title: '',
			close: function(ev, ui) {
			   $('#many_<%=module%>_dialog').html('');
			   $("body").css("overflow", "auto");
			}
		});
		
	</script>
	<div class="box-body">
		<div id="keyColumn">
			<c:forEach items="${ matrixViewModuleM.colHeaderDatas }" var="colDataKey" varStatus="g">
				<c:if test="${ colDataKey.mappingKey }">
					<input type="hidden" name="${ colDataKey.fieldID }" value="${ colDataKey.fieldValue }"/>
				</c:if>
			</c:forEach>
		</div>
		<div id="sizeMatrix">
			<input type="hidden" name="${ matrixViewModuleM.moduleID }_sizeRow" value="${ matrixViewModuleM.rowRecords }"/>
			<input type="hidden" name="${ matrixViewModuleM.moduleID }_sizeCol" value="${ matrixViewModuleM.colRecords }"/>
		</div>
		<div class="col-md-12">
	      <div class="scrolling outer">
			<div id="matrix-box" class="${ matrixViewModuleM.moduleID }-ui-matrix-table" module="${ matrixViewModuleM.moduleID }" >
			
				<table id="result-tbl" class="table table-bordered dataTable">
					<thead>
		<%	
			int trIndex = 1; 
		%>
		
				<!--  for loop column header -->
				<c:forEach items="${ matrixViewModuleM.colHeaderCols }" var="colKeyCfg" varStatus="i">
					<c:if test="${ colKeyCfg.showResult == 'Y' }">
						<tr name="thead-tr<%=trIndex++%>">
							<th colspan="${ matrixViewModuleM.showSearchRowKeyCount }" class="${ matrixViewModuleM.moduleID }-one-freeze" style="text-align:left; cursor: pointer;" onclick="toggleOneMTX('${ matrixViewModuleM.moduleID}')" >
								<div id='mtx-one-arrow'  class='fa fa-minus'></div>
								<c:if test="${ colKeyCfg.showLabel == 'Y' }">
									${ fn:escapeXml(colKeyCfg.showFieldName) }
								</c:if>
							</th>
							<!--  for loop column data -->
							<c:forEach items="${ matrixViewModuleM.colHeaderDatas }" var="colDataCfg" varStatus="j">
								<c:if test="${ colDataCfg.showResult }">
								<th colspan="${ matrixViewModuleM.showSearchDataCount }" class="ui-matrix-col-key-detail" style="text-align:${ colDataCfg.alignment}">
									${ fn:escapeXml(colDataCfg.fieldValue)}
								</th>
								</c:if>
							</c:forEach>
							
						</tr>
					</c:if>
					
				</c:forEach>
				
				
				<c:forEach items="${ matrixViewModuleM.oneModuleColumn }" var="oneKeyCfg" varStatus="rowG">
					<c:if test="${ oneKeyCfg.showResult == 'Y' }">
					<tr name="thead-tr<%=trIndex++%>" class="toggle-one-mtx">
					<th colspan="${ matrixViewModuleM.showSearchRowKeyCount}" class="ui-matrix-one-header ${ matrixViewModuleM.moduleID }-one-freeze" style="text-align:left">
						<c:if test="${ oneKeyCfg.showLabel == 'Y' }">
							${ fn:escapeXml(oneKeyCfg.showFieldName) }
						</c:if>
					</th>
					<c:forEach items="${ oneKeyCfg.vDataMatrix }" var="oneKeyData" varStatus="rowH">
						<td ${ oneKeyData.tdAttrMtx} colspan="${ matrixViewModuleM.showSearchDataCount }" class="ui-matrix-one-detail" >${ oneKeyData.tagDisplay }</td>
					</c:forEach>
					</tr>
					</c:if>
				</c:forEach>
					
					<!--  button module one zone -->
					<tr name="thead-tr<%=trIndex++%>" class="${ matrixViewModuleM.moduleID }-matrix-button" >
					<th colspan="${ matrixViewModuleM.showSearchRowKeyCount}" class="ui-matrix-one-header ${ matrixViewModuleM.moduleID }-one-freeze" style="text-align:left">
						
					</th>
					<c:forEach items="${ matrixViewModuleM.buttonHeaderDatas }" var="buttonCfg" varStatus="rowF">
						<td colspan="${ matrixViewModuleM.showSearchDataCount }" class="ui-matrix-one-button" >
						<div id="${buttonCfg.nameDiv}">
							<i class="fa fa-trash-o" aria-hidden="true" onclick="${buttonCfg.deleteAction}" style="font-size:1.5em; padding-right:0.15em;color:#337ab7;cursor:pointer;"></i>
							<c:if test="${ buttonCfg.showButton}">
								<i class="fa fa-pencil-square-o" aria-hidden="true"  onclick="${buttonCfg.editAction}" style="font-size:1.5em; padding-right:0.15em;color:#337ab7;cursor:pointer;" ></i>
	<!-- 						<i class="fa fa-clipboard" aria-hidden="true" onclick="alert('copy')" style="font-size:1.5em; padding-right:0.15em;color:#337ab7;"></i> -->
							</c:if>
							
						</div>
						</td>
					</c:forEach>
					</tr>
						
					</thead>
					
					<tbody>
						<!--  for loop row group header -->
						
						<c:forEach items="${ matrixViewModuleM.rowGroupCols }" var="rowGroupCfg" varStatus="rowI">
							<tr name="tbody-tr<%=trIndex++%>" class="${ matrixViewModuleM.moduleID }-height">
								<!--  for loop row header -->
								
								<c:forEach items="${ rowGroupCfg.headerColList }" var="rowKeyCfg" varStatus="rowJ">
									<c:if test="${ rowKeyCfg.showResult == 'Y' }">
									<th style="text-align:center" class="${ matrixViewModuleM.moduleID }-row-head-freeze-${rowJ.count}">
										<c:if test="${ rowKeyCfg.showLabel == 'Y' }">
											${ fn:escapeXml(rowKeyCfg.showFieldName) }
										</c:if>
									</th>
									</c:if>
								</c:forEach>
								<!--  for loop data header -->
								<c:forEach  var="colCount" begin="1" end="${ matrixViewModuleM.showColDataCount }">
									<c:forEach items="${ matrixViewModuleM.dataHeaderCols }" var="dataKeyCfg" varStatus="i">
										<th class="ui-matrix-col-header-detail" style="text-align:${ dataKeyCfg.alignment}"><c:if test="${ dataKeyCfg.showLabel == 'Y' }">${ fn:escapeXml(dataKeyCfg.showFieldName) }</c:if></th>
									</c:forEach>
								</c:forEach>
							</tr>
							<!--  for loop group module & data module -->
							
							<c:forEach items="${ rowGroupCfg.matrixDataRows }" var="rowDataRows" varStatus="rowK">
	
								<c:choose>
	  							<c:when test="${rowDataRows.rowType=='GROUP'}">
					    			<tr>
					    				<c:choose>
					    				<c:when test="${ rowDataRows.groupClass == 'MAIN' }">
											<td class="ui-martix-main-group" colspan="${ rowDataRows.groupSpan }">
										</c:when>
										<c:otherwise>
											<td class="ui-martix-sub-group" colspan="${ rowDataRows.groupSpan }" onclick="toggleDataMTX('${ matrixViewModuleM.moduleID}','${ rowDataRows.groupValue}')" >
											<div id="mtx-data-arrow-${ rowDataRows.groupValue}"  class="fa fa-minus"></div>
										</c:otherwise>
										</c:choose>
										${ rowDataRows.groupLabel }
										</td>
									</tr>
							  </c:when>
							  <c:otherwise>
							    	<tr mtx-row-key-${ rowDataRows.rowRecord} class="toggle-data-mtx-${ rowDataRows.groupValue} ${ matrixViewModuleM.moduleID }-height">
							    		<c:forEach items="${ rowDataRows.rowHeaderDatas }" var="rowDataHeader" varStatus="rowL">
							    			<c:if test="${ rowDataHeader.showResult }">
							    				<td  class="${ matrixViewModuleM.moduleID }-row-head-freeze-${rowL.index}" style="text-align:${ rowDataHeader.alignment}">${ rowDataHeader.fieldValue }</td>
							    			</c:if>
							    			<c:if test="${ rowDataHeader.mappingKey }">
							    				<input type="hidden" name="${ rowDataHeader.fieldID }" value="${ rowDataHeader.fieldValue }" mtx_id="${ rowDataHeader.matrixFieldID }" />
							    			</c:if>
							    		</c:forEach>
							    		
							    		<c:forEach items="${ rowDataRows.vDataMatrix }" var="vDataMtx" varStatus="rowM">
							    				<td ${ vDataMtx.tdAttrMtx }>
							    					${ vDataMtx.tagDisplay }
												</td>							    		
							    		</c:forEach>
							    	
							    	</tr>
							  </c:otherwise>
							</c:choose>
							
							
							
							</c:forEach>
						
							<tr>
							<td class="ui-martix-button" colspan=${ matrixViewModuleM.rowAllColumn}>
								<div id="sub-matrix-button" class="matrix-many-button" >
									${ rowGroupCfg.buttonMtxTag }
								</div>
							</td>
						</c:forEach>
						
						
						
					</tbody>
				</table>
			</div>
		</div>
	  </div>
	</div>
</div>
</div>

${ matrixViewModuleM.strJavaScript }

	