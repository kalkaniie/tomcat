function anaList(returnStr)   {
	
	var pipeCnt = 4;
	var fileList     = "";
	var fileListHTML = "";

	var fileListFrontHTML = "  <td  height='24' align='center' class='fontscolor'>";
	var fileListFrontRightHTML = "  <td  align='right' class='fontscolor'>";
   	var fileListEndHTML = " </td>";

	var fileListSize = 0;
	if(returnStr.length > 0) {
	  returnStr = returnStr.substring(0,returnStr.length-1);
	}
	
	fileList     = returnStr.split('|');
	fileListSize = fileList.length;
	var chkDirArr ;
		
	// 다운로드에 필요한 개체 입력

	var tempSendURL   = anacondaFm.anaForm.sendURL.value;
	var tempUsers_idx = anacondaFm.anaForm.users_idx.value;
	var tempMail_seq  = anacondaFm.anaForm.mail_seq.value;
	var tempFile_seq  = 0;

	var chkDirPath="";
	var delSlashName ="" ; 			//웹하드에서 메일로 첨부시
	for(i=0;i<fileListSize;i++) {
		// 파일/폴더명 + 링크 걸기
	    if(i%pipeCnt ==0 ) {
	    	fileListHTML += "<tr bgcolor='#FFFFFF'>";
	    	if( fileList[i+1] =="0"){
	    		fileListHTML += "<td>&nbsp;<img src='" + tempSendURL + "/image/kor/anaconda/down_03.gif' width='14' height='15' align='absmiddle'> ";
		    	fileListHTML += "<a href='" + tempSendURL + "/servlet/anaconda.AnaDownServ?cmd=download&users_idx=" + tempUsers_idx + "&mail_seq=" + tempMail_seq + "&file_seq=" + tempFile_seq + "'>";
		      	delSlashName ="";
		      	if( fileList[i].indexOf("/") != -1){
		      		delSlashName = fileList[i].substring( fileList[i].lastIndexOf("/")+1);
		      	}else {
		      		delSlashName = 	fileList[i];
		      	}	
		      	fileListHTML += delSlashName;
		      	fileListHTML += "</a>";
	      	}else{
	    		fileListHTML += "<td>&nbsp;<img src='" + tempSendURL + "/image/kor/tree/file_folderclosed.gif' width='18' height='20' align='absmiddle'> ";
		    	fileListHTML += "<a href='" + tempSendURL + "/servlet/anaconda.AnaDownServ?cmd=popupActiveX&users_idx=" + tempUsers_idx + "&mail_seq=" + tempMail_seq+"' target='_new'>";
		      fileListHTML += fileList[i];
		      fileListHTML += "</a>";
	    	}
	      	fileListHTML += fileListEndHTML;
	      	// file_seq 증가
	      	if( Number(fileList[i+3] >1)){		//폴더일경우
	      		tempFile_seq = tempFile_seq + Number(fileList[i+3])+1;
	      	}else{								// 파일일경우
	    		tempFile_seq++;
	    	}	
	
	    // 파일/폴더 구분 플래그
	    } else if(i%pipeCnt ==1 ) {
	    	if(fileList[i] == "0") 
	    		fileListHTML += fileListFrontHTML+"파일"+fileListEndHTML;
	    	else 
	        	fileListHTML += fileListFrontHTML+"폴더"+fileListEndHTML;
	    
	    // 파일/폴더 사이즈
	    }else if(i%pipeCnt ==2 ) {
	    	// 파일/폴더 사이즈
	    	var tempFileSize = parseFloat(fileList[i]);
	    	if((tempFileSize/1024/1024) > 1.0) {
	    		fileListHTML += fileListFrontRightHTML + roundNum(tempFileSize/1024/1024) + " MB" +fileListEndHTML;
	    	} else {
	    		fileListHTML += fileListFrontRightHTML + roundNum(tempFileSize/1024) + " KB" +fileListEndHTML;
	      	}
	      	// 생성일
	      	fileListHTML += fileListFrontHTML + formatDateDetail(anacondaFm.anaForm.file_create.value) ;
	        fileListHTML += ' ~ ' ;
	      	// 종료일
	      	fileListHTML += formatDateDetail(anacondaFm.anaForm.file_expire.value) +fileListEndHTML;
	      
	    } 
    }

  return fileListHTML;
}


