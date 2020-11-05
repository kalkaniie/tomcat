var NEED_MSG = "<메시지를 입력해주세요>";


function makeHpNum(exchangeNum, num) {
  return exchangeNum.value + "-" + num.value;
}

function receiveHpSelectedAll(obj, flag) {
  var size = obj.options.length;
  for(var i=0; i<size; i++) {
    obj.options[i].selected = flag;
  }
}





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

function addDash(obj) {
	var noDashStr = "" ;
	noDashStr	= removeDash(obj.value);
	var iLen		= getLeng(noDashStr);

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
}
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

function daysInMonth(whichMonth, whichYear) {
  var daysInMonth = 31;

  if(whichMonth=="4" || whichMonth=="6" || whichMonth=="9" || whichMonth=="11") daysInMonth = 30;
  if(whichMonth=="2" && (whichYear/4)!=Math.floor(whichYear/4)) daysInMonth = 28;
  if(whichMonth=="2" && (whichYear/4)==Math.floor(whichYear/4)) daysInMonth = 29;

  return daysInMonth;
}
function checkReservation(objForm) {
  var now = new Date();
  var year = objForm.SMS_REQUEST_SEND_DATE_year.value;
  var month = objForm.SMS_REQUEST_SEND_DATE_month.value;
  var day = objForm.SMS_REQUEST_SEND_DATE_date.value;
  var hour = objForm.SMS_REQUEST_SEND_DATE_hour.value;
  var minute = objForm.SMS_REQUEST_SEND_DATE_minute.value;
  var dayLng = 0;

  dayLng = daysInMonth(month, year);

  if (dayLng < day) {
    alert("예약할수 없는 날짜입니다.");
    objForm.SMS_REQUEST_SEND_DATE_date.value = dayLng;
    return ;
  }

  var selectDay = new Date(year, (month - 1), day, hour, minute);

  if(now>selectDay) {
    alert("지난 날짜는 예약할수없습니다.");
    return ;
  }
}
function hiddenDiv(showElement, hiddenElement) {
  if(showElement == 'reservationDiv')
       alert("예약전송은 취소가 되지 않습니다.\n 예약정보를 정확히 입력해주세요.!!");

  document.all[showElement].style.display = "";
  document.all[hiddenElement].style.display = "none";
}
function isEmpty(oObject) {
  return oObject.value=="" || oObject.value.length==0
}
function checkMsgNull(objForm) {
  var obj = objForm.toMessage;

  if (isEmpty(obj) || obj.value==NEED_MSG) {
    alert("메세지가 입력되지않았습니다.");
    obj.focus();
    return true;
  } else {
    return false;
  }
}
function checkSendPhone(objForm) {
  var obj1 = objForm.sendPhoneCode;
  var obj2 = objForm.sendPhone;
  var phoneNumLen = removeDash(obj2.value).length;

  if (isEmpty(obj1)||isEmpty(obj2)) {
    alert("보내는사람 폰번호가 입력되지않았습니다.");
    obj2.focus();
    return ;
  } else if(phoneNumLen<7 || phoneNumLen>8) {
    alert("보내는사람 폰번호가 잘못 입력 되었습니다.");
    obj2.focus();
    return ;
  } 
  return true;
}
function checkInputReceivePhone(objForm) {
  var obj1 = objForm.receivePhoneCode;
  var obj2 = objForm.receivePhone;

  if (isEmpty(obj1)||isEmpty(obj2)) {
    alert("받는사람 폰번호가 입력되지않았습니다.");
    obj2.focus();
    return ;
  }

  var phoneNumLen = removeDash(obj2.value).length;
  if((!isEmpty(obj2)) && (phoneNumLen<7 || phoneNumLen>8)) {
    alert("보내는사람 폰번호가 잘못 입력 되었습니다.");
    obj2.focus();
    return ;
  }

  return true;
}
function checkReceivePhone(objForm) {
  if(objForm.receiveHp.options.length<=0) {
    alert("받는사람 폰번호가 입력되지않았습니다.");
    objForm.receivePhone.focus();
    return false;
  }

  return true;
}
function checkTypeIsReservation(objForm) {
  var val = getRadioCheckedValue(objForm.type);
alert(val)
  if (val==1) {
    return true;
  } else {
    return false;
  }
}
function checkReservationDate(objForm) {
  var obj1 = objForm.SMS_REQUEST_SEND_DATE_year;
  var obj2 = objForm.SMS_REQUEST_SEND_DATE_month;
  var obj3 = objForm.SMS_REQUEST_SEND_DATE_day;
  var obj4 = objForm.SMS_REQUEST_SEND_DATE_hour;
  var obj5 = objForm.SMS_REQUEST_SEND_DATE_minute;

  if (isEmpty(obj1) && isEmpty(obj2) && isEmpty(obj3) && isEmpty(obj4) && isEmpty(obj5)) {
    alert("예약일자가 올바르게 입력되지않았습니다.");
    obj1.focus();
    return ;
  } else if(!checkReservation(objForm)) {
    obj1.focus();
    return ;
  } 
}