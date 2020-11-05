<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.jdf.db.entity.Pop3Entity"%>
<%@page import="com.nara.springframework.service.WebMailService"%>

<jsp:useBean id="pop_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="mboxlist" class="java.util.ArrayList" scope="request" />
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script language=javascript>
<!--
function chkSubmit(){
  var objForm=document.pop_form;
  if(objForm.POP_SERVER.value.length < 1){
    alert("서버명을 입력해 주십시오.");
    objForm.POP_SERVER.focus();
    return;
  }else if(objForm.POP_ID.value.length < 1){
    alert("ID를 입력해 주십시오.");
    objForm.POP_ID.focus();
    return;
  }else if(objForm.POP_PASSWD.value.length < 1){
    alert("비밀번호를 입력해 주십시오.");
    objForm.POP_PASSWD.focus();
    return;
  }else if(objForm.MBOX_IDX[objForm.MBOX_IDX.selectedIndex].value.length < 1){
    alert("저장될 편지함을 선택해 주십시오.");
    objForm.MBOX_IDX.focus();
    return;
  }else{
    if( updateOrInsert !="upt")
    	objForm.method.value= "pop3_insert";
    else
    	objForm.method.value= "pop3_update";
    
    updateOrInsert="";
    objForm.action="pop3.auth.do";
    objForm.submit();
  }
}

function selServer(value){
  objForm = document.pop_form;
  if(value == "NO"){
    alert("선택하신 서비스는 POP3를 지원하지 않는 서비스입니다.");
    return;
  }else if(value == "VAR"){
    alert("선택하신 서비스는 사용자마다 서버가 다릅니다.\n자신의 pop3서버를 확인하십시오.");
    return;
  }else if(value == "DPA"){
    alert("선택하신 서비스는 MS 의 DPA 인증방식을 사용하고 있습니다.\n이 인증방식은 MS 솔루션이 아니면 지원할 수 없는 방식입니다.");
    return;
  }else if(value == "NOTIONLY"){
    alert("해당 서비스 관리자에게 문의 하십시오.");
    return;
  }else{
	//지메일,한메일 포트는 995
	if (value == 'pop.gmail.com' || value == 'pop.hanmail.net' || value == 'pop3.live.com' || value == 'pop.naver.com') port = 995;
	else port="110";
	objForm.POP_PORT.value=port;
		
	objForm.POP_PROTOCOL[0].selected=true;
    objForm.POP_SERVER.value = value;
  }
}

function pop_delete(popIdx,obj){
	objForm = document.pop_form;
	var cfm= window.confirm("삭제 하시겠습니까");
	if(cfm){
		var queryString = "method=aj_pop_delete&POP_IDX=" + popIdx;
		
		Ext.Ajax.request({
				url: 'pop3.auth.do?method=aj_pop_delete',
				params: { POP_IDX: popIdx},
				success : function(response, options) {
					
				},
				failure : function(response, options) {
				
				},
				callback: function (options, success, response) {
					
				}
		});
		
	}
	
	var tableNode = obj.parentNode.parentNode.parentNode.parentNode;
	var currentNode = obj.parentNode.parentNode.parentNode;
	
	tableNode.removeChild(currentNode);	
	updateOrInsert="";
	objForm.reset();
}

