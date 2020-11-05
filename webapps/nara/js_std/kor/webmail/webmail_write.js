Ext.namespace('webmail_write_space');
Ext.apply(Ext.Ajax, {
    fakeUpload : function(p) {
        var boundaryString = 'separator';
    	var boundary = '--' + boundaryString;
        var requestbody = [];
        // preparing params to submission
        for (var key in p.params) {
            requestbody.push(   boundary, 
                                '\nContent-Disposition: form-data; name="', 
                                key, 
                                '"\n\n', 
                                p.params[key],
                                '\n'
                            );
        }
        // preparing fakeFiles to submission
        for (var i = 0; i< p.files.length;i++) {
            requestbody.push(   boundary, 
                                '\nContent-Disposition: form-data; name="', 
                                p.files[i].field, 
                                '"; filename="', 
                                p.files[i].name, 
                                '"\nContent-Type: application/octet-stream\n\n', 
                                p.files[i].body, 
                                '\n'
                             );
        }
        requestbody.push(boundary);
        // altering default header
        Ext.apply(Ext.lib.Ajax, {
            defaultPostHeader :'multipart/form-data;boundary="' + boundaryString + '"'
        });
        // lib.Ajax.request 
        Ext.lib.Ajax.request(
            'POST',
            p.url,
            function () {},
            requestbody.join('')
        );
        // resetting default header
        Ext.apply(Ext.lib.Ajax, {
            defaultPostHeader :"application/x-www-form-urlencoded; charset=UTF-8"
        });
    }
});

var uniqStr ="";
webmail_write_space.webmail_write = function() {
    var ds = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'address.auth.do?method=aj_get_cached_email',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS'])});
    var resultTpl = new Ext.XTemplate('<tpl for="."><div class=search-item>','{ADDRESS}','</div></tpl>');

    var searchTO = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
	    pageSize:0,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        queryDelay:0,
        applyTo: 'M_TO',
        itemSelector: 'div.search-item',
        listWidth :350,
        anchor:'100%',
        onSelect: function(record){
         	var obj = document.form_mail_write;
         	var tVal =  obj.M_TO.value;
         	if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else if(tVal.lastIndexOf(";") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(";")) ;
            	 tVal += ";"+ record.data.ADDRESS+";";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            obj.M_TO.value = tVal;
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
        typeAhead: false,
        loadingText: 'Searching...',
        pageSize:0,
        minChars :1,
        queryParam : 'liveQueryStr',
        queryDelay:0,
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'M_CC',
        itemSelector: 'div.search-item',
        listWidth :350,
        anchor:'100%',
        ctCls:'k_write_textarea',
        onSelect: function(record){
         	var obj =document.form_mail_write;
         	var tVal =  obj.M_CC.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else if(tVal.lastIndexOf(";") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(";")) ;
            	 tVal += ";"+ record.data.ADDRESS+";";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            obj.M_CC.value = tVal;
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
    
    var searchBCC;
    function createSearchBCC(){
    	if( !(searchBCC instanceof Ext.form.ComboBox)){
	    	searchBCC = new Ext.form.ComboBox({
		        store: ds,
		        displayField:'title',
		        typeAhead: false,
		        loadingText: 'Searching...',
		        width:615,
		        pageSize:0,
		        minChars :1,
		        listWidth :350,
		        queryParam : 'liveQueryStr',
		        hideTrigger:true,
		        tpl: resultTpl,
		        queryDelay:0,
		        applyTo: 'M_BCC',
		        itemSelector: 'div.search-item',
		        anchor:'100%',
		        onSelect: function(record){
		        	var obj =document.form_mail_write;
		         	var tVal =  obj.M_BCC.value;
		            if(tVal.lastIndexOf(",") != -1){
		            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
		            	 tVal += ","+ record.data.ADDRESS+",";
		            }else if(tVal.lastIndexOf(";") != -1){
		            	 tVal = tVal.substring(0,tVal.lastIndexOf(";")) ;
		            	 tVal += ";"+ record.data.ADDRESS+";";
		            }else{
		            	tVal = record.data.ADDRESS+",";
		            }
		            obj.M_BCC.value = tVal;
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
    	}
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
		createSearchBCC:function(){return createSearchBCC();},
    	init : function() {
    		try{
//	    		var objForm = searchFormByActiveTab('form_mail_write');
//	    		var uStr = objForm.uniqStr.value;
//		 		fn_webmail_write_editor();
//	    		setTimeout(function(){ if(objForm.M_TO !=null) objForm.M_TO.focus()},2000); 
//	    		Ext.EventManager.onWindowResize(function(){Ext.getCmp('editor_m_content'+uniqStr).setWidth(getReturnWidth(31,100))}, this, false);
//	    		Ext.EventManager.onWindowResize(function(){searchTO.setWidth(getReturnWidth(370,100))}, this, false);
//	    		Ext.EventManager.onWindowResize(function(){searchCC.setWidth(getReturnWidth(160,100))}, this, false);
//	    		Ext.EventManager.onWindowResize(function(){ if(searchBCC instanceof Ext.form.ComboBox){searchBCC.setWidth(getReturnWidth(160,100))}}, this, false);
	    		
    		}catch(e){}
    	}
	}
}();
Ext.onReady(webmail_write_space.webmail_write.init, webmail_write_space.webmail_write, true);