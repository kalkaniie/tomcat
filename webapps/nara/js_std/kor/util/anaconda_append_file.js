function anaList(returnStr)   { 
	var pipeCnt = 4;
	var fileList     = "";
	var fileListHTML = "";

	var fileListFrontHTML = "<td  style='text-align:center; line-height:20px'>";
	var fileListEndHTML = "</td>";

	var fileListSize = 0;
	if(returnStr.length > 0) {
	  returnStr = returnStr.substring(0,returnStr.length-1);
	}
	
	fileList     = returnStr.split('|');
	fileListSize = fileList.length;
	var chkDirArr ;
		
	// 다운로드에 필요한 개체 입력
	var objForm = document.form_mail_write;
	var uniqStrThis = objForm.uniqStr.value;
	
	var currForm = eval("anacondaFm"+uniqStrThis+".anaForm"+uniqStrThis);
	var tempSendURL   = currForm.sendURL.value;
	var tempUsers_idx = currForm.users_idx.value;
	var tempMail_seq  = currForm.mail_seq.value;
	var tempMailServletUrl = currForm.mailServletURL.value;
	var tempFile_seq  = 0;

	var chkDirPath="";
	var delSlashName ="" ; 			//웹하드에서 메일로 첨부시
	for(i=0;i<fileListSize;i++) {
		// 파일/폴더명 + 링크 걸기
	    if(i%pipeCnt ==0 ) {
	    	fileListHTML += "<tr>";
	    	if( fileList[i+1] =="0"){
	    		fileListHTML += "<td style='text-align:left; padding-left:10px'><img src='" + tempSendURL + "/images/kor/ico/ico_file.gif' style='padding-right:2px'/> ";
		    	//fileListHTML += "<a href=\"javascript:arkFileDownLoad('" + tempMail_seq + "','" + tempFile_seq + "','" + tempMailServletUrl + "anaconda.public.do?method=file_download&USERS_IDX=" + tempUsers_idx + "&MAIL_SEQ=" + tempMail_seq + "&FILE_SEQ=" + tempFile_seq + "');\">";
		      	delSlashName ="";
		      	if( fileList[i].indexOf("/") != -1){
		      		delSlashName = fileList[i].substring( fileList[i].lastIndexOf("/")+1);
		      	}else {
		      		delSlashName = 	fileList[i];
		      	}	
		      	fileListHTML += delSlashName;
		      	//fileListHTML += "</a>";
	      	}else{
	    		fileListHTML += "<td style='text-align:left; padding-left:10px'><img src='" + tempSendURL + "/images/kor/ico/ico_file.gif' style='padding-right:2px'/>";
		    	//fileListHTML += "<a href=\"javascript:arkFolderDownLoad('" + tempMailServletUrl + "anaconda.public.do?method=popupActiveX&USERS_IDX=" + tempUsers_idx + "&MAIL_SEQ=" + tempMail_seq+"';)\">";
	    		fileListHTML += "<a href=\"javascript:arkFolderDownLoad('" + tempMailServletUrl + "anaconda.public.do?method=popupActiveX&USERS_IDX=" + tempUsers_idx + "&MAIL_SEQ=" + tempMail_seq+"';)\">";
		      	fileListHTML += fileList[i];
		      	//fileListHTML += "</a>";
	    	}
	      	fileListHTML += fileListEndHTML;
	      	// FILE_SEQ 증가
	      	if( Number(fileList[i+3] >1)){		//폴더일경우
	      		tempFile_seq = tempFile_seq + Number(fileList[i+3])+1;
	      	}else{								// 파일일경우
	    		tempFile_seq++;
	    	}	
	
	    // 파일/폴더 구분 플래그
	    } else if(i%pipeCnt ==1 ) {
	    	if(fileList[i] == "0") 
	    		fileListHTML += fileListFrontHTML+"&#54028;&#51068;"+fileListEndHTML;
	    	else 
	        	fileListHTML += fileListFrontHTML+"&#54260;&#45908;"+fileListEndHTML;
	    
	    // 파일/폴더 사이즈
	    }else if(i%pipeCnt ==2 ) {
	    	// 파일/폴더 사이즈
	    	var tempFileSize = parseFloat(fileList[i]);
	    	if((tempFileSize/1024/1024) > 1.0) {
	    		fileListHTML += fileListFrontHTML + roundNum(tempFileSize/1024/1024) + " MB" +fileListEndHTML;
	    	} else {
	    		fileListHTML += fileListFrontHTML + roundNum(tempFileSize/1024) + " KB" +fileListEndHTML;
	      	}
	      	// 생성일
	      	fileListHTML += fileListFrontHTML + formatDateDetail(currForm.file_create.value) ;
	        fileListHTML += ' ~ ' ;
	      	// 종료일
	      	fileListHTML += formatDateDetail(currForm.file_expire.value) +fileListEndHTML;
	      
	    } 
    }
	fileListHTML += "</table>";
  return fileListHTML;
}


