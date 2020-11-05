/** 
 * SMS 전송요청 JavaScript. 
 *
 * author : hojoongkim , hojoongkim@kebi.com
 * date   : 2003. 01.  
 * Copyright 1995-2003 by  NARAVISION.CO All rights reserved. 
 * 
 */


/**
 * 상수 모음
 */
var NEED_MSG = "<메시지를 입력해주세요>";
var PHONE_CODE = ['011', '016', '017', '018', '019', '010'];
var PHONE_CODE_ALL = ['011', '016', '017', '018', '019', '010', '02', '031', '032',
        '033', '041', '042', '043', '051', '052', '053', '054', '055', '061',
        '062', '063', '064', '080', '0510', '0502', '0505', '0130', '1510'];


/**
 * 휴대폰, 유선전화지역번호 <select>..</select> Tag 만들기.
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printPhoneCode(selectName, css) {
  document.writeln(makePhoneCode(selectName, PHONE_CODE, css));
}


/**
 * 휴대폰, 유선전화지역번호 <select>..</select> Tag 만들기.
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printPhoneCodeAll(selectName, css) {
  document.writeln(makePhoneCode(selectName, PHONE_CODE_ALL, css));
}


/**
 * 폰코드를 <select> tag로 변환하여 반환.
 */
function makePhoneCode(selectName, phoneCode, css) {
  var html = "";
  if(selectName!=null) {
    html = '<select name=' + selectName + ' class='+css+'>';
 
    for(var i=0; i<phoneCode.length; i++) {
      html += "<option value='" + phoneCode[i] +"'>" + phoneCode[i] + "</option>\n";
    }
     html += '</select>';
  } else {
    alert('폰코드 입력 필드명이 빠졌습니다.\n소스를 확인하십시오.');
  }

  return html;
}


/**
 * SMS보내는사람전화번호를 입력한다.
 */
function setSendHp(userSendHp) {
  if(userSendHp==null) {
    return;
  }

  userSendHp = removeDash(userSendHp);

  if(userSendHp.length<9||userSendHp.length>12) {
    return;
  }

  var phoneCode = userSendHp.substring(0, 3);
  var phoneNum = userSendHp.substr(3, 8);

  setSelectedIndexByValue(document.sms_01_010.sendPhoneCode, phoneCode);
  document.sms_01_010.sendPhone.value = phoneNum;

  addDash(document.sms_01_010.sendPhone);
}

/**
 * SMS 받는 사람 전화번호를 입력한다.
 */
function setReceiveHp(userSendHp) {
  if(userSendHp==null) {
    return;
  }

  userSendHp = removeDash(userSendHp);

  if(userSendHp.length<9||userSendHp.length>12) {
    return;
  }

  var phoneCode = userSendHp.substring(0, 3);
  var phoneNum = userSendHp.substr(3);

  setSelectedIndexByValue(document.sms_01_010.receivePhoneCode, phoneCode);
  document.sms_01_010.receivePhone.value = phoneNum;

  addDash(document.sms_01_010.receivePhone);
}

/**
 * SMS전송입력값(전체)을 초기화한다.
 */
function resetAll() {
  firstCur();

  document.sms_01_010.msglen.value = 0;
//  inputCurDate();
//  setCheckedRadioByValue( document.sms_01_010.type, "0" );
//  hiddenDiv('directDiv', 'reservationDiv');
  resetReceivePhone();
  document.sms_01_010.receiveHp.options.length = null;
  setReceiveCount();

  if(document.sms_01_010.formType.value=="long") {
    checkCount();
  }
}


/**
 * 받는사람입력값을 초기화한다.
 */
function resetReceivePhone() {
  var obj1 = document.sms_01_010.receivePhoneCode;
  var obj2 = document.sms_01_010.receivePhone;

//  obj1.selectedIndex = 0;
  obj2.value = "";
  obj2.focus();
}


/**
 * f.toMessage를 초기화한다.
 */
function firstCur() {
  document.sms_01_010.toMessage.value = NEED_MSG;
}


/**
 * f.toMessage가 초기화상태이면 내용을 지운다.
 */
function selText()
{
  if(document.sms_01_010.toMessage.value == NEED_MSG) {
    document.sms_01_010.toMessage.value = ""
    document.sms_01_010.msglen.value = 0;
  }
}


/**
 * f.toMessage에 내용이 없으면 내용을 초기화한다.
 */
function outText()
{
  if(document.sms_01_010.toMessage.value == "") {
    document.sms_01_010.toMessage.value = NEED_MSG;
    document.sms_01_010.msglen.value = 0;
  }
}


