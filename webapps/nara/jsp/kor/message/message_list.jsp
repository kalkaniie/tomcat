<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="STYLESHEET" type="text/css" href="/css/MyWeb.css">

<script language=javascript>
<!--

function showHide(key)
{
  var div = eval("document.all.schedule_" + key);
  div.style.display = "none";
  w_size = removePX(window.screenTop);
  f_size = removePX(document.body.scrollHeight);
  c_size = removePX(event.y+document.body.scrollTop);
  l_size = removePX(document.body.scrollWidth);			
  r_size = removePX(event.x+document.body.scrollLeft);
  v_size = l_size - r_size;
  d_size = f_size - c_size;
  if(d_size < 140){
    if(v_size < 100){
      div.style.top = event.y+document.body.scrollTop ;
      div.style.left = event.x+document.body.scrollLeft-140;
    }else{
      div.style.top = event.y+document.body.scrollTop;
      div.style.left = event.x+document.body.scrollLeft+10;
    }
  }else{
    if(v_size < 100){
      div.style.top = event.y+document.body.scrollTop;
      div.style.left = event.x+document.body.scrollLeft-140;
  }else{
    div.style.top = event.y+document.body.scrollTop;
    div.style.left = event.x+document.body.scrollLeft+10;
  }
}
  
  /*if(div.style.display == ''){
    div.style.display = "none";
  }else{
    div.style.display = "";
  }*/
	div.style.display = "block";
}

function showHidden(key){
  var div = eval("document.all.schedule_" + key);
  div.style.display = "none";
}
function removePX(sStr){
	var a = ""+sStr;
	idx = a.indexOf("px");

	if(idx < 0) idx = a.indexOf("PX");
	if(idx < 0)
		idx = a.indexOf("Px");
	else
		a = a.substring(0, (a.length - 2));
	return a;
}

function makeCursorHand(obj)
{
  obj.style.cursor = "hand";
}



function mouseOnTD(seq, bool)
{
	var oTD = eval("document.all.listXP" + seq);
	var len = oTD.length;
	var borderStyle = "1 solid slategray";
	
	if (bool){
		
		oTD.style.borderLeft = borderStyle;
		oTD.style.backgroundColor = "menu";
		
	}else{
		
		oTD.style.border = "";
		oTD.style.backgroundColor = "";
	}
}
function mouseOverOnInfo(obj, bool)
{

	if (bool)
		obj.style.backgroundColor="#dddddd";
	else
		obj.style.backgroundColor="#ffffff";

}

-->
</script>

<title>통합 메시지함</title>
</head>

<body>

<div id='schedule_22334' style='display: none; position: absolute'
	onMouseOver="this.style.display='block'"
	onMouseOut="this.style.display='none'" class="skin1"
	style="border:1 solid buttonface;border:2 outset buttonhighlight;">
<table cellspacing='1' bgcolor='slategray' cellpadding='0' width='100'
	height="60">
	<tr>
		<td class=small bgcolor='#FFFFFF'>

		<table border='0' cellspacing='0' cellpadding='0' width="100%"
			height="100%">
			<tr valign='top' onselectstart="return false;" id=listXP1
				onmouseover="mouseOnTD('1',true)" onclick="DoChecking('1');"
				onmouseout="mouseOnTD('1',false)">
				<td height="30" align="center" valign="middle">대화하기</td>
			</tr>


			<tr valign='top' onselectstart="return false;" id=listXP2
				onmouseover="mouseOnTD('2',true)" onclick="DoChecking('2');"
				onmouseout="mouseOnTD('2',false)" height="30">
				<td align="center" valign="middle">쪽지보내기</td>

			</tr>
		</table>

		</td>
	</tr>
</table>
</div>



<p>&nbsp;</p>
<table width="800" border="1" cellspacing="1" cellpadding="1">





	<tr>
		<!-- <td width="100"><p>통함메시지함</p>
    <p><a href="javascript:showMenu()">전체</a></p>
    <p>대화
	  <br><br> <font onMouseOver ="javascript:makeCursorHand(this);showHide('22334')" >
				<a href='schedule.ScheduleServ?cmd=detail&SCHEDULE_IDX=22334&ORGANIZE_IDX=0&mode=3' class='css_g'>
&nbsp;&nbsp;&nbsp;조승태
</a>
</font>
  <br>

    </p>    
    <p>쪽지
		  <br><br> <font onMouseOver ="javascript:makeCursorHand(this);showHide('22334')" >
				<a href='schedule.ScheduleServ?cmd=detail&SCHEDULE_IDX=22334&ORGANIZE_IDX=0&mode=3' class='css_g'>
