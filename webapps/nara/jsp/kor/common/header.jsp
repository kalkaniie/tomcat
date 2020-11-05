<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.springframework.service.UsersService"%>
<%@page import="com.nara.jdf.db.entity.OrganizeEntity"%>
<%@page import="com.nara.web.narasession.OrganizeSession"%>
<% 	
	UserEntity userEntity  = UserSession.getUserInfo(request);
	com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
	List oragnList = (ArrayList)OrganizeSession.getObject(request, "orgainzeList");
	
	int ORGANIZE_IDX = -1;
	if (oragnList != null && oragnList.size() >0) {
		try {
			OrganizeEntity organizeEntity =  (OrganizeEntity)oragnList.get(0);
			ORGANIZE_IDX = organizeEntity.ORGANIZE_IDX;
		} catch(Exception e){}
	} else {
		if (UsersService.isAdmin(userEntity)) {
			ORGANIZE_IDX = 0;
		}
	}
	// 메신저(activeX) 자동 실행
	String base64UserInfo = "";
	String serialKeyTmp =conf.getString("com.nara.msg.activex.messenger.serialKey");
	String downloadTmp =conf.getString("com.nara.msg.activex.messenger.download");
	String strProductGUID ="",strDownloadName="";
	if(conf.getBoolean("com.nara.msg")){
		
		strProductGUID = (serialKeyTmp == null || "".equals(serialKeyTmp))?"0E87AAA4-7C9A-4583-8510-7132149C4BF8": serialKeyTmp ;  //시리얼키
		strDownloadName = (downloadTmp == null || "".equals(downloadTmp))?"http://demo.kebiportal.com/nara/imtong30/Install/KebiMessengerSetup.exe":downloadTmp ;  //시리얼키
		
		try{
			String base64code = userEntity.USERS_ID+"\2"+ UserSession.getString(request,"USERS_PASSWD_ENC");
			base64UserInfo = new sun.misc.BASE64Encoder().encode(base64code.getBytes());
		}catch(Exception ex){
			System.out.println("error" + ex.toString());
		}
	}	
%>
<SCRIPT LANGUAGE=JavaScript>
<% if(conf.getBoolean("com.nara.msg")){ %> 
function callKebiMessenger(){
		setupTong('<%=base64UserInfo%>', '<%=userEntity.DOMAIN%>','<%=strProductGUID%>', '<%=strDownloadName%>');
}
<%}%>

var USERS_LISTNUM = <%=userEntity.USERS_LISTNUM%>;
function viewSearchDetail(){
	onoff("k_searchBox_header");
	document.header_search_form.search_strKeyword_div.value="";
}
function viewSearchDirect(){
	var objForm = document.header_search_form;
	
	if( objForm.search_strKeyword.value ==""){
<%if(UsersService.isAlias(request)){ %>
		objForm.k_selectBox.style.visibility = 'visible';
<%}%>
		alert("검색어를 입력하여 주십시요");
		objForm.search_strKeyword.focus();
		return;
	}
	
	var M_TITLE 		= objForm.M_TITLE.checked ? "M_TITLE":""
	var M_SENDER 		= objForm.M_SENDER.checked ? "M_SENDER":""
	var M_SENDERNM 		= objForm.M_SENDERNM.checked ? "M_SENDERNM":""
	var M_TO 			= objForm.M_TO.checked ? "M_TO":""
	var M_ATTACH_NAME 	= objForm.M_ATTACH_NAME.checked ? "M_ATTACH_NAME":""
	
   	var params = "method=mail_list"
			   	+ "&MBOX_IDX=0"
				+ "&MBOX_TYPE=0"
				+ "&TAG_TYPE=0"
				+ "&VIEW_TYPE=search" 				
				+ "&READ_MODE=ALL"
				+ "&M_TITLE="+M_TITLE
			 	+ "&M_SENDER="+M_SENDER
				+ "&M_SENDERNM="+M_SENDERNM
			 	+ "&M_TO="+M_TO
			 	+ "&M_ATTACH_NAME="+M_ATTACH_NAME
			 	+ "&search_strIndex="+objForm.search_strIndex.value
			 	+ "&search_strKeyword="+(objForm.search_strKeyword.value).toLowerCase()
			 	+ "&search_startdt="+objForm.search_startdt.value
			 	+ "&search_enddt="+objForm.search_enddt.value;
			 	
	params = encodeURI(params);						 			
	goLeftAndRightDivRender('webmail.auth.do?'+params,'검색','search_mail');
	objForm.search_strKeyword_div.value =objForm.search_strKeyword.value;
	onoff("k_searchBox_header");	
}
function viewSearchDetailSubmit(){
	var objForm = document.header_search_form;
	
	if( objForm.search_strKeyword_div.value ==""){
		alert("검색어를 입력하여 주십시요");
		objForm.search_strKeyword_div.focus();
		return;
	}
	
	var M_TITLE 		= objForm.M_TITLE.checked ? "M_TITLE":""
	var M_SENDER 		= objForm.M_SENDER.checked ? "M_SENDER":""
	var M_SENDERNM 		= objForm.M_SENDERNM.checked ? "M_SENDERNM":""
	var M_TO 			= objForm.M_TO.checked ? "M_TO":""
	var M_ATTACH_NAME 	= objForm.M_ATTACH_NAME.checked ? "M_ATTACH_NAME":""
	
   	var params = "method=mail_list"
			   	+ "&MBOX_IDX=0"
				+ "&MBOX_TYPE=0"
				+ "&TAG_TYPE=0"
				+ "&VIEW_TYPE=search" 				
				+ "&READ_MODE=ALL"
				+ "&M_TITLE="+M_TITLE
			 	+ "&M_SENDER="+M_SENDER
				+ "&M_SENDERNM="+M_SENDERNM
			 	+ "&M_TO="+M_TO
			 	+ "&M_ATTACH_NAME="+M_ATTACH_NAME
			 	+ "&search_strIndex="+objForm.search_strIndex.value
			 	+ "&search_strKeyword="+(objForm.search_strKeyword_div.value).toLowerCase()
			 	+ "&search_startdt="+objForm.search_startdt.value
			 	+ "&search_enddt="+objForm.search_enddt.value;
			 	
	params = encodeURI(params);		
	goLeftAndRightDivRender('webmail.auth.do?'+params,'검색','search_mail');
}

