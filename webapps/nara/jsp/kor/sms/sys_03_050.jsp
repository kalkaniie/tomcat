<%@page language="java"%>
<%@page contentType="text/html;charset=utf-8"%>

<%
	String img_path = "/images/kor/sms";
	int msgLength = 80;
%>

<script type="text/javascript" src="/js/common/common.js"></script>

<script language="javascript">
<!--
function js_performTask()
{
    //if(document.frames['iframe'].f.SEQ_NO.value == 0) {
    if(document.f.FLAG_NO.value == 0) {
        alert('분류를 선택하세요');
        return false;
    } else if(document.f.TITLE.value=='') {
        alert('이모티콘 제목을 입력하세요');
        document.f.TITLE.focus();
        return false;
    } else if(document.f.CONTENT.value=='') {
        alert('이모티콘 내용을 입력하세요');
        document.f.CONTENT.focus();
        return false;
    }
    
    return true;
}

//이모티콘 등록/수정
function js_commit() {
    if(js_performTask()) {
        if(document.f.gubun.value == 'insert') {
            document.f.method.value = 'sys_03_050c';
            document.f.target="iframe";                 
        } else {
            document.f.method.value = 'sys_03_050u';  
            document.f.target="iframe";            
        }
        
        document.f.submit();  
        
        js_reset();
    }  
}

//이모티콘 입력화면 리셋
function js_reset() {
	objForm = document.f;
	var linkObj = document.getElementById("commit_link");
	linkObj.innerHTML = "<img name=\"Image1\" src=\"<%=img_path %>/btnSmsImg_entry.gif\" id=\"Image1\" />";
	
	objForm.gubun.value = "insert";
	objForm.Image1.src = "<%=img_path%>/btnSmsImg_entry.gif";
	objForm.SEQ_NO.value = "";
	objForm.TITLE.value = "";
	objForm.CONTENT.value = "";
	
	document.recalc();
}


function checklen(args)
{
    return returnChecklen(args);
}

/**
 * 문자열이 length byte를 초과하는지 체크하고,
 * 초과시 length byte까지만 세팅하고 경고문을 띄운다.
 * length byte를 초과하면 false.
 */
function returnChecklen(length)
{
    var gubun = true;
    var msgtext = document.f.CONTENT.value;
    var msglen = document.f.msglen.value;
    
    var i=0,l=0;
    var temp,lastl;
    
    //길이를 구한다.
    while(i < msgtext.length)
    {
        temp = msgtext.charAt(i);
    
        if(escape(temp).length>4) 
        {
            l+=2;
        } else if (temp!='\r') 
        {
            l++;
        }
    
        // OverFlow
        if(l>length) 
        {
            alert("메시지본문은 한글 " + (length/2) + "자, 영문 " + length +
                    "자까지만 쓰실 수 있습니다.");
            temp = document.f.CONTENT.value.substr(0,i);
            document.f.CONTENT.value = temp;
            l = lastl;
            gubun = false;
            break;
        }
        
        lastl = l;
        i++;
    }
    
    document.f.msglen.value=l;
    return gubun;
}

function addChar(ch) {   
  document.f.CONTENT.value = document.f.CONTENT.value + ch;
  checklen(<%=msgLength%>);
}
//-->
</script>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />

<form name="f" mehtod="post">
<input type=hidden name='method' value=''> 
<input type=hidden name='SEQ_NO' value=''> 
<input type=hidden name='FLAG_NO' value=''> 
<input type=hidden name='nPage' value=''> 
<input type=hidden name='gubun' value='insert'>

<div class="k_puTit">
<h2 class="k_puTit_ico2">기타관리 <strong>SMS관리</strong></h2>
<hr />
</div>
<ul class="k_tip_ul">
	<li>이모티콘을 관리하고 분류합니다.</li>
</ul>
<div class="k_puAdmin">
<ul class="k_tab_menu">
	<li class="k_tab_menuImg"><img src="/images/kor/tabmenu/admin_tabLeft.gif" /></li>
	<li><a href="sms.system.do?method=sys_03_010">전송내역관리</a></li>
	<li><a href="sms.system.do?method=sys_03_020">사용량관리</a></li>
	<li><a href="sms.system.do?method=sys_03_060">SMS기본 Quota관리</a></li>
	<li><a href="sms.system.do?method=sys_03_040">이모티콘분류관리</a></li>
	<li class="k_tab_menuOn"><b><a href="sms.system.do?method=sys_03_050">이모티콘관리</a></b></li>

