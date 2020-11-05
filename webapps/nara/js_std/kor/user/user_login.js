function init(){
  var objForm = document.f;
  objForm.USERS_ID.focus();
}

function userLogin(){
  var objForm = document.f;
  if(objForm.DOMAIN.value.length < 1){
    alert("도메인명을 입력해 주십시오");
    objForm.DOMAIN.focus();
    return;
  }else if(objForm.USERS_ID.value.length < 1){
    alert("아이디를 입력해 주십시오");
    objForm.USERS_ID.focus();
    return;
  }else if(objForm.USERS_PASSWD.value.length < 1){
    alert("비밀번호를 입력해 주십시오");
    objForm.USERS_PASSWD.focus();
    return;
  }else{
    objForm.submit();
  }
    
}