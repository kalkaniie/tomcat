var leftTagDataStore;
var mbox_base;
var mbox_mybox;
var myboxCookieView;
var myboxCP= new Ext.state.CookieProvider({expires: new Date(new Date().getTime()+(1000*60*60*24*30))});
Ext.namespace('left_base_mbox');
left_base_mbox.mbox = function() {
	var panel_body_style="overflow-y:scroll;overflow-x:hidden;padding:'0 0 0 0'";
	mbox_base = new Ext.tree.TreePanel({
        el:'ext_base_mbox_div',
        rootVisible:false,
        height:125,
        border:false,
        bodyBorder:false,
        width:180,
        enableDrop:true,
        margins:'0 0 0 0',
//        bodyStyle:panel_body_style,
        loader: new Ext.tree.TreeLoader({
            dataUrl:"mbox.auth.do?method=aj_getMBoxList"
        }),
        dropConfig: {
            ddGroup:"left_mbox_DD",
            dropAllowed:true,
            notifyDrop: function(source, e, data) {
                if(this.lastOverNode == null){
                	alert("옮겨 놓을 위치를 바르게 선택하여 주십시요. ");
                	return;
                }
                
                var targetId = this.lastOverNode.node.id;
	        	var gridselect = data.selections;
		        var mIdx = new Array();
		        var newCnt =0;				
		        for(i=0; i<gridselect.length; i++){
		        	mIdx.push(gridselect[i].id);
		            if(gridselect[i].data.M_ISREAD =="N" || gridselect[i].data.M_ISREAD =="P")
		            	newCnt ++;
		        }
		        Ext.Ajax.request({
			   		url: "webmail.auth.do?method=aj_drag_move_mail",
				   	params: { MBOX_IDX: targetId, M_IDX:  mIdx},
				   	success: function(response, options){
                    	data.grid.getStore().reload();
                    	leftMailBoxAllReload();
					}
                });
				return true;
            }
         }
    });
	var base_root = new Ext.tree.AsyncTreeNode({
        draggable:false
    });
    mbox_base.setRootNode(base_root);
    mbox_base.render();

	//mbox_base.on('click',  function(node,e) {    alert(1)  },  this); 
  
	
    function leftTagInit(){
    	leftTagDataStore = null;
    	document.getElementById("ext_left_tag_div").innerHTML="";
		leftTagDataStore = new Ext.data.Store({
		    	autoLoad: true,
		    	proxy: new Ext.data.HttpProxy({
		    		url: 'mailtag.auth.do?method=aj_getTagList'
		    	}),	
		    	reader : new Ext.data.XmlReader({
		    		totalRecords: 'recCount',
		   			record: 'Record',
		   			id: 'TAG_TYPE'
		            },
		            ['TAG_IMG_NAME','TAG_TYPE','TAG_NAME','VIEW_TYPE']	
		    	)
			});
			
			var leftTagTpl = new Ext.XTemplate(
				'<table>',
				'<tpl for=".">',	
				'<tpl if="this.chkTagType(TAG_TYPE) == false">',
				'<tr><td>태그정보 없음</td></tr>',
				'</tpl>',
				'<tpl if="this.chkTagType(TAG_TYPE) == true">',
				
				'<tr><td><img src="/images/kor/ico/{TAG_IMG_NAME}" style="padding-left:5px"/> <a href="javascript:goLeftAndRightDivRender(\'webmail.auth.do?method=mail_list&VIEW_TYPE=tag&TAG_TYPE={TAG_TYPE}\',\'태그-{TAG_NAME}\',\'mail\');" name="tag_info" tagtype="{TAG_TYPE}">{TAG_NAME}</a></td></tr>',
				'</tpl>',
				'</tpl>',
				'</table>',
				{
			     chkTagType: function(tag_type){
			         if (tag_type == -1) return false
			         else return true;
			     }
				}
			);
			
		leftTagDV= new Ext.DataView({
	        store: leftTagDataStore,
	        tpl: leftTagTpl,
	       	multiSelect : true,
	       	width:130,
	       	height:100,
	       	overClass:'x-view-over',
	       	itemSelector:'div.thumb-wrap'
		})
		
		var viewTag = new Ext.Panel({
			renderTo:'ext_left_tag_div',
			border:false,
			autoScroll :true,
			items:leftTagDV
		});
    }	
	function mbox_base_reload(){mbox_base.root.reload();}
	function mbox_mybox_reload(){if( mbox_mybox !=null) mbox_mybox.root.reload();} 	
	
	function getMyBoxTree(){
		if( !(mbox_mybox instanceof Ext.tree.TreePanel)){
			newobj = document.createElement("div"); 
			newobj.setAttribute("id","ext_mybox_mbox_div");
			newobj.setAttribute("style","overflow-y:hidden");
			document.getElementById('ext_mybox_mbox_div_parent').appendChild(newobj); 

			myboxCP.set("myboxView","Y");
			mbox_mybox = new Ext.tree.TreePanel({
		        id:"ext_mybox_mbox_id",
		        el:'ext_mybox_mbox_div',
		        animate:true,
		        ctCls:'k_tree',
		        rootVisible:false,
		        height:105,
		        bodyStyle:'overflow-x:hidden',
				width:175,
				autoScroll:true,
				containerScroll:true,
		        border:false,
		        bodyBorder:false,
		        enableDrop:true,
		        loader: new Ext.tree.TreeLoader({
		            dataUrl:"mbox.auth.do?method=aj_getMBoxListMyBox"
		        }),
		        dropConfig: {
		            ddGroup:"left_mbox_DD",
		            dropAllowed:true,
		            notifyDrop: function(source, e, data) {
		                if(this.lastOverNode == null){
		                	alert("옮겨 놓을 위치를 바르게 선택하여 주십시요. ");
		                	return;
		                }
		                
		                var targetId = this.lastOverNode.node.id;
			        	var gridselect = data.selections;
				        var mIdx = new Array();
				        var newCnt =0;				
				        for(i=0; i<gridselect.length; i++){
				        	mIdx.push(gridselect[i].id);
				            if(gridselect[i].data.M_ISREAD =="N" || gridselect[i].data.M_ISREAD =="P")
				            	newCnt ++;
				        }
				        Ext.Ajax.request({
					   		url: "webmail.auth.do?method=ajax_move_mail",
						   	params: { MBOX_IDX: targetId, M_IDX:  mIdx},
						   	success: function(response, options){
		                    	data.grid.getStore().reload();
		                    	leftMailBoxAllReload();
							}
		                });
						return true;
		            }
		         }
		    });
			var mybox_root = new Ext.tree.AsyncTreeNode({
		        draggable:false
		    });
		    mbox_mybox.setRootNode(mybox_root);
		    mbox_mybox.render();
		}else{
			treePanel = Ext.getCmp("ext_mybox_mbox_id");
			treePanel.destroy(treePanel,true);
			mbox_mybox = null;
			myboxCP.set("myboxView","N");
		}
	}
	function removeNode(node){
            while (node.firstChild){
                removeNode(node.firstChild);
            }
            var parentNode = node.parentNode;
            if (parentNode){
                parentNode.removeChild(node);
            }
        }

	return {
		left_base_mbox_reload:function(){return mbox_base_reload();},
		left_mybox_mbox_reload:function(){return mbox_mybox_reload();},
		leftTagInit:function(){return leftTagInit();},
		getMyBoxTree:function(){return getMyBoxTree();},
		init : function() {
			if( myboxCP.get("myboxView")=="Y"){
				getMyBoxTree();
			}
		}	
    }
}();
Ext.onReady(left_base_mbox.mbox.init, left_base_mbox.mbox, true);

