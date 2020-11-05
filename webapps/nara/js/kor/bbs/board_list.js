Ext.namespace('board_list_Space');
board_list_Space.board_list = function() {
	var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
	
    function renderTitle(value, p, record){ 
		var retVal = "";
		var str = "";
		
		if( record.data.B_GUBUN =="top") str = "<img src='/images/eng/ico/ico_star.gif'>&nbsp;"+str;
		for(var i=1; i<record.data.B_LEVEL; i++) {
			str += "&nbsp;&nbsp;&nbsp;"
		}

		if(record.data.B_LEVEL > 0) {
			str += "<img src='/images/kor/ico/icon_re.gif' border='0'>";
		}

		retVal += "<a href='javascript:board_list_Space.board_list.board_detail(" + record.data.BBS_IDX + "," + record.data.B_IDX + ");'>"
		if(record.data.READARTICLE == "true") {
			retVal += (str + record.data.B_TITLE);
		} else if(record.data.READARTICLE == "false") {
			retVal += (str + "<b>" + record.data.B_TITLE + "</b>");
		}
		if(record.data.NEWARTICLE == "true") {
			retVal += "&nbsp;<img src=/images/kor/ico/icon_new.gif>";
		}
		retVal += "</a>"
		
		var b_attach = record.data.B_ATTACHE;
		var attachStr = "";
		var arr = new Array();
		var arrExt = new Array();
		var bbs_idx = record.data.BBS_IDX;
		var b_idx = record.data.B_IDX;
		
		if (b_attach.length > 0) {
			attachStr +="<span style='align:right;'>"
			arr = b_attach.split(":");
			for(var i=0; i<arr.length; i++) {
				try {
					var FileType = getFileExtImgName(Ext.util.Format.substr(arr[i], arr[i].lastIndexOf('.')+1));
					if(arr[i].length > 0)
						attachStr += "<a href='javascript:;' style='margin-left:3px;'><img src=/images/kor/ico/" + FileType[1] + " onClick=\"board_list_Space.board_list.fileDownload('"+bbs_idx+"','"+b_idx+"','"+i+"','"+arr[i]+"')\" alt=\""+arr[i]+"\" style='_padding-bottom:1px'></a>";
				}catch(e) {}
			}
			attachStr +="</span>"
		}
		retVal += attachStr;
		
		return retVal;
    };
    
    var sm_border_list = new Ext.grid.CheckboxSelectionModel({
    	singleSelect:false,
    	hidden: !isAdminAuth,
    	dataIndex:'B_IDX',
    	name:'B_IDX',
    	id:'B_IDX'
    });

    var sm_border_list = new Ext.grid.CheckboxSelectionModel();
	var cm_border_list = new Ext.grid.ColumnModel([
	    	new Ext.grid.RowNumberer(),
	    	sm_border_list
	    	,{header: '제목',dataIndex: 'B_TITLE',width: 320,renderer: renderTitle}
	    	,{header: '글쓴이',dataIndex: 'B_NAME',width: 100}
	    	,{header: '날짜',dataIndex: 'B_DATE',width: 70,align: 'right'}
	    	,{header: '조회수',dataIndex: 'B_READ_NUM',width:60,align: 'right'}
	]);
	cm_border_list.defaultSortable = false;

    var ds_board_list = new Ext.data.Store({
		proxy: new Ext.data.HttpProxy({
			url:'board.auth.do',method:'POST'
		}),
		baseParams:{
			method:'aj_get_board_list', 
			BBS_IDX:objForm.BBS_IDX.value, 
			strIndex:'', 
			strKeyword:'', 
			startdt:'', 
			enddt:''
		},
		reader:new Ext.data.XmlReader({
	        record: 'Record',
	        totalRecords: 'recCount'
		}, 
		['B_IDX','BBS_IDX','B_NAME','B_TITLE','B_ATTACHE','B_ATTACHE_EXT','B_DATE','READARTICLE','NEWARTICLE','B_GUBUN','B_READ_NUM','B_DOWNLOAD_NUM','B_APPEND_NUM', 'B_LEVEL']),
		remoteSort: false
	});
	var bbs_gridPn ;
	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-101;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-103;
	
    function create_grid() {		
    	bbs_gridPn = new Ext.grid.GridPanel({
	    	id:'grid_board_list'+objForm.uniqStr.value,
	        el:'div_board_list'+objForm.uniqStr.value,
	        sm: sm_border_list,
	        store: ds_board_list,
	        cm: cm_border_list,
	        trackMouseOver:false,
			height:browserHeight,
	        width:Ext.get(document.getElementById("doc-body")).getWidth(),
			autoSizeColumns:true,
			autoScroll :true,
			loadMask: true,
		    view: new Ext.grid.GridView({forceFit:true,autoFill:true,scrollOffset:0})
	    });

	    bbs_gridPn.render();
		ds_board_list.load({params:{start:0, limit:USERS_LISTNUM}});
		
		var pagigBar=  new Ext.NumberPagingToolbar(
			'grid_board_list_bbar'+objForm.uniqStr.value,
            ds_board_list,
            {
            pageSize:USERS_LISTNUM,
            id:'grid_board_list_bbar'+objForm.uniqStr.value,
            width:300,
            height:25
            }
       );
    };

    function goArticleSearch() {
    	var strIndexVal = objForm.strIndex.value;
    	var alertMsg = "";
    	
    	if (strIndexVal != "B_DATE") {
    		var strKeywordVal = objForm.strKeyword.value;
    		if 	(strKeywordVal == "") {
    			alert("검색어를 입력하세요. ");
    		} else {
    			ds_board_list.baseParams = {method:'aj_get_board_list', BBS_IDX:BBS_IDX, strIndex:strIndexVal, strKeyword:strKeywordVal, startdt:'', enddt:''};
    			ds_board_list.load({params:{start:0, limit:USERS_LISTNUM}});
    		}
    	} else {
    		var startdtVal = eval("document.startdt"+objForm.uniqStr.value);
    		var enddtVal = eval("document.enddt"+objForm.uniqStr.value);
    		if 	(startdtVal == "" &&  enddtVal == "") {
    			alert("검색일 설정이 잘못 되었습니다. ");
    		} else {
    			ds_board_list.baseParams = {
					method:'aj_get_board_list', BBS_IDX:BBS_IDX, strIndex:strIndexVal, strKeyword:'', startdt:startdtVal, enddt:enddtVal
    			};
    			ds_board_list.load({params:{start:0, limit:USERS_LISTNUM}});
    		}
    	}
    };
    
    function registArticle(_bbs_idx) {
    	mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=regist_article_form&BBS_IDX="+_bbs_idx,
			scripts: true
	    });	
    };
    
    function deleteArticle() {
    	var selected_key= new Array();
		if(!board_list_Space.board_list.isGridSelectedRowId(Ext.getCmp('grid_board_list'+objForm.uniqStr.value), selected_key)){
			alert("삭제할 게시물을 선택하십시요.");
			return;
		}
		
    	Ext.Ajax.request({
    		url:'board.auth.do',
    		method:'POST',
    		params: { 
    			method:'aj_remove_article',
    			B_IDX: selected_key,
    			BBS_IDX:objForm.BBS_IDX.value
    		},
    		success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   		record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
						Ext.getCmp('grid_board_list'+objForm.uniqStr.value).getStore().reload();
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
			},
    		failure:function(){
    			callAjaxFailure(response, options);
    		}
    	})
    };
    
    function moveArticle() {
    	var selected_key= new Array();
		if(!board_list_Space.board_list.isGridSelectedRowId(Ext.getCmp('grid_board_list'+objForm.uniqStr.value), selected_key)){
			alert("이동할 게시물을 선택하십시요.");
			Ext.get('bbs_name_list').dom.options[0].selected = true;
			return;
		}
		
		var BBS_IDX = objForm.bbs_name_list.value;
		if (BBS_IDX == -1) {
			return ;
		}
		
		Ext.Ajax.request({
    		url:'board.auth.do',
    		method:'POST',
    		params: { 
    			method:'aj_move_article',
    			B_IDX: selected_key,
    			BBS_IDX:BBS_IDX
    		},
    		success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   		record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
						Ext.getCmp('grid_board_list'+objForm.uniqStr.value).getStore().reload();
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
			},
    		failure:function(){
    			callAjaxFailure(response, options);
    		}
    	})
    };

	function fileDownload(bbs_idx, b_idx, nFileNum, strFileName) {
	   	Ext.Ajax.request({
	   		url:'board.auth.do',
	   		method:'POST',
	   		params : {
	   			method:'aj_attache_chk',
	   			BBS_IDX:bbs_idx,
	   			B_IDX:b_idx, 
	   			nFileNum:nFileNum,
	   			strFileName:strFileName
	   		},
	   		success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   		record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
						var objForms = document.getElementsByTagName('form');
						var objForm ;
						for(var ii=0; ii<objForms.length; ii++) {
						  	if(objForms[ii].name.indexOf("f_board_list") == 0) {
						  		objForm = objForms[ii];
						  		break;
						  	}
						}
						
						objForm.action = "board.auth.do";
						objForm.method.value = "download";
					  	objForm.BBS_IDX.value = bbs_idx;
					  	objForm.B_IDX.value = b_idx;
					  	objForm.nFileNum.value = nFileNum;
					  	objForm.strFileName.value = strFileName;
					  	objForm.submit();										
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
			},
	   		failure:function(){
	   			callAjaxFailure(response, options);
	   		}
	   	})
	};
	
	function board_detail(bbs_idx, b_idx) {
		mainPanel.getActiveTab().body.load({
			url: "board.auth.do?method=detail_article&BBS_IDX="+bbs_idx+"&B_IDX="+b_idx,
			scripts: true
		});
	};
	
	function changeSearchKey() {
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		
		if (objForm.strIndex.value == "B_DATE") {
			eval("search_key_1"+objForm.uniqStr.value).style.display = "none";
			eval("search_key_2"+objForm.uniqStr.value).style.display = "block";
		} else {
			eval("search_key_1"+objForm.uniqStr.value).style.display = "block";
			eval("search_key_2"+objForm.uniqStr.value).style.display = "none";
		}
	};
	
	function isGridSelectedRowId(temp_grid,return_var){
		var temp_sm = temp_grid.getSelectionModel();
		var temp_rows = temp_sm.getSelections();
		for (var i = 0; i <temp_rows.length; i++) {
			return_var.push(temp_rows[i].data.B_IDX);
		}
		
		if(temp_rows.length > 0)
		    return true;
		  else
		    return false;
	};	
	
    return {
    	goArticleSearch: function(){return goArticleSearch();},
    	registArticle: function(_bbs_idx){return registArticle(_bbs_idx);},
    	deleteArticle: function(){return deleteArticle();},
    	moveArticle: function(){return moveArticle();},
    	board_detail: function(bbs_idx, b_idx){return board_detail(bbs_idx, b_idx);},
    	fileDownload: function(bbs_idx, b_idx, nFileNum, strFileName){return fileDownload(bbs_idx, b_idx, nFileNum, strFileName);},
    	changeSearchKey: function(){return changeSearchKey();},
    	isGridSelectedRowId: function(temp_grid,return_var){return isGridSelectedRowId(temp_grid,return_var);},
    	init : function() {
    		create_grid();
			Ext.EventManager.onWindowResize(function(){bbs_gridPn.setWidth(Ext.get(document.getElementById("doc-body")).getWidth())}, bbs_gridPn, true);		
    		Ext.EventManager.onWindowResize(function(){bbs_gridPn.setHeight(browserHeight)}, bbs_gridPn, true);
    	}
    }
}();

Ext.onReady(board_list_Space.board_list.init, board_list_Space.board_list, true);