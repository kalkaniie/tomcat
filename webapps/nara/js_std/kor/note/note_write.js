var note_write_editor;
Ext.namespace('note_write_space_std');
note_write_space_std.note_write = function() {
	var objForm = document.f_note_regist;
	var uniqStr = objForm.uniqStr.value;
	
    var ds = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'user.auth.do?method=aj_get_note_suggest_list',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS', 'USERS_ID'])});
    var resultTpl = new Ext.XTemplate('<tpl for="."><div class=search-item>','{ADDRESS}','</div></tpl>');
   
    var search = new Ext.form.ComboBox({
        id: "note_write_combo",
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
        pageSize:0,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'NOTE_TO',
        listWidth :350,
        itemSelector: 'div.search-item',
        onSelect: function(record){
        	var tVal =  eval("f_note_regist").NOTE_TO.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.USERS_ID+",";
            }else if(tVal.lastIndexOf(";") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(";")) ;
            	 tVal += ";"+ record.data.USERS_ID+";";
            }else{
            	tVal = record.data.USERS_ID+",";
            }
            eval("document.f_note_regist").NOTE_TO.value = tVal;
            this.collapse();
        },
        listeners:{
        	beforequery  : function(obj){
	        	var charLocation =0;
	        	if(obj.query.lastIndexOf(",") > obj.query.lastIndexOf(";"))
	        		charLocation = obj.query.lastIndexOf(",")+1;
        		else if(obj.query.lastIndexOf(",") < obj.query.lastIndexOf(";"))
        			charLocation = obj.query.lastIndexOf(";")+1;
        		obj.query = obj.query.substring(charLocation).trim();
        	}	
        }
    });
  
    function fn_note_write_editor(){    	
	    note_write_editor = new Ext.ux.HTMLEditor({
	      id : 'editor_m_content'+uniqStr,
	      width:getReturnWidth(0,100),
	      height:230,
	      plugins: new Ext.ux.HTMLEditorImage(),
	      el:'htmleditor'+uniqStr,
	      listeners: {
    	   initialize: function(e) {if (Ext.isIE) {e.updateToolbar();}}
	      	}
	    });
	    note_write_editor.render();
    };
    
	return {
	    	init : function() {
	    	}		
	}	
}();

Ext.onReady(note_write_space_std.note_write.init, note_write_space_std.note_write, true);