/**
 * 선택된 문자를 f.toMessage에 추가한다.
 * @param f.toMessage에 추가할 character
 */
function addChar(ch) {
  selText();
  document.sms_01_010.toMessage.value = document.sms_01_010.toMessage.value + ch;
}


/**
 * 선택된 번호를 받는 사람에 추가한다
 */
function addNum(num) {
  var option1 = new Option(num,num);
  var len = document.sms_01_010.receiveHp.length-1; 
  document.sms_01_010.receiveHp.options[len+1] = option1;
}
/**
 * 휴대폰 양식에 맞는 문자를 만들어 반환한다.
 * (국번과 번호사이에 '-'문자삽입)
 */
function makeHpNum(exchangeNum, num) {
  return exchangeNum.value + "-" + num.value;
}


/**
 * 주소록 팝업 창 출력
 */
function selAddress(objForm,objText) {
  var link = "../servlet/address.AddressServ?cmd=list&use=sms&objForm="+objForm+"&objText="+objText;
  window.open( link ,"address","status=no,toolbar=no,scrollbars=yes,width=500,height=700");
}


/**
 * 받는사람 전화번호 업로드 팝업 창 출력
 */
function upload_hp_form() {
  var link = "../servlet/sms.SmsServ?cmd=upload_hp_form";
  window.open( link ,"upload_hp","status=no,toolbar=no,scrollbars=no,width=540,height=200");
}


/**
 * 받는사람 수 설정
 */
function setReceiveCount() {
    var count1 = 0;
    var count2 = 0;
  for(idx=0; idx<document.sms_01_010.receiveHp.options.length; idx++)
  {
    //alert(document.sms_01_010.receiveHp[idx].value);
        if(document.sms_01_010.receiveHp[idx].value.indexOf('@') != -1)
        {
            count2 = parseInt(count2) + 1;
        } else
        {
            count1 = parseInt(count1) +1;    
        }
  }
  //alert('count1 : '+count1);
  //alert('count2 : '+count2);
  document.sms_01_010.receiveCount1.value = count1;
  document.sms_01_010.receiveCount2.value = count2;
}


/**
 * 받는사람 select box에 전화번호 추가
 */
function addReceiveHp() {
    
  returnAddReceiveHp();
}


/**
 * 받는사람 select box 모두 선택 혹은 해제
 */
function receiveHpSelectedAll(obj, flag) {
  var size = obj.options.length;
  for(var i=0; i<size; i++) {
    obj.options[i].selected = flag;
  }
}


/**
 * 받는사람 select box에 전화번호 추가
 * 성공하면 true반환
 */
function returnAddReceiveHp() {
  var obj = document.sms_01_010;
    
  if(!checkInputReceivePhone()) 
  {
    return false;
  }
    
  var receiveHpNum = makeHpNum(obj.receivePhoneCode, obj.receivePhone);

  insertOption(obj.receiveHp, receiveHpNum, receiveHpNum);
  receiveHpSelectedAll(obj.receiveHp, false);
  setReceiveCount();
  resetReceivePhone();
  
  return true;
}

function recentAddReceiveHp(num) {
  var obj = document.sms_01_010;
    
    
  var receiveHpNum =num;

  insertOption(obj.receiveHp, receiveHpNum, receiveHpNum);
  receiveHpSelectedAll(obj.receiveHp, false);
  setReceiveCount();
  resetReceivePhone();
  
  return true;
}

/**
 * 주소록에서 유효한 핸드폰 번호인지 체크
 */
function checkMobileNumber(args)
{
	alert(11)
    if(args=="" || args.length==0)
        return;
    
    var okReceiveHpNum = "";
    var tempChar = ' ';    
    for (i = 0; i < args.length; i++) 
    {
        tempChar = args.charAt(i);
        if (tempChar != "-") 
        {
            if (tempChar>='0'&& tempChar<='9') 
            {
                okReceiveHpNum += tempChar;
            } else
            {                
                return 'none';
            }
        }
    }
    
    var len = okReceiveHpNum.length;
    if(len<10 || len>11)     
        return 'none';
        
    if(len==10)     
        okReceiveHpNum = okReceiveHpNum.substring(0, 3) + "-" + okReceiveHpNum.substring(3, 6) + "-" + okReceiveHpNum.substr(6, 10);
    else 
        okReceiveHpNum = okReceiveHpNum.substring(0, 3) + "-" + okReceiveHpNum.substring(3, 7) + "-" + okReceiveHpNum.substr(7, 11);
   
   //alert(okReceiveHpNum);
   return okReceiveHpNum;
    
}

