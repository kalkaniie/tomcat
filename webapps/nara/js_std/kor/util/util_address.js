var addr = new Array();

var selectedIndex = 0;
var totalLineNum = 0;
var obj;
var token = "";

function Addr(email){
  this.email = email;
}

var eLayers = (document.layers) ? true : false;
var eAll    = (document.all)    ? true : false;

function checkKey(e) {
  if(eLayers) var keyValue = e.which;
  else if(eAll) var keyValue = event.keyCode;
  if(keyValue == 13){
    setAddress();
    return false;
  }else if( keyValue >= 37 && keyValue <= 40  ) {
    return false;
  }else{
    return checkKeyValue(keyValue);
  }
}

function checkKeyValue(keyValue) {
  // 문자와 숫자, backspace만 입력할때 return true
  if ( ((keyValue >= 33) && (keyValue <= 126 )) || keyValue == 8 ) {
    return true;
  }else {
    return false;
  }
}

function isValidToken(str){
  //[ , " '. @ < > ] 문자일 경우 return false
  var isValidKey = false;
  str = trimToken(str);
  if( str == ',' || str == '"' || str == "'" || str == '.' 
   || str == '@' || str == '<' || str == '>' ){
    isValidKey = false;
  }else{
    isValidKey = true;
  }
  return isValidKey;
}

function moveFocus(e){
  if(eLayers) var keyValue = e.which;
  else if(eAll) var keyValue = event.keyCode;
  if(keyValue == 38 && selectedIndex > 1){
    onFocus(selectedIndex-1);
  }else if(keyValue == 40 && selectedIndex < totalLineNum){
    onFocus(selectedIndex+1);
  }
}

function onFocus(index){
  selected_addr=document.getElementById("addr_"+selectedIndex);
  if(selected_addr != null){ 
    selected_addr.style.background="#FFFFFF";
    selected_addr.style.color="#666666";
  }
  selected_addr=document.getElementById("addr_"+index);
  if(selected_addr != null){
    selected_addr.style.background="#006699";
    selected_addr.style.color="#FFFFFF";
    selectedIndex = index;
  }
}

function setAddress(){
  if(selectedIndex > 0 && totalLineNum > 0){
    selected_addr=document.getElementById("addr_"+selectedIndex);
    if(selected_addr != null){
      obj.value = obj.value.substring(0,obj.value.lastIndexOf(',')+1);
      obj.value += translateToAddress(selected_addr.innerHTML)+',';
      resetAddress();
      obj.focus();
    }
  }
}

function searchAddress(obj, e){
  if(!checkKey(e))
    return false;
  showAddress(obj);
}

function showAddress(object){

  if(!isValidToken(object.value))
    return false;

  this.obj = object;
  this.token = object.value;
  
  try{
    token = token.substring(token.lastIndexOf(",")+1,token.length);
    token = trimToken(token);
    
   if( obj.value.length == 0 || token.length == 0){
      resetAddress();
      return false;
    }
    
    var str = "";
    var transAddr="";
    totalLineNum = 1;
    for(i=0; i < addr.length; i++){
      if(addr[i].email.indexOf(token) != -1){
      	transAddr = addr[i].email;
      	transAddr = transAddr.substring(0, transAddr.indexOf("<"))+" "+transAddr.substring(transAddr.indexOf("<"));
        var strEmail = translate(transAddr.replace(eval("/"+token+"/gi"),"<B>"+token+"</B>"));
        str += "<tr><td id='addr_"+totalLineNum+"' onMouseOver=onFocus("+totalLineNum+") onmousedown='setAddress();'>"+strEmail+"</td></tr>";
        totalLineNum++;
      }
    }
    totalLineNum--;
    if(totalLineNum > 0){
      var strAddress = "<table border=0 cellpadding=1 cellspacing=1 bgcolor=#999999><tr bgcolor=#ffffff><td>";
      strAddress += "<table border=0 cellpadding=1 cellspacing=1>"+str+"</table></td></tr></table>";
      printAddressBox(strAddress);
      onFocus(1);
    }else{
      resetAddress();
    }
  }catch(exception){}
}

function resetAddress(){
  printAddressBox("");
  selectedIndex = 0;
  totalLineNum = 0;
}

function printAddressBox(strAddress){
  document.getElementById("ADDRESS_BOX_"+obj.name).innerHTML = strAddress;
}

function translate(s){
  s = s.replace( /</gi, "&lt;");
  s = s.replace( />/gi, "&gt;");
  s = s.replace( /&lt;B&gt;/gi, "<B>");
  s = s.replace( /&lt;[/]B&gt;/gi, "</B>");
  return s;
}

function translateToAddress(s){
  s = s.replace( /&lt;/gi, "<");
  s = s.replace( /&gt;/gi, ">");
  s = s.replace( /<[/]?B>/gi, "");
  return s;
}

function trimToken(str){
  return str.replace(/(^\s+)|(\s+)$/,"");
}