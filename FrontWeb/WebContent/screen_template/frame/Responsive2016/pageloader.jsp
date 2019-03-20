<!-- <div class="loading-spinner-wrapper" id="app-loader"> -->
<!-- 	<span class="loading-spinner white">  -->
<!-- 		<i></i> -->
<!-- 		<i></i> -->
<!-- 		<i></i> -->
<!-- 		<i></i> -->
<!-- 		<i></i> -->
<!-- 	</span> -->
<!-- </div> -->

<div class="loading" id="app-loader">
	<div class="bar"></div>
	<div class="bar"></div>
	<div class="bar"></div>
</div>


<style type='text/css'> 

.loading{position:relative;margin-top:0px;width:100%;height:6px;background-color:#fdba2c;margin:1px 0;z-index:1000}
.bar{content:"";display:inline;position:absolute;width:0;height:100%;left:50%;text-align:center}
.bar:nth-child(1){background-color:#da4733;animation:loading 3s linear infinite}
.bar:nth-child(2){background-color:#3b78e7;animation:loading 3s linear 1s infinite}
.bar:nth-child(3){background-color:#fdba2c;animation:loading 3s linear 2s infinite}@keyframes loading{from{left:50%;width:0;z-index:100}33.3333%{left:0;width:100%;z-index:10}to{left:0;width:100%}}


#app-loader {
	position: absolute;
	
	margin-left: -16px;
	z-index:1;
}

.loading-spinner {
  position: relative;
  display: inline-block;
  width: 55px;
  height: 7px;
  text-align: center;
}

.loading-spinner.white i {
background: #fff;
}
.loading-spinner i:nth-child(1) {
  float: left;
  -webkit-animation-delay: 0s;
  -moz-animation-delay: 0s;
  animation-delay: 0s;
}
.loading-spinner i:nth-child(2) {
  -webkit-animation-delay: 0.2s;
  -moz-animation-delay: 0.2s;
  animation-delay: 0.2s;
}
.loading-spinner i:nth-child(3) {
  -webkit-animation-delay: 0.3s;
  -moz-animation-delay: 0.3s;
  animation-delay: 0.3s;
}    
.loading-spinner i:nth-child(4) {
  -webkit-animation-delay: 0.4s;
  -moz-animation-delay: 0.4s;
  animation-delay: 0.4s;
}    
.loading-spinner i:nth-child(5) {
  -webkit-animation-delay: 0.5s;
  -moz-animation-delay: 0.5s;
  animation-delay: 0.5s;
}   

.loading-spinner i {
  vertical-align: top;
  display: inline-block;
  width: 7px;
  height: 7px;
  border-radius: 50%;
  background: #7D7D8E;
  opacity: 0;
  -webkit-animation: pulse ease-in-out 1s infinite alternate;
  -moz-animation: pulse ease-in-out 1s infinite alternate;
  animation: pulse ease-in-out 1s infinite alternate;
}

@-webkit-keyframes pulse {
    0% { opacity: 0.0}
    10% { opacity: .20}
    20% { opacity: .40 }
    30% { opacity: .60 }
    40% { opacity: .80 } 
    50% { opacity: 1.0}
    60% { opacity: .80}
    70% { opacity: .60}
    80% { opacity: .40}
    90% { opacity: .20}
    100% { opacity: 0.0}
}

/* 20180521 - fixed menu was hidden */
#sideBarMenuMobile {
	height:60vh !important;			/* 1vh = 1% of browser screen height */
	overflow-y:scroll !important;
}

</style>



<script>

$(window).resize(function() { 

	$('div.wrapbigmenu').css("display", "");
	  
  	if(($(window).height()) <= 498) {
		$('div.content-wrapper').css("min-height", '');
	}

  	if(($(window).height()) > 960) {
		$('div.content-wrapper').css("min-height", '1024');
	}
});

$(".wrapbigmenu a").on('click', function(){
  	$data="topMenuId="+$(this).attr('data-menu-id');
  	$.ajax({
      	url: '<%=request.getContextPath()%>/ReLoadMobileMenu',
      	type: 'POST',
      	dataType: 'html',
      	data: $data
  	}).done(function(data) {  
  		$('#sideBarMenuMobile').html(data);
  	});
});

</script>