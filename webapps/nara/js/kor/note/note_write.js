var note_write_editor;
Ext.namespace('note_write_space');
note_write_space.note_write = function() {
	var objForm = document.f_note_regist;
	var uniqStr = objForm.uniqStr.value;
	
    var ds = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'user.auth.do?method=aj_get_note_suggest_list',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS', 'USERS_ID'])});
    var resultTpl = new Ext.XTemplate('<tpl for="."><div class=search-item>','{ADDRESS}','</div></tpl>');
   
    var search = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
        width:320,
        pageSize:10,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'NOTE_TO',
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
  
    return {
	    	init : function() {
	    		var objForm = document.f_note_regist;
		 		var uStr = objForm.uniqStr.value;
	    	}		
	}	
}();

Ext.onReady(note_write_space.note_write.init, note_write_space.note_write, true);