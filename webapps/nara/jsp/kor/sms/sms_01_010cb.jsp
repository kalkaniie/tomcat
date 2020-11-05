<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.nara.util.*"%>
<%@ page import="com.nara.jdf.db.entity.*"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<jsp:useBean id="scr_id" class="java.lang.String" scope="request" />
<jsp:useBean id="quota" class="java.lang.String" scope="request" />
<jsp:useBean id="users_idx" class="java.lang.String" scope="request" />
<jsp:useBean id="receive_phone" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_CELLNO" class="java.lang.String" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="msg_str" class="java.lang.String" scope="request" />
<jsp:useBean id="vec" class="java.util.Vector" scope="request" />
<jsp:useBean id="vec2" class="java.util.Vector" scope="request" />
<jsp:useBean id="phone_list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="sendPhone_list" class="java.util.ArrayList"
	scope="request" />
<% 
String uniqStr = new UniqueStringGenerator().getUniqueStringNonComma(); 
int msgLength = 80;
int quotaInt = 0;

try {
    quotaInt = Integer.parseInt(quota);
} catch(NumberFormatException nfe) {
}

String target="sms.auth.do";  
String textarea = null;

if(msg_str.equals(""))    textarea = "<메시지를 입력해주세요>";
else    textarea =msg_str;

String phone1 = null;
String phone2 = null;

UserEntity userEntity = UserSession.getUserInfo(request);

String[] arrayCellNo = {"",""};
userEntity.USERS_CELLNO = userEntity.USERS_CELLNO.replaceAll("-","");
if(userEntity.USERS_CELLNO.indexOf("-") != -1){
	try{
  		arrayCellNo = userEntity.USERS_CELLNO.split("-",2);
	}catch(Exception e){}
} else {
	if(userEntity.USERS_CELLNO.length() > 2){
		arrayCellNo[0] = userEntity.USERS_CELLNO.substring(0, 3);
		arrayCellNo[1] = userEntity.USERS_CELLNO.substring(3, userEntity.USERS_CELLNO.length());
	}
}

%>
<script type="text/javascript" src="/js/kor/sms/sms.js"></script>
<script language="javascript">
function js_addr_pop(){
    var link ="address.auth.do?method=address_list_pop_sms&objForm=sms_01_010";
    window.open(link ,"sms","status=no,toolbar=no,scrollbars=no,width=921,height=467");
}

function js_upload_pop(){
  var link = "sms.auth.do?method=sms_upload_form";
  window.open( link ,"sms","status=yes,toolbar=no,scrollbars=no,width=540,height=255");
}

function js_sel(){
    var val = document.sms_01_010.FLAG_NO[document.sms_01_010.FLAG_NO.selectedIndex].value;
    frames['iframe'].location.href="<%=target%>?method=sms_01_010if&FLAG_NO="+val;
}

function sendMsg(length){
	<%
    for(int tdx=0; tdx<list.size(); tdx++){
        SmsServerStateEntity state_item = (SmsServerStateEntity) list.get(tdx);
        if( state_item.level.equals("E")){
            out.println("alert('"+state_item.detail+"');");
            out.println("return");
            break;
        }
    }
	%>
    var obj = document.sms_01_010;
    if(obj.type[1].checked && !confirm("예약발송은 취소가 되지 않습니다.\n작성된 메시지의 정보가 정확합니까?")){
       return;
    }
    
    if(!useQuota())
        return;
    
    if(!returnChecklen(<%=msgLength%>) || !checkIntegrity())
        return;    
    
    obj.sendHp.value = makeHpNum(obj.sendPhoneCode, obj.sendPhone);
    receiveHpSelectedAll(obj.receiveHp, true);
    
    document.getElementById('smssend-loading').style.visibility='visible';
    Ext.Ajax.request({
		scope :this,
		url: 'sms.auth.do?method=aj_sendSms',
		method : 'POST',
		form: obj,
		success : function(response, options) {
    		var reader = new Ext.data.XmlReader({
    		   	record: 'RESPONSE'
    			}, 
    			['RESULT','MESSAGE','new_quota','total_quota','list','error_list','back_list','return_url']);
    		var resultXML = reader.read(response);
    		if (resultXML.records[0].data.RESULT == "success") {
    				mainPanel.body.load(
						{url: resultXML.records[0].data.return_url,
						params: {new_quota:resultXML.records[0].data.new_quota , 
								 total_quota:resultXML.records[0].data.total_quota ,
								 list:resultXML.records[0].data.list,
								 error_list:resultXML.records[0].data.error_list,
								 back_list:resultXML.records[0].data.back_list
						},scripts: true});
    		}else{
    			document.getElementById('smssend-loading').style.visibility='hidden';
    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
    			
    		}
		},
		failure : function(response, options) {callAjaxFailure(response, options);}
	});
}

