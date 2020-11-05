/**
* WebImtong 사용을 위한 펑션 JS
* Created 2006. 09. 29 Jiseong
* modified 2007. 01. ImTong 서버교체로 인한 IMBS 값 변경예정
* modified 2007. 02. Base64 Incording 관련 작업 추가
*/

function WebImtongStart(MailToName, MailToIDX, MailFromName, MailFromIDX){

		document.writeln("<OBJECT id= WebImTong name = WebImTong 																					");
		document.writeln("classid='clsid:7AF1D5C6-9ED2-4EC0-8855-363EF591D252' width='100%' height='100%' ");
		document.writeln("leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'                   ");
		document.writeln("codebase='http://demo.kebiportal.com/nara/imtong/WebImTong.cab#version=1,0,0,31'>       ");
		document.writeln("<PARAM NAME = 'msgviewtype' VALUE = 'CHAT' >                                    ");
		document.writeln("<PARAM NAME = 'MailToName' VALUE = '"+MailToName+"'>                            ");
		document.writeln("<PARAM NAME = 'MailToIDX' VALUE = '"+MailToIDX+"' >                      				");
		document.writeln("<PARAM NAME = 'MailFromName' VALUE ='"+MailFromName+"' >                     		");
		document.writeln("<PARAM NAME = 'MailFromIDX' VALUE ='"+MailFromIDX+"' >                     			");
		document.writeln("<PARAM NAME = 'IMBS' VALUE = '61.100.139.181:3301'>                             ");
		//document.writeln("<PARAM NAME = 'IMBS' VALUE = '210.116.116.240:3301'>                           ");
		document.writeln("<PARAM NAME = 'FRS' VALUE = '58.225.75.11:23000'>                               ");
		document.writeln("</OBJECT>                                                                       ");

}

// modified 2007. 02. Base64 Incording 관련 작업 추가
function WebImtongBase64(nsUserParam){
		var arrScript = new Array();
		//var nsSysParam = "CHAT|61.100.139.181:3301|58.225.75.11:23000|TRUE"; 인코딩 전
		//var nsSysParam = "Q0hBVHw2MS4xMDAuMTM5LjE4MTozMzAxfDU4LjIyNS43NS4xMToyMzAwMHxUUlVF";
		arrScript.push("<OBJECT id=\"WebImTong\" name =\"WebImTong\"																		");
		arrScript.push("classid=\"clsid:7AF1D5C6-9ED2-4EC0-8855-363EF591D252\" width=\"100%\" height=\"100%\" ");
		arrScript.push("leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'                   ");
		arrScript.push("codebase=\"http://demo.kebiportal.com/nara/imtong/WebImTong.cab#version=1,0,0,31\">       ");
		//arrScript.push("<PARAM NAME = \"UserParam\" VALUE =\"waTB9ry6fGNvbG9ybm85QG5hcmF2aXNpb24ubmV0fLHHwMfAzHxuYWZyZWVAbmFyYXZpc2lvbi5uZXR8MjAwNzAyMTI=\" > ");
		//arrScript.push("<PARAM NAME = \"SysParam\" VALUE = \"Q0hBVHw2MS4xMDAuMTM5LjE4MTozMzAxfDU4LjIyNS43NS4xMToyMzAwMHxUUlVF\" >                           ");
		arrScript.push("<PARAM NAME = \"UserParam\" VALUE =\""+nsUserParam+"\" > ");
		arrScript.push("<PARAM NAME = \"SysParam\" VALUE = \"Q0hBVHw2MS4xMDAuMTM5LjE4MTozMzAxfDYxLjEwMC4xMzkuMTAxOjIzMDAwfFRSVUU=\" >                           ");
		arrScript.push("</OBJECT>");
		document.writeln(arrScript.join(""));
}



/**
*하드코딩 테스트 펑션
*/
/*
function test64(){
		var arrScript = new Array();
		//var nsSysParam = "CHAT|61.100.139.181:3301|58.225.75.11:23000|TRUE"; 인코딩 전
		//var nsSysParam = "Q0hBVHw2MS4xMDAuMTM5LjE4MTozMzAxfDU4LjIyNS43NS4xMToyMzAwMHxUUlVF";
		arrScript.push("<OBJECT id=\"WebImTong\" name =\"WebImTong\"																		");
		arrScript.push("classid=\"clsid:7AF1D5C6-9ED2-4EC0-8855-363EF591D252\" width=\"100%\" height=\"100%\" ");
		arrScript.push("leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'                   ");
		arrScript.push("codebase=\"http://demo.kebiportal.com/nara/imtong/WebImTong.cab#version=1,0,0,30\">       ");
		//arrScript.push("<PARAM NAME = \"UserParam\" VALUE =\"waTB9ry6fGNvbG9ybm85QG5hcmF2aXNpb24ubmV0fLHHwMfAzHxuYWZyZWVAbmFyYXZpc2lvbi5uZXR8MjAwNzAyMTI=\" > ");
		//arrScript.push("<PARAM NAME = \"SysParam\" VALUE = \"Q0hBVHw2MS4xMDAuMTM5LjE4MTozMzAxfDU4LjIyNS43NS4xMToyMzAwMHxUUlVF\" >                           ");
		arrScript.push("<PARAM NAME = \"UserParam\" VALUE =\"waTB9ry6fGNvbG9ybm85QG5hcmF2aXNpb24ubmV0fLHHwMfAzHxuYWZyZWVAbmFyYXZpc2lvbi5uZXR8MjAwNzAyMTI=\" > ");
		arrScript.push("<PARAM NAME = \"SysParam\" VALUE = \"Q0hBVHw2MS4xMDAuMTM5LjE4MTozMzAxfDU4LjIyNS43NS4xMToyMzAwMHxUUlVF\" >                           ");
		arrScript.push("</OBJECT>");
		document.writeln(arrScript.join(""));
}
*/                                                                                                                                                                                                                                                                                                                                                                                                                               