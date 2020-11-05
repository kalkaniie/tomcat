Ext.namespace('formletter_list_space');
var ds_formletter_list;
var gp_formletter_list;

formletter_list_space.formletter_list = function() {
	ds_formletter_list = new Ext.data.Store({
	     	storeId:'formletter_list_store',
	     	proxy: new Ext.data.HttpProxy({
	     		url: 'formletter.auth.do?method=aj_formletter_list',
	     		method: 'POST'
	     	}),
	     	baseParams :{strIndex: document.formletter_list_pop.strIndex.value,
	     				 strKeyword : document.formletter_list_pop.strKeyword.value
	     				 },
			reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Record',
	        	id: 'FORMLETTER_IDX',
	        	totalRecords: 'recCount'
		  	}, 
		  	['FORMLETTER_IDX','FORMLETTER_SUBJECT','CONTENT']),
		  	remoteSort: true
		});
		ds_formletter_list.load();
		ds_formletter_list.setDefaultSort('FORMLETTER_SUBJECT', 'asc');
	
		


	var cm_formletter = new Ext.grid.ColumnModel([
    	{id:'FORMLETTER_IDX',  header: '제목',dataIndex: 'FORMLETTER_SUBJECT',width:Ext.get(document.getElementById("formletter_list_div")).getWidth()-10,
    		renderer: function(value, metadata, record) {
    			var reVal="";
    			reVal = "<a href='javascript:selectForm("+record.data.FORMLETTER_IDX+")'>"+record.data.FORMLETTER_SUBJECT+"</a>";
    			return reVal;
  			}
    	},
    	{dataIndex: 'CONTENT',hidden:true}
    	]);
     
 	cm_formletter.defaultSortable = false;
	
  	gp_formletter_list = new Ext.grid.GridPanel({
    	id :'gd_formletterId',
    	layout:'fit',
    	ds: ds_formletter_list,
    	cm: cm_formletter,
    	stripeRows: true,
		height:248,
    	width:Ext.get(document.getElementById("formletter_list_div")).getWidth(),
    	autoWidth:true,
    	autoSizeColumns:true, 
    	autoScroll :true,
    	loadMask:true,
    	bbar:  new Ext.PagingToolbar({
            id :'pagingFormletterId',
            pageSize: Ext.get(document.getElementById("formletter_list_div")).getWidth(),
            store: ds_formletter_list,
            displayInfo: true,
            emptyMsg: "문서양식이 없습니다"
	    }),
	    border:true
	});
    gp_formletter_list.render("formletter_list_div");
    return {
    	init : function() {
    		Ext.EventManager.onWindowResize(function(){gp_formletter_list.setWidth(Ext.get(document.getElementById("formletter_list_div")).getWidth())}, gp_formletter_list, true);		
    	}	
	}
}();

Ext.onReady(formletter_list_space.formletter_list.init, formletter_list_space.formletter_list, true);