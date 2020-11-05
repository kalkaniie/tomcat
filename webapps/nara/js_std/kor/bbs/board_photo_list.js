/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('board_photo_list_space');
var store;
board_photo_list_space.board_list = function() {
	var objForm = searchFormByActiveTab('f_board_photo_list');
    
    //board list search
    function goSearch() {
    	var strIndexVal = objForm.strIndex.value;
    	var alertMsg = "";
    	
    	if (strIndexVal != "B_DATE") {
    		var strKeywordVal = objForm.strKeyword.value;
    		if 	(strKeywordVal == "") {
    			alertMsg = "검색어를 입력하세요."
    			alertMessage("검색조건 오류", alertMsg);
    		} else {
    			mainPanel.getActiveTab().body.load(
					{url: "board.auth.do",
					params: {method:'board_list_main' ,
							BBS_IDX:objForm.BBS_IDX.value ,
							strIndex:objForm.strIndex.value,
							strKeyword:objForm.strKeyword.value,
							startdt:objForm.startdt.value,
							enddt:objForm.enddt.value},
					scripts: true
	        		}	
				);
    		}
    	} else {
    		var startdtVal = objForm.startdt.value;
    		var enddtVal = objForm.enddt.value;
    		if 	(startdtVal == "" &&  enddtVal == "") {
    			alertMsg = "검색일 설정이 잘못 되었습니다."
    			alertMessage("검색조건 오류", alertMsg);
    		} else {
    			mainPanel.getActiveTab().body.load(
					{url: "board.auth.do",
					params: {method:'board_list_main' ,
							BBS_IDX:objForm.BBS_IDX.value ,
							strIndex:objForm.strIndex.value,
							strKeyword:objForm.strKeyword.value,
							startdt:objForm.startdt.value,
							enddt:objForm.enddt.value},
					scripts: true
	        		}	
				);
    		}
    	}
    };
    
    function registArticle(_bbs_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=regist_article_form&BBS_IDX="+_bbs_idx,
			scripts: true
	    });	
    };
    
    function getCheckedValue(){
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
				  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
				  		}
				},
	    		failure:function(){
	    			Ext.Msg.alert('message', "게시물 삭제중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.");
	    		}
	    	})
		}
    };
    
    function moveArticle(e) {
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
								url: "board.auth.do?method=board_list_main&BBS_IDX="+bIdx+"&BBS_TYPE=1",
								scripts: true
						    });	
				  		}else{
				  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
				  		}
				},
	    		failure:function(){
	    			Ext.Msg.alert('message', "게시물 삭제중 오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.");
	    		}
	    	})
		}
    };
    
    function showDetail(_b_idx) {
		var queryStr = "&BBS_IDX=" + objForm.BBS_IDX.value
		             + "&B_IDX=" + _b_idx
		             + "&strKeyword=" + objForm.strKeyword.value
		             + "&strIndex=" + objForm.strIndex.value
		             + "&startdt=" + objForm.startdt.value
		             + "&enddt=" + objForm.enddt.value;
		             
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=detail_article" + queryStr,
			scripts: true
	    });	    	
	};
    
	function mailSend(_m_name, _m_to) {
		var m_to = "\""+ _m_name + "\"<" + _m_to + ">";
		goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + m_to, "편지쓰기>게시판-" + getUniqueString());
	};
	
    return {
    	goSearch: function(){return goSearch();},
    	registArticle: function(_bbs_idx){return registArticle(_bbs_idx);},
    	deleteArticle: function(){return deleteArticle();},
    	moveArticle: function(){return moveArticle();},
    	showDetail: function(_b_idx){return showDetail(_b_idx);},
    	mailSend: function(_m_name, _m_to){return mailSend(_m_name, _m_to);},
    	
    	init : function() {
    		
    	}
    }
}();

Ext.onReady(board_photo_list_space.board_list.init, board_photo_list_space.board_list, true);
