/**
 * Window Open <br>
 * Window속성 - 화면가운데 위치 하며 scrollbar = yes, resizable=yes, status=yes, toolbar=no, menubar=no
 * @param url  window의 URL
 * @param name  Window의 명
 * @param widht window폭 (픽셀)
 * @param height window높이 (픽셀)
 * @return window object
 */
function openWindow(url, name, width, height)   {
    var top     =       screen.height / 2 - height / 2 - 50;
    var left    =       screen.width / 2 - width / 2 ;
    var win = open(url, name, 'width='+width+',height='+height+',top='+top+',left='+left+',resizable=yes,status=yes,toolbar=no,menubar=no');
    win.focus();
    return win;
}

/**
 * Bubble sort function due to Javascript's sort() method of the Array 
 * class's bug.
 *  And, this function uses bubble sort algorithm for the simplicity.
 *  
 * @param array the array to sort
 * @param comfunc the comparator function
 */
function sortArray( array, cmpfunc ) {
   var i,j;
   
   for ( i = array.length - 1; i >= 0; i-- ) {
     for ( j = 0; j < i; j++ ) {
       var cond;
       if ( cmpfunc == null )
           cond = (array[j] > array[j+1]);
       else
           cond = cmpfunc( array[j], array[j+1] );     
       if ( cond ) {
          // swap the elements
          temp = array[j];
          array[j] = array[j+1];
          array[j+1] = temp;
       }
     }
   }
}

/**
 * Make the specified value selected in the selection object
 *
 * @param selectObject the object to modify the selected value
 * @param value the value to be selected
 * @return true : success changed, false : no data found
 */
function setSelectedIndexByValue( selectObject, value ) {
  if ( selectObject == null )
    return false;
    
  for ( var i = 0; i < selectObject.options.length; i++ ) {
    if ( selectObject.options[i].value == value ) {
      selectObject.selectedIndex = i;
      return true;
    }
  }
  return false
}

function setCheckedRadioByValue( checkObject, value ) {
  if ( checkObject == null )
    return false;
  for ( var i = 0; i < checkObject.length; i++ ) {
    if ( checkObject[i].value == value ) {
      checkObject[i].checked = true;
      return true;
    }
  }
  return false
}

function setCheckBoxByValue( checkObject, value ) {
  if ( checkObject == null ){
    return false;
  }
  if ( checkObject.value == value ) {
    checkObject.checked = true;
    return true;
  }
  return false
}

function setCheckBoxsByValues( checkObject, value ) {
  if ( checkObject == null )
    return false;
  for(i = 0; i < checkObject.length;i++){
    if ( checkObject[i].value == value ) {
      checkObject[i].checked = true;
      return true;
    }
  }
  return false
}

/**
 * Returns the selected value from the selection object
 * @param selectObject the selection object
 */
function getSelectedValue( select ) {
  if ( select == null )
    return null;
  
  return select.options[select.selectedIndex].value;
}

/**
 * Selection Object에서 Value의 Index Return 
 * @param select the selection object
 * @param value 값 
 * @return Index of value, -1 if there were no value in Selection Object.
 */
function getIndexByValue( select, value ) {
  if ( select == null )
    return;
    
  for ( var i = 0; i < select.options.length; i++ ) {
    if ( select.options[i].value == value )
      return i;
  }
  
  return -1;  // not found.
}


function insertOption(selectObject, text, value){
  if( selectObject == null ) {
    return false;
  }
  var opt = document.createElement("Option");
	opt.text= text;
	opt.value= value;
	selectObject.options.add(opt);
	return true; 		
}

function insertOptions(selectObject, insertObject){
  if( selectObject == null || insertObject == null) {
    return false;
  }
  for(i=0; i<selectObject.options.length; i++){
    if(selectObject.options[i].selected == true){
      var isExist = false;
      for(j=0; j<insertObject.options.length; j++){
        if(insertObject.options[j].value == selectObject.options[i].value){
          isExist=true;
        }
      }  
      if(!isExist){
        var opt = document.createElement("Option");
      	opt.text= selectObject.options[i].text;
      	opt.value= selectObject.options[i].value;
      	insertObject.options.add(opt);
	    }
    }
  }
}

function deleteOptions(selectObject){
  if( selectObject == null) {
    return false;
  }
  for(i=selectObject.options.length-1; i>=0; i--){
    if(selectObject.options[i].selected == true){
      selectObject.options[i] = null;
    }
  }
}


