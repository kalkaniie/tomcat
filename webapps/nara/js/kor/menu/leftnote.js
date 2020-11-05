Ext.namespace('left_note_space');
left_note_space.left_note = function() {
	function goNoteList(_idx) {
		mainPanel.getActiveTab().body.load({
			url: 'note.auth.do',
			scripts: true,
			params:{
				method:'showMain',
				NOTE_BOX_TYPE:_idx
			}
		});	
	};
	
	function goNoteReconfList() {
		mainPanel.getActiveTab().body.load({
			url: 'note.auth.do',
			scripts: true,
			params:{
				method:'note_reconf_list_form'
			}
		});	
	};
	
	return {
		goNoteList: function(_idx){return goNoteList(_idx);},
		goNoteReconfList: function(){return goNoteReconfList();},
		init : function() {}
	}
}();

left_note_space.note_regist = function() {
	var win_note_write;
	var win_organ_tree;
	
	function goNoteWrite(_note_to, _note_idx) {
		if( !(win_note_write instanceof Ext.Window)){
			win_note_write = new Ext.Window({
				id:'kebi_note_write_window',
				title:'쪽지쓰기',
				closable:true,
				width:566,
				height:452,
				plain:true,
				autoScroll:true,
				closable :false,
				autoDestroy :true,
				items:new Ext.Panel({
					autoScroll: false,
					autoSize:true,
					autoLoad:{
						url:'note.auth.do?method=note_regist_form',
						params:{
							NOTE_TO:_note_to,
							NOTE_IDX:_note_idx
						},
						scripts:true
					}
					
				}),
				tools : [{id:'close',
		        	handler: function(e, target, panel){
		            	win_note_write.destroy(win_note_write);
		            	win_note_write=null;
		        	}}
		        ],
		        listeners:{
		        	resize  : function(obj,t_wid,t_hei){
		        		try{
		        		Ext.getCmp("note_write_combo").setWidth( t_wid -180);
		        		}catch(e){}
		        	}
		        }
			});
		}
		win_note_write.show();	
	};
	
	function create_editor(_uniqStr) {
		var editor = new Ext.ux.HTMLEditor({
	      id : 'editor_note_content'+_uniqStr,
	      layout :'fit',
	      width: 550,
	      height: 240,
	      plugins: new Ext.ux.HTMLEditorImage(),
	      el:'htmleditor'+_uniqStr
	    });
	     editor.render();
	};
	
	function sendNote(type) {
		var objForms = document.getElementsByTagName('form');
		var objForm ;
		
		for(var ii=0; ii<objForms.length; ii++) {
		 	if(objForms[ii].name == "f_note_regist") {
				objForm = objForms[ii];
		 		break;
			}
		}
		
		var USERS_LIST = objForm.NOTE_TO.value.split(",");
		if (USERS_LIST.length >= 20) {
			alert( "20명이상 초과할 수 없습니다.");
			objForm.NOTE_TO.focus();
			return;
		}
		if (objForm.NOTE_TO.value.trim() == "") {
			alert( "받는 사람을 입력하세요.");
			objForm.NOTE_TO.focus();
			return;
		}
		//objForm.NOTE_CONTENT.value = Ext.getCmp("editor_note_content"+objForm.uniqStr.value).getValue();
		if (objForm.NOTE_CONTENT.value.trim() == "") {
			alert( "쪽지 내용을 입력하세요.");
			return;
		}
		
		chkValidName(type, objForm.NOTE_TO.value.trim());
	}
	
	function sendNote2(type) {
		var objForms = document.getElementsByTagName('form');
		var objForm ;
		
		for(var ii=0; ii<objForms.length; ii++) {
		 	if(objForms[ii].name == "f_note_regist") {
				objForm = objForms[ii];
		 		break;
			}
		}

		if (objForm.NOTE_TO.value.trim() == "" || objForm.NOTE_TO.value.trim() == ",") {
			alert( "받는 사람을 입력하세요.");
			objForm.NOTE_TO.focus();
			return;
		}
		
	    Ext.Ajax.request({
			url:'note.auth.do',
			method:'POST',
			form: objForm,
			success:function(response, opt){
				var reader = new Ext.data.XmlReader({
		        	record: 'RESPONSE'
				}, 
				['RESULT','MESSAGE']);
				
				var resultXML = reader.read(response);
				if (resultXML.records[0].data.RESULT == "success") {
					if(type == 1){
						closeNoteRegistWindow();
					}
					if(type == 2){
						self.close();
					}
					if(type == 3){
						Ext.getCmp("mypageNoteWrite").close();
					}
				} else {
					alert(resultXML.records[0].data.MESSAGE);
				}
			},
			failure:function(){
				alert('쪽지 발송중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.')
			}
		})
	};
	
	
	function popUserGroupTreeByNote() {
		win_organ_tree = new Ext.Window({
			id:'kebi_ext_window',
			title:'그룹선택',
			closable:true,
			width:320,
			height:345,
			plain:true,
			autoScroll:false,
			autoSize:false,
			modal:true,
			closeAction:'close',
			items:new Ext.Panel({
				autoScroll: true,
				autoSize:true,
				autoLoad:{
					url:'note.auth.do?method=usergroup_tree',
					scripts:true
				}
			})
		});

		win_organ_tree.show();	
	};
	
	function renderUserGroupTree(_userGroupIdx, _userGroupName) {
	    var tree = new Ext.tree.TreePanel({
	        el:'div_pop_usergorup_tree',
	        autoScroll:true,
	        animate:true,
	        enableDD:true,
	        containerScroll: true,
	        loader: new Ext.tree.TreeLoader({ dataUrl:'note.auth.do?method=aj_getUserGroup'})
	    });
		
		var root = new Ext.tree.AsyncTreeNode({
	        text: rootName,
	        draggable:false,
	        id:rootNode
	    });
		
	    tree.on('click', function(node, e){
			if (node.getDepth() == 0) return;
			checkedNode = node;
			var _user_group_name = getAllDeptNodeNameOnlyOne("$", _userGroupName);
			var objForms = document.getElementsByTagName('form');
			var objForm ;
			for(var ii=0; ii<objForms.length; ii++) {
			 	if(objForms[ii].name == "f_note_regist") {
					objForm = objForms[ii];
			 		break;
				}
			}
			if (objForm.NOTE_TO.value.trim() == "") {
				objForm.NOTE_TO.value = _user_group_name;
			} else {
				if (objForm.NOTE_TO.value.trim().substring(objForm.NOTE_TO.value.trim().length-1) == ",") {
					objForm.NOTE_TO.value = objForm.NOTE_TO.value.trim() + _user_group_name;
				} else {
					objForm.NOTE_TO.value = objForm.NOTE_TO.value.trim() + "," + _user_group_name;
				}	    	
			}
			if (win_organ_tree instanceof Ext.Window) {
				win_organ_tree.close();
			}			
	    });
	    
		tree.setRootNode(root);
	    tree.render();
	};

	function closeNoteRegistWindow() {
		if (win_note_write instanceof Ext.Window) {
			win_note_write.destroy(win_note_write);
		    win_note_write=null;
		}
	};
	
	function chkValidName(type){
		var objForms = document.getElementsByTagName('form');
		var objForm ;
		
		for(var ii=0; ii<objForms.length; ii++) {
		 	if(objForms[ii].name == "f_note_regist") {
				objForm = objForms[ii];
		 		break;
			}
		}
		
		var ajaxBoolean = Ext.Ajax.request({
			scope :this,
			url: 'note.auth.do',
			method : 'POST',
			params: {
				method:'aj_NameValidCheck',
				M_TO:objForm.NOTE_TO.value.trim()
			},			
			success : function(response, options) {
				try {
					var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE','VALID_M_TO','DUPL_ADDR_LIST','NOT_FOUND_ADDR_LIST']);
			  		var resultXML = reader.read(response);
			  	
			  		var duplResult = new Ext.data.XmlReader({record: 'DUPL_ADDR'},['TARGET','USERS_IDX','USERS_ID','USERS_NAME','USERS_DEPARTMENT']);
					var duplResultXML = duplResult.read(response);
					
			  		if (resultXML.records[0].data.RESULT == "success") {
		  				var toArr = new Array();
		  				toArr = resultXML.records[0].data.VALID_M_TO.split(",");
		  				var emailAddr = "";
		  				for(var i=0; i<toArr.length; i++) {
		  					if (toArr[i] != "") {
		  						emailAddr += (toArr[i] + ",");
		  					}
		  				}
		  				
		  				objForm.NOTE_TO.value = emailAddr;
		  				sendNote2(type);
			  		} else {
			  			if(resultXML.records[0].data.NOT_FOUND_ADDR_LIST != ""){
			  				if (!confirm("존재하지않는 사용자가 있습니다.\n" + resultXML.records[0].data.NOT_FOUND_ADDR_LIST + "\n 제외 하시겠습니까?")) {
			  					return;
			  				}
			  			}

			  			var VALID_M_TO = "";
			  			VALID_M_TO = resultXML.records[0].data.VALID_M_TO;
			  			if(duplResultXML.records.length > 0){
							var TARGET = new Array(), USERS_IDX = new Array(), USERS_NAME = new Array(), USERS_DEPARTMENT = new Array();
			  				arrSize = duplResultXML.records.length;
			  				
			  				for(i =0; i<arrSize; i++){
			  					TARGET.push(duplResultXML.records[i].data.TARGET);
			  					USERS_IDX.push(duplResultXML.records[i].data.USERS_IDX + " ");
			  					USERS_NAME.push(duplResultXML.records[i].data.USERS_NAME + " ");
			  					USERS_DEPARTMENT.push(duplResultXML.records[i].data.USERS_DEPARTMENT + " ");
			  				}
			  				var link_str = "webmail.auth.do?method=getLocalUser";
			  				var params = Ext.urlDecode(
			  								"USERS_IDX="+USERS_IDX+
			  								"&USERS_NAME="+USERS_NAME+
			  								"&USERS_DEPARTMENT="+USERS_DEPARTMENT+
			  								"&TARGET="+TARGET+
			  								"&VALID_M_TO="+VALID_M_TO+
			  								"&key_uniqStr="+
			  								"&gubun=note"+
			  								"&type="+type);
			  				newWindowOpen('내부사용자선택',360,150,link_str,params);		
			  			} else {
			  				objForm.NOTE_TO.value = VALID_M_TO;
			  				sendNote2(type);
			  			}
			  		}
				} catch(e) {
					return;
				}	    		
	   		},
			failure : function(response, options) {
			}
		});
	}
	
	return {
		goNoteWrite: function(_note_to, _note_idx){return goNoteWrite(_note_to, _note_idx);},
		create_editor: function(_uniqStr){return create_editor(_uniqStr);},
		sendNote: function(type) {return sendNote(type);},
		popUserGroupTreeByNote: function() {return popUserGroupTreeByNote();},
		renderUserGroupTree: function(_userGroupIdx, _userGroupName) {return renderUserGroupTree(_userGroupIdx, _userGroupName);},
		closeNoteRegistWindow: function() {return closeNoteRegistWindow();} ,
		win_note_detail_close: function() {return win_note_detail_close();},
		sendNote2: function(str) { return sendNote2(str) ;}
	}
}();
var note_detail_pop;
left_note_space.note_detail = function() {
	
	function note_detail(_note_idx, _note_isread) {
		if( !(note_detail_pop instanceof Ext.Window)){
			note_detail_pop = new Ext.Window({
				id:'kebi_ext_window',
				title:'쪽지보기',
				closable :false,
				width:400,
				autoHeight:true,
				plain:true,
				layout:'fit',
				autoScroll:true,
				pageX :400,
				pageY:200,
				autoLoad:{
					url:'note.auth.do',
					scripts:true,
					params:{
						method:'note_detail',
						NOTE_IDX:_note_idx,
						NOTE_ISREAD:_note_isread
					}
				},
				tools : [{id:'close',
		        	handler: function(e, target, panel){		        		
		            	note_detail_pop.destroy(note_detail_pop);
		            	note_detail_pop=null;
		        	}}],
				listeners:{
			    	close:function() {
				      //noteListReload();
				    }
			    }
			});		
	
			note_detail_pop.show();
		}else {
			// 기존에 미리보기 창이 있는 경우 기존창에 내용을 업데이트 한다. MODIFY ELLEPARK 
			note_detail_pop.getUpdater().update({
			url: 'note.auth.do?method=note_detail&NOTE_IDX='+_note_idx+'&NOTE_ISREAD='+_note_isread,
			scripts: true
		});		
	}	
	};
	
	function win_note_detail_close() {
		note_detail_pop.close();
	};
	

	function deleteNote(_note_idx){
		Ext.Ajax.request({
			scope :this,
			url: 'note.auth.do',
			method : 'POST',
			params: { method:'aj_remove_note',NOTE_IDX: _note_idx},
			success : function(response, options) {
				getExtAjaxMessage(response,'삭제되었습니다.',true);
				win_note_detail_close();
				noteListReload();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
		
	};
	
	function reloadNote(){
				win_note_detail_close();
				noteListReload();
	};
	
	function deleteNoteNoreload(_note_idx, _note_type){
		if(_note_type != 1) return;
		Ext.Ajax.request({
			scope :this,
			url: 'note.auth.do',
			method : 'POST',
			params: { method:'aj_remove_note',NOTE_IDX: _note_idx},
			success : function(response, options) {
				//getExtAjaxMessage(response,'삭제되었습니다.',true);
				//win_note_detail_close();
				//();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
		
	};
	
	function keepingNote(_note_idx) {
		Ext.Ajax.request({
			scope :this,
			url: 'note.auth.do',
			method : 'POST',
			params: { method:'keeping_note',NOTE_IDX: _note_idx},
			success : function(response, options) {
				getExtAjaxMessage(response,'보관함에 저장 되었습니다.',true);
				win_note_detail_close();
				noteListReload();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	};
	
	function download(_note_attache_idx){
		var objForms = document.getElementsByTagName('form');
		var objForm ;
		for(var ii=0; ii<objForms.length; ii++) {
		 	if(objForms[ii].name == "f_noto_detail") {
				objForm = objForms[ii];
		 		break;
			}
		}
		
	  	objForm.method.value="download";
	  	objForm.action="note.auth.do";
	  	objForm.NOTE_ATTACHE_IDX.value=_note_attache_idx;
	  	objForm.submit();
	};
	
	return {
		note_detail: function(_note_idx, _note_isread){return note_detail(_note_idx, _note_isread);},
    	win_note_detail_close: function(){return win_note_detail_close();},
    	deleteNote: function(_note_idx) {return deleteNote(_note_idx);},
    	deleteNoteNoreload: function(_note_idx, _note_type) {return deleteNoteNoreload(_note_idx, _note_type);},    	
		keepingNote: function(_note_idx) {return keepingNote(_note_idx);},
		download: function(_note_attache_idx) {return download(_note_attache_idx);},
		reloadNote: function() {return reloadNote(reloadNote)}
		
	}
}();

Ext.onReady(left_note_space.left_note.init, left_note_space.left_note, true);

