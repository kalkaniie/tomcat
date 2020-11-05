/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('board_regist_space');
board_regist_space.board_regist = function () {
	var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
	var kk = objForm.elements;
	var editor;
	var browserHeight=0;
	if(Ext.isIE) browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-200;
	else browserHeight = Ext.get(document.getElementById("doc-body")).getHeight()-198;
	
	function create_editor() {
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		 editor = new Ext.ux.HTMLEditor({
			id : 'editor_board_content' + objForm.uniqStr.value,
			width: Ext.get(document.getElementById("doc-body")).getWidth()-20,
			height:browserHeight,
			plugins: new Ext.ux.HTMLEditorImage(),
			el: 'htmleditor' + objForm.uniqStr.value
		});
		
		editor.render();
	};

	function boardRegist() {
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
	  
	  	if(objForm.B_TITLE.value.length <= 0){
		    alert("제목을 입력하세요.");
		    objForm.B_TITLE.focus();
		    return;
	  	} else if(objForm.BBS_MODE.value ==4){
	  		var cnt=0;
      		for(i=0;i< objForm.elements.length; i++){
      			if(objForm.elements[i].name =="attache_file") cnt ++;
      		}	
      		if(cnt ==0){		
	  			alert("이미지 파일을 선택하세요.");
		    	return;
      		}
	  	} 
	  	
		objForm.B_CONTENT.value = Ext.getCmp("editor_board_content"+objForm.uniqStr.value).getValue();
		objForm.method.value = 'aj_regist_article';
		objForm.action="board.auth.do";
		
		Ext.Ajax.request({
			scope :this,
			url: 'board.auth.do',
			method: 'POST',
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
	
	function setOriginal(){
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		Ext.getCmp("editor_board_content"+objForm.uniqStr.value).setValue(Ext.getCmp("editor_board_content"+objForm.uniqStr.value).getValue() + "<br><br>--------------------------------------------------<br>" + objForm.content_original.value);
	};
	
    function boardList(_bbs_idx, _bbs_type) {
		var queryStr = "&BBS_IDX=" + _bbs_idx
		             + "&BBS_TYPE=" + _bbs_type;
		             
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=board_list_main" + queryStr,
			scripts: true
	    });	    	
	};

	function regist(){
		var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		
		if (confirm("게시물을 등록 하시겠습니까?")) {
			var uploadObj = eval("document.flexUpload"+objForm.uniqStr.value);
			if( !uploadObj ) {
				alert("flex 파일 업로드가  로드되지 못했습니다.");
				return;
			}
			setAttechMode("bbs","board_regist_space.board_regist.boardRegist");
			uploadObj.upload();
		}
	};
	
	return {
		setOriginal: function(){return setOriginal();},
		regist: function(){return regist();},
		boardRegist: function(){return boardRegist();},
		boardList: function(_bbs_idx, _bbs_type){return boardList(_bbs_idx, _bbs_type);},
		init : function() {
			setTimeout(function(){create_editor();}, 100);
			Ext.EventManager.onWindowResize(function(){editor.setHeight(browserHeight)}, editor, true);
		}
	}
}();

Ext.onReady(board_regist_space.board_regist.init, board_regist_space.board_regist, true);