function doBlink(){
    var blink = document.all.tags("BLINK")
    for (var i=0; i < blink.length; i++)
    blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""
}
function startBlink(){
    if (document.all)
        setInterval("doBlink()",600)
}


function js_reset(){
    for(var i=0; i<document.sms_01_010.receiveHp.options.length; i++) 
    {      
        document.sms_01_010.receiveHp.options[i] = null;      
    }    
    document.sms_01_010.reset();
    setSelectedIndexByValue( document.sms_01_010.sendPhoneCode, "<%=arrayCellNo[0]%>" );
}

function recentSelect(){
	recentAddReceiveHp(document.sms_01_010.recentPhone.value);
}

function hiddenDiv(showElement, hiddenElement) {
	  if(showElement == 'reservationDiv')
	       alert("예약전송은 취소가 되지 않습니다.\n 예약정보를 정확히 입력해주세요.!!");

	  document.getElementById(showElement).style.display = "";
	  document.getElementById(hiddenElement).style.display = "none";
}
function openSmsResult(){
  var link = "sms.auth.do?method=getSms_01_020";
  window.open( link ,"smsresult","status=no,toolbar=no,scrollbars=no,resizable=no,width=890,height=600");
}
</script>

<style type="text/css">
.smssend-loading {
	visibility: hidden;
	position: absolute;
	top: 300px;
	left: 300px;
	width: 200px;
	text-align: center;
	background-color: #eee;
	font-size: 11px;
	color: #000000;
}
</style>
<div id="smssend-loading" class="smssend-loading">
<div class="loading-indicator">SMS를 보내는 중입니다.</div>
</div>

<form method=post name=sms_01_010 action="<%=target%>?method=sendSms">
<input type=hidden name=formType value="short">
<input type=hidden name=sendHp value=''>
<input type=hidden name='FLAG_NO' value=''>
<input type=hidden name='nPage' value=''>

<table class="h1">
	<tr>
		<td class="tt">SMS</td>
		<td class="src"><input name="search_strKeyword_div" value="검색" type="text" /><a href="javascript:viewSearchDirect();"><img src="/images_std/kor/btn/btn_src.gif" alt="검색" align="top" /></a><a href="javascript:viewSearchDetail();"><img src="/images_std/kor/btn/btn_srcd.gif" alt="상세" align="top" /></a></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%" class="btn_bgtd">
      <a href="javascript:openSmsResult();"><img src="/images_std/kor/btn/btn_checkResult.gif" align="absmiddle" /></a>
    </td>
  </tr>
  </table>

