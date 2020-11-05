/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('boardMainSpace');

boardMainSpace.board = function() {
	var _viewPort;
	
	function tools(_bbs_idx,_title){
		return [{
	        id:'right',
	        handler: function(a, b, c){mainPanel.getActiveTab().body.load({url: "board.auth.do?method=board_list_main&BBS_IDX="+_bbs_idx+"&BBS_TYPE=1",scripts: true});}
	        }]
	};
    
	function getDataStore(_bbs_group_idx) {
		var boardDataStore = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy({
				url:'board.auth.do',
				method:'POST'
			}),
			baseParams:{method:'aj_resent_bbs_list', USERS_LISTNUM:'7', BBS_IDX:_bbs_group_idx},
			reader:new Ext.data.XmlReader({
		        record: 'Record',
		        totalRecords: 'recCount'
				}, 
				['B_IDX','BBS_IDX','USERS_IDX', 'B_NAME','B_TITLE','B_ATTACHE','B_ATTACHE_EXT','B_DATE','READARTICLE','NEWARTICLE','B_GUBUN','B_LEVEL']),
			remoteSort: false
		});
		boardDataStore.load();
		return boardDataStore;
	}
	
	var colModel = new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
			{header: '작성자 ',dataIndex:'B_NAME',width: 120,sortable:false,
				renderer:function(value, metadata, record){
					var retVal = "";
					if(record.data.B_GUBUN == "top") {
						retVal = "<img src=/images/kor/ico/board_icon_01.gif>&nbsp;&nbsp;" + record.data.B_NAME;
					} else if(record.data.B_GUBUN == "list") {
						retVal = "<img src=/images/kor/ico/board_icon_02.gif>&nbsp;&nbsp;" + record.data.B_NAME;
					}
					retVal += "(" + record.data.USERS_IDX.split('@')[0] + ")";
					
					return retVal;
				}
			},
			{header: '제목 ',dataIndex: 'B_TITLE',width: 250,
				renderer:function(value, metadata, record){
					var retVal = "";
					var str = "";
					for(var i=1; i<record.data.B_LEVEL; i++) {
						str += "&nbsp;&nbsp;&nbsp;"
					}

					if(record.data.B_LEVEL > 0) {
						str += "<img src='/images/kor/ico/icon_re.gif' border='0'>";
					}
	
					retVal += "<a href='javascript:boardMainSpace.board.board_detail(" + record.data.BBS_IDX + "," + record.data.B_IDX + ");'>"
					if(record.data.READARTICLE == "true") {
						retVal += (str + record.data.B_TITLE);
					} else if(record.data.READARTICLE == "false") {
						retVal += (str + "<b>" + record.data.B_TITLE + "</b>");
					}
					if(record.data.NEWARTICLE == "true") {
						retVal += "&nbsp;<img src=/images/kor/ico/icon_new.gif>";
					}
					retVal += "</a>"
					
					var b_attach = record.data.B_ATTACHE;
					var attachStr = "";
					var arr = new Array();
					var arrExt = new Array();
					var bbs_idx = record.data.BBS_IDX;
					var b_idx = record.data.B_IDX;
					
					if (b_attach.length > 0) {
						attachStr +="<em style='position:absolute;right:0;margin:0 10px 0 0;'>"
						arr = b_attach.split(":");
						for(var i=0; i<arr.length; i++) {
							try {
								var FileType = getFileExtImgName(Ext.util.Format.substr(arr[i], arr[i].lastIndexOf('.')+1));
								if(arr[i].length > 0)
									attachStr += "<a href='javascript:;' style='margin-left:3px;'><img src=/images/kor/ico/" + FileType[1] + " onClick=\"boardMainSpace.board.fileDownload('"+bbs_idx+"','"+b_idx+"','"+i+"','"+arr[i]+"')\" alt=\""+arr[i]+"\" style='_padding-bottom:1px'></a>";
							}catch(e) {}
						}
						attachStr +="</em>"
					}
					retVal += attachStr;
					
					return retVal;
				}
			}
		]);
	colModel.defaultSortable = false;
	
	function getBoardGrid(_bbs_group_idx,_title) {
		boardGrid = new Ext.grid.GridPanel({
			frame:true,
			title:_title,
			cls:'x-portlet',
			ds: getDataStore(_bbs_group_idx),
			cm: colModel,
			stripeRows: true,
			selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
			height:215,
			width:200,
			autoScroll :true,
			tools: tools(_bbs_group_idx,_title),
			view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:1})
		});
		
		return boardGrid;
	};
	
	function board_detail(bbs_idx, b_idx) {
		mainPanel.getActiveTab().body.load({
			url: "board.auth.do?method=detail_article&BBS_IDX="+bbs_idx+"&B_IDX="+b_idx,
			scripts: true
		});
	};
	
    function getItem(_title, _bbs_idx) {
    	var pItem = {
	        layout:'fit',
	        items: getBoardGrid(_bbs_idx,_title)
	    };
	    
	    return pItem;
    };
    
    function getItems(_pos) {
    	var items = "[";

    	for(var ii=0; ii<bbs_idx_array.length; ii++) {
            if(_pos == 'left' && ii%2 == 0) {
                    items = items + "getItem('" + bbs_name_array[ii] + "','" + bbs_idx_array[ii] + "'" + "),";
            } else if(_pos == 'right' && ii%2 == 1) {
                    items = items + "getItem('" + bbs_name_array[ii] + "','" + bbs_idx_array[ii] + "'" + "),";
            }
    	};
    	
		if (items.length == 1) {
    		items = "";
    		items = null;
    	} else {
    		items = items.substring(0,items.length-1) + "]";
    		items = eval(items);
    	}

    	var pItems = {
            columnWidth:.49,
            items:items
        };

        return pItems;
    }
    
    function getItemList() {
    	var pItemList = {
            id:'board_main_item',
            xtype:'portal',
            region:'center',
            items:[getItems('left'), getItems('right')]
       	};
       	
       	return pItemList;
    };
	
    function groupList(_organize_idx) {
    	mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=groupList&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 
    };
    
    function organize_detail(_organize_idx) {
    	mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=organize_detail&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 
    };
    
    function fileDownload(bbs_idx, b_idx, nFileNum, strFileName) {
	   	Ext.Ajax.request({
	   		url:'board.auth.do',
	   		method:'POST',
	   		params : {
	   			method:'aj_attache_chk',
	   			BBS_IDX:bbs_idx,
	   			B_IDX:b_idx, 
	   			nFileNum:nFileNum,
	   			strFileName:strFileName
	   		},
	   		success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   		record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
						var objForms = document.getElementsByTagName('form');
						var objForm ;
						for(var ii=0; ii<objForms.length; ii++) {
						  	if(objForms[ii].name == "f_board_main") {
						  		objForm = objForms[ii];
						  		break;
						  	}
						}
				
					  	objForm.BBS_IDX.value = bbs_idx;
					  	objForm.B_IDX.value = b_idx;
					  	objForm.nFileNum.value = nFileNum;
					  	objForm.strFileName.value = strFileName;
					  	objForm.submit();										
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
			},
	   		failure:function(){
	   			callAjaxFailure(response, options);
	   		}
	   	})
	};
	
	function createView() {
		var objForms = document.getElementsByTagName('form');
		var objForm ;
		for(var ii=0; ii<objForms.length; ii++) {
		  	if(objForms[ii].name == "f_board_main") {
		  		objForm = objForms[ii];
		  		break;
		  	}
		}
		
		_viewPort = new Ext.Panel({
			xtype:'panel',
			autoScroll:true,
			width: Ext.get(document.getElementById("doc-body")).getWidth()-20,		
//    		height :Ext.get(document.getElementById("doc-body")).getHeight()-60,
	        renderTo:'div_board_main'+objForm.uniqStr.value,
	        id:'id_board_main',
	        items:[getItemList()]
	    });
	};
	
    return {
    	groupList: function(_organize_idx){return groupList(_organize_idx);},
    	organize_detail: function(_organize_idx){return organize_detail(_organize_idx);},
    	board_detail: function(bbs_idx, b_idx){return board_detail(bbs_idx, b_idx);},
    	fileDownload: function(bbs_idx, b_idx, nFileNum, strFileName){return fileDownload(bbs_idx, b_idx, nFileNum, strFileName);},
    	init : function() {
			setTimeout(function(){
				createView();
			}, 300);
			//Ext.EventManager.onWindowResize(function(){Ext.getCmp('div_board_main').setWidth(Ext.get(document.getElementById("doc-body")).getWidth())}, Ext.getCmp('div_board_main'), true);		
   			//Ext.EventManager.onWindowResize(function(){Ext.getCmp('div_board_main').setHeight(Ext.get(document.getElementById("doc-body")).getHeight()-60)}, Ext.getCmp('div_board_main'), true);
    	}
    }
}();

Ext.onReady(boardMainSpace.board.init, boardMainSpace.board, true);