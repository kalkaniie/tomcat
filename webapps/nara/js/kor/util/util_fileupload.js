function FileUpload(cmd,type,dir,formName){		//formName : 서버이미지 보여주기위
  if(KBbig == null || KBbig == '')
  {
  	alert('파일 관련 activeX가 로딩 되지 못했습니다.');	
  	return;
  }
  KBbig.SetCmd(cmd);  
  KBbig.SetDirPath(dir);
  KBbig.filetype = type; //ALL,IMG,MAIL
  if(cmd == "fileAttacheFile" || cmd == "homepageAttacheFile"){
  	KBbig.maxFileCnt = 100;
  }
  if(cmd == "photoUpload" ){
    KBbig.AllowMultiSelect = false; // multi file upload false
  } 

  result = KBbig.OpenFileDialog;
  if(result.substr(0,3) == "400"){
  }else if(result.substr(0,3) == "500"){
    alert("파일저장에 실패했습니다.");
    return;
  }else if(result.substr(0,3) == "600"){
    alert("사용자디스크 용량을 초과했습니다.");
    return;
  }else if(result.substr(0,3) == "700"){
    alert("파일업로드 용량을 초과했습니다.");
    return;
  }else{
  	if(cmd == "webmailAttacheFile"){
      fileattache.innerHTML += result;
    }else if(cmd == "imageAttacheFile"){
      imageattache.innerHTML += result;
      insertImage(KBbig.GetUploadedFilePath);
    }else if(cmd == "fileAttacheFile" || cmd == "homepageAttacheFile"){
      document.file.location.reload();
    }else if(cmd == "bbsAttacheFile"){
      var elDom = mainPanel.getActiveTab().getEl().dom;
      var objForms = elDom.getElementsByTagName('form');
      var objForm ;
      
      for(var ii=0; ii<objForms.length; ii++) {
      	if(objForms[ii].name == formName) {
      		objForm = objForms[ii];
      		break;
      	}
      }

      var pipeCnt = 5;
      var fileList = result.split('|');
      var tbl = document.getElementById("file_attach_id").getElementsByTagName("TBODY")[0];
      var tempHtml ="";
	  var el;
      for( i=0; i< fileList.length-1; i++){
      	if(i%pipeCnt ==0 ) {
      		var row = document.createElement("tr");    
      		var col = document.createElement("td");     
      		row.setAttribute("id", "attatch_div"+ fileList[i+2]);
      		
      		row.appendChild(col);
      		tempHtml = "<img src='/images/kor/ico/"+ fileList[0]+"'>"
      		         + fileList[i+4] +" ("+fileList[i+1]+")<a href='javascript:removeFile(\""
      		         + fileList[i+2]+"\",\""+fileList[i+3]+"/"+fileList[i+4]+"\")'><img src='/images/kor/ico/btnD_x.gif'/></a>"
      		         ;

      		col.innerHTML = tempHtml;
      		
      		tbl.appendChild(row);
      		el = document.createElement("input");
	    	el.type="hidden";
	    	el.name="attache_file";
	    	el.value=fileList[i+3] +"/"+ fileList[i+4];
	    	objForm.appendChild(el);
	  	}
      }
    }else if(cmd == "noteAttacheFile"){
      var elDom = mainPanel.getActiveTab().getEl().dom;
      var objForms = document.getElementsByTagName('form');
      var objForm ;
      
      for(var ii=0; ii<objForms.length; ii++) {
      	if(objForms[ii].name == formName) {
      		objForm = objForms[ii];
      		break;
      	}
      }

      var pipeCnt = 5;
      var fileList = result.split('|');
      var tbl = document.getElementById("file_attach_id").getElementsByTagName("TBODY")[0];
      var tempHtml ="";

      for( i=0; i< fileList.length-1; i++){
      	if(i%pipeCnt ==0 ) {
      		var row = document.createElement("tr");    
      		var col = document.createElement("td");     
      		row.setAttribute("id", "attatch_div"+ fileList[i+2]);
      		
      		row.appendChild(col);
      		tempHtml = "<img src='/images/kor/ico/"+ fileList[0]+"'>&nbsp;"
      		         + fileList[i+4] +" ("+fileList[i+1]+")&nbsp;<a href='javascript:removeFile(\""
      		         + fileList[i+2]+"\",\""+fileList[i+3]+"/"+fileList[i+4]+"\")'><img src='/images/kor/ico/btnD_x.gif'/></a>"
      		         ;

      		col.innerHTML = tempHtml;
      		tbl.appendChild(row);
      		el = document.createElement("INPUT");
	    	el.type  = "hidden";
	    	el.name = "attache_file";
	    	el.value = fileList[i+3] +"/"+ fileList[i+4];
	    	col.appendChild(el);
      	}
      }
    }else if(cmd == "emlUpload"){
      var objForms = document.getElementsByTagName('form');
      var objForm ;
      for(var ii=0; ii<objForms.length; ii++) {
      	if(objForms[ii].name == formName) {
      		objForm = objForms[ii];
      		break;
      	}
      }
     //  alert( objForm.action);
      // alert( objForm.method.value);
      alert('편지함이 업데이트 되었습니다.');
    
//      objForm.action="user.public.do";
//	  objForm.method.value="login_form";
//      objForm.submit();
      
    }else if(cmd == "photoUpload"){
      fileattache.innerHTML = result;
      previewPhoto(result);
    }
   
  }
}