&nbsp;&nbsp;&nbsp;조승태
</a>
	  <br><br> <font onMouseOver ="javascript:makeCursorHand(this);showHide('22334')" >
				<a href='schedule.ScheduleServ?cmd=detail&SCHEDULE_IDX=22334&ORGANIZE_IDX=0&mode=3' class='css_g'>
&nbsp;&nbsp;&nbsp;조은호
</a>
	  <br><br> <font onMouseOver ="javascript:makeCursorHand(this);showHide('22334')" >
				<a href='schedule.ScheduleServ?cmd=detail&SCHEDULE_IDX=22334&ORGANIZE_IDX=0&mode=3' class='css_g'>
&nbsp;&nbsp;&nbsp;김이선
</a>
	  </p>
    <p >시스템 알림 </p>
	
	
</td>-->
		<td width="200" align="left" valign="top"><script
			language=javascript src="/js/kor/util/treeFunctions_1.js"
			language="JavaScript"></script> <script language='JavaScript'>

foldersTree = gFld('통합메시지함', '1' , '');
aux0 = gFld('&nbsp;<b><font color=#666666>통합메시지함</font></b>', 'webmail.WebMailBoxServ?cmd=main', 'http://localhost:8080/image/kor/main_mail_icon_tree_ad_folder.gif' , '');


insDoc(aux0, gLnk2('<div id=mt_7447>전체</div>', 'webmail.WebMailServ?cmd=mlist&MBOX_IDX=7447', '/image/kor/main_mail_icon_tree_ad_1.gif',''));

aux12982 = insFld(aux0, gFld2('<div id=mt_12982>대화</div>','webmail.WebMailServ?cmd=mlist&MBOX_IDX=12982', '/image/kor/main_mail_icon_tree_ad_6.gif',''));
insDoc(aux12982, gLnk2('<font onClick ="javascript:makeCursorHand(this);showHide(22334)" >	<a href="#" class="css_g">조승태</a></font>', 'webmail.WebMailServ?cmd=mlist&MBOX_IDX=14760', '/image/kor/logon.gif',''));
insDoc(aux12982, gLnk2('<font onClick ="javascript:makeCursorHand(this);showHide(22334)" >	<a href="#" class="css_g">조은호</a></font>', 'webmail.WebMailServ?cmd=mlist&MBOX_IDX=14760', '/image/kor/logon.gif',''));


aux12982 = insFld(aux0, gFld2('<div id=mt_12982>쪽지</div>','webmail.WebMailServ?cmd=mlist&MBOX_IDX=12982', '/image/kor/main_mail_icon_tree_ad_6.gif',''));
insDoc(aux12982, gLnk2('<font onClick="javascript:makeCursorHand(this);showHide(22334)" >	<a href="#" class="css_g">조승태</a></font>', 'webmail.WebMailServ?cmd=mlist&MBOX_IDX=14760', '/image/kor/logon.gif',''));
insDoc(aux12982, gLnk2('<font onClick="javascript:makeCursorHand(this);showHide(22334)" >	<a href="#" class="css_g">김이선</a></font>', 'webmail.WebMailServ?cmd=mlist&MBOX_IDX=14760', '/image/kor/logon.gif',''));


initializeDocument(); 
//clickOnNode(1)
</script></td>



		<td width="700">
		<form name="form1" method="post" action="">
		<table width="100%" height="600" border="1" cellpadding="1"
			cellspacing="1">
			<tr>
				<td align="left" valign="top"><input type="text"
					name="textfield"> ~ <input type="text" name="textfield2">
				<input type="text" name="textfield3"> 찾기<br>
				<br>
				<table width="100%" height="100%" border="0" align="left"
					cellpadding="1" cellspacing="1">
					<tr bgcolor="#999999">
						<td height="30">
						<div align="center" class="skin1">타입</div>
						</td>
						<td height="30">
						<div align="center">첨부[다운로드 남은 일자]</div>
						</td>
						<td height="30">
						<div align="center">대화상대</div>
						</td>
						<td height="30">
						<div align="center">내용</div>
						</td>
						<td height="30">
						<div align="center">날짜</div>
						</td>
						<td height="30">
						<div align="center">수신확인</div>
						</td>

					</tr>
					<tr bgcolor="#CCCCCC">
						<td>
						<div></font></div>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