/**
 * 받는사람 select box에 전화번호 삭제
 */
function removeReceiveHp()	{
  var obj = document.sms_01_010;

	if(obj.receiveHp.options.length==0) {
		alert("더이상 삭제할 폰번호가 없습니다.");
		return;
	}

	if(obj.receiveHp.selectedIndex==-1) {
//		obj.receiveHp.options[0] = null;
    alert("삭제할 폰번호를 선택하세요.");
	} else {
    for(var i=0; i<obj.receiveHp.options.length; i++) {
      if(obj.receiveHp.options[i].selected) {
        obj.receiveHp.options[i] = null;
        --i;
      }
    }
	}
  setReceiveCount();
}

/**
 * 문자열이 length byte를 초과하는지 체크하고,
 * 초과시 length byte까지만 세팅하고 경고문을 띄운다.
 */
function checklen(length) {
  returnChecklen(length);
}


/**
 * 문자열이 length byte를 초과하는지 체크하고,
 * 초과시 length byte까지만 세팅하고 경고문을 띄운다.
 * length byte를 초과하면 false.
 */
function returnChecklen(len) {
  var flag = true;
	var msgtext = document.sms_01_010.toMessage.value;
    var msglen = document.sms_01_010.msglen.value;

	var i=0,l=0;
	var temp,lastl;
	
	//길이를 구한다.
	while(i < msgtext.length)
	{
		temp = msgtext.charAt(i);
		
		if(escape(temp).length>4) {
			l+=2;
    } else if (temp!='\r') {
      l++;
    }
		// OverFlow
		if(l>len) {
			alert("일반 메시지 본문은 한글 " + (len/2) + "자, 영문 " + len +
                  "자까지만 쓰실 수 있습니다.\n");
			temp = document.sms_01_010.toMessage.value.substr(0,i);
			document.sms_01_010.toMessage.value = temp;
			l = lastl;
      		flag = false;
      		document.sms_01_010.mglenLimit.value = '/ '+len;
			break;
		}
		lastl = l;
		i++;
	}

	document.sms_01_010.msglen.value=l;
  if(document.sms_01_010.formType.value=="long") {
    checkCount();
  }
  return flag;
}


/**
 * 문자열길이를 80byte단위로 쪼개어 몇건인지 계산하여 msgCount에 설정.
 */
function checkCount() {
  document.sms_01_010.msgCount.value = getMessageCount();
}


/**
 * 숫자만 입력받을수 있게 체크.
 */
function chkNum() {
	if(event.keyCode==37 || event.keyCode==39 || event.keyCode==46) {
		event.returnValue = true;
	} else {
		if(!event.shiftKey) {
			if(event.keyCode>47) {
				if(event.keyCode<58) {
					event.returnValue = true;
				} else if(event.keyCode>95 ) {
					if(event.keyCode<106) {
						event.returnValue = true;
					} else {
						event.returnValue = false;
          }
				} else {
					event.returnValue = false;
        }
			} else if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 32) {
				event.returnValue = true;
			} else {
				event.returnValue = false;
      }
		} else {
			event.returnValue = false;
    }
	}
}

/**
 * byte길이를 구하여 반환한다.(message용)
 */
function getMessageLeng(str) {
	var i=0,len=0;
	var temp;
	
	//길이를 구한다.
	while(i < str.length)
	{
		temp = str.charAt(i);
		
		if(escape(temp).length>4) {
			len+=2;
    } else if (temp!='\r') {
      len++;
    }

		i++;
	}

  return len;
}

/**
 * byte길이를 구하여 반환한다.(폰번호용)
 */
function getLeng(str) {
	var len = 0;
	for (var i = 0; i < str.length; i++) {
		if ( str.charCodeAt(i) > 127) {
			len += 2;
		} else {
			len++;
		}
	}

	return len;
}


/**
 * 80byte단위로 몇건인지 구하여 반환한다.
 */
function getMessageCount() {

  var len = document.sms_01_010.msglen.value;
  var count = Math.ceil(len/80);

  return count;
}


/**
 * 전화번호 입력양식에 맞는 '-'문자를 삽입한다.
 */
