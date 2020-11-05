function init(value){
  chmod(value);
}

function chmod(value){
  if(value == 'P'){
    document.all['comp'].innerHTML="사용자명";
    document.all['job'].innerHTML="직업";
    S_JOB.style.display="inline";
    S_CLASS.style.display="none";
  }else{
    document.all['comp'].innerHTML="회사";
    document.all['job'].innerHTML="업종";
    S_CLASS.style.display="inline";
    S_JOB.style.display="none";
  }  
}


function chkDomainValue(){
	
  var objForm=document.f;

  if(objForm.DOMAIN_TYPE[0].checked == false && objForm.DOMAIN_TYPE[1].checked == false){
    alert('가입구분을 선택해 주십시오');
  }else if(objForm.DOMAIN_NAME.value.length < 1){
    alert('회사명/학교명을 입력해 주십시오.');
    objForm.DOMAIN_NAME.focus(); 
  }else if(objForm.DOMAIN_ZIPCODE1.value.length < 1 || objForm.DOMAIN_ZIPCODE2.value.length < 1){
    alert('우편번호를 입력해 주십시오.');
    objForm.DOMAIN_ZIPCODE1.focus();   
  }else if(objForm.DOMAIN_ADDRESS1.value.length < 1){
    alert('주소를 입력해 주십시오.');
    objForm.DOMAIN_ADDRESS1.focus(); 
  }else if(objForm.DOMAIN_ADDRESS2.value.length < 1){
    alert('세부주소를 입력해 주십시오.');
    objForm.DOMAIN_ADDRESS2.focus();     
  }else if(objForm.DOMAIN_TEL1.value.length < 1 ){
    alert('지역번호를 입력해 주십시오.');
    objForm.DOMAIN_TEL1.focus();  
  }else if(objForm.DOMAIN_TEL2.value.length < 1 ){
    alert('국번을 입력해 주십시오.');
    objForm.DOMAIN_TEL2.focus();
  }else if(objForm.DOMAIN_TEL3.value.length < 1 ){
    alert('연락처를 입력해 주십시오.');
    objForm.DOMAIN_TEL3.focus();   
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
