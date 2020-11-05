/**
 * Window Open <br>
 * Window�Ӽ� - ȭ�鰡� ��ġ �ϸ� scrollbar = yes, resizable=yes, status=yes, toolbar=no, menubar=no
 * @param url  window�� URL
 * @param name  Window�� ��
 * @param widht window�� (�ȼ�)
 * @param height window���� (�ȼ�)
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
 * Selection Object���� Value�� Index Return 
 * @param select the selection object
 * @param value �� 
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


/*checkbox�� �ϳ��ϰ�� checkObject.length�� �������� ����
  getCheckedValue(objForm, strObj)���
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
 * Selection Object���� Value�� ������ option���� 
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
 *Selection Object �̵�
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
 *Selection Object�� text ����
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
 * ��¥ �����͸� Setting�Ѵ�. printDateSelect()�� �Բ� ��� 
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
 * �� + �� + �� + �ð� + �� <select>..</select> Tag �Ѹ��� 
 * @param selectName <select name='<--�� �� Name 
 */
function printDateTimeSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    var hourSelectName = selectName + '_hour';
    var minuteSelectName = selectName + '_minute';
    
    document.writeln( makeYearSelect( yearSelectName ) + '�� ' 
         + makeMonthSelect( monthSelectName) +'�� '
         + makeDateSelect( dateSelectName) +'��'
         + makeHourSelect( hourSelectName) +'��'
         + makeMinuteSelect( minuteSelectName) +'��');
}

/**
 * �� + �� + �� + <br> + �ð� + �� <select>..</select> Tag �Ѹ��� 
 * @param selectName <select name='<--�� �� Name 
 */
function printDateBrTimeSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    var hourSelectName = selectName + '_hour';
    var minuteSelectName = selectName + '_minute';
    
    document.writeln( makeYearSelect( yearSelectName ) + '�� ' 
         + makeMonthSelect( monthSelectName) +'�� '
         + makeDateSelect( dateSelectName) +'��'
         + "<br><br>"
         + makeHourSelect( hourSelectName) +'��'
         + makeMinuteSelect( minuteSelectName) +'��');
}

/**
 * �� + �� + �� + �ð� + �� + �� <select>..</select> Tag �Ѹ��� 
 * @param selectName <select name='<--�� �� Name 
 */
function printDateToSecondSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    var hourSelectName = selectName + '_hour';
    var minuteSelectName = selectName + '_minute';
    var secondSelectName = selectName + '_second';
    
    document.writeln( makeYearSelect( yearSelectName ) + '�� ' 
         + makeMonthSelect( monthSelectName) +'�� '
         + makeDateSelect( dateSelectName) +'��'
         + makeHourSelect( hourSelectName) +'��'
         + makeMinuteSelect( minuteSelectName) +'��'
         + makeSecondSelect( secondSelectName) +'��');
}


/**
 * �� + �� + �� + �ð� <select>..</select> Tag �Ѹ��� 
 * @param selectName <select name='<--�� �� Name 
 */
function printDateHourSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    var hourSelectName = selectName + '_hour';
    
    document.writeln( makeYearSelect( yearSelectName ) + '�� ' 
         + makeMonthSelect( monthSelectName) +'�� '
         + makeDateSelect( dateSelectName) +'��'
         + makeHourSelect( hourSelectName) +'��');
}

  
/**
 * �� + �� + �� <select>..</select> Tag �Ѹ��� 
 * @param selectName <select name='<--�� �� Name 
 */
function printDateSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    
    var yearSelectName = selectName + '_year';
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    
    document.writeln( makeYearSelect( yearSelectName ) + '�� ' 
         + makeMonthSelect( monthSelectName) +'�� '
         + makeDateSelect( dateSelectName) +'��');
}

/**
 * �� + �� <select>..</select> Tag �Ѹ��� 
 * @param selectName <select name='<--�� �� Name 
 */
function printMonthDateSelect( selectName ) {
    
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    
    var monthSelectName	= selectName + '_month';
    var dateSelectName = selectName + '_date';
    
    document.writeln(  makeMonthSelect( monthSelectName) +'�� '
         + makeDateSelect( dateSelectName) +'��');
}

/**
 * �� + �� <select>..</select> Tag �Ѹ��� 
 */
function printYearToMonthSelect( yearSelectName, monthSelectName ) {
    document.writeln( makeYearSelect( yearSelectName ) + '�� ' 
         + makeMonthSelect( monthSelectName) +'��' );
}

/**
 * �ð� + �� <select>..</select> Tag �Ѹ��� 
 * @param selectName <select name='<--�� �� Name 
 */