function tagDivOnOff(obj){
    var obj = document.getElementById(obj);
    if(obj.style.display == "block") obj.style.display = "none";
    else obj.style.display = "block"; 
}
function tagEditMode(obj) { 
	var _tag_name = obj.getAttribute("tag_name");
	var _tag_type = obj.getAttribute("tag_type");
	var _tag_img = obj.getAttribute("tag_img");
	obj.parentNode.innerHTML = "<img src=\"/images/kor/ico/" + _tag_img + "\"/>&nbsp;<input name=\"TAG_NAME\" type=\"text\" value=\"" + _tag_name + "\"/>&nbsp;<a href=\"javascript:;\" onClick=\"tagUpdate(this);\" tag_img=\""+ _tag_img + "\" tag_type=\"" + _tag_type + "\" tag_name=\"" + _tag_name + "\"><img src=\"/images/kor/btn/btnD_modify.gif\" /></a>";
}
function tagDelete(obj) { 
	var wc= window.confirm("태그를 삭제 하시겠습니까?\n편지함 태그정보까지 삭제 됩니다.");
	if(wc){
		var _tag_type = obj.getAttribute("tag_type");
		var _tag_img = obj.getAttribute("tag_img");
		Ext.Ajax.request({
   			scope :this,
   			url: 'mailtag.auth.do?method=aj_delete_tag',
	   		method : 'POST',
	   		params: { TAG_TYPE: _tag_type},
	   		success : function(response, options) {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
		    		var resultXML = reader.read(response);
		    		if (resultXML.records[0].data.RESULT == "success") {
						if(leftTagDataStore !=null){
							leftTagDataStore.reload();
						}	
						obj.parentNode.innerHTML = "<img src=\"/images/kor/ico/" + _tag_img + "\"/>&nbsp;&nbsp;<input name=\"TAG_NAME\" type=\"text\" value=\"\"/>&nbsp;&nbsp;<a href=\"javascript:;\" onClick=\"tagAdd(this);\" tag_img=\""+ _tag_img + "\" tag_type=\"" + _tag_type + "\" tag_name=\"\"><img src=\"/images/kor/btn/btnD_entry.gif\" /></a>";
							
		    		}else{
		    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		    		}
			},
			failure : function(response, options) {
			},
			callback: function (options, success, response) {
			}
		});
	}	
}
function tagUpdate(obj) {
	var inObj = obj.parentNode.getElementsByTagName("input")[0];
	var _tag_name = inObj.value;
	var _tag_type = obj.getAttribute("tag_type");
	var _tag_img = obj.getAttribute("tag_img");
	
	var tagaddAjax = Ext.Ajax.request({
   			scope :this,
   			url: 'mailtag.auth.do?method=aj_modify_tag',
	   		method : 'POST',
	   		params: { TAG_TYPE: _tag_type, TAG_NAME:  _tag_name},
	   		success : function(response, options) {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
		    		var resultXML = reader.read(response);
		    		if (resultXML.records[0].data.RESULT == "success") {
						if(leftTagDataStore !=null){
							leftTagDataStore.reload();
						}	
						if(_tag_name==""){
							obj.parentNode.innerHTML = "<img src=\"/images/kor/ico/" + _tag_img + "\"/>&nbsp;<input name=\"TAG_NAME\" type=\"text\" value=\"" + _tag_name + "\"/>&nbsp;<a href=\"javascript:;\" onClick=\"tagAdd(this);\" tag_img=\""+ _tag_img + "\" tag_type=\"" + _tag_type + "\" tag_name=\"" + _tag_name + "\"><img src=\"/images/kor/btn/btnD_entry.gif\" /></a>";
						}else{
							obj.parentNode.innerHTML = "<img src=\"/images/kor/ico/" + _tag_img + "\"/>&nbsp;" + _tag_name + "&nbsp;&nbsp;&nbsp;<a href=\"javascript:;\" onClick=\"tagEditMode(this);\" tag_img=\""+ _tag_img + "\" tag_type=\"" + _tag_type + "\" tag_name=\"" + _tag_name + "\"><img src=\"/images/kor/btn/btnD_modify.gif\" /></a>"
							+"&nbsp;&nbsp;<a href=\"javascript:;\" onClick=\"tagDelete(this);\" tag_img=\"" + _tag_img + "\" tag_type=\"" + _tag_type + "\" tag_name=\""+ _tag_name + "\"><img src=\"/images/kor/btn/btnD_entry_del.gif\" style=\"padding: 0 5px;_padding-bottom:1px\" /></a>";;
						}	
		    		}else{
		    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		    		}
			},
			failure : function(response, options) {
			},
			callback: function (options, success, response) {
			}
		});
}

