<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<link rel="stylesheet" type="text/css" href="/css/km5_popup.css" />
<link rel="stylesheet" type="text/css" href="/css_std/km5_std.css" />
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<jsp:include page="/jsp/kor/util/activex_setup.jsp" flush="true"></jsp:include>

<%!
private void printMboxName(javax.servlet.jsp.JspWriter out, java.util.ArrayList list, int MBOX_IDX)
  throws java.io.IOException{
  for(int i=0; i<list.size(); i++) {
	  com.nara.jdf.db.entity.WebMailBoxEntity entity = (com.nara.jdf.db.entity.WebMailBoxEntity)list.get(i);
    if(entity.MBOX_REF == MBOX_IDX){
      boolean isExistSub = isExistSubTree(list, entity.MBOX_IDX);
      String strIndex = "mail_box_"+entity.MBOX_IDX;
      
      out.println("<div ID='mailbox_Table' class='k_mailbox_list'>");
      out.println("<img src='/images/kor/ico/ico_mail_"+entity.MBOX_TYPE+".gif'>");
      out.println("<span ID='mboxName_"+entity.MBOX_IDX+"'>"+com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(entity.MBOX_NAME,20))+"</span>");
            
      if(entity.MBOX_TYPE == 6)
      out.println("<a href='javascript:modifyMbox("+entity.MBOX_IDX+","+entity.MBOX_TYPE+",\""+entity.MBOX_NAME+"\");'><img src='/images/kor/ico/ico_mail_edit.gif' alt='편지함 이름수정'></a>");
      
      if(entity.MBOX_PUBLIC != null && entity.MBOX_PUBLIC.equals("S"))
    	  out.println("<img src='/images/kor/ico/ico_security.gif'>");
      
      out.println("</div>");
      
      
    	  
      if(isExistSub){
        out.println("<div id='"+strIndex+"' style='display: none; margin-left: 18px;'>");
        printMboxName(out, list, entity.MBOX_IDX);
        out.println("</div>");
      }
    }
  }
}
%>

