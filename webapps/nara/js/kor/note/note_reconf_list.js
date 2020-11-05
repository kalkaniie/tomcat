Ext.namespace('note_reconf_space');
var ds_note_reconf;
var gp_note_reconf_list;
note_reconf_space.note_reconf_list = function() {
	var objForm = searchFormByActiveTab("f_note_reconf_list");
	var _note_idx = objForm.NOTE_SEND_IDX.value;
	
	function expandedRow(obj, record, body, rowIndex){
        id = "myrow-" + record.data.NOTE_IDX
        id2 = "mygrid-" + record.data.NOTE_IDX  
		       
       	var gridX = new Ext.Panel({
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
	    ds_note_reconf.reload();
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
    
	function fn_note_reconf_datastore(){
		var objForm = searchFormByActiveTab("f_note_reconf_list");
		ds_note_reconf = new Ext.data.Store({
	     	proxy: new Ext.data.HttpProxy({
	     		url: 'note.auth.do',
	     		method: 'POST'
	     	}),
	     	baseParams: {
	     		method:'aj_note_reconf_list', 
	     		NOTE_SEND_IDX:objForm.NOTE_SEND_IDX.value
	     	},
			reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Record',
	        	id: 'NOTE_RECONF_IDX',
	        	totalRecords: 'recCount'
		  	}, 
		  	['NOTE_RECONF_IDX',
			 'USERS_IDX',
			 'NOTE_IDX',
			 'NOTE_RECONF_TO',
			 'NOTE_RECONF_TO_ORI',
			 'NOTE_SEND_TIME',
			 'NOTE_READ_TIME',
			 'NOTE_SEND_IDX',
			 'NOTE_RECONF_STATE',
			 'NOTE_TITLE',
			 'NOTE_ISREAD'
		  	]),
		  	remoteSort: true
		});
		ds_note_reconf.load(); 
		return ds_note_reconf;
	}	
	
	var sm_note_reconf = new Ext.grid.CheckboxSelectionModel();
    var cm_note_reconf = new Ext.grid.ColumnModel([
    	expander,
    	sm_note_reconf,
    	{id:'NOTE_RECONF_IDX', header:'받는사람',width: 150,
    		renderer:function(value,metadata,record){
				var reVal = "";
				reVal = record.data.NOTE_RECONF_TO;
    			
    			return reVal;
    		}
    	},
    	{header: '보낸시간',width:100,align:'left', 
    		renderer:function(value,metadata,record){
    			var reVal="";
				reVal = record.data.NOTE_SEND_TIME;	
				return reVal;
    		}
    	},
    	{header: '제목',width:500,align:'left',
    		renderer:function(value,metadata,record){
    			var reVal="";
    			reVal = "<a href=\"javascript:left_note_space.note_detail.note_detail('" + record.data.NOTE_IDX + "','" + record.data.NOTE_ISREAD + "')\" class='a_normal_click'>" + record.data.NOTE_TITLE + "</a>";
    			
    			return reVal;
    		}
    	},
    	{header: '확인시간',width:100,align:'left', 
    		renderer:function(value,metadata,record){
    			var reVal="";
				reVal = record.data.NOTE_READ_TIME;	
				if (reVal == "") {
					reVal = "확인안함";
				}
    			return reVal;
    		}
    	}
    ]);
     
 	cm_note_reconf.defaultSortable = false;
	
	gp_note_reconf_list = new Ext.grid.GridPanel({
	    	id :'id_gp_note_reconf_list',
	    	el:'div_note_reconf_list',
	    	sm: sm_note_reconf,
	    	ds: fn_note_reconf_datastore(_note_idx),
	    	cm: cm_note_reconf,
	    	stripeRows: true,
	    	autoHeight:true,
	    	width:Ext.get(document.getElementById("doc-body")).getWidth(),
	    	autoWidth:true,
	    	autoSizeColumns:true, 
	    	autoScroll :true,
	    	plugins: expander,
	    	view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0}),
	    	border:true
	    });
	gp_note_reconf_list.render();
	
	gp_note_reconf_list.getView().on('refresh', function(){ 
        Ext.each(gp_note_reconf_list.view.getRows(),function(row) { 
            record = gp_note_reconf_list.store.getAt(row.rowIndex); 
            if (expander.state[record.id]) 
                { 
                    expander.expandRow(row); 
                } 
        });
	});
	
//	function create_note_reconf_list_panel(_note_idx){
//		var fn_note_reconf = new Ext.form.FormPanel({
//			name:'f_note_reconf_list_panel',
//			id:'f_note_reconf_list_panel',
//			autoDestroy :true,
//		    onSubmit: Ext.emptyFn,
//	        submit: function() {
//	            this.getForm().getEl().dom.submit();
//	        },
//	        items :[ fn_note_reconf_grid(_note_idx)],
//	        renderTo: Ext.get("div_note_reconf_list")
//    	});
//    	
//		return fn_note_reconf;
//	};

	function deleteNoteReconf(){
		var selected_key= new Array();
		if(!isGridSelectedRowId(this.gp_note_reconf_list, selected_key)){
			alert("삭제할 목록을 선택하십시오.");
			return;
		}
		
		Ext.Ajax.request({
			scope :this,
			url: 'note.auth.do',
			method : 'POST',
			params: { method:'aj_remove_note_reconf',NOTE_RECONF_IDX: selected_key},
			success : function(response, options) {
				getExtAjaxMessage(response,'삭제되었습니다.',true);
				ds_note_reconf.reload();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
		
	};
	
	function reconfList(_note_idx) {
		create_note_reconf_list_panel(_note_idx);
	};
	
	var noet_reconf_pop;
	function noteReconfPop(_note_idx) {
		noet_reconf_pop = new Ext.Window({
			id:'kebi_ext_window',
			title:'쪽지읽음 확인',
			colsable:true,
			width:300,
			autoHeight:true,
			plain:true,
			layout:'fit',
			autoScroll:true,
			autoLoad:{
				url:'note.auth.do',
				scripts:true,
				params:{
					method:'note_reconf_list_form',
					NOTE_SEND_IDX:_note_idx
				}
			}
		});		

		noet_reconf_pop.show();
	};

    return {
    	noteReconfPop: function(_note_idx) {return noteReconfPop(_note_idx);},
		reconfList: function(_note_idx) {return reconfList(_note_idx);},
		deleteNoteReconf: function() {return deleteNoteReconf();},
		init : function() {
//			var objForm = searchFormByActiveTab("f_note_reconf_list");
//			gp_note_reconf_list(objForm.NOTE_SEND_IDX.value);
		}
  }
}();

Ext.onReady(note_reconf_space.note_reconf_list.init, note_reconf_space.note_reconf_list, true);