<!-- <div class="k_gridA3"><a href="javascript:openSmsResult();"><img src="/images_std/kor/btn/btn_checkResult.gif" /></a></div> -->
<table class="k_tbSms">
	<tr>
		<th width="224">
		<div class="k_phone">
		<div class="k_phoneHead"><textarea class="k_phoneMsg" cols="16"
			name=toMessage onClick="selText();" onblur="outText();"
			onKeyUp="javascript:checklen(<%=msgLength%>);"
			onFocus="javascript:checklen(<%=msgLength%>);"><%=textarea%></textarea>
		<div class="k_phoneLimit"><input name="msglen" value=0 readOnly
			style="width: 14px"><input name="mglenLimit" value="/ 80"
			style="width: 24px">Bytes</div>
		<div class="k_phoneChar">l <a href="#"
			onClick="onoff('sms_character')" style="font-size:8pt;">특수문자입력</a>ㅣ
		<table id="sms_character" class="k_charPicker">
			<tr>
				<td><a href="javascript:addChar('☆');checklen(80);">☆</a></td>
				<td><a href="javascript:addChar('○');checklen(80);">○</a></td>
				<td><a href="javascript:addChar('□');checklen(80);">□</a></td>
				<td><a href="javascript:addChar('◎');checklen(80);">◎</a></td>
				<td><a href="javascript:addChar('★');checklen(80);">★</a></td>
				<td><a href="javascript:addChar('●');checklen(80);">●</a></td>
				<td><a href="javascript:addChar('■');checklen(80);">■</a></td>
			</tr>
			<tr>
				<td><a href="javascript:addChar('⊙');checklen(80);">⊙</a></td>
				<td><a href="javascript:addChar('☏');checklen(80);">☏</a></td>
				<td><a href="javascript:addChar('☎');checklen(80);">☎</a></td>
				<td><a href="javascript:addChar('◈');checklen(80);">◈</a></td>
				<td><a href="javascript:addChar('▣');checklen(80);">▣</a></td>
				<td><a href="javascript:addChar('◐');checklen(80);">◐</a></td>
				<td><a href="javascript:addChar('◑');checklen(80);">◑</a></td>
			</tr>
			<tr>
				<td><a href="javascript:addChar('☜');checklen(80);">☜</a></td>
				<td><a href="javascript:addChar('☞');checklen(80);">☞</a></td>
				<td><a href="javascript:addChar('◀');checklen(80);">◀</a></td>
				<td><a href="javascript:addChar('▶');checklen(80);">▶</a></td>
				<td><a href="javascript:addChar('▼');checklen(80);">▼</a></td>
				<td><a href="javascript:addChar('▲');checklen(80);">▲</a></td>
				<td><a href="javascript:addChar('♠');checklen(80);">♠</a></td>
			</tr>
			<tr>
				<td><a href="javascript:addChar('♣');checklen(80);">♣</a></td>
				<td><a href="javascript:addChar('♥');checklen(80);">♥</a></td>
				<td><a href="javascript:addChar('◆');checklen(80);">◆</a></td>
				<td><a href="javascript:addChar('◁');checklen(80);">◁</a></td>
				<td><a href="javascript:addChar('▷');checklen(80);">▷</a></td>
				<td><a href="javascript:addChar('△');checklen(80);">△</a></td>
				<td><a href="javascript:addChar('▽');checklen(80);">▽</a></td>
			</tr>
			<tr>
				<td><a href="javascript:addChar('♤');checklen(80);">♤</a></td>
				<td><a href="javascript:addChar('♧');checklen(80);">♧</a></td>
				<td><a href="javascript:addChar('♡');checklen(80);">♡</a></td>
				<td><a href="javascript:addChar('◇');checklen(80);">◇</a></td>
				<td><a href="javascript:addChar('※');checklen(80);">※</a></td>
				<td><a href="javascript:addChar('♨');checklen(80);">♨</a></td>
				<td><a href="javascript:addChar('♪');checklen(80);">♪</a></td>
			</tr>
			<tr>
				<td colspan="7" class="k_txAliC"><a href="#"
					onClick="offon('sms_character')">close</a></td>
			</tr>
		</table>
		</div>
		<div class="k_phoneCountA">전송가능메시지 : <input name="quota"
			value='<%=quotaInt%>' readOnly style="width:25px">건</div>
		</div>
		<div>
		<div class="k_phoneFormTo">받는사람 <select name='receivePhoneCode'
			style="width: 51px">
			<option value='010'>010</option>
			<option value='011'>011</option>
			<option value='016'>016</option>
			<option value='017'>017</option>
			<option value='018'>018</option>
			<option value='019'>019</option>
			<option value='0505'>0505</option>			
		</select> <input type="text" name="receivePhone" onKeyDown="chkNum()" onKeyUp="addDash(this)" style="width: 63px;"></div>
		<div class="k_phoneFunt" style="align: left"><a
			href="javascript:addReceiveHp();"><img
			src="/images/kor/btn/btnSms_add.gif" /></a> <a
			href="javascript:removeReceiveHp();"><img
			src="/images/kor/btn/btnSms_delete.gif" /></a> <a href="javascript:js_addr_pop()"><img src="/images/kor/btn/btnSms_address.gif" /></a>
    <!--<a href="#"><img src="/images/kor/btn/btnSms_lumpsum.gif" /></a>-->
    </div>
		<dl class="k_phoneCount">
			<dt>개인 :</dt>
			<dd class="k_section"><input name="receiveCount1" value=0 readOnly style="width:20px;">건</dd>
			<dt>그룹 :</dt>
			<dd><input name="receiveCount2" value=0 readOnly style="width:20px;">건</dd>
		</dl>
		<div class="k_phoneList">
			<select name="receiveHp" multiple
			style="width: 170px; height: 60px;">
				<%
                if(vec2.size() > 0)
                {
                    for(int zdx=0; zdx<vec2.size(); zdx++)
                    {
                    	com.nara.jdf.db.entity.TEMP_SMS_ADDRESS item1 = (com.nara.jdf.db.entity.TEMP_SMS_ADDRESS) vec2.elementAt(zdx);
                        out.println("<option value='"+item1.value+"'>"+item1.text+"</option>");
                    }
                }
            %>
			</select>
		</div>
		<div class="k_phoneFormFro">보내는사람 <select name='sendPhoneCode'
			style="width: 51px">
			<option value='010'>010</option>
			<option value='011'>011</option>
			<option value='016'>016</option>
			<option value='017'>017</option>
			<option value='018'>018</option>
			<option value='019'>019</option>
			<option value='0505'>0505</option>
		</select> <input type="text" name="sendPhone" onKeyDown="chkNum()" onKeyUp="addDash(this)" style="width:60px;" value="<%=arrayCellNo[1]%>"></div>
		<div class="k_phoneSend"><label for="sms_send01">
		<input	name="type" value="0" type="radio" checked id="sms_send01" onClick="hiddenDiv('directDiv<%=uniqStr%>','sms_date_div<%=uniqStr%>')">즉시발송</label>&nbsp;
		<label for="sms_send02"><input name="type" type="radio"	value="1" id="sms_send02" onClick="hiddenDiv('sms_date_div<%=uniqStr%>','directDiv<%=uniqStr%>')">예약발송</label>
		</div>
		<div class="k_phoneDate" id="sms_date_div<%=uniqStr%>">
		<script language="javascript">
       	   	Ext.DomHelper.append("sms_date_div<%=uniqStr%>",printDateBrTimeSelectSms("SMS_REQUEST_SEND_DATE"));
       	</script></div>
		<div class="k_phoneInfo" id="directDiv<%=uniqStr%>">예약발송을 클릭하시면 원하는 시간<br />
		에 SMS를 발송 할 수 있습니다.</div>
		</div>
		<div><a href="javascript:sendMsg(<%=msgLength%>);"><img
			src="/images/kor/sms/btnSmsImg_send.gif" /></a><a
			href="javascript:js_reset();"><img
			src="/images/kor/sms/btnSmsImg_reset.gif" /></a></div>
		</div>
		</th>
		<td><iframe width="100%" height="550" name="iframe" frameborder="no" src="sms.auth.do?method=sys_03_050if" scrolling="no"></iframe>
		</td>
	</tr>
</table>
</form>

<script language=javascript>
hiddenDiv('directDiv<%=uniqStr%>','sms_date_div<%=uniqStr%>');
setSelectedIndexByValue( document.sms_01_010.sendPhoneCode, "<%=arrayCellNo[0]%>" );
</script>