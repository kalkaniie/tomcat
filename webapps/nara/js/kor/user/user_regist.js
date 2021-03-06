function init(objForm){
  	objForm.USERS_ID.focus();
}

function chkValidID(USERS_ID){
  if(checkUserId(objForm.USERS_ID)){
    return true
  }else{
    return false;
  }
}

function chkDupID(objForm){
  if( objForm.DOMAIN.value == ""){
    alert("Domain 정보가 없습니다.");
    return;
  }
  
  if(checkUserId(objForm.USERS_ID)){
  	
   window.open("user.public.do?method=chkDupId&USERS_ID="+objForm.USERS_ID.value+
   "&DOMAIN="+objForm.DOMAIN.value,"idcheck","status=no,toolbar=no,scrollbars=no,width=350,height=137");
  }
}

function chkUserValue(objForm){
  if(objForm.USERS_ID.value.length < 1 ){
    alert('ID를 입력해 주십시오.');
    objForm.USERS_ID.focus();
  }
  if(checkUserId(objForm.USERS_ID)){
    if(objForm.USERS_PASSWD.value.length < 1 ){
      alert('비밀번호를 입력해 주십시오.');
      objForm.USERS_PASSWD.focus();
    }else if(objForm.USERS_PASSWD.value.length < 6 || objForm.USERS_PASSWD.value.length > 20){
      alert('비밀번호는 6~20자의 영문 대소문자, 숫자, 특수문자를 혼용하여 사용이 가능합니다.');
      objForm.USERS_PASSWD.focus();    
    }else if(objForm.USERS_PASSWD_RE.value.length < 1 ){
      alert('비밀번호 재확인을 입력해 주십시오.');
      objForm.USERS_PASSWD_RE.focus();
    //}else if(!(/[a-zA-Z]/.test(objForm.USERS_PASSWD.value))){
    //  alert('패스워드는 문자가 하나 이상 포함되어야 합니다.');
    //  objForm.USERS_PASSWD.focus();
    //}else if(!(/[0-9]/.test(objForm.USERS_PASSWD.value))){
    //  alert('패스워드는 숫자가 하나 이상 포함되어야 합니다.');
    //  objForm.USERS_PASSWD.focus();
    }else if(isSpecialLetter(objForm.USERS_PASSWD.value)){
      alert('비밀번호는 특수문자를 사용하실 수 없습니다.');
      objForm.USERS_PASSWD.focus();
    }else if(objForm.USERS_PASSWD.value != objForm.USERS_PASSWD_RE.value){
      alert('입력하신 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오');
      objForm.USERS_PASSWD.focus();
    }else if(getSelectedValue(objForm.PASSWD_HINT_QUESTION) ==0){
      alert('비밀번호 찾기의 질문을 선택해 주십시오.');
      objForm.PASSWD_HINT_QUESTION.focus();  
    }else if(objForm.PASSWD_HINT_ANSWER.value.length < 1){
      alert('비밀번호 찾기의 답변을 입력해 주십시오.');
      objForm.PASSWD_HINT_ANSWER.focus();
    }else if(objForm.USERS_NAME.value.length < 1 ){
      alert('이름을 입력해 주십시오.');
      objForm.USERS_NAME.focus();
    }else if(objForm.USERS_PREVEMAIL.value.length < 1 ){
      alert('연락가능한 E-mail을 입력해 주십시오.');
      objForm.USERS_PREVEMAIL.focus();
    }else if(!isValidEmail(objForm.USERS_PREVEMAIL.value)){
      alert('잘못된 이메일 형식입니다. 다시 확인해 주십시오.');
      objForm.USERS_PREVEMAIL.focus();
    }else if(objForm.USERS_JUMIN1.value.length>0 || objForm.USERS_JUMIN2.value.length>0){
      if(!check_num(objForm.USERS_JUMIN1.value+objForm.USERS_JUMIN2.value)){
        alert('주민번호가 유효하지 않습니다. 다시 확인해 주십시오.');
        objForm.USERS_JUMIN1.focus();
      }else{
      	objForm.USERS_ZIPCODE.value=objForm.USERS_ZIPCODE1.value+"-"+objForm.USERS_ZIPCODE2.value;
        objForm.USERS_TELNO.value=objForm.USERS_TELNO1.value+"-"+objForm.USERS_TELNO2.value+"-"+objForm.USERS_TELNO3.value;
        objForm.USERS_CELLNO.value=objForm.USERS_CELLNO1.value+"-"+objForm.USERS_CELLNO2.value+"-"+objForm.USERS_CELLNO3.value;
        objForm.USERS_BIRTH.value=objForm.USERS_BIRTH_YEAR.value+"-"+objForm.USERS_BIRTH_MONTH.value+"-"+objForm.USERS_BIRTH_DAY.value;
        
      	objForm.submit();
      }
    }else{
    	objForm.USERS_ZIPCODE.value=objForm.USERS_ZIPCODE1.value+"-"+objForm.USERS_ZIPCODE2.value;
        objForm.USERS_TELNO.value=objForm.USERS_TELNO1.value+"-"+objForm.USERS_TELNO2.value+"-"+objForm.USERS_TELNO3.value;
        objForm.USERS_CELLNO.value=objForm.USERS_CELLNO1.value+"-"+objForm.USERS_CELLNO2.value+"-"+objForm.USERS_CELLNO3.value;
        objForm.USERS_BIRTH.value=objForm.USERS_BIRTH_YEAR.value+"-"+objForm.USERS_BIRTH_MONTH.value+"-"+objForm.USERS_BIRTH_DAY.value;
        
    	objForm.submit();
    }
  }
}

