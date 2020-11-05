// 타입
var TYPE_NONE		 = 0;
var TYPE_EXPRESS = 1;
var TYPE_OUTLOOK = 2;
var TYPE_CSV 		 = 3;

// 테이블 ID
var SOURCE_TABLE_ID   = "source_table";
var TARGET_TABLE_ID = "target_table";

// 체크박스
var CHECK_SOURCE_UNCHECKED =  "<input name='LOAD_ADDRESS_EMAIL' id='LOAD_ADDRESS_EMAIL' type='checkbox'>";
var CHECK_SOURCE_CHECKED 		=  "<input name='LOAD_ADDRESS_EMAIL' id='LOAD_ADDRESS_EMAIL' type='checkbox' checked>";
var CHECK_TARGET_UNCHECKED =  "<input name='ADDRESS_EMAIL' id='ADDRESS_EMAIL' type='checkbox'>";
var CHECK_TARGET_CHECKED 		=  "<input name='ADDRESS_EMAIL' id='ADDRESS_EMAIL' type='checkbox' checked>";

var addr_type = TYPE_EXPRESS;
var sourceTable, targetTable;
var sortImport, sortSelect;

function addressAxInit(){
	sourceTable = document.getElementById(SOURCE_TABLE_ID);
	targetTable = document.getElementById(TARGET_TABLE_ID);
	updateSourceTitle(0);
	updateTargetTitle(0);
//		removeAddressList(true, true, sourceTable);
//		removeAddressList(true, true, sourceTable);
//		createHeader(sourceTable, null);
//		createHeader(targetTable, null);
}

// AX 작성
function writeAddressSync()
{
		var arrScript = new Array();
		arrScript.push(" <object id='AddressSync' name='AddressSync'                                    ");
		arrScript.push("  classid='clsid:6B8EE170-C3A0-4F9A-BFC1-3E8FF3BDC492'  	                      ");
		arrScript.push("  style='height:0px; width:0px;'                    	                        	");
		arrScript.push("  codebase = '/activeX/kor/AddressSync.cab#version=1,0,0,1' > 	                          	");
		arrScript.push(" </object>                                                                      ");

		document.writeln(arrScript.join(""));
}

// Ax 주소록 요청
function callGetAddress(type){
	if(AddressSync.GetAddressList(type)){
		if(type == TYPE_EXPRESS || type == TYPE_OUTLOOK) {
			displayLoading(true);
		}
	}
}

// Ax 주소록 추가
function callAddAddress(data){
	return AddressSync.AddAddress(data);
}

// Ax 주소록 리스트  추가
function callSaveAddressList(){
	if(AddressSync.SaveAddressList(addr_type))
		displayLoading(true);
}

// 헤더 생성
function createHeader(table, type){
	var headers = new Array("", "이름", "메일주소", "주소(집)", "구/군/시(집)", "우편 번호(집)",
													    "시/도(집)", "국가(집)", "집 전화", "주소(회사)", "구/군/시(회사)",
													    "우편 번호(회사)", "시/도(회사)", "국가(회사)", "회사 전화", "회사", "직함");
	var formName = 'document.f';
	var fieldName = "";

	if (table.id == SOURCE_TABLE_ID) {
		fieldName = "LOAD_ADDRESS_EMAIL";
	} else if (table.id == TARGET_TABLE_ID) {
		fieldName = "ADDRESS_EMAIL";
	}

	var count = (type==TYPE_CSV)?headers.length:3;
	var row = table.insertRow();
	var cols = new Array();

	for(var i=0; i<count; i++){
		cols[i] = document.createElement("tr");
		switch(i){
			case 0:
				cols[i].setAttribute("id", "head_sel");
				cols[i].className = "nosort";
		 		cols[i].innerHTML = "<img src=\"/images_std/kor/bullet/select_arrow06.gif\" onclick=\"checkAll(" + formName + ",'" + fieldName + "')\">";
				break;
			case 1: cols[i].setAttribute("id", "head_name");	break;
			case 2: cols[i].setAttribute("id", "head_mail");	break;
			default:cols[i].setAttribute("id", "head_default");break;
		}
		if(i > 0)
				cols[i].innerHTML = "<img>" + headers[i];
		row.appendChild(cols[i]);

	} // for
}