function addDash(obj) {
	var noDashStr = "" ;
	noDashStr	= removeDash(obj.value);
	var iLen		= getLeng(noDashStr);

//	if(event.keyCode != 8) {
		switch (iLen) {
			case 0:
			case 1:
			case 2:
				break;
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
				obj.value = noDashStr.substring(0,3) + "-" + noDashStr.substr(3,4) ;
				break;
			case 8:
				obj.value = noDashStr.substring(0,4) + "-" + noDashStr.substr(4,4) ;
				break;
			default :
				alert("사용할수 없는 폰번호입니다.");
				obj.value  = noDashStr.substring(0,4) + "-" + noDashStr.substr(4,4) ;
		}
//	}
}


/**
 * '-'문자를 지워 반환한다.
 */
function removeDash(str) {
	var noDashStr = "";
	var i = 0;
	
	for (i = 0; i < str.length; i++) {
		if (str.charAt(i) != "-") {
			noDashStr += str.charAt(i);
		}
	}

	return noDashStr;
}


/**
 * '\r'문자를 지워 반환한다.
 */
function removeCr(obj) {
	var noCrStr = "";
	var i = 0;
	
	for (i = 0; i < obj.value.length; i++) {
		if ((obj.value).charAt(i) != '\r') {
			noCrStr += (obj.value).charAt(i);
		}
	}

	return noCrStr;
}


/**
 * 예약전송선택시 현재 날짜를 넣어준다.
 */
function inputCurDate() {
	var today = new Date();

	document.sms_01_010.SMS_REQUEST_SEND_DATE_year.value = today.getYear();
  document.sms_01_010.SMS_REQUEST_SEND_DATE_month.value = today.getMonth() + 1;
  document.sms_01_010.SMS_REQUEST_SEND_DATE_date.value = today.getDate();
  document.sms_01_010.SMS_REQUEST_SEND_DATE_hour.value = today.getHours();
  document.sms_01_010.SMS_REQUEST_SEND_DATE_minute.value = today.getMinutes();
}


/**
 * 해당하는 달의 마지막 날을 리턴.
 */
function daysInMonth(whichMonth, whichYear) {
  var daysInMonth = 31;

  if(whichMonth=="4" || whichMonth=="6" || whichMonth=="9" || whichMonth=="11") daysInMonth = 30;
  if(whichMonth=="2" && (whichYear/4)!=Math.floor(whichYear/4)) daysInMonth = 28;
  if(whichMonth=="2" && (whichYear/4)==Math.floor(whichYear/4)) daysInMonth = 29;

  return daysInMonth;
}


/**
 * 예약날짜가 현재날짜 이전이면 경고창을 띄운다.
 */
function checkReservation() {
  var now = new Date();
  var year = document.sms_01_010.SMS_REQUEST_SEND_DATE_year.value;
  var month = document.sms_01_010.SMS_REQUEST_SEND_DATE_month.value;
  var day = document.sms_01_010.SMS_REQUEST_SEND_DATE_date.value;
  var hour = document.sms_01_010.SMS_REQUEST_SEND_DATE_hour.value;
  var minute = document.sms_01_010.SMS_REQUEST_SEND_DATE_minute.value;
  var dayLng = 0;

  dayLng = daysInMonth(month, year);

  if (dayLng < day) {
    alert("예약할수 없는 날짜입니다.");
    document.sms_01_010.SMS_REQUEST_SEND_DATE_date.value = dayLng;
    return false;
  }

  var selectDay = new Date(year, (month - 1), day, hour, minute);

  if(now>selectDay) {
    alert("지난 날짜는 예약할수없습니다.");
    return false;
  }

  return true;
}


/**
 * div 숨기고 보이게 하는 함수
 */
function hiddenDiv(showElement, hiddenElement) {
  if(showElement == 'reservationDiv')
       alert("예약전송은 취소가 되지 않습니다.\n 예약정보를 정확히 입력해주세요.!!");

  document.all[showElement].style.display = "";
  document.all[hiddenElement].style.display = "none";
}


/**
 * 해당 object의 값이 null이거나 비어있는지 체크하는 함수.
 */
function isEmpty(oObject) {
  return oObject.value=="" || oObject.value.length==0
}


/**
 * 메시지 내용이 null인지 체크한다.
 */
function checkMsgNull() {
  var obj = document.sms_01_010.toMessage;

  if (isEmpty(obj) || obj.value==NEED_MSG) {
    alert("메세지가 입력되지않았습니다.");
    obj.focus();
    return true;
  } else {
    return false;
  }
}


/**
 * 보내는사람의 phone number가 유효한지 체크한다.
 */