/*checkbox가 하나일경우 checkObject.length를 가져오지 못함
  getCheckedValue(objForm, strObj)사용
*/
function getRadioCheckedValue(checkObject){
  var strValue;
  for ( var i = 0; i < checkObject.length; i++ ) {
    if ( checkObject[i].checked == true ) {
      strValue = checkObject[i].value; 
    }
  }
  return strValue;    
}

function getCheckedValue(objForm, strObj){
  var value;
  var len = objForm.elements.length;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == strObj){
      if(objForm.elements[i].checked){
        value=objForm.elements[i].value
        break;
      }
    }
  }
  return value;
}

/**
 * Selection Object에서 Value를 가지는 option제거 
 * @param selectObject the Selection Object
 * @param value Option value to remove
 * @return true : success changed, false : no data found 
 */
function removeOptionByValue( selectObject, value ) {
    
  if ( selectObject == null )  
    return false;
    
  var index = getIndexByValue( selectObject, value );
  var srcC = 0, destC = 0;  
  if ( index == -1 ) return false; // not found
  
  // else value was found, shift all elemenets which are after index    
  while ( srcC < selectObject.options.length) {
    //selectObject.options[destC] = selectObject.options[srcC];
    selectObject.options[destC].value=selectObject.options[srcC].value;
    selectObject.options[destC].text=selectObject.options[srcC].text;
    if ( srcC == index ){ destC--;}       
    srcC++;
    destC++;
  }  
  selectObject.options.length -= 1;      
  return true;
}

/*
 *Selection Object 이동
 * @param selectObject the Selection Object
 * @param optFrom Option index to move 
 * @param optTo   Option index to move
 */
function moveSelectOptionByIndex(selectObject, optFrom, optTo){
   if ( selectObject == null )  
    return false;
   if(selectObject.options[optFrom] == null || selectObject.options[optTo] == null)
     return false;
   var strTmpValue = selectObject.options[optFrom].value;
   var strTmpText = selectObject.options[optFrom].text;
   selectObject.options[optFrom].text = selectObject.options[optTo].text ;
   selectObject.options[optFrom].value = selectObject.options[optTo].value ;
   selectObject.options[optTo].text  = strTmpText;
   selectObject.options[optTo].value  = strTmpValue;
   selectObject.options[optTo].selected = true;
   return true;
}


/*
 *Selection Object의 text 수정
 * @param selectObject the Selection Object
 * @param strValue 
 * @param strText  
 */
function modifySelectTextByValue(selectObject, strValue, strText){
  if ( selectObject == null )  
    return false;
  var index = getIndexByValue( selectObject, strValue );  
  if ( index == -1 ) return false; // not found
  selectObject.options[index].text  = strText;
}

/**
 * 날짜 데이터를 Setting한다. printDateSelect()와 함께 사용 
 * @param select select Object ex) document.frm.p_date
 */

function mergeDateSelect( select ) {
    
    var sYear = eval('document.' + select.form.name + '.' + select.name + '_year');
    var sMonth = eval('document.' + select.form.name + '.' + select.name + '_month');
    var sDate = eval('document.' + select.form.name + '.' + select.name + '_date');
       
    select.value = sYear.options[ sYear.selectedIndex ].value;
    select.value += sMonth.options[ sMonth.selectedIndex ].value;
    select.value += sDate.options[ sDate.selectedIndex ].value;
    
 }


