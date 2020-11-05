document.onkeydown = function() {
	var event = window.event || e;
	if(event.keyCode == 116) {
		event.keyCode = 0;
	 	return false; 
	} else if((event.keyCode == 78) && (event.ctrKey == true)) { //컨트롤 + N 막기
	 	event.keyCode = 0;
	 	return false;
	} else if(event.keyCode == 8 ) { //백스페이스 키 막기
	  	var obj = (event.srcElement) ? event.srcElement : event.target; 
		if( (obj.tagName != "INPUT" && obj.tagName != "TEXTAREA")){
			event.keyCode = 0;
	  		return false;
		}	
//	} else if(event.ctrlKey == true ){ //컨트롤 완전 막기
//	  return false;
	}
}