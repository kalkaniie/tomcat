Ext.namespace('webmail_write_space');
var uniqStr ="";
webmail_write_space.webmail_write = function() {
    uniqStr = searchFormByActiveTab("form_mail_write").uniqStr.value;
    var ds = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'address.auth.do?method=aj_get_cached_email',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS'])});
    var resultTpl = new Ext.XTemplate('<tpl for="."><div class=search-item>','{ADDRESS}','</div></tpl>');

    var searchTO = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
	    pageSize:10,
	    minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'M_TO'+uniqStr,
        itemSelector: 'div.search-item',
        listWidth :350,
        onSelect: function(record){
         	var tVal =  eval("form_mail_write"+uniqStr).M_TO.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else if(tVal.lastIndexOf(";") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(";")) ;
            	 tVal += ";"+ record.data.ADDRESS+";";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            eval("document.form_mail_write"+uniqStr).M_TO.value = tVal;
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
    
    var searchCC = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
        pageSize:10,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'M_CC'+uniqStr,
        itemSelector: 'div.search-item',
        listWidth :350,
        onSelect: function(record){
         	var tVal =  eval("form_mail_write"+uniqStr).M_CC.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else if(tVal.lastIndexOf(";") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(";")) ;
            	 tVal += ";"+ record.data.ADDRESS+";";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            eval("document.form_mail_write"+uniqStr).M_CC.value = tVal;
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
    var searchBCC = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
        pageSize:10,
        minChars :1,
        listWidth :getReturnWidth(551,100),
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'M_BCC'+uniqStr,
        itemSelector: 'div.search-item',
        listWidth :350,
        onSelect: function(record){
         	var tVal =  eval("form_mail_write"+uniqStr).M_BCC.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else if(tVal.lastIndexOf(";") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(";")) ;
            	 tVal += ";"+ record.data.ADDRESS+";";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            eval("document.form_mail_write"+uniqStr).M_BCC.value = tVal;
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
    
    function fn_webmail_write_editor(){
	    var webmail_write_editor = new Ext.ux.HTMLEditor({
	      id : 'editor_m_content'+uniqStr,
	      width:getReturnWidth(30,100),
	      layout :'fit',
	      height:300,
	      margins: {top: 10,right:10,bottom:10,left:10},
	      plugins: new Ext.ux.HTMLEditorImage(),
	      el:'htmleditor'+uniqStr,
	      listeners: {
    	  	initialize: function(e) {
    	  		if (Ext.isIE) {e.updateToolbar();}
    	  		var objForm = searchFormByActiveTab("form_mail_write");
    	  		try{this.setValue(objForm.temp_content.value);}catch(e){}
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
    	init : function() {
    		var objForm = searchFormByActiveTab('form_mail_write');
    		var uStr = objForm.uniqStr.value;
	 		fn_webmail_write_editor();
    		setTimeout(function(){ if(objForm.M_TO !=null) objForm.M_TO.focus()},2000); 
    		
    		Ext.EventManager.onWindowResize(function(){Ext.getCmp('editor_m_content'+uniqStr).setWidth(getReturnWidth(30,100))}, this, false);
//    		Ext.EventManager.onWindowResize(function(){searchTO.setWidth(getReturnWidth(370,100))}, this, false);
//    		Ext.EventManager.onWindowResize(function(){searchCC.setWidth(getReturnWidth(160,100))}, this, false);
//    		Ext.EventManager.onWindowResize(function(){ if(searchBCC instanceof Ext.form.ComboBox){searchBCC.setWidth(getReturnWidth(160,100))}}, this, false);
	    		
//	 		fn_webmail_write_editor();
//	 		try{
//	 		document.getElementById("k_txWrite"+uStr).style.width =  getReturnWidth(20,100);
//    		document.getElementById("k_attach"+uStr).style.width =  getReturnWidth(20,100);
//	 		}catch(e){}
//    		setTimeout(function(){ try{objForm.M_TO.focus()}catch(e){}},100);
//    		Ext.EventManager.onWindowResize(function(){Ext.getCmp('editor_m_content'+uniqStr).setWidth(getReturnWidth(20,100))}, this, false);
//    		//Ext.EventManager.onWindowResize(function(){search.setWidth(getReturnWidth(511,100))}, this, false);
//    		Ext.EventManager.onWindowResize(function(){
//    			if(Ext.get("k_attach"+uStr) !=null )
//    				Ext.get("k_attach"+uStr).setWidth(getReturnWidth(20,100))}, this, false);
    		}
}	
}();
Ext.onReady(webmail_write_space.webmail_write.init, webmail_write_space.webmail_write, true);