/* non use */
function getAllNonRootNodeNodeName(rootNode){
	var bb = Ext.query('input:checked')
	
	returnNodeName  = new Array(); 
	
	for(i=0; i<bb.length;i++){
		
		var pNode = bb[i].parentNode.parentNode.parentNode.parentNode.childNodes[0];
		var cNode = bb[i].parentNode.parentNode.childNodes[0];
		var pNodeText =""; 
		var cNodeText="";
		
		var cNodeId = bb[i].parentNode.getAttribute('ext:tree-node-id');
		var pNodeId =pNode.parentNode.childNodes[0].getAttribute('ext:tree-node-id');
		
		if( rootNode != pNodeId){
			//alert(typeof pNode.innerText);
			if( typeof pNode.innerText != "undefined")  pNodeText = pNode.innerText;	else  pNodeText = pNode.textContent;
			if( typeof cNode.innerText != "undefined") 	cNodeText = cNode.innerText;	else  cNodeText = cNode.textContent;
			returnNodeName.push("$"+pNodeText+"-"+cNodeText);
			
		}else{
			//alert(typeof pNode.innerText);
			if( typeof cNode.innerText != "undefined") cNodeText = cNode.innerText;  else cNodeText = cNode.textContent;
			returnNodeName.push("!"+cNodeText);
		
		}
	}
	return returnNodeName;
}
function getOnlyCheckNode(){		
	if( typeof checkedNode != "undefined"){
		if( checkedNode.length ==0){
			return false;
		}else if( checkedNode.length >1){
			return false;
		}else{
			return true;
		}	
	}	
	return false;
}

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
