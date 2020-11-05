<%@ page contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>특수문자 입력</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type='text/css'>
.charbutton {
	border-style: none;
	width: 25px;
	height: 25px;
	background-color: #EEEEEE;
}

td {
	font-size: 11px;
	font-family: verdana
}
</style>
<script language="javascript">
var eid = null;
var isIE = true;

opener = window.dialogArguments;

var _editor_url = opener._editor_url;
var objname     = location.search.substring(1,location.search.length);
var config      = opener.document.all[objname].config;
var editor_obj  = opener.document.all["_" +objname+  "_editor"];
var editdoc     = editor_obj.contentWindow.document;


function ButtonUp(param) {
	param.style.border="1px outset";
	param.style.background="#C6C3C6";
	document.getElementById("preivewtext").value = param.value;
}

function ButtonOut(param) {
	param.style.border="";
	param.style.background="";
}

function sendIcon(txt) {
	
	/*
	alert(txt);
	if (isIE) {
		alert(txt);
		window.returnValue = txt;
	}else{
		alert(eid+":::"+txt);
		opener.uEditPasteHtmlToCanvas(eid, txt);
   	window.close();
   }
   */
   var curRange = editdoc.selection.createRange();
   opener.editor_insertHTML(objname, txt);
   window.close();
   	
}

function modal_init() {
	isIE = navigator.appName == 'Microsoft Internet Explorer';
	
	if (!isIE)
		eid = opener.getCurrentEid();
}

window.onload=modal_init;
</script>

</head>
<body>
<form name=mdal>


