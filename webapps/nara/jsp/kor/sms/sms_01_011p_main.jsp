<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page
	import="java.util.*, address.AddressEntity, address.AddressGroupEntity"%>
<jsp:useBean id="cmd" class="java.lang.String" scope="request" />
<jsp:useBean id="vec1" class="java.util.Vector" scope="request" />

<jsp:useBean id="users_idx" class="java.lang.String" scope="request" />
<jsp:useBean id="ADDRESS_GROUP_IDX" class="java.lang.String"
	scope="request" />
<% 
    String target="/nara/servlet/sms.SmsServ"; 
    String img_path = "/nara/img/kor/sms";
%>
<html>
<head>
<title>주소록</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type="text/css">
<!--
BODY {
	scrollbar-face-color: #eeeeee;
	scrollbar-shadow-color: #cccccc;
	scrollbar-highlight-color: #FFFFFF;
	scrollbar-3dlight-color: #fafafa;
	scrollbar-darkshadow-color: #ccccccF;
	scrollbar-track-color: #ffffff;
	scrollbar-arrow-color: #666666
}

body,td,input,div,form,textarea,center,pre,blockquote,select,option {
	font-size: 9pt;
	font-family: 돋움;
	color: 555555;
	line-height: 140%
}

A:link {
	color: 666666;
	text-decoration: none;
}

A:visited {
	color: 666666;
	text-decoration: none;
}

A:active {
	color: 666666;
	text-decoration: none;
}

A:hover {
	color: 333333;
	text-decoration: none;
}

.boxline {
	BORDER-RIGHT: #d0d0d0 1px solid;
	BORDER-TOP: #d0d0d0 1px solid;
	BORDER-LEFT: #d0d0d0 1px solid;
	CURSOR: text;
	BORDER-BOTTOM: #d0d0d0 1px solid;
	font-size: 8pt;
	color: #D4D0C8;
}

.style1 {
	color: #838378
}

.boxline1 {
	BORDER-RIGHT: #d0d0d0 1px solid;
	BORDER-TOP: #d0d0d0 1px solid;
	BORDER-LEFT: #d0d0d0 1px solid;
	CURSOR: text;
	BORDER-BOTTOM: #d0d0d0 1px solid;
	font-size: 8pt;
	color: #888888;
}
-->
</style>
<SCRIPT LANGUAGE=JavaScript src=../js/kor/sms/sms.js></SCRIPT>
<script language="JavaScript"> 
<!-- 
function bluring(){ 
if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus(); 
} 
document.onfocusin=bluring; 

function getStrKey(args)
{    
    var groupid = document.all.group_address.value;
    parent.below.location.href="<%=target%>?cmd=sms_01_011p_below&strKey="+args+"&ADDRESS_GROUP_IDX="+groupid;
    document.form.strKeyword.value = "";
    /*document.form.strKey.value = args;
    document.form.ADDRESS_GROUP_IDX.value = "0";
    document.form.strKeyword.value = "";
    document.form.strIndex.value = "";
    document.form.target = "below";
    parent.frames['below'].document.belowform.strKey.value=args; 
    parent.frames['below'].document.belowform.strKeyword.value="";
    parent.frames['below'].document.belowform.strIndex.value="";
    parent.frames['below'].document.belowform.ADDRESS_GROUP_IDX.value="0";    
    document.form.action="<%=target%>?cmd=sms_01_011p_below";
    document.form.submit();*/
    
}

function go_group()
{
    var groupid = document.all.group_address.value;    
    if(groupid == "") 
		return;
    
    parent.below.location.href="<%=target%>?cmd=sms_01_011p_below&ADDRESS_GROUP_IDX="+groupid;
    
    /*document.form.strKeyword.value = "";    
    document.form.strIndex.value = "";
    document.form.target = "below";    
    parent.frames['below'].document.belowform.ADDRESS_GROUP_IDX.value=groupid;    
    document.form.ADDRESS_GROUP_IDX.value = groupid;
    document.form.action="<%=target%>?cmd=sms_01_011p_below";
    document.form.submit();*/
}

function js_text_search()
{    

    if(document.form.strKeyword.value == '')
    {
        alert('검색어를 입력하세요');
        return;
    }
    
    document.form.strIndex.value="ADDRESS_NAME";
    //document.form.strKey.value = "";
    document.form.target = "below";
    //parent.frames['below'].document.belowform.strKey.value="";
    parent.frames['below'].document.belowform.strKeyword.value=document.form.strKeyword.value;
    document.form.action="<%=target%>?cmd=sms_01_011p_below";
    document.form.submit();
}

function js_locaion(args)
{
    top.document.location.href = args;
}