function printHourToMinuteSelect(selectName) {
    document.writeln( "<input type='hidden' name='" + selectName + "'>");
    var hourSelectName = selectName + '_hour';
    var minuteSelectName = selectName + '_minute';
    
    document.writeln(makeHourSelect( hourSelectName) +'��'
         + makeMinuteSelect( minuteSelectName) +'��');
}

/**
 * �⵵ <select>..</select> Tag �����
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
    	alert('�⵵ �ʵ���� �������ϴ�.\n�ҽ��� Ȯ���Ͻʽÿ�.');
    } 
    return '';    
}

/**
 * ��(month) <select>..</select> Tag �����
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
    	alert('��(month)�Է� �ʵ���� �������ϴ�.\n�ҽ��� Ȯ���Ͻʽÿ�.');
    } 
    return '';    
}

/**
 * ��(date) <select>..</select> Tag �����
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
    	alert('��(date)�Է� �ʵ���� �������ϴ�.\n�ҽ��� Ȯ���Ͻʽÿ�.');
    } 
    return '';    
}

/**
 * �ð�(time) <select>..</select> Tag �����
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
    	alert('�ð�(hour)�Է� �ʵ���� �������ϴ�.\n�ҽ��� Ȯ���Ͻʽÿ�.');
    } 
    return '';    
}


/**
 * �� (minute) <select>..</select> Tag �����
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
    	alert('��(minute)�Է� �ʵ���� �������ϴ�.\n�ҽ��� Ȯ���Ͻʽÿ�.');
    } 
    return '';    
}

/**
 * �� (second) <select>..</select> Tag �����
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
    	alert('��(second)�Է� �ʵ���� �������ϴ�.\n�ҽ��� Ȯ���Ͻʽÿ�.');
    } 
    return '';
}

/**
 * ���� ù��° ��ǲ �ؽ�Ʈ �ʵ忡 ��Ŀ���� �ִ� �Լ�.
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
 * ASCII ���� �Է��ϵ��� üũ�ϴ� ��ƾ ����
 */
var nonASCIIChar = /(([^\x20-\x7A])+)/g;    // ASCII Character�� �ƴ� ���� ���. �ѱ�, ����, ��Ʈ��, 128�̻� ���� ���

/**
 * ASCII �� �̿��� ���� �����ϰ� �ִ����� �˻��ϴ� �Լ�
 * @return true ASCII �� �̿��� ���� ����
 *      false ASCII  ���� ����
 */ 
function containsNonASCII( check ) {
    if ( check.type != "text" && check.type != "password" && check.type != "hidden" ) {
      // Input type�� text, password, hidden type�� ���� �̿��� �Է��� �ִ����� check�Ѵ�.
      /*
      alert( 'Check�� ����� Input ��Ʈ�ѷ� text, password, hidden type�� �����մϴ�.\n' +
       '�ҽ��� Ȯ���� �ּ���.' );
      */
      return false;
    }

    if ( check.value.search( nonASCIIChar ) != -1 ) {
      return true;
    }

    return false;
}


/**
 * �ֹε�Ϲ�ȣ Ȯ�� 
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
 * �ֹε�Ϲ�ȣ Ȯ�� 
 * 2�ڸ��� ������ Ȯ�� 
 */
function isSSN(regnoInput1, regnoInput2)   {
	
    var regno1 = regnoInput1.value;
    var regno2 = regnoInput2.value;
    
    // �ֹε�Ϲ�ȣ 1 üũ
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

    // �ֹε�Ϲ�ȣ 2 üũ
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

    // �ֹε�Ϲ�ȣ üũ
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
 * �ֹε�Ϲ�ȣ Ȯ�� 
 * 2�ڸ��� ������ Ȯ�� 
 */
function    isSSNWithMsg(regnoInput1, regnoInput2)   {
	
    var regno1 = regnoInput1.value;
    var regno2 = regnoInput2.value;
    
    // �ֹε�Ϲ�ȣ 1 üũ
    if(regno1 == "") {
    	alert("�ֹε�Ϲ�ȣ�� �Է��Ͻʽÿ�.");    	
    	regnoInput1.focus();
    	return  false;
    } else {
    if(regno1.length != 6) {
        alert("�ֹε�Ϲ�ȣ�� �Է��Ͻʽÿ�.\n 6�ڸ��� �����Դϴ�.");
        regnoInput1.focus();
        return  false;
    } else {
        thisfilednum = checkSSN(regno1);
        if(!thisfilednum) {
        alert("�ֹε�Ϲ�ȣ�� ���ڸ� �����մϴ�.");
        regnoInput1.focus();
        return  false;
        }
    }
    }

    // �ֹε�Ϲ�ȣ 2 üũ
    if(regno2 == "") {
    	alert("�ֹε�Ϲ�ȣ 7�ڸ�(���ڸ�)�� �Է��Ͻʽÿ�.");
    	regnoInput2.focus();
    	return  false;
    } else {
    	if(regno2.length != 7) {
    		
        	alert("�ֹε�Ϲ�ȣ�� �Է��Ͻʽÿ�.\n 7�ڸ��� �����Դϴ�.");
        	regnoInput2.focus();
        	return  false;
    	} else {
        	thisfilednum = checkSSN(regno2);
        	if(!thisfilednum) {
        		alert("�ֹε�Ϲ�ȣ�� ���ڸ� �����մϴ�.");
        		regnoInput2.focus();
        		return  false;
        	}
    	}
    }

    // �ֹε�Ϲ�ȣ üũ
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
            alert("�ֹε�Ϲ�ȣ�� �߸��Ǿ����ϴ�.");
            regnoInput1.focus();
            return  false;
        }
    }
        alert("�ֹε�Ϲ�ȣ�� �߸��Ǿ����ϴ�.");
        regnoInput1.focus();
        return  false;
    }

    return  true;
}

