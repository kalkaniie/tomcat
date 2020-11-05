<%@ page contentType="text/html;charset=utf-8" %>
<script type="text/javascript" charset="utf-8" src="/js/tools/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/tools/ext-all.js"></script>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<script type="text/javascript" src="/js/common/common.js"></script>
<script language=javascript>
<!--
function searchUsersEmail(){
	var objForm = document.f;
	if(objForm.E_USERS_ID.value.length < 1 ) {
	    alert('아이디를 입력해 주십시오.');
	    objForm.E_USERS_ID.focus();    
	} else if(objForm.E_USERS_NAME.value.length < 1) {
		alert('이름을 입력해 주십시오.');
		objForm.E_USERS_NAME.focus();
	} else if(document.getElementsByName("E_GUBUN")[0].checked &&
			(objForm.E_USERS_JUMIN1.value.length < 1 || objForm.E_USERS_JUMIN2.value.length < 1)) {
	    alert('주민등록번호를 입력해 주십시오.');
	    objForm.E_USERS_JUMIN1.focus();
	    return;
	} else if(document.getElementsByName("E_GUBUN")[1].checked && objForm.E_PASSWD_HINT_ANSWER.value.length < 1) {
	    alert('비밀번호 찾기의 답변을 입력해 주십시오.');
	  	objForm.E_PASSWD_HINT_ANSWER.focus();
	  	return;
	} else {		
		Ext.Ajax.request({
			scope :this,
			url: '/mail/user.public.do?method=aj_searchEmailCellNo',
			method : 'POST',
			form:objForm,
			success : function(response, options) {
				try {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE','USERS_CELLNO','USERS_PREVEMAIL','USERS_PASSWD']);
			  		var resultXML = reader.read(response);

			  		if (resultXML.records[0].data.RESULT == "success") {
			  			
						if(resultXML.records[0].data.USERS_PREVEMAIL == "null") {
							document.getElementById("t_email").innerText = "";
							objForm.S_EMAIL.value = "";
						} else {
							document.getElementById("t_email").innerText = resultXML.records[0].data.USERS_PREVEMAIL;
							objForm.S_EMAIL.value = resultXML.records[0].data.USERS_PREVEMAIL;					
						}
						
						document.getElementById('div_send').style.display = "inline";
											
			  		} else {
			  			alert(resultXML.records[0].data.MESSAGE);
			  			document.getElementById('div_send').style.display = "none";
			  		}
				} catch(e) {
					return ;
				}	    		
	   		},
			failure : function(response, options) {
			}
		});		
	}
}

function setFocus(objname) {
	var obj = eval("document.f."+objname);
	obj.focus();
}