function pers_add(where)
{
    var opt;
	
	var el_sel = document.all.select_address;
	
	var el_tot = document.all.person_address;
	
	if ( !el_tot )
	{
		 alert("주소록을 가지고 오는 중입니다..잠시만 기다려주세요.");
	}
	else
	{	
		for (var i=0;i< el_tot.length; i++)
		{
			if (el_tot.options[i].selected == true && el_tot.options[i].value!="")
			{			
				tmp = el_tot.options[i].value;
				check_email = tmp.substring(tmp.length-6);
			
				/*if( check_email == "[none]" ) 
				{
					alert(tmp + " 는 메일 주소가 없습니다.");
					return;
				}*/
				for(var j = 0; j < el_sel.options.length; j++)
				{
					if(el_sel.options[j].value == el_tot.options[i].value)
					{
						alert("이미 선택하셨습니다.");
						return;
					}
				}
				
				var valid_number;	
				if(checkMobileNumber(el_tot.options[i].value) != 'none')
				    valid_number = checkMobileNumber(el_tot.options[i].value);				 
				else
				{
				    alert("유효하지 않은 핸드폰 번호가 포함 되어 있습니다!\n["+el_tot.options[i].text+"]");
				    continue;
				}  
				
				opt = document.createElement("Option");
				opt.text = el_tot.options[i].text;
				opt.value = valid_number;
				el_sel.options.add(opt);
			}
		}
  	}
}

function add(where)
{
    var opt;
	
	var el_sel = document.all.select_address;
	
	var el_tot = document.all.group_address;
	for (var i=0;i< el_tot.length; i++)
	{
		if (el_tot.options[i].selected == true && el_tot.options[i].value!="")
		{
			for(var j = 0; j < el_sel.options.length; j++)
			{
			    //alert(el_sel.options[j].value);
			    //alert(el_tot.options[i].value);
				if(el_sel.options[j].value == "@|"+el_tot.options[i].value)
				{
					alert("이미 선택하셨습니다.");
					return;
				}
			}
				
			opt = document.createElement("Option");
			opt.text= "[그룹]"+el_tot.options[i].text;
			opt.value= "@|"+el_tot.options[i].value;
			el_sel.options.add(opt);
		}
	}
}

function del(from)
{
    var el_sel = document.all.select_address;
	
	for (var i=0;i< el_sel.length; i++)
	{
		if (el_sel.options[i].selected == true && el_sel.options[i].value!="")
		{
			el_sel.options[i] = null;
			i--;
		}
	}
}

function js_insert()
{   
    var strtmp;
	var el_sel;
	
	el_sel = document.all.select_address;
	if(el_sel.length == 1)
	{
	    alert('받는 분을 입력하셔야 합니다.');
	    return;
	}
	
	/*strtmp = "";
	for (var i=0; i < el_sel.length; i++ ) 
	{
		if (el_sel.options[i].value!="") 
		{
			if (strtmp=="")
			{
				strtmp = el_sel.options[i].value;
			}
			else
			{
				strtmp += "," + el_sel.options[i].value;
			}
		}
	}
    
    document.form2.strArray.value = strtmp;    
    document.form2.submit();    */
    
    var src_sel = el_sel;
    var target_sel = parent.opener.window.document.f.receiveHp;
    var opt1;
    
    for(var i=1; i <src_sel.length; i++)
    {
        opt1 = document.createElement("Option");    
        opt1.text = src_sel.options[i].text;
        opt1.value = src_sel.options[i].value;
        //alert(opt1.value);
        parent.opener.window.insertOption(target_sel, opt1.text, opt1.value);        
    }
    parent.opener.window.setReceiveCount(); 
    parent.window.close();
    
}

// --> 
</script>
<style type="text/css">
<!--
body {
	background-color: #ddddd3;
}
-->
</style>
</head>

<body>
<form name=form method="post" action="javascript:js_text_search();">
<INPUT TYPE=hidden NAME='ADDRESS_GROUP_IDX'
	value="<%=ADDRESS_GROUP_IDX%>"> <INPUT TYPE=hidden
	NAME='strIndex' value="">
