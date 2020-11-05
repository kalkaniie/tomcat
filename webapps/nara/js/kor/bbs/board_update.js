/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('board_update_space');
board_update_space.board_update = function() {
	var editor;
	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-200;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-199;
	
	function create_editor() {
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		    editor = new Ext.ux.HTMLEditor({
			id : 'editor_board_content' + objForm.uniqStr.value,
			width: Ext.get(document.getElementById("doc-body")).getWidth(),
			height:browserHeight,
			plugins: new Ext.ux.HTMLEditorImage(),
			el: 'htmleditor' + objForm.uniqStr.value
		});
		
		editor.render();
	};

	function update(){
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		objForm.B_CONTENT.value = Ext.getCmp("editor_board_content"+objForm.uniqStr.value).getValue();
		
		if(objForm.B_TITLE.value.length <= 0){
		    alert("제목을 입력하세요.");
		    objForm.B_TITLE.focus();
		    return;
	  	}
	  	
		if (confirm("게시물을 수정 하시겠습니까?")) {
			var uploadObj = eval("document.flexUpload"+objForm.uniqStr.value);
			if( !uploadObj ) {
				alert("flex 파일 업로드가  로드되지 못했습니다.");
				return;
			}
			setAttechMode("bbs","board_update_space.board_update.boardUpdate");
			uploadObj.upload();
		}
	};
	
	//게시글 수정(removeArticle())
	function boardUpdate() {
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		objForm.B_CONTENT.value = Ext.getCmp("editor_board_content"+objForm.uniqStr.value).getValue();

		Ext.Ajax.request({
    		url:'board.auth.do?method=aj_modify_article',
    		method:'POST',
    		form: objForm,
    		success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
					mainPanel.getActiveTab().body.load( {
						url: "board.auth.do?method=board_list_main&BBS_IDX="+objForm.BBS_IDX.value,
						scripts: true
				    });	  
		  		}else{
		  			alert(resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {callAjaxFailure(response, options);}
	    });
	};
	
	//본문내용 Setting
	function setContent() {
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		Ext.getCmp("editor_board_content"+objForm.uniqStr.value).setValue(objForm.content_current.value);
	};
	
	function setOriginal(){
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		Ext.getCmp("editor_board_content"+objForm.uniqStr.value).setValue(Ext.getCmp("editor_board_content"+objForm.uniqStr.value).getValue() + "<br>" + objForm.content_original.value);
	};
	
	//목록보기
	function board_list(_bbs_idx, _bbs_type) {
		var queryStr = "&BBS_IDX=" + _bbs_idx
             + "&BBS_TYPE=" + _bbs_type;

		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=board_list_main" + queryStr,
			scripts: true
	    });	
	};
    		
	function download(nFileNum,strFileName){
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		
	  	objForm.method.value="download";
	  	objForm.action="board.auth.do";
	  	objForm.nFileNum.value=nFileNum;
	  	objForm.strFileName.value=strFileName;
	  	objForm.submit();
	};
	
	function removeBBSFile(_b_idx,nFileNum){
	  	var obj = eval("div_bbs_file_"+nFileNum);
	  	obj.outerHTML="";
	};
	
    return {
    	setContent: function(){return setContent();},
    	setOriginal: function(){return setOriginal();},
    	board_list: function(_bbs_idx, _bbs_type){return board_list(_bbs_idx, _bbs_type);},
    	boardUpdate: function(){return boardUpdate();},
    	update: function(){return update();},
    	download: function(nFileNum,strFileName){return download(nFileNum,strFileName);},
    	removeBBSFile: function(_b_idx,nFileNum){return removeBBSFile(_b_idx,nFileNum);},
    	init : function() {
    		create_editor();
    		setContent();
			Ext.EventManager.onWindowResize(function(){editor.setHeight(browserHeight)}, editor, true);
    	}
    }
}();

Ext.onReady(board_update_space.board_update.init, board_update_space.board_update, true);

