/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('intranet_home_space');

intranet_home_space.intranet_home = function() {
	var objForm;
    
	function tools(_bbs_idx,_title){
		return [{
	        id:'right',
	        handler: function(a, b, c){
				mainPanel.getActiveTab().body.load( {
					url: "board.auth.do?method=board_list_main&BBS_IDX="+_bbs_idx+"&BBS_TYPE=1",
					scripts: true
			    });	        	
	        }},{
		        id:'close',
		        handler: function(e, target, panel){
		            panel.ownerCt.remove(panel, true);
	        }
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
			{header: '작성자',dataIndex: 'B_NAME',width: 120,sortable:false,
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
			{header: '제목',		dataIndex: 'B_TITLE',width: 250,
				renderer:function(value, metadata, record){
					var retVal = "";
					var str = "";
					for(var i=1; i<record.data.B_LEVEL; i++) {
						str += "&nbsp;&nbsp;&nbsp;"
					}

					if(record.data.B_LEVEL > 0) {
						str += "<img src='/images/kor/ico/icon_re.gif' width='6' height='8' border='0'>";
					}
	
					if(record.data.READARTICLE == "true") {
						retVal = str + record.data.B_TITLE;
					} else if(record.data.READARTICLE == "false") {
						retVal = str + "<b>" + record.data.B_TITLE + "</b>";
					}
					if(record.data.NEWARTICLE == "true") {
						retVal += "&nbsp;<img src=/images/kor/ico/icon_new.gif>";
					}
					
					var b_attach = record.data.B_ATTACHE;
					var attachStr = "";
					var arr = new Array();
					var arrExt = new Array();
					var bbs_idx = record.data.BBS_IDX;
					var b_idx = record.data.B_IDX;
					if (b_attach.length > 0) {
						arr = b_attach.split(":");
						for(var i=0; i<arr.length; i++) {
							try {
								var FileType = FileType = getFileExtImgName(Ext.util.Format.substr(arr[i], arr[i].lastIndexOf('.')+1));
								//attachStr += "<a href='javascript:;'><img src=/images/kor/ico/" + FileType[1] + " onClick=\"fileDownload('"+bbs_idx+"','"+b_idx+"','"+i+"','"+arr[i]+"')\" alt=\""+arr[i]+"\"></a>";
							}catch(e) {}
						}
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
			height:200,
			width:200,
			autoScroll :true,
			view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:1}),
			listeners:{
		    	celldblclick:function(grid, rowIndex, columnIndex, e) {
			        var record = grid.getStore().getAt(rowIndex);
					mainPanel.getActiveTab().body.load( {
						url: "board.auth.do?method=detail_article&BBS_IDX="+record.data.BBS_IDX+"&B_IDX="+record.data.B_IDX+"&strKeyword=&strIndex=B_TITLE&startdt=&enddt=",
						scripts: true
				    });
			    }
		    }
		});
		
		return boardGrid;
	};
	
    function getItem(_title, _bbs_idx) {
    	var pItem = {
	        title: _title,
	        layout:'fit',
	        tools: tools(_bbs_idx,_title),
	        items: getBoardGrid(_bbs_idx)
	    };
	    
	    return pItem;
    };
    
    function getItems(_pos) {
    	var items = "";
		var item = "";
    	for(var ii=0; ii<bbs_idx_array.length; ii++) {
    		if(_pos == 'left' && ii%2 == 0) {
    			item = item + "getItem('" + bbs_name_array[ii] + "','" + bbs_idx_array[ii] + "'" + "),";
    		} else if(_pos == 'right' && ii%2 == 1) {
    			item = item + "getItem('" + bbs_name_array[ii] + "','" + bbs_idx_array[ii] + "'" + "),";
    		}
    	};
		
    	if (item.length != 0) {
    		item = item.substring(0,item.length-1);
    		items = "[" + item + "]";
    	}
    	
    	items = eval(items);
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
	  	objForm.BBS_IDX.value = bbs_idx;
	  	objForm.B_IDX.value = b_idx;
	  	objForm.nFileNum.value = nFileNum;
	  	objForm.strFileName.value = strFileName;
	  	objForm.submit();
	};

    return {
    	groupList: function(_organize_idx){return groupList(_organize_idx);},
    	organize_detail: function(_organize_idx){return organize_detail(_organize_idx);},
    	fileDownload: function(bbs_idx, b_idx, nFileNum, strFileName){return fileDownload(bbs_idx, b_idx, nFileNum, strFileName);},    	
    	init : function() {	
			objForm = mainPanel.getActiveTab().getEl("f_intranet_home").child('form').dom;
			BrowserCheck();
			viewPortHeight =0;
			if(isIE6)viewPortHeight = Ext.get(document.getElementById("doc-body")).getHeight()+500;
			else viewPortHeight = Ext.get(document.getElementById("doc-body")).getHeight()+300;
    		 _viewPort = new Ext.Panel({
		        xtype:'panel',
		        renderTo:'div_board_main'+objForm.uniqStr.value,
		        id:'id_board_main',
		        width: Ext.get(document.getElementById("doc-body")).getWidth()-20,		
    			height :viewPortHeight,
		        items:[getItemList()]
		    });
//		    alert(Ext.get(document.getElementById("doc-body")).getHeight())
    	}
    }
}();

Ext.onReady(intranet_home_space.intranet_home.init, intranet_home_space.intranet_home, true);