function anaFrontList()   {
	var objForm = document.form_mail_write;
	var uniqStrThis = objForm.uniqStr.value;
	var currForm = eval("anacondaFm"+uniqStrThis+".anaForm"+uniqStrThis);
	
	var tempSendURL   = currForm.sendURL.value;
	var tempUsers_idx   = currForm.users_idx.value;
	var tempMail_seq     = currForm.mail_seq.value;
	var tempMailServletUrl = currForm.mailServletURL.value;
	var anaURL = tempMailServletUrl + "anaconda.public.do?method=popupActiveX&USERS_IDX=" + tempUsers_idx + "&MAIL_SEQ=" + tempMail_seq;	
	var fileFrontList="";
  	fileFrontList +=  "<table style='border-collapse:collapse;width:100%; border:1px solid #cacaca; border-width:0px 1px 1px 1px;'>";
  	fileFrontList +=  "<caption style='background:#cacaca url(" + tempSendURL + "/images/kor/bullet/arrow_right2.gif) no-repeat 9px 7px; text-align:left;color:#2d2c2c;font-weight:bold;line-height:18px;padding:2px 0 0 17px;display:block;position:relative'>";
  	fileFrontList +=  "대용량첨부파일<span style='position:absolute;right:5px;top:2px'><a href=\'" + anaURL + "' target='_new'><img src='" + tempSendURL + "/images/kor/btn/btnB_savePc.gif' border=0 /></a></span>";
  	fileFrontList +=  "</caption>";
  	fileFrontList +=  "<tr>";
  	fileFrontList +=  "<th style='background:#ececec url(" + tempSendURL + "/images/kor/line/2tonG_14px.gif) no-repeat left 2px; border-top:1px solid #fff; border-bottom:1px solid #cacaca; text-align: center; line-height: 19px; font-weight: normal;'>파일명</th>";
  	fileFrontList +=  "<th width='74' style='background:#ececec url(" + tempSendURL + "/images/kor/line/2tonG_14px.gif) no-repeat left 2px; border-top:1px solid #fff; border-bottom:1px solid #cacaca; text-align: center; line-height: 19px; font-weight: normal;'>형식</th>";
  	fileFrontList +=  "<th width='90' style='background:#ececec url(" + tempSendURL + "/images/kor/line/2tonG_14px.gif) no-repeat left 2px; border-top:1px solid #fff; border-bottom:1px solid #cacaca; text-align: center; line-height: 19px; font-weight: normal;'>용량</th>";
  	fileFrontList +=  "<th width='150' style='background:#ececec url(" + tempSendURL + "/images/kor/line/2tonG_14px.gif) no-repeat left 2px; border-top:1px solid #fff; border-bottom:1px solid #cacaca; text-align: center; line-height: 19px; font-weight: normal;'>다운로드기간</th>";
  	fileFrontList +=  "</tr>";
  return fileFrontList;
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