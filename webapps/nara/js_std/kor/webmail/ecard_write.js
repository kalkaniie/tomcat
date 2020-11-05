var webmail_write_editor;
Ext.namespace('webmail_write_space');
var uniqStr ="";
webmail_write_space.webmail_write = function() {
    var ds = new Ext.data.Store({proxy: new Ext.data.HttpProxy({url: 'address.auth.do?method=aj_get_cached_email',method: 'POST'}),reader: new Ext.data.XmlReader({totalRecords: 'recCount',record: 'Record'},['ADDRESS'])});
    var resultTpl = new Ext.XTemplate('<tpl for="."><div class=search-item>','{ADDRESS}','</div></tpl>');
    var uniqStr = document.form_mail_write.uniqStr.value;
    var search = new Ext.form.ComboBox({
        store: ds,
        displayField:'title',
        typeAhead: false,
        loadingText: 'Searching...',
        //width:Ext.get(document.getElementById("doc-body")).getWidth()-511,
        height:230,
        pageSize:0,
        minChars :1,
        queryParam : 'liveQueryStr',
        hideTrigger:true,
        tpl: resultTpl,
        applyTo: 'M_TO',
        itemSelector: 'div.search-item',
        onSelect: function(record){
        	var tVal =  document.form_mail_write.M_TO.value;
            if(tVal.lastIndexOf(",") != -1){
            	 tVal = tVal.substring(0,tVal.lastIndexOf(",")) ;
            	 tVal += ","+ record.data.ADDRESS+",";
            }else{
            	tVal = record.data.ADDRESS+",";
            }
            document.form_mail_write.M_TO.value = tVal;
            this.collapse();
            
        },
        listeners:{
        	beforequery  : function(obj){
	        	obj.query = obj.query.substring(obj.query.lastIndexOf(",")+1);
        	}	
        }
    });
    
    
return {
    	init : function() {
    	}	
}	
}();
Ext.onReady(webmail_write_space.webmail_write.init, webmail_write_space.webmail_write, true);