function FileToImageUpload(cmd,type,dir,str1, str2){
  KBbig.SetCmd(cmd);
  KBbig.SetDirPath(dir);
  KBbig.filetype = type; //ALL,IMG,MAIL
  result = KBbig.FileUploadX(str1, str2);
  if(result.substr(0,3) == "400"){
  }else if(result.substr(0,3) == "500"){
    alert("파일저장에 실패했습니다.");
    return;
  }else if(result.substr(0,3) == "600"){
    alert("사용자디스크 용량을 초과했습니다.");
    return;
  }else if(result.substr(0,3) == "700"){
    alert("파일업로드 용량을 초과했습니다.");
    return;
  }else{
    fileattache.innerHTML += result;
  }
}
  
function removeFile(nNum, strFileName){
//  KBbig.DecFileCnt();
//  var obj = eval("div_attache_file_"+nNum);
//  if(obj != null){
//    obj.outerHTML="";
//  }
//
//  var url = "utilfile.auth.do?method=attache_del&strFileName="+strFileName;
//  document.fileattachFrame.location.replace(url);
  KBbig.DecFileCnt();
  
  var tbl = document.getElementById("file_attach_id").getElementsByTagName("TBODY")[0];
  tbl.removeChild(document.getElementById("attatch_div"+nNum))
	    		
  var elDom = mainPanel.getActiveTab().getEl().dom;
  var objForms = elDom.getElementsByTagName('INPUT');
  var objForm ;
      
  for(var ii=0; ii<objForms.length; ii++) {
	if(objForms[ii].name == "attache_file"){
		if(objForms[ii].value == strFileName){
			objForms[ii].parentNode.removeChild(objForms[ii]);
			break;
		}
	}
  }
  
  var url = "utilfile.auth.do?method=attache_del&strFileName="+strFileName;
  document.fileattachFrame.location.replace(url);	
}

//function removeFileBbs(nNum, strFileName){
//  KBbig.DecFileCnt();
//  
//  var tbl = document.getElementById("file_attach_id").getElementsByTagName("TBODY")[0];
//  tbl.removeChild(document.getElementById("attatch_div"+nNum))
//	    			
//  var url = "utilfile.auth.do?method=attache_del&strFileName="+strFileName;
//  document.fileattachFrame.location.replace(url);
//}

function Images(image){
  this.image = image;
}

function insertImage(imageFilePath){
	var objForm = searchFormByActiveTab("form_mail_write");
	var uniqStrThis = "";
	if(objForm.uniqStr !=null) uniqStrThisobjForm.uniqStr.value;
	
  //var uniqStrThis = mainPanel.getActiveTab().getEl().child("form").dom.uniqStr.value;
  var imageArr = new Array();
  imageArr = imageFilePath.trim().split(">");
  for( i=0; i< imageArr.length; i++){
     if(imageArr[i].indexOf("<input") !=-1)
     	Ext.getCmp("editor_m_content"+uniqStrThis).insertAtCursor("<img src=\"/attache_temp/"+imageArr[i].substring(imageArr[i].indexOf("value='")+7, imageArr[i].lastIndexOf("'"))+"\">");
  }
}


function FileUploadX(dir,filenames)
{
      FileToImageUpload("webmailAttacheFile","ALL","",dir, filenames);
}

function previewPhoto(resultStr){
  var imageArr = new Array();
  imageArr = resultStr.trim().split(">");
  for( i=0; i< imageArr.length; i++){
     if(imageArr[i].indexOf("<input") !=-1)
     	picImage.innerHTML = "<img src=\"/attache_temp/"+imageArr[i].substring(imageArr[i].indexOf("value='")+7, imageArr[i].lastIndexOf("'"))+"\" width=\"120\" height=\"150\">";
  }
}