function anaFrontList(returnStr)   {

	var tempSendURL   = anacondaFm.anaForm.sendURL.value;

	var tempDownCnt   = parseInt(anacondaFm.anaForm.down_cnt.value);
  var fileFrontList = "";


  fileFrontList +=    "\n <script language='JavaScript'> ";
  fileFrontList +=    "\n <!-- ";
  fileFrontList +=    "\n function bluring(){ ";
  fileFrontList +=    "\n if(event.srcElement.tagName=='A'||event.srcElement.tagName=='IMG') document.body.focus(); ";
  fileFrontList +=    "\n } ";
  fileFrontList +=    "\n document.onfocusin=bluring; ";
  fileFrontList +=    "\n // --> ";
  fileFrontList +=    "\n </script> ";
  fileFrontList +=    "\n <br><br><table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
  fileFrontList +=    "\n <tr><td height='16' colspan=2 background='" + tempSendURL + "/image/kor/anaconda/down_dot1.gif'></td></tr>";
  fileFrontList +=    "\n <tr><td width='100' ><img src='" + tempSendURL + "/image/kor/anaconda/down_top.gif' ></td>";
  fileFrontList +=    "\n <td align='right' background='" + tempSendURL + "/image/kor/anaconda/down_dot2.gif'>";//<font color='#FF9900'>※ 첨부된 파일은 " + tempDownCnt + "회만 다운로드 하실 수 있습니다.</font>";
  fileFrontList +=    "\n </td></tr></table><table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
  fileFrontList +=    "\n <tr>";
  fileFrontList +=    "\n <td bgcolor='C4DDDD'>";
  fileFrontList +=    "\n <table width='100%' border='0' cellspacing='1' cellpadding='2'> ";
  fileFrontList +=    "\n <tr align='center' bgcolor='F3F6F7'> ";
  fileFrontList +=    "\n <td height='26'  width='60%'><strong>파일이름</strong></td> ";
  fileFrontList +=    "\n <td width='7%'><strong>형식</strong></td> ";
  fileFrontList +=    "\n <td width='10%'><strong>용량</strong></td> ";
  fileFrontList +=    "\n <td width='23%'><strong>다운로드 기간</strong></td></tr> ";


  return fileFrontList;
}


function anaEndList(returnStr)   {
  var fileEndList = "\n";

	var tempSendURL     = anacondaFm.anaForm.sendURL.value;
	var tempUsers_idx   = anacondaFm.anaForm.users_idx.value;
	var tempMail_seq     = anacondaFm.anaForm.mail_seq.value;
	var anaURL = tempSendURL + "/servlet/anaconda.AnaDownServ?cmd=popupActiveX&users_idx=" + tempUsers_idx + "&mail_seq=" + tempMail_seq;
  fileEndList +=    "\n </table></td> </tr></table><table width='100%' border='0' cellpadding='2'><tr>";
  fileEndList +=    "\n <td align='left' height='32'><a href='" + anaURL + "' target='_new'><img src='" + tempSendURL + "/image/kor/anaconda/down_04.gif' width='203' height='22' border='0' ></a></td> ";
  fileEndList +=    "\n </tr></table> ";
  return fileEndList;
}


//// file 웹으로 다운로드 메소드
//function anaDownLoad(sendURL, users_idx, mail_seq, file_seq) {
//	sendURL + ""+
//}

// 날짜 포멧 메소드
function formatDate(str, formatter) {
	
  var strDate = "";
  // 8자리인자 확인
  if(str.length == 8) {
  	strDate = str.substring(0,4) + formatter + str.substring(4,6) + formatter + str.substring(6,8);
  } else {
    strDate = str;
  }
  return strDate;
}

// 날짜 포멧 일반 메소드
function formatDateDetail(str) {
	return formatDate(str,".");
}


function roundNum(num){
 //소숫점 2자리까지(반올림)
 num = (Math.round(num*100)) / 100;
 return num;
}


// 날짜 포멧 메소드
function formatDate(str, formatter) {
	
  var strDate = "";
  // 8자리인자 확인
  if(str.length == 8) {
  	strDate = str.substring(0,4) + formatter + str.substring(4,6) + formatter + str.substring(6,8);
  } else {
    strDate = str;
  }
  return strDate;
}

// 날짜 포멧 일반 메소드
function formatDateDetail(str) {
	return formatDate(str,".");
}

