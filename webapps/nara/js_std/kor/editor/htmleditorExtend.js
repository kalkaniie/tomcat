Ext.override(Ext.form.HtmlEditor, {
	getValue : function() {
		if (this.sourceEditMode) {
			this.pushValue();
		} else {
			this.syncValue();
		}
		return Ext.form.HtmlEditor.superclass.getValue.call(this);
	}
});

Ext.override(Ext.form.HtmlEditor, {
	insertAtCursor : function(text){
    	if(!this.activated){
            return;
        }
        if(Ext.isIE){
            this.win.focus();
            if(this.copyRange){
                this.copyRange.collapse(true);
                this.copyRange.pasteHTML(text);
                this.copyRange.select();
                this.syncValue();
                this.deferFocus();
            } else {
	            var r = this.doc.selection.createRange();
   	         	if(r){
   	             	r.collapse(true);
   	             	r.pasteHTML(text);
   	             	this.syncValue();
   	             	this.deferFocus();
   	         	}
            }
        }else if(Ext.isGecko || Ext.isOpera){
            this.win.focus();
            this.execCmd('InsertHTML', text);
            this.deferFocus();
        }else if(Ext.isSafari){
            this.execCmd('InsertText', text);
            this.deferFocus();
        }
    }
});

Ext.apply(Ext.Ajax, {
    fakeUpload : function(p) {
        var boundaryString = 'separator';
    	var boundary = '--' + boundaryString;
        var requestbody = [];
        // preparing params to submission
        for (var key in p.params) {
            requestbody.push(   boundary, 
                                '\nContent-Disposition: form-data; name="', 
                                key, 
                                '"\n\n', 
                                p.params[key],
                                '\n'
                            );
        }
        // preparing fakeFiles to submission
        for (var i = 0; i< p.files.length;i++) {
            requestbody.push(   boundary, 
                                '\nContent-Disposition: form-data; name="', 
                                p.files[i].field, 
                                '"; filename="', 
                                p.files[i].name, 
                                '"\nContent-Type: application/octet-stream\n\n', 
                                p.files[i].body, 
                                '\n'
                             );
        }
        requestbody.push(boundary);
        // altering default header
        Ext.apply(Ext.lib.Ajax, {
            defaultPostHeader :'multipart/form-data;boundary="' + boundaryString + '"'
        });
        // lib.Ajax.request 
        Ext.lib.Ajax.request(
            'POST',
            p.url,
            function () {},
            requestbody.join('')
        );
        // resetting default header
        Ext.apply(Ext.lib.Ajax, {
            defaultPostHeader :"application/x-www-form-urlencoded; charset=UTF-8"
        });
    }
});
function webMailInsertImage(imageFilePath){
	
	var objForm = searchFormByActiveTab("form_mail_write");
	var uniqStrThis = "";
	uniqStrThis = mainPanel.getEl().child("form").dom.uniqStr.value;
	if(objForm.uniqStr !=null) uniqStrThis=objForm.uniqStr.value;
	
	var imageArr = new Array();
	var inputStr = "";
	imageArr = imageFilePath.split("||");
	for( i=0; i< imageArr.length; i++){
  		if(imageArr[i].trim().length >0 ){
  			inputStr += "<input type='hidden' name='attache_image' value='"+imageArr[i]+"'>";
  		}	
  	}
  	
	document.getElementById("imageattache"+uniqStr ).innerHTML += inputStr;
	imageArr = new Array();
  	imageArr = imageFilePath.split("||");
  
  	for( i=0; i< imageArr.length; i++){
  		if(imageArr[i].trim().length >0){
     		Ext.getCmp("editor_m_content"+uniqStrThis).insertAtCursor("<img src=\"/attache_temp/"+imageArr[i]+"\">");
     	}	
  }
}