var updateOrInsert ;
function pop_change(POP_IDX,
					POP_PROTOCOL,
					POP_SERVER,
					POP_ID,
					POP_PASSWD,
					MBOX_IDX,
					POP_ISDEL,
					POP_MBOX,
					POP_NAME,
					POP_ICON,
					POP_PORT){
	objForm = document.pop_form;
	objForm.POP_IDX.value = POP_IDX     ;
	
	if(POP_PROTOCOL=="pop3")
		objForm.POP_PROTOCOL.options[0].selected = true;
	else
		objForm.POP_PROTOCOL.options[1].selected = true;
	
	objForm.POP_SERVER.value = POP_SERVER  ;
	objForm.POP_ID.value = POP_ID      ;
	objForm.POP_PASSWD.value = POP_PASSWD  ;
	objForm.POP_NAME.value = POP_NAME    ;
	objForm.POP_PORT.value = POP_PORT    ;
	
	for( i=0; i< objForm.MBOX_IDX.length; i++){
		if(MBOX_IDX == objForm.MBOX_IDX.options[i].value){
			objForm.MBOX_IDX.options[i].selected = true;
		}
	}		
	
	objForm.MBOX_IDX.value = MBOX_IDX    ;
	
	if(POP_ISDEL=="N")	objForm.POP_ISDEL[0].checked = true;
	else				objForm.POP_ISDEL[1].checked = true;
	
	//if( POP_MBOX=="INBOX")	objForm.POP_MBOX[0].checked = true;
	//else 					objForm.POP_MBOX[1].checked = true;	
	
	POP_ICON = POP_ICON-1;
	try{eval("objForm.POP_ICON["+POP_ICON+"]").checked = true;}catch(e){}
	
	updateOrInsert ="upt";
}
-->
</script>
<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />
<link rel="stylesheet" type="text/css" href="/css_std/km5_std.css" />
<table class="h2">
	<tr>
		<td><img src="/images_std/kor/bullet/arrow_pop.gif" align="top" />외부메일확인</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:5px;">
	<tr>
		<td class="ttit_s_popup" style="border-bottom:1px dashed #DDD; padding-top:4px;">* 회원님의 다른 서비스 메일 계정에 수신된 메일들을 본 메일 계정에서 한 번에 볼 수 있습니다.<br />
		* '외부메일가져오기'를 클릭하시면 설정된 외부서버에서 편지를 가져옵니다.<br />
		* '외부메일설정'에서 외부메일 계정을 등록합니다.</td>
	</tr>
</table>
<table class="bl">
	<caption>메일목록</caption>
	<tr>
		<th width="30" scope="col">구분</th>
		<th width="250" scope="col">이름</th>
		<th width="122" scope="col">아이디</th>
		<th scope="col">저장메일함</th>
		<th width="80" scope="col">수정/삭제</th>
	</tr>

<%	
	if (pop_list != null) { 
		Iterator iterator = pop_list.iterator();
		if (!iterator.hasNext()) {
%>
	<tr>
		<td colspan="5" style="text-align:center; font-size:11px;">조회된 결과가 없습니다.</td>
	</tr>
<%		
		} else {		
			while(iterator.hasNext()) {
				Pop3Entity entity = null;
					try {
				    	entity = (Pop3Entity)iterator.next();
				    }catch(Exception e){
				    	out.println(com.nara.jdf.util.Utility.getStackTrace(e));
				        continue;
				    }
%>
	<tr>
		<td align=center><img src="/images/kor/ico/ico_pop3_0<%= entity.POP_ICON%>.gif" width="11" height="8" /></td>
		<td align=center><%= entity.POP_NAME%>(<%= entity.POP_SERVER%>)</td>
		<td align=center><%= entity.POP_ID%></td>
		<td align=center><%=WebMailService.getMboxName(mboxlist, entity.MBOX_IDX,request)%></td>
		<td align=center>
			<a href="javascript:pop_change('<%= entity.POP_IDX%>','<%= entity.POP_PROTOCOL%>','<%= entity.POP_SERVER%>','<%= entity.POP_ID%>','<%= entity.POP_PASSWD%>','<%= entity.MBOX_IDX%>','<%= entity.POP_ISDEL%>','<%= entity.POP_MBOX%>','<%= entity.POP_NAME%>','<%= entity.POP_ICON%>','<%= entity.POP_PORT%>')">수정</a> l<em>
            <a href="javascript:;" onClick="javascript:pop_delete('<%= entity.POP_IDX%>',this)">삭제</a></em>
        </td>
	</tr>
	
<%	
			}
		}
	}	
%>