/**
 * 년 + 월 + 일 + 시간 + 분 <select>..</select> Tag 뿌리기 
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printDateTimeSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    var hourSelectName = selectName + '_hour';
    var minuteSelectName = selectName + '_minute';
    
    document.writeln( makeYearSelect( yearSelectName ) + '년 ' 
         + makeMonthSelect( monthSelectName) +'월 '
         + makeDateSelect( dateSelectName) +'일'
         + makeHourSelect( hourSelectName) +'시'
         + makeMinuteSelect( minuteSelectName) +'분');
}

/**
 * 년 + 월 + 일 + <br> + 시간 + 분 <select>..</select> Tag 뿌리기 
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printDateBrTimeSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    var hourSelectName = selectName + '_hour';
    var minuteSelectName = selectName + '_minute';
    
    document.writeln( makeYearSelect( yearSelectName ) + '년 ' 
         + makeMonthSelect( monthSelectName) +'월 '
         + makeDateSelect( dateSelectName) +'일'
         + "<br><br>"
         + makeHourSelect( hourSelectName) +'시'
         + makeMinuteSelect( minuteSelectName) +'분');
}

/**
 * 년 + 월 + 일 + 시간 + 분 + 초 <select>..</select> Tag 뿌리기 
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printDateToSecondSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    var hourSelectName = selectName + '_hour';
    var minuteSelectName = selectName + '_minute';
    var secondSelectName = selectName + '_second';
    
    document.writeln( makeYearSelect( yearSelectName ) + '년 ' 
         + makeMonthSelect( monthSelectName) +'월 '
         + makeDateSelect( dateSelectName) +'일'
         + makeHourSelect( hourSelectName) +'시'
         + makeMinuteSelect( minuteSelectName) +'분'
         + makeSecondSelect( secondSelectName) +'초');
}


/**
 * 년 + 월 + 일 + 시간 <select>..</select> Tag 뿌리기 
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printDateHourSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    var hourSelectName = selectName + '_hour';
    
    document.writeln( makeYearSelect( yearSelectName ) + '년 ' 
         + makeMonthSelect( monthSelectName) +'월 '
         + makeDateSelect( dateSelectName) +'일'
         + makeHourSelect( hourSelectName) +'시');
}

  
/**
 * 년 + 월 + 일 <select>..</select> Tag 뿌리기 
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printDateSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    
    document.writeln( makeYearSelect( yearSelectName ) + '년 ' 
         + makeMonthSelect( monthSelectName) +'월 '
         + makeDateSelect( dateSelectName) +'일');
}

/**
 * 월 + 일 <select>..</select> Tag 뿌리기 
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printMonthDateSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    
    document.writeln(  makeMonthSelect( monthSelectName) +'월 '
         + makeDateSelect( dateSelectName) +'일');
}

/**
 * 년 + 월 <select>..</select> Tag 뿌리기 
 */
function printYearToMonthSelect( yearSelectName, monthSelectName ) {
    document.writeln( makeYearSelect( yearSelectName ) + '년 ' 
         + makeMonthSelect( monthSelectName) +'월' );
}

/**
 * 시간 + 분 <select>..</select> Tag 뿌리기 
 * @param selectName <select name='<--에 들어갈 Name 
 */
function printHourToMinuteSelect(selectName) {
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var hourSelectName = selectName + '_hour';
    var minuteSelectName = selectName + '_minute';
    
    document.writeln(makeHourSelect( hourSelectName) +'시'
         + makeMinuteSelect( minuteSelectName) +'분');
}

/**
 * 년도 <select>..</select> Tag 만들기
 */
function makeYearSelect( yearSelectName ) {
    var html = "";
    var now = new Date();
    if ( yearSelectName != null ) {    
    html = '<select name="' + yearSelectName + '" class="boxline00">';    
    for ( var i = now.getFullYear() - 5; i <= now.getFullYear() + 5; i++ ) {
    html    += '<option value="' + i + '"' 
        + ( (now.getFullYear() == i) ? ' selected' : '') 
        + '>' + i + '</option>\n';
    }        
    html += '</select>';       
    return html;
    } else {
    	alert('년도 필드명이 빠졌습니다.\n소스를 확인하십시오.');
    } 
    return '';    
}

/**
 * 월(month) <select>..</select> Tag 만들기
 */
function makeMonthSelect( monthSelectName ) {
    var html = "";
    var now = new Date();    
    if ( monthSelectName != null ) {
    html = '<select name=' + monthSelectName + ' class="boxline00">';
    for ( var i = 1; i <= 12; i++ )
    html    +=  '<option value="' + ( ( i < 10 ) ? '' + i : i) + '"' 
        +   ( ( now.getMonth() + 1 == i ) ? ' selected' : '') 
        +   '>' + i + '</option>\n';
    html += '</select>';
    return html;
    } else {
    	alert('월(month)입력 필드명이 빠졌습니다.\n소스를 확인하십시오.');
    } 
    return '';    
}

/**
 * 일(date) <select>..</select> Tag 만들기
 */
function makeDateSelect( dateSelectName ) {
    var html = "";
    var now = new Date();    
    if ( dateSelectName != null ) {
    html = '<select name=' + dateSelectName + ' class="boxline00">';
    for ( var i = 1; i <= 31; i++ )
    html    +=  '<option value="' + ( ( i < 10 ) ? '' + i : i) + '"' 
        +   ( ( now.getDate() == i ) ? ' selected' : '') 
        +   '>' + i + '</option>';
    html += '</select>';       
    return html;
    } else {
    	alert('일(date)입력 필드명이 빠졌습니다.\n소스를 확인하십시오.');
    } 
    return '';    
}

