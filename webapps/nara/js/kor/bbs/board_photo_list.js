/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('board_photo_list_space');
board_photo_list_space.board_list = function() {
    function goSearch() {
    	var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
    	var strIndexVal = objForm.strIndex.value;
		var startdtVal = eval("document.startdt"+objForm.uniqStr.value);
    	var enddtVal = eval("document.enddt"+objForm.uniqStr.value);
    	
    	if (strIndexVal != "B_DATE") {
    		var strKeywordVal = objForm.strKeyword.value;
    		if 	(strKeywordVal == "") {
    			alert("검색어를 입력하세요.");
    		} else {
    			mainPanel.getActiveTab().body.load(
					{url: "board.auth.do",
					params: {method:'board_list_main' ,
							BBS_IDX:objForm.BBS_IDX.value ,
							strIndex:objForm.strIndex.value,
							strKeyword:objForm.strKeyword.value,
							startdt:startdtVal,
							enddt:enddtVal},
					scripts: true
	        		}	
				);
    		}
    	} else {
    		if 	(startdtVal == "" &&  enddtVal == "") {
    			alert("검색일 설정이 잘못 되었습니다.");
    		} else {
    			mainPanel.getActiveTab().body.load(
					{url: "board.auth.do",
					params: {method:'board_list_main' ,
							BBS_IDX:objForm.BBS_IDX.value ,
							strIndex:objForm.strIndex.value,
							strKeyword:objForm.strKeyword.value,
							startdt:startdtVal,
							enddt:enddtVal},
					scripts: true
	        		}	
				);
    		}
    	}
    };
    
    function refresh() {
    	var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
    	var startdtVal = eval("document.startdt"+objForm.uniqStr.value);
    	var enddtVal = eval("document.enddt"+objForm.uniqStr.value);
    	
    	mainPanel.getActiveTab().body.load(
			{url: "board.auth.do",
			params: {method:'board_list_main' ,
					BBS_IDX:objForm.BBS_IDX.value ,
					strIndex:objForm.strIndex.value,
					strKeyword:objForm.strKeyword.value,
					startdt:startdtVal,
					enddt:enddtVal,
					nPage:objForm.nPage.value},
			scripts: true
    		}	
		);
    };
    
    function registArticle(_bbs_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=regist_article_form&BBS_IDX="+_bbs_idx,
			scripts: true
	    });	
    };
    
    function getCheckedValue(){
    	var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		var b_idx = document.getElementsByName("B_IDX");
	  	var val = "";
	  	
		for (var i = 0; i <b_idx.length; i++) {
			if (b_idx[i].checked) {
		    	val = val + b_idx[i].value + ",";
			}
		}
		
		if (val.length > 0) {
			val = val.substring(0, val.length -1);
		}
		
		return val;
	};
	
    function deleteArticle() {
    	var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
    	var b_idx_arr = getCheckedValue();

		if (b_idx_arr.length == 0) {
			alert("삭제 할 게시물을 선택하세요.");	
		} else {
	    	Ext.Ajax.request({
	    		url:'board.auth.do?method=aj_remove_article&BBS_IDX='+BBS_IDX+'&B_IDX='+b_idx_arr,
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
								url: "board.auth.do?method=board_list_main&BBS_IDX="+BBS_IDX+"&BBS_TYPE=1",
								scripts: true
						    });	
				  		}else{
				  			alert(resultXML.records[0].data.MESSAGE);
				  		}
				},
	    		failure:function(){
	    			callAjaxFailure(response, options);
	    		}
	    	})
		}
    };
    
    function moveArticle(e) {
    	var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
		var b_idx_arr = getCheckedValue();
		var BBS_IDX = objForm.bbs_name_list.value;
		if (BBS_IDX == -1) {
			return ;
		}
		if (b_idx_arr.length == 0) {
			alert("이동 할 게시물을 선택하세요.");
			objForm.bbs_name_list.options[0].selected = true;
		} else {
	    	Ext.Ajax.request({
	    		url:'board.auth.do?method=aj_move_article&BBS_IDX='+BBS_IDX+'&B_IDX='+b_idx_arr,
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
								url: "board.auth.do?method=board_list_main&BBS_IDX="+objForm.BBS_IDX.value+"&BBS_TYPE=1",
								scripts: true
						    });	
				  		}else{
				  			alert(resultXML.records[0].data.MESSAGE);
				  		}
				},
	    		failure:function(){
	    			callAjaxFailure(response, options);
	    		}
	    	})
		}
    };
    
    function showDetail(_b_idx) {
    	var objForm = mainPanel.getActiveTab().getEl().child('form').dom;
    	var startdtVal = eval("document.startdt"+objForm.uniqStr.value);
    	var enddtVal = eval("document.enddt"+objForm.uniqStr.value);
    	
		var queryStr = "&BBS_IDX=" + objForm.BBS_IDX.value
		             + "&B_IDX=" + _b_idx
		             + "&strKeyword=" + objForm.strKeyword.value
		             + "&strIndex=" + objForm.strIndex.value
		             + "&startdt=" + startdtVal
		             + "&enddt=" + enddtVal;
		             
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=detail_article" + queryStr,
			scripts: true
	    });	    	
	};
    
	function mailSend(_m_name, _m_to) {
		var m_to = "\""+ _m_name + "\"<" + _m_to + ">";
		goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + m_to, "편지쓰기:게시판-" + getUniqueString());
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
	
    return {
    	goSearch: function(){return goSearch();},
    	registArticle: function(_bbs_idx){return registArticle(_bbs_idx);},
    	deleteArticle: function(){return deleteArticle();},
    	moveArticle: function(){return moveArticle();},
    	showDetail: function(_b_idx){return showDetail(_b_idx);},
    	changeSearchKey: function(){return changeSearchKey();},
    	refresh: function(){return refresh();},
    	mailSend: function(_m_name, _m_to){return mailSend(_m_name, _m_to);},
    	init : function() {
    		
    	}
    }
}();

Ext.onReady(board_photo_list_space.board_list.init, board_photo_list_space.board_list, true);
