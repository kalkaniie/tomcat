﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿<%@page language="java" contentType="text/html;charset=utf-8"%>
<script language="JavaScript" src="/js/kor/menu/mbox_panel.js"></script>
<% 	
com.nara.jdf.Config conf = com.nara.jdf.Configuration.getInitial();
%>
<div class="k_sideBox"> 
	<div class="k_sideTopBox">
	  <div class="k_sideTop">
	  <a href="javascript:goRightDivRender('webmail.auth.do?method=mail_write','편지쓰기')"><img src="/images/kor/side/menu_write.gif" /></a>
	  <a href="javascript:goRightDivRender('webmailReConfirm.auth.do?method=confirm_list','수신확인')" ><img src="/images/kor/side/menu_receive.gif" /></a>
	  <a href="javascript:goLeftAndRightDivRender('address.auth.do?method=address_list','주소록','address')"><img src="/images/kor/side/menu_addr.gif" /></a>
	  </div>
	</div>
	<div class="k_sideMailMu">
	  <div class="k_sideMailMuTop"></div>
	  <div class="k_sideMailMuBott">
	    <ul>
	      <li class="k_mailMuF">
	        <img src="/images/kor/side/muMailBox_iconMailbox.gif" />
	        <a href="#" onclick="offon('ext_base_mbox_div')">편지함</a>
	        <div class="k_mailMuFBtn">
	        <a href="javascript:MM_openBrWindow('mbox.auth.do?method=manager_std','boxmanager','scrollbars=yes,width=800,height=460');"><img src="/images/kor/side/btnSide_mailBox.gif" /></a>
	        </div>
	      </li>
	    </ul>
	    <table border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td class="k_mailMuS">
	        <div id="ext_base_mbox_div"></div>
	        </td>
	      </tr>
	    </table>
	
	    <ul>
	      <li class="k_mailMuF1"><img src="/images/kor/side/muMailBox_iconMyletter.gif"/><a href="#" onclick="javascript:left_base_mbox.mbox.getMyBoxTree();">내 편지함</a>
	        <div class="k_mailMuF1Btn">
	        <a href="#" onclick="onoff('mlAdd_mb')"><img src="/images/kor/side/btnSide_add.gif" /></a>
	        </div>
	      </li>
	    </ul>
	    <table width="175" border="0" cellspacing="0" cellpadding="0" style="margin:0 0 0 7px">
	      <tr>
	        <td><div id="ext_mybox_mbox_div_parent"></div></td>
	      </tr>
	    </table>
	  </div>
	</div>
	<div class="k_muListBox">
		<div class="k_muListBoxTop"></div>
		<div class="k_muListBoxBott">
	    <ul>
	      <li class="k_muListBoxBottF">
	        <img src="/images/kor/side/muList_iconMailtome.gif" />
	        <a href="javascript:goLeftAndRightDivRender('webmail.auth.do?method=mail_list&VIEW_TYPE=me','내게쓴메일','mail');">내게 쓴 메일</a>
	      </li>
	      <li class="k_muListBoxBottF">
	        <img src="/images/kor/side/muList_Important.gif" />
	        <a href="javascript:goLeftAndRightDivRender('webmail.auth.do?method=mail_list&VIEW_TYPE=importance','중요메일','mail');">중요 메일</a>
	      </li>
	      <li class="k_muListBoxBottF">
	        <img src="/images/kor/index/ico_install.gif" />&nbsp;&nbsp;
	        <a href="javascript:goLeftAndRightDivRender('webmail.auth.do?method=mail_list&READ_MODE=NEW&VIEW_TYPE=new','안읽은메일','mail');">안읽은 메일</a>
	      </li>
	      <%--
	      <li class="k_muListBoxBottF">
	        <img src="/images/kor/side/muList_iconTag.gif" />
	        <a href="javascript:;" onclick="onoff('k_myTagList');left_base_mbox.mbox.leftTagInit();">태그별 목록</a>
	        <div class="k_muListBoxBottFBtn">
	        <a href="javascript:;" onclick="tagWinOpen();"><img src="/images/kor/side/btnSide_admin.gif" /></a>
	        </div>
	        <ol class="k_tagList" id="k_myTagList" style="display:none">
	        <div id="ext_left_tag_div"></div>
	       </ol>
	      </li>
	      --%>
	      <%if(conf.getBoolean("com.nara.realtime")){ %>
	      <li class="k_muListBoxBottF"><img src="/images/kor/side/ico_mailtoMe.gif" />&nbsp;&nbsp;
	      <a href="javascript:goLeftAndRightDivRender('webmail.auth.do?method=realTime_mail_write','실시간 대화요청','mail');">실시간 대화요청</A> 
	      </li>  
	      <%}%>  
	
	    </ul>
	  </div>
	</div>
</div>	  
<form method=post name='f_leftbase'>
<input type=hidden	name=method value=''>
<input type=hidden name=MBOX_IDX value=''>
</form>
<form method=post name="webmail_mbox_main_form">
<input type=hidden name='method' value='manager'> 
<input type=hidden name='MBOX_IDX' value=''> 
<input type=hidden name='MBOX_TYPE'	value=''> 
<input type=hidden name='MBOX_REF' value=''>
<input type=hidden name='MBOX_PUBLIC' value='P'>
<div class="k_sideAddBox" id="mlAdd_mb" style="display:none">
  <dl>
    <dt> 편지함이름 등록
      <a href="#" onclick="mlAdd_mb.style.display='none'">
        <img src="/images/kor/side/btnSide_X.gif" width="12" height="12" />
      </a>
    </dt>
    <dd>
      <input name="MBOX_NAME" type="text"  class="k_sideAddBoxInput" onkeydown="javascript:if(event.keyCode == 13) { mboxregist(); return false}"/>
      <a href="javascript:mboxregist();"><img src="/images/kor/side/btnSide_addAdd.gif" /></a>
    </dd>
  </dl>
</div>
</form>

<script language=javascript>
function mboxregist(){
  var objForm=document.webmail_mbox_main_form;
  if(objForm.MBOX_NAME.value.length < 1 ){
    alert("편지함명을 입력하십시오");
    objForm.MBOX_NAME.focus();
    return;
  }
  if(isSpecialLetter(objForm.MBOX_NAME.value)){
  	alert("편지함명은 한글 ,영문, 숫자만을 지원합니다.")
  	return;
  }	
  objForm.method.value = "regist";
  
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
  			leftMyMBoxReload();
  			objForm.MBOX_NAME.value="";
  			onoff('mlAdd_mb');
  		}else{
  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
  		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}
</script>