/**
 * 시간(time) <select>..</select> Tag 만들기
 */
function makeHourSelect( hourSelectName ) {
    var html = "";
    var now = new Date();    
    if ( hourSelectName != null ) {
    html = '<select name=' + hourSelectName + ' class="boxline00">';
    for ( var i = 0; i <= 23; i++ )
    html    +=  '<option value="' + ( ( i < 10 ) ? '' + i : i) + '"' 
        +   ( ( now.getHours() == i ) ? ' selected' : '') 
        +   '>' + i + '</option>';
    html += '</select>';      
    
    return html;
    } else {
    	alert('시간(hour)입력 필드명이 빠졌습니다.\n소스를 확인하십시오.');
    } 
    return '';    
}


/**
 * 분 (minute) <select>..</select> Tag 만들기
 */
function makeMinuteSelect( minuteSelectName ) {
    var html = "";
    var now = new Date();    
    if ( minuteSelectName != null ) {
    html = '<select name=' + minuteSelectName + ' class="boxline00">';
    for ( var i = 0; i <= 59; i++ )
    html    +=  '<option value="' + ( ( i < 10 ) ? '' + i : i) + '"' 
        +   ( ( now.getMinutes() == i ) ? ' selected' : '') 
        +   '>' + i + '</option>';
    html += '</select>';       
    return html;
    } else {
    	alert('분(minute)입력 필드명이 빠졌습니다.\n소스를 확인하십시오.');
    } 
    return '';    
}

/**
 * 초 (second) <select>..</select> Tag 만들기
 */
function makeSecondSelect( secondSelectName ) {
    var html = "";
    var now = new Date();    
    if ( secondSelectName != null ) {
    html = '<select name=' + secondSelectName + ' class="boxline00">';
    for ( var i = 0; i <= 59; i++ )
    html    +=  '<option value="' + ( ( i < 10 ) ? '' + i : i) + '"' 
        +   ( ( now.getSeconds() == i ) ? ' selected' : '') 
        +   '>' + i + '</option>';
    html += '</select>';       
    return html;
    } else {
    	alert('초(second)입력 필드명이 빠졌습니다.\n소스를 확인하십시오.');
    } 
    return '';
}

/**
 * 폼의 첫번째 인풋 텍스트 필드에 포커스를 주는 함수.
 * @param form the FORM Object 
 */
function setFocusToFirstTextField( form ) {
  if ( typeof form == 'undefined' ) return;  // if form is invalid, just return.

  var count = form.elements.length;

  for ( var i = 0; i < count; i++ ) {
    if ( form.elements[i].type == "text" || form.elements[i].type == "password" ) {
      form.elements[i].focus();
      return;
    }
  }
}

/*
 * ASCII 값만 입력하도록 체크하는 루틴 영역
 */
var nonASCIIChar = /(([^\x20-\x7A])+)/g;    // ASCII Character가 아닌 문자 모두. 한글, 공백, 컨트롤, 128이상 문자 모두

/**
 * ASCII 값 이외의 값을 포함하고 있는지를 검사하는 함수
 * @return true ASCII 값 이외의 값을 포함
 *      false ASCII  값만 포함
 */ 
function containsNonASCII( check ) {
    if ( check.type != "text" && check.type != "password" && check.type != "hidden" ) {
      // Input type중 text, password, hidden type만 영어 이외의 입력이 있는지를 check한다.
      /*
      alert( 'Check할 대상은 Input 컨트롤로 text, password, hidden type만 가능합니다.\n' +
       '소스를 확인해 주세요.' );
      */
      return false;
    }

    if ( check.value.search( nonASCIIChar ) != -1 ) {
      return true;
    }

    return false;
}


/**
 * 주민등록번호 확인 
 */
function    checkSSN(tocheck_num) {
    var     isnum = true;
    if((tocheck_num == null) || (tocheck_num == "")) {
    isnum = false;
    return isnum;
    }
    for(var j = 0; j < tocheck_num.length; j++) {
    if((tocheck_num.substring(j, j+1) != "0") &&
        (tocheck_num.substring(j,j+1) != "1" ) &&
        (tocheck_num.substring(j,j+1) != "2" ) &&
        (tocheck_num.substring(j,j+1) != "3" ) &&
        (tocheck_num.substring(j,j+1) != "4" ) &&
        (tocheck_num.substring(j,j+1) != "5" ) &&
        (tocheck_num.substring(j,j+1) != "6" ) &&
        (tocheck_num.substring(j,j+1) != "7" ) &&
        (tocheck_num.substring(j,j+1) != "8" ) &&
        (tocheck_num.substring(j,j+1) != "9" ) ) {
         isnum = false;
    }
    }
    return isnum;
}

