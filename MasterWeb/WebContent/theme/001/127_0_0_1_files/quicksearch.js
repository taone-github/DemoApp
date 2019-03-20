/*
 * WICK: Web Input Completion Kit
 * http://wick.sourceforge.net/
 * Copyright (c) 2004, Christopher T. Holland
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * Neither the name of the Christopher T. Holland, nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Portions created by SugarCRM are Copyright (C) SugarCRM, Inc.
 
 */
function freezeEvent(e){if(e.preventDefault)e.preventDefault();e.returnValue=false;e.cancelBubble=true;if(e.stopPropagation)e.stopPropagation();return false;}
function isWithinNode(e,i,c,t,obj){answer=false;te=e;while(te&&!answer){if((te.id&&(te.id==i))||(te.className&&(te.className==i+"Class"))||(!t&&c&&te.className&&(te.className==c))||(!t&&c&&te.className&&(te.className.indexOf(c)!=-1))||(t&&te.tagName&&(te.tagName.toLowerCase()==t))||(obj&&(te==obj))){answer=te;}else{te=te.parentNode;}}
return te;}
function getEvent(event){return(event?event:window.event);}
function getEventElement(e){return(e.srcElement?e.srcElement:(e.target?e.target:e.currentTarget));}
function findElementPosX(obj){curleft=0;if(obj.offsetParent){while(obj.offsetParent){curleft+=obj.offsetLeft;obj=obj.offsetParent;}}
else if(obj.x)
curleft+=obj.x
return curleft;}
function findElementPosY(obj){curtop=0;if(obj.offsetParent){while(obj.offsetParent){curtop+=obj.offsetTop;obj=obj.offsetParent;}}
else if(obj.y)
curtop+=obj.y
return curtop;}
function handleKeyPress(event){e=getEvent(event);eL=getEventElement(e);sqs_tab_action=false;upEl=isWithinNode(eL,null,"sqsEnabled",null,null);sqs_id=eL["id"];kc=e["keyCode"];if(kc==13||kc==9){if(sqs_lookup_active)return;sqs_tab_action=true;}
if(siw&&((kc==13)||(kc==9))){siw.selectingSomething=true;if(siw.isSafari)inputBox.blur();try{siw.inputBox.focus();}
catch(e){return;}
hideSmartInputFloater(true);}else if(upEl&&(kc!=38)&&(kc!=40)&&(kc!=37)&&(kc!=39)&&(kc!=13)&&(kc!=27)){if(!siw||(siw&&!siw.selectingSomething)){handleInput(event);}}else if(siw&&siw.inputBox){siw.internalCall=true;siw.inputBox.focus();}}
function handleInput(event){e=getEvent(event);eL=getEventElement(e);upEl=isWithinNode(eL,null,"sqsEnabled",null,null);if(siw&&upEl.value==''){hideSmartInputFloater(false);}
sqs_id=eL["id"];if(sqs_id!='debug'&&sqs_id!='left'&&sqs_id!=''&&typeof(sqs_objects)!='undefined'){if(typeof(sqs_objects[sqs_id]['disable'])!='undefined'&&sqs_objects[sqs_id]['disable']==true)return;if(typeof(sqs_old_values)&&typeof(sqs_old_values[sqs_id])=='undefined'){sqs_old_values[sqs_id]='';}
makeRPCCall(upEl,sqs_id,rpc_timeout);}}
function handleOnPropertyChange(event){if(!from_popup_return)handleInput(event);}
function doCall(sqs_id,sqs_query,value){if(floaterWait==null||typeof(floaterWait)=='undefined'){quicksearchInit();}
if(value!=upEl.value||value=='')return;if(typeof(window['callDelay'])!="undefined")window.clearTimeout(callDelay);x=findElementPosX(upEl)-19;y=findElementPosY(upEl);floaterWait.style.left=x;floaterWait.style.top=y;floaterWait.style.display="block";floaterWait.style.visibility="visible";for(var i=0;i<sqs_objects[sqs_id]['conditions'].length;i++){if(typeof(sqs_objects[sqs_id]['conditions'][i]['source'])!='undefined'){src_elem=document.getElementById(sqs_objects[sqs_id]['conditions'][i]['source']);if(typeof(src_elem)!='undefined'&&src_elem.value!=''){sqs_objects[sqs_id]['conditions'][i]['value']=JSON.stringifyNoSecurity(src_elem.value);}}else{sqs_objects[sqs_id]['conditions'][i]['value']=JSON.stringifyNoSecurity(sqs_query);}}
postData='data='+JSON.stringifyNoSecurity(sqs_objects[sqs_id])+'&module=Home&action=quicksearchQuery&to_pdf=1';sqs_request_id++;sqs_last_query=sqs_query;sqs_query=sqs_last_query;sqs_lookup_active=true;YAHOO.util.Connect.asyncRequest('POST','index.php',{success:SugarQuickSearchObject.display,failure:SugarQuickSearchObject.fail,argument:{id:sqs_request_id,query:sqs_query}},postData);}
function makeRPCCall(upEl,sqs_id,delay){if(sqs_tab_action)return;if(typeof(sqs_objects[sqs_id])!='undefined'){if(sqs_objects[sqs_id]['multi'])
sqs_query=getUserInputToMatch(document.getElementById(sqs_id).value);else
sqs_query=document.getElementById(sqs_id).value;if(typeof(siw)!='undefined'&&sqs_query=='')hideSmartInputFloater(false);sqs_query=sqs_query.replace(/\\/gi,'').replace(/\[/gi,'').replace(/\(/gi,'').replace(/\./gi,'\.').replace(/\?/gi,'');sqs_query=sqs_query.replace(/[()]+/g,'');if(sqs_query.length>0){if(sqs_query.length>sqs_last_query.length&&sqs_old_values[sqs_id].length>0&&sqs_query.indexOf(sqs_old_values[sqs_id])==0&&typeof(collection)!='undefined'&&collection.length>0&&collection.length<sqs_objects[sqs_id]['limit']){processSmartInput(upEl,sqs_id);}
else{hideSmartInputFloater(false);clearSQSLookupData(false);clearPopulateList(upEl.id,sqs_id);if(typeof(window['callDelay'])!="undefined")window.clearTimeout(callDelay);callDelay=window.setTimeout('doCall(sqs_id, sqs_query,upEl.value)',delay);}}
sqs_old_values[sqs_id]=sqs_query;sqs_object_id=sqs_id;}}
function handleKeyDown(event){e=getEvent(event);eL=getEventElement(e);sqs_tab_action=false;if(siw&&(kc=e["keyCode"])){if(kc==40){siw.selectingSomething=true;freezeEvent(e);if(siw.isGecko)siw.inputBox.blur();selectNextSmartInputMatchItem();}else if(kc==38){siw.selectingSomething=true;freezeEvent(e);if(siw.isGecko)siw.inputBox.blur();selectPreviousSmartInputMatchItem();}else if((kc==13)||(kc==9)){siw.selectingSomething=true;sqs_tab_action=true;activateCurrentSmartInputMatch();freezeEvent(e);}else if(kc==27){hideSmartInputFloater(false);freezeEvent(e);}else{siw.selectingSomething=false;}
try{siw.internalCall=true;siw.inputBox.focus();}catch(e){return;}}}
function handleFocus(event){if(siw&&siw.internalCall){siw.internalCall=false;return;}
sqs_tab_action=true;from_popup_return=false;e=getEvent(event);eL=getEventElement(e);sqs_id=eL["id"];if(focEl=isWithinNode(eL,null,"sqsEnabled",null,null)){if(typeof(siw)!='undefined'&&(!siw||(siw&&!siw.selectingSomething))){sqs_old_values[sqs_id]=''
sqs_original_value=eL.value;handleInput(event);}}}
function handleBlur(event){e=getEvent(event);eL=getEventElement(e);if(blurEl=isWithinNode(eL,null,"sqsEnabled",null,null)){sqs_original_value='';toggleMultis(eL['id'],false);id=eL['id'];if(sqs_must_match&&eL.value!=''&&sqs_id!=''&&(!siw||(siw.selectingSomething&&sqs_tab_action||!siw.selectingSomething))){failBlur=!sqsFilledOut(sqs_id);if(failBlur){window.setTimeout('handleUnBlur(id)',10);}else{clearSQSLookupData(true);}}
else{if(typeof(window['callDelay'])!="undefined")window.clearTimeout(callDelay);}}}
function sqsFilledOut(sqs_id){if(typeof sqs_objects[sqs_id]!='undefined'&&typeof collection_extended[document.getElementById(sqs_id).value]!='undefined'){list=sqs_objects[sqs_id]['populate_list'];for(i in list){if(i>-1){j=list[i];k=sqs_objects[sqs_id]['field_list'][i];if(document.getElementById(j).value!=String(collection_extended[document.getElementById(sqs_id).value][k]).replace(/&amp;/gi,'&').replace(/&lt;/gi,'<').replace(/&gt;/gi,'>').replace(/&#039;/gi,'\'').replace(/&quot;/gi,'"').replace(/\r\n/gi,'\n')){return false;}}}}
return true;}
function handleUnBlur(id){document.getElementById(id).focus();sqs_tab_action=false;if(typeof(window['callDelay'])!="undefined"&&sqs_query!=''&&sqs_query!=sqs_last_query){doCall(sqs_id,sqs_query,upEl.value);}}
function clearSQSLookupData(full){if(full){sqs_last_query='';sqs_query='';}
if(siw){siw.matchCollection=new Array();}
sqs_original_value='';collection=new Array();collection_extended=new Array();}
function handleClick(event){e2=getEvent(event);eL2=getEventElement(e2);toggleMultis(eL2['id'],true);if(siw&&siw.selectingSomething){selectFromMouseClick();}}
function handleMouseOver(event){e=getEvent(event);eL=getEventElement(e);if(siw&&(mEl=isWithinNode(eL,null,"sqsMatchedSmartInputItem",null,null))){siw.selectingSomething=true;selectFromMouseOver(mEl);}else if(isWithinNode(eL,null,"siwCredit",null,null)){siw.selectingSomething=true;}else if(siw){siw.selectingSomething=false;}}
function showSmartInputFloater(){if(!siw)siw=new smartInputWindow();if(!siw.floater.style.display||(siw.floater.style.display=="none")){if(!siw.customFloater){x=findElementPosX(siw.inputBox);y=findElementPosY(siw.inputBox)+siw.inputBox.offsetHeight;if(!siw.isGecko&&!siw.isWinIE)x+=8;if(!siw.isGecko&&!siw.isWinIE)y+=10;siw.floater.style.left=x;siw.floater.style.top=y;}else{}
siw.floater.style.display="block";siw.floater.style.visibility="visible";if(siw.isWinIE){siw.floaterIframe.style.display="block";siw.floaterIframe.style.visibility="visible";resizeSmartInputIframe();}
siw.floater.style.opacity=1;siw.floater.style.filter='alpha(opacity=100)';siw.floater.getElementsByTagName('td')[0].getElementsByTagName('div')[0].style.opacity=1;siw.floater.getElementsByTagName('td')[0].getElementsByTagName('div')[0].style.filter='alpha(opacity=100)';siw.floaterIframe.style.opacity=1;siw.floaterIframe.style.filter='alpha(opacity=100)';}}
function clearPopulateList(id,sqs_id){if(sqs_tab_action)return;for(j=1;j<sqs_objects[sqs_id]['populate_list'].length;j++){if(id!=sqs_objects[sqs_id]['populate_list'][j]){document.getElementById(sqs_objects[sqs_id]['populate_list'][j]).value='';}}}
function hideSmartInputFloater(selected){postblur=false;if(siw){siw.blurring=true;if(typeof(callDelay)!='undefined')window.clearTimeout(callDelay);if(typeof(sqs_object_id)!='undefined'){user_input=document.getElementById(sqs_object_id).value;var multi=false;if(selected&&typeof sqs_objects[sqs_object_id]['multi']!='undefined'&&sqs_objects[sqs_object_id]['multi']){if(typeof sqs_objects[sqs_object_id]['multi_populate_list']=='undefined')
sqs_objects[sqs_object_id]['multi_populate_list']=new Array();if(typeof sqs_objects[sqs_object_id]['multi_populate_list'][user_input]=='undefined'||sqs_objects[sqs_object_id]['multi_populate_list'][user_input]==null)
sqs_objects[sqs_object_id]['multi_populate_list'][user_input]=new Array();sqs_objects[sqs_object_id]['multi_populate_list'][user_input][document.getElementById(sqs_object_id).name]=user_input;multi=true;}
for(j=1;j<sqs_objects[sqs_object_id]['populate_list'].length;j++){if(typeof(collection_extended)!='undefined'&&typeof(sqs_objects)!='undefined'&&typeof(collection_extended[user_input])!='undefined'&&typeof(collection_extended[user_input][sqs_objects[sqs_object_id]['field_list'][j]])!='undefined'){if(multi){sqs_objects[sqs_object_id]['multi_populate_list'][user_input][sqs_objects[sqs_object_id]['populate_list'][j]]=collection_extended[user_input][sqs_objects[sqs_object_id]['field_list'][j]];}else{document.getElementById(sqs_objects[sqs_object_id]['populate_list'][j]).value=collection_extended[user_input][sqs_objects[sqs_object_id]['field_list'][j]];}
postblur=true;}else{document.getElementById(sqs_objects[sqs_object_id]['populate_list'][j]).value='';}}
if(multi){sqsCreateSpans(sqs_object_id);document.getElementById(sqs_object_id).value='';}
if(typeof(sqs_objects[sqs_object_id]['post_onblur_function'])!='undefined'&&postblur){eval(sqs_objects[sqs_object_id]['post_onblur_function']+'(collection_extended[user_input], sqs_object_id)');}}
sqs_query='';theDiv=siw.floaterContent.getElementsByTagName('div')[0];if((selected&&user_input!=''&&sqsFilledOut(sqs_object_id))||user_input==''||sqs_query.indexOf(sqs_last_query)!=0){hideSmartInputFloaterComplete();}}}
function sqsCreateSpans(sqs_object_id){multi_populate_el=document.getElementById(sqs_objects[sqs_object_id]['multi_populate']);multi_populate_el.innerHTML='';list=new Array();countWP=0;for(wp in sqs_objects[sqs_object_id]['multi_populate_list']){if(sqs_objects[sqs_object_id]['multi_populate_list'][wp]!=null&&wp!=''){countWP++;span='<a href="#" onclick="return sqsRemove(\''+wp+'\', \''+sqs_object_id+'\' )">'+wp;for(field in sqs_objects[sqs_object_id]['multi_populate_list'][wp]){span+='<input type="hidden" name="'+field+'[]" value="'+sqs_objects[sqs_object_id]['multi_populate_list'][wp][field]+'">';}
span+='</a>';list.push(span);}}
multi_populate_el.innerHTML='<span>'+countWP+' selected items</span>'
+'<div style="height: 20px;">'
+'<div style="padding: 2px 2px 2px 2px; border: 1px black solid; background: #fff; overflow: auto; width: 100px; height: 100px; position: absolute;" id="'+sqs_object_id+'_info">'+list.join(',<br>')+'</div></div>';toggleMultis(sqs_object_id,true);}
function toggleMultis(sqs_object_id,show){multi_div=document.getElementById(sqs_object_id+'_info');if(multi_div&&show){multi_div.style.height='100px';multi_div.style.width='100px';}
if(multi_div&&!show){multi_div.style.height='25px';multi_div.style.width='100px';}}
function sqsRemove(item,sqs_object_id){sqs_objects[sqs_object_id]['multi_populate_list'][item]=null;sqsCreateSpans(sqs_object_id);return false;}
function hideSmartInputFloaterComplete(){if(siw){siw.floater.style.display="none";siw.floater.style.visibility="hidden";siw.floaterIframe.style.display="none";siw.floaterIframe.style.visibility="hidden";siw.blurring=false;siw=null;}}
function setOpacity(value,theDiv){if(siw&&theDiv){newOpacity=100-value*20;siw.floater.style.opacity=1-value/20;siw.floater.style.filter='alpha(opacity='+newOpacity+')';theDiv.style.opacity=1-value/20;theDiv.style.filter='alpha(opacity='+newOpacity+')';siw.floaterIframe.style.opacity=1-value/20;siw.floaterIframe.style.filter='alpha(opacity='+newOpacity+')';}}
function processSmartInput(inputBox,sqs_id){if(!siw)siw=new smartInputWindow();siw.inputBox=inputBox;try{classData=inputBox.className.split(" ");}
catch(e){return;}
siwDirectives=null;for(i=0;(!siwDirectives&&classData[i]);i++){if(classData[i].indexOf("sqsEnabled")!=-1)
siwDirectives=classData[i];}
if(siwDirectives&&(siwDirectives.indexOf(":")!=-1)){siw.customFloater=true;newFloaterId=siwDirectives.split(":")[1];siw.floater=document.getElementById(newFloaterId);siw.floaterContent=siw.floater.getElementsByTagName("div")[0];}
setSmartInputData();if(siw.matchCollection&&(siw.matchCollection.length>0))selectSmartInputMatchItem(0);content=getSmartInputBoxContent();if(content){modifySmartInputBoxContent(content);showSmartInputFloater();}else{if(typeof(sqs_query)!="undefined"&&sqs_query.length>0&&(typeof(sqs_objects[sqs_id]['disable'])=='undefined'||sqs_objects[sqs_id]['disable']==false)){modifySmartInputBoxContent('<div class="sqsNoMatch">'+sqs_objects[sqs_id]['no_match_text']+'</div>');showSmartInputFloater();}}}
function smartInputMatch(cleanValue,value){this.cleanValue=cleanValue;this.value=value;this.isSelected=false;}
function simplify(s){var unicode='';var badChars=new Object();badChars['(']=1;badChars[')']=1;for(var i=0;i<s.length;i++){var tempChar='';if(badChars[s.charAt(i)]!=undefined){continue;}else if(s.charCodeAt(i)>128){tempChar=s.charCodeAt(i).toString(16);while(tempChar.length<4){tempChar="0"+tempChar;}
tempChar="\\u"+tempChar;}else{tempChar=s.charAt(i);}
unicode+=tempChar;}
return unicode;}
function getUserInputToMatch(s){a=s;fields=s.split(";");if(fields.length>0)a=fields[fields.length-1];return a;}
function getUserInputBase(){try{s=siw.inputBox.value;}
catch(e){return;}
a=s;if((lastComma=s.lastIndexOf(";"))!=-1){a=a.replace(/^(.*\;[ \r\n\t\f\s]*).*$/i,'$1');}
else
a="";return a;}
function runMatchingLogic(userInput,standalone){userInput=simplify(userInput);uifc=userInput.charAt(0).toLowerCase();if(uifc=='"')uifc=(n=userInput.charAt(1))?n.toLowerCase():"z";if(standalone)userInput=uifc;if(siw)siw.matchCollection=new Array();if(typeof(collection)=="undefined")return;pointerToCollectionToUse=collection;if(siw&&(userInput.length==1)&&(!collectionIndex[uifc])){siw.buildIndex=true;}else if(siw){siw.buildIndex=false;}
tempCollection=new Array();contacts_request=typeof sqs_objects[sqs_id]["modules"]!='undefined'&&sqs_objects[sqs_id]["modules"]=="Contacts";if(userInput=='\\'){return;}
if(contacts_request){re1m=new RegExp("([\(\) \"\>\<\-]*)("+userInput+")","i");re1=new RegExp("([\(\) \"\}\{\-]*)("+userInput+")","gi");}else{re1m=new RegExp("^([\(\) \"\>\<\-]*)("+userInput+")","i");re1=new RegExp("^([\(\) \"\}\{\-]*)("+userInput+")","gi");}
for(i=0,j=0;(i<pointerToCollectionToUse.length);i++){displayMatches=((!standalone)&&(j<siw.MAX_MATCHES));entry=pointerToCollectionToUse[i];mEntry=simplify(entry);mEntry=entry;if(!standalone&&(mEntry.indexOf(userInput)==0)){userInput=userInput.replace(/\>/gi,'\\}').replace(/\< ?/gi,'\\{');re=new RegExp("("+userInput+")","i");if(displayMatches){siw.matchCollection[j]=new smartInputMatch(entry,mEntry.replace(/\>/gi,'}').replace(/\< ?/gi,'{').replace(re,"<b>$1</b>"));}
tempCollection[j]=entry;j++;}else if(mEntry.match(re1m)){if(!standalone&&displayMatches){siw.matchCollection[j]=new smartInputMatch(entry,mEntry.replace(/\>/gi,'}').replace(/\</gi,'{').replace(re1,"$1<b>$2</b>"));}
tempCollection[j]=entry;j++;}}
if(siw){siw.lastUserInput=userInput;siw.revisedCollection=tempCollection.join(",").split(",");collectionIndex[userInput]=tempCollection.join(",").split(",");}
if(standalone||siw.buildIndex){collectionIndex[uifc]=tempCollection.join(",").split(",");if(siw)siw.buildIndex=false;}}
function setSmartInputData(){if(typeof(siw)!='undefined'){if(siw){orgUserInput=siw.inputBox.value;if(typeof(sqs_objects)!='undefined'&&typeof(sqs_id)!='undefined'&&typeof(sqs_objects[sqs_id])!='undefined'&&sqs_objects[sqs_id]['multi'])orgUserInput=getUserInputToMatch(orgUserInput);userInput=orgUserInput;if(userInput&&(userInput!="")&&(userInput!='"')){runMatchingLogic(userInput);}
else{siw.matchCollection=null;}}}}
function getSmartInputBoxContent(){a=null;if(siw&&siw.matchCollection&&(siw.matchCollection.length>0)){a='';for(i=0;i<siw.matchCollection.length;i++){selectedString=siw.matchCollection[i].isSelected?' sqsSelectedSmartInputItem':'';a+='<p class="sqsMatchedSmartInputItem'+selectedString+'">'+siw.matchCollection[i].value.replace(/\{ */gi,"&lt;").replace(/\} */gi,"&gt;")+'</p>';}}
return a;}
function modifySmartInputBoxContent(content){if(!siw.blurring){siw.floaterContent.innerHTML='<div id="sqsSmartInputResults">'+content+'</div>';resizeSmartInputIframe();siw.matchListDisplay=document.getElementById("sqsSmartInputResults");}}
function selectFromMouseOver(o){currentIndex=getCurrentlySelectedSmartInputItem();if(currentIndex!=null)deSelectSmartInputMatchItem(currentIndex);newIndex=getIndexFromElement(o);selectSmartInputMatchItem(newIndex);modifySmartInputBoxContent(getSmartInputBoxContent());}
function selectFromMouseClick(){activateCurrentSmartInputMatch();siw.inputBox.focus();hideSmartInputFloater(true);}
function getIndexFromElement(o){index=0;while(o=o.previousSibling){index++;}
return index;}
function getCurrentlySelectedSmartInputItem(){answer=null;if(typeof(siw.matchCollection)!='undefined'&&typeof(siw.matchCollection.length)!='undefined'){for(i=0;((i<siw.matchCollection.length)&&!answer);i++){if(siw.matchCollection[i].isSelected)
answer=i;}}
return answer;}
function selectSmartInputMatchItem(index){if(typeof(siw.matchCollection[index])!='undefined')
siw.matchCollection[index].isSelected=true;}
function deSelectSmartInputMatchItem(index){siw.matchCollection[index].isSelected=false;}
function selectNextSmartInputMatchItem(){currentIndex=getCurrentlySelectedSmartInputItem();if(currentIndex!=null){deSelectSmartInputMatchItem(currentIndex);if((currentIndex+1)<siw.matchCollection.length)
selectSmartInputMatchItem(currentIndex+1);else
selectSmartInputMatchItem(0);}else{selectSmartInputMatchItem(0);}
modifySmartInputBoxContent(getSmartInputBoxContent());}
function selectPreviousSmartInputMatchItem(){currentIndex=getCurrentlySelectedSmartInputItem();if(currentIndex!=null){deSelectSmartInputMatchItem(currentIndex);if((currentIndex-1)>=0)
selectSmartInputMatchItem(currentIndex-1);else
selectSmartInputMatchItem(siw.matchCollection.length-1);}else{selectSmartInputMatchItem(siw.matchCollection.length-1);}
modifySmartInputBoxContent(getSmartInputBoxContent());}
var selIndex;function activateCurrentSmartInputMatch(){baseValue=getUserInputBase();if((selIndex=getCurrentlySelectedSmartInputItem())!=null){addedValue=siw.matchCollection[selIndex].cleanValue;theString=(baseValue?baseValue:"")+addedValue;siw.inputBox.value=theString;runMatchingLogic(addedValue,true);}}
function smartInputWindow(){this.originalInput='';this.customFloater=false;this.floater=document.getElementById("smartInputFloater");this.floaterContent=document.getElementById("smartInputFloaterContent");this.selectedSmartInputItem=null;this.MAX_MATCHES=12;this.isGecko=(navigator.userAgent.indexOf("Gecko/200")!=-1);this.isSafari=(navigator.userAgent.indexOf("Safari")!=-1);this.isWinIE=((navigator.userAgent.indexOf("Win")!=-1)&&(navigator.userAgent.indexOf("MSIE")!=-1));this.floaterIframe=document.getElementById("smartInputFloaterIframe");this.blurring=false;this.internalCall=false;}
function resizeSmartInputIframe(){siw.floaterIframe.style.width=siw.floater.offsetWidth;siw.floaterIframe.style.height=siw.floater.offsetHeight;siw.floaterIframe.style.top=siw.floater.style.top;siw.floaterIframe.style.left=siw.floater.style.left;siw.floaterIframe.style.zIndex=siw.floater.style.zIndex-2;}
function registerSmartInputListeners(){inputs=document.getElementsByTagName("input");texts=document.getElementsByTagName("textarea");allinputs=new Array();z=0;y=0;while(inputs[z]){allinputs[z]=inputs[z];z++;}
while(texts[y]){allinputs[z]=texts[y];z++;y++;}
for(i=0;i<allinputs.length;i++){if((c=allinputs[i].className)&&(c.indexOf("sqsEnabled")!=-1)){allinputs[i].setAttribute("autocomplete","OFF");allinputs[i].onfocus=handleFocus;allinputs[i].onblur=handleBlur;allinputs[i].onkeydown=handleKeyDown;allinputs[i].onkeyup=handleKeyPress;if(allinputs[i].addEventListener)
allinputs[i].addEventListener("input",handleOnPropertyChange,true);}}}
if(document.addEventListener){document.addEventListener("keydown",handleKeyDown,false);document.addEventListener("keyup",handleKeyPress,false);document.addEventListener("click",handleClick,false);document.addEventListener("mouseover",handleMouseOver,false);}else{document.onkeydown=handleKeyDown;document.onkeyup=handleKeyPress;document.onmouseup=handleClick;document.onmouseover=handleMouseOver;}
function registerSingleSmartInputListener(input){if((c=input.className)&&(c.indexOf("sqsEnabled")!=-1)){input.setAttribute("autocomplete","OFF");input.onfocus=handleFocus;input.onblur=handleBlur;input.onkeydown=handleKeyDown;input.onkeyup=handleKeyPress;if(input.addEventListener)
input.addEventListener("input",handleOnPropertyChange,true);}}
YAHOO.util.Event.addListener(window,"load",quicksearchInit);function quicksearchInit(){var floaterDiv=document.createElement('div');floaterDiv.innerHTML='<table id="smartInputFloater" class="sqsFloater" cellpadding="0" cellspacing="0"><tr><td id="smartInputFloaterContent" nowrap="nowrap">'
+'<\/td><\/tr><\/table>'+'<iframe id="smartInputFloaterIframe" class="sqsFloater" name="smartInputFloaterIframeName" src="javascript:false;" scrolling="no" frameborder="0"></iframe>'+'<div class="sqsFloater" id="smartInputFloaterWait"><img src="'+sqsWaitGif+'"></div>';document.body.appendChild(floaterDiv);floaterWait=document.getElementById("smartInputFloaterWait");registerSmartInputListeners();}
function sqs_checkForm(){answer=true;if(siw&&siw.selectingSomething)
answer=false;return answer;}
function SugarQS(){}
SugarQS.prototype.fail=function(result){}
SugarQS.prototype.display=function(result){if(typeof(result)=='undefined')
return;floaterWait.style.display="none";floaterWait.style.visibility="hidden";if(sqs_lookup_active&&result.argument['id']==sqs_request_id)sqs_lookup_active=false;if(upEl.value==''||result.argument['id']!=sqs_request_id||(result.argument['query']!=sqs_query&&sqs_query!='')){return;}
names=eval(result.responseText);collection=new Array();collection_extended=new Array();for(i=0;i<names.length;i++){escaped_name=names[i].fields[sqs_objects[sqs_id].field_list[0]].replace(/&amp;/gi,'&').replace(/&lt;/gi,'<').replace(/&gt;/gi,'>').replace(/&#039;/gi,'\'').replace(/&quot;/gi,'"');collection[i]=escaped_name;collection_extended[escaped_name]=new Array();for(j=0;j<sqs_objects[sqs_id]['field_list'].length;j++){collection_extended[escaped_name][sqs_objects[sqs_id]['field_list'][j]]=names[i].fields[sqs_objects[sqs_id].field_list[j]];}}
processSmartInput(upEl,sqs_id);}
SugarQuickSearchObject=new SugarQS();if(typeof(sqs_objects)=='undefined'){sqs_objects=new Array();}
siw=null;collectionIndex=new Array();collection_extended=new Array();sqs_object_id='';sqs_original_value='';rpc_timeout=500;floaterWait=document.getElementById("smartInputFloaterWait");from_popup_return=false;sqs_request_id=0;sqs_must_match=true;sqs_old_values=new Array();sqs_last_query='';sqs_tab_action=false;sqs_lookup_active=false;
