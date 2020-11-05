/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
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
			['B_IDX','BBS_IDX','B_NAME','B_TITLE','B_ATTACHE','B_ATTACHE_EXT','B_DATE','READARTICLE','NEWARTICLE','B_GUBUN']),
		remoteSort: false
		//sortInfo:{field:'B_DATE', direction:'DESC'}
	});
	boardDataStore.load();
	
	return boardDataStore;
}

var colModel = new Ext.grid.ColumnModel([
		new Ext.grid.RowNumberer(),
		{header: '작성자',dataIndex: 'B_NAME',width: 80,sortable:false,
			renderer:function(value, metadata, record){
				var retVal = "";

				if(record.data.B_GUBUN == "top") {
					retVal = "<img src=/images/kor/ico/board_icon_01.gif>&nbsp;&nbsp;" + record.data.B_NAME;
				} else if(record.data.B_GUBUN == "list") {
					retVal = "<img src=/images/kor/ico/board_icon_02.gif>&nbsp;&nbsp;" + record.data.B_NAME;
				}
				
				return retVal;
			}
		},
		{header: '제목',		dataIndex: 'B_TITLE',width: 250}
	]);
colModel.defaultSortable = false;

function getBoardGrid(_bbs_group_idx) {
	boardGrid = new Ext.grid.EditorGridPanel({
		ds: getDataStore(_bbs_group_idx),
		cm: colModel,
		stripeRows: true,
		selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
		height:200,
		width:600,
		enableDragDrop: true,
		enableColumnMove: true,
		autoScroll :true,
		//baseCls: 'x-panel',
		listeners:{
	    	celldblclick:function(grid, rowIndex, columnIndex, e) {
		        var record = grid.getStore().getAt(rowIndex);  
		        var d = record.data;
		        //gridClicked(d.M_IDX);
		    }
	    }
	});
	
	return boardGrid;
}
 
