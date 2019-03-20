function tmp2createmenu(arrobj,arrtxt){ 
	Mnob = document.createElement("DIV"); 
	Mnob.style.position="absolute"; 
	Mnob.style.visibility="hidden"; 
	tmp2tutwi=subWidth; 
	Mnob.style.width=tmp2tutwi; 
	Mnob.Iwidth=tmp2tutwi; 
	Mnob.sagbak=1; 
	Mnob.style.zIndex=(tmp2zminx++); 
	Mnob.style.background=subMenuOutBgColor; 
	Mnob.style.left=imgpx; 
	Mnob.style.padding=0; 
	Mnob.style.borderStyle="solid"; 
	Mnob.style.borderWidth="1"; 
	Mnob.style.borderColor=subMenuOutBorderColor; 
	Mnob.innerHTML=""; 
	Mnob.trtext=""+arrtxt; 
	Mnob.a21=0; 
	Mnob.tmpobj21=null; 
	Mnob.tmpobj21o=null; 
	Mnob.onmouseover = tmp2mblockover; 
	Mnob.onmouseout = tmp2mblockout; 
	Mnob.tmp2hideobjchilds=tmp2hidechildsI21; 
	document.body.appendChild(Mnob); 
	eval("tmp2ma_rr"+arrtxt+"obj=Mnob"); 
	prevh=0; 
	addh=0; 
	subbh=0; 
	Mnob.className='select-free';
	Mnob.appendChild(document.createElement("IFRAME")); 
	for(i=0;i<arrobj.length;i++) { 
		subm = Mnob.appendChild(document.createElement("DIV")); 
		subm.style.position="absolute"; 
		subm.style.visibility="inherit"; 
		subm.style.width=tmp2tutwi-2*parseInt("1")-0-0; 
		subm.style.left=0; 
		subm.style.top=addh; 
		subm.style.background=subMenuInBgColor; 
		subm.style.color=subMenuFontColor; 
		subm.style.fontFamily=subMenuFont; 
		subm.style.fontSize=subMenuFontSize; //<-- font size sub menu
		subm.style.fontStyle="normal"; 
		subm.style.fontWeight="normal"; 
		subm.style.textAlign="left"; 
		subm.style.textDecoration="none"; 
		subm.style.paddingLeft="10px"; 
		subm.style.paddingTop="0px"; 
		subm.style.paddingBottom="0px"; 
		subm.style.paddingRight="8px"; 
		if(arrobj[i][1].length<3) {
			subm.style.cursor='default';
		} else {
			subm.style.cursor='hand';
		} 
		subm.style.borderStyle="solid"; 
		subm.style.borderWidth="0"; 
		subm.style.borderColor=subMenuInBorderColor; 
		subm.hassub=arrobj[i][3]; 
		subm.hastext=""+arrtxt+"_"+i; 
		subm.uptext=""+arrtxt; 
		subm.ownindex=""+i; 
		subm.linktx=arrobj[i][1]; 
		subm.targtx=arrobj[i][2]; 
		subm.onclick= tmp2itemclick; 
		subm.onmouseover = tmp2itemmover; 
		subm.onmouseout = tmp2itemmout; 
		eval("tmp2submi"+arrtxt+"_"+i+"obj=subm"); 
		subtv="tmp2submi"+arrtxt+"_"+i+"img"; 
		arrowposx=tmp2tutwi-2*parseInt("1")-0-0-(12); 
		icontxt=""; 
		if(arrobj[i][3]==1) {
			if(arrobj[i][1].length>3){
				ticont="<a href=\""+arrobj[i][1]+"\""; 
				if (arrobj[i][2].length>3) ticont += " target=\"" + arrobj[i][2] + "\"";
				ticont+="><span style=\"position:relative;z-index:2;height:100%;width:100%\">"+arrobj[i][0]+"</span></a>"; 
			}else{
				ticont="<span style=\"position:relative;z-index:2;height:100%;width:100%\">"+arrobj[i][0]+"</span>"; 
			}
			ticont=ticont+icontxt; 
			if(tmp2istherearrow==1){
				ticont=ticont+"<img src=\""+theme_path+"/images/arrow_black1.gif"+"\" id=\""+subtv+"b\" style=\"position:absolute;visibility:inherit;z-index:3;top:"+7+";left:"+arrowposx+";\" border=\"0\">";
			} 
			if(tmp2istheremoarrow==1){
				ticont=ticont+"<img src=\""+theme_path+"/images/arrow_y2.gif"+"\" id=\""+subtv+"a\" style=\"position:absolute;visibility:hidden;z-index:3;top:"+7+";left:"+arrowposx+";\" border=\"0\">";
			} 
			subm.innerHTML=ticont; 
		} else {
			if(arrobj[i][1].length>3){
				ticont2="<a href=\""+arrobj[i][1]+"\""; 
				if (arrobj[i][2].length>3) ticont2 += " target=\"" + arrobj[i][2] + "\"";
				ticont2+="><span style=\"position:relative;z-index:2;height:100%;width:100%\">"+arrobj[i][0]+"</span></a>"; 
			}else{
				ticont2="<span style=\"position:relative;z-index:2;height:100%;width:100%\">"+arrobj[i][0]+"</span>"; 
			}
			ticont2=ticont2+icontxt; subm.innerHTML=ticont2; 
		} 
		prevh=subm.offsetHeight; 
		if(i==(arrobj.length-1)) { 
			addh=addh+prevh; 
		} else { 
			addh=addh+prevh+1; 
		} 
	} 
	Mnob.style.height=addh+0+2*parseInt("1"); 
	Mnob.skh=addh+0+2*parseInt("1");
}
function tmp2itemclick(){
}
//mainmenu onmouseover one tab
function tmp2htmover(){ 
	d1=0; 
	for(d1=0;d1<=tmp2pgi_co;d1++) { 
		if(d1!=this.sinex) { 
			tmp2htmout2(d1); 
		} 
	}
	this.style.background=mainMenuInBgColor2; 
	this.style.color=mainMenuFontColor2; 
	this.style.textDecoration="none"; 
	this.style.borderColor=mainMenuInBorderColor2; 
	if(this.imgvar==1) { 
		gco=eval("tmp2bir"+this.sinex); 
		gco.style.visibility="hidden"; 
	} 
	if(this.moimgvar==1) { 
		gco=eval("tmp2iki"+this.sinex); 
		gco.style.visibility="visible"; 
		gcoB=eval("tmp2ikiB"+this.sinex); 
		gcoB.style.visibility="visible"; 
	} 
	tmp2mover(this.sinex,this);
}
function tmp2htmout(){ 
	tmp2mout(this.sinex,this); 
}
//mainmenu onmouseover all tabs
function tmp2htmout2(getindx){ 
	htmotmp=eval("tmp2pgiid"+getindx); 
	htmotmp.style.background=mainMenuInBgColor; 
	htmotmp.style.color=mainMenuFontColor; 
	htmotmp.style.textDecoration="none"; 
	htmotmp.style.borderColor=mainMenuInBorderColor;
	if(htmotmp.imgvar==1) { 
		gco=eval("tmp2bir"+htmotmp.sinex); 
		gco.style.visibility="visible"; 
	} 
	if(htmotmp.moimgvar==1) { 
		gco=eval("tmp2iki"+htmotmp.sinex); 
		gco.style.visibility="hidden"; 
		gcoB=eval("tmp2ikiB"+htmotmp.sinex); 
		gcoB.style.visibility="hidden"; 
	} 
}
//step 1
function tmp2initmenu(){
	tmp2plcmenu1 = tmp2hmplcmenu1.appendChild(document.createElement("DIV")); 
	tmp2plcmenu1.style.width=0;
	tmp2plcmenu1.style.height=0;
	tmp2plcmenu1.style.position="relative";
	tmp2plcmenu1.style.top=0;
	tmp2plcmenu1.style.left=0;
	tmp2plcmenu1.style.overflow="visible";
	tmp2plcmenu1.style.borderLeftWidth=0;
	tmp2plcmenu1.style.borderTopWidth=0;
	tmp2plcmenu1.style.borderRightWidth=0;
	tmp2plcmenu1.style.borderBottomWidth=0;
	tmp2plcmenu1.style.borderStyle="solid";
	tmp2plcmenu1.style.borderColor=mainMenuOutBorderColor;
	if(tmp2ver_hor==0){
	}else{
		tmp2plcmenu1.style.height=mainHeight;
		tmp2hmplcmenu1.style.height=mainHeight;
		ctopw=0;
		cposx=0; 
		/*mainmenu style*/
		for(i=0;i<=tmp2pgi_co;i++) { 
			subm = tmp2plcmenu1.appendChild(document.createElement("DIV")); 
			subm.id="tmp2pgiid"+i; 
			subm.style.position="absolute"; 
			subm.style.visibility="inherit"; 
			subm.style.width=mainWidth; 
			subm.style.height=mainHeight-0-0-parseInt(1+1); 
			subm.style.background=mainMenuInBgColor; 
			subm.style.overflow="hidden"; 
			subm.style.color=mainMenuFontColor; 
			subm.style.fontFamily=mainMenuFont; 
			subm.style.fontSize=mainMenuFontSize;
			subm.style.fontStyle="normal"; 
			subm.style.fontWeight="bold"; 
			subm.style.textAlign="center"; 
			subm.style.textDecoration="none"; 
			subm.style.paddingTop="0px"; 
			subm.style.paddingLeft="4px"; 
			subm.style.paddingRight="4px"; 
			subm.sinex=i; 
			subm.style.left=cposx+(1*i); 
			cposx=cposx+mainWidth; 
			subm.style.top=0; 
			subm.style.borderWidth="0"; 
			subm.style.borderStyle="solid"; 
			subm.style.borderColor=mainMenuInBorderColor; 
			if(tmp2hma_in0[i][1].length<3) { 
				subm.style.cursor='default'; 
			} else { 
				subm.style.cursor='hand'; 
			} 
			if(tmp2hma_in0[i][1].length>3){
				xxx="<a href=\""+tmp2hma_in0[i][1]+"\""; 
				if (tmp2hma_in0[i][2].length>3) xxx += " target=\"" + tmp2hma_in0[i][2] + "\"";
				xxx+="><span style=\"position:relative;z-index:2;height:100%;width:100%\">"+tmp2hma_in0[i][0]+"</span></a>"; 
				subm.innerHTML = xxx;
			}else{
				subm.innerHTML="<span style=\"position:relative;z-index:2;height:100%;width:100%\">"+tmp2hma_in0[i][0]+"</span>"; 
			}
			subm.imgvar=0; 
			subm.moimgvar=0; 
			subm.linktx=tmp2hma_in0[i][1]; 
			subm.targtx=tmp2hma_in0[i][2]; 
			subm.onclick= tmp2itemclick; 
			subm.onmouseover = tmp2htmover; 
			subm.onmouseout = tmp2htmout; 
		} 
		tmp2plcmenu1.style.width=cposx+0+parseInt(1+1)+(1*(tmp2hma_in0.length-1)); 
		tmp2hmplcmenu1.style.width=tmp2plcmenu1.style.width;
	}
}
function tmp2initmenu2(){ 
	if(!tmp2hmplcmenu1) { 
		setTimeout("tmp2initmenu2()",500); 
	} else { 
		setTimeout("tmp2initmenu()",300); 
	}
}
function tmp2fimg(simgo){ 
	if(tmp2istheremoicon==1) { 
		timg2=eval("tmp2submi"+simgo.hastext+"img"); 
		timg2.style.visibility="hidden"; 
	} 
	if(tmp2isthereicon==1) { 
		timg6=eval("tmp2submi"+simgo.hastext+"imgf"); 
		timg6.style.visibility="inherit"; 
	} 
	if(simgo.hassub==1) { 
		if(tmp2istheremoarrow==1) { 
			timg4=eval("tmp2submi"+simgo.hastext+"imga"); 
			timg4.style.visibility="hidden"; 
		} 
		if(tmp2istherearrow==1) { 
			timg8=eval("tmp2submi"+simgo.hastext+"imgb"); 
			timg8.style.visibility="inherit"; 
		} 
	} 
}
function tmp2himg(simgosh){ 
	if(tmp2istheremoicon==1) { 
		timg=eval("tmp2submi"+simgosh.hastext+"img"); 
		timg.style.visibility="inherit"; 
	} 
	if(tmp2isthereicon==1) { 
		timg5=eval("tmp2submi"+simgosh.hastext+"imgf"); 
		timg5.style.visibility="hidden"; 
	} 
	if(simgosh.hassub==1) { 
		if(tmp2istheremoarrow==1) { 
			timg3=eval("tmp2submi"+simgosh.hastext+"imga"); 
			timg3.style.visibility="inherit"; 
		} 
		if(tmp2istherearrow==1) { 
			timg7=eval("tmp2submi"+simgosh.hastext+"imgb"); 
			timg7.style.visibility="hidden"; 
		} 
	}
}
function tmp2mover(mnum,imgobj){ 
	for(a23=0;a23<=tmp2pgi_co;a23++) { 
		tdecis=tmp2hma_in0[a23][3]; 
		if(parseInt(tdecis)==1) { 
			tmpobj=eval("tmp2ma_rr"+a23+"obj"); 
			if(tmpobj) { 
				tmpobj.tmp2hideobjchilds(); 
				if(parseInt(tmp2hma_in0[mnum][3])==1) { 
					if(tmpobj==eval("tmp2ma_rr"+mnum+"obj")){
					} else { 
						tmpobj.style.visibility="hidden"; 
					} 
				} else{
					tmpobj.style.visibility="hidden";
				} 
			} 
		} 
	} 
	clearTimeout(tmp2timepop2); 
	clearTimeout(tmp2timepop); 
	var g1=parseInt(document.body.scrollTop); 
	var g3=document.body.clientHeight; 
	var g4=parseInt(document.body.clientWidth); 
	var g6=parseInt(document.body.scrollLeft); 
	if(tmp2ver_hor==0) { 
		imgpx=tmp2hmplcmenu1.offsetLeft+parseInt(tmp2hmplcmenu1.style.width)+(-1); 
		imgpy=imgobj.offsetTop+tmp2hmplcmenu1.offsetTop+parseInt(1)+(2)-g1-(1); 
	} else { 
		imgpx=imgobj.offsetLeft+tmp2hmplcmenu1.offsetLeft+parseInt(1)+(-1)-g6; 
		imgpy=imgobj.offsetTop+tmp2hmplcmenu1.offsetTop+parseInt(imgobj.style.height)+parseInt(1)+(2)-g1-(1); 
	} 
	tdecis=tmp2hma_in0[mnum][3]; 
	if(parseInt(tdecis)==1) { 
		tmpobj=eval("tmp2ma_rr"+mnum+"obj"); 
		if(!tmpobj) { 
			tmp2createmenu(eval("tmp2ma_rr"+mnum+""),""+mnum); 
		} 
	} 
	if(parseInt(tdecis)==1) { 
		tmpobj=eval("tmp2ma_rr"+mnum+"obj"); 
		tmpobj.style.height=tmpobj.skh; 
		tmpobj.style.width=tmpobj.Iwidth; 
		tmpobj.style.overflow="hidden"; 
		if((imgpy+g1+parseInt(tmpobj.style.height))>(g1+g3)) { 
			if((tmp2hmplcmenu1.offsetTop-g1)>parseInt(tmpobj.style.height)) { 
				if(tmp2ver_hor==0) { 
					tmpobj.style.top=g1+g3-parseInt(tmpobj.style.height); 
				} else { 
					tmpobj.style.top=tmp2hmplcmenu1.offsetTop-parseInt(tmpobj.style.height)+parseInt(1)+0; 
				} 
			} else { 
				if(parseInt(tmpobj.style.height)<g3) { 
					tmpobj.style.top=g1+(g3-parseInt(tmpobj.style.height)); 
				} else { 
					tmpobj.style.height=g3-4; tmpobj.style.overflowX="hidden"; 
					tmpobj.style.overflowY="scroll"; 
					var sdeg=parseInt(tmpobj.Iwidth)-parseInt(tmpobj.clientWidth)-(2*parseInt("1")); 
					tmpobj.style.width=parseInt(tmpobj.Iwidth)+parseInt(sdeg); 
					tmpobj.style.top=(g1+2)+"px"; 
				} 
			} 
		} else { 
			tmpobj.style.top=imgpy+g1+"px"; 
		} 

		if((imgpx+parseInt(tmpobj.style.width))>(g4+g6)) { 
			if((tmp2hmplcmenu1.offsetLeft-g6)>parseInt(tmpobj.style.width)) { 
				if(tmp2ver_hor==0) { 
					tmpobj.style.left=tmp2hmplcmenu1.offsetLeft-parseInt(tmpobj.style.width)-(-1); 
				} else { 
					tmpobj.style.left=imgpx+"px"; 
				} 
			} else { 
				tmpobj.style.left=imgpx+"px"; 
			} 
			tmpobj.sagbak=0; 
		} else { 
			tmpobj.style.left=imgpx+"px"; 
			tmpobj.sagbak=1; 
		} 
		if(tmpobj.style.visibility!="visible") { 
			if(e1==1){
				tmpobj.filters[0].apply();
			} 
			tmpobj.style.visibility="visible"; 
			if(e1==1){
				tmpobj.filters[0].play();
			} 
		} 
	} 
}