</table>
<p style="padding:5px; text-align: right">
<a	href="pop3.auth.do?method=pop3_main"><img src="/images/kor/btn/popup_pop3.gif" /></a></p>
<div>
<form name="pop_form" method="post">
<input type="hidden" name="method" value=""> 
<input type="hidden" name="POP_IDX" value="">
<table class="k_tb_other" style="margin-bottom: 0px">
	<caption>외부메일 추가</caption>
	<tr>
		<th width="135" scope="row">표시이름</th>
		<td><input type="text" name="POP_NAME" style="width: 175px" /></td>
	</tr>
	<tr>
		<th scope="row">서버주소</th>
		<td><select onChange=selServer(this.value); name="hostsel" id="select" style="width: 178px">
			<option value="" selected>직접 입력
			<OPTION VALUE="pop.naver.com">네이버</option>
			<OPTION VALUE="pop3.nate.com">네이트</option>
			<option value="pop.dreamwiz.com">드림위즈</option>
			<option value="pop.mail.yahoo.co.kr">야후(co.kr)</option>			
			<option value="pop.mail.yahoo.com">야후(com)</option>
			<option value="pop.gmail.com">지메일</option>
			<option value="pop.paran.com">파란</option>
			<option value="pop.freechal.com">프리챌</option>
			<OPTION VALUE="pop.daum.net">다음/한메일</option>
			<OPTION VALUE="pop3.live.com">핫메일</option>
			<option value="email.kebi.com">깨비메일(유료)</option>
			<option value="pmail.unitel.co.kr">유니텔(유료)</option>
			<option value="pop.chol.com">천리안(유료)</option>
			<option value="pop.korea.com">korea.com(유료)</option>
		</select> 
		<input type="text" name="POP_SERVER" style="width: 175px; height: 14px" /></td>
	</tr>
	<tr>
		<th scope="row">아이디</th>
		<td><input type="text" name="POP_ID" style="width: 175px;ime-mode:inactive" /></td>
	</tr>
	<tr>
		<th scope="row">비밀번호</th>
		<td><input type="password" name="POP_PASSWD" style="width: 175px" />
		</td>
	</tr>
	<tr>
		<th scope="row">PROTOCOL</th>
		<td><select name="POP_PROTOCOL" id="select2" style="width: 178px">
			<option value='pop3'>POP3</option>
			<option value='imap'>IMAP</option>
		</select></td>
	</tr>
	<tr>
		<th scope="row">연결포트</th>
		<td><input type="text" name="POP_PORT" style="width: 175px" value="110"/></td>
	</tr>
	<tr>
		<th scope="row">저장할 메일함</th>
		<td>
		<select name="MBOX_IDX" id="select3" style="width: 155px">
			<%=WebMailService.getMboxbySelect(request)%>
		</select></td>
	</tr>
	<tr>
		<th scope="row">아이콘 선택</th>
		<td>
			<input type="radio" name="POP_ICON" value="1" checked /> <img src="/images/kor/ico/ico_pop3_01.gif" />&nbsp;&nbsp;&nbsp; 
			<input type="radio" name="POP_ICON" value="2" /> <img src="/images/kor/ico/ico_pop3_02.gif" />&nbsp;&nbsp;&nbsp; 
			<input type="radio" name="POP_ICON" value="3" /> <img src="/images/kor/ico/ico_pop3_03.gif" />&nbsp;&nbsp;&nbsp; 
			<input type="radio" name="POP_ICON" value="4" /> <img src="/images/kor/ico/ico_pop3_04.gif" />&nbsp;&nbsp;&nbsp; 
			<input type="radio" name="POP_ICON" value="5" /> <img src="/images/kor/ico/ico_pop3_05.gif" />
		</td>
	</tr>
	<tr>
		<th scope="row">메일 가져오기</th>
		<td>
			<label> <input type="radio" name="POP_MBOX"	value="INBOX" checked /> 새 메일</label> &nbsp;&nbsp;&nbsp; 
			<!--<label> <input type="radio" name="POP_MBOX" value="ALL" /> 모든 메일</label>-->
		</td>
	</tr>
	<tr>
		<th scope="row">서버에 원본 남기기</th>
		<td>
			<label> <input type="radio" name="POP_ISDEL" value="N" checked /> 예</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label> <input type="radio" name="POP_ISDEL" value="Y" /> 아니오</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>'아니오'를 선택할 경우 원 서비스 계정에서	메일이 삭제됩니다.</span>
		</td>
	</tr>
	<!--
	<tr>
    	<th scope="row">스팸 필터링 적용</th>
    	<td>
    		<label> <input type="radio" name="radio9" id="radio9" value="radio9" /> 예</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    <label> <input type="radio" name="radio10" id="radio10" value="radio10" /> 아니오&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
		    <span>필터 사용시 필터링 옵션에 지정된 폴더로 메일이 저장됩니다.</span>
		</td>
  	</tr>
  	-->
</table>
</form>
<p style="padding:5px; text-align: right"><a href="javascript:chkSubmit()"><img src="/images/kor/btn/popup_confirm.gif" /></a></p>
</div>