Ext.onReady(function(){
	var df1 = new Ext.form.DateField({
		id:'search_startdt',
		name:'search_startdt',
		format: 'Y-m-d',
        minValue: '01/01/06',
        vtype: 'daterange',
        endDateField: 'search_enddt'
	})
	
	df1.render('search_data_picker_start');
	
	var df2 =new Ext.form.DateField({
		id:'search_enddt',
		name:'search_enddt',
        format: 'Y-m-d',
        minValue: '01/01/06',
        vtype: 'daterange',
        startDateField: 'search_startdt'
    })
	df2.render('search_data_picker_end');
	var _date = new Date();
	var toDate = _date.format('Y-m-d');
	var prevMonth = ((new Date()).add(Date.MONTH, -1)).format('Y-m-d');
    df1.setValue(prevMonth);
	df2.setValue(toDate);
});	

function userAliasChange() {
	var objForm = document.header_search_form;
	objForm.USERS_IDX.value = objForm.USERS_DELEGATE_LIST.value;
	objForm.method.value = "login";
	objForm.action = "user.public.do";
	objForm.LOGIN_TYPE.value = "DELEGATE_LOGIN";
	objForm.submit();
}
</script>

<form name="header_search_form">
<input type="hidden" name="method" value="">
<input type="hidden" name="USERS_IDX" value="">
<input type="hidden" name="LOGIN_TYPE" value="">
<input type="hidden" name="USERS_LICENCENUM" value="<%=userEntity.USERS_LICENCENUM %>">