<script language="javascript">
<!--

menuItems = new Array();
menuItemNum = 0;

function addMenuItem(text, url, img){
  if(img) menuItems[menuItemNum] = new Array(text, url, img);
  else if(text) menuItems[menuItemNum] = new Array(text, url);
  else menuItems[menuItemNum] = new Array();
  menuItemNum++;
}

menuWidth = 148; //메뉴상자의 가로크기
menuHeight = 176; //메뉴상자의 세로크기
menuDelay = 50; //상자가 열리기전 지연시간
menuSpeed = 8; //메뉴상자가 열리는 속도
menuOffset = 1; //마우스 포인터의 위치

addMenuItem("삭제","http://www.jasko.co.kr");
addMenuItem();
addMenuItem("쪽지 보내기","http://kr.yahoo.com");
addMenuItem("대화 보내기","http://www.hanmail.net");



if(window.navigator.appName == "Microsoft Internet Explorer" && window.navigator.appVersion.substring(window.navigator.appVersion.indexOf("MSIE") + 5, window.navigator.appVersion.indexOf("MSIE") + 8) >= 5.5)
  isIe = 1;
else
  isIe = 0;

if(isIe){
  menuContent = '<table id="rightMenu" width="0" height="0" cellspacing="0" cellpadding="0" style="font:menu;color:menutext;"><tr height="1"><td style="background:threedlightshadow" colspan="4"></td><td style="background:threeddarkshadow"></td></tr><tr height="1"><td style="background:threedlightshadow"></td><td style="background:threedhighlight" colspan="2"></td><td style="background:threedshadow"></td><td style="background:threeddarkshadow"></td></tr><tr height="10"><td style="background:threedlightshadow"></td><td style="background:threedhighlight"></td><td style="background:threedface"><table cellspacing="0" cellpadding="0" nowrap style="font:menu;color:menutext;cursor:default;">';
  for(m=0;m<menuItems.length;m++){
   if(menuItems[m][0] && menuItems[m][2]){
    menuContent += '<tr height="17" onMouseOver=this.style.background="highlight";this.style.color=highlighttext;onMouseOut=this.style.background="threedface";this.style.color=menutext; onClick=parent.window.location.href=' + menuItems[m][1] + '><td style="background:threedface" width="1" nowrap></td><td width="21" nowrap><img src="' + menuItems[m][2] + '"></td><td nowrap>' + menuItems[m][0] + '</td><td width="21" nowrap></td><td style="background:threedface" width="1" nowrap></td></tr>';
   }else if(menuItems[m][0]){
    menuContent += '<tr height="17" onMouseOver=this.style.background="highlight";this.style.color="highlighttext"; onMouseOut=this.style.background="threedface";this.style.color="menutext";   onClick=parent.window.location.href="' + menuItems[m][1] + '"><td style="background:threedface" width="1" nowrap></td><td width="21" nowrap><img src="/image/kor/commuity.gif" width=17 height=17></td><td nowrap>' + menuItems[m][0] + '</td><td width="21" nowrap></td><td style="background:threedface" width="1" nowrap></td></tr>';
   }else{
    menuContent += '<tr><td colspan="5" height="4"></td></tr><tr><td colspan="5"><table cellspacing="0"><tr><td width="2" height="1"></td><td width="0" height="1" style="background:threedshadow"></td><td width="2" height="1"></td></tr><tr><td width="2" height="1"></td><td width="100%" height="1" style="background:threedhighlight"></td><td width="2" height="1"></td></tr></table></td></tr><tr><td colspan="5" height="3"></td></tr>';
   }
  }
  menuContent += '</table></td><td style="background:threedshadow"></td><td style="background:threeddarkshadow"></td></tr><tr height="1"><td style="background:threedlightshadow"></td><td style="background:threedhighlight"></td><td style="background:threedface"></td><td style="background:threedshadow"></td><td style="background:threeddarkshadow"></td></tr><tr height="1"><td style="background:threedlightshadow"></td><td style="background:threedshadow" colspan="3"></td><td style="background:threeddarkshadow"></td></tr><tr height="1"><td style="background:threeddarkshadow" colspan="5"></td></tr></table>';

//document.write(menuContent);
//  menuPopup = window.createPopup();
//  menuPopup.document.body.innerHTML = menuContent;


  document.all["schedule_22334"].innerHTML = menuContent;

  //if(isIe) document.oncontextmenu = showMenu;
}
-->
</script>