/** 
 * 주민등록번호 확인 
 * 2자리로 나누어 확인 
 */
function isSSN(regnoInput1, regnoInput2)   {
	
    var regno1 = regnoInput1.value;
    var regno2 = regnoInput2.value;
    
    // 주민등록번호 1 체크
    if(regno1 == "") {
    	
    	return  false;
    } else {
    if(regno1.length != 6) {
        
        return  false;
    } else {
        thisfilednum = checkSSN(regno1);
        if(!thisfilednum) {        
        	return  false;
        }
    }
    }

    // 주민등록번호 2 체크
    if(regno2 == "") {
    	
    	return  false;
    } else {
    	if(regno2.length != 7) {
        	
        	return  false;
    	} else {
        	thisfilednum = checkSSN(regno2);
        	if(!thisfilednum) {        	
        		return  false;
        	}
    	}
    }

    // 주민등록번호 체크
    var regno = regno1 + regno2;
    if(regno1 != "" && regno2 != "") {
    if(regno.charAt(6) == 1 || regno.charAt(6) == 2){
        if(regno.charAt(12) ==
        ((11 - ((regno.charAt(0)*2+regno.charAt(1)*3
            +regno.charAt(2)*4+regno.charAt(3)*5
            +regno.charAt(4)*6+regno.charAt(5)*7
            +regno.charAt(6)*8+regno.charAt(7)*9
            +regno.charAt(8)*2+regno.charAt(9)*3
            +regno.charAt(10)*4+regno.charAt(11)*5)% 11)))%10) {
        return  true;
        } else {        
        	return  false;
        }
    }
        
        return  false;
    }

    return  true;
}

/** 
 * 주민등록번호 확인 
 * 2자리로 나누어 확인 
 */
function    isSSNWithMsg(regnoInput1, regnoInput2)   {
	
    var regno1 = regnoInput1.value;
    var regno2 = regnoInput2.value;
    
    // 주민등록번호 1 체크
    if(regno1 == "") {
    	alert("주민등록번호를 입력하십시오.");    	
    	regnoInput1.focus();
    	return  false;
    } else {
    if(regno1.length != 6) {
        alert("주민등록번호를 입력하십시오.\n 6자리의 숫자입니다.");
        regnoInput1.focus();
        return  false;
    } else {
        thisfilednum = checkSSN(regno1);
        if(!thisfilednum) {
        alert("주민등록번호는 숫자만 가능합니다.");
        regnoInput1.focus();
        return  false;
        }
    }
    }

    // 주민등록번호 2 체크
    if(regno2 == "") {
    	alert("주민등록번호 7자리(뒷자리)를 입력하십시오.");
    	regnoInput2.focus();
    	return  false;
    } else {
    	if(regno2.length != 7) {
    		
        	alert("주민등록번호를 입력하십시오.\n 7자리의 숫자입니다.");
        	regnoInput2.focus();
        	return  false;
    	} else {
        	thisfilednum = checkSSN(regno2);
        	if(!thisfilednum) {
        		alert("주민등록번호는 숫자만 가능합니다.");
        		regnoInput2.focus();
        		return  false;
        	}
    	}
    }

    // 주민등록번호 체크
    var regno = regno1 + regno2;
    if(regno1 != "" && regno2 != "") {
    if(regno.charAt(6) == 1 || regno.charAt(6) == 2){
        if(regno.charAt(12) ==
        ((11 - ((regno.charAt(0)*2+regno.charAt(1)*3
            +regno.charAt(2)*4+regno.charAt(3)*5
            +regno.charAt(4)*6+regno.charAt(5)*7
            +regno.charAt(6)*8+regno.charAt(7)*9
            +regno.charAt(8)*2+regno.charAt(9)*3
            +regno.charAt(10)*4+regno.charAt(11)*5)% 11)))%10) {
        return  true;
        } else {
            alert("주민등록번호가 잘못되었습니다.");
            regnoInput1.focus();
            return  false;
        }
    }
        alert("주민등록번호가 잘못되었습니다.");
        regnoInput1.focus();
        return  false;
    }

    return  true;
}

/**
 * 값의 길이가 자리수를 초과 하는 가?
 */
