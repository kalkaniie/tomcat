function addrNameByMailWrite(str1, str2){
	goRightDivRender(encodeURI(str1),str2)
}

function leftMBoxReload(str){
	try{
		var baseMboxTplStore = parent.document.getElementById("api").contentWindow.leftMboxDataStore; //�⺻������ �����
		baseMboxTplStore.reload();
	}catch(e){}
}

function leftMyMBoxReload(){
	try{
		parent.document.getElementById("api").contentWindow.left_base_mbox.mbox.left_mybox_mbox_reload();
	}catch(e){}
}

function leftMailBoxAllReload(){
	try{
		var baseMboxTplStore = parent.document.getElementById("api").contentWindow.leftMboxDataStore;
		baseMboxTplStore.reload();
		parent.document.getElementById("api").contentWindow.left_base_mbox.mbox.left_mybox_mbox_reload();
	}catch(e){}
}

function leftMailBoxAllReload2(){
	try{
		var baseMboxTplStore = parent.parent.document.getElementById("api").contentWindow.leftMboxDataStore;
		baseMboxTplStore.reload();
		parent.parent.document.getElementById("api").contentWindow.left_base_mbox.mbox.left_mybox_mbox_reload();
	}catch(e){}
}


function refreshLeftMboxNewCnt(mIdx,mboxIdx,isRead,mboxType){
	if( isRead=="N" || isRead=="P"){
		var parentObj = null;
		if(parent.document.getElementById("api") != null){
			parentObj = parent;
		}else if( parent.parent.document.getElementById("api") != null ){
			parentObj = parent.parent;
		}
		var curCnt = parentObj.document.getElementById("api").contentWindow.document.getElementById("left_mbox"+mboxIdx).innerHTML;
		if(curCnt !=""){
			var newCntStr = ""; 
			var newCntNum =0;
			if(curCnt.length >0){
				newCntStr = curCnt.replace("(",""); 
				newCntStr = newCntStr.replace(")","");
				if(Number(newCntStr) >=1){
					newCntNum = Number(newCntStr) -1 ;
					
				}
			}
			document.getElementById("mail_list_newCnt").innerHTML =newCntNum.toString();
			// (0) 표현 삭제  2010-04-02
			if(newCntNum.toString() == "0") {
				parentObj.document.getElementById("api").contentWindow.document.getElementById("left_mbox"+mboxIdx).innerHTML = "";	
			}else {
				parentObj.document.getElementById("api").contentWindow.document.getElementById("left_mbox"+mboxIdx).innerHTML = "("+newCntNum.toString()+")";
			}
			//(0) 표현 삭제  2010-04-02
			document.getElementById("mailTitleStr"+mIdx).className="";
			if(mboxType=="1" || mboxType=="5" || mboxType=="6"){
				curCnt = parentObj.document.getElementById("api").contentWindow.document.getElementById("leftNewMailCnt").innerHTML;
				if(Number(curCnt) >=1){
					curCnt = Number(curCnt) -1 ;
				}
				parentObj.document.getElementById("api").contentWindow.document.getElementById("leftNewMailCnt").innerHTML = curCnt.toString();
			}
		}	
	}	
}