function chkUserValueAdmin(objForm){
  if(objForm.USERS_ID.value.length < 1 ){
    alert('ID를 입력해 주십시오.');
    objForm.USERS_ID.focus();
  }
  if(checkUserId(objForm.USERS_ID)){
    if(objForm.USERS_PASSWD.value.length < 1 ){
      alert('비밀번호를 입력해 주십시오.');
      objForm.USERS_PASSWD.focus();
    }else if(objForm.USERS_PASSWD.value.length < 4 ){
      alert('비밀번호는 영문+숫자 조합으로 최소 4자 이상입니다.');
      objForm.USERS_PASSWD.focus();    
    }else if(objForm.USERS_PASSWD_RE.value.length < 1 ){
      alert('비밀번호 재확인을 입력해 주십시오.');
      objForm.USERS_PASSWD_RE.focus();
    }else if(objForm.USERS_PASSWD.value != objForm.USERS_PASSWD_RE.value){
      alert('입력하신 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오');
      objForm.USERS_PASSWD.focus();
    }else if(getSelectedValue(objForm.PASSWD_HINT_QUESTION) ==0){
      alert('비밀번호 찾기의 질문을 선택해 주십시오.');
      objForm.PASSWD_HINT_QUESTION.focus();  
    }else if(objForm.PASSWD_HINT_ANSWER.value.length < 1){
      alert('비밀번호 찾기의 답변을 입력해 주십시오.');
      objForm.PASSWD_HINT_ANSWER.focus();
    }else if(objForm.USERS_NAME.value.length < 1 ){
      alert('이름을 입력해 주십시오.');
      objForm.USERS_NAME.focus();
    }else if(objForm.USERS_JUMIN1.value.length>0 || objForm.USERS_JUMIN2.value.length>0){
      if(IsSSN(objForm.USERS_JUMIN1.value+objForm.USERS_JUMIN2.value)){
        alert('주민번호가 유효하지 않습니다. 다시 확인해 주십시오.');
        objForm.USERS_JUMIN1.focus();
      }else{
        objForm.USERS_ZIPCODE.value=objForm.USERS_ZIPCODE1.value+"-"+objForm.USERS_ZIPCODE2.value;
        objForm.USERS_CELLNO.value=objForm.USERS_CELLNO1.value+"-"+objForm.USERS_CELLNO2.value;
        objForm.USERS_BIRTH.value=objForm.USERS_BIRTH_YEAR.value+"-"+objForm.USERS_BIRTH_MONTH.value+"-"+objForm.USERS_BIRTH_DAY.value;
        objForm.submit();
      }
    }else{
      objForm.USERS_ZIPCODE.value=objForm.USERS_ZIPCODE1.value+"-"+objForm.USERS_ZIPCODE2.value;
      objForm.USERS_CELLNO.value=objForm.USERS_CELLNO1.value+"-"+objForm.USERS_CELLNO2.value;
      objForm.USERS_BIRTH.value=objForm.USERS_BIRTH_YEAR.value+"-"+objForm.USERS_BIRTH_MONTH.value+"-"+objForm.USERS_BIRTH_DAY.value;
      objForm.submit();
    }
  }
}

