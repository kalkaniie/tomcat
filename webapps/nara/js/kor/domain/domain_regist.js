function init(){
  var objForm = document.f;
  chmod('C');
  objForm.DOMAIN.focus();
}

function chkValidID(DOMAIN){
  var alpha="abcdefghijklmnopqrstuvwxyz";
  var num="1234567890";
  var ch=".-";
  var alphanum=alpha + num + ch;
  var rtn = 0;
 
  for (i=0; i< DOMAIN.length; i++){
    if (alphanum.indexOf(DOMAIN.substring(i,i+1))<0){
      rtn = -1;
      break;
    }
  }
  if(rtn ==0)
    return true;
  else return false;
}

function chmod(value){
  if(value == 'P'){
    document.all['comp'].innerHTML="&nbsp; <font color=#FF0000>*</font> 사용자명";
    document.all['job'].innerHTML="&nbsp; 직업";
    S_JOB.style.display="inline";
    S_CLASS.style.display="none";
  }else{
    document.all['comp'].innerHTML="&nbsp; <font color=#FF0000>*</font> 회사명";
    document.all['job'].innerHTML="&nbsp; 업종";
    S_CLASS.style.display="inline";
    S_JOB.style.display="none";
  }  
}


function chkDomainValue(){
	
  var objForm=document.f;
  if(objForm.DOMAIN.value.length < 1 ){
    alert('도메인명을 입력해 주십시오.');
    objForm.DOMAIN.focus();
  }else if(!chkValidID(objForm.DOMAIN.value)){
    alert('도메인명은 영소문자와 숫자 혹은 [ . - ]로 이루어져야 합니다.');
    objForm.DOMAIN.focus();
  }else if(!isValidDomain(objForm.DOMAIN.value)){
    alert('도메인명이 잘못 되었습니다.');
    objForm.DOMAIN.focus();
  }else if(objForm.DOMAIN.value.substr(0,4) == "www."){
    alert('\"www\"를  제외한 도메인 명을 입력해 주십시오.');
    objForm.DOMAIN.focus();
  }else if(objForm.DOMAIN_TYPE[0].checked == false && objForm.DOMAIN_TYPE[1].checked == false){
    alert('가입구분을 선택해 주십시오');
  }else if(objForm.DOMAIN_NAME.value.length < 1){
    alert('회사명/학교명을 입력해 주십시오.');
    objForm.DOMAIN_NAME.focus(); 
  }else{
    if(objForm.DOMAIN_TYPE[0].checked == true){
      objForm.DOMAIN_JOB.value=objForm.D_CLASS.options[objForm.D_CLASS.selectedIndex].value;
    }else if(objForm.DOMAIN_TYPE[1].checked == true){
      objForm.DOMAIN_JOB.value=objForm.D_JOB.options[objForm.D_JOB.selectedIndex].value;
    }
    objForm.DOMAIN_ZIPCODE.value=objForm.DOMAIN_ZIPCODE1.value+"-"+objForm.DOMAIN_ZIPCODE2.value;
    objForm.DOMAIN_TEL.value=objForm.DOMAIN_TEL1.value+"-"+objForm.DOMAIN_TEL2.value+"-"+objForm.DOMAIN_TEL3.value;
    objForm.submit();
  }
}
