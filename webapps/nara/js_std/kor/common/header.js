function goLeftAndRightDivRenderHeader(strUrl, tabClassName, menuSubName){
	var leftUrl ;
	if(menuSubName =="bbs") leftUrl = "/jsp_std/kor/menu/leftboard.jsp";
	else if(menuSubName =="intranet") leftUrl = "/jsp_std/kor/menu/leftintranet.jsp";
	else if(menuSubName =="schedule") leftUrl = "/jsp_std/kor/menu/leftschedule.jsp";
	else if(menuSubName =="address") leftUrl = "/jsp_std/kor/menu/leftbase.jsp";
	else if(menuSubName =="note") leftUrl = "/jsp_std/kor/menu/leftnote.jsp";
	else if(menuSubName =="ecard") leftUrl = "/jsp_std/kor/menu/leftecard.jsp";
	else leftUrl = "/jsp_std/kor/menu/leftbase.jsp";
	
	if(parent.document.getElementById("api").src.indexOf(leftUrl) ==-1){
		parent.document.getElementById("api").src = leftUrl;
	}
	parent.document.getElementById("mainPanel").src =strUrl;
	
}