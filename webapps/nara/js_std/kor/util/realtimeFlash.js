/**
* IE��ġ�� ����
* �÷��� ��ù����� ���� ��� 2006.03.20 ������
*/
function writeFlash(sSrc, iWidth, iHeight) {
	var arrScript = new Array();
	arrScript.push("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\"");
	arrScript.push("codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\""); 
	arrScript.push(" width=\""+iWidth+"\" "); 
	arrScript.push(" height=\""+iHeight+"\">"); 
	arrScript.push("<param name=\"movie\" value=\""+sSrc+"\">"); 
	arrScript.push("<param name=\"quality\" value=\"high\">"); 
	arrScript.push("<embed src=\""+sSrc+"\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" "); 
	arrScript.push(" width=\""+iWidth+"\" "); 
	arrScript.push(" height=\""+iHeight+"\" "); 
	arrScript.push("></embed> "); 
	arrScript.push("</object>"); 
	document.writeln(arrScript.join(""));
}



/**
* IE��ġ�� ����
* E-card �߼��� ���� ��ġ(���) 2006.03.20 ������
*/
function writeCard(sSrc, iWidth, iHeight) {
	var arrScript = new Array();
	arrScript.push("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\"");
	arrScript.push("codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\""); 
	arrScript.push(" width=\""+iWidth+"\" "); 
	arrScript.push(" height=\""+iHeight+"\">"); 
	arrScript.push("<param name=\"movie\" value=\""+sSrc+"\">"); 
	arrScript.push("<param name=\"loop\" value=\"false\">"); 
	arrScript.push("<param name=\"menu\" value=\"false\">"); 
	arrScript.push("<param name=\"quality\" value=\"high\">"); 
	arrScript.push("<param name=\"scale\" value=\"exactfit\">"); 
	arrScript.push("<param name=\"salign\" value=\"T\">"); 
	arrScript.push("<param name=\"devicefont\" value=\"true\">"); 
	arrScript.push("<embed src=\""+sSrc+"\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" "); 
	arrScript.push(" width=\""+iWidth+"\" "); 
	arrScript.push(" height=\""+iHeight+"\" "); 
	arrScript.push("></embed> "); 
	arrScript.push("</object>"); 
	document.writeln(arrScript.join(""));
}