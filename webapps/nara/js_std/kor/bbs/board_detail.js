Ext.namespace('board_detail_space');
board_detail_space.board_detail = function() {	
	function appendReply() {
		var objForm = searchFormByActiveTab('f_board_detail');
	 	var b_idx = objForm.B_IDX.value;
	 	var append_content = objForm.APPEND_CONTENT.value;
	 	if(append_content == null || append_content == "") {
	 		Ext.Msg.alert("message", "추가할 답글을 입력해 주십시오.")
	 		objForm.APPEND_CONTENT.focus();
	 		return;
	 	} else {
			Ext.Ajax.request({
	    		url:'board.auth.do?method=aj_append_reply',
	    		method:'POST',
	    		form: objForm,
	    		success:function(response, opt){
					var reader = new Ext.data.XmlReader({
			        	record: 'RESPONSE'
					}, 
					['RESULT','BBS_IDX','B_IDX','APPEND_IDX','APPEND_CONTENT','APPEND_NAME','APPEND_DATE']);
					
					var resultXML = reader.read(response);
					
					if (resultXML.records[0].data.RESULT == "success") {
						
						var tbl = document.getElementById("tb_reply"+objForm.uniqStr.value).getElementsByTagName("TBODY")[0];
		    			var row = document.createElement("tr");    
						var col1 = document.createElement("th");     
						var col2 = document.createElement("td");     
						var col3 = document.createElement("td");
						var col4 = document.createElement("td");
						row.setAttribute("id", "tr_reply_"+ resultXML.records[0].data.APPEND_IDX);
						
						row.appendChild(col1);    
						row.appendChild(col2);    
						row.appendChild(col3);
						row.appendChild(col4);
					
						col1.setAttribute();
						col2.setAttribute();
						col2.setAttribute("width", "150");
						
						col3.setAttribute("width", "120");
						col4.setAttribute("width", "24");
					
						col1.innerHTML = resultXML.records[0].data.APPEND_CONTENT;    
						col2.innerHTML = resultXML.records[0].data.APPEND_NAME;
						col3.innerHTML = resultXML.records[0].data.APPEND_DATE; 
						col4.innerHTML = "<a href=\"javascript:board_detail_space.board_detail.removeReply("+resultXML.records[0].data.BBS_IDX+","+resultXML.records[0].data.B_IDX+","+resultXML.records[0].data.APPEND_IDX+")\"><img src=\"/images/kor/shared/close_bl.gif\"/></a>";
						
						tbl.appendChild(row);
						objForm.APPEND_CONTENT.value="";
					}else{
			  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
			  		}
				},
	    		failure:function(response){
	    			alert('답글 등록에 실패하였습니다.\n관리자에게 문의하시기 바랍니다.');
	    		}
		    });	
	 	}
	};
	
	function removeArticle() {
		var objForm = searchFormByActiveTab('f_board_detail');
		Ext.MessageBox.show({
	       	title: '삭제 확인',
	       	msg: '게시물이 삭제됩니다.\n 삭제 하시겠습니까?',
	       	buttons: Ext.MessageBox.OKCANCEL,
	       	icon: Ext.MessageBox.QUESTION,
	       	fn: function(btn){
	        	if (btn == 'ok'){
					Ext.Ajax.request({
			    		url:'board.auth.do?method=aj_remove_article',
			    		method:'POST',
			    		form: objForm,
			    		success:function(response, opt){
							var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
							var resultXML = reader.read(response);
							
							if (resultXML.records[0].data.RESULT == "success") {
								mainPanel.getActiveTab().body.load( {
									url: "board.auth.do?method=board_list_main&BBS_IDX="+objForm.BBS_IDX.value+"&BBS_TYPE="+objForm.BBS_TYPE.value,
									scripts: true
							    });
							} else {
								Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
							}
			    		},
			    		failure:function(response){
			    			alert('게시물 삭제 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.');
			    		}
				    });	
	        	} else if (btn == 'cancel'){
	        		return false;
		        }
			}
	   });
	};
	
	function topArticleSetting(_bbs_idx, _bbs_type, _b_idx, _type) {
		var objForm = searchFormByActiveTab('f_board_detail');
		if (_type == 1) {
			Ext.Ajax.request({
	    		url:'board.auth.do',
	    		method:'POST',
	    		params :{method:'aj_regist_top_article', BBS_IDX: _bbs_idx, BBS_TYPE: _bbs_type, B_IDX:_b_idx}, 
	    		success:function(response, opt){
					var reader = new Ext.data.XmlReader({
			        	record: 'RESPONSE'
					}, 
					['RESULT','MESSAGE']);
					
					var resultXML = reader.read(response);
							
					if (resultXML.records[0].data.RESULT == "success") {
						mainPanel.getActiveTab().body.load( {
							url: "board.auth.do?method=board_list_main&BBS_IDX="+_bbs_idx+"&BBS_TYPE="+_bbs_type,
							scripts: true
					    });	
					} else {
						Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
					}
	    		},
	    		failure:function(response){
	    			alert('TOP글 설정 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.');
	    		}
		    });	
		} else if (_type == 0) {
			Ext.Ajax.request({
	    		url:'board.auth.do',
	    		method:'POST',
	    		params :{method:'aj_remove_top_article', BBS_IDX: _bbs_idx ,B_IDX:_b_idx}, 
	    		success:function(response, opt){
					var reader = new Ext.data.XmlReader({
			        	record: 'RESPONSE'
					}, 
					['RESULT','MESSAGE']);
					
					var resultXML = reader.read(response);
					
					if (resultXML.records[0].data.RESULT == "success") {
						mainPanel.getActiveTab().body.load( {
							url: "board.auth.do?method=board_list_main&BBS_IDX="+_bbs_idx+"&BBS_TYPE="+_bbs_type,
							scripts: true
					    });	
					} else {
						alert(_message);
					}
	    		},
	    		failure:function(response){
	    			alert('게시물 삭제 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.');
	    		}
		    });	
		}
	};
	
	//게시물 이동
	function pageMoveArticle(_bbs_idx, _b_idx) {
		var queryStr = "&BBS_IDX=" + _bbs_idx
             + "&B_IDX=" + _b_idx;
		             
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=detail_article" + queryStr,
			scripts: true
	    });	
	};
	
	//인쇄화면
	function printPage(_b_idx) { 
	  	var link = "board.auth.do?method=printPage&B_IDX="+_b_idx;
	  	MM_openBrWindow(link, 'pop_board_print','scrollbars=yes,width=601,height=434')
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
	
	//답글쓰기
	function reply_article(_bbs_idx, _b_idx) {
		var queryStr = "&BBS_IDX=" + _bbs_idx
             + "&B_IDX=" + _b_idx;
		             
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=reply_article_form" + queryStr,
			scripts: true
	    });	
	};
	
	//수정하기
	function modify_article(_bbs_idx, _b_idx) {
		var queryStr = "&BBS_IDX=" + _bbs_idx
             + "&B_IDX=" + _b_idx;
		             
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=aj_modify_article_form" + queryStr,
			scripts: true
	    });	
	};
	
	function download(nFileNum,strFileName){
		var objForm = searchFormByActiveTab('f_board_detail');
	  	objForm.method.value="download";
	  	objForm.action="board.auth.do";
	  	objForm.nFileNum.value=nFileNum;
	  	objForm.strFileName.value=strFileName;
	  	objForm.submit();
	}

	//간단한답글 삭제
	function removeReply(bbsIdx, bIdx, aIdx) {
		var objForm = searchFormByActiveTab('f_board_detail');
	 	var winConfirm =  window.confirm("답글을 삭제 하시겠습니까?");
	 	if(winConfirm){
	    	Ext.Ajax.request({
	    		url:'board.auth.do?method=aj_remove_reply',
	    		method:'POST',
	    		params :{BBS_IDX: bbsIdx ,B_IDX:bIdx ,APPEND_IDX :aIdx }, 
	    		success : function(response, options) {
			  		var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['RESULT','MESSAGE']);
				  		var resultXML = reader.read(response);
				  		if (resultXML.records[0].data.RESULT == "success") {
							var tbl = document.getElementById("tb_reply"+objForm.uniqStr.value).getElementsByTagName("TBODY")[0];
	    					tbl.removeChild(document.getElementById("tr_reply_"+aIdx))
				  		}else{
				  			Ext.Msg.alert('message', resultXML.records[0].data.MESSAGE);
				  		}
				},
	    		failure:function(){Ext.Msg.alert('message', "답글 삭제시 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");}
	    	});
	 	}
	 	
	};
	
	function mail_write(_m_to, _m_sendernm) {
		var m_to = "";
		if (_m_sendernm != "") {
			m_to = "\"" + _m_sendernm + "\"<" + _m_to + ">"; 
		} else {
			m_to = _m_to
		}
		goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + m_to, "편지쓰기>게시판-" + getUniqueString());
	};
	
	function showDetail(_b_idx) {
		var objForm = searchFormByActiveTab('f_board_detail');
		var queryStr = "&BBS_IDX=" + objForm.BBS_IDX.value+ "&B_IDX=" + _b_idx;
		mainPanel.getActiveTab().body.load( {
			url: "board.auth.do?method=detail_article" + queryStr,
			scripts: true
	    });	    	
	};
	
    return {
    	appendReply: function(){return appendReply();},
    	pageMoveArticle: function(_bbs_idx, _b_idx){return pageMoveArticle(_bbs_idx, _b_idx);},
    	removeArticle: function(){return removeArticle();},
    	printPage: function(_b_idx){return printPage(_b_idx);},
    	topArticleSetting: function(_bbs_idx, _bbs_type, _b_idx, _type){return topArticleSetting(_bbs_idx, _bbs_type, _b_idx, _type);},
    	board_list: function(_bbs_idx, _bbs_type){return board_list(_bbs_idx, _bbs_type);},
    	reply_article: function(_bbs_idx, _b_idx){return reply_article(_bbs_idx, _b_idx);},
    	modify_article: function(_bbs_idx, _b_idx){return modify_article(_bbs_idx, _b_idx);},
    	removeReply: function(bbsIdx, bIdx, aIdx){return removeReply(bbsIdx, bIdx, aIdx);},
    	download: function(nFileNum,strFileName){return download(nFileNum,strFileName);},
    	mail_write: function(_m_to, _m_sendernm) {return mail_write(_m_to, _m_sendernm);},
    	showDetail: function(_b_idx) {return showDetail(_b_idx);},
    	init : function() {
    		var objForm = searchFormByActiveTab('f_board_detail');
	 		var uStr = objForm.uniqStr.value;
	 		var bbs_gubun = objForm.board_gubun.value;
	 		
	 		if(Ext.isIE){ 
		 		if(bbs_gubun =="photo"){
		 			document.getElementById("b_content"+uStr).style.height =  Ext.get(document.getElementById("doc-body")).getHeight()-376;
				}else{
			 		document.getElementById("b_content"+uStr).style.height =  Ext.get(document.getElementById("doc-body")).getHeight()-296;
				}
	 		}else{
	 			if(bbs_gubun =="photo"){
	 				document.getElementById("b_content"+uStr).style.height =  (Ext.get(document.getElementById("doc-body")).getHeight()-385)+"px";
	 			}else{
			 		document.getElementById("b_content"+uStr).style.height =  (Ext.get(document.getElementById("doc-body")).getHeight()-285)+"px";
				}
	 		}
	 	}
    }
}();

Ext.onReady(board_detail_space.board_detail.init, board_detail_space.board_detail, true);