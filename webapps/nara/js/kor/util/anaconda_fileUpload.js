function FileUpload(cmd,type,dir){
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
      fileattache.innerHTML += result;
    }else if(cmd == "emlUpload"){
      document.location.reload();
    }else if(cmd == "photoUpload"){
      fileattache.innerHTML = result;
      previewPhoto(KBbig.GetUploadedFilePath);
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
	var uploadObj = anacondaFm.KBbig;
	if( !uploadObj ) {
		alert("파일 업로드 activeX가 로드되지 못했습니다.");
		return;
	}

  uploadObj.DecFileCnt();
  var obj = eval("div_attache_file_"+nNum);
  if(obj != null){
    obj.outerHTML="";
  }

  var url = "util.UtilFileAttacheApp?cmd=attache_del&strFileName="+strFileName;
  document.fileattachFrame.location.replace(url);
}

function Images(image){
  this.image = image;
}

function insertImage(imageFilePath){
  var uniqStrThis = mainPanel.getActiveTab().getEl().child("form").dom.uniqStr.value;
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

function previewPhoto(imageFilePath){
  var images = new Array();
  var len = imageFilePath.length;
  var sit = 0;
  var ch  = '';
  var str = ""
  while (sit < len) {
    ch = imageFilePath.charAt(sit);
    if(ch != '\n'){
      str += ch;
    }
    if((ch == '\n' && sit != 0) || sit+1 == len){
      images[images.length] = new Images(str);
      str = "";
    }
    sit++;
  }
  for(i=0; i<images.length; i++){
    imagesrc = "file:///"+images[i].image.replace( /%/gi,"%25").replace( / /gi, "%20").replace( /\\/gi,"/").replace( /&/gi,"&amp;");
    photo.innerHTML = "<IMG src=\""+imagesrc+"\" width=120 height=150>"
  }
}

	function ImageAppend() {
		var uploadObj = anacondaFm.KBbig;
		if( !uploadObj ) {
			alert("파일 업로드 activeX가 로드되지 못했습니다.");
			return;
		}

		uploadObj.SetCmd("imageAttacheFile");
		uploadObj.SetDirPath("");
		uploadObj.filetype = "IMG";

		result = uploadObj.OpenFileDialog();
		if(result.substr(0,3) == "500"){
			alert("파일저장에 실패했습니다.");
			return;
		} else if(result.substr(0,3) == "600") {
			alert("사용자디스크 용량을 초과했습니다.");
			return;
		} else if(result.substr(0,3) == "700") {
			alert("파일업로드 용량을 초과했습니다.");
			return;
		}

		imageattache.innerHTML += result;
		insertImage(uploadObj.GetUploadedFilePath);
	} 

	function OverWriteType(writeType) {
		var uploadObj = anacondaFm.KBbig;
		if( !uploadObj ) {
			alert("파일 업로드 activeX 로드되지 못했습니다.");
			return;
		}
		uploadObj.OverWriteType(writeType);
	} 
 
	


	function TestUpload() {
		var uploadObj = anacondaFm.KBbig;
		if( !uploadObj ) {
			alert("파일 업로드 activeX 로드되지 못했습니다.");
			return;
		}

		uploadObj.SetCmd("webmailAttacheFile");
		uploadObj.filetype = "ALL";
		uploadObj.UploadFile();  
		return;
	} 