<div class="k_topHd">
	<div class="k_topLogo">
	<a href="user.public.do?method=logout"><img src="/images/kor/top/logo.gif"  style="text-align:center" /></a>
	</div>
	
	<div class="k_topMuBox">
		<b><%=userEntity.USERS_NAME%>님</b>
		<a href="user.public.do?method=logout"><img src="/images/kor/top/topBtn_login.gif" /></a>
		<span class="k_topMuSpan">
			<a href="user.public.do?method=login_form&USERS_LOGIN_MODE=text">Text Edition</a><img src="/images/kor/top/line_Topsec.gif" />
			<a href="user.public.do?method=login_form&USERS_LOGIN_MODE=std">Standard</a><img src="/images/kor/top/line_Topsec.gif" />
			<a href="javascript:MM_openBrWindow('userenv.auth.do?method=my_info','env','scrollbars=yes,width=955,height=520');" >환경설정</a><img src="/images/kor/top/line_Topsec.gif" />
			<a href="javascript:MM_openBrWindow('/jsp/kor/help/helpM.html','help','scrollbars=no,width=720,height=565');">도움말</a><img src="/images/kor/top/line_Topsec.gif" />
			<%if(UserSession.isAdmin(request)){ %>
			<a href="javascript:MM_openBrWindow('user.admin.do?method=user_list','admin','scrollbars=yes,width=1024,height=730');">관리자</a>
			<%}%>
		</span>
	</div>
	<div class="k_topSrBox">
		<input name="search_strKeyword" type="text"  style="margin-left:5px" class="k_topSrBoxInput" onkeydown="javascript:if(event.keyCode == 13) { viewSearchDirect(); return false}"/><a href="javascript:viewSearchDirect();" <%if(UsersService.isAlias(request)){ %>onclick="k_selectBox.style.visibility='hidden'"<%}%>><img src="/images/kor/top/topBtn_search.gif" /></a><a href="javascript:viewSearchDetail();" <%if(UsersService.isAlias(request)){ %>onclick="k_selectBox.style.visibility='hidden'"<%}%>><img src="/images/kor/top/topBtn_searchD.gif" /></a>
	</div>
	<ul class="k_topMailMu">
	<li class="k_topMailMuF"><a href="javascript:mainPanel.setActiveTab(0)" style="background:none"><img src="/images/kor/top/topMu_mypage.gif" /></a></li>
	<li class="k_topMailMuS"><a href="javascript:goLeftAndRightDivRender('webmail.auth.do?method=mail_list','받은편지함','mail')"><img src="/images/kor/top/topMu_mail.gif" /></a></li>
	<%if(UsersService.isValidModule(request,"schedule")){ %>
	<li class="k_topMailMuS"><a href="javascript:goLeftAndRightDivRender('schedule.auth.do?method=main','일정','schedule')"><img src="/images/kor/top/topMu_schedule.gif" /></a></li>
	<%}%>
	<%if(UsersService.isValidModule(request,"webfile")){ %>
	<li class="k_topMailMuS"><a href="javascript:goLeftAndRightDivRender('webfile.auth.do?method=showMain','파일관리','webfile')"><img src="/images/kor/top/topMu_file.gif" /></a></li>
	<%}%>
	<li class="k_topMailMuS"><a href="javascript:goLeftAndRightDivRender('board.auth.do?method=board_main','게시판','bbs')"><img src="/images/kor/top/topMu_board.gif" /></a></li>
	<% 	if(ORGANIZE_IDX != -1 && UsersService.isValidModule(request,"intranet")){%>
	<li class="k_topMailMuS"><a href="javascript:goLeftAndRightDivRender('intranet.auth.do?method=organize_home&ORGANIZE_IDX=<%=ORGANIZE_IDX%>','인트라넷','intranet')"><img src="/images/kor/top/topMu_intranet.gif" /></a></li>
	<%}%>
	<%if(UsersService.isValidModule(request,"file")){ %>
	<li class="k_topMailMuS"><a href="javascript:callWebhard();"><img src="/images/kor/top/topMu_webhard.gif" /></a></li>
	<%}%>
	<% 	if(UsersService.isValidModule(request,"sms")){%>
	<li class="k_topMailMuS"><a href="javascript:goLeftAndRightDivRender('sms.auth.do?method=beforeSms','sms','sms')"><img src="/images/kor/top/topMu_sms.gif" /></a></li>
	<%}%>
	<li class="k_topMailMuS"><a href="javascript:goLeftAndRightDivRender('ecard.auth.do?method=card_list','카드','ecard')"><img src="/images/kor/top/topMu_card.gif" /></a></li>
	
	
	<%if(conf.getBoolean("com.nara.msg")){ %> 
	<li class="k_topMailMuS"><a href="javascript:messenger_init()"><img src="/images_std/kor/top/img_navi12.gif" /></a></li>
	<li class="k_topMailMuS"><a href="javascript:callKebiMessenger()"><img src="/images_std/kor/top/img_navi13.gif" /></a></li>
	<%}%>
	
	<li class="k_topMailMuS"><a href="javascript:goLeftAndRightDivRender('note.auth.do?method=showMain','쪽지','note')"><img src="/images/kor/top/topMu_note.gif" /></a></li>
	
	
	</ul>
</div>
<div class="k0_popBox" id="k_searchBox_header" style="width:585px;" >
<div class="k0_popBoxTop">
<img src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" />
<img src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" />
</div>
<div class="k0_popBoxCont">
<div class="k0_popBoxClose"><a href="#" onclick="k_searchBox_header.style.display='none';<%if(UsersService.isAlias(request)){ %>k_selectBox.style.visibility='visible'<%}%>"><img src="/images/kor/btn/btnD_bultClose.gif" /></a></div>
<div class="k0_pbPick">
     <select name="search_strIndex" style="width:100px;">
        <option value="0">전체편지함</option>
        <%=WebMailService.getMboxbySelectAll(request)%>
      </select>
      <span id="chebox_span1">
      <input type=checkbox name=M_TITLE value="M_TITLE" checked> 제목
      <input type=checkbox name=M_SENDER value="M_SENDER"> 보낸사람 주소
      <input type=checkbox name=M_SENDERNM value="M_SENDERNM"> 보낸사람 이름
      <input type=checkbox name=M_TO value="M_TO"> 받는사람 주소
      <input type=checkbox name=M_ATTACH_NAME value="M_ATTACH_NAME"> 첨부파일명 </span>

</div>
<div class="k0_pbSchBox" style="margin-top:0px">
<div class="k0_pbDate"><b>상세날짜지정 :</b>
   <div id="search_data_picker_start" style="width:100px;float:left"></div>
   <b>~</b>
   <div id="search_data_picker_end" style="width:100px;float:left"></div>
   <input name="search_strKeyword_div" type="text" onkeydown="javascript:if(event.keyCode == 13) { viewSearchDetailSubmit(); return false}" style="margin-top:1px;width:200px" />
   <a href="javascript:viewSearchDetailSubmit()"><img src="/images/kor/btn/btnB_search.gif" /></a> 
 </div>
</div>
</div>
<div class="k0_popBoxBtm">
<img src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" />
<img src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR" />
</div>
</div>
</form>