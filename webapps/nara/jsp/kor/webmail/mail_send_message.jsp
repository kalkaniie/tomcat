<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.springframework.service.DomainService"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>

<jsp:useBean id="rcpt" class="java.lang.String" scope="request" />
<jsp:useBean id="strAddress" class="java.lang.String" scope="request" />
<jsp:useBean id="strSelectGroup" class="java.lang.String" scope="request" />
<jsp:useBean id="M_TITLE" class="java.lang.String" scope="request" />
<jsp:useBean id="addressList" class="java.lang.String" scope="request" />
<jsp:useBean id="usersList" class="java.util.Vector" scope="request" />
<jsp:useBean id="sendType" class="java.lang.String" scope="request" />
<jsp:useBean id="M_SECURE_YN" class="java.lang.String" scope="request" />
<jsp:useBean id="M_SECURE_PW" class="java.lang.String" scope="request" />
<jsp:useBean id="ttttt" class="java.lang.String" scope="request" />
<%
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma();

UserEntity userEntity = UserSession.getUserInfo(request);

String[] arrayCellNo = {"",""};
userEntity.USERS_CELLNO = userEntity.USERS_CELLNO.replaceAll("-","");
if(userEntity.USERS_CELLNO.indexOf("-") != -1){
	try{
  		arrayCellNo = userEntity.USERS_CELLNO.split("-",2);
	}catch(Exception e){}
} else {
	userEntity.USERS_CELLNO = userEntity.USERS_CELLNO.trim();
	if(userEntity.USERS_CELLNO.length() > 2){
		arrayCellNo[0] = userEntity.USERS_CELLNO.substring(0, 3);
		arrayCellNo[1] = userEntity.USERS_CELLNO.substring(3, userEntity.USERS_CELLNO.length());
	}
}
%>

<link href="/css/km5.css"  rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js_std/kor/sms/sms_mailsendMessage.js?<%=uniqStr%>"></script>
<script language="javascript">
isMailSend = false;					// 메일 임시보관 여부

function newMailWrite<%=uniqStr%>() {
	if(mainPanel.getActiveTab().id=="docs-편지쓰기"){
		mainPanel.getActiveTab().body.load({url: "webmail.auth.do?method=mail_write",scripts: true});
	}else{
		goRightDivRender('webmail.auth.do?method=mail_write',mainPanel.getActiveTab().id.substring(5),'mainPanel');
	}
}
function newEcardWrite<%=uniqStr%>() {
	if(mainPanel.getActiveTab().id=="docs-카드"){
		mainPanel.getActiveTab().body.load({url: "ecard.auth.do?method=card_list",scripts: true});
	}else{
		goRightDivRender('ecard.auth.do?method=card_list','카드','mainPanel');
	}
}
function insertAddress<%=uniqStr%>(){
	var objForm = document.mail_send_message_form<%=uniqStr%>;
	Ext.Ajax.request({
		scope :this,
		url: 'address.auth.do?method=aj_registList',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
			alert("주소록에 저장 되었습니다");
		},
		failure : function(response, options) {
			callAjaxFailure(response, options);
		}
	});
}

function returnAddReceiveHp() {
	var obj = document.mail_send_message_form<%=uniqStr%>;
	
	if(!checkInputReceivePhone(obj)){return ;}
	
	var receiveHpNum = makeHpNum(obj.receivePhoneCode, obj.receivePhone);
	insertOption(obj.receiveHp, receiveHpNum, receiveHpNum);
	receiveHpSelectedAll(obj.receiveHp, false);
	setReceiveCount<%=uniqStr%>();
	resetReceivePhone<%=uniqStr%>();
}
</script>