function tagAdd(obj) {
	var inObj = obj.parentNode.getElementsByTagName("input")[0];
	
	if(inObj.value == "") {
		alert("태그명을 입력하세요. ");
		inObj.focus();
		return;
	} else {
		var _tag_name = inObj.value;
		var _tag_type = obj.getAttribute("tag_type");
		var _tag_img = obj.getAttribute("tag_img");
		
		var tagaddAjax = Ext.Ajax.request({
   			scope :this,
   			url: 'mailtag.auth.do?method=aj_modify_tag',
	   		method : 'POST',
	   		params: { TAG_TYPE: _tag_type, TAG_NAME:  _tag_name},
	   		success : function(response, options) {
				var reader = new Ext.data.XmlReader({
		    		   	record: 'RESPONSE'
		    			}, 
		    			['RESULT','MESSAGE']);
		    		var resultXML = reader.read(response);
		    		if (resultXML.records[0].data.RESULT == "success") {
						if(leftTagDataStore !=null){
							leftTagDataStore.reload();
						}	
						obj.parentNode.innerHTML = "<img src=\"/images/kor/ico/" + _tag_img + "\"/>&nbsp;&nbsp;" + _tag_name + "<a href=\"javascript:;\" onClick=\"tagEditMode(this);\" tag_img=\""+ _tag_img + "\" tag_type=\"" + _tag_type + "\" tag_name=\"" + _tag_name + "\">&nbsp;<img src=\"/images/kor/btn/btnD_modify.gif\" /></a>"
												   +"&nbsp;&nbsp;<a href=\"javascript:;\" onClick=\"tagDelete(this);\" tag_img=\"" + _tag_img + "\" tag_type=\"" + _tag_type + "\" tag_name=\""+ _tag_name + "\"><img src=\"/images/kor/btn/btnD_entry_del.gif\" style=\"padding: 0 5px;_padding-bottom:1px\" /></a>";
		    		}else{
		    			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		    		}
				
			},
			failure : function(response, options) {
			},
			callback: function (options, success, response) {
			}
		});
		
	}
}
function private_box_create(){
	newWindowOpen('편지함생성',300,200,'/mail/mbox.auth.do?method=create_form');
}
function private_box_on_off(){
	mbox_base.getRootNode().childNodes[4].toggle();
}