function sendSms() {
	var objForm=document.f;
	if(objForm.S_PHONE.value.length < 1) {
		alert('해당 서비스는 지원되지 않습니다.');
		objForm.E_USERS_ID.focus();
	} else {
		Ext.Ajax.request({
			scope :this,
			url: '/mail/user.public.do?method=aj_sendSms',
			method : 'POST',
			form:document.f,
			success : function(response, options) {
				try {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
	
			  		if (resultXML.records[0].data.RESULT == "success") {
						alert("전송되었습니다");
			  		} else {
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
}

function sendEmail() {
	var objForm=document.f;
	if(objForm.S_EMAIL.value.length < 1){
		alert('이메일주소가 없습니다. 관리자에게 문의하십시요\n ');
		return;
	}else{
		Ext.Ajax.request({
			scope :this,
			url: '/mail/user.public.do?method=aj_sendEmail',
			method : 'POST',
			form:document.f,
			success : function(response, options) {
				try {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
	
			  		if (resultXML.records[0].data.RESULT == "success") {
						alert("이메일이 전송되었습니다");
			  		} else {
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
}

function goPart(str) {
	if(str == "id") {
		location.href = "user.public.do?method=idfind";		
	} else {
		location.href = "user.public.do?method=showPasswdHint";
	}
}

function goChange(str) {
	var objForm=document.f;
	if(str == "jumin") {
		document.getElementById('div_jumin').style.display = "inline";
		document.getElementById('div_passwd_hint').style.display = "none";
		document.getElementById('div_send').style.display = "none";
		objForm.E_PASSWD_HINT_ANSWER.value = "";		
	} else {
		document.getElementById('div_jumin').style.display = "none";
		document.getElementById('div_passwd_hint').style.display = "inline";
		document.getElementById('div_send').style.display = "none";
		objForm.E_USERS_JUMIN1.value = "";
		objForm.E_USERS_JUMIN2.value = "";
	}
}
//-->
</script>
</head>
<form method=post name="f" method="post">
<input type=hidden name='USERS_IDX' value=''>
<input type=hidden name='S_EMAIL' value=''>
<input type=hidden name='S_PHONE' value=''>

<div class="k_joinUser">
  <img src="/images/kor/find/ipFind_tit.gif" border="0" usemap="#Map" />
  <map name="Map" id="Map"><area shape="rect" coords="117,31,178,49" href="user.public.do?method=show_provision" /></map>
  <div><img src="/images/kor/join/ipFind_img.gif" /></div>
  <div class="k_boxSp" style="width:800px">  	    	
    <div class="k_boxSpTop">
      <img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR"/>
    </div>
    <div class="k_boxSpCont">         
      <div class="k_boxSpCont_in" style="padding:12px 25px 20px 30px;">
        <a href="javascript:goPart('id');"><img src="/images/kor/find/btn_searchId_nomal.gif" border="0"/></a>
        <a href="javascript:goPart('pass');"><img src="/images/kor/find/btn_searchPw_over.gif" border="0"/></a>
        <br><br>
        <p class="k_juTxInfo">회원가입시 입력한 아이디와 이름, 주민번호를 입력해 주십시오.</p>
        <table class="k_tableSt7"  style="margin-bottom:-2px">
          <tr>
            <th width="119" scope="row"> 아이디</th>
            <td><input type="text" name="E_USERS_ID" value="" style="width:200px" class="k_inpColor4" /></td>
          </tr>
          <tr>
            <th scope="row"> 이름</th>
            <td>
              <input type="text" name="E_USERS_NAME" value="" id="textfield3" style="width:200px" class="k_inpColor4" /></td>
          </tr>
        </table>
        <table class="k_tableSt7" style="margin-bottom:-2px">
          <tr>
            <th scope="row" width="119"> 인증항목선택</th>
            <td>
              <input type="radio" name="E_GUBUN" id="E_GUBUN" value="jumin" onclick="javascript:goChange('jumin');" checked>주민등록번호&nbsp;&nbsp;
              <input type="radio" name="E_GUBUN" id="E_GUBUN" value="passwd_hint" onclick="javascript:goChange('passwd_hint');">질문&답변 
            </td>            
          </tr>
        </table>
        <div id="div_jumin" style="display:inline">
          <table class="k_tableSt7" style="margin-bottom:15px"> 
            <tr>
              <th scope="row" width="119"> 주민등록번호</th>
              <td>
                <input type="text" name="E_USERS_JUMIN1" value="" onKeyUp="changeFocus(6, this, E_USERS_JUMIN2)" onKeyDown="javascript:chkNum();" id="textfield2" maxlength="6" class="k_inpColor4" style="width:90px" /> - 
                <input type="password" name="E_USERS_JUMIN2" value="" onKeyDown="javascript:chkNum();" id="textfield2" maxlength="7" class="k_inpColor4" style="width:90px;ime-mode:inactive" />
              </td>
            </tr>          
          </table>
        </div>
        <div id="div_passwd_hint" style="display:none;">
	        <table class="k_tableSt7"  style="margin-bottom:15px">
	       	  <tr>
	          <th scope="row">비밀번호찾기</th>
	            <td>
	            	<select name="E_PASSWD_HINT_QUESTION" onChange="setFocus('E_PASSWD_HINT_ANSWER')" class="boxline01">
						<option value="0">- 질문을 선택해 주십시오 -
		                <option value="1"> 어릴 적 별명은?
		                <option value="2"> 본인이 태어난 곳은?
		                <option value="3"> 가고싶은 장소는?
		                <option value="4"> 즐겨부르는 노래는?
		                <option value="5"> 감명깊게 본 영화는?
		                <option value="6"> 아버지의 고향은 어디인가?
		                <option value="7"> 본인의 핸드폰 번호는?
		                <option value="8"> 어머니의 성함은?
		                <option value="9"> 좋아하는 색깔은?
		                <option value="10"> 가장 좋아하는 연예인은?
		                <option value="11"> 부모님이 좋아하는 음식은?
		                <option value="12"> 가장 기억에 남는 선생님은?
		                <option value="13"> 좋아하는 애완동물은?
					</select>
					&nbsp; 답변
					<input type="text" name="E_PASSWD_HINT_ANSWER" style="width:200px" class="k_inpColor4" value="" >
				</td>
			  </tr>		  
		    </table>	    	    
        </div>
          
        <div class="k_juButn">
          <a href="javascript:searchUsersEmail();"><img src="/images/kor/btn/btnJoin_confirm.gif" /></a>
          <a href="/"><img src="/images/kor/btn/btnJoin_cancel.gif" /></a>
        </div>
              
        <div id="div_send" style="display:none">
          <table class="k_tableSt7" style="margin-bottom:15px;margin-top:20px;">
            <tr>
              <th width="119" scope="row">이메일</th>
              <td id="t_email">&nbsp;</td><td></td>
            </tr>
          </table>
          <div class="k_juButn" align="center">
            <a href="javascript:sendEmail();"><img src="/images/kor/btn/btnJoin_sendEmail.gif" /></a>
          </div>
        </div>
        <br /><br /><br />
      </div>
    </div>
    <div class="k_boxSpBtm">
      <img src="/images/kor/box/boxSp_cornersBl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersBr.gif" class="k_fltR"/>
    </div>
  </div>
</div>
</form>