function tmp2mout(mnum,imgobj){ 
	tmp2timepop2=setTimeout('tmp2hideblocks()',500);
}
function tmp2itemmover(){ 
	this.style.background=subMenuInBgColor2; 
	this.style.color=subMenuFontColor2; 
	this.style.textDecoration="none"; 
	this.style.borderColor=subMenuInBorderColor2; 
	tmp2himg(this); 
	if(this.hassub==1) { 
		tmpobj=eval("tmp2ma_rr"+this.hastext+"obj"); 
		if(!tmpobj) { 
			tmp2createmenu(eval("tmp2ma_rr"+this.hastext+""),""+this.hastext); 
		} 
		tmpobj=eval("tmp2ma_rr"+this.hastext+"obj"); 
		if(tmpobj.style.visibility!="visible") { 
			var g1=parseInt(document.body.scrollTop); 
			var g2=parseInt(this.parentNode.style.left); 
			var g4=parseInt(document.body.clientWidth); 
			var g5=parseInt(document.body.clientHeight); 
			var g6=parseInt(document.body.scrollLeft); 
			tmpobj.style.width=parseInt(tmpobj.Iwidth); 
			tmpobj.style.height=tmpobj.skh; 
			tmpobj.style.overflow="hidden"; 
			if(e1==1){
				tmpobj.filters[0].apply();
			} 
			tmpobj.style.visibility="visible"; 
			if(e1==1){
				tmpobj.filters[0].play();
			} 
			tmp2tutwi=parseInt(this.parentNode.style.width); 
			tmp2tutwi2=parseInt(tmpobj.style.width); 
			dd=eval("tmp2ma_rr"+this.uptext+"obj"); 
			var yd=dd.sagbak; 
			if((parseInt(this.parentNode.offsetTop)+parseInt(this.style.top)+parseInt(tmpobj.skh)-g1+(0))<g5) { 
				//tmpobj.style.top=parseInt(this.parentNode.style.top)+parseInt(this.style.top)+(0); 
				tmpobj.style.top=parseInt(this.parentNode.style.top)+parseInt(this.style.top); 
			} else { 
				if(parseInt(tmpobj.style.height)<(g5-4)) { 
					tmpobj.style.top=g1+g5-parseInt(tmpobj.skh)-(1); 
				} else { 
					tmpobj.style.height=g5-4; tmpobj.style.overflowX="hidden"; 
					tmpobj.style.overflowY="scroll"; 
					var sdeg=parseInt(tmpobj.Iwidth)-parseInt(tmpobj.clientWidth)-(2*parseInt("1")); 
					tmpobj.style.width=parseInt(tmpobj.Iwidth)+parseInt(sdeg); tmpobj.style.top=(g1+2)+"px"; 
				} 
			} 
			tmp2tutwi=parseInt(this.parentNode.style.width); 
			tmp2tutwi2=parseInt(tmpobj.style.width); 
			g2=parseInt(this.parentNode.style.left); 
			if(yd==1) { 
				if((parseInt(tmpobj.style.width)+g2+tmp2tutwi+(1))< (g4+g6)) { 
					tmpobj.sagbak=1; 
					//tmpobj.style.left=g2+tmp2tutwi+(1); 
					tmpobj.style.left=g2+tmp2tutwi; 
				} else { 
					tmpobj.sagbak=0; 
					//tmpobj.style.left=g2-tmp2tutwi2-(1); 
					tmpobj.style.left=g2-tmp2tutwi2; 
				} 
			} else { 
				if((g2-parseInt(tmpobj.style.width))>(g6+2)) { 
					tmpobj.sagbak=0; 
					tmpobj.style.left=g2-tmp2tutwi2-(1); 
				} else { 
					tmpobj.sagbak=1; 
					tmpobj.style.left=g2+tmp2tutwi+(1); 
				} 
			} 
		} 
		tmpobj.tmp2hideobjchilds(); 
	} 
	etxt="tmp2ma_rr"+this.uptext+""; 
	tmpobj2=eval(etxt); 
	for(a=0;a<parseInt(tmpobj2.length);a++) { 
		if(parseInt(this.ownindex)!=a) { 
			if(parseInt(tmpobj2[a][3])==1) { 
				tmpobj3=eval("tmp2ma_rr"+this.uptext+"_"+a+"obj"); 
				if(tmpobj3) { 
					tmpobj3.style.visibility="hidden";
					if(tmpobj3.trtext.length>1){ 
						tmpobj5=eval("tmp2submi"+tmpobj3.trtext+"obj"); 
						tmpobj5.style.background=subMenuInBgColor; 
						tmpobj5.style.color=subMenuFontColor; 
						tmpobj5.style.textDecoration="none"; 
						tmpobj5.style.borderColor=subMenuInBorderColor; 
						tmp2fimg(tmpobj5);
					} 
					tmpobj3.tmp2hideobjchilds(); 
				} 
			} 
		} 
	}
}
function tmp2itemmout(){ 
	this.style.background=subMenuInBgColor; 
	this.style.color=subMenuFontColor; 
	this.style.textDecoration="none"; 
	this.style.borderColor=subMenuInBorderColor; 
	tmp2fimg(this); 
}
function tmp2hidechildsI21(){ 
	this.a21=0; 
	this.tmpobj21=eval("tmp2ma_rr"+this.trtext+""); 
	for(this.a21=0;this.a21<this.tmpobj21.length;this.a21++) { 
		if(parseInt(this.tmpobj21[this.a21][3])==1) { 
			this.tmpobj21o=eval("tmp2ma_rr"+this.trtext+"_"+this.a21+"obj"); 
			if(this.tmpobj21o) { 
				this.tmpobj21o.style.visibility="hidden"; 
				if(this.tmpobj21o.trtext.length>1) { 
					tmpobj6=eval("tmp2submi"+this.tmpobj21o.trtext+"obj"); 
					tmpobj6.style.background=subMenuInBgColor; 
					tmpobj6.style.color=subMenuFontColor; 
					tmpobj6.style.textDecoration="none"; 
					tmpobj6.style.borderColor=subMenuInBorderColor; 
					tmp2fimg(tmpobj6); 
				} 
				this.tmpobj21o.tmp2hideobjchilds(); 
			} 
		} 
	}
}
function tmp2hideblocks(){
var elements=document.getElementsByTagName("div");
for (var i=0;i<elements.length ;i++ ){
	var currentElement = elements[i];
	if(currentElement.id.indexOf("tmp2pgiidR")==-1){
		if(currentElement.id.indexOf("tmp2pgiid")!=-1){
			var tmpid = currentElement.id.substring(9,currentElement.id.length);
			tmp2htmout2(tmpid);
			tmpobj=eval("tmp2ma_rr"+tmpid+"obj");
			if(tmpobj){
				tmpobj.tmp2hideobjchilds();
				tmpobj.style.visibility="hidden";
			}
		}
	}
}
}
function tmp2mblockover(){
	if(this.trtext.length>1){ 
		if(tmp2ich==1) { 
			tmpobj4=eval("tmp2submi"+this.trtext+"obj"); 
			tmpobj4.style.background=subMenuInBgColor2; 
			tmpobj4.style.color=subMenuFontColor2; 
			tmpobj4.style.textDecoration="none"; 
			tmpobj4.style.borderColor=subMenuInBorderColor2; 
		} 
		if(tmp2ich==1) { 
			tmp2himg(tmpobj4); 
		} 
	} 
	clearTimeout(tmp2timepop); 
	clearTimeout(tmp2timepop2);
}
function tmp2mblockout(){ 
	tmp2timepop=setTimeout('tmp2hideblocks()',500);
}
function getx(o){
	var n;
	var parent;
	n=o.offsetLeft;
	while(o.offsetParent!=null){
		parent = o.offsetParent;
		n=n+parent.offsetLeft;
		o = parent;
	}
	return n;
}
function gety(o){
	var n;
	var parent;
	n=o.offsetTop;
	while(o.offsetParent!=null){
		parent = o.offsetParent;
		n=n+parent.offsetTop;
		o = parent;
	}
	return n;
}
