var webmail_write_editor;
Ext.namespace('webmail_write_space');
webmail_write_space.webmail_write = function() {
    var uniqStr = mainPanel.getActiveTab().getEl().child("form").dom.uniqStr.value;
    var ds = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'address.auth.do?method=aj_get_cached_email',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS'])});
    var resultTpl = new Ext.XTemplate('<tpl for="."><div class=search-item'+uniqStr+'>','{ADDRESS}','</div></tpl>');
   
    var search = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
        width:Ext.get(document.getElementById("doc-body")).getWidth()-511,
        height:230,
        pageSize:10,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'M_TO'+uniqStr,
        itemSelector: 'div.search-item'+uniqStr,
        onSelect: function(record){
        	var tVal =  eval("form_mail_write"+uniqStr).M_TO.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            eval("document.form_mail_write"+uniqStr).M_TO.value = tVal;
            this.collapse();
            
        },
        listeners:{
        	beforequery  : function(obj){
	        	obj.query = obj.query.substring(obj.query.lastIndexOf(",")+1);
        	}	
        }
    });
    function fn_webmail_write_editor(){
	    webmail_write_editor = new Ext.ux.HTMLEditor({
	      id : 'editor_m_content'+uniqStr,
	      width:Ext.get(document.getElementById("doc-body")).getWidth(),
	      height:Ext.get(document.getElementById("doc-body")).getHeight()-409,
	      plugins: new Ext.ux.HTMLEditorImage(),
	      el:'htmleditor'+uniqStr
	    });
	    webmail_write_editor.render();
    }
    
return {
    	init : function() {
    		Ext.EventManager.onWindowResize(function(){webmail_write_editor.setWidth(Ext.get(document.getElementById("doc-body")).getWidth())}, webmail_write_editor, true);
    		Ext.EventManager.onWindowResize(function(){webmail_write_editor.setHeight(Ext.get(document.getElementById("doc-body")).getHeight()-409)}, webmail_write_editor, true);
    		Ext.EventManager.onWindowResize(function(){search.setWidth(Ext.get(document.getElementById("doc-body")).getWidth()-511)}, search, true);
    		setTimeout(function(){
    			fn_webmail_write_editor();
			}, 300);
    	}	
}	
}();
Ext.onReady(webmail_write_space.webmail_write.init, webmail_write_space.webmail_write, true);