var tablewindow, letterWindow,formletterWindow;
Ext.ux.HTMLEditorImage = function() {
  var editor;
  var tabs;
  var openTableWindow = function() {
    if (!tablewindow) {
      tablewindow = new Ext.Window({
        title: 'Table Insert',
        closable: true,
    	modal: true,
        closeAction: 'hide',
        width: 400,
        height: 450,
        pageX:400,
        pageY:200,
        plain: true,
        layout: 'fit',
        border: false,
        ctCls :'/js/kor/editor/popup/addTable.css',
        autoLoad :{url:'/js/kor/editor/popup/create_table.jsp?uniqStr='+uniqStr, scripts:true, scope: this}
      }); 
    }
    tablewindow.show(this);
  }
  
  var mailImageAppend = function () {
		var uploadObj = anacondaFm.KBbig;
		if( !uploadObj ) {
			alert("파일 업로드 activeX가 로드되지 못했습니다.");
			return;
		}

		uploadObj.SetCmd("imageAttacheFile");
		uploadObj.SetDirPath("");
		uploadObj.filetype = "IMG";

		result = uploadObj.OpenFileDialog();
		alert(result)
		if(result.substr(0,3) == "500"){
			alert("파일저장에 실패했습니다.");
			return;
		} else if(result.substr(0,3) == "600") {
			alert("사용자디스크 용량을 초과했습니다.");
			return;
		} else if(result.substr(0,3) == "700") {
			alert("파일업로드 용량을 초과했습니다.");
			return;
		}
		document.getElementById("imageattache"+uniqStr).innerHTML += result;
		insertImage(result);
	} 
  var selectLetter = function (){
	  if (!letterWindow) {
      letterWindow = new Ext.Window({
        title: 'letter paper',
        closable: true,
    	modal: true,
        closeAction:'hide',
        width: 600,
        height: 550,
        pageX:400,
        pageY:80,
        plain: true,
        layout: 'fit',
        border: false,
        autoScroll:true,
        autoLoad :{url:'letter.auth.do?method=letter_list&uniqStr='+uniqStr, scripts:true, scope: this}
      });
    }
    letterWindow.show(this);
  }	
  var formletter = function (){
	  if (!formletterWindow) {
      formletterWindow = new Ext.Window({
        title: 'Document Form',
        closable: true,
    	modal: true,
        closeAction: 'hide',
        width: 400,
        height: 350,
        pageX:400,
        pageY:200,
        plain: true,
        layout: 'fit',
        border: false,
        autoLoad :{url:'formletter.auth.do?method=formletter_list&uniqStr='+uniqStr, scripts:true, scope: this}
      });
    }
    formletterWindow.show(this);
  }
  return {
    init: function(htmlEditor) {
      	editor = htmlEditor;
      	
      	editor.tb.insertToolsBefore('sourceedit', {
        	itemId: 'addTable',
        	cls: 'x-btn-icon x-edit-table',
        	handler: openTableWindow,
        	scope: this,
        	clickEvent: 'mousedown',
        	tooltip: {
          		title: 'table',
          		text: '테이블 삽입',
          		cls: 'x-html-editor-tip'
        	}
      	});
      	if(imgTool){
	      	editor.tb.insertToolsBefore('sourceedit', {
	        	itemId: 'addimage',
	        	cls: 'x-btn-icon x-edit-imageappend',
	        	handler: mailImageAppend,
	        	scope: this,
	        	clickEvent: 'mousedown',
	        	tooltip: {
	          		title: 'image',
	          		text: '본문이미지 삽입',
	          		cls: 'x-html-editor-tip'
	        	}
	      	});
      	}
      	if(letterTool){
	      	editor.tb.insertToolsBefore('sourceedit', {
	        	itemId: 'addLetter',
	        	cls: 'x-btn-icon x-edit-letter',
	        	handler: selectLetter,
	        	scope: this,
	        	clickEvent: 'mousedown',
	        	tooltip: {
	          		text: '편지지사용',
	          		cls: 'x-html-editor-tip'
	        	}
	      	});
      	}
      	if(formletterTool){
	      	editor.tb.insertToolsBefore('sourceedit', {
	        	itemId: 'addFormLetter',
	        	cls: 'x-btn-icon x-edit-formletter',
	        	handler: formletter,
	        	scope: this,
	        	clickEvent: 'mousedown',
	        	tooltip: {
	          		text: '문서양식',
	          		cls: 'x-html-editor-tip'
	        	}
	      	});
      	}
      	var insertAtCursor = function(text){
        	if(!this.activated){
            	return;
        	}
        	if(Ext.isIE){
            	var r = this.doc.selection.createRange();
            	if(r){
                	r.pasteHTML(text);
                	this.deferFocus();
            	}
        	}else if(Ext.isGecko || Ext.isOpera){
            	this.win.focus();
            	this.execCmd('InsertHTML', text);
            	this.deferFocus();
        	}else if(Ext.isSafari){
            	this.execCmd('InsertText', text);
            	this.deferFocus();
        	}
    	};
    }
  }
}