<table width="500" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="500" border="0" cellspacing="0" cellpadding="0">
			<div align="center">
			<tr>
				<td background="../image/kor/pop_addr_02.gif"><img
					src="../image/kor/pop_addr_00.gif" width="21" height="81"></td>
				<td valign="top" background="../image/kor/pop_mail_mess_err_02.gif"
					bgcolor="#FFFFFF">
				<table width="100%" height="81" border="0" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="97"><img src="../image/kor/pop_addr_01.gif"
							width="97" height="81"></td>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="31">&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;<font color="#FFFFFF">주<strong><font
									color="#6CD0DF">ㅣ</font></strong>소<strong><font color="#6CD0DF">ㅣ</font></strong>록</font>
								</td>
							</tr>
							<tr>
								<td height="30"><img src="../image/kor/pop_def_textimg.gif"
									width="160" height="30"></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<td align="right" background="../image/kor/pop_addr_03.gif"><img
					src="../image/kor/pop_mail_mess_err_03.gif" width="21" height="81"></td>
			</tr>
			</div>
			<tr>
				<td width="21" background="../image/kor/pop_addr_02.gif">&nbsp;</td>
				<td width="458" valign="top" bgcolor="#FFFFFF">
				<table width="458" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="../image/kor/pop_addr_icon_00.gif" width="35"
							height="25" align="absmiddle"> <input name='strKeyword'
							value='' type="text" class="boxline" id="검색" size="20"> <input
							type=image src="../image/kor/pop_addr_butt_search.gif" width="56"
							height="20" border="0" align="absmiddle"></td>
					</tr>
					<tr>
						<td height="10" valign="top"><img
							src="../image/kor/pop_addr_dotline_450.gif" width="450"
							height="5"></td>
					</tr>
					<tr>
						<td height="23" background="../image/kor/pop_addr_title_line.gif">
						<table width="458" height="23" border="0" cellpadding="0"
							cellspacing="0">
							<tr>
								<td width="452"><!--a href="javascript:js_locaion('<%=target%>?cmd=sms_01_010p');"><img src="../image/kor/pop_addr_indivi_title_a.gif" width="35" height="19" border="0"></a-->
								<!--a href="javascript:js_locaion('<%=target%>?cmd=sms_01_011p');"><img src="../image/kor/pop_addr_group_title_b.gif" width="35" height="19" border="0"></a-->
								</td>
								<td width="10" bgcolor="#FFFFFF">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="20" background="../image/kor/pop_addr_person_bg.gif">
						<table width="458" height="20" border="0" cellpadding="0"
							cellspacing="0">
							<tr>
								<td width="448"><img src="../image/kor/pop_addr_person.gif"
									width="358" height="20" border="0" usemap="#Map"></td>
								<td width="10" bgcolor="#FFFFFF">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td><img src="../image/kor/blank.gif" width="147" height="2"></td>
					</tr>
					<tr>
						<td>
						<table width="458" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td width="219" height="23" valign="top">
								<table width="219" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="center" bgcolor="#EEEEE9"><img
											src="../image/kor/blank.gif" width="5" height="5"></td>
									</tr>
									<tr>
										<td align="center" bgcolor="#EEEEE9"><select
											name="group_address" multiple class="boxline1"
											style="width: 200; height: 120; font-size: 8pt;"
											onChange="javascript:go_group();">
											<option>-------------- 선택 --------------</option>
											<option value='0'>그룹없음</option>
											<%
    for(int idx=0; idx<vec1.size(); idx++)
    {
        AddressGroupEntity item1 = (AddressGroupEntity) vec1.elementAt(idx);
%>
											<option value='<%=item1.ADDRESS_GROUP_IDX%>'><%=item1.ADDRESS_GROUP_STMT%></option>
											<%
    }