<form name='mail_send_message_form<%=uniqStr%>' method=post	action='address.auth.do'>
<input type=hidden name=formType value="short"> 
<input type=hidden name="type" value="0">
<input type=hidden name=sendHp value=''>



  <div class="k_sendmail">
    <table class="k_tbSmsMs">
	  <tr>
		<td><img src="/images/kor/sms/img_sms.gif" /></td>
		<td width="273" style="padding: 49px 0 0">
		  <img src="/images/kor/sms/img_sendMailTx.gif" />
		  <div class="k_boxSt4">
		    <div class="k_boxSt4Top">
		      <img src="/images/kor/box/boxBc_cornersTl.gif" class="k_fltL" />
		      <img src="/images/kor/box/boxBc_cornersTr.gif" class="k_fltR" />
		    </div>
		    <div class="k_boxSt4Cont">
		      <span class="k_fotCol">아래 Email로 메일이 전송되었습니다.</span> 
		      <span> 
<%
	try{
    	javax.mail.internet.InternetAddress[] recipients 
        	= javax.mail.internet.InternetAddress.parseHeader(rcpt,false);
		for(int i=0; i<recipients.length ; i++){
        	try{
%> 
		        <%=(recipients[i].getPersonal() != null) ? recipients[i].getPersonal().replaceAll("'","&#039;").replaceAll("\"","&quot;") : "" %>
				&lt;<%=recipients[i].getAddress()%>&gt; 
<%  
			}catch(Exception e){
    			continue;
    		}
		}
	}catch(Exception e){
%> 
				<%=rcpt%> 
<%
	}
%> 
			  </span>
			</div>
		    <div class="k_boxSt4Btm">
		      <img src="/images/kor/box/boxBc_cornersBl.gif" class="k_fltL" />
		      <img src="/images/kor/box/boxBc_cornersBr.gif" class="k_fltR" />
		    </div>
		  </div>
<%
	javax.mail.internet.InternetAddress[] addrs = null;
    try{
    	addrs = javax.mail.internet.InternetAddress.parseHeader(strAddress,false);
        if(addrs.length>0){
%> 
<%}%> 
<%  
		for (int i=0; i<addrs.length ; i++) { 
%>
		  <div style="padding: 14px 0 0">
<%    	
			try{
%> 
			<input type=checkbox name='address' value='<%=addrs[i].getAddress()%>' checked> 
			<input type=text name='<%=addrs[i].getAddress()%>' class="k_inpColor" style="width: 60px" maxlength='40' value='<%=(addrs[i].getPersonal() != null) ? addrs[i].getPersonal().replaceAll("'","&#039;").replaceAll("\"","&quot;") : "" %>'>
		    &lt;<%=addrs[i].getAddress()%>&gt; 
<%    
			}catch(Exception e){
            	continue;
            }
%>
		  </div>
<%
		}
	}catch(Exception e){}
%>
		  <div style="padding: 5px 0 0 24px">
<% if(addrs.length>0){ %> 
			<select name='GROUP_IDX' style="width: 123px;">
			  <option value="0">그룹없음</option>
			  <%=strSelectGroup%>
			</select> 
			<a href="javascript:;" onClick="insertAddress<%=uniqStr%>()"><img src="/images/kor/btn/btnB_saveAddress.gif" /></a> 
<% } %>
		  </div>
		  <div style="padding: 20px 0 0 24px">
<% if(sendType.equals("") ){%> 
			<a href="javascript:newMailWrite<%=uniqStr%>()"><img src="/images/kor/btn/btnA_writeNew.gif" /></a> 
<% }else {%> 
			<a href="javascript:newEcardWrite<%=uniqStr%>()"><img src="/images/kor/btn/btnA_cardSendNew.gif" /></a> 
<% } %>
 		  </div>
		</td>
        <td style="padding-left: 20px">