<table border=0 cellspacing=0 cellpadding=0 width=100%>
	<tr>
		<td width=82 align=center><input type=text name=preivewtext
			id=preivewtext
			style="font-size: 70; font-weight: bold; height: 80; width: 80; text-align: center"
			readonly></td>
		<td bgcolor=#eeeeee>
		<button onclick=sendIcon( 'ⓐ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓐ class=charbutton>ⓐ</button>
		<button onclick=sendIcon( 'ⓑ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓑ class=charbutton>ⓑ</button>
		<button onclick=sendIcon( 'ⓒ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓒ class=charbutton>ⓒ</button>
		<button onclick=sendIcon( 'ⓓ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓓ class=charbutton>ⓓ</button>
		<button onclick=sendIcon( 'ⓔ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓔ class=charbutton>ⓔ</button>
		<button onclick=sendIcon( 'ⓕ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓕ class=charbutton>ⓕ</button>
		<button onclick=sendIcon( 'ⓖ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓖ class=charbutton>ⓖ</button>
		<button onclick=sendIcon( 'ⓗ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓗ class=charbutton>ⓗ</button>
		<button onclick=sendIcon( 'ⓘ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓘ class=charbutton>ⓘ</button>
		<button onclick=sendIcon( 'ⓙ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓙ class=charbutton>ⓙ</button>
		<button onclick=sendIcon( 'ⓚ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓚ class=charbutton>ⓚ</button>
		<button onclick=sendIcon( 'ⓛ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓛ class=charbutton>ⓛ</button>
		<br>
		<button onclick=sendIcon( 'ⓜ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓜ class=charbutton>ⓜ</button>
		<button onclick=sendIcon( 'ⓝ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓝ class=charbutton>ⓝ</button>
		<button onclick=sendIcon( 'ⓞ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓞ class=charbutton>ⓞ</button>
		<button onclick=sendIcon( 'ⓟ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓟ class=charbutton>ⓟ</button>
		<button onclick=sendIcon( 'ⓠ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓠ class=charbutton>ⓠ</button>
		<button onclick=sendIcon( 'ⓡ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓡ class=charbutton>ⓡ</button>
		<button onclick=sendIcon( 'ⓢ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓢ class=charbutton>ⓢ</button>
		<button onclick=sendIcon( 'ⓣ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓣ class=charbutton>ⓣ</button>
		<button onclick=sendIcon( 'ⓤ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓤ class=charbutton>ⓤ</button>
		<button onclick=sendIcon( 'ⓥ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓥ class=charbutton>ⓥ</button>
		<button onclick=sendIcon( 'ⓦ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓦ class=charbutton>ⓦ</button>
		<button onclick=sendIcon( 'ⓧ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓧ class=charbutton>ⓧ</button>
		<br>
		<button onclick=sendIcon( 'ⓨ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓨ class=charbutton>ⓨ</button>
		<button onclick=sendIcon( 'ⓩ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ⓩ class=charbutton>ⓩ</button>
		<button onclick=sendIcon( '①') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=① class=charbutton>①</button>
		<button onclick=sendIcon( '②') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=② class=charbutton>②</button>
		<button onclick=sendIcon( '③') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=③ class=charbutton>③</button>
		<button onclick=sendIcon( '④') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=④ class=charbutton>④</button>
		<button onclick=sendIcon( '⑤') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑤ class=charbutton>⑤</button>
		<button onclick=sendIcon( '⑥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑥ class=charbutton>⑥</button>
		<button onclick=sendIcon( '⑦') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑦ class=charbutton>⑦</button>
		<button onclick=sendIcon( '⑧') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑧ class=charbutton>⑧</button>
		<button onclick=sendIcon( '⑨') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑨ class=charbutton>⑨</button>
		<button onclick=sendIcon( '⑩') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑩ class=charbutton>⑩</button>
		</td>
	</tr>
	<tr>
		<td colspan=2 bgcolor=#eeeeee>
		<button onclick=sendIcon( '⑪') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑪ class=charbutton>⑪</button>
		<button onclick=sendIcon( '⑫') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑫ class=charbutton>⑫</button>
		<button onclick=sendIcon( '⑬') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑬ class=charbutton>⑬</button>
		<button onclick=sendIcon( '⑭') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑭ class=charbutton>⑭</button>
		<button onclick=sendIcon( '⑮') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⑮ class=charbutton>⑮</button>
		<button onclick=sendIcon( 'ㅿ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ㅿ class=charbutton>ㅿ</button>
		<button onclick=sendIcon( 'ㆀ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ㆀ class=charbutton>ㆀ</button>
		<button onclick=sendIcon( 'ㆁ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ㆁ class=charbutton>ㆁ</button>
		<button onclick=sendIcon( 'ㆅ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ㆅ class=charbutton>ㆅ</button>
		<button onclick=sendIcon( 'ㅹ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ㅹ class=charbutton>ㅹ</button>
		<button onclick=sendIcon( 'ㅸ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ㅸ class=charbutton>ㅸ</button>
		<button onclick=sendIcon( 'ㆄ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ㆄ class=charbutton>ㆄ</button>
		<button onclick=sendIcon( '½') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=½ class=charbutton>½</button>
		<button onclick=sendIcon( '＃') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＃ class=charbutton>＃</button>
		<button onclick=sendIcon( '＆') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＆ class=charbutton>＆</button>
		<br>
		<button onclick=sendIcon( '＊') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＊ class=charbutton>＊</button>
		<button onclick=sendIcon( '＠') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＠ class=charbutton>＠</button>
		<button onclick=sendIcon( '§') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=§ class=charbutton>§</button>
		<button onclick=sendIcon( '※') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=※ class=charbutton>※</button>
		<button onclick=sendIcon( '☆') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=☆ class=charbutton>☆</button>
		<button onclick=sendIcon( '★') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=★ class=charbutton>★</button>
		<button onclick=sendIcon( '○') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=○ class=charbutton>○</button>
		<button onclick=sendIcon( '●') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=● class=charbutton>●</button>
		<button onclick=sendIcon( '◎') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=◎ class=charbutton>◎</button>
		<button onclick=sendIcon( '◇') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=◇ class=charbutton>◇</button>
		<button onclick=sendIcon( '◆') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=◆ class=charbutton>◆</button>
		<button onclick=sendIcon( '□') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=□ class=charbutton>□</button>
		<button onclick=sendIcon( '■') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=■ class=charbutton>■</button>
		<button onclick=sendIcon( '△') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=△ class=charbutton>△</button>
		<button onclick=sendIcon( '▲') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▲ class=charbutton>▲</button>
		<br>
		<button onclick=sendIcon( '▽') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▽ class=charbutton>▽</button>
		<button onclick=sendIcon( '▼') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▼ class=charbutton>▼</button>
		<button onclick=sendIcon( '→') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=→ class=charbutton>→</button>
		<button onclick=sendIcon( '←') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=← class=charbutton>←</button>
		<button onclick=sendIcon( '↑') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=↑ class=charbutton>↑</button>
		<button onclick=sendIcon( '↓') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=↓ class=charbutton>↓</button>
		<button onclick=sendIcon( '↔') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=↔ class=charbutton>↔</button>
		<button onclick=sendIcon( '〓') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=〓 class=charbutton>〓</button>
		<button onclick=sendIcon( '◁') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=◁ class=charbutton>◁</button>
		<button onclick=sendIcon( '◀') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=◀ class=charbutton>◀</button>
		<button onclick=sendIcon( '▷') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▷ class=charbutton>▷</button>
		<button onclick=sendIcon( '▶') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▶ class=charbutton>▶</button>
		<button onclick=sendIcon( '♤') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♤ class=charbutton>♤</button>
		<button onclick=sendIcon( '♠') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♠ class=charbutton>♠</button>
		<button onclick=sendIcon( '♡') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♡ class=charbutton>♡</button>
		<br>
		<button onclick=sendIcon( '♥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♥ class=charbutton>♥</button>
		<button onclick=sendIcon( '♧') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♧ class=charbutton>♧</button>
		<button onclick=sendIcon( '♣') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♣ class=charbutton>♣</button>
		<button onclick=sendIcon( '⊙') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⊙ class=charbutton>⊙</button>
		<button onclick=sendIcon( '◈') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=◈ class=charbutton>◈</button>
		<button onclick=sendIcon( '▣') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▣ class=charbutton>▣</button>
		<button onclick=sendIcon( '◐') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=◐ class=charbutton>◐</button>
		<button onclick=sendIcon( '◑') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=◑ class=charbutton>◑</button>
		<button onclick=sendIcon( '▒') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▒ class=charbutton>▒</button>
		<button onclick=sendIcon( '▤') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▤ class=charbutton>▤</button>
		<button onclick=sendIcon( '▥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▥ class=charbutton>▥</button>
		<button onclick=sendIcon( '▨') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▨ class=charbutton>▨</button>
		<button onclick=sendIcon( '▧') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▧ class=charbutton>▧</button>
		<button onclick=sendIcon( '▦') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▦ class=charbutton>▦</button>
		<button onclick=sendIcon( '▩') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=▩ class=charbutton>▩</button>
		<br>
		<button onclick=sendIcon( '♨') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♨ class=charbutton>♨</button>
		<button onclick=sendIcon( '☏') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=☏ class=charbutton>☏</button>
		<button onclick=sendIcon( '☎') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=☎ class=charbutton>☎</button>
		<button onclick=sendIcon( '☜') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=☜ class=charbutton>☜</button>
		<button onclick=sendIcon( '☞') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=☞ class=charbutton>☞</button>
		<button onclick=sendIcon( '¶') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=¶ class=charbutton>¶</button>
		<button onclick=sendIcon( '†') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=† class=charbutton>†</button>
		<button onclick=sendIcon( '‡') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=‡ class=charbutton>‡</button>
		<button onclick=sendIcon( '↕') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=↕ class=charbutton>↕</button>
		<button onclick=sendIcon( '↗') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=↗ class=charbutton>↗</button>
		<button onclick=sendIcon( '↙') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=↙ class=charbutton>↙</button>
		<button onclick=sendIcon( '↖') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=↖ class=charbutton>↖</button>
		<button onclick=sendIcon( '↘') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=↘ class=charbutton>↘</button>
		<button onclick=sendIcon( '♭') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♭ class=charbutton>♭</button>
		<button onclick=sendIcon( '♩') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♩ class=charbutton>♩</button>
		<br>
		<button onclick=sendIcon( '♪') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♪ class=charbutton>♪</button>
		<button onclick=sendIcon( '♬') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♬ class=charbutton>♬</button>
		<button onclick=sendIcon( '㉿') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉿ class=charbutton>㉿</button>
		<button onclick=sendIcon( '㈜') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㈜ class=charbutton>㈜</button>
		<button onclick=sendIcon( '№') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=№ class=charbutton>№</button>
		<button onclick=sendIcon( '㏇') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㏇ class=charbutton>㏇</button>
		<button onclick=sendIcon( '™') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=™ class=charbutton>™</button>
		<button onclick=sendIcon( '㏂') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㏂ class=charbutton>㏂</button>
		<button onclick=sendIcon( '㏘') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㏘ class=charbutton>㏘</button>
		<button onclick=sendIcon( '℡') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=℡ class=charbutton>℡</button>
		<button onclick=sendIcon( '??') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=?? class=charbutton>??</button>
		<button onclick=sendIcon( '＂') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＂ class=charbutton>＂</button>
		<button onclick=sendIcon( '〔') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=〔 class=charbutton>〔</button>
		<button onclick=sendIcon( '〕') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=〕 class=charbutton>〕</button>
		<button onclick=sendIcon( '〈') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=〈 class=charbutton>〈</button>
		<br>
		<button onclick=sendIcon( '〉') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=〉 class=charbutton>〉</button>
		<button onclick=sendIcon( '‘') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=‘ class=charbutton>‘</button>
		<button onclick=sendIcon( '’') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=’ class=charbutton>’</button>
		<button onclick=sendIcon( '“') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=“ class=charbutton>“</button>
		<button onclick=sendIcon( '”') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=” class=charbutton>”</button>
		<button onclick=sendIcon( '《') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=《 class=charbutton>《</button>
		<button onclick=sendIcon( '》') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=》 class=charbutton>》</button>
		<button onclick=sendIcon( '「') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=「 class=charbutton>「</button>
		<button onclick=sendIcon( '」') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=」 class=charbutton>」</button>
		<button onclick=sendIcon( '『') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=『 class=charbutton>『</button>
		<button onclick=sendIcon( '』') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=』 class=charbutton>』</button>
		<button onclick=sendIcon( '【') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=【 class=charbutton>【</button>
		<button onclick=sendIcon( '】') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=】 class=charbutton>】</button>
		<button onclick=sendIcon( '＄') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＄ class=charbutton>＄</button>
		<button onclick=sendIcon( '％') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=％ class=charbutton>％</button>
		<br>
		<button onclick=sendIcon( '￦') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=￦ class=charbutton>￦</button>
		<button onclick=sendIcon( '℃') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=℃ class=charbutton>℃</button>
		<button onclick=sendIcon( 'Å') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=Å class=charbutton>Å</button>
		<button onclick=sendIcon( '￠') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=￠ class=charbutton>￠</button>
		<button onclick=sendIcon( '￥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=￥ class=charbutton>￥</button>
		<button onclick=sendIcon( '℉') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=℉ class=charbutton>℉</button>
		<button onclick=sendIcon( 'ℓ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ℓ class=charbutton>ℓ</button>
		<button onclick=sendIcon( '㎘') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㎘ class=charbutton>㎘</button>
		<button onclick=sendIcon( '㏄') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㏄ class=charbutton>㏄</button>
		<button onclick=sendIcon( '㎣') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㎣ class=charbutton>㎣</button>
		<button onclick=sendIcon( '㎤') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㎤ class=charbutton>㎤</button>
		<button onclick=sendIcon( '㎥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㎥ class=charbutton>㎥</button>
		<button onclick=sendIcon( '㎦') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㎦ class=charbutton>㎦</button>
		<button onclick=sendIcon( 'Ω') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=Ω class=charbutton>Ω</button>
		<button onclick=sendIcon( 'Θ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=Θ class=charbutton>Θ</button>
		<br>
		<button onclick=sendIcon( 'Ξ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=Ξ class=charbutton>Ξ</button>
		<button onclick=sendIcon( 'Σ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=Σ class=charbutton>Σ</button>
		<button onclick=sendIcon( 'Φ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=Φ class=charbutton>Φ</button>
		<button onclick=sendIcon( 'Ψ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=Ψ class=charbutton>Ψ</button>
		<button onclick=sendIcon( 'Ω') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=Ω class=charbutton>Ω</button>
		<button onclick=sendIcon( 'α') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=α class=charbutton>α</button>
		<button onclick=sendIcon( 'β') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=β class=charbutton>β</button>
		<button onclick=sendIcon( 'γ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=γ class=charbutton>γ</button>
		<button onclick=sendIcon( 'π') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=π class=charbutton>π</button>
		<button onclick=sendIcon( 'χ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=χ class=charbutton>χ</button>
		<button onclick=sendIcon( 'ψ') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ψ class=charbutton>ψ</button>
		<button onclick=sendIcon( 'ω') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=ω class=charbutton>ω</button>
		<button onclick=sendIcon( '＋') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＋ class=charbutton>＋</button>
		<button onclick=sendIcon( '－') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=－ class=charbutton>－</button>
		<button onclick=sendIcon( '＜') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＜ class=charbutton>＜</button>
		<br>
		<button onclick=sendIcon( '＝') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＝ class=charbutton>＝</button>
		<button onclick=sendIcon( '＞') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＞ class=charbutton>＞</button>
		<button onclick=sendIcon( '±') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=± class=charbutton>±</button>
		<button onclick=sendIcon( '×') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=× class=charbutton>×</button>
		<button onclick=sendIcon( '÷') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=÷ class=charbutton>÷</button>
		<button onclick=sendIcon( '≠') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=≠ class=charbutton>≠</button>
		<button onclick=sendIcon( '≤') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=≤ class=charbutton>≤</button>
		<button onclick=sendIcon( '≥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=≥ class=charbutton>≥</button>
		<button onclick=sendIcon( '∞') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∞ class=charbutton>∞</button>
		<button onclick=sendIcon( '∴') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∴ class=charbutton>∴</button>
		<button onclick=sendIcon( '♂') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♂ class=charbutton>♂</button>
		<button onclick=sendIcon( '♀') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=♀ class=charbutton>♀</button>
		<button onclick=sendIcon( '∠') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∠ class=charbutton>∠</button>
		<button onclick=sendIcon( '⊥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⊥ class=charbutton>⊥</button>
		<button onclick=sendIcon( '⌒') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⌒ class=charbutton>⌒</button>
		<br>
		<button onclick=sendIcon( '∂') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∂ class=charbutton>∂</button>
		<button onclick=sendIcon( '∇') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∇ class=charbutton>∇</button>
		<button onclick=sendIcon( '≡') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=≡ class=charbutton>≡</button>
		<button onclick=sendIcon( '≒') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=≒ class=charbutton>≒</button>
		<button onclick=sendIcon( '≪') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=≪ class=charbutton>≪</button>
		<button onclick=sendIcon( '≫') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=≫ class=charbutton>≫</button>
		<button onclick=sendIcon( '√') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=√ class=charbutton>√</button>
		<button onclick=sendIcon( '∽') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∽ class=charbutton>∽</button>
		<button onclick=sendIcon( '∝') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∝ class=charbutton>∝</button>
		<button onclick=sendIcon( '∵') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∵ class=charbutton>∵</button>
		<button onclick=sendIcon( '∫') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∫ class=charbutton>∫</button>
		<button onclick=sendIcon( '∬') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∬ class=charbutton>∬</button>
		<button onclick=sendIcon( '∈') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∈ class=charbutton>∈</button>
		<button onclick=sendIcon( '∋') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∋ class=charbutton>∋</button>
		<button onclick=sendIcon( '⊆') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⊆ class=charbutton>⊆</button>
		<br>
		<button onclick=sendIcon( '⊇') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⊇ class=charbutton>⊇</button>
		<button onclick=sendIcon( '⊂') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⊂ class=charbutton>⊂</button>
		<button onclick=sendIcon( '⊃') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⊃ class=charbutton>⊃</button>
		<button onclick=sendIcon( '∪') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∪ class=charbutton>∪</button>
		<button onclick=sendIcon( '∩') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∩ class=charbutton>∩</button>
		<button onclick=sendIcon( '∧') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∧ class=charbutton>∧</button>
		<button onclick=sendIcon( '∨') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∨ class=charbutton>∨</button>
		<button onclick=sendIcon( '￢') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=￢ class=charbutton>￢</button>
		<button onclick=sendIcon( '⇒') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⇒ class=charbutton>⇒</button>
		<button onclick=sendIcon( '⇔') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=⇔ class=charbutton>⇔</button>
		<button onclick=sendIcon( '∀') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∀ class=charbutton>∀</button>
		<button onclick=sendIcon( '∃') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∃ class=charbutton>∃</button>
		<button onclick=sendIcon( '∮') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∮ class=charbutton>∮</button>
		<button onclick=sendIcon( '∑') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∑ class=charbutton>∑</button>
		<button onclick=sendIcon( '∏') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∏ class=charbutton>∏</button>
		<br>
		<button onclick=sendIcon( '／') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=／ class=charbutton>／</button>
		<button onclick=sendIcon( '！') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=！ class=charbutton>！</button>
		<button onclick=sendIcon( '？') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=？ class=charbutton>？</button>
		<button onclick=sendIcon( '＿') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＿ class=charbutton>＿</button>
		<button onclick=sendIcon( '￣') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=￣ class=charbutton>￣</button>
		<button onclick=sendIcon( '‥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=‥ class=charbutton>‥</button>
		<button onclick=sendIcon( '…') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=… class=charbutton>…</button>
		<button onclick=sendIcon( '〃') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=〃 class=charbutton>〃</button>
		<button onclick=sendIcon( '＼') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=＼ class=charbutton>＼</button>
		<button onclick=sendIcon( '∼') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=∼ class=charbutton>∼</button>
		<button onclick=sendIcon( '～') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=～ class=charbutton>～</button>
		<button onclick=sendIcon( '㉠') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉠ class=charbutton>㉠</button>
		<button onclick=sendIcon( '㉡') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉡ class=charbutton>㉡</button>
		<button onclick=sendIcon( '㉢') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉢ class=charbutton>㉢</button>
		<button onclick=sendIcon( '㉣') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉣ class=charbutton>㉣</button>
		<br>
		<button onclick=sendIcon( '㉤') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉤ class=charbutton>㉤</button>
		<button onclick=sendIcon( '㉥') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉥ class=charbutton>㉥</button>
		<button onclick=sendIcon( '㉦') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉦ class=charbutton>㉦</button>
		<button onclick=sendIcon( '㉧') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉧ class=charbutton>㉧</button>
		<button onclick=sendIcon( '㉨') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉨ class=charbutton>㉨</button>
		<button onclick=sendIcon( '㉩') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉩ class=charbutton>㉩</button>
		<button onclick=sendIcon( '㉪') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉪ class=charbutton>㉪</button>
		<button onclick=sendIcon( '㉫') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉫ class=charbutton>㉫</button>
		<button onclick=sendIcon( '㉬') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉬ class=charbutton>㉬</button>
		<button onclick=sendIcon( '㉭') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉭ class=charbutton>㉭</button>
		<button onclick=sendIcon( '㉮') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉮ class=charbutton>㉮</button>
		<button onclick=sendIcon( '㉯') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉯ class=charbutton>㉯</button>
		<button onclick=sendIcon( '㉰') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉰ class=charbutton>㉰</button>
		<button onclick=sendIcon( '㉱') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉱ class=charbutton>㉱</button>
		<button onclick=sendIcon( '㉲') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉲ class=charbutton>㉲</button>
		<br>
		<button onclick=sendIcon( '㉳') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉳ class=charbutton>㉳</button>
		<button onclick=sendIcon( '㉴') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉴ class=charbutton>㉴</button>
		<button onclick=sendIcon( '㉵') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉵ class=charbutton>㉵</button>
		<button onclick=sendIcon( '㉶') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉶ class=charbutton>㉶</button>
		<button onclick=sendIcon( '㉷') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉷ class=charbutton>㉷</button>
		<button onclick=sendIcon( '㉸') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉸ class=charbutton>㉸</button>
		<button onclick=sendIcon( '㉹') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉹ class=charbutton>㉹</button>
		<button onclick=sendIcon( '㉺') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉺ class=charbutton>㉺</button>
		<button onclick=sendIcon( '㉻') onmouseover=ButtonUp(this)
			onmouseout=ButtonOut(this) value=㉻ class=charbutton>㉻</button>

		</td>
	</tr>
</table>



</form>

</body>
</html>