// 주소 추가
function insertAddress(dest, data, check){
	var tableBody = dest.getElementsByTagName('tbody')[0];
	var fields = data.split(",");
	var fieldCount = fields.length;
	var dispCount = 3;
	if(fieldCount < 2) return false;
	var search = fields[0] + "," + fields[1];
	if(findAddress(dest, search)) return false;
	var col,  row = tableBody.insertRow();

	for(var i=0; i<dispCount; i++){
		col = row.insertCell();
		switch(i){
			case 0:
				col.style.textAlign = "left";
				col.style.height = "24px";
				col.setAttribute('data', data);
				if (dest.id == SOURCE_TABLE_ID) {
					col.innerHTML = check?CHECK_SOURCE_CHECKED:CHECK_SOURCE_UNCHECKED;
				} else {
					col.innerHTML = check?CHECK_TARGET_CHECKED:CHECK_TARGET_UNCHECKED;
				}
				break;
			case 1:
				col.style.textAlign = "left";
				var value = fields[0];
				col.innerHTML = (value.length)?value:"&nbsp;";
				break;
			case 2:
				col.style.valign = "top";
				var value = fields[1];
				col.innerHTML = (value.length)?value:"&nbsp;";
				break;
		}
	} // for

	//insertRowLine(tableBody);
	return true;
}

function insertRowLine(tableBody) {
	var col,  row = tableBody.insertRow();
	col = row.insertCell();
	col.colSpan = 3;

	col.style.height = "1px";
	col.style.backgroundColor = "#DDD";
}

// 주소 찾기
function findAddress(table, data){
	var tableBody = table.getElementsByTagName('tbody')[0];
	var tableRows = tableBody.rows;
	var count = tableRows.length;
	for(var i=3; i<count; i+=2){
		var tableCell = tableRows[i].cells[0];
		var checkData = tableCell.data;
		var fields = checkData.split(",");
		if(fields.length < 2) continue;
		var check = fields[0] + "," + fields[1];
		if(check == data)
			return true;
  	}

  	return false;
}

// 리스트 삭제
function removeAddressList(head, all, table){
	var checkObjName = "";
	if (table.id == SOURCE_TABLE_ID) {
		checkObjName = "LOAD_ADDRESS_EMAIL";
	} else {
		checkObjName = "ADDRESS_EMAIL";
	}

	if (!all && !isCheckedCheckBox(document.getElementsByName(checkObjName))) {
		alert("제거할 주소를 선택하세요.");
		return;
	}

	var tableBody = table.getElementsByTagName('tbody')[0];
	var tableRows = tableBody.rows;
	var count = tableRows.length;
//	for(var i=count; i>3; i-=2){
//		var tableCell = tableRows[i-2].cells[0];
//		var html = tableCell.innerHTML;
//		var chkObj = tableCell.getElementsByTagName('input');
//		var check = (chkObj[0].checked)?true:false;
//	  	if(all == true || check == true) {
//	  		tableRows[i-1].removeNode(true);
//	 		tableRows[i-2].removeNode(true);
//	  	}
//	}
	for(var i=count ; i>1 ; i--){
		var tableCell = tableRows[i-1].cells[0];
		
		var chkObj = tableCell.getElementsByTagName('input');
		var check = (chkObj[0].checked)?true:false;
		if(all == true || check == true) {
	  		tableCell.parentNode.removeNode(true);
	  	}
	}
	updateTargetTitle((targetTable.getElementsByTagName('tbody')[0].rows.length-1));
}

// 리스트 이동
function moveAddressList(all, src, dest, del){
	var tableBody = src.getElementsByTagName('tbody')[0];
	var tableRows = tableBody.rows;
	var count = tableRows.length;
	for(var i=count; i>1; i--){
		var tableCell = tableRows[i-1].cells[0];
		var data = tableCell.data;
		var html = tableCell.innerHTML;
	 	var check = (html.toLowerCase().indexOf('checked') != -1)?true:false;
		if(all == true || check == true){
			tableCell.innerHTML =  CHECK_SOURCE_CHECKED;
			insertAddress(dest, data/*, check*/);
	  	if(del)
	  		tableRows[i-1].removeNode(true);
		}
  }
	sortAddressList();
}

// 리스트 정렬
function sortAddressList(id){
	if(id){
		if(id == SOURCE_TABLE_ID){
			sortImport = new TableSorter.sorter("sortImport");
			sortImport.init(SOURCE_TABLE_ID, 1);
		}else{
			sortSelect = new TableSorter.sorter("sortSelect");
			sortSelect.init(TARGET_TABLE_ID, 1);
		}
	}else{
		sortImport = new TableSorter.sorter("sortImport");
		sortImport.init(SOURCE_TABLE_ID, 1);
		sortSelect = new TableSorter.sorter("sortSelect");
		sortSelect.init(TARGET_TABLE_ID, 1);
	}
}

// 가져오기
function importAddress(){
	if (!isCheckedCheckBox(document.getElementsByName('LOAD_ADDRESS_EMAIL'))) {
		alert("추가할 주소를 선택하세요.");
		return;
	}

	var tableBody = sourceTable.getElementsByTagName('tbody')[0];
	var tableRows = tableBody.rows;
	var count = tableRows.length;
	var params = "", first = true;

	for(var i=1; i<(count); i++) {
		var tableCell = tableRows[i].cells[0];
		var data = tableCell.data;
		var chkObj = tableCell.getElementsByTagName('input');
		var check = (chkObj[0].checked)?true:false;
		if(!check) {continue;}
		tableCell.innerHTML = CHECK_SOURCE_UNCHECKED;
		insertAddress(targetTable, data);
  	}

  	updateTargetTitle((targetTable.getElementsByTagName('tbody')[0].rows.length-1));
}