function setJuminFocus(objForm){
  if(objForm.USERS_JUMIN1.value.length ==6)
    objForm.USERS_JUMIN2.focus();
}

function setdateBirthday(objForm){	
  var strReg_1 = objForm.USERS_JUMIN1.value;
  var strReg_2= objForm.USERS_JUMIN2.value;
  strReg_1_len = strReg_1.length;
  strReg_2_len = strReg_2.length;
  
  if (strReg_1_len == 6 && strReg_2_len == 7) {
    strReg_year = strReg_1.substring(0,2);
    strReg_month = strReg_1.substring(2,4);
    strReg_day = strReg_1.substring(4,6);			
    strReg_key = strReg_2.substring(0,1);
			
    if (parseInt(strReg_key) == 3 || parseInt(strReg_key) == 4)
      strReg_head = "20";
    else
      strReg_head = "19";
    
    objForm.USERS_BIRTH_YEAR.value = strReg_head + strReg_year;
    objForm.USERS_BIRTH_MONTH.value = strReg_month;
    objForm.USERS_BIRTH_DAY.value = strReg_day;
  }	
}


function makeArray(n)
{
        this.length = n;
        for(var i=1; i<=n; i++)
                this[i] = 0;
        return this;
}

function CheckValidIDDate(id, str)
{
        var TodayYear, TodayMon, TodayDay;
        var idYear, idMon, idDay, cfDate;

        idDay = new makeArray(13);


        idDay = new makeArray(13);
        Today = new makeArray(13);

        for(var i = 0; i < 13; i++){
                idDay[i] = parseInt(id.charAt(i), 10);
        }
        for(i = 0; i < 8; i++){
                Today[i] = parseInt(str.charAt(i), 10);
        }

	if (idDay[6] == 1 || idDay[6] == 2)	
                idYear = (idDay[0]*10 + idDay[1]) + 1900;
	if (idDay[6] == 3 || idDay[6] == 4)	
                idYear = (idDay[0]*10 + idDay[1]) + 2000;

        TodayYear = Today[0]*1000 + Today[1]*100 + Today[2]*10 + Today[3];

        idMon = idDay[2]*10 + idDay[3];
        idDay = idDay[4]*10 + idDay[5];

        TodayMon = Today[4]*10 + Today[5];
        TodayDay = Today[6]*10 + Today[7];

        if (idYear > TodayYear){
                return false;
        } else if (idYear < TodayYear){
                return true;
	} else {                // 연도가 같은경우
                if (idMon > TodayMon){
                        return false;
                } else if (idMon < TodayMon){
                        return true;
                } else {                // 월이 같은 경우
                        if (idDay > TodayDay)
                                return false;
                        else
                                return true;
                }
        }
}

function IsSSN(value){
	var v1,v2,v3,v4,v5,v6,v7;
	var v8,v9,v10,v11,v12,v13;
	var v_sum, v_chk;
	var result = false;
	if(value.length == 13) {
		result = true;
		v1 = value.charAt(0);
		v2 = value.charAt(1);
		v3 = value.charAt(2);
		v4 = value.charAt(3);
		v5 = value.charAt(4);
		v6 = value.charAt(5);
		v7 = value.charAt(6);
		v8 = value.charAt(7);
		v9 = value.charAt(8);
		v10 = value.charAt(9);
		v11 = value.charAt(10);
		v12 = value.charAt(11);
		v13 = value.charAt(12);
 /*
 내국인 주민번호의 경우 7번째 자리가 1,2,3,4이며
 외국민 주민번호의 경우 7번째 자리가 5,6,7,8,9 이다.
 따라서 7번째 자리수를 체크해서 5,6,7,8,9인 경우 외국인 주민번호 확인 모듈(fgn_no_chksum(reg_no))를 이용하여 맞으면 true를 그렇지
 않으면 false를 리턴하여
 동시에 내국인, 외국인 주민번호를 확인하지 않도록 한다.
 */
		if ((v7 == '5')||(v7 == '6') || (v7 == '7') || (v7 == '8')|| (v7 == '9') ){
			return fgn_no_chksum(value);
		}
		v_sum = (parseInt(v1) * 2) + ( parseInt(v2) * 3) + ( parseInt(v3) * 4) + (parseInt(v4) * 5);
		v_sum = parseInt(v_sum) + ( parseInt(v5) * 6) + ( parseInt(v6) * 7) + ( parseInt(v7) * 8);
		v_sum = parseInt(v_sum) + ( parseInt(v8) * 9) + ( parseInt(v9) * 2) + (parseInt(v10) * 3);
		v_sum = v_sum + (parseInt(v11) * 4) + (parseInt(v12) * 5);
		v_chk = v_sum % 11;
		v_chk = 11 - v_chk;
		if(v_chk == 11){
			v_chk = 1
		} else if(v_chk == 10) {
			v_chk = 0;
		}
		if(v13 != v_chk) result = false;
	} else {
		result = false;
	}
	return result;
}

