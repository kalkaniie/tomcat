var proc='mail';
var	s_mail_store;
var	s_bbs_store;

function createMailStore(){
	s_mail_store= new Ext.data.Store({
		proxy: new Ext.data.HttpProxy({url: '/mail/webmail.auth.do',method: 'POST'}),
	 	reader: new Ext.data.XmlReader({record: 'Record',id: 'M_IDX',totalRecords: 'recCount'}, 
	  	['M_IDX','M_ISREAD','MBOX_NAME','M_TO','M_TITLE','M_TIME','M_SIZE','M_ATTACHE']),
	  	remoteSort: false
	});
	return s_mail_store;
}	

function createBbsStore(){
	s_bbs_store= new Ext.data.Store({
		proxy: new Ext.data.HttpProxy({url: '/mail/board.auth.do',	method: 'POST'}),
		reader: new Ext.data.XmlReader({record: 'Record',id: 'B_IDX',totalRecords: 'recCount'}, 
	  	['BBS_IDX','B_IDX','B_TITLE','B_NAME','B_CONTENT','B_DATE','B_READ_NUM']),
	  	remoteSort: false
	});
	return s_bbs_store;
}	
var s_mail_cm = new Ext.grid.ColumnModel([
	new Ext.grid.RowNumberer(),
	{id:'M_IDX',  header: '구분',dataIndex: 'M_ISREAD',width:40,sortable:false,renderer:mail_status},
	{header: '보낸사람',dataIndex: 'M_TO',width: 100},
	{header: '제목',	dataIndex: 'M_TITLE',width: 320,
		renderer: function(value, metadata, record) {
			var reVal="";
			if( record.data.M_TITLE =="") reVal = "No Subject"; else reVal = record.data.M_TITLE;
			if(record.data.M_ISREAD =="N" || record.data.M_ISREAD =="P") reVal = "<b>"+reVal+"</b>" 
			else reVal =reVal;
			return reVal;
		}
	},
	{header: '날짜',dataIndex:'M_TIME',width:130,sortable:false},
	{header: '크기',dataIndex:'M_SIZE',width:80,sortable:false,
		renderer: function(value, metadata, record) {
			var reVal="";
			if(record.data.M_ATTACHE!="") reVal = "<img src=/images/kor/ico/ico_att.gif>";
			reVal += parseInt(Number(record.data.M_SIZE)/1024) ;
			reVal +=" KB";
			return reVal;
		}
	}
]);
s_mail_cm.defaultSortable = false;
	 
var s_bbs_cm = new Ext.grid.ColumnModel([
	new Ext.grid.RowNumberer(),
	{id:'M_IDX',header:'제목',dataIndex:'B_TITLE',sortable:false},
	{header: '글쓴이',dataIndex:'B_NAME',width: 100},
	{header: '날짜',dataIndex:'B_DATE',width: 200},
	{header: '조회수',dataIndex:'B_READ_NUM',width: 100}
]);
s_bbs_cm.defaultSortable = false;

var searchGridMail ;
var pagingbar_search;
function createMailGrid(){
	searchGridMail =  new Ext.grid.GridPanel({
		id :'search_grid_mail',
    	ds: s_mail_store,
    	cm: s_mail_cm,
    	stripeRows: true,
    	selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
    	height:300,
    	width:649,
    	loadMask: true,
    	autoScroll :true,
    	renderTo : 'search_result_div_mail',
    	view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
    	listeners:{
	    	rowclick:function(grid, rowIndex, columnIndex, e) {
	        	goMailPrewView(grid.getStore().getAt(rowIndex).data.M_IDX,"search");
	    	}
    	}
	});
	
	pagingbar_search = new Ext.NumberPagingToolbar(
		'search_bbar',
        s_mail_store,
        {
        pageSize:USERS_LISTNUM,
        id:'search_bbar',
        width:300,
        height:25
        }
    );
}

var searchGridBbs;
function createBbsGrid(){
 	searchGridBbs = new Ext.grid.GridPanel({
		id :'search_grid_bbs',
    	ds: s_bbs_store,
    	cm: s_bbs_cm,
    	stripeRows: true,
    	selModel: new Ext.grid.RowSelectionModel({singleSelect:false}),
    	height:300,
    	width:649,
    	loadMask: true,
    	autoScroll :true,
    	view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
    	listeners:{
		    	rowclick:function(grid, rowIndex, columnIndex, e) {
		        	goBbsPrewView(grid.getStore().getAt(rowIndex).data.BBS_IDX, grid.getStore().getAt(rowIndex).data.B_IDX, "search");
		    	}
    	}
	});
	pagingbar_search = new Ext.NumberPagingToolbar(
			'search_bbar',
            s_bbs_store,
            {
            pageSize:USERS_LISTNUM,
            id:'search_bbar',
            width:300,
            height:25
            }
       );
}