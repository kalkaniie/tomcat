/** 
 * SMS¿ë tooltip JavaScript. 
 *
 * author : hojoongkim , hojoongkim@kebi.com
 * date   : 2003. 01.  
 * Copyright 1995-2003 by  NARAVISION.CO All rights reserved. 
 * 
 */


function findObj(n, d) {
	var p,i,x;
	if(!d) d=document;
	if((p=n.indexOf("?"))>0&&parent.frames.length) {
		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
	}

	if(!(x=d[n])&&d.all) x=d.all[n];
	for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=findObj(n,d.layers[i].document);

  return x;
}


function showNhideLayer() {
	var i,p,v,obj,args=showNhideLayer.arguments;
	var sDisplay = '';
	for (i=0; i<(args.length-2); i+=3)
		if ((obj=findObj(args[i]))!=null) {
			v=args[i+2];
			if (obj.style) {
			obj=obj.style;
			v=(v=='show')?'visible':(v='hide')?'hidden':v;
		}

		if (args[2] == 'show')
			sDisplay = '';
		else 
			sDisplay = 'none';

		obj.display=sDisplay;
		obj.visibility=v;
	}
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


function movetip() {

	w_size = removePX(window.screenTop);
	f_size = removePX(document.body.scrollHeight);
	c_size = removePX(event.y+document.body.scrollTop);
	l_size = removePX(document.body.scrollWidth);			
	r_size = removePX(event.x+document.body.scrollLeft);
	v_size = l_size - r_size;
	d_size = f_size - c_size;
	if(d_size < 140){
		if(v_size < 100){
			tooltip.style.top = event.y+document.body.scrollTop - 119;
			tooltip.style.left = event.x+document.body.scrollLeft-140;
		}else{
			tooltip.style.top = event.y+document.body.scrollTop - 119;
			tooltip.style.left = event.x+document.body.scrollLeft+10;
		}
	}else{
		if(v_size < 100){
			tooltip.style.top = event.y+document.body.scrollTop;
			tooltip.style.left = event.x+document.body.scrollLeft-140;
		}else{
			tooltip.style.top = event.y+document.body.scrollTop;
			tooltip.style.left = event.x+document.body.scrollLeft+10;
		}
	}
}


function showTip(nNum) {
  var obj =eval("document.form.content_"+nNum);
  var message = obj.value;

  var str = 
    "<table width='146' border='0' cellspacing='0' cellpadding='0'>" +
    "<tr>" +
    "    <td><img src='../image/main_sms_meswin_00.gif' width='146' height='37'></td>" +
    "</tr>" +
    "<tr>" +
    "    <td valign='top'>" +
    "    <table width='100%' height='74' border='0' cellpadding='0' cellspacing='0'>" +
    "    <tr>" +
    "        <td width='19' background='../image/main_sms_meswin_01.gif'>&nbsp;</td>" +
    "        <td align='center' background='../image/main_sms_meswin_02.gif'><textarea cols='15' style='height:96; OVERFLOW: hidden; border-width:0px; font-size:9pt; color: #336699; filter=progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#B4EAFF, EndColorStr=#F1FFFF)' name=textarea14 readonly>"+message+"</textarea></td>" +
    "        <td width='19' background='../image/main_sms_meswin_03.gif'>&nbsp;</td>" +
    "    </tr>" +
    "    </table>" +
    "    </td>" +
    "</tr>" +
    "<tr>" +
    "    <td><img src='../image/main_sms_meswin_04.gif' width='146' height='17'></td>" +
    "</tr>" +
    "<tr>" +
    "    <td align='center' background='../image/main_sms_meswin_05.gif'>" +
    "    <table width='100%'  border='0' cellspacing='0' cellpadding='0'>" +
    "    <tr>" +
    "        <td height='15' align='center' valign='top'>&nbsp;</td>" +
    "    </tr>" +
    "    <tr>" +
    "        <td align='center'>&nbsp;</td>" +
    "    </tr>" +
    "    </table>" +
    "    </td>" +
    "</tr>" +
    "<tr>" +
    "    <td><img src='../image/main_sms_meswin_06.gif' width='146' height='5'></td>" +
    "</tr>" +
    "</table>";

  /*var	str =
	"<html>" +
	"<head>" +
	"<style type='text/css'>" +
	"table { border: none }" +
	"img { border: none }" +
	"td { font-size: 2px }" +
	".screen { font-family: µ¸¿òÃ¼; font-size: 9pt; color: #000000; line-height: 14px; }" +
	"</style>" +
	"</head>" +
	"<body width='100%' height='100%' leftmargin='0' topmargin='0'>" +
  "<table width='100%' border='0' cellspacing='0' cellpadding='0'>" +
  "<tr>" +
  "<td><img src='../img/kor/sms_top.gif' width='144' height='24'></td>" +
  "</tr>" +
  "<tr>" +
  "<td height='96' align='center' valign='top' background='../img/kor/sms_bg2.gif'>" +
  "<textarea style='background=.../img/kor/sms_bg3.gif ;overflow:hidden; border-style:none;' rows=5 cols=16>" + message + "</textarea>" +
  "</td>" +
	"</tr>" +
	"</table>" +
	"</body>" +
	"</html>";*/
/*
  var	str =
	"<html>" +
	"<head>" +
	"<style type='text/css'>" +
	"table { border: none }" +
	"img { border: none }" +
	"td { font-size: 2px }" +
	".screen { font-family: µ¸¿òÃ¼; font-size: 9pt; color: #000000; line-height: 14px; }" +
	"</style>" +
	"</head>" +
	"<body width='100%' height='100%' leftmargin='0' topmargin='0'>" +
	"<form name=sms_form>" +
	"<table width='100%' height='100%' border='0' cellspacing='0' cellpadding='0'>" +
	"<tr>" +
	"<td width='136'><img src='/img/sms/scrn02_top.gif' width='136' height='24'></td>" +
	"</tr><tr>" +
	"<td width='136' background='/img/sms/tooltip_middle.gif' align='center'>" +
	"<textarea id='sms_message' name='content' style='cursor : hand' name='content' cols='16' rows='6' style='background-image:url(\"/img/sms/tooltip_bg02.gif\"); background-repeat:no-repeat; background-attachment:fixed; border: none; overflow: hidden; height=82' class='screen'>"+message+"</textarea>" +
	"</td>" +
	"</tr><tr>" +
	"<td width='136'><img src='/img/sms/scrn02_bottom.gif' width='136' height='24'></td>" +
	"</tr>" +
	"</table>" +
	"</form>" +
	"</body>" +
	"</html>";
*/
	document.fContent.location.reload();
	document.fContent.document.write(str);

	showNhideLayer('tooltip','', 'show')

}


function hideTip() {
	showNhideLayer('tooltip','', 'hide');
}


function showTip2(nNum) {
alert("ddd");
  var obj =eval("document.f.content_"+nNum);
  var message = obj.value;

alert(message);
var str =     "<table width='146' border='0' cellspacing='0' cellpadding='0'>" +
    "<tr>" +
    "    <td>"+message+"</td></tr></table>";
alert(str);
/*
  var str =
    "<table width='146' border='0' cellspacing='0' cellpadding='0'>" +
    "<tr>" +
    "    <td><img src='../image/main_sms_meswin_00.gif' width='146' height='37'></td>" +
    "</tr>" +
    "<tr>" +
    "    <td valign='top'>" +
    "    <table width='100%' height='74' border='0' cellpadding='0' cellspacing='0'>" +
    "    <tr>" +
    "        <td width='19' background='../image/main_sms_meswin_01.gif'>&nbsp;</td>" +
    "        <td align='center' background='../image/main_sms_meswin_02.gif'><textarea cols='15' style='height:96; OVERFLOW: hidden;
 border-width:0px; font-size:9pt; color: #336699; filter=progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#B
4EAFF, EndColorStr=#F1FFFF)' name=textarea14 readonly>"+message+"</textarea></td>" +
    "        <td width='19' background='../image/main_sms_meswin_03.gif'>&nbsp;</td>" +
    "    </tr>" +
    "    </table>" +
    "    </td>" +
    "</tr>" +
    "<tr>" +
    "    <td><img src='../image/main_sms_meswin_04.gif' width='146' height='17'></td>" +
    "</tr>" +
    "<tr>" +
    "    <td align='center' background='../image/main_sms_meswin_05.gif'>" +
    "    <table width='100%'  border='0' cellspacing='0' cellpadding='0'>" +
    "    <tr>" +
    "        <td height='15' align='center' valign='top'>&nbsp;</td>" +
    "    </tr>" +
    "    <tr>" +
    "        <td align='center'>&nbsp;</td>" +
    "    </tr>" +
    "    </table>" +
    "    </td>" +
    "</tr>" +
    "<tr>" +
    "    <td><img src='../image/main_sms_meswin_06.gif' width='146' height='5'></td>" +
    "</tr>" +
    "</table>";

*/
  /*var str =
        "<html>" +
        "<head>" +
        "<style type='text/css'>" +
        "table { border: none }" +
        "img { border: none }" +
        "td { font-size: 2px }" +
        ".screen { font-family: µ¸¿òÃ¼; font-size: 9pt; color: #000000; line-height: 14px; }" +
        "</style>" +
        "</head>" +
        "<body width='100%' height='100%' leftmargin='0' topmargin='0'>" +
  "<table width='100%' border='0' cellspacing='0' cellpadding='0'>" +
  "<tr>" +
  "<td><img src='../img/kor/sms_top.gif' width='144' height='24'></td>" +
  "</tr>" +
  "<tr>" +
  "<td height='96' align='center' valign='top' background='../img/kor/sms_bg2.gif'>" +
  "<textarea style='background=.../img/kor/sms_bg3.gif ;overflow:hidden; border-style:none;' rows=5 cols=16>" + message + "</textare
a>" +
  "</td>" +
        "</tr>" +
        "</table>" +
        "</body>" +
        "</html>";*/
/*
  var   str =
        "<html>" +
        "<head>" +
        "<style type='text/css'>" +
        "table { border: none }" +
        "img { border: none }" +
        "td { font-size: 2px }" +
        ".screen { font-family: µ¸¿òÃ¼; font-size: 9pt; color: #000000; line-height: 14px; }" +
        "</style>" +
        "</head>" +
        "<body width='100%' height='100%' leftmargin='0' topmargin='0'>" +
        "<form name=sms_form>" +
        "<table width='100%' height='100%' border='0' cellspacing='0' cellpadding='0'>" +
        "<tr>" +
        "<td width='136'><img src='/img/sms/scrn02_top.gif' width='136' height='24'></td>" +
        "</tr><tr>" +
        "<td width='136' background='/img/sms/tooltip_middle.gif' align='center'>" +
        "<textarea id='sms_message' name='content' style='cursor : hand' name='content' cols='16' rows='6' style='background-image:u
rl(\"/img/sms/tooltip_bg02.gif\"); background-repeat:no-repeat; background-attachment:fixed; border: none; overflow: hidden; height=
82' class='screen'>"+message+"</textarea>" +
        "</td>" +
        "</tr><tr>" +
        "<td width='136'><img src='/img/sms/scrn02_bottom.gif' width='136' height='24'></td>" +
        "</tr>" +
        "</table>" +
        "</form>" +
        "</body>" +
        "</html>";
*/
        document.fContent.location.reload();
        document.fContent.document.write(str);

        showNhideLayer('tooltip','', 'show')

}


function hideTip2() {
        showNhideLayer('tooltip','', 'hide');
}