function checkSendPhone() {
  var obj1 = document.sms_01_010.sendPhoneCode;
  var obj2 = document.sms_01_010.sendPhone;
  var phoneNumLen = removeDash(obj2.value).length;

  if (isEmpty(obj1)||isEmpty(obj2)) {
    alert("보내는사람 폰번호가 입력되지않았습니다.");
    obj2.focus();
    return false;
  } else if(phoneNumLen<7 || phoneNumLen>8) {
    alert("보내는사람 폰번호가 잘못되었습니다");
    obj2.focus();
    return false;
  } else {
    return true;
  }
}


/**
 * 받는사람의 phone number가 유효한지 체크한다.
 */
function checkInputReceivePhone() {
  var obj1 = document.sms_01_010.receivePhoneCode;
  var obj2 = document.sms_01_010.receivePhone;

  if (isEmpty(obj1)||isEmpty(obj2)) {
    alert("받는사람 폰번호가 입력되지않았습니다.");
    obj2.focus();
    return false;
  }

  var phoneNumLen = removeDash(obj2.value).length;
  if((!isEmpty(obj2)) && (phoneNumLen<7 || phoneNumLen>8)) {
    alert("받는사람 폰번호가 잘못되었습니다");
    obj2.focus();
    return false;
  }

  return true;
}


/**
 * 받는사람이 세팅되어있는지 체크한다.
 */
function checkReceivePhone() {
  if(document.sms_01_010.receiveHp.options.length<=0) {
    alert("받는사람 폰번호가 입력되지않았습니다.");
    document.sms_01_010.receivePhone.focus();
    return false;
  }

  return true;
}


/**
 * type이 예약이라면 true를 반환한다.
 * 즉시이거나 null 혹은 값이 없다면 false를 반환한다.
 */
function checkTypeIsReservation() {
  var val = getRadioCheckedValue(document.sms_01_010.type);

  if (val==1) {
    return true;
  } else {
    return false;
  }
}


/**
 * 예약일자가 설정되어있는지 체크한다.
 */
function checkReservationDate() {
  var obj1 = document.sms_01_010.SMS_REQUEST_SEND_DATE_year;
  var obj2 = document.sms_01_010.SMS_REQUEST_SEND_DATE_month;
  var obj3 = document.sms_01_010.SMS_REQUEST_SEND_DATE_day;
  var obj4 = document.sms_01_010.SMS_REQUEST_SEND_DATE_hour;
  var obj5 = document.sms_01_010.SMS_REQUEST_SEND_DATE_minute;

  if (isEmpty(obj1) && isEmpty(obj2) && isEmpty(obj3) && isEmpty(obj4) && isEmpty(obj5)) {
    alert("예약일자가 올바르게 입력되지않았습니다.");
    obj1.focus();
    return false;
  } else if(!checkReservation()) {
    obj1.focus();
    return false;
  } else {
    return true;
  }
}


/**
 * SMS전송시 필요한 데이터가 유효한지 체크
 */
function checkIntegrity() {
  if(checkMsgNull()) return false;
  if(!checkSendPhone()) return false;
  if(!isEmpty(document.sms_01_010.receivePhone)) {
    if(!returnAddReceiveHp()) {
      return false;
    }
  }
  if(!checkReceivePhone()) return false;

  if(checkTypeIsReservation()) {
    if(!checkReservationDate()) return false;
  }
  return true;
}


/**
 * 쿼터제한에 걸리지 않는지 체크
 */
function useQuota() {
  var obj = document.sms_01_010;

  if(getMessageCount()*obj.receiveHp.length>document.sms_01_010.quota.value) {
    alert("전송가능메시지를 초과하였습니다.");
    return false;
  }
  return true;
}

function addHpDash(obj) {
 var noDashStr = "" ;
 noDashStr = removeDash(obj.value);
 var iLen  = getLeng(noDashStr);
  switch (iLen) {
   case 0:
   case 1:
   case 2:
    break;
   case 3:
   case 4:
   case 5:
   case 6:
   case 7:
    break;
   case 8:
    break;
   case 9: 
   case 10:
    obj.value = noDashStr.substring(0,3) + "-" + noDashStr.substr(3,3) + "-" + noDashStr.substr(6,4);
    break;
   case 11:
    obj.value = noDashStr.substring(0,3) + "-" + noDashStr.substr(3,4) + "-" + noDashStr.substr(7,4);
    break;
   default :
    alert("사용할수 없는 폰번호입니다.");
    obj.value  = noDashStr.substring(0,4) + "-" + noDashStr.substr(4,4) ;
  }
}

