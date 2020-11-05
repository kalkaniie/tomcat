<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.jdf.db.entity.MemoEntity"%>
<%@page import="com.nara.springframework.service.MemoService"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.nara.springframework.service.UserTagService"%>
<%@page import="com.nara.jdf.db.entity.UserTagEntity"%>
<%@page import="com.nara.springframework.service.WebMailService"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<% UserEntity userEntity  = UserSession.getUserInfo(request); %>
<SCRIPT LANGUAGE=JavaScript>
var USERS_LISTNUM = <%=userEntity.USERS_LISTNUM%>;
</script>


<link rel="stylesheet" type="text/css"
	href="/js/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css"
	href="/js/ext/examples/examples.css" />
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" src="/js/ext/examples/examples.js"></script>
<script type="text/javascript"
	src="/js/ext/src/locale/ext-lang-ko.js"></script>

<script type="text/javascript" src="/js/kor/search/search.js"></script>
<SCRIPT LANGUAGE=JavaScript>
<%--
<!--
function memo_write_form(){
	var objForm = document.memo_form;
	document.memo_form.MEMO_CONTENT.value='';
	objForm.MEMO_COLOR.value = "1";
	onoff('mlAccOn_memo');
}

function memo_insert(str){
	var objForm = document.memo_form;
	if(objForm.MEMO_CONTENT.value.length <= 0 ){
		alert("메모 내용을 입력하세요");
	    objForm.MEMO_CONTENT.focus();
	    return;
	}else if(objForm.MEMO_CONTENT.value.length >1000){
	  	alert("메모 내용은 1000자 이내입니다");
	    objForm.MEMO_CONTENT.focus();
	    return;
	}
	
	if(str="save")		objForm.DIPLAY_YN.value="0";
	else				objForm.DIPLAY_YN.value="1";
		
	Ext.Ajax.request({
			url: 'memo.auth.do?method=aj_memo_write',
			params: { MEMO_COLOR: objForm.MEMO_COLOR.value, DIPLAY_YN:0 , MEMO_CONTENT:  objForm.MEMO_CONTENT.value},
			success : function(response, options) {
				
			},
			failure : function(response, options) {
			
			},
			callback: function (options, success, response) {
				
			}
	});
	
	mlAccOn_memo.style.display='none';
	
 }	

function changeStyle(str){
	var objForm = document.memo_form;
	var basic_dir ="/images/postit/";
	var org_str = str ;
	
	document.getElementById("postitColor").style.display='none';
	
	document.getElementById("mlAccOn_memo").className ="accOn_memo"+str;
	document.getElementById("c_11").src = basic_dir + "memo_postit" +str+ "-11.gif";
	document.getElementById("c_13").src = basic_dir + "memo_postit" +str+ "-13.gif";
	//document.getElementById("c_14").src = basic_dir + "memo_postit" +str+ "-14.gif";
	document.getElementById("c_15").src = basic_dir + "memo_postit" +str+ "-15.gif";
	document.getElementById("c_25").src = basic_dir + "memo_postit" +str+ "-25.gif";
	document.getElementById("c_20").src = basic_dir + "memo_postit" +str+ "-20.gif";
	document.getElementById("c_25").src = basic_dir + "memo_postit" +str+ "-25.gif";
	
	//var color_arr = new Array("#fff8bb","#ffdfdf","#e2e4ff","#caecfa","#dbffb2","#f5ffc7","#f9f9f9","#edefff","#e7fff1","#fff8bb");
	objForm.MEMO_COLOR.value = org_str; //color_arr[org_str-1];
	
}	
function updateDisplay(idx,str){
	
	var queryString = "method=aj_memo_update&uptColoum=Y&DIPLAY_YN=1&MEMO_IDX=" + idx;
	CallSimpleAjax("memo.auth.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		return ;
	}
	
	str.parentNode.style.display='none';
}	

function view_memo(memoIdx,obj){
	var queryString = "method=aj_memo_view&MEMO_IDX=" + memoIdx;
	CallSimpleAjax("memo.auth.do", queryString);
	if (ajax_code != 200) {
		alert(ajax_message);
		return ;
	}

	var xmlDoc = createXMLFromString(ajax_message);
	var result = xmlDoc.getElementsByTagName("memo") ;
	
	
	var memoid =result.item(0).getElementsByTagName("memoid").item(0).firstChild.nodeValue;
	var memocolor =result.item(0).getElementsByTagName("memocolor").item(0).firstChild.nodeValue;
	var memocontent =result.item(0).getElementsByTagName("memocontent").item(0).firstChild.nodeValue;
	var memodisplay =result.item(0).getElementsByTagName("memodisplay").item(0).firstChild.nodeValue;
	var updatedate =result.item(0).getElementsByTagName("updatedate").item(0).firstChild.nodeValue;
	
	
	document.getElementById("mlAccOn_memo").className ="accOn_memo"+memoIdx;
	document.memo_form.MEMO_CONTENT.value=memocontent;
	document.memo_form.MEMO_IDX.value=memoid;
	onoff('mlAccOn_memo');
	changeStyle(memocolor);
}	
--%>
var searchType ="";
var thisOrPop ="this";

