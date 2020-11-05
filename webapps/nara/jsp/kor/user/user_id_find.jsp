<%@ page contentType="text/html;charset=utf-8" %>
<script type="text/javascript" charset="utf-8" src="/js/tools/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/tools/ext-all.js"></script>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<script type="text/javascript" src="/js/common/common.js"></script>
<script language=javascript>
<!--
function searchUsersEmail() {
	var objForm = document.f;
	
	if(objForm.E_USERS_NAME.value.length < 1) {
		alert('이름을 입력해 주십시오.');
		objForm.E_USERS_NAME.focus();
		return;
	} else if(document.getElementsByName("E_GUBUN")[0].checked &&
			(objForm.E_USERS_JUMIN1.value.length < 1 || objForm.E_USERS_JUMIN2.value.length < 1)) {
	    alert('주민등록번호를 입력해 주십시오.');
	    objForm.E_USERS_JUMIN1.focus();
	    return;
	} else if(document.getElementsByName("E_GUBUN")[1].checked && objForm.E_USERS_LICENCENUM.value.length < 1) {
	    alert('사번/학번을 입력해 주십시오.');
	    objForm.E_USERS_LICENCENUM.focus();
	    return;
	} else {		
		Ext.Ajax.request({
			scope :this,
			url: '/mail/user.public.do?method=idfind_result',
			method : 'POST',
			form:objForm,
			success : function(response, options) {
				try {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE','USERS_ID']);
			  		var resultXML = reader.read(response);
					if (resultXML.records[0].data.RESULT == "success") {
			  			
						if(resultXML.records[0].data.USERS_ID == "null") {
							document.getElementById("t_id").innerText = "";
						} else {
							document.getElementById("t_id").innerText = resultXML.records[0].data.USERS_ID;				
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
		document.getElementById('div_licence').style.display = "none";
		document.getElementById('div_send').style.display = "none";
		objForm.E_USERS_LICENCENUM.value = "";		
	} else {
		document.getElementById('div_jumin').style.display = "none";
		document.getElementById('div_licence').style.display = "inline";
		document.getElementById('div_send').style.display = "none";
		objForm.E_USERS_JUMIN1.value = "";
		objForm.E_USERS_JUMIN2.value = "";
	}
}
-->
</script>
</head>
<form method=post name="f" method="post">
<input type=hidden name='USERS_IDX' value=''>
<input type=hidden name='S_EMAIL' value=''>
<input type=hidden name='S_PHONE' value=''>

<div class="k_joinUser">
  <img src="/images/kor/find/ipFind_tit.gif" border="0" usemap="#Map" />
  <map name="Map" id="Map"><area shape="rect" coords="117,31,178,49" href="/mail/user.public.do?method=show_provision" /></map>
  <div><img src="/images/kor/join/ipFind_img.gif" /></div>
  <div class="k_boxSp" style="width:800px">  	    	
    <div class="k_boxSpTop">
      <img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR"/>
    </div>
    <div class="k_boxSpCont">         
      <div class="k_boxSpCont_in" style="padding:12px 25px 20px 30px;">
        <a href="javascript:goPart('id');"><img src="/images/kor/find/btn_searchId_over.gif" border="0"/></a>
        <a href="javascript:goPart('pass');"><img src="/images/kor/find/btn_searchPw_nomal.gif" border="0"/></a>
        <br /><br />
        <p class="k_juTxInfo">이름과 주민등록번호 또는 사번/학번을 입력해 주십시오.</p>
        <table class="k_tableSt7" style="margin-bottom:-2px">
          <tr>
            <th scope="row" width="119"> 이름</th>
            <td>
              <input type="text" name="E_USERS_NAME" value="" style="width:200px" class="k_inpColor4" />
            </td>            
          </tr>
        </table>
        <table class="k_tableSt7" style="margin-bottom:-2px">
          <tr>
            <th scope="row" width="119"> 인증항목선택</th>
            <td>
              <input type="radio" name="E_GUBUN" id="E_GUBUN" value="jumin" onclick="javascript:goChange('jumin');" checked>주민등록번호&nbsp;&nbsp;
              <input type="radio" name="E_GUBUN" id="E_GUBUN" value="licence" onclick="javascript:goChange('licence');">사번/학번 
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
        <div id="div_licence" style="display:none">
          <table class="k_tableSt7"  style="margin-bottom:15px">
            <tr>
              <th scope="row" width="119"> 사번/학번</th>
              <td>
                <input type="text" name="E_USERS_LICENCENUM" value="" style="width:200px" class="k_inpColor4" /></td>
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
              <th width="119" scope="row">아이디</th>
              <td id="t_id">&nbsp;</td><td></td>
            </tr>
          </table>
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