/**
 * ���� ���̰� �ڸ����� �ʰ� �ϴ� ��?
 */
function overLength(obj, length) {
    if ( obj.value.length > length ) {
        return  true;
    } else {
        return false;
    }
}
/**
 * �ʼ� �Է°� Ȯ��
 */
function isNodata(obj) {
    if ( overLength(obj, 0) ) {
    return  true;
    } else {
    return false;
    }
}


/**
 * isNum(str)   : ���� üũ �Լ�(���� �̿��� ���ڰ� �߰��Ǿ����� üũ)
 * @param  input
 * @return  
 *     true     : ���ڸ� �ԷµǾ���
 *     false    : ���ڰ� �߰��Ǿ���, error message (�Է¿���)       
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
 * isCheckChar(str)   : ���� üũ �Լ�(���ڰ� ���ԵǾ� �ִ��� üũ)
 * @param  str string
 * @return 
 *      true     : ���ڰ� ���ԵǾ� �ֽ�
 *      false    : ���ڰ� ���ԵǾ����� ����          
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
 * addZero(str,len) : '0' �߰� �Լ�(maxLength �� ũ�⿡ ���߾� �տ� '0' �߰�)
 * Example - �Է�(76), ��ü length(4) -> addZero(str,4) -> str=0076
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
 * ���ڵ��� �ݾ�ǥ�÷� ��ȯ (99999 -> 99,999)
 * @param obj the Input Object
 * @return : formatted value of the Object.
 */