var tempForm,wiswigEditId,uniqStrCurTab;
function getHtmlEditorInit(formName){
	tempForm = searchFormByActiveTab(formName);
	wiswigEditId = tempForm.wiswigEditId.value; 
	uniqStrCurTab= tempForm.uniqStr.value; 
}
var tablewindow, letterWindow,formletterWindow,logoAppend=false,logoWindow;
Ext.ux.HTMLEditorImage = function() {var editor;var tabs;var openTableWindow = function() {tablewindow = new Ext.Window({title: '표만들기',closable: true,modal: true,closeAction:'close',bodyStyle:'background:white',width: 400,height: 310,pageX:400,pageY:100,plain: true,layout: 'fit',border: false,autoLoad :{url:'/jsp/kor/editor/popup/create_table.jsp?wiswigEditId='+wiswigEditId, scripts:true, scope: this}});tablewindow.show(this);}
var mailImageAppend = function () {
	dialog = new Ext.ux.UploadDialog.Dialog({
        url: 'fileuploadax.public.do?method=imageAttacheFile',
        reset_on_hide: false,
        allow_close_on_upload: true,
        upload_autostart: true,
        permitted_extensions: ['jpg', 'jpeg', 'gif','JPG','JPEG','GIF','bmp','BMP'],
        listeners:{
        	uploadsuccess  : function(dialog ,filename , data,record){
        		webMailInsertImage(data.returnStr);
        		dialog.close();
        	},
        	uploaderror : function(dialog ,filename , data,record ){
        		alert(data.message);
        		dialog.close();
        	}
        }	
      });
	dialog.show('show-button');
}
var logoAppend1 = function (){if(logoAppend){logoWindow = new Ext.Window({title: 'logo',closable: true,modal: true,closeAction:'close',width: 650,height: 370,pageX:250,pageY:150,plain: true,layout: 'fit',border: false,autoScroll:true,autoLoad :{url:'/jsp/kdic/logo.jsp?uniqStr='+uniqStrCurTab, scripts:true, scope: this}});}logoWindow.show(this);}
var selectLetter = function (){if (!letterWindow) {letterWindow = new Ext.Window({title: 'letter paper',closable: true,modal: true,closeAction:'hide',width: 650,height: 370,pageX:250,pageY:150,plain: true,layout: 'fit',border: false,autoScroll:true,autoLoad :{url:'letter.auth.do?method=letter_list&uniqStr='+uniqStrCurTab, scripts:true, scope: this}});}letterWindow.show(this);} 
var formletter = function (){if (!formletterWindow) {formletterWindow = new Ext.Window({title: 'Document Form',closable: true,modal: true,closeAction: 'hide',width: 400,height: 316,pageX:300,pageY:150,plain: true,layout: 'fit',border: false,autoLoad :{url:'formletter.auth.do?method=formletter_list&uniqStr='+uniqStrCurTab, scripts:true, scope: this}});}formletterWindow.show(this);}
return {init: function(htmlEditor) {editor = htmlEditor;editor.tb.insertToolsBefore('sourceedit', {itemId: 'addTable',cls: 'x-btn-icon x-edit-table',handler: openTableWindow,scope: this,clickEvent: 'mousedown',tooltip: {title: 'table',text: '테이블 삽입',cls: 'x-html-editor-tip'}});
if(imgTool){editor.tb.insertToolsBefore('sourceedit', {itemId: 'addimage',cls: 'x-btn-icon x-edit-imageappend',handler: mailImageAppend,scope: this,clickEvent: 'mousedown',tooltip: {	title: 'image',text: '본문이미지 삽입',	cls: 'x-html-editor-tip'}});}
if(letterTool){editor.tb.insertToolsBefore('sourceedit', {itemId: 'addLetter',cls: 'x-btn-icon x-edit-letter',handler: selectLetter,scope: this,clickEvent: 'mousedown',tooltip: {text: '편지지사용',cls: 'x-html-editor-tip'}});}
if(formletterTool){editor.tb.insertToolsBefore('sourceedit', {itemId: 'addFormLetter',cls: 'x-btn-icon x-edit-formletter',handler: formletter,scope: this,clickEvent: 'mousedown',tooltip: {text: '문서양식',cls: 'x-html-editor-tip'}});}
if(logoAppend){editor.tb.insertToolsBefore('sourceedit', {itemId: 'kdic1',cls: 'x-btn-icon x-edit-logo1',handler: logoAppend1,scope: this,clickEvent: 'mousedown',tooltip: {text: '로고',cls: 'x-html-editor-tip'}});}

}}}