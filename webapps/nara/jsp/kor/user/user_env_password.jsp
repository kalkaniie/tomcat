<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity" scope="request" />
<jsp:useBean id="userPassHintEntity" class="com.nara.jdf.db.entity.UserPassHintEntity" scope="request" />

<script language="javascript">
<!--
	function chkUserPass(){
	  	var objForm=document.user_pass;
	  	if(objForm.USERS_PASSWD[0].value.length < 1 ){
	    	alert('현재 사용중인 비밀번호를 입력해 주십시오.');
	    	objForm.USERS_PASSWD[0].focus();
	    	return;
	  	}else if(objForm.USERS_PASSWD[1].value.length < 6 || objForm.USERS_PASSWD[1].value.length > 20){
		    alert('비밀번호는 6~20자의 영문 대소문자, 숫자를 혼용하여 사용이 가능합니다.');
		    objForm.USERS_PASSWD[1].focus();
		    return;  
		}else if(objForm.USERS_PASSWD[2].value.length < 6 || objForm.USERS_PASSWD[1].value.length > 20 ){
		    alert('비밀번호는 6~20자의 영문 대소문자, 숫자를 혼용하여 사용이 가능합니다.');
		    objForm.USERS_PASSWD[2].focus();
		    return;
		//}else if(!(/[a-zA-Z]/.test(objForm.USERS_PASSWD[1].value)) ){
		//      alert('비밀번호는 영문 대소문자가 하나 이상 포함되어야 합니다.');
		//      objForm.USERS_PASSWD[0].focus();
		//}else if(!(/[0-9]/.test(objForm.USERS_PASSWD[1].value))){
		//      alert('비밀번호는 숫자가 하나 이상 포함되어야 합니다.');
		//      objForm.USERS_PASSWD[1].focus();
		}else if(isSpecialLetter(objForm.USERS_PASSWD[1].value)){
		    alert('비밀번호는 특수문자를 사용하실 수 없습니다.');
		    objForm.USERS_PASSWD[1].focus();
		    return;            
	  	}else if(objForm.USERS_PASSWD[1].value != objForm.USERS_PASSWD[2].value){
		    alert('입력하신 신규 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오');
		    objForm.USERS_PASSWD[2].focus();
		    return;
		}else if(getSelectedValue(objForm.PASSWD_HINT_QUESTION) == 0){
		    alert('비밀번호 찾기의 질문을 선택해 주십시오.');
		    objForm.PASSWD_HINT_QUESTION.focus();
		    return;
		}else if(objForm.PASSWD_HINT_ANSWER.value.length < 1){
		    alert('비밀번호 찾기의 답변을 입력해 주십시오.');
		    objForm.PASSWD_HINT_ANSWER.focus();
		    return;
	  	}else{
	  		Ext.Ajax.request({
	  			scope :this,
	  			url: 'userenv.auth.do?method=aj_password_chk',
	  			method : 'POST',
	  			params: { USERS_PASSWD: objForm.USERS_PASSWD[0].value},
	  			success : function(response, options) {
	  				var reader = new Ext.data.XmlReader({
	  	    		   	record: 'RESPONSE'
	  	    			}, 
	  	    			['CODE','MESSAGE']);
	  	    		var resultXML = reader.read(response);
	  	    		if (resultXML.records[0].data.CODE == "200") {
	  	    			Ext.Ajax.request({
		  		  			scope :this,
		  		  			url: 'userenv.auth.do?method=aj_change_password',
		  		  			method : 'POST',
		  		  			params: { 
	  	    					BEFORE_USERS_PASSWD: objForm.USERS_PASSWD[0].value,
	  	    					USERS_PASSWD: objForm.USERS_PASSWD[1].value,
	  	    					PASSWD_HINT_QUESTION: getSelectedValue(objForm.PASSWD_HINT_QUESTION),
	  	    					PASSWD_HINT_ANSWER: objForm.PASSWD_HINT_ANSWER.value
	  	    				},
		  		  			success : function(response, options) {
			  		  			var reader = new Ext.data.XmlReader({
				  	    		   	record: 'RESPONSE'
				  	    			}, 
				  	    			['RESULT','MESSAGE']);
				  	    		var resultXML = reader.read(response);
				  	    		if (resultXML.records[0].data.RESULT == "success") {
				  	    			alert("비밀번호가 변경 되었습니다.");
				  	    			location.reload();
				  	    		}else{
				  	    			alert(resultXML.records[0].data.MESSAGE);
				  	    		}
		  		  			},
		  		  			failure : function(response, options) {
		  		  				callAjaxFailure(response, options);
		  		  			}
		  		  		});
	  	    		}else{
	  	    			alert(resultXML.records[0].data.MESSAGE)
	  	    		}
	  				
	  				
	  			},
	  			failure : function(response, options) {
	  				callAjaxFailure(response, options);
	  			}
	  		});
	  		
	  	}
	}

	function setFocus(objname){
		var obj = eval("document.user_pass."+objname);
		obj.focus();
	}