function search_fn(){
	var inVal = document.header_search_form.strIndex.value;
	if( inVal !="bbs" ) searchType = "mail"; else searchType= inVal;
	
	if( document.header_search_form.strKeyword.value ==""){
		alert("검색어를 입력하여 주십시요");
		document.header_search_form.strKeyword.focus();
		return;
	}
	thisOrPop ="pop";
	openSearchPanel();
}

function viewSearch(){
	thisOrPop ="this";
	openSearchPanel();
}

function openSearchPanel(){
	var searchPanel = new Ext.Panel({
        html:'',
        width:350,
        height:300,
        autoLoad: {
       		url: '/jsp/kor/search/search.jsp',
       		callback: setRepeatDiv
       	}	
    }); 
	
	var	searchWin = new Ext.Window({
			id:'kebi_ext_window',
			title:'검색',
			colsable:true,
			width:720,
			height:530,
			plain:true,
			layout:'fit',
			autoScroll:true,
			autoShow :true,
			autoDestroy :true,
			items : searchPanel,
			listeners:{
		    	 close:function() {
					searchMailYes = false;
					searchBbsYes = false;
			    }
		    }
				
	 });
	searchWin.show();
}

function setRepeatDiv(){
	var df1 = new Ext.form.DateField({
		id:'startdt',
		name:'startdt',
		format: 'Y-m-d',
        minValue: '01/01/06',
        vtype: 'daterange',
        endDateField: 'enddt'
	})
	
	df1.render('search_data_picker_start');
	
	var df2 =new Ext.form.DateField({
		id:'enddt',
		name:'enddt',
        format: 'Y-m-d',
        minValue: '01/01/06',
        vtype: 'daterange',
        startDateField: 'startdt'
    })
	df2.render('search_data_picker_end');
	
	document.searchFormDiv.strIndex.options[document.header_search_form.strIndex.selectedIndex].selected = true;
	document.searchFormDiv.strKeyword.value = document.header_search_form.strKeyword.value;
	
	if(document.header_search_form.strKeyword.value !=''){
		divChange(searchType);
	}
	if(thisOrPop=="pop"){
		searchFunction()
	}	
}

function getElementValue(str){
	var elementStr = eval(str);
	if( elementStr !=null && typeof elementStr !="undefined")
		return elementStr.value;
	else return "";	
}
function getElementCheckedValue(str){
	var elementStr = eval(str);
	if( elementStr !=null && typeof elementStr !="undefined")
		return elementStr.checked == true ? elementStr.value :"";
	else return "";	
}
function getElementChecked(str){
	var elementStr = eval(str);
	if( elementStr !=null && typeof elementStr !="undefined")
		if( elementStr.checked) return true;
	else return false;	
}