%>
										</select><br>
										<img src="../image/kor/blank.gif" width="147" height="10"><br>
										<select name="person_address" multiple class="boxline1"
											style="width: 200; height: 120; font-size: 8pt;">
											<option>-------------- 선택 --------------</option>
										</select></td>
									</tr>
									<tr>
										<td><img src="../image/kor/pop_addr_table_line_219.gif"
											width="219" height="7"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td><img src="../image/kor/blank.gif" width="147"
											height="3"></td>
									</tr>
									<tr>
										<td>&nbsp;<img src="../image/kor/pop_bullet_00.gif"
											width="5" height="5" align="absmiddle"> <span
											class="style1">[Shift], [Ctrl]키로 복수 선택 가능</span></td>
									</tr>
								</table>
								</td>
								<td width="20" align="center" valign="top">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td height="70" valign="bottom">
										<table width="20" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td align="center"><a
													href="javascript:add('select_address');"><img
													src="../image/kor/pop_addr_butt_add_r.gif" width="14"
													height="13" border=0></a></td>
											</tr>
											<tr>
												<td align="center"><img src="../image/kor/blank.gif"
													width="6" height="3"></td>
											</tr>
											<tr>
												<td align="center"><a
													href="javascript:del('select_address');"><img
													src="../image/kor/pop_addr_butt_add_l.gif" width="14"
													height="13" border=0></a></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td height="150" valign="bottom">
										<table width="20" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td align="center"><a
													href="javascript:pers_add('select_address');"><img
													src="../image/kor/pop_addr_butt_add_r.gif" width="14"
													height="13" border=0></a></td>
											</tr>
											<tr>
												<td align="center"><img src="../image/kor/blank.gif"
													width="6" height="3"></td>
											</tr>
											<tr>
												<td align="center"><a
													href="javascript:del('select_address');"><img
													src="../image/kor/pop_addr_butt_add_l.gif" width="14"
													height="13" border=0></a></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
								<td width="219" height="23" valign="top">
								<table width="213" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="center" bgcolor="#EEEEE9"><img
											src="../image/kor/blank.gif" width="5" height="5"></td>
									</tr>
									<tr>
										<td align="center" bgcolor="#EEEEE9"><select
											name="select_address" multiple class="boxline1"
											style="width: 200; height: 250; font-size: 8pt;">
											<option>-------------- 선택 --------------</option>
										</select></td>
									</tr>
									<tr>
										<td><img src="../image/kor/pop_addr_table_line_213.gif"
											width="213" height="7"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td><img src="../image/kor/blank.gif" width="147"
											height="3"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="15"><img
							src="../image/kor/pop_addr_dotline_450.gif" width="450"
							height="5"></td>
					</tr>
					<tr>
						<td align="center"><a href="javascript:js_insert();"><img
							src="../image/kor/pop_addr_butt_ok.gif" width="58" height="22"
							border="0"></a> <a
							href="javascript:parent.window.self.close();"><img
							src="../image/kor/pop_addr_butt_cancel.gif" width="58"
							height="22" border="0"></a></td>
					</tr>
				</table>
				</td>
				<td width="21" background="../image/kor/pop_mail_mess_err_05.gif">&nbsp;</td>
			</tr>
			<tr>
				<td background="../image/kor/pop_addr_02.gif"><img
					src="../image/kor/pop_mail_mess_err_06.gif" width="21" height="19"></td>
				<td valign="top" background="../image/kor/pop_mail_mess_err_07.gif">&nbsp;</td>
				<td align="right" background="../image/kor/pop_addr_03.gif"><img
					src="../image/kor/pop_mail_mess_err_08.gif" width="21" height="19"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
<map name="Map">
	<area shape="rect" coords="3,2,20,17"
		href="javascript:getStrKey('all');" id="ad_00">
	<area shape="rect" coords="37,2,47,17"
		href="javascript:getStrKey('ㄱ');" id="ad_01">
	<area shape="rect" coords="50,2,58,17"
		href="javascript:getStrKey('ㄴ');" id="ad_02">
	<area shape="rect" coords="59,2,67,17"
		href="javascript:getStrKey('ㄷ');" id="ad_03">
	<area shape="rect" coords="70,2,79,17"
		href="javascript:getStrKey('ㄹ');" id="ad_04">
	<area shape="rect" coords="81,2,90,17"
		href="javascript:getStrKey('ㅁ');" id="ad_05">
	<area shape="rect" coords="93,2,101,17"
		href="javascript:getStrKey('ㅂ');" id="ad_06">
	<area shape="rect" coords="103,2,112,17"
		href="javascript:getStrKey('ㅅ');" id="ad_07">
	<area shape="rect" coords="115,2,123,17"
		href="javascript:getStrKey('ㅇ');" id="ad_08">
	<area shape="rect" coords="126,2,135,17"
		href="javascript:getStrKey('ㅈ');" id="ad_09">
	<area shape="rect" coords="136,2,145,17"
		href="javascript:getStrKey('ㅊ');" id="ad_10">
	<area shape="rect" coords="147,2,156,17"
		href="javascript:getStrKey('ㅋ');" id="ad_11">
	<area shape="rect" coords="158,2,166,17"
		href="javascript:getStrKey('ㅌ');" id="ad_12">
	<area shape="rect" coords="168,2,177,17"
		href="javascript:getStrKey('ㅍ');" id="ad_13">
	<area shape="rect" coords="179,2,189,17"
		href="javascript:getStrKey('ㅎ');" id="ad_14">
	<area shape="rect" coords="207,2,232,17"
		href="javascript:getStrKey('a');" id="ad_15">
	<area shape="rect" coords="238,2,260,17"
		href="javascript:getStrKey('f');" id="ad_16">
	<area shape="rect" coords="267,2,290,17"
		href="javascript:getStrKey('k');" id="ad_17">
	<area shape="rect" coords="294,2,318,17"
		href="javascript:getStrKey('p');" id="ad_18">
	<area shape="rect" coords="325,2,350,17"
		href="javascript:getStrKey('u');" id="ad_19">
</map>
<!--form name=form2 method=post action="<%=target%>?cmd=sms_group_below" target="below">
<input type=hidden name=strArray value=''>
</form-->
</body>
</html>
