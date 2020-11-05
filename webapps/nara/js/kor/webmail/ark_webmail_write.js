Ext.QuickTips.init();
var webmail_write_editor;
var search ;
Ext.namespace('webmail_write_space');
webmail_write_space.webmail_write = function() {
    var uniqStr = document.form_ark_mail_write.uniqStr.value;
    var ds = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'address.auth.do?method=aj_get_cached_email',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS'])});
    var resultTpl = new Ext.XTemplate('<tpl for="."><div class=search-item>','{ADDRESS}','</div></tpl>');

    search = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
		width:300,
        pageSize:10,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'M_TO'+uniqStr,
        itemSelector: 'div.search-item',
        onSelect: function(record){
        	var tVal = document.form_ark_mail_write.M_TO.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            document.form_ark_mail_write.M_TO.value = tVal;
            this.collapse();
            
        },
        listeners:{
        	beforequery  : function(obj){
	        	obj.query = obj.query.substring(obj.query.lastIndexOf(",")+1).trim();
        	}	
        }
    });
    
    function fn_webmail_write_editor(){
	    webmail_write_editor = new Ext.ux.HTMLEditor({
	      id : 'editor_m_content'+uniqStr,
	      width:800,
	      layout :'fit',
	      height:380,
	      plugins: new Ext.ux.HTMLEditorImage(),
	      el:'htmleditor',
	      listeners: {
    	  	initialize: function(e) {
    	  		if (Ext.isIE) {e.updateToolbar();}
    	  		var objForm = document.form_ark_mail_write;
    	  	}
    	  }
	    });
	    webmail_write_editor.render();
	    
    }
    
    function keeping_session() {
		try {
			Ext.Ajax.request({
				scope :this,
				url: 'webmail.auth.do',
				method : 'POST',
				params: {method:'aj_keeping_session'},
				success : function(response, options) {
				  	setTimeout('webmail_write_space.webmail_write.keeping_session();', 600000);
				},
				failure : function(response, options) {
					setTimeout('webmail_write_space.webmail_write.keeping_session();', 600000);
				}
			});
		} catch(e) {}    	
    };
    
   
    
return {
		//keeping_session:function(){return keeping_session();},
    	init : function() {
    		var objForm = document.form_ark_mail_write;
    		var uStr = objForm.uniqStr.value;
	 		fn_webmail_write_editor();
//	 		document.getElementById("k_txWrite"+uStr).style.width =  getReturnWidth(20,100);
//    		document.getElementById("k_attach"+uStr).style.width =  getReturnWidth(20,100);
//    		Ext.EventManager.onWindowResize(function(){webmail_write_editor.setWidth(getReturnWidth(18,100))}, this, false);
//    		Ext.EventManager.onWindowResize(function(){search.setWidth(getReturnWidth(511,100))}, this, false);
    		
    	}	
}	
}();
Ext.onReady(webmail_write_space.webmail_write.init, webmail_write_space.webmail_write, true);