var searchMailYes = false;
var searchBbsYes  = false;
function searchFunction(){
	
	var objForm = document.searchFormDiv;
	var checkValue = true;
	//if(trim(objForm.strKeyword.value).length ==0 
	//	|| (objForm.startdt.value.length==0 || objForm.enddt.value.length==0)){
	//    alert("검색어 혹은 검색날짜를 입력하십시오.");
	//    return;
	//}
	
	if(thisOrPop =="pop"){
		
		if( !objForm.M_TITLE.checked &&
			!objForm.M_SENDER.checked && 
			!objForm.M_SENDERNM.checked && 
			!objForm.M_TO.checked) {
			  alert("검색 대상이 설정되지 않았습니다.  조건을 지정해주세요");
			  checkValue = false;
			  return;
		}
		
		if(	!objForm.B_TITLE.checked &&
			!objForm.B_NAME.checked && 
			!objForm.B_CONTENT.checked ) {
			  alert("검색 대상이 설정되지 않았습니다.  조건을 지정해주세요");
			  checkValue = false;
			  return;
		}
	}	
	
	if(objForm.strIndex.value !="bbs"){
		if(!searchMailYes){
			createMailStore();
			createMailGrid();
			searchMailYes = true;
		}	
		
		
		document.getElementById("search_result_div_bbs").style.display='none';
		document.getElementById("search_result_div_mail").style.display='';
		
		searchGridMail.render('search_result_div_mail');
		s_mail_store.baseParams = ({method:'aj_search_mail_list', 
						 			LISTNUM: USERS_LISTNUM,
						 			strIndex: 	getElementValue('document.searchFormDiv.strIndex'),
						 			M_TITLE:    getElementCheckedValue('document.searchFormDiv.M_TITLE'),
						 			M_SENDER:   getElementCheckedValue('document.searchFormDiv.M_SENDER'),
						 			M_SENDERNM: getElementCheckedValue('document.searchFormDiv.M_SENDERNM'),
						 			M_TO:    	getElementCheckedValue('document.searchFormDiv.M_TO'),
						 			startdt:    getElementValue('document.searchFormDiv.startdt'),
						 			enddt:    	getElementValue('document.searchFormDiv.enddt'),
						 			strKeyword: getElementValue('document.searchFormDiv.strKeyword')
						 			
		});
		
		//if( thisOrPop =="pop" && checkValue ==true){
		s_mail_store.reload({params:{start:0, limit:USERS_LISTNUM}});
		
		//}	
		searchGridMail.getView().refresh();
	}else{
		if(!searchBbsYes){
			createBbsStore();
			createBbsGrid();
			searchBbsYes = true;
		}	
		document.getElementById("search_result_div_mail").style.display='none';
		document.getElementById("search_result_div_bbs").style.display='';
		searchGridBbs.render('search_result_div_bbs');
		s_bbs_store.baseParams = ({method:'aj_get_search_board_list', 
						 			LISTNUM: USERS_LISTNUM,
						 			//strIndex: 	'b_content',
						 			B_TITLE   : getElementChecked(document.searchFormDiv.B_TITLE) ==true ? getElementValue('document.searchFormDiv.strKeyword') :"",//getElementCheckedValue('document.searchFormDiv.B_TITLE'),
						 			B_NAME    : getElementChecked(document.searchFormDiv.B_NAME) ==true ? getElementValue('document.searchFormDiv.strKeyword') :"",//getElementCheckedValue('document.searchFormDiv.B_NAME'),
						 			B_CONTENT : getElementChecked(document.searchFormDiv.B_CONTENT) ==true ? getElementValue('document.searchFormDiv.strKeyword') :"",//getElementCheckedValue('document.searchFormDiv.B_CONTENT'),
						 			startdt   : getElementValue('document.searchFormDiv.startdt'),
						 			enddt     : getElementValue('document.searchFormDiv.enddt')
						 			//strKeyword: getElementValue('document.searchFormDiv.strKeyword')
						 			//,BBS_IDX: 23
 		});
		
		s_bbs_store.reload({params:{start:0, limit:USERS_LISTNUM}});
		searchGridBbs.getView().refresh();
	}
}

function divChange(inVal){
	if(inVal=="bbs"){
		document.searchFormDiv.B_TITLE.checked = true;
		document.searchFormDiv.B_NAME.checked = true;
		document.searchFormDiv.B_CONTENT.checked = true;
		
		searchType ="bbs";
		document.getElementById("chebox_span1").style.display='none';
		document.getElementById("chebox_span2").style.display='';
	}else{
		searchType ="mail";
		document.getElementById("chebox_span1").style.display='';
		document.getElementById("chebox_span2").style.display='none';
	}
}
-->
</SCRIPT>
<div id="content">

<div id="sch"><a href="webmail.auth.do?method=mail_list"><img
	src="/images/btn/navBtn_mailRead.gif" /></a> <a
	href="webmail.auth.do?method=mail_write"><img
	src="/images/btn/navBtn_mailWrite.gif" /></a> <a
	href="webmailReConfirm.auth.do?method=confirm_list"><img
	src="/images/btn/navBtn_sendCheck.gif" /></a>
<div>
<ul>
	<form name="header_search_form">
	<li id="bsch"><span id="bt">통합검색</span> <span id="bt2"> <select
		name="strIndex">
		<option value="0">전체편지함</option>
		<%=WebMailService.getMboxbySelect(request)%>
		<option value="bbs">게시판</option>
	</select> </span> <span id="bt3"> <input name="strKeyword" type="text"
		class="intx" id="textfield" /></span> <span id="bt4"><img
		src="/images/btn/btnA_search.gif" style="cursor: hand"
		onClick="javascript:search_fn();" /></span> <span id="bt5"><img
		src="/images/btn/btnA_searchDet.gif" style="cursor: hand"
		onClick="javascript:viewSearch();" /></span></li>
	</form>
	<!--
				<li class="btype">
					<a href="#"><img src="/images/ico/column_doubleOn.gif" /></a>
					<a href="#"><img src="/images/ico/column_singleOff.gif" /></a>
				</li>
				-->
	<!--<li class="bmemo"><a href="javascript:memo_write_form()">메모작성</a></li>-->
</ul>
</div>
</div>