// 내보내기
function exportAddress(){
	if (!isCheckedCheckBox(document.getElementsByName('ADDRESS_EMAIL'))) {
		alert("제거할 주소를 선택하세요.");
		return;
	}

	var tableBody = targetTable.getElementsByTagName('tbody')[0];
	var tableRows = tableBody.rows;
	var count = tableRows.length;
	var first = true;
	var params = new Array();

	for(var i=count; i>1; i--){
		var tableCell = tableRows[i-1].cells[0];
		var data = tableCell.data;
		var html = tableCell.innerHTML;
		var check = (html.toLowerCase().indexOf('checked') != -1)?true:false;
		if(!check)
			continue;
		tableCell.innerHTML = CHECK_SOURCE_CHECKED;
		if(insertAddress(sourceTable, data)){
			params.push(data);
		}
  	}
}

// 로컬 타이틀 갱신
function updateSourceTitle(cnt){
	var title = document.getElementById("source_address_title");
	var name = "<strong>";
	switch(addr_type){
		case TYPE_EXPRESS: name+="익스프레스 주소록"; break;
		case TYPE_OUTLOOK: name+="아웃룩 주소록"; break;
		case TYPE_CSV: name+="CSV파일(엑셀)"; break;
	}
	name += "</strong>";

	title.innerHTML = name + " : " + cnt + "개";
}

// 원격 타이틀 갱신
function updateTargetTitle(cnt){
	var title = document.getElementById("target_address_title");
	var name = "<strong>추가할 주소</strong>";
	if(cnt == 0)
		title.innerHTML = name;
	else
		title.innerHTML = name + " : " + cnt + "개";
}

function displayLoading(show){
	var display = "none";
	if(show) display = "block";
	try{
		document.getElementById("address_ax_loading").style.display = display;
	}catch(e){alert(e)}
}

function addressCheckAll(table){
  	var tableBody = table.getElementsByTagName('tbody')[0];
	var tableRows = tableBody.rows;
	var count = tableRows.length;
	var check, uncheck;
	if (table.id == SOURCE_TABLE_ID) {
		check = CHECK_SOURCE_CHECKED;
		uncheck = CHECK_SOURCE_UNCHECKED;
	} else {
		check = CHECK_TARGET_CHECKED;
		uncheck = CHECK_TARGET_UNCHECKED;
	}

	for(var i=1; i<count; i++){
  		var tableCell = tableRows[i].cells[0];
		var html = tableCell.innerHTML;
		//alert(html)
  		if(html.toLowerCase().indexOf('checked') == -1) {
  			html = check;
  		} else {
  			html = uncheck;
  		}
  		tableCell.innerHTML = html;
	}
 }

function registAddressAx() {
	var objForm = document.f;
	if (document.getElementsByName("ADDRESS_EMAIL").length == 0) {
		alert("추가할 주소가 없습니다.");
		return;
	}

	if (!confirm("주소록에 추가 하시겠습니까?")) {
		return;
	}

	var address_email = new Array();
	var address_name = new Array();
	var tableBody = targetTable.getElementsByTagName('tbody')[0];
	var tableRows = tableBody.rows;
	var count = tableRows.length;

//	for(var i=(count-1); i>3; i-=2) {
//		var tableCell = tableRows[i-1].cells[0];
//		var data = tableCell.data;
//		var fields = data.split(",");
//		if(fields.length < 2) continue;
//		address_name.push(fields[0]);
//		address_email.push(fields[1])
//  	}
	
  	for(var i=count ; i>1 ; i--){
		var tableCell = tableRows[i-1].cells[0];
		var data = tableCell.data;
		var fields = data.split(",");
		if(fields.length < 2) continue;

		address_name.push(fields[0]);
		address_email.push(fields[1])
	}
	
	Ext.Ajax.request({
		scope :this,
		url: 'address.auth.do',
		method: 'POST',
		params: {
			method: 'aj_regist_by_outlook',
			GROUP_IDX: objForm.GROUP_IDX.value,
			ADDRESS_NAME: address_name,
			ADDRESS_EMAIL: address_email
		},
		success : function(response, options) {
  		var reader = new Ext.data.XmlReader({
  		   	record: 'RESPONSE'
  			},
  			['RESULT','MESSAGE']);
	  		var resultXML = reader.read(response);
	  		if (resultXML.records[0].data.RESULT == "success") {
	  			removeAddressList(true, true, targetTable);
	  			try{
	  				opener.reloadPanel();
	  			}catch(e){}
	  			//self.close();
	  		}else{
	  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
	  		}
		},
		failure : function(response, options) {
			callAjaxFailure(response, options);
		}
	});
}