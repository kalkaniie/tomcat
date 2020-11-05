Ext.namespace('webmail_list_space');
var gp_mail_list;
var viewPanel;
var listViewPanel;
var pagigBar;

webmail_list_space.webmail_list = function() {
	var objForm = searchFormByActiveTab("form_mail_list");
	var cp = new Ext.state.CookieProvider({expires: new Date(new Date().getTime()+(1000*60*60*24*30))});//30days
	Ext.state.Manager.setProvider(cp);
	
	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-101;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-103;
	var browserWidth = Ext.get(document.getElementById("doc-body")).getWidth();
	
	var ds_mail_list;
	var gridWidth =300;
	if( objForm.viewMode.value != "basic"){
		gridWidth = browserWidth /2;
	}else{
		gridWidth = browserWidth;
	}
	function fn_mailDataStore(){
		ds_mail_list = new Ext.data.Store({
	     	storeId:'mail_list_store'+objForm.uniqStr.value,
	     	proxy: new Ext.data.HttpProxy({
	     		url: 'webmail.auth.do',
	     		method: 'POST'
	     	}),
	     	baseParams :{
	     		method: 'aj_mail_list',
				MBOX_IDX : objForm.MBOX_IDX.value,
				MBOX_TYPE: objForm.MBOX_TYPE.value,
				TAG_TYPE : objForm.TAG_TYPE.value,
				VIEW_TYPE: objForm.VIEW_TYPE.value, 				
 				READ_MODE: objForm.READ_MODE.value,
 				M_TITLE: objForm.M_TITLE.value,
			 	M_SENDER: objForm.M_SENDER.value,
		 	 	M_SENDERNM: objForm.M_SENDERNM.value,
			 	M_TO: objForm.M_TO.value,
			 	M_ATTACH_NAME: objForm.M_ATTACH_NAME.value,
			 	search_strIndex:objForm.search_strIndex.value,
			 	search_strKeyword:objForm.search_strKeyword.value,
			 	search_startdt: objForm.search_startdt.value,
			 	search_enddt: objForm.search_enddt.value
			},
	     	reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Record',
	        	id: 'M_IDX',
	        	totalRecords: 'recCount'
		  	}, 
		  	 ['M_IDX','MBOX_NAME','MBOX_IDX','M_ISREAD','TAG_TYPE','M_TO','M_SENDER','M_SENDERNM','M_TITLE','M_TIME','M_SIZE','M_ATTACHE','M_ATTACH_NUM','M_PRIORITY']),
		  	remoteSort: true
		});
		
		var nPageVal = objForm.nPage.value;
		var limitVal = objForm.USERS_LISTNUM.value;
		var startVal = (nPageVal-1);

		ds_mail_list.load({params:{nPage:nPageVal, start:startVal, limit:limitVal}});
		ds_mail_list.setDefaultSort('M_TIME', 'DESC');
		return ds_mail_list;
	};	
	
	var sm2 = new Ext.grid.CheckboxSelectionModel();
    
	var colModel;
	function makeColumnModel(){
	    colModel = new Ext.grid.ColumnModel([
	       sm2,
	    	{id:'M_IDX',  header: '상태 ',dataIndex: 'M_ISREAD',width:52, 
	    		renderer:function(value, metadata, record){
	    			var returnVal="";				
					if(value =="N" )
				      returnVal+=  "<img src=/images/eng/ico/ico_mail.gif alt='New Mail'>";
					else if(value =="R" )
				      returnVal+= "<img src=/images/eng/ico/ico_mailRep.gif alt='Reply Mail'>";
					else if(value =="O" )
				      returnVal+= "<img src=/images/eng/ico/ico_mailPop.gif alt='POP Mail' >"
					else if(value =="F" )
				      returnVal+= "<img src=/images/eng/ico/ico_mailFedb.gif alt='Delivery' >";
				    else
				      returnVal+= "<img src=/images/eng/ico/ico_mailRead.gif alt='Read'>";
				    if(record.data.M_PRIORITY == "1" )
				      returnVal +=  "<img src=/images/kor/ico/ico_star2.gif alt='중요편지'>";
					if(record.data.M_ATTACHE != "" && record.data.M_ATTACH_NUM != "") 
					  returnVal += " <img src=/images/kor/ico/ico_att.gif>";
					return returnVal;    		
	    		}
	    	},
	    	{header: '편지함 ',dataIndex: 'MBOX_NAME',width: 100},
	    	{header: '태그 ',dataIndex: 'TAG_TYPE',width: 46,renderer:mail_flag},
	    	{header: objForm.strM_sender.value,dataIndex:objForm.manTypeDataIndex.value ,width: 110,sortable:true,
	    		renderer: function(value, metadata, record) {
	    			var reVal = "";
	    			var params = "";
	    			if(objForm.MBOX_TYPE.value == 2 || objForm.MBOX_TYPE.value == 4) {	
	    				reVal = record.data.M_TO;
	    			}else{
	    				if( record.data.M_SENDERNM ==""){
	    					reVal = "<a href=\"javascript:addrNameByMailWrite('webmail.auth.do?method=mail_write&M_TO="+translate(record.data.M_SENDER.replaceAll("'",""))+"','편지쓰기')\" style='align:left' title='"+translate(record.data.M_SENDER)+"'>"+translate(record.data.M_SENDER)+"</a>";
	    				}else{
	    					reVal = "<a href=\"javascript:addrNameByMailWrite('webmail.auth.do?method=mail_write&M_TO="+translate(record.data.M_SENDER.replaceAll("'",""))+"','편지쓰기')\" style='align:left' title='"+translate(record.data.M_SENDER)+"'>"+translate(record.data.M_SENDERNM)+"</a>";
	    				}	
	    			}	
	    			return reVal;
	  			}
	    	},
	    	{header: '제목 ',	id:'m_title',dataIndex: 'M_TITLE',width: 335,sortable:true,renderer: function(value, metadata, record) {
	    			var reVal="";
	    			if( record.data.M_TITLE =="") reVal = "No Subject"; else reVal = record.data.M_TITLE;
	    			
	    			if(objForm.viewMode.value == "basic"){
	    				reVal = "<a href='javascript:goMailPrewView("+record.data.M_IDX+",\"maillist\")'><img src=/images/kor/ico/ico_review2.gif></a>&nbsp;&nbsp;<a href='javascript:goMailView("+record.data.M_IDX+")'>"+reVal+"</a>";
	    			}else{
	    				reVal = "<a href='javascript:goMailView("+record.data.M_IDX+")'>"+reVal+"</a>";
	    			}
	    			if(record.data.M_ISREAD =="N" || record.data.M_ISREAD =="P") reVal = "<b>"+reVal+"</b>" 
	    			else reVal =reVal;
	    			return reVal;
	  			}
	    	},
	    	{header: objForm.strM_TIME.value,dataIndex:'M_TIME',width: 110,sortable:true},
	    	{header: '크기 ',dataIndex: 'M_SIZE',width:83,sortable:true,renderer: function(value, metadata, record) {
	    			var reVal="";
	    			reVal += parseInt(Number(record.data.M_SIZE)/1024) ;
	    			reVal +=" KB";
	    			return reVal;
	  			}
	   		}
	    ]);
	    
	 	colModel.defaultSortable = false;
	 	return colModel;
	}
 	function defaultInitColModel(){
		if(objForm.search_strKeyword.value !="" 
		|| objForm.VIEW_TYPE.value =="importance" 
		|| objForm.VIEW_TYPE.value =="me"){
			colModel.setHidden(2,false);
		}else{
			colModel.setHidden(2,true);
		}
 	}

 	function getUniqStr(){
		return objForm.uniqStr.value;
 	};
 	
 	function ds_mail_list_reload(){
 		ds_mail_list.reload();
 	};
 	
 	function makeGrid(str){
	 	objForm = searchFormByActiveTab("form_mail_list");
	 	if(objForm.viewMode.value != "basic"){
		 	browserWidth = Ext.get(document.getElementById("doc-body")).getWidth();
		 	if(str =="reload"){
		 		Ext.getCmp('mygridid'+objForm.uniqStr.value).destroy( Ext.getCmp('mygridid'+objForm.uniqStr.value),true);
		 		gridWidth = browserWidth /2;
		 	}
		 	
		 	var viewPosion="west";
		 	if(objForm.viewMode.value == "horizon"){
		 		viewPosion="north";
		 		gridWidth = browserWidth;
		 		browserHeight = browserHeight/2;
		 	}else if(objForm.viewMode.value == "vertical"){
		 		Ext.state.Manager.set('mailgrid-stateid', {});

		 		viewPosion="west";
		 		gridWidth = browserWidth/2;
		 	}

		 	gp_mail_list = new Ext.grid.GridPanel({
		    	id :'mygridid'+objForm.uniqStr.value,
		    	stateId :'mailgrid-stateid',
		        stateful:true,
		    	stateEvents: ['columnresize', 'columnmove', 'columnvisible'],
		    	layout:'fit',
		    	view: new Ext.grid.GridView({forceFit:true,scrollOffset:0}),        
		    	sm: sm2,
				cm: makeColumnModel(),
		    	ds: fn_mailDataStore(),
		    	stripeRows: true,
		    	height:browserHeight,
		    	width:gridWidth,
		    	autoSizeColumns:true,
		    	enableDrag: true,
		    	autoScroll :true,
		    	ddGroup: 'left_mbox_DD',
		    	loadMask:true,
		    	collapsible: true,
		    	region: viewPosion,
		        split: true,
		        margins:'3 0 3 3',
		        cmargins:'3 3 3 3'
		    });
		 	    
	 	}else{
	 		if(str =="reload"){
		 		Ext.getCmp('mygridid'+objForm.uniqStr.value).destroy( Ext.getCmp('mygridid'+objForm.uniqStr.value),true);
		 	}
	 		gp_mail_list = new Ext.grid.GridPanel({
		    	id :'mygridid'+objForm.uniqStr.value,
		    	stateId :'mailgrid-stateid',
		        stateful:true,
		    	stateEvents: ['columnresize', 'columnmove', 'columnvisible'],
		    	layout:'fit',
		    	view: new Ext.grid.GridView({forceFit:true,scrollOffset:0}),        
		    	sm: sm2,
				cm: makeColumnModel(),
		    	ds: fn_mailDataStore(),
		    	stripeRows: true,
		    	height:browserHeight,
		    	width:browserWidth,
		   		autoWidth:true,
		    	autoSizeColumns:true,
		    	enableDrag: true,
		    	autoScroll :true,
		    	ddGroup: 'left_mbox_DD',
		    	loadMask:true
		    });
	 	}	    
 	}
 	
	function makeAll(str){
		objForm = searchFormByActiveTab("form_mail_list");
		if(str == 'reload'){ document.getElementById("maillist_div"+objForm.uniqStr.value).innerHTML = '';}
		
		if( objForm.viewMode.value != "basic"){
			gridWidth = browserWidth /2;
		    viewPanel = new Ext.Panel({
		        id :'mail_view_panel'+objForm.uniqStr.value,
		        region: 'center',
				width: gridWidth,
		        collapsible: true,
		        autoScroll :true,
		        margins:'0 0 0 5',
		        defaults:{autoScroll:true},
		        autoLoad:{url:'/jsp/kor/webmail/mail_view_blank_info.jsp',scripts:true, scope: this}
		    });
		    
		    if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-101;
			else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-103;
			
			listViewPanel = new Ext.Panel({
		    	id :'mail_list_view_panel'+objForm.uniqStr.value,
		        height:browserHeight,
				width:browserWidth,
		        plain:true,
		        layout: 'border',
		        ctCls:'mail_list_cls',
		        items: [gp_mail_list, viewPanel],
		        renderTo : "maillist_div"+objForm.uniqStr.value
		    });

		}else{
			gp_mail_list.render("maillist_div"+objForm.uniqStr.value);
		}
	}	
	function makePaging(){
		if(Ext.getCmp('maillist_bbar'+objForm.uniqStr.value) !=null) Ext.getCmp('maillist_bbar'+objForm.uniqStr.value).destroy( Ext.getCmp('maillist_bbar'+objForm.uniqStr.value),true);
		pagigBar=  new Ext.NumberPagingToolbar(
			'maillist_bbar'+objForm.uniqStr.value,
            ds_mail_list,
            {
            pageSize:Number(objForm.USERS_LISTNUM.value),
            id:'maillist_bbar'+objForm.uniqStr.value,
            width:300,
            height:25            
            }
	    );
	}    
    function pn_webmail_list_view(listOrView, mIdx){
		
		if( objForm.viewMode.value != "basic"){
			var cur_objForm = searchFormByActiveTab("form_mail_list");
			Ext.getCmp('mail_view_panel'+cur_objForm.uniqStr.value).getUpdater().update({
				url: 'webmail.auth.do?method=mail_view&M_IDX='+mIdx, 
				params:{
					method:'mail_view',
					M_IDX:mIdx,
					MBOX_IDX : objForm.MBOX_IDX.value,
					MBOX_TYPE: objForm.MBOX_TYPE.value,
					TAG_TYPE : objForm.TAG_TYPE.value,
					VIEW_TYPE: objForm.VIEW_TYPE.value, 				
	 				READ_MODE: objForm.READ_MODE.value,
	 				M_TITLE: objForm.M_TITLE.value,
				 	M_SENDER: objForm.M_SENDER.value,
			 	 	M_SENDERNM: objForm.M_SENDERNM.value,
				 	M_TO: objForm.M_TO.value,
				 	M_ATTACH_NAME: objForm.M_ATTACH_NAME.value,
				 	search_strIndex:objForm.search_strIndex.value,
				 	search_strKeyword:objForm.search_strKeyword.value,
				 	search_startdt: objForm.search_startdt.value,
				 	search_enddt: objForm.search_enddt.value,
				 	nPage:Ext.getCmp('maillist_bbar'+objForm.uniqStr.value).getPageData().activePage+1
				}	
			});
		}else{
			mainPanel.getActiveTab().body.load({
				url: 'webmail.auth.do?method=mail_view&M_IDX='+mIdx, 
				scripts:true, scope: this,
				params:{
					method:'mail_view',
					M_IDX:mIdx,
					MBOX_IDX : objForm.MBOX_IDX.value,
					MBOX_TYPE: objForm.MBOX_TYPE.value,
					TAG_TYPE : objForm.TAG_TYPE.value,
					VIEW_TYPE: objForm.VIEW_TYPE.value, 				
	 				READ_MODE: objForm.READ_MODE.value,
	 				M_TITLE: objForm.M_TITLE.value,
				 	M_SENDER: objForm.M_SENDER.value,
			 	 	M_SENDERNM: objForm.M_SENDERNM.value,
				 	M_TO: objForm.M_TO.value,
				 	M_ATTACH_NAME: objForm.M_ATTACH_NAME.value,
				 	search_strIndex:objForm.search_strIndex.value,
				 	search_strKeyword:objForm.search_strKeyword.value,
				 	search_startdt: objForm.search_startdt.value,
				 	search_enddt: objForm.search_enddt.value,
				 	nPage:Ext.getCmp('maillist_bbar'+objForm.uniqStr.value).getPageData().activePage+1
				},
				renderTo:mainPanel.getActiveTab().body
			});
		}	
	};
	
	function changeViewType(str){
		Ext.Ajax.request({
			scope :this,
			url: 'userenv.auth.do',
			method : 'POST',
			params:{method:'aj_change_mail_view_type', USERS_MAIL_VIEW_MODE: str},
			success : function(response, options) {
				if(str=="0") str="basic";
				else if(str=="1") str="horizon";
				else if(str=="2") str="vertical";
				objForm.viewMode.value = str;
				makeGrid('reload');
		    	makeAll('reload');
		    	makePaging();
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
		
	}
	return {
    	maillist_ds_mail_list:function(){return ds_mail_list_reload();},
    	getMailListViewPanel: function(listOrView,mIdx){return pn_webmail_list_view(listOrView,mIdx);},
    	changeViewType: function(str){return changeViewType(str);},
    	init : function() {
    		makeGrid('');
    		makeAll('');
    		makePaging();
    		defaultInitColModel();
    		//Ext.EventManager.onWindowResize(function(){gp_mail_list.setWidth(Ext.get(document.getElementById("doc-body")).getWidth())}, gp_mail_list, true);		
    		//Ext.EventManager.onWindowResize(function(){gp_mail_list.setHeight(getBrowserHeight())}, gp_mail_list, true);
    	}	
    }
}();

Ext.onReady(webmail_list_space.webmail_list.init, webmail_list_space.webmail_list, true);

function mail_flag(inVal){
	var returnVal="";
	if(inVal.length==1) inVal ="0"+inVal;
	returnVal=  "<img src=/images/kor/ico/ico_tag"+inVal+".gif>";
	return returnVal;
}

function goMailView(mIdx){
	webmail_list_space.webmail_list.getMailListViewPanel('view', mIdx);
}

function addrNameByMailWrite(str1, str2){
	goRightDivRender(encodeURI(str1),str2)
}