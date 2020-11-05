Ext.namespace('note_list_space');
var ds_note_list;
var note_gridPn;

note_list_space.note_list = function() {	
	var objForm = getNotFormObj();
	
	function getNotFormObj() {
		var objForms = document.getElementsByTagName('form');
		var objForm ;
		for(var ii=0; ii<objForms.length; ii++) {
		 	if(objForms[ii].name == "f_note_list") {
				objForm = objForms[ii];
		 		break;
			}
		}
		
		return objForm;
	};
	
	function expandedRow(obj, record, body, rowIndex){
        id = "myrow-" + record.data.NOTE_IDX
        id2 = "mygrid-" + record.data.NOTE_IDX  
		       
       	var gridX = new Ext.Panel({
	        //width:700,
	        height:300,
	        autoWidth:true,
	        autoLoad: {
	       		url: 'note.auth.do?method=note_detail&viewMode=iframe&NOTE_IDX='+record.data.NOTE_IDX
	       	},	
	    	autoScroll :true,
        	autoHeight :true        	 
        });        
        
        gridX.render(id);
    };
    
    function collapseRow(obj, record, body, rowIndex){
	    ds_note_list.reload();
    };
    
	var expander = new Ext.grid.RowExpander({
        tpl : new Ext.Template('<div id="myrow-{NOTE_IDX}"></div>'),
        enableCaching: true,
        single: true,
        listeners : {
			expand:expandedRow,
    		collapse:collapseRow
        }
    });
    
	var ds_note_list = new Ext.data.Store({
		proxy: new Ext.data.HttpProxy({
     		url: 'note.auth.do',
     		method: 'POST'
     	}),
     	baseParams: {
     		method:'aj_note_list',
     		NOTE_BOX_TYPE:objForm.NOTE_BOX_TYPE.value,
     		NOTE_ISREAD:objForm.NOTE_ISREAD.value,
     		strIndex:objForm.strIndex.value,
     		strKeyword:objForm.strKeyword.value,
     		orderCol:objForm.orderCol.value,
     		orderType:objForm.orderType.value
      	},	      	
		reader: new Ext.data.XmlReader(
 	 	{
        	record: 'Record',
        	id: 'NOTE_IDX',
        	totalRecords: 'recCount'
	  	}, 
	  	['NOTE_IDX',
	  	 'NOTE_BOX_TYPE',
	  	 'NOTE_FROM',
	  	 'NOTE_TO',
	  	 'NOTE_SAVE_YN',
	  	 'NOTE_TITLE',
	  	 'NOTE_CONTENT',
	  	 'NOTE_TIME',
	  	 'REF_NOTE_IDX',
	  	 'NOTE_ISREAD',
	  	 'NOTE_ATTACHE_CNT',
	  	 'NOTE_SEND_CNT',
	  	 'NOTE_READ_TIME',
	  	 'NOTE_FROM_USERS_NAME',
	  	 'NOTE_TO_USERS_NAME'
	  	]),
	  	remoteSort: false
	});

	function setSenderHeaderTitle() {
		var objForm = getNotFormObj();
		
		var reVal = "";
		if (objForm.NOTE_BOX_TYPE.value == 1) {
			reVal = "보낸사람";
		} else if (objForm.NOTE_BOX_TYPE.value == 2) {
			reVal = "받는사람";
		} else if (objForm.NOTE_BOX_TYPE.value == 3) {
			reVal = "받는사람";
		} else {	
			reVal = "받는사람";
		}
		
		return reVal;
	};
	
	function setTimeHeaderTitle() {
		var objForm = getNotFormObj();
		
		var reVal = "";
		if (objForm.NOTE_BOX_TYPE.value == "1") {
			reVal = "받은시간";
		} else if (objForm.NOTE_BOX_TYPE.value == "2") {
			reVal = "보낸시간";
		} else if (objForm.NOTE_BOX_TYPE.value == "3") {	
			reVal = "받은시간";
		} else {	
			reVal = "받은시간";
		}
		
		return reVal;
	};
	
	var sm_note_list = new Ext.grid.CheckboxSelectionModel();
	var cm_note_list = new Ext.grid.ColumnModel([
		expander,
    	sm_note_list,
    	{id:'NOTE_IDX', header:setSenderHeaderTitle(),width: 150,
    		renderer:function(value,metadata,record){
				var reVal = "";
				if (record.data.NOTE_BOX_TYPE == 1) {
					reVal = record.data.NOTE_FROM_USERS_NAME;
				} else {
					reVal = record.data.NOTE_TO_USERS_NAME;
				}
    			
    			return reVal;
    		}
    	},
    	{header: '제목',width:500,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			if (record.data.NOTE_ISREAD != "Y") {
    				reVal = "<a href=\"javascript:left_note_space.note_detail.note_detail('" + record.data.NOTE_IDX + "','" + record.data.NOTE_ISREAD + "')\" class='a_normal_click'><B>" + record.data.NOTE_TITLE + "</B></a>";
    			} else {
    				reVal = "<a href=\"javascript:left_note_space.note_detail.note_detail('" + record.data.NOTE_IDX + "','" + record.data.NOTE_ISREAD + "')\" class='a_normal_click'>" + record.data.NOTE_TITLE + "</a>";
    			}
    			
    			return reVal;
    		}
    	},
    	{header:setTimeHeaderTitle(),width: 200,
    		renderer:function(value,metadata,record){
				return record.data.NOTE_TIME;
    		}
    	}
    ]);	
	cm_note_list.defaultSortable = false;

	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-101;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-103;
	
	note_gridPn = new Ext.grid.GridPanel({
    	id:'grid_note_list',
        el:'div_note_list',
        sm: sm_note_list,
        store: ds_note_list,
        cm: cm_note_list,
        trackMouseOver:false,
		height:browserHeight,
        width:Ext.get(document.getElementById("doc-body")).getWidth(),
		autoSizeColumns:true,
		autoScroll :true,
		loadMask: true,
		plugins: expander,
	    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0})
    });

    note_gridPn.render();
	ds_note_list.load({params:{start:0, limit:USERS_LISTNUM}});
	
	var pagigBar=  new Ext.NumberPagingToolbar(
		'id_paging_note',
        ds_note_list,
        {
        pageSize:objForm.USERS_LISTNUM.value,
        id:'id_paging_note',
        width:300,
        height:25
        }
   	);

    note_gridPn.getView().on('refresh', function(){ 
        Ext.each(note_gridPn.view.getRows(),function(row) { 
            record = note_gridPn.store.getAt(row.rowIndex); 
            if (expander.state[record.id]) 
                { 
                    expander.expandRow(row); 
                } 
        });
	});

	function deleteNote(){
		var selected_key= new Array();
		if(!isGridSelectedRowId(this.note_gridPn, selected_key)){
			alert("삭제할 쪽지 목록을 선택하십시오.");
			return;
		}
		
		if (confirm("선택하신 쪽지를 삭제 하시겠습니까?")) {
			Ext.Ajax.request({
				scope :this,
				url: 'note.auth.do',
				method : 'POST',
				params: { method:'aj_remove_note',NOTE_IDX: selected_key},
				success : function(response, options) {
					getExtAjaxMessage(response,'삭제되었습니다.',true);
					ds_note_list.reload();
				},
				failure : function(response, options) {callAjaxFailure(response, options);}
			});
		}
	};
	
	function noteListReload() {
		ds_note_list.reload();
	};
	
	function search_note() {
		var objForm = getNotFormObj();
		
		mainPanel.getActiveTab().body.load( {
			url: "note.auth.do",
			scripts: true,
			params:{
				method:'showMain',
				NOTE_BOX_TYPE:objForm.NOTE_BOX_TYPE.value, 
				strIndex: objForm.strIndex.value,
				strKeyword :objForm.strKeyword.value,
				orderCol :objForm.orderCol.value,
				orderType :objForm.orderType.value
			}
	    });
	};
	
	function keepingNote() {
		var selected_key= new Array();
		if(!isGridSelectedRowId(this.note_gridPn, selected_key)){
			alert("보관할 쪽지 목록을 선택하십시오.");
			return;
		}
		
		if (confirm("선택하신 쪽지를 보관 하시겠습니까?")) {
			Ext.Ajax.request({
				scope :this,
				url: 'note.auth.do',
				method : 'POST',
				params: { method:'keeping_note',NOTE_IDX: selected_key},
				success : function(response, options) {
					getExtAjaxMessage(response,'보관함에 저장 되었습니다.',true);
					ds_note_list.reload();
				},
				failure : function(response, options) {callAjaxFailure(response, options);}
			});
		}
	};

	function loadNoteList(_note_isread) {
		var objForm = getNotFormObj();
		
    	mainPanel.getActiveTab().body.load({
			url: "note.auth.do",
			scripts: true,
			params:{
				method:'showMain',
				NOTE_BOX_TYPE:objForm.NOTE_BOX_TYPE.value,
				NOTE_ISREAD:_note_isread,
				strIndex:objForm.strIndex.value,
	     		strKeyword:objForm.strKeyword.value,
	     		orderCol:objForm.orderCol.value,
	     		orderType:objForm.orderType.value
			}
	    });			
	};
	  
	function noteListByBox(_idx) {
		var objForm = getNotFormObj();
		
	    ds_note_list.baseParams = {
	     		method:'aj_note_list',
	     		NOTE_BOX_TYPE:objForm.NOTE_BOX_TYPE.value,
	     		NOTE_BOX_TYPE:objForm.NOTE_BOX_TYPE.value,
	     		NOTE_ISREAD:objForm.NOTE_ISREAD.value,
	     		strIndex1:objForm.strIndex1.value,
	     		strIndex2:objForm.strIndex2.value,
	     		strKeyword:objForm.strKeyword.value
	     	};
		ds_note_list.load();
	};
	
    return {
    	noteListReload: function() {return noteListReload();},
    	search_note: function() {return search_note();},
		loadNoteList: function(_note_isread) {return loadNoteList(_note_isread);},
		deleteNote: function() {return deleteNote();},
		keepingNote: function() {return keepingNote();},
		noteListByBox: function(_idx) {return noteListByBox(_idx);},
		init : function() {
    		Ext.EventManager.onWindowResize(function(){note_gridPn.setWidth(Ext.get(document.getElementById("doc-body")).getWidth())}, note_gridPn, true);
    	}	
  }
}();