/*외국인 주민번호 체크*/
function fgn_no_chksum(reg_no) {
	var sum = 0;
	var odd = 0;
	buf = new Array(13);
	for (i = 0; i < 13; i++){
		buf[i] = parseInt(reg_no.charAt(i));
	}
    
	odd = buf[7]*10 + buf[8];
  	if (odd%2 != 0) {
  		return false;
  	}
  	if ((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9)) {
  		return false;
  	}
  	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
  	for (i = 0, sum = 0; i < 12; i++){
  		sum += (buf[i] *= multipliers[i]);
  	}
  	sum=11-(sum%11);
  	if (sum>=10){
  		sum-=10;
  	}
    
  	sum += 2;
  	if (sum>=10){
  		sum-=10;
  	}
    
  	if ( sum != buf[12]) {
  		return false;
  	} else {
  		return true;
  	}
}

function check_num(str)
{
        num = new makeArray(13);
        digit = new makeArray(12);

        digit[1] = 2
        digit[2] = 3
        digit[3] = 4
        digit[4] = 5
        digit[5] = 6
        digit[6] = 7
        digit[7] = 8
        digit[8] = 9
        digit[9] = 2
        digit[10] = 3
        digit[11] = 4
        digit[12] = 5

        //사람이 입력한 주민등록 번호를 배열에 넣는다
        for(var j=1; j<=13; j++)
        {
                num[j] = parseInt(str.charAt(j-1),10)
        }

        if (CheckValidIDDate(str, '19991001') == false)
                return false;

        // Y2K source start : 2000년이전 출생자의 주민등록 번호 입력을 위한 부분
        if (num[7] != 3 &&  num[7] != 4) {

        // Y2K source start : 2000년이전 출생자의 주민등록 번호 입력을 위한 부분
        if (num[7] != 3 &&  num[7] != 4) {
                sum = 0;
                //check_digit와 번호를 연산한다
                for(i=1; i<=12; i++)
                {
                        sum += digit[i] * num[i];
                }
                div = (sum%11);
                if(div == 1){
                        comp = 0;
                }
                else if(div == 0){
                        comp = 1;
                }
                else if((div != 0)&&(div != 1)){
                        comp = 11 - div;
                }

                if(div == 0)
                {
                        if(num[13] == 1)
                                return true;
                        else
                        {
                                return false;
                        }
                }
                else if(div == 1)
                {
                        if(num[13] == 0)
                                return true;
                        else
                        {
                                return false;
                        }
                }
                else if((11-div) == num[13])
                {
                        return true;
                }

                else
                {
                        {
                        return false;
                        }
                }
        }
        else {
        // 2000년 이후 출생자의 주민등록번호 체크 루틴
                if (num[3] != 0 && num[3] != 1) {
                        return false;
                }
                else if (num[5] != 0 && num[5] != 1 && num[5] != 2 && num[5] != 3) {
                        return false;
                }
                else if (num[7] != 1 && num[7] != 2 && num[7] != 3 && num[7] != 4) {
                        return false;
                }
                else if (num[3] == 0 && num[4] == 0) {
                        return false;
                }
                else if ((num[3] == 1) && (num[4] != 0 && num[4] != 1 && num[4] != 2)) {
                        return false;
                }
                else if (num[5] == 0 && num[6] == 0) {
                        return false;
                }
                else if (num[5] == 3 && (num[6] != 0 && num[6]  != 1)) {
                        return false;
                }
                else {
                        return true;
                }
        }
        // Y2K Source end
}
}

function selectOrganize(objForm){
  var DOMAIN = objForm.DOMAIN.value;
  if(DOMAIN == ""){
    alert("도메인 명을 입력하세요");
    return;
  }
  var link = "user.UserServ?cmd=selectOrganize&objForm=f&DOMAIN="+DOMAIN;
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=450");
 
}

function setFocus(objname){
  var obj = eval("document.f."+objname);
  obj.focus();
}