<%!
private void printMboxInfo(javax.servlet.jsp.JspWriter out, java.util.ArrayList list, int MBOX_IDX)
  throws java.io.IOException{
  java.text.DecimalFormat df = new java.text.DecimalFormat("###.#");
  for(int i=0; i<list.size(); i++) {
	  com.nara.jdf.db.entity.WebMailBoxEntity entity = (com.nara.jdf.db.entity.WebMailBoxEntity)list.get(i);
    if(entity.MBOX_REF == MBOX_IDX){
      boolean isExistSub = isExistSubTree(list, entity.MBOX_IDX);
      String strIndex = "mail_box_"+entity.MBOX_IDX+"_info";
      if(i%2 ==0)
    	  out.println("<tr class='k_puMbContTr'>");
      else
    	  out.println("<tr>");
      out.println("<td class='k_txAliR'>");
      //out.println("<a href='javascript:goMailListReadOrNotRead(\"base\","+entity.MBOX_IDX+",\""+entity.MBOX_NAME+"\",\"mainPanel\",1)' style='color: #000000; font-size: 12px; font-weight: bold; text-decoration: none' onmouseover='this.style.color=\"#999999\"' onmouseout='this.style.color=\"#000000\"'>");
      
      if(entity.MBOX_NEW_MAILCOUNT > 0) out.print("<b>");
      
      out.print(entity.MBOX_NEW_MAILCOUNT);
      
      if(entity.MBOX_NEW_MAILCOUNT > 0)  out.print("</b>");
      
      //out.print("</a>");
      out.println("/"+entity.MBOX_MAILCOUNT+"개");		  
      out.println("</td>");
      
      
      if(entity.MBOX_SIZE < 1048576)
          out.println("<td class='k_txAliR'>"+df.format((double)entity.MBOX_SIZE/1024)+"KB&nbsp;&nbsp;&nbsp;&nbsp;</td>");
        else
          out.println("<td class='k_txAliR'>"+df.format((double)entity.MBOX_SIZE/1048576)+"MB&nbsp;&nbsp;&nbsp;&nbsp;</td>");
      
      out.println("<td><a href=javascript:removeAllMailInBox("+entity.MBOX_IDX+",'"+ entity.MBOX_PUBLIC+"');><img src='/images/kor/ico/ico_trash.gif' alt='편지함비우기' /></a></td>");
     
      /* 
      if( entity.MBOX_TYPE != 6 ) {
          out.println("<td></td>");
      } else {
          out.println("<td><a href=\"javascript:registMbox('"+entity.MBOX_IDX+"','"+entity.MBOX_NAME+"');\"><img src='/images/kor/ico/ico_createMb.gif' alt='새편지함만들기'/></a></td>");
      }
      */
      
      if(entity.MBOX_TYPE == 6 && !isExistSubTree(list, entity.MBOX_IDX)){
          out.println("<td><a href=javascript:removeMbox('"+entity.MBOX_IDX+"','"+entity.MBOX_TYPE+"','"+ entity.MBOX_PUBLIC+"');><img src='/images/kor/ico/ico_deleteMb.gif' border=0 alt='편지함삭제'/></a></td>");
      }else{
          out.println("<td></td>");
      }
      
     
      out.println("<td><a href=javascript:downloadMbox("+entity.MBOX_IDX+",'"+ entity.MBOX_PUBLIC+"');><img src='/images/kor/ico/ico_mailFile_import.gif' alt='편지함 내보내기'/></a></td>");
      //out.println("<td><a href=javascript:FileUpload('emlUpload','MAIL','"+entity.MBOX_IDX+"','mbox_manager_form');><img src='/images/kor/ico/ico_mailFile_export.gif' alt='편지(함) 가져오기'></a></td>");
      out.println("<td><a href=javascript:fileUpload("+entity.MBOX_IDX+",'"+ entity.MBOX_PUBLIC+"');><img src='/images/kor/ico/ico_mailFile_export.gif' alt='편지(함) 가져오기'></a></td>");
    
 
      out.println("<input type=hidden name='MBOX_"+entity.MBOX_IDX+"' value="+entity.MBOX_IDX+" />");
      out.println("</tr>");
      if(isExistSub){
        out.println("<div id='"+strIndex+"' style='display: none;'>");
        printMboxInfo(out, list, entity.MBOX_IDX);
        out.println("</div>");
      }
    }
  }
}
%>

<%!
private boolean isExistSubTree(java.util.ArrayList list, int MBOX_IDX){
  boolean isExist = false;
  for(int i=0; i<list.size(); i++) {
	  com.nara.jdf.db.entity.WebMailBoxEntity entity = (com.nara.jdf.db.entity.WebMailBoxEntity)list.get(i);
    if(entity.MBOX_REF == MBOX_IDX){
      isExist= true;
      break;
    }
  }
  return isExist;
}
%>


<script language=javascript>

function treeExpand() {
   divs=document.getElementsByTagName("DIV");
   for (i=0;i<divs.length;i++) {
	   if(divs[i].id.indexOf("mail_box_") != -1)
	   divs[i].style.display="block";
   }
}

