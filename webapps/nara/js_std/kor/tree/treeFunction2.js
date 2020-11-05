/* non use */
function getTreeCheckedAllNodeTextObj(str,rootName,objTree){
	var reArr = new Array();
	for( i=0; i< objTree.length; i++){
		var realName ="";
		if( objTree[i].getPath("text").indexOf(rootName) ==1 ){
			realName= objTree[i].getPath("text").substring(rootName.length+2)
		}
		
		reArr.push( (str+ realName+",").replace(/\//g, "-"));
	}
	return reArr;
}
function getTreeCheckedAllNodeTextStr(str,rootName,objTree){
	var reStr = "";
	
	for( i=0; i< objTree.length; i++){
		var realName ="";
		if( objTree[i].getPath("text").indexOf(rootName) ==1 ){
			realName= objTree[i].getPath("text").substring(rootName.length+2)
		}
		reStr += (str+ realName+",").replace(/\//g, "-");
	}
	return reStr;
}

function getTreeCheckedAllNodeIdStr(objTree){
	var reStr = "";
	if(objTree !=null){
		for( i=0; i< objTree.length; i++){
			reStr += objTree[i].id+",";
		}
		return reStr.substring(0,reStr.length-1);
	}else{
		return "";
	}
	
	
}

function getOnlyCheckNode(objTree){		
	if(objTree.length >1)
		return true;
	else	
		return false;
}

function getAllDeptNodeName(str,rootNode){	
	reArr = new Array();
	if( typeof checkedNode != "undefined"){
		for( i=0; i< checkedNode.length; i++){
			reStr="";
			reArr.push(str+getParentNode(checkedNode[i],rootNode))
		}
	}	

	return reArr;
}

function makeGroupStr(str,rootName,objTree){
	var realName ="";
	if( objTree.getPath("text").indexOf(rootName) ==1 ){
		realName= str+(objTree.getPath("text").substring(rootName.length+2)).replace(/\//g, "||");
	}
	return realName;
}

/* not use ===>>>>>>>>>*/
function getCurNodeName(){	
	reArr = new Array();
	if( typeof checkedNode != "undefined"){
		for( i=0; i< checkedNode.length; i++){
			reArr.push(checkedNode[i].attributes.text);
		}
	}	
	return reArr;
}

function getCurNodeId(){	
	reArr = new Array();
	if( typeof checkedNode != "undefined"){
		for( i=0; i< checkedNode.length; i++){
			reArr.push(checkedNode[i].attributes.id);
		}
	}	
	return reArr;
}


function getAllDeptNodeNameOnlyOne(str,rootNode){	
	reArr = new Array();
	if( typeof checkedNode != "undefined"){
			reStr="";
			reArr.push(str+getParentNode(checkedNode,rootNode))
	}	
	return reArr;
}
var reStr ="";
function getParentNode(node, rootNode){		// prarnt node 
	
	if( node.parentNode !='undefined' && node.parentNode != rootNode){
		reStr = node.attributes.text  +"||"+ reStr;
		getParentNode(node.parentNode);	
	}
	return reStr.substring(0,reStr.lastIndexOf("||"));
}
