<%@ page contentType="text/html;charset=utf-8" %>
<jsp:useBean id="USERS_ID" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_PASSWD" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_NAME" class="java.lang.String" scope="request" />
<jsp:useBean id="USERS_LASTDATE" class="java.lang.String" scope="request" />
<script type="text/javascript" charset="utf-8" src="/js/tools/adapter/ext/ext-base.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/tools/ext-all.js"></script>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<script type="text/javascript" src="/js/common/common.js"></script>

<script language=javascript>
<!--
function searchUsersEmail(){
	var objForm = document.f;
		
	Ext.Ajax.request({
		scope :this,
		url: '/mail/user.public.do?method=permitUser',
		method : 'POST',
		form:objForm,
		success : function(response, options) {
			try {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT']);
		  		var resultXML = reader.read(response);

		  		if (resultXML.records[0].data.RESULT == "success") {
			  		alert('정상적으로 휴먼변경이 해지되었습니다.');
			  		location.href = "/mail/user.public.do?method=login_form";
		  		}  else {
		  			alert('휴먼변경이 해지가 실패하였습니다.');		  			
		  		}
			} catch(e) {
				return ;
			}	    		
	   	},
			failure : function(response, options) {
		}
	});		
	
}
//-->
</script>
</head>
<form method=post name="f" method="post">
<input type=hidden name='USERS_IDX' value='<%=USERS_IDX%>'>
<div class="k_joinUser">
  <img src="/images/kor/join/cancleAccount_tit.gif" border="0" usemap="#Map" />
  <map name="Map" id="Map"><area shape="rect" coords="117,31,178,49" href="https://webmail.nonghyup.com/jsp/kor/user/user_provision.jsp" /></map>
  <div><img src="/images/kor/join/ipFind_img.gif" /></div>
  <div class="k_boxSp" style="width:800px">  	    	
    <div class="k_boxSpTop">
      <img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL"/><img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR"/>
    </div>
    <div class="k_boxSpCont">         
      <div class="k_boxSpCont_in" style="padding:12px 25px 20px 30px;">
         <p class="k_juTxInfo"><b>휴면 상태를 해제하려면 확인 버튼을 눌러 주십시오.</b></p>
        <table class="k_tableSt7"  style="margin-bottom:15px">
          <tr>
            <td><%=USERS_NAME%>(<%=USERS_ID%>)님은 현재 휴면 상태 입니다. 최근 접속 시간은 <%=USERS_LASTDATE%> 입니다.<br></td>
          </tr>
        </table>
        <div class="k_juButn">
          <a href="javascript:searchUsersEmail();"><img src="/images/kor/btn/btnJoin_confirm.gif" /></a>
          <a href="/"><img src="/images/kor/btn/btnJoin_cancel.gif" /></a>
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