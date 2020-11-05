Ext.namespace('webmail_write_space');
var uniqStr ="";
webmail_write_space.webmail_write = function() {
    
    var ds = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'address.auth.do?method=aj_get_cached_email',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS'])});
    var resultTpl = new Ext.XTemplate('<tpl for="."><div class=search-item>','{ADDRESS}','</div></tpl>');
	
    var ds_usergroup = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'user.auth.do?method=aj_get_users_suggest_list',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS', 'USERS_ID'])});
    var resultTpl_usergroup = new Ext.XTemplate('<tpl for="."><div class=search-item>','{ADDRESS}','</div></tpl>');
    
    var searchTO = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
	    height:230,
        pageSize:10,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'M_TO',
        itemSelector: 'div.search-item',
        listWidth :350,
        pageSize:0,
        onSelect: function(record){
         	var tVal =  document.form_mail_write.M_TO.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else if(tVal.lastIndexOf(";") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(";")) ;
            	 tVal += ";"+ record.data.ADDRESS+";";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            document.form_mail_write.M_TO.value = tVal;
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
        store: ds_usergroup,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
        height:230,
        width:200,
        pageSize:10,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl_usergroup,
        applyTo: 'RT_RECEIVER1',
        itemSelector: 'div.search-item',
        listWidth :200,
        pageSize:0,
        onSelect: function(record){
         	tVal = record.data.USERS_ID;
            document.form_mail_write.RT_RECEIVER1.value = tVal;
            this.collapse();
            
        },
        listeners:{
        	beforequery  : function(obj){
	        	var charLocation =0;
	        	obj.query = obj.query.substring(charLocation).trim();
	        	
        	}	
        }
    });
    var searchBCC = new Ext.form.ComboBox({
        store: ds_usergroup,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
        width:200,
        height:230,
        pageSize:10,
        minChars :1,
        listWidth :200,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl_usergroup,
        applyTo: 'RT_RECEIVER2',
        itemSelector: 'div.search-item',
        pageSize:0,
        onSelect: function(record){
         	tVal = record.data.USERS_ID;
            document.form_mail_write.RT_RECEIVER2.value = tVal;
            this.collapse();
            
        },
        listeners:{
        	beforequery  : function(obj){
	        	var charLocation =0;
	        	obj.query = obj.query.substring(charLocation).trim();
	        	
        	}	
        }
    });
    
    
    
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
    		var objForm = document.form_mail_write;
    		
	 		}
		}	
}();
Ext.onReady(webmail_write_space.webmail_write.init, webmail_write_space.webmail_write, true);