function numFormat(obj) {
    var str  = String(obj.value);
    var len  = str.length;
    var tmp  = "";
    var tm2  = "";
    
    /* �Ҽ��� �ΰ� �̻� ���� ǥ�� */
    count = 0;
    for( j=0 ; j < len ; j++) {
    if( obj.value.charAt(j) == '.') count++;
    }
    if (count > 1) {
    var text ="�Է¿��� : �Ҽ����� �� �̻� ���ԵǾ����ϴ�."; 
    alert(text);
    obj.focus();
    }
    /* �Ҽ��� �ΰ� �̻� ���� ǥ�� �� */
    
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
 * Formatting�� ���ڸ� ���ڷ� ��ȯ�Լ�
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
 * keyCheck(e)  : ����, ���� �Է� �Լ�(���ڿ� ���� Backspace�� �Է�) 
 * @param    : [event]
 * @return : [true, false]
 */
var dLayers = (document.layers) ? true : false;
var dAll    = (document.all)    ? true : false;

function keyCheck(e) {
    if(dLayers) var keyValue = e.which;
    else if(dAll) var keyValue = event.keyCode;

    // ���ڿ� ����, backspace�� �Է��Ҷ� return true
    if ( ((keyValue >= 33) && (keyValue <= 126 )) || keyValue == 8 ) {
      if ( keyValue >= 0x61 && keyValue <= 122 ) { // �ҹ����̸�
    if ( dLayers ) {// Netscape
      //e.which = e.which & 0xDF;
      // nothing to do here now.
    }
    else if ( dAll ) {  // Internet Explorer
      event.keyCode = event.keyCode & 0xDF;  // �빮�ڷ� ����
    }
      }

    return true;       
       }
    else return false;
}


/**
 * keyNumCheck(e)  : ���� �Է� �Լ�(���ڿ� Backspace�� �Է�) 
 * @param    : [event]
 * @return : [true, false]
 */
var dLayers = (document.layers) ? true : false;
var dAll    = (document.all)    ? true : false;

function keyNumCheck(e) {
    if(dLayers) var keyValue = e.which;
    else if(dAll) var keyValue = event.keyCode;

    // ���ڿ� backspace�� �Է��Ҷ� return true
    if ( ((keyValue >= 48) && (keyValue <= 57)) || keyValue == 8)
    return true; 
    else return false;
}

/**
 * keyNumCheck2(e)  : ���ڿ� �Ҽ���(��ȯ) �Է� �Լ�(���ڿ� Backspace, �Ҽ����� �Է�) 
 * @param    : [event]
 * @return : [true, false]
 */
var dLayers = (document.layers) ? true : false;
var dAll    = (document.all)    ? true : false;

function keyNumCheck2(e) {
    if(dLayers) var keyValue = e.which;
    else if(dAll) var keyValue = event.keyCode;

    // ���ڿ� backspace, �Ҽ����� �Է��Ҷ� return true)e
    if ( ((keyValue >= 48) && (keyValue <= 57)) || keyValue == 8 || keyValue == 46)
    return true; 
    else return false;
}

/**
 * keyNumCheck3(e)  : ���ڿ� '-' �Է� �Լ�(���ڿ� Backspace, '-'�� �Է�) 
 * @param    : [event]
 * @return : [true, false]
 */
var dLayers = (document.layers) ? true : false;
var dAll    = (document.all)    ? true : false;
function keyNumCheck3(e) {
//      var keyCode = 0, keyValue = null;

    if(dLayers) keyCode = e.which;
    else if(dAll) keyCode = event.keyCode;

    // ���ڿ� backspace, �Ҽ����� �Է��Ҷ� return true)e
    if ( ((keyCode >= 48 ) && (keyCode <= 57)) || keyCode == 8 || keyCode == 45)
    return true;
    else return false;
}


// �ѱ� �ѱ��ڸ� 2byte�� �ν��Ͽ�, IE�� Netscape�� 
// ����� byte���̸� ���� �ݴϴ�.

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
 * �Է°��� �̸��� �������� üũ
 */
function isValidEmail(input) {
    var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
    return isValidFormat(input,format);
}

/**
 * �Է°��� ������ �������� üũ
 */
function isValidDomain(input) {
    var format = /^((\w|[\-\.])+)\.([A-Za-z]+)$/;
    return isValidFormat(input,format);
}


/**
 * �Է°��� IP �������� üũ
 */
function isValidIP(input) {
    var format = /^(\d+).(\d+).(\d+).(\d+)$/;
    return isValidFormat(input,format);
}

/**
 * �Է°��� ����ڰ� ������ ���� �������� üũ
 * �ڼ��� format ������ �ڹٽ�ũ��Ʈ�� 'regular expression'�� ����
 */
function isValidFormat(input,format) {
    if (input.search(format) != -1) {
        return true; 
    }
    return false;
}

/**
 * �Է°��� Ư�� ����(chars)������ �Ǿ��ִ��� üũ
 */
function containsCharsOnly(input,chars) {
    for (var inx = 0; inx < input.length; inx++) {
       if (chars.indexOf(input.charAt(inx)) == -1)
           return false;
    }
    return true;
}


/*check box���� �ϳ��̻� ���õǾ������ ture
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


/*check box���� �ϳ���  ���õǾ������ ture
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



/*���ڸ� �Է�
ex)<input type=text onKeyPress=checkNum(this)>
*/
function checkNum(obj){
  if ((event.keyCode<48) || (event.keyCode >57 )) {
    event.returnValue=false;
    obj.focus();
    return;
  }
}


/*���ڿ� - �� �Է�(��ȭ��ȣ ����)
ex)<input type=text onKeyPress=checkNum(this)>
*/
function checkNum_tel(obj){
  if (((event.keyCode < 48) || (event.keyCode > 57 )) && (event.keyCode != 45)) {
    event.returnValue=false;
    obj.focus();
    return;
  }
}


/*���ڿ� �� ���� ����*/
function trim(str){
  return str.replace(/(^\s+)|(\s+)$/,"");
}

/*frame ��ũ���� �Ⱥ��̵��� ������ ����
���� �����ӿ��� ȣ��
@param name (�����Ӹ�)
@param ������ �ּ�ũ��
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


/*��â ��ũ���� �Ⱥ��̵��� ������ ����
@param ������ �ּ�ũ��
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

//��Ŀ�� �̵�
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

/*���� ��ü�� ��ȯ */
String.prototype.replaceAll = function(from, to) {
   return this.replace(new RegExp(from, "g"), to);
}

String.prototype.replaceAll02 = function(from, to) {
   return this.replace(eval("/" + from + "/g"), to);
}

/**
 * ���ڸ� �Է¹����� �ְ� üũ.
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