function overLength(obj, length) {
    if ( obj.value.length > length ) {
        return  true;
    } else {
        return false;
    }
}
/**
 * 필수 입력값 확인
 */
function isNodata(obj) {
    if ( overLength(obj, 0) ) {
    return  true;
    } else {
    return false;
    }
}


/**
 * isNum(str)   : 숫자 체크 함수(숫자 이외의 문자가 추가되었는지 체크)
 * @param  input
 * @return  
 *     true     : 숫자만 입력되었슴
 *     false    : 문자가 추가되엇슴, error message (입력에러)       
 */
function isNum(input) {
    /*
    for (i = 0; i < str.length; i++) {
      if (('0' <= str.charAt(i))&&(str.charAt(i) <= '9')){
        continue;
      }
      else {        
        return false;
      }
    }
    return true;       
    */
    if ( !(input.value-0) ) return false;
    return true;
    
}

/**
 * isCheckChar(str)   : 문자 체크 함수(문자가 포함되어 있는지 체크)
 * @param  str string
 * @return 
 *      true     : 문자가 포함되어 있슴
 *      false    : 문자가 포함되어있지 않음          
 */
function isCheckChar(str) {
    var checkChar = false;
    for (i = 0; i < str.length; i++) {
    if (('0' <= str.charAt(i))&&(str.charAt(i) <= '9')){
        continue;
    }
    else {
        checkChar = true;
    }
    }
    return checkChar;           
}

/**
 * addZero(str,len) : '0' 추가 함수(maxLength 의 크기에 맞추어 앞에 '0' 추가)
 * Example - 입력(76), 전체 length(4) -> addZero(str,4) -> str=0076
 * @param str string
 * @param len length
 * @return string
 */
function addZero(str,len) {
    if (str.length != len) {
    str = "0"+str;
    str = addZero(str,len);
    }
    return str;
}


/**
 * 숫자들을 금액표시로 전환 (99999 -> 99,999)
 * @param obj the Input Object
 * @return : formatted value of the Object.
 */
function numFormat(obj) {
    var str  = String(obj.value);
    var len  = str.length;
    var tmp  = "";
    var tm2  = "";
    
    /* 소수점 두개 이상 에러 표시 */
    count = 0;
    for( j=0 ; j < len ; j++) {
    if( obj.value.charAt(j) == '.') count++;
    }
    if (count > 1) {
    var text ="입력에러 : 소수점이 둘 이상 포함되었습니다."; 
    alert(text);
    obj.focus();
    }
    /* 소수점 두개 이상 에러 표시 끝 */
    
    if (str.charAt(0) == '-') {
    tmp = '-' ;
    str = str.substring(1,len);
    }
    if (str.indexOf('-',0) != -1) {
    obj.focus();
    return;
    }
    if ((sit=str.indexOf('.',0)) != -1) {
    tm2 = str.substring(sit,len);
    str = str.substring(0,sit);
    }

    var i    = 0;  
    while (str.charAt(i) == '0') i++;
  
    str = str.substring(i,len);
    len = str.length;
    
    if(len < 3) {
    obj.value = str;
    return;
    }
    else {
    var sit = len % 3;
    if (sit > 0) {
        tmp = tmp + str.substring(0,sit) + ',';
        len = len - sit;
    }
    while (len > 3) {
        tmp = tmp + str.substring(sit,sit+3) + ',';
        len = len - 3;
        sit = sit + 3;
    }
    tmp = tmp + str.substring(sit,sit+3) + tm2;
    obj.value = tmp;
    }
}
/**
 * Formatting된 문자를 숫자로 전환함수
 * @param  the Input Object
 * @return : value of unformatted the object
 */
function numUnFormat(obj) {
    var str = String(obj.value);
    var len = str.length;
    var sit = 0;
    var tmp = "";
    var ch  = '';
    
    while (sit < len) {
    ch = str.charAt(sit);
    if (((ch >= '0') && (ch <= '9')) || (ch == '-') || (ch == '.')) tmp = tmp + ch;
    sit++;
    }
    obj.value = tmp;
}

/**
 * keyCheck(e)  : 문자, 숫자 입력 함수(문자와 숫자 Backspace만 입력) 
 * @param    : [event]
 * @return : [true, false]
 */
var dLayers = (document.layers) ? true : false;
var dAll    = (document.all)    ? true : false;

