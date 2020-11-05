Ext.namespace('address_list_space');
address_list_space.address_list = function() {
	var GROUP_IDX;
	var strIndex;
	var strKeyword;
	var strField;
	var orderCol;
	var orderType;
	var strKey;
	var ds_address_list; 
	var gp_address_list;
	var pagigBar;
	var nPageVal = 1;
	var limitVal = mainPanel.getEl().child("form").dom.USERS_LISTNUM.value;
	var startVal = (nPageVal-1)*limitVal;
	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-138;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-140;
	
	function fn_AddressDataStore(){
	    ds_address_list = new Ext.data.Store({
	     	storeId:'address_list_store',
	     	proxy: new Ext.data.HttpProxy({
	     		url: 'address.auth.do?method=aj_address_list',
	     		method: 'POST'
	     	}),
	     	baseParams :{
	     		method:'aj_address_list',
				GROUP_IDX:GROUP_IDX,
				strIndex:strIndex,
				strKeyword:strKeyword,
				strField:strField,
				orderCol:orderCol,
				orderType:orderType,
				strKey:strKey
			},
	     	reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Record',
	        	id: 'EXT_ADDRESS_IDX',
	        	totalRecords: 'recCount'
		  	}, 
		  	['EXT_ADDRESS_IDX','GROUP_IDX','ADDRESS_IDX','ADDRESS_NAME','ADDRESS_EMAIL','ADDRESS_TEL','ADDRESS_CELLTEL']),
		  	remoteSort: true
		});
		
		ds_address_list.load({
			params:{
				nPage:1, 
				start:startVal, 
				limit:limitVal
			}
		});

		return ds_address_list;
	}	
	var sm2 = new Ext.grid.CheckboxSelectionModel();
    var colModel = new Ext.grid.ColumnModel([
		sm2,
    	{id:'EXT_ADDRESS_IDX',dataIndex: 'EXT_ADDRESS_IDX',width:46,hidden:true},
    	{header: '이름',dataIndex: 'ADDRESS_NAME',width: 46,sortable:true,
    		renderer:function(value, metadata, record) {
    			if (record.data.EXT_ADDRESS_IDX.indexOf("G_") != -1) {
    				return "<a href=\"javascript:address_list_space.address_list.selectAddressList('" + record.data.ADDRESS_IDX + "');\"><b>" + record.data.ADDRESS_NAME + "[그룹]</b></a>";
    			} else {
    				return record.data.ADDRESS_NAME;
    			}
  			}    		
    	},
    	{header: '이메일',dataIndex: 'ADDRESS_EMAIL',width: 46,sortable:true,
    		renderer:function(value, metadata, record){
    			if (record.data.EXT_ADDRESS_IDX.indexOf("G_") != -1) {
    				return record.data.ADDRESS_EMAIL;	
    			} else {
    				return "<a href=\"javascript:address_list_space.address_list.mail_write('1','" + record.data.ADDRESS_NAME + "','" + record.data.ADDRESS_EMAIL + "');\">" + record.data.ADDRESS_EMAIL + "</a>";
    			}
    		}
    	},
    	{header: '전화번호',dataIndex: 'ADDRESS_TEL',width: 46},
    	{header: '핸드폰번호',dataIndex: 'ADDRESS_CELLTEL',width: 46},
    	{header: '수 정',dataIndex: 'ADDRESS_CELLTEL',width: 46,
    		renderer:function(value, metadata, record) {
    			if (record.data.EXT_ADDRESS_IDX.indexOf("G_") != -1) {
    				return "-";
    			} else {
    				return "<a href=\"javascript:address_list_space.address_list.dModifyAddr('" + record.data.ADDRESS_IDX + "');\"><img src='/images/kor/btn/btnA_modify.gif'/></a>";
    			}
  			}
    	}
    ]);
     
 	colModel.defaultSortable = false;
	
 	function getUniqStr(){
 		return mainPanel.getEl().child("form").dom.uniqStr.value;
 	}
 	function ds_address_list_reload(){
 		ds_address_list.reload();
 	}
 	
 	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-172;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-175;
	
  	gp_address_list = new Ext.grid.GridPanel({
    	id :'addressgridid',
    	layout:'fit',
    	sm: sm2,
    	ds: fn_AddressDataStore(),
    	cm: colModel,
    	stripeRows: true,
    	height:browserHeight-20,
    	width:Ext.get(document.getElementById("doc-body")).getWidth(),
    	autoWidth:true,
    	autoSizeColumns:true,
    	autoScroll :true,
    	loadMask:true,
    	border:true,
	    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0})        
	});
	
	pagigBar=  new Ext.NumberPagingToolbar(
		'address_list_bbar',
        ds_address_list,
        {
            pageSize:Number(mainPanel.getEl().child("form").dom.USERS_LISTNUM.value),
            id:'address_list_bbar',
            width:300,
            height:25
        }
	);
	
    function pn_address_list_view(listOrView, mIdx){
		var objForms = mainPanel.getEl().dom.getElementsByTagName('form');
		var objForm ;
		  
		for(var ii=0; ii<objForms.length; ii++) {
			if(objForms[ii].name.indexOf("form_mail_list") == 0) {
				objForm = objForms[ii];
				break;
			}
		}
		
		if(listOrView =="view"){
			mainPanel.body.load({
				url: 'webmail.auth.do?method=mail_view&M_IDX='+mIdx, 
				scripts:true, scope: this,
				params:{
					method:'mail_view',
					M_IDX:mIdx,
					MBOX_IDX:objForm.MBOX_IDX.value,
					VIEW_TYPE:objForm.viewType.value,
					TAG_TYPE:objForm.tagType.value,
					READ_MODE:objForm.readMode.value,
					nPage:Ext.getCmp('maillist_bbar'+mainPanel.getEl().child("form").dom.listDivRenderId.value).getPageData().activePage,
					toMe:objForm.toMe.value
				},
				renderTo:mainPanel.body
			});
		}else{
			mainPanel.body.load(
					{url: 'webmail.auth.do?method=mail_list&MBOX_IDX='+TAB_MBOX_IDX, scripts:true, scope: this,
					renderTo:mainPanel.body
					});
		}
	};

	//빠른주소추가
	function qAddAddr() {
		var objForm ;
		if(mainPanel.getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getEl().child("form").dom;
		}
		
		if(objForm.IN_ADDRESS_NAME.value == '이름입력' || objForm.IN_ADDRESS_NAME.value.length < 1){
		  	Ext.Msg.alert('message', "이름을 입력해 주십시오.");
		  	objForm.IN_ADDRESS_NAME.focus();
		  	return;
		}else if(objForm.IN_ADDRESS_EMAIL.value == '이메일입력') {
			Ext.Msg.alert('message', "이메일 주소를 입력해 주십시오.");
		  	objForm.IN_ADDRESS_EMAIL.focus();
		  	return;
		}else if(objForm.IN_ADDRESS_EMAIL.value.length > 0 && !isValidEmail(objForm.IN_ADDRESS_EMAIL.value)){
		  	Ext.Msg.alert('message', "잘못된 이메일 형식입니다. 다시 확인해 주십시오.");
		  	objForm.IN_ADDRESS_EMAIL.focus();
		  	return;
		}
		
		if(objForm.IN_ADDRESS_TEL.value == "전화번호입력" || objForm.IN_ADDRESS_TEL.value == ""){
			objForm.IN_ADDRESS_TEL.value = "";
		}
		if(objForm.IN_ADDRESS_CELLTEL1.value == ""){
			objForm.IN_ADDRESS_CELLTEL1.value = "";
		}
		if(objForm.IN_ADDRESS_CELLTEL2.value == "핸드폰번호입력" || objForm.IN_ADDRESS_CELLTEL2.value == ""){
			objForm.IN_ADDRESS_CELLTEL1.value = "";
			objForm.IN_ADDRESS_CELLTEL2.value = "";
		}
		
		var IN_ADDRESS_CELLTEL = objForm.IN_ADDRESS_CELLTEL1.value + "-" + objForm.IN_ADDRESS_CELLTEL2.value;
		
		Ext.Ajax.request({
			scope :this,
			url: 'address.auth.do',
			method: 'POST',
			params: {
				method: 'aj_add_address',
				GROUP_IDX: objForm.GROUP_IDX.value,
				ADDRESS_NAME: objForm.IN_ADDRESS_NAME.value,
				ADDRESS_EMAIL: objForm.IN_ADDRESS_EMAIL.value,
				ADDRESS_TEL: objForm.IN_ADDRESS_TEL.value,
				ADDRESS_CELLTEL: IN_ADDRESS_CELLTEL
			},
			success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
					ds_address_list.reload();
					objForm.IN_ADDRESS_NAME.value="이름입력";
					objForm.IN_ADDRESS_EMAIL.value="이메일입력";
					objForm.IN_ADDRESS_TEL.value="전화번호입력";
					objForm.IN_ADDRESS_CELLTEL1.value="";
					objForm.IN_ADDRESS_CELLTEL2.value="핸드폰번호입력";
		  		}else{
		  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	};
	
	//주소 상세 수정
	function dModifyAddr(_ADDRESS_IDX) {
		var link_str ='address.auth.do?method=address_modify_form&ADDRESS_IDX='+_ADDRESS_IDX;
		var params ;
		MM_openBrWindow(link_str,'_addresss','width=500,height=470');
	};
	
	function selectAddressList(_GROUP_IDX) {
		var objForm ;
		if(mainPanel.getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getEl().child("form").dom;
			objForm.GROUP_IDX.value = _GROUP_IDX;
		}

		strKeyword = objForm.strKeyword.value;
		strIndex = objForm.strIndex.value;
		strKey = "";
		GROUP_IDX = _GROUP_IDX;
		
		ds_address_list.baseParams = {
			method:'aj_address_list',
			GROUP_IDX:GROUP_IDX,
			strIndex:strIndex,
			strKeyword:strKeyword,
			strField:strField,
			orderCol:orderCol,
			orderType:orderType,
			strKey:strKey
		};
    			
		ds_address_list.load({
			params:{
				nPage:1, 
				start:startVal, 
				limit:limitVal
			}
		});
	};
	
	function addressListReLoad() {
		ds_address_list.reload();
	};
	
	//주소삭제
	function delete_addr() {
		var objForm ;
		if(mainPanel.getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getEl().child("form").dom;
		}
		
		var selected_key= new Array();
		if(!isGridSelectedRowId(Ext.getCmp('addressgridid'), selected_key)){
			alert("삭제할 메일주소를 선택하십시요.");
			return;
		}
		if (!confirm("선택하신 항목을 삭제 하시겠습니까?")) {
			return ;
		}

		for(var ii=0; ii<selected_key.length; ii++) {
			if (selected_key[ii].indexOf("G_") == 0) {
				alert("그룹정보는 그룹별 주소록에서 삭제 하여 주시기 바랍니다.");
				return;
			}
		}

		Ext.Ajax.request({
			scope :this,
			url: 'address.auth.do',
			method: 'POST',
			params: { 
				method:'aj_delete_address',
				IDX_KEY: selected_key
			},
			success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
					addressListReLoad();
		  		}else{
		  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});
	};
	
	//메일쓰기 바로가기(sType:1 ==> 개인, sType:2 ==> 개인다중, sType:3 ==> 그룹, sType:4 ==> 다중그룹 )
	function mail_write(sType, addr_name, addr_email) {
		var objForm ;
		if(mainPanel.getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getEl().child("form").dom;
		}
		
		var obj;
		var inputObj;
		var _M_TO="";
		  
		if (sType == "1") {
			_M_TO = "\"" + addr_name + "\"<" + addr_email + ">";
		} else {
			var temp_sm = Ext.getCmp('addressgridid').getSelectionModel();
			var temp_rows = temp_sm.getSelections();
			for (var i = 0; i <temp_rows.length; i++) {
				if (temp_rows[i].data.EXT_ADDRESS_IDX.indexOf("A_") == -1) {
					_M_TO = _M_TO + "," + "#" + temp_rows[i].data.ADDRESS_NAME;
				} else {
					_M_TO = _M_TO + "," + "\"" + temp_rows[i].data.ADDRESS_NAME + "\"<" + temp_rows[i].data.ADDRESS_EMAIL + "> ";
				}
			}
			
			_M_TO = _M_TO.substring(1);
		}

		goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + _M_TO, "편지쓰기>주소록-" + getUniqueString());
	};
	
	function goAddressAdd() { 
		  MM_openBrWindow('address.auth.do?method=address_add_pop_form&nMode=tab','_address','scrollbars=yes,width=500,height=633');
	};
	
	function move_address() { 
		var objForm ;
		if(mainPanel.getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getEl().child("form").dom;
		}
		var objGroup = objForm.sel_group;
		
		var selected_key= new Array();
		if(!isGridSelectedRowId(Ext.getCmp('addressgridid'), selected_key)){
			alert("이동할 메일주소를 선택하십시요.");
			return;
		}

		for(var ii=0; ii<selected_key.length; ii++) {
			if (selected_key[ii].indexOf("G_") == 0) {
				alert("그룹정보는 이동할 수 없습니다.");
				return;
			}
		}
		
		if (objGroup.value == "") {
			alert("이동할 그룹을 선택하세요");
			return;
		}
	
		Ext.Ajax.request({
			scope :this,
			url: 'address.auth.do',
			method: 'POST',
			params: {
				method: 'aj_move_address',
				GROUP_IDX: objGroup.value,
				CHK_ADDRESS_IDX: selected_key
			},
			success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
					alert("메일주소가 이동 되었습니다.");
					addressListReLoad();
		  		}else{
		  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});	
	};
	
	function copy_address() {
		var objForm ;
		if(mainPanel.getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getEl().child("form").dom;
		}
		var objGroup = objForm.sel_group;
		
		var selected_key= new Array();
		if(!isGridSelectedRowId(Ext.getCmp('addressgridid'), selected_key)){
			alert("복사할 메일주소를 선택하십시요.");
			return;
		}

		for(var ii=0; ii<selected_key.length; ii++) {
			if (selected_key[ii].indexOf("G_") == 0) {
				alert("그룹정보는 복사할 수 없습니다.");
				return;
			}
		}
		
		if (objGroup.value == "") {
			alert("복사할 그룹을 선택하세요");
			return;
		}
	
		Ext.Ajax.request({
			scope :this,
			url: 'address.auth.do',
			method: 'POST',
			params: {
				method: 'aj_copy_address',
				GROUP_IDX: objGroup.value,
				CHK_ADDRESS_IDX: selected_key
			},
			success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
					alert("메일주소가 복사 되었습니다.");
					addressListReLoad();
		  		}else{
		  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
		});	
	};

	//키(ㄱ,ㄴ ~~) 주소 검색
	function key_srch_addr(_strKey) {
		var objForm ;
		if(mainPanel.getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getEl().child("form").dom;
		}
		
		strKey = _strKey;
		strKeyword = "";
		strIndex = "";
		
		ds_address_list.baseParams = {
			method:'aj_address_list',
			GROUP_IDX:GROUP_IDX,
			strIndex:strIndex,
			strKeyword:strKeyword,
			strField:strField,
			orderCol:orderCol,
			orderType:orderType,
			strKey:strKey
		};
    			
		ds_address_list.load({
			params:{
				nPage:1, 
				start:startVal, 
				limit:limitVal
			}
		});
	};
	
	//키워드 주소 검색
	function keyword_srch_addr() {
		var objForm ;
		if(mainPanel.getEl().child("form").dom.name =="address_list"){
			objForm = mainPanel.getEl().child("form").dom;
		}
		
		if(objForm.strKeyword.value == "") {
			Ext.Msg.alert('message', "검색어를 입력하세요.");
			return;
		}
		
		strKeyword = objForm.strKeyword.value;
		strIndex = objForm.strIndex.value;
		strKey = "";
		
		ds_address_list.baseParams = {
			method:'aj_address_list',
			GROUP_IDX:GROUP_IDX,
			strIndex:strIndex,
			strKeyword:strKeyword,
			strField:strField,
			orderCol:orderCol,
			orderType:orderType,
			strKey:strKey
		};
    			
		ds_address_list.load({
			params:{
				nPage:1, 
				start:startVal, 
				limit:limitVal
			}
		});
	};
	
    return {
    	qAddAddr:function(){return qAddAddr();},
    	dModifyAddr:function(_ADDRESS_IDX){return dModifyAddr(_ADDRESS_IDX);},
    	selectAddressList:function(_GROUP_IDX){return selectAddressList(_GROUP_IDX);},
    	addressListReLoad:function(){return addressListReLoad();},
    	delete_addr:function(){return delete_addr();},
    	mail_write:function(sType, addr_name, addr_email){return mail_write(sType, addr_name, addr_email);},
    	goAddressAdd:function(){return goAddressAdd();},
    	move_address:function(){return move_address();},
    	copy_address:function(){return copy_address();},
    	key_srch_addr:function(_strKey){return key_srch_addr(_strKey);},
    	keyword_srch_addr:function(){return keyword_srch_addr();},
    	init : function() {
    		gp_address_list.render("div_address_list");
    		Ext.EventManager.onWindowResize(function(){gp_address_list.setWidth(getReturnWidth(0,100))}, this, false);
    		Ext.EventManager.onWindowResize(function(){gp_address_list.setHeight(browserHeight)}, this, false);
    	}	
    }
}();

Ext.onReady(address_list_space.address_list.init, address_list_space.address_list, true);