<% if(DomainService.isValidModule(request,"sms")){ %> 
<script	language="javascript">
function js_addr_pop() {
    var link = "sms.auth.do?method=sms_01_011p";
    window.open(link ,"sms","status=no,toolbar=no,scrollbars=yes,width=500,height=520");
}

function js_upload_pop() {
	var link = "sms.auth.do?method=sms_upload_form";
	window.open( link ,"sms","status=yes,toolbar=no,scrollbars=no,width=540,height=255");
}

function useQuota<%=uniqStr%>() {
	var obj = document.mail_send_message_form<%=uniqStr%>;
	if(getMessageCount<%=uniqStr%>()*obj.receiveHp.length> obj.quota.value) {
	    alert("전송가능 메시지를 초과하였습니다.");
	    return false;
	}
	return true;
}

function checkIntegrity(objForm) {
	  if(checkMsgNull(objForm)) return false;
	  if(!checkSendPhone(objForm)) return false;
	  if(!isEmpty(objForm.receivePhone)) {
		 
		  if(!returnAddReceiveHp()) {
			
	      return false;
	    }
	  }
	  if(!checkReceivePhone(objForm)) return false;
	  return true;
}

function sendMsg<%=uniqStr%>(len) {
	//var objForm ;
	//if(mainPanel.getActiveTab().getEl().child("form").dom.name =="mail_send_message_form<%=uniqStr%>"){
	//	objForm = mainPanel.getActiveTab().getEl().child("form").dom;
	//}
	
	var objForm = document.mail_send_message_form<%=uniqStr%>;
	
    //if(!useQuota<%=uniqStr%>())
    //    return;
    if(!checklen2<%=uniqStr%>(80) || !checkIntegrity(objForm))
        return;
	objForm.sendHp.value = makeHpNum(objForm.sendPhoneCode, objForm.sendPhone);
    receiveHpSelectedAll(objForm.receiveHp, true);
    Ext.Ajax.request({
		scope :this,
		url: 'sms.auth.do?method=aj_sendSms',
		method : 'POST',
		form: objForm,
		success : function(response, options) {
			try {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','new_quota','MESSAGE']);
		  		var resultXML = reader.read(response);

		  		if (resultXML.records[0].data.RESULT == "success") {
		  			objForm.quota.value = resultXML.records[0].data.new_quota;
					alert("전송되었습니다");
		  		}  else {
		  			alert(resultXML.records[0].data.MESSAGE);
		  		}
			} catch(e) {
				return ;
			}	    		
   		},
		failure : function(response, options) {
		}
	});
}

function js_reset() {
    for(var i=0; i<document.mail_send_message_form<%=uniqStr%>.receiveHp.options.length; i++){      
        document.mail_send_message_form<%=uniqStr%>.receiveHp.options[i] = null;
    }    
    document.mail_send_message_form<%=uniqStr%>.reset();
    
    setSelectedIndexByValue( document.mail_send_message_form<%=uniqStr%>.sendPhoneCode, "<%=arrayCellNo[0]%>" );
}

function checklen<%=uniqStr%>(length) {
	var flag = true;
	var msgtext = document.mail_send_message_form<%=uniqStr%>.toMessage.value;
    var msglen = document.mail_send_message_form<%=uniqStr%>.msglen.value;
	var i=0,l=0;
	var temp,lastl;
	//길이를 구한다.
	while(i < msgtext.length)
	{
		temp = msgtext.charAt(i);
		if(escape(temp).length>4) {
			l+=2;
		} else if (temp!='\r') {
			l++;
		}
		if(l>length) {
			alert("일반 메시지 본문은 한글 " + (length/2) + "자, 영문 " + length +"자까지만 쓰실 수 있습니다.\n");
			temp = document.mail_send_message_form<%=uniqStr%>.toMessage.value.substr(0,i);
			document.mail_send_message_form<%=uniqStr%>.toMessage.value = temp;
			l = lastl;
			flag = false;
			document.mail_send_message_form<%=uniqStr%>.mglenLimit.value = '/ '+length;
			break;
			
		}

		lastl = l;
		i++;
	}
	
	document.mail_send_message_form<%=uniqStr%>.msglen.value=l;
	//return flag;
}

function checklen2<%=uniqStr%>(length) {
	var flag = true;
	var msgtext = document.mail_send_message_form<%=uniqStr%>.toMessage.value;
    var msglen = document.mail_send_message_form<%=uniqStr%>.msglen.value;
	var i=0,l=0;
	var temp,lastl;
	//길이를 구한다.
	while(i < msgtext.length)
	{
		temp = msgtext.charAt(i);
		if(escape(temp).length>4) {
			l+=2;
		} else if (temp!='\r') {
			l++;
		}
		if(l>length) {
			alert("일반 메시지 본문은 한글 " + (length/2) + "자, 영문 " + length +"자까지만 쓰실 수 있습니다.\n");
			temp = document.mail_send_message_form<%=uniqStr%>.toMessage.value.substr(0,i);
			document.mail_send_message_form<%=uniqStr%>.toMessage.value = temp;
			l = lastl;
			flag = false;
			document.mail_send_message_form<%=uniqStr%>.mglenLimit.value = '/ '+length;
			break;
			
		}

		lastl = l;
		i++;
	}
	
	document.mail_send_message_form<%=uniqStr%>.msglen.value=l;
	return flag;
}

function checkCount<%=uniqStr%>() {
	  document.mail_send_message_form<%=uniqStr%>.msgCount.value = getMessageCount<%=uniqStr%>();
}

function getMessageCount<%=uniqStr%>() {
	  var len = document.mail_send_message_form<%=uniqStr%>.msglen.value;
	  var count = Math.ceil(len/80);
	  return count;
}

function selText<%=uniqStr%>() {
  if(document.mail_send_message_form<%=uniqStr%>.toMessage.value == NEED_MSG) {
    document.mail_send_message_form<%=uniqStr%>.toMessage.value = ""
    document.mail_send_message_form<%=uniqStr%>.msglen.value = 0;
  }
}

function outText<%=uniqStr%>() {
  if(document.mail_send_message_form<%=uniqStr%>.toMessage.value == "") {
    document.mail_send_message_form<%=uniqStr%>.toMessage.value = NEED_MSG;
    document.mail_send_message_form<%=uniqStr%>.msglen.value = 0;
  }
}

function setReceiveCount<%=uniqStr%>() {
    var count1 = 0;
    var count2 = 0;
    for(idx=0; idx<document.mail_send_message_form<%=uniqStr%>.receiveHp.options.length; idx++){
        if(document.mail_send_message_form<%=uniqStr%>.receiveHp[idx].value.indexOf('@') != -1){
            count2 = parseInt(count2) + 1;
        }else{
            count1 = parseInt(count1) +1;    
        }
    }
    document.mail_send_message_form<%=uniqStr%>.receiveCount1.value = count1;
    document.mail_send_message_form<%=uniqStr%>.receiveCount2.value = count2;
}

function resetReceivePhone<%=uniqStr%>() {
	var obj1 = document.mail_send_message_form<%=uniqStr%>.receivePhoneCode;
	var obj2 = document.mail_send_message_form<%=uniqStr%>.receivePhone;
	obj2.value = "";
	obj2.focus();
}

function removeReceiveHp<%=uniqStr%>() {
	var objForm = document.mail_send_message_form<%=uniqStr%>;
	
	if(objForm.receiveHp.options.length==0) {
		alert("더이상 삭제할 폰번호가 없습니다.");
		return;
	}

	if(objForm.receiveHp.selectedIndex==-1) {
	   	alert("삭제할 폰번호를 선택하세요.");
	} else {
	   for(var i=0; i<objForm.receiveHp.options.length; i++) {
	     if(objForm.receiveHp.options[i].selected) {
	       objForm.receiveHp.options[i] = null;
	       --i;
	     }
	   }
	}
	setReceiveCount<%=uniqStr%>();
}

function addChar(ch) {
	var objForm = document.mail_send_message_form<%=uniqStr%>;
	selText<%=uniqStr%>();
	objForm.toMessage.value = objForm.toMessage.value + ch;
}
</script>

<%
    String INIT_MESSAGE="";
    if(M_TITLE == null || M_TITLE.length()==0){
        INIT_MESSAGE = "<메시지를 입력해주세요>";
    }else{
    	if(M_SECURE_YN.equals("true")){
        	INIT_MESSAGE = userEntity.USERS_NAME + "님께서 보내신 보안메일의 키입니다. " + M_SECURE_PW;
        }else{
        	INIT_MESSAGE = M_TITLE + ":" + userEntity.USERS_NAME + "님이 보낸 편지입니다.";
        }
    }
    if(INIT_MESSAGE.length() > 80)
        INIT_MESSAGE = com.nara.jdf.jsp.HtmlUtility.translate(com.nara.util.ChkValueUtil.cutString(INIT_MESSAGE,80));
%>
          <div class="k_phone">
		    <div class="k_phoneHead"><textarea name="toMessage"	onClick="selText<%=uniqStr%>();" onblur="outText<%=uniqStr%>();" onKeyUp="javascript:checklen2<%=uniqStr%>(80);"	onFocus="javascript:checklen<%=uniqStr%>(80);" cols="16" class="k_phoneMsg"><%=INIT_MESSAGE%></textarea>
		      <div class="k_phoneLimit"><input name="msglen" value=0 readOnly	style="width: 14px"><input name="mglenLimit" value="/ 80" style="width: 24px">Bytes</div>
		      <div class="k_phoneChar">l <a href="#" onclick="onoff('sms_character')" style="font-size:8pt;">특수문자입력</a>ㅣ	<table id="sms_character" class="k_charPicker">
			    <tr>
				  <td><a href="javascript:addChar('☆');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">☆</a></td>
				  <td><a href="javascript:addChar('○');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">○</a></td>
				  <td><a href="javascript:addChar('□');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">□</a></td>
				  <td><a href="javascript:addChar('◎');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">◎</a></td>
				  <td><a href="javascript:addChar('★');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">★</a></td>
				  <td><a href="javascript:addChar('●');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">●</a></td>
				  <td><a href="javascript:addChar('■');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">■</a></td>
			    </tr>
			    <tr>
				  <td><a href="javascript:addChar('⊙');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">⊙</a></td>
				  <td><a href="javascript:addChar('☏');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">☏</a></td>
				  <td><a href="javascript:addChar('☎');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">☎</a></td>
				  <td><a href="javascript:addChar('◈');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">◈</a></td>
				  <td><a href="javascript:addChar('▣');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">▣</a></td>
				  <td><a href="javascript:addChar('◐');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">◐</a></td>
				  <td><a href="javascript:addChar('◑');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">◑</a></td>
			    </tr>
			    <tr>
				  <td><a href="javascript:addChar('☜');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">☜</a></td>
				  <td><a href="javascript:addChar('☞');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">☞</a></td>
				  <td><a href="javascript:addChar('◀');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">◀</a></td>
				  <td><a href="javascript:addChar('▶');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">▶</a></td>
				  <td><a href="javascript:addChar('▼');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">▼</a></td>
				  <td><a href="javascript:addChar('▲');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">▲</a></td>
				  <td><a href="javascript:addChar('♠');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">♠</a></td>
			    </tr>
			    <tr>
				  <td><a href="javascript:addChar('♣');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">♣</a></td>
				  <td><a href="javascript:addChar('♥');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">♥</a></td>
				  <td><a href="javascript:addChar('◆');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">◆</a></td>
				  <td><a href="javascript:addChar('◁');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">◁</a></td>
				  <td><a href="javascript:addChar('▷');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">▷</a></td>
				  <td><a href="javascript:addChar('△');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">△</a></td>
				  <td><a href="javascript:addChar('▽');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">▽</a></td>
			    </tr>
			    <tr>
				  <td><a href="javascript:addChar('♤');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">♤</a></td>
				  <td><a href="javascript:addChar('♧');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">♧</a></td>
				  <td><a href="javascript:addChar('♡');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">♡</a></td>
				  <td><a href="javascript:addChar('◇');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">◇</a></td>
				  <td><a href="javascript:addChar('※');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">※</a></td>
				  <td><a href="javascript:addChar('♨');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">♨</a></td>
				  <td><a href="javascript:addChar('♪');checklen<%=uniqStr%>(80);" onClick="sms_character.style.display='none'">♪</a></td>
			    </tr>
		      </table>
		    </div>
		    <div class="k_phoneCountA">전송가능메시지 : <input name="quota" value='<%=userEntity.USERS_SMS_QUOTA%>' readOnly style="width: 25px"> 건</div>
		  </div>
		  <div>
		  <div id="hpListDivOne<%=uniqStr%>" class="k_phoneFormTo">받는사람 
		    <select name='receivePhoneCode' style="width: 51px">
			  <option value='010'>010</option>
			  <option value='011'>011</option>
			  <option value='016'>016</option>
			  <option value='017'>017</option>
			  <option value='018'>018</option>
			  <option value='019'>019</option>
			  <option value='0505'>0505</option>
			</select>
		  	<input type="text" name="receivePhone" onkeydown="chkNum()"	onkeyup="addDash(this)" style="width: 63px" />
		  </div>
  		    <div class="k_phoneFunt">
  		      <a href="javascript:returnAddReceiveHp();"><img src="/images/kor/btn/btnSms_add.gif" /></a> 
  		      <a href="javascript:removeReceiveHp<%=uniqStr%>();"><img src="/images/kor/btn/btnSms_delete.gif" /></a>
  		    </div>
		    <dl class="k_phoneCount">
			  <dt>개인 :</dt>
			  <dd class="k_section"><input name="receiveCount1" value=0	readOnly style="width:20px;">건</dd>
			  <dt>그룹 :</dt>
			  <dd><input name="receiveCount2" value=0 readOnly style="width:20px;">건</dd>
		    </dl>
		    <div class="k_phoneList"><select name="receiveHp" multiple style="overflow-y: auto; width: 170px; height: 62px;"></select></div>
		    <div class="k_phoneFormFro" id="hpListDivTwo<%=uniqStr%>">보내는사람
		      <select name='sendPhoneCode' style="width: 51px">
			    <option value='010'>010</option>
			    <option value='011'>011</option>
			    <option value='016'>016</option>
			    <option value='017'>017</option>
			    <option value='018'>018</option>
			    <option value='019'>019</option>
			    <option value='0505'>0505</option>
			  </select> 
		      <input type="text" name="sendPhone" onKeyDown="chkNum()" onKeyUp="addDash(this)" style="width:58px" value="<%=arrayCellNo[1]%>">
		    </div>
			<div class="k_phoneInfo2"></div>
			<div><a href="javascript:sendMsg<%=uniqStr%>(80);"><img src="/images/kor/sms/btnSmsImg_send2.gif" /></a></div>
		  </div>
<script language="javascript">
	document.mail_send_message_form<%=uniqStr%>.toMessage.focus();
<%
	String[] data = addressList.split(",");
	for(int i=0; i<data.length; i++) {
%>
	insertOption(document.mail_send_message_form<%=uniqStr%>.receiveHp, '<%=data[i]%>', '<%=data[i]%>');
	//receiveHpSelectedAll(document.mail_send_message_form<%=uniqStr%>.receiveHp, false);
<%
	}
%>
	setReceiveCount<%=uniqStr%>();
    resetReceivePhone<%=uniqStr%>();
</script> 
<% } %>
        </div>
	  </td>
	</tr>
  </table>
</div>
</form>
<script language="javascript">
	leftMBoxReload();
	//setTimeout('newMailWrite<%=uniqStr%>()', 3000);
	setSelectedIndexByValue( document.mail_send_message_form<%=uniqStr%>.sendPhoneCode, "<%=arrayCellNo[0]%>" );
</script>