function keyCheck(e) {
    if(dLayers) var keyValue = e.which;
    else if(dAll) var keyValue = event.keyCode;

    // 문자와 숫자, backspace만 입력할때 return true
    if ( ((keyValue >= 33) && (keyValue <= 126 )) || keyValue == 8 ) {
      if ( keyValue >= 0x61 && keyValue <= 122 ) { // 소문자이면
    if ( dLayers ) {// Netscape
      //e.which = e.which & 0xDF;
      // nothing to do here now.
    }
    else if ( dAll ) {  // Internet Explorer
      event.keyCode = event.keyCode & 0xDF;  // 대문자로 변경
    }
      }

    return true;       
       }
    else return false;
}


/**
 * keyNumCheck(e)  : 숫자 입력 함수(숫자와 Backspace만 입력) 
 * @param    : [event]
 * @return : [true, false]
 */
var dLayers = (document.layers) ? true : false;
var dAll    = (document.all)    ? true : false;

function keyNumCheck(e) {
    if(dLayers) var keyValue = e.which;
    else if(dAll) var keyValue = event.keyCode;

    // 숫자와 backspace만 입력할때 return true
    if ( ((keyValue >= 48) && (keyValue <= 57)) || keyValue == 8)
    return true; 
    else return false;
}

/**
 * keyNumCheck2(e)  : 숫자와 소수점(외환) 입력 함수(숫자와 Backspace, 소수점만 입력) 
 * @param    : [event]
 * @return : [true, false]
 */
var dLayers = (document.layers) ? true : false;
var dAll    = (document.all)    ? true : false;

function keyNumCheck2(e) {
    if(dLayers) var keyValue = e.which;
    else if(dAll) var keyValue = event.keyCode;

    // 숫자와 backspace, 소수점만 입력할때 return true)e
    if ( ((keyValue >= 48) && (keyValue <= 57)) || keyValue == 8 || keyValue == 46)
    return true; 
    else return false;
}

/**
 * keyNumCheck3(e)  : 숫자와 '-' 입력 함수(숫자와 Backspace, '-'만 입력) 
 * @param    : [event]
 * @return : [true, false]
 */
var dLayers = (document.layers) ? true : false;
var dAll    = (document.all)    ? true : false;
function keyNumCheck3(e) {
//      var keyCode = 0, keyValue = null;

    if(dLayers) keyCode = e.which;
    else if(dAll) keyCode = event.keyCode;

    // 숫자와 backspace, 소수점만 입력할때 return true)e
    if ( ((keyCode >= 48 ) && (keyCode <= 57)) || keyCode == 8 || keyCode == 45)
    return true;
    else return false;
}


// 한글 한글자를 2byte로 인식하여, IE든 Netscape든 
// 제대로 byte길이를 구해 줍니다.

function getByteLength(s){
   var len = 0;
   if ( s == null ) return 0;
   for(var i=0;i<s.length;i++){
      var c = escape(s.charAt(i));
      if ( c.length == 1 ) len ++;
      else if ( c.indexOf("%u") != -1 ) len += 2;
      else if ( c.indexOf("%") != -1 ) len += c.length/3;
   }
   return len;
}

/**
 * 입력값이 이메일 형식인지 체크
 */
function isValidEmail(input) {
    var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
    return isValidFormat(input,format);
}

/**
 * 입력값이 도메인 형식인지 체크
 */
function isValidDomain(input) {
    var format = /^((\w|[\-\.])+)\.([A-Za-z]+)$/;
    return isValidFormat(input,format);
}


/**
 * 입력값이 IP 형식인지 체크
 */
function isValidIP(input) {
    var format = /^(\d+).(\d+).(\d+).(\d+)$/;
    return isValidFormat(input,format);
}

/**
 * 입력값이 사용자가 정의한 포맷 형식인지 체크
 * 자세한 format 형식은 자바스크립트의 'regular expression'을 참조
 */
function isValidFormat(input,format) {
    if (input.search(format) != -1) {
        return true; 
    }
    return false;
}

/**
 * 입력값이 특정 문자(chars)만으로 되어있는지 체크
 */
function containsCharsOnly(input,chars) {
    for (var inx = 0; inx < input.length; inx++) {
       if (chars.indexOf(input.charAt(inx)) == -1)
           return false;
    }
    return true;
}


/*check box에서 하나이상 선택되었을경우 ture
 */
function isCheckedOfBox(objForm, strObj){
  var len = objForm.elements.length;	
  var nChkNum=0;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == strObj){
      if(objForm.elements[i].checked){
        nChkNum++;
      }
    }
  }
  if(nChkNum > 0)
    return true;
  else
    return false;
}


