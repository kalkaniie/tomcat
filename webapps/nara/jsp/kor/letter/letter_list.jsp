<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />

<% String strUrl = com.nara.springframework.service.DomainService.getHttpUrl(); %>

<script language=javascript>
function resetImage() {
  document.getElementById("strFileName").value="";
  window.letterImage.innerHTML = "";
  this.letterWindow.hide();
}

function previewLetter(strFileName) {
  document.getElementById("strFileName").value = strFileName;
  window.letterImage.innerHTML = "<img src='"+strFileName+"' width=198 height=198 border=0>";
}

function setLetter() {
  var openerObjForm ;
  if(mainPanel.getActiveTab().getEl().child("form").dom.name =="form_mail_write<%=uniqStr%>"){
	openerObjForm = mainPanel.getActiveTab().getEl().child("form").dom;
  }
  var letterImage = document.getElementById("strFileName").value;
  openerObjForm.letterPaper.value = "<%=strUrl%>"+letterImage;
  var letterbody = Ext.getCmp("editor_m_content<%=uniqStr%>").getEditorBody();
  var letterStyle = Ext.getCmp("editor_m_content<%=uniqStr%>").el.getStyles('font-size', 'font-family', 'background-image', 'background-repeat');
  letterStyle['background'] = 'url(' + letterImage + ')';
  Ext.DomHelper.applyStyles(letterbody, letterStyle);
  this.letterWindow.hide();
}
</script>
<input type=hidden name=strFileName value="">
<div class="k_popBox">
  <div class="k_popBoxTop">
    <img src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" />
    <img src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" />
  </div>
  <div class="k_popBoxCont">
    <table class="k_puLetter">
	  <tr>
		<td class="k_puLtr_images">
		  <div style="height: 280px; overflow-y: auto">
		    <ul style="width: auto">
<%
  if (list.size() == 0) {
%>
			  <li>조회된 결과가 없습니다.</li>
<%
  } else {
	String strFileName = "";
	Iterator iterator = list.iterator();
	int i=0;
	while(iterator.hasNext()) {
      strFileName = (String)iterator.next();
%>
			  <li>
			    <a href='javascript:onClick=previewLetter("/images/common/letter/<%=strFileName%>")'>
			    <img src="/images/common/letter/<%=strFileName%>" width=50 height=50 /></a>
			  </li>
<% 
    }
  }	
%>
		    </ul>
		  </div>
		</td>
		<td width="205" class="k_puLtr_imgVe">
		  <div id="letterImage"></div>
		</td>
	  </tr>
    </table>
  </div>
  <div class="k_popBoxBtm">
    <img src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" />
    <img src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR" style="margin: 0 0 -1px" />
  </div>
</div>
<div class="k_puBtn">
  <a href="javascript:setLetter();"><img src="/images/kor/btn/btnA_choice.gif" /></a> 
  <a href="javascript:resetImage();"><img src="/images/kor/btn/btnA_cancel.gif" /></a>
</div>