function lineBackGround() {
   table=document.getElementsByTagName("TABLE");
   var nLineNum = 0;
   for (i=0;i<table.length;i++) {
     if(table(i).getAttribute("ID") == "mailbox_Table"){
       if(nLineNum%2 == 1)
         table(i).style.background="EDF3F5";
       nLineNum++;
     }
   }
   
   tr=document.getElementsByTagName("TR");
   nLineNum = 0;
   for (j=0;j<tr.length;j++) {
     if(tr(j).getAttribute("ID") == "mailinfoTr"){
       if(nLineNum%2 == 1)
         tr(j).style.background="EDF3F5";
       nLineNum++;
     }
   }
}
function regist(){
  var objForm=document.mbox_manager_form;
  if(objForm.MBOX_NAME.value.length < 1 ){
    alert("편지함명을 입력하십시오");
    objForm.MBOX_NAME.focus();
    return;
  }
  if(objForm.MBOX_NAME.value.length > 20)
	{
	   alert('편지함명의 길이는 20자 이하 입니다.');
	   return;
	}
  // alert(objForm.MBOX_PUBLIC[1].value)
 if(objForm.MBOX_PUBLIC[1].checked == true){
    
    if(objForm.MBOX_PASSWD.value.length < 1){
	    alert('편지함 패스워드를 입력하십시오');
    	objForm.MBOX_PASSWD.focus();
   	    return;
    }	
	if(objForm.MBOX_RE_PASSWD.value.length < 1){
	    alert('편지함 패스워드  확인을 입력하십시오');
    	objForm.MBOX_RE_PASSWD.focus();    	 
	    return;    	
    }	
	if(objForm.MBOX_PASSWD.value != objForm.MBOX_RE_PASSWD.value)
	{
	   alert('비밀번호와 비밀번호 확인이 다릅니다.');
	   return;
	}
  }
  
  objForm.method.value = "aj_regist";
  
  Ext.Ajax.request({
		scope :this,
		url: 'mbox.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
  		var reader = new Ext.data.XmlReader({
  		   	record: 'RESPONSE'
  			}, 
  			['RESULT','MESSAGE']);
  		var resultXML = reader.read(response);
  		if (resultXML.records[0].data.RESULT == "success") {
  			leftMBoxReload();
  			Ext.getCmp("kebi_ext_window").body.load({url: "mbox.auth.do?method=manager",scripts: true});
  		}else{
  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
  
  
}

  
function isSecurityBox(MBOX_IDX ,MBOX_PUBLIC ,MBOX_TYPE ,  func_name ){
  var objForm=document.mbox_manager_form;
  var MBOX_CERT = eval("objForm.MBOX_" + MBOX_IDX);
  
  if(MBOX_PUBLIC != null && MBOX_PUBLIC =='S' && MBOX_CERT.value != 'Y'){
  		SecurityBox(MBOX_IDX ,'securityMailBox' ,MBOX_TYPE ,  func_name );
  		return  false;
  	}
  else
  	return true;
}


function SecurityBox(mboxIdx , mboxName , mbox_type, func_name){
		/*
		newmboxWindowOpen('보안 편지함',300,125,'mbox.auth.do?method=webmail_idpwd','MBOX_IDX='+ mboxIdx  
				+ '&mboxName=' +mboxName
				+ '&func_name=' +func_name
				+ '&mboxgubun=M') ;
		*/
		var width = 300;
		var height = 125 ;
		sw = screen.availWidth/2;
		sh = screen.availHeight/2;
		
		pw = (sw- width);
		py = (sh - height);
		
		MM_openBrWindow('mbox.auth.do?method=webmail_idpwd_type2&MBOX_IDX='+ mboxIdx+ '&mboxName=' +mboxName+ '&func_name=' +func_name
				+ '&mboxgubun=M&MBOX_TYPE=' + mbox_type  ,'test11','left='+pw+',top=' +py +',scrollbars=yes,width=300,height=105') ;
		
		// MM_openBrWindow(link,'greetingsview','scrollbars=yes,width=540,height=470');
		
		return true;
}

function func_redirect(param  , MBOX_IDX  , MBOX_TYPE){
			
		    if(param == "removeAllMailInBox")
		 		removeAllMailInBox(MBOX_IDX , 'N')
		 	else if(param == "removeMbox"){
		 		removeMbox(MBOX_IDX,MBOX_TYPE, 'N');
		 		return false;
		 		}
		 	else if(param == "downloadMbox")
		 		downloadMbox(MBOX_IDX, 'N');
		 	else if(param == "fileUpload")
		 		fileUpload(MBOX_IDX, 'N');
				
		 		
}

function removeAllMailInBox(MBOX_IDX , MBOX_PUBLIC){
	if(isSecurityBox(MBOX_IDX ,MBOX_PUBLIC , '',  'removeAllMailInBox')){
    
	    objForm = document.mbox_manager_form;
	    var isRemove = confirm("편지함속의 모든 편지가 삭제됩니다.\n편지함을 삭제하시겠습니까?");    
	  	if(isRemove){
	    objForm.method.value = "aj_removeAllMailInMbox";
	    objForm.MBOX_IDX.value = MBOX_IDX;
	    objForm.action="mbox.auth.do";
	    Ext.Ajax.request({
			scope :this,
			url: 'mbox.auth.do',
			method : 'POST',
			form: objForm,
			success : function(response, options) {
			var reader = new Ext.data.XmlReader({
			   	record: 'RESPONSE'
				}, 
				['RESULT','MESSAGE']);
			var resultXML = reader.read(response);
			if (resultXML.records[0].data.RESULT == "success") {
				leftMBoxReload();
				Ext.getCmp("kebi_ext_window").body.load({url: "mbox.auth.do?method=manager",scripts: true});
			}else{
				Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
			}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	  }
  }

}

function removeMbox(MBOX_IDX,MBOX_TYPE, MBOX_PUBLIC){
if(isSecurityBox(MBOX_IDX ,MBOX_PUBLIC , MBOX_TYPE , 'removeMbox')){
    
  objForm = document.mbox_manager_form;
  var isRemove = confirm("편지함속의 모든 편지가 삭제됩니다.\n편지함을 삭제하시겠습니까?");    
  if(isRemove){
    objForm.method.value = "aj_remove";
    objForm.MBOX_IDX.value = MBOX_IDX;
    objForm.MBOX_TYPE.value = MBOX_TYPE;
    objForm.action="mbox.auth.do";
    Ext.Ajax.request({
		scope :this,
		url: 'mbox.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
		var reader = new Ext.data.XmlReader({
		   	record: 'RESPONSE'
			}, 
			['RESULT','MESSAGE']);
		var resultXML = reader.read(response);
		if (resultXML.records[0].data.RESULT == "success") {
			leftMBoxReload();
			Ext.getCmp("kebi_ext_window").body.load({url: "mbox.auth.do?method=manager",scripts: true});
		}else{
			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
  }
 } 
}

function downloadMbox(MBOX_IDX, MBOX_PUBLIC) { //v2.0
if(isSecurityBox(MBOX_IDX ,MBOX_PUBLIC , '', 'downloadMbox')){
  objForm = document.mbox_manager_form;
  objForm.method.value="download";
  objForm.MBOX_IDX.value = MBOX_IDX;
  objForm.action = "mbox.auth.do";
  // objForm.submit();
   objForm.submit();
  }
}
 function fileUpload(MBOX_IDX, MBOX_PUBLIC){
 if(isSecurityBox(MBOX_IDX ,MBOX_PUBLIC , '',  'fileUpload')){
  	FileUpload('emlUpload','MAIL',MBOX_IDX,'mbox_manager_form');
  	}
  }
      


var nMboxIdx = 0;
var strMboxName = "";

function modifyMbox(MBOX_IDX,MBOX_TYPE,MBOX_NAME){
  if(nMboxIdx != 0){
    var obj = eval("mboxName_"+nMboxIdx);
    obj.innerHTML = "<a href=webwebmail.auth.do?method=mail_list&MBOX_IDX="+nMboxIdx+">"+strMboxName+"</a>";
  }
  var obj = eval("mboxName_"+MBOX_IDX);
  var str = "<input type='text' name='MBOX_NAME_"+MBOX_IDX+"' value='"+MBOX_NAME+"' style='width:100px' maxlength=30 />" ;
  str += "<a href='javascript:onClick=modify("+MBOX_IDX+","+MBOX_TYPE+");' style='padding-left:5px'><img src='/images/kor/btn/popupSm_modify.gif'/></a>";
  obj.innerHTML = str;
  nMboxIdx = MBOX_IDX;
  strMboxName = MBOX_NAME;
}

function modify(MBOX_IDX,MBOX_TYPE){
  var objForm=document.mbox_manager_form;
  var objMbox = eval("document.mbox_manager_form.MBOX_NAME_"+MBOX_IDX);
  if(objMbox.value.length < 1 ){
    alert("편지함명을 입력하십시오");
    objMbox.focus();
    return;
  }
  document.mbox_manager_form.MBOX_IDX.value=MBOX_IDX;
  objForm.MBOX_NAME.value = objMbox.value;
  objForm.method.value = "aj_modify";
  document.mbox_manager_form.MBOX_TYPE.value=MBOX_TYPE;
  
  Ext.Ajax.request({
		scope :this,
		url: 'mbox.auth.do',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
		var reader = new Ext.data.XmlReader({
		   	record: 'RESPONSE'
			}, 
			['RESULT','MESSAGE']);
		var resultXML = reader.read(response);
		if (resultXML.records[0].data.RESULT == "success") {
			leftMBoxReload();
			objForm.method.value = "manager";
			Ext.getCmp("kebi_ext_window").body.load({url: "mbox.auth.do?method=manager",scripts: true});
		}else{
			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}

function registMbox(MBOX_IDX, PATH){
  
  document.mbox_manager_form.PATH.value=PATH;
  document.mbox_manager_form.MBOX_REF.value=MBOX_IDX;
  document.mbox_manager_form.MBOX_TYPE.value=6;
  document.mbox_manager_form.MBOX_NAME.focus();

}



function chmod(value){
  if(value == 'P'){
    document.getElementById('S_PASSWD').style.display="none";
    }else{
    document.getElementById('S_PASSWD').style.display="inline";
  }  
}

</script>
<form method=post name="test">

</form>
<form method=post name="mbox_manager_form">
<input type=hidden name='method' value='manager'>
<input type=hidden name='MBOX_IDX' value=''>
<input type=hidden name='MBOX_TYPE' value=''>
<input type=hidden name='MBOX_REF' value=''> 

<div class="k_popBox">
  <div class="k_puSearchBar">
    <img src="/images/kor/popup/popup_searchBar_left.gif" class="k_fltL"/>
    <img src="/images/kor/popup/popup_searchBar_right.gif" class="k_fltR"/>
    <span>
    <strong>새 편지함 만들기</strong>
    <INPUT type="text" name='PATH' value='편지함' maxlength=30 readonly class="k_puInput" style="width:96px">
    <input type="text"  name='MBOX_NAME' value='' maxlength=30 style="width:146px">
    <input type="radio"  name='MBOX_PUBLIC' value='P' checked onClick=chmod(this.value);>일반
    <input type="radio"  name='MBOX_PUBLIC' value='S' onClick=chmod(this.value);>보안
    <a href=javascript:regist();><img src="/images/kor/btn/btnB_create.gif" /></a>
    </span>
    
    <span id='S_PASSWD' style="display:none;width:340px">
     <div> <b>비밀번호 </b><INPUT type="password" name='MBOX_PASSWD' value='' maxlength=120  style="width:96px"></div>
     <div><b>비밀번호확인 </b><INPUT type="password" name='MBOX_RE_PASSWD' value='' maxlength=120   style="width:96px"></div>
    </span>
     
  </div>
  <table class="k_puMailBox">
    <tr>
      <td width="250" class="k_puMb">
      <div class="k_puMbTitL">
          편지함
        </div>
        <div class="k_puMbTree">
          <%printMboxName(out, list, 0);%>
        </div>
      </td>
      <td>
       <table class="k_puMbCont">
          <tr>
            <th width="80" class="k_txAliR" scope="col">새편지</th>
            <th width="80" class="k_txAliR" scope="col">용량</th>
            <th scope="col">비우기</th>
            <!-- <th width="70" scope="col">생성</th> -->
            <th width="70" scope="col">삭제</th>
            <th width="70" scope="col">내보내기</th>
            <th width="70" scope="col">가져오기</th>
          </tr>
          <%printMboxInfo(out, list, 0);%>       
      </table>
      </td>
    </tr>
  </table>
</div>
</form>
<script language=javascript>
treeExpand();
</script>