/*check box에서 하나만  선택되었을경우 ture
 */
function isCheckedOneOfBox(objForm, strObj){
  var len = objForm.elements.length;	
  var nChkNum=0;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == strObj){
      if(objForm.elements[i].checked){
        nChkNum++;
      }
    }
  }
  if(nChkNum ==1)
    return true;
  else
    return false;
}

/*check box reset
 */
function resetCheckedBox(objForm, strObj){
  var len = objForm.elements.length;	
  var nChkNum=0;
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == strObj){
      objForm.elements[i].checked = false;
    }
  }
}



/*숫자만 입력
ex)<input type=text onKeyPress=checkNum(this)>
*/
function checkNum(obj){
  if ((event.keyCode<48) || (event.keyCode >57 )) {
    event.returnValue=false;
    obj.focus();
    return;
  }
}


/*숫자와 - 만 입력(전화번호 형식)
ex)<input type=text onKeyPress=checkNum(this)>
*/
function checkNum_tel(obj){
  if (((event.keyCode < 48) || (event.keyCode > 57 )) && (event.keyCode != 45)) {
    event.returnValue=false;
    obj.focus();
    return;
  }
}


/*문자열 내 공백 제거*/
function trim(str){
  return str.replace(/(^\s+)|(\s+)$/,"");
}

/*frame 스크롤이 안보이도록 사이즈 조절
하위 프레임에서 호출
@param name (프레임명)
@param 프레임 최소크기
*/
function resizeFrame(name, min_width, min_height){
  var oBody =  document.body;
  var oFrame = parent.document.all(name); 
  if(oFrame != null){
    var i_height = oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);
    var i_width = oBody.scrollWidth + (oBody.offsetWidth-oBody.clientWidth);
    if(i_height < min_height) i_height = min_height;
    if(i_width < min_width) i_width = min_width;
    oFrame.style.height = i_height;
    oFrame.style.width = i_width;
  }
}


/*새창 스크롤이 안보이도록 사이즈 조절
@param 프레임 최소크기
*/
function resizeWindow(min_width,min_height,max_width,max_height){
  var oBody =  document.body;
  var i_height = oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight)+30;
  var i_width = oBody.scrollWidth + (oBody.offsetWidth-oBody.clientWidth)+25;
  if(i_height < min_height) i_height = min_height;
  if(i_width < min_width) i_width = min_width;
  if(i_height > max_height) i_height = max_height;
  if(i_width > max_width) i_width = min_width;
  window.resizeTo(i_width, i_height);
}

//포커스 이동
function changeFocus(len, inObj, nextObj) {
	if( inObj.value.length == len) {
		nextObj.focus();
	}
}

function setCheckbox(obj){
  if(obj.checked)
    obj.checked = false;
  else
     obj.checked = true;
}

function setCookie(name,value,expires){
  var str = ""+name+"="+escape(value);
  var exdata = "";
  if(expires != ""){
    exdata = ";expires="+expires.toGMTString();
    str += exdata;
  }
  document.cookie = str;
}

function getCookie (name) {
  var dcookie = document.cookie; 
  var cname = name + "=";
  var clen = dcookie.length;
  var cbegin = 0;
  while (cbegin < clen) {
    var vbegin = cbegin + cname.length;
    if (dcookie.substring(cbegin, vbegin) == cname) { 
      var vend = dcookie.indexOf (";", vbegin);
      if (vend == -1) vend = clen;
        return unescape(dcookie.substring(vbegin, vend));
    }
      cbegin = dcookie.indexOf(" ", cbegin) + 1;
      if (cbegin == 0) break;
  }
  return "";
}

function escape_url(url) {
	var i;
	var ch;
	var out = '';
	var url_string = '';

	url_string = String(url);

	for (i = 0; i < url_string.length; i++) {
		ch = url_string.charAt(i);
		if (ch == ' ')		out += '%20';
		else if (ch == '%')	out += '%25';
		else if (ch == '&')	out += '%26';
		else if (ch == '+')	out += '%2B';
		else if (ch == '=')	out += '%3D';
		else if (ch == '?') out += '%3F';
		else				out += ch;
	}
	return out;
}

/*문자 전체열 변환 */
String.prototype.replaceAll = function(from, to) {
   return this.replace(new RegExp(from, "g"), to);
}

String.prototype.replaceAll02 = function(from, to) {
   return this.replace(eval("/" + from + "/g"), to);
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