</ul>
<div class="k_tab_boxTop">
<img src="/images/kor/tabmenu/admin_tabTopL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabTopR.gif" class="k_fltR" />
</div>
<div class="k_tab_boxMid">
<table width="100%" class="k_tbSms">
	<tr>
		<td width="202" class="k_tdPhone">
		<div class="k_phone">
		<div class="k_phoneHead">
		<textarea name="CONTENT" id="textfield2" onKeyUp="javascript:checklen(<%=msgLength%>);" cols="16" class="k_phoneMsg"></textarea>
		<div class="k_phoneLimit" style="margin: -3px 0 0;"><input name="msglen" value=0 readOnly style="width: 14px"> <input name="mglenLimit" value="/ 80" style="width: 24px"> Bytes</div>
		</div>
		<div>
		<div class="k_phoneFormTo">제목 <input name="TITLE" type="text" style="width: 138px" /></div>
		<div class="k_phoneInfo">
		<table align="center" class="k_adminPhone">
			<tr>
				<td><a href="javascript:addChar('☆');">☆</a></td>
				<td><a href="javascript:addChar('○');">○</a></td>
				<td><a href="javascript:addChar('□');">□</a></td>
				<td><a href="javascript:addChar('◎');">◎</a></td>
				<td><a href="javascript:addChar('★');">★</a></td>
				<td><a href="javascript:addChar('●');">●</a></td>
				<td><a href="javascript:addChar('■');">■</a></td>
			</tr>
			<tr>
				<td><a href="javascript:addChar('⊙');">⊙</a></td>
				<td><a href="javascript:addChar('☏');">☏</a></td>
				<td><a href="javascript:addChar('☎');">☎</a></td>
				<td><a href="javascript:addChar('◈');">◈</a></td>
				<td><a href="javascript:addChar('▣');">▣</a></td>
				<td><a href="javascript:addChar('◐');">◐</a></td>
				<td><a href="javascript:addChar('◑');">◑</a></td>
			</tr>
			<tr>
				<td><a href="javascript:addChar('☜');">☜</a></td>
				<td><a href="javascript:addChar('☞');">☞</a></td>
				<td><a href="javascript:addChar('◀');">◀</a></td>
				<td><a href="javascript:addChar('▶');">▶</a></td>
				<td><a href="javascript:addChar('▼');">▼</a></td>
				<td><a href="javascript:addChar('▲');">▲</a></td>
				<td><a href="javascript:addChar('♠');">♠</a></td>
			</tr>
			<tr>
				<td><a href="javascript:addChar('♣');">♣</a></td>
				<td><a href="javascript:addChar('♥');">♥</a></td>
				<td><a href="javascript:addChar('◆');">◆</a></td>
				<td><a href="javascript:addChar('◁');">◁</a></td>
				<td><a href="javascript:addChar('▷');">▷</a></td>
				<td><a href="javascript:addChar('△');">△</a></td>
				<td><a href="javascript:addChar('▽');">▽</a></td>
			</tr>
			<tr>
				<td><a href="javascript:addChar('♤');">♤</a></td>
				<td><a href="javascript:addChar('♧');">♧</a></td>
				<td><a href="javascript:addChar('♡');">♡</a></td>
				<td><a href="javascript:addChar('◇');">◇</a></td>
				<td><a href="javascript:addChar('※');">※</a></td>
				<td><a href="javascript:addChar('♨');">♨</a></td>
				<td><a href="javascript:addChar('♪');">♪</a></td>
			</tr>
		</table>
		</div>
		</div>
		<div style="margin: -1px 0 0">
		<a href="javascript:;" onClick="js_commit();" id="commit_link"><img src="/images/kor/sms/btnSmsImg_entry.gif" /></a>
		<a href="javascript:;" onClick="js_reset();"><img src="/images/kor/sms/btnSmsImg_reset.gif" /></a>
		</div>
		</div>
		</td>
		<td><iframe width="100%" height="590" name="iframe" frameborder="no" src="sms.system.do?method=sys_03_050if" scrolling="no"></iframe></td>
	</tr>
</table>
</div>
<div class="k_tab_boxBott">
<img src="/images/kor/tabmenu/admin_tabBottL.gif" class="k_fltL" />
<img src="/images/kor/tabmenu/admin_tabBottR.gif" class="k_fltR" />
</div>
</div>

</form>