//-->
</script>


<form method=post name="user_pass">
<input type=hidden name='method' value=''> 
<input type=hidden name='USERS_IDX'	value='<%=userEntity.USERS_IDX%>'> 
<input type=hidden name='USERS_ID' value='<%=userEntity.USERS_ID%>'>

<div class="k_puTit">
<h2>비밀번호 변경<span>사용자 비밀번호를 수정할 수 있습니다</span></h2>
</div>
<table class="k_tb_other" style="wdith: 500px">
  <tr>
	<th width="135" scope="row">아이디</th>
	<td><%=userEntity.USERS_ID%></td>
  </tr>
  <tr>
	<th width="135" scope="row">현재 비밀번호</th>
	<td><input type="password" name="USERS_PASSWD"	style="width: 150px;ime-mode:inactive" /></td>
  </tr>
  <tr>
	<th width="135" scope="row">새 비밀번호</th>
	<td><input type="password" name="USERS_PASSWD"	style="width: 150px;ime-mode:inactive" />
	<img src="/images/kor/bullet/bult_asterYe.gif"/><font color="#9100dc"> 6~20자의 영문 대소문자, 숫자 혼용 사용</font></td>
  </tr>
  <tr>
	<th width="135" scope="row">새 비밀번호 확인</th>
	<td><input type="password" name="USERS_PASSWD"	style="width: 150px;ime-mode:inactive" />
	<img src="/images/kor/bullet/bult_asterYe.gif"/><font color="#9100dc"> 6~20자의 영문 대소문자, 숫자 혼용 사용</font></td>
  </tr>
  <tr>
	<th width="135" scope="row">비밀번호 찾기</th>
    <td>
      <select name="PASSWD_HINT_QUESTION" id="select" style="width:200px" onChange="document.user_pass.PASSWD_HINT_ANSWER.focus();" tabindex="4">
        <option value="0">- 질문을 선택해 주십시오 -</option>
		<option value="1"> 어릴 적 별명은?</option>
        <option value="2"> 본인이 태어난 곳은?</option>
		<option value="3"> 가고싶은 장소는?</option>
		<option value="4"> 즐겨부르는 노래는?</option>
		<option value="5"> 감명깊게 본 영화는?</option>
		<option value="6"> 아버지의 고향은 어디인가?</option>
		<option value="7"> 본인의 핸드폰 번호는?</option>
		<option value="8"> 어머니의 성함은?</option>
		<option value="9"> 좋아하는 색깔은?</option>
		<option value="10"> 가장 좋아하는 연예인은?</option>
		<option value="11"> 부모님이 좋아하는 음식은?</option>
		<option value="12"> 가장 기억에 남는 선생님은?</option>
		<option value="13"> 좋아하는 애완동물은?</option>
      </select>
      &nbsp;&nbsp;&nbsp;답변 : <input type="text" name="PASSWD_HINT_ANSWER" style="width: 150px;ime-mode:active" />
    </td>
  </tr>
</table>
<p style="padding: 10px 5px 10px; text-align: right;">
  <a href="javascript:chkUserPass()"><img src="/images/kor/btn/popup_save2.gif" /></a>
</p>
</form>