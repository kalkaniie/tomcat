Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';
var leftTagDataStore;
var mbox_base;
var mbox_mybox;
var myboxCookieView;
var myboxCP= new Ext.state.CookieProvider({expires: new Date(new Date().getTime()+(1000*60*60*24*30))});

Ext.namespace('left_base_mbox');
left_base_mbox.mbox = function() {
	var panel_body_style="overflow-y:auto; overflow-x:hidden; width:100%; backgroundcolor:#F6F6F6; color:#4C5B5E; margin:0;";
//	mbox_base = new Ext.tree.TreePanel({
//        el:'ext_base_mbox_div',
//        animate:true,
//        rootVisible:false,
//        height:115,
//        border:false,
//        margins:'0,0,0,0',
//        bodyBorder:false,
//        enableDrop:true,
//        loader: new Ext.tree.TreeLoader({
//            dataUrl:"mbox.auth.do?method=aj_getMBoxList"
//        }),
//        dropConfig: {
//            ddGroup:"left_mbox_DD",
//            dropAllowed:true,
//            notifyDrop: function(source, e, data) {
//                if(this.lastOverNode == null){
//                	alert("옮겨 놓을 위치를 바르게 선택하여 주십시요. ");
//                	return;
//                }
//                
//                var targetId = this.lastOverNode.node.id;
//	        	var gridselect = data.selections;
//		        var mIdx = new Array();
//		        var newCnt =0;				
//		        for(i=0; i<gridselect.length; i++){
//		        	mIdx.push(gridselect[i].id);
//		            if(gridselect[i].data.M_ISREAD =="N" || gridselect[i].data.M_ISREAD =="P")
//		            	newCnt ++;
//		        }
//		        Ext.Ajax.request({
//			   		url: "webmail.auth.do?method=aj_drag_move_mail",
//				   	params: { MBOX_IDX: targetId, M_IDX:  mIdx},
//				   	success: function(response, options){
//                    	data.grid.getStore().reload();
//                    	leftMailBoxAllReload();
//					}
//                });
//				return true;
//            }
//         }
//    });
//	var base_root = new Ext.tree.AsyncTreeNode({
//        draggable:false
//    });
//    mbox_base.setRootNode(base_root);
//    mbox_base.render();
//	  
	function mbox_base_reload(){}
	function mbox_mybox_reload(){if( mbox_mybox !=null) mbox_mybox.root.reload();} 	
	
	function getMyBoxTree(){
		if( !(mbox_mybox instanceof Ext.tree.TreePanel)){
			
			newobj = document.createElement("div"); 
			newobj.setAttribute("id","ext_mybox_mbox_div");
			newobj.setAttribute("style","overflow-y:hidden");
			document.getElementById('ext_mybox_mbox_div_parent').appendChild(newobj); 
			document.getElementById('ext_mybox_mbox_div_parent').style.height ="190px";
			myboxCP.set("myboxView","Y");
			mbox_mybox = new Ext.tree.TreePanel({
		        id:"ext_mybox_mbox_id",
		        el:'ext_mybox_mbox_div',
		        animate:true,
		        rootVisible:false,
		        bodyStyle:'overflow:hidden;background:#F6F6F6',
				width:166,
		        border:false,
		        autoScroll:true,
		        containerScroll: true,
		        bodyBorder:false,
		        enableDrop:true,
		        hideMode: 'offsets',
		        loader: new Ext.tree.TreeLoader({
		            dataUrl:"/mail/mbox.auth.do?method=aj_getMBoxListMyBox"
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
		         },
		         listeners:{
			    	expandnode :function(node) {
			    		if( mbox_mybox.getRootNode().childNodes.length >10){
			    			this.getTreeEl().setHeight(190);
			    		}else{
			    			if( node != mbox_mybox.getRootNode() && node.childNodes != null){
			    				this.getTreeEl().setHeight(190);
			    				document.getElementById('ext_mybox_mbox_div_parent').style.height =190 +"px";
			    			}else{
			    				this.getTreeEl().setHeight( (mbox_mybox.getRootNode().childNodes.length) *19);
			    				document.getElementById('ext_mybox_mbox_div_parent').style.height =(mbox_mybox.getRootNode().childNodes.length)*19 +"px";
			    			}
			    		}
				    }
			    }
		         
		    });
			var mybox_root = new Ext.tree.AsyncTreeNode({
		        draggable:false
		    });
		    mbox_mybox.setRootNode(mybox_root);
		    
		    //Ext.getCmp('api-tree').add(mbox_mybox);
		    mbox_mybox.render();

		}else{
			treePanel = Ext.getCmp("ext_mybox_mbox_id");
			treePanel.destroy(treePanel,true);
			mbox_mybox = null;
			myboxCP.set("myboxView","N");
			document.getElementById('ext_mybox_mbox_div_parent').style.height ="0px";
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

function private_box_create(){
	newWindowOpen('편지함생성',300,200,'/mail/mbox.auth.do?method=create_form');
}
function private_box_on_off(){
	mbox_base.getRootNode().childNodes[4].toggle();
}