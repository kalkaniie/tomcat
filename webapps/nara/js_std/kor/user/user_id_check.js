function checkUserId(obj){
  var alpha="abcdefghijklmnopqrstuvwxyz";
  var num="1234567890";
  var ch="-_";
  var alphanum=alpha + num + ch;
  if(obj.value.length < 4 || obj.value.length > 20){
    alert("아이디는 4 ~ 20자의 영문소문자, 숫자, '_', '-' 만 가능합니다.");
    obj.focus();
    return false;
  }
  for (i=0; i< obj.value.length; i++){
    if (alphanum.indexOf(obj.value.substring(i,i+1))<0){
      alert("아이디는 4 ~ 20자의 영문소문자, 숫자, '_', '-' 만 가능합니다.");
      obj.focus();
      return false;
      break;
    }
  }
  return true;
} 
