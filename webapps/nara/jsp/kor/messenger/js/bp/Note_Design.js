/*
	쪽지창을 그린다.
*/
//2009.07. 14
var tmpszIndex;

var noteRcvwindow = {
  
  create: function( fromBuddyId , fromBuddyNm , sentTime ,fileCount, fileSize ,fileInfo, noteMessage,fontInfo ) {
    
    var fileNmSize = '';
    var fileOrgNm = '';
    var filewebpath = '';
    var buttonLive = true;
    
    // 2009.07.15. -----------------------------------------------------------------
    var viewFileInfo = '';
    var arrSzFont = fontInfo.split(",");
    var msg = '';
    
     if(fontInfo = null || fontInfo=='') {
            msg = noteMessage + "<br/>";   
        } else {
        		var HexTmp = "";
        		for(var kk=2; kk<5; kk++){
        			HexTmp += hidef.js_DecToHex(parseInt(arrSzFont[kk])) ;
        		}
        		
            msg = hidef.js_msgStyeTras(noteMessage,arrSzFont[5], arrSzFont[6], arrSzFont[7], arrSzFont[0], arrSzFont[1], HexTmp);
			 
        }
    		
    var tmpfileInfo = fileInfo.split('|');
    
   //-----------------------------------------------------------------------------------
    
    if( fileInfo.length > 0 && fileCount > 0)
    {
//        fileOrgNm = fileInfo.split(',')[0];
//        filewebpath = escape(fileInfo.split(',')[1]);
//        fileNmSize = fileOrgNm+' ['+fileSize+' byte]';
    	for(var i=0;i<tmpfileInfo.length;i++){
    		
	        fileOrgNm = tmpfileInfo[i].split(',')[0];
	        filewebpath = escape(tmpfileInfo[i].split(',')[1]);
	        //전체 경로 path 빼
	        filewebpath = filewebpath.substring(filewebpath.indexOf("/data/")+1,filewebpath.length);
	        fileNmSize = fileOrgNm+' ['+fileSize+' byte]';
	    	viewFileInfo =viewFileInfo +'<img src="/jsp/kor/messenger/images/default/tree/leaf.gif" absmiddle>&nbsp;'
	            	//+'<a href="http://naravision.net/messenger/notefiledwn?file1='+filewebpath+'&file2='
	            	+'<a href="http://'+ hidef.ServerDomain +'/messenger/notefiledwn?file1='+filewebpath+'&file2='
	            	+ encodeURIComponent(fileOrgNm) + '">'+fileNmSize+'</a><br/>'
	            	//+ fileOrgNm + '">'+fileNmSize+'</a><br/>'
			//alert(viewFileInfo) ;           	
    	}	
        buttonLive = false;
    }
    	 //alert(fileOrgNm + ":" + filewebpath);
    var form = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        labelWidth: 55,
        layout:'absolute',
        url:'NoteFileDownLoadSvl',
        defaultType: 'textfield',
        
        items: [{
            x: 0,
            y: 5,
            xtype:'label',
            text: '보낸사람:'
        },{
            x: 60,
            y: 0,
            name: 'fromBuddyNm',
            value: fromBuddyNm,
            readOnly:true,
            anchor: '100%'  
        },{
            x: 0,
            y: 35,
            xtype:'label',
            text: '보낸시각:'
        },{
            x: 60,
            y: 30,
            name: 'sentTime',
            value: sentTime,
            readOnly:true,            
            anchor: '100%'  // anchor width by percentage
        },{ 
            x: 0,
            y: 65,
            xtype:'label',
            text: '첨부파일:'
        },{
            x: 60,
            y: 60,
            //height:22,
            height:78,
            xtype:'panel',
            id: 'fileProgress',
            html: viewFileInfo /*'<img src="/jsp/kor/messenger/images/default/tree/leaf.gif" absmiddle>&nbsp;<a href="http://naravision.net/messenger/notefiledwn?file1='+filewebpath+'&file2='
            	+ encodeURIComponent(fileOrgNm) + '">'+fileNmSize+'</a>' */
        },{ 
            x: 0,
            //y: 90,
            y: 160,
            xtype:'panel',
            //height:500,
            height:150,
            autoScroll:true,
            cmargins:'3 3 3 3',
            anchor: '100% 100%',
            //html: createNoteDiv(noteMessage)
            html: createNoteDiv(msg)
        },{
            xtype: 'hidden',
            name: 'fromBuddyId',
            value: fromBuddyId
        }]
    });

    var win = new Ext.Window({
        title: '쪽지보기',
        width: 450,
        height:300,
        minWidth: 350,
        minHeight: 250,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        collapsible: true,
        items: form,  
        buttons: [{
            text: '답장',
            handler: function(){
                js_Note_Reply(win,form);
            }
        },{
            text: '취소',
            handler: function(){
                js_Note_close(win);
            }
        }]
    });
    
    win.show();
    }
}

var form; 
var win ;

var noteSendwindow = {
  
  create: function(buddyIndex, fromBuddyId, fromBuddyNm , toBuddyId , toBuddyNm , szIndex) {
    if( Ext.QuickTips.isEnabled() ) 
      {
        
      }else{
        Ext.QuickTips.init();
      }
    
      
           var tTitle ="";
     var fontnames = ['돋음', '굴림', '바탕', '궁서', 'Arial', 'courier new','Georgia', 'Tahoma', 'Verdana', 'impact', 'WingDings'];
        var fontsizes = ['10', '12', '14', '16', '18', '20', '22', '24', '26', '28'];
        
        var fontNameSelectHtml = ""
    
            fontNameSelectHtml += "<select id='fontName_"+buddyIndex+"' name='fontName_"+buddyIndex+"' style='margin: 1 2 0 2; font-size: 12px;' onChange=\"CtntEditorNote.toggleFontName('"+buddyIndex+"',this.value);\">";
            for (var i = 0; i < fontnames.length; i++) {
                fontNameSelectHtml += "<option value='" + fontnames[i]+ "'>" + fontnames[i] + "</option>";
            }
            fontNameSelectHtml += "</select>";
    
        var fontSizeSelectHtml = ""
    
            fontSizeSelectHtml += "<select id='fontSize_"+buddyIndex+"' name='fontSize_"+buddyIndex+"' style='margin: 1 2 0 2; font-size: 12px;' onChange=\"CtntEditorNote.toggleFontSize('"+buddyIndex+"',this.value);\">";
            for (var i = 0; i < fontsizes.length; i++) {
                fontSizeSelectHtml += "<option value='" + fontsizes[i]+ "'>" + fontsizes[i] + "</option>";
            }
            fontSizeSelectHtml += "</select>";
    
    
        var fontColorLayer ="<div id='NotefontColorList' class='msgWdw_fontColorList' style='z-index:9999999999;left:230;top:0;display:none;'>"+
                        "<table  bgcolor='E7E7E7'>"+
                        "<tr>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#000000;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#000000');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#b8b8b8;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#b8b8b8');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#b4ad3b;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#b4ad3b');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#bb5c54;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#bb5c54');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#755a5c;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#755a5c');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#a9b5ef;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#a9b5ef');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#d65a20;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#d65a20');\"></td>"+
                       "</tr>"+                                                                                                                                                              
                        "<tr>"+                                                                                                                                                               
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#e39230;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#e39230');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#a71334;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#a71334');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#590099;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#590099');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#d40088;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#d40088');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#0030ac;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#0030ac');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#676f11;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#676f11');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#769321;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#769321');\"></td>"+
                        "</tr>"+                                                                                                                                                              
//                        "<tr>"+                                                                                                                                                               
//                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#3966fe;' onclick=\"CtntEditorNote.setFontColor('"+buddyIndex+"','#3966fe');\"></td>"+
//                        "</tr>"+
                        "</table>"+
                        "</div>";
    
        var webEditorButtonHtml = " <img src='/jsp/kor/realtime/images/ico/icon_btn01_off.gif' id='bold_"+buddyIndex+"' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditorNote.toggleBold('"+buddyIndex+"');\"> "+
                             " <img src='/jsp/kor/realtime/images/ico/icon_btn02_off.gif' id='italic_"+buddyIndex+"' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditorNote.toggleItalic('"+buddyIndex+"');\"> "+
                             " <img src='/jsp/kor/realtime/images/ico/icon_btn03_off.gif' id='underline_"+buddyIndex+"' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditorNote.toggleUnderline('"+buddyIndex+"');\"> "+
                             " <img src='/jsp/kor/realtime/images/ico/icon_btn04_off.gif' id='fontColor_"+buddyIndex+"' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditorNote.toggleFontColor('"+buddyIndex+"');\">"+
                             "<div id='NotemsgFontColor_"+buddyIndex+"'></div> ";
        var webEditorHtml = " <table height='25' width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='E7E7E7'><tr><td>"
        					+ fontNameSelectHtml + fontSizeSelectHtml + webEditorButtonHtml +"</td></tr></table>" + fontColorLayer
        
     
     if(Note_popup){
	   		tTitle = "파일 보내기";
	       var f_panel = new Ext.Panel(
	        		{width:395,height:150,
	        		 //autoLoad: {url: '/flex/jsp/msg_fileupload_flex.jsp'
	        		 autoLoad: {url: '/jsp/kor/messenger/flex_loading.jsp?width=150'
	        		, scripts:true
	        		, scope: this}
	        		})
     		
		    form = new Ext.form.FormPanel({
	        baseCls: 'x-plain',
	        labelWidth: 55,
	        url: 'http://' + hidef.ServerDomain+ '/jsp/kor/messenger/flex_file_save.jsp',
	        defaultType: 'textfield',
	        fileUpload : true,
	        items: [
	        {
	            fieldLabel: '받는사람',
	            name: buddyIndex + '_to',
	            value: toBuddyNm  ,
	            readOnly : true,
	            anchor: '100%'  // anchor width by percentage
	        },f_panel
	        ,{
		        xtype:'panel',
	            id: 'webEditor',
	            html: webEditorHtml 
	            ,height: 30
   			} ,
//	            ,{
//		        xtype:'panel',
//	            id: 'webPainting',
//	            html: fontColorLayer 
//	        },
	        	{
	            //xtype:'htmleditor',
	            xtype:'textarea',
	            name: buddyIndex + '_content',
	            hideLabel: true,
	            enableAlignments: false,
	            enableLinks: false,
	            enableSourceEdit: false,
	            enableLists: false,
	            //height:120,
	            anchor: '100% -220'
	            //anchor: '100% -53'
	        },{
	            xtype: 'hidden',
	            name: 'buddyIndex',
	            value: buddyIndex
	        },{
	            xtype: 'hidden',
	            name: 'fromBuddyId',
	            value: fromBuddyId
	        },{
	            xtype: 'hidden',
	            name: 'fromBuddyNm',
	            value: fromBuddyNm
	        },{
	            xtype: 'hidden',
	            name: 'toBuddyId',
	            value: toBuddyId
	        }]
	        
	    });
		    
	    
	 }else{
	 	tTitle = "쪽지  보내기";
	 	
	 	var f_panel = new Ext.Panel(
	        		{width:395,height:110,
	        		 //autoLoad: {url: '/flex/jsp/msg_fileupload_flex.jsp'
	        		 autoLoad: {url: '/jsp/kor/messenger/flex_loading.jsp?width=95'
	        		, scripts:true
	        		, scope: this}
	        		})
	 	
	 	form = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        labelWidth: 55,
        url: 'http://' + hidef.ServerDomain + '/jsp/kor/messenger/flex_file_save.jsp',
        defaultType: 'textfield',
        fileUpload : true,
        items: [
        {
            fieldLabel: '받는사람',
            name: buddyIndex + '_to',
            value: toBuddyNm + "(" + toBuddyId  + ")"  ,
            readOnly : true,
            anchor: '100%'  // anchor width by percentage
        },{
		        xtype:'panel',
	            id: 'webEditor',
	            html: webEditorHtml 
	            ,height: 30
   			}
        ,{
           // xtype:'htmleditor',
        	xtype:'textarea',
            name: buddyIndex + '_content',
            hideLabel: true,
            enableAlignments: false,
            enableLinks: false,
            enableSourceEdit: false,
            enableLists: false,
            id: buddyIndex + '_content',
            height:90,
            anchor: '100% -163'
            //anchor: '100% -53'
        },f_panel,
        {
            xtype: 'hidden',
            name: 'buddyIndex',
            value: buddyIndex
        },{
            xtype: 'hidden',
            name: 'fromBuddyId',
            value: fromBuddyId
        },{
            xtype: 'hidden',
            name: 'fromBuddyNm',
            value: fromBuddyNm
        },{
            xtype: 'hidden',
            name: 'toBuddyId',
            value: toBuddyId
        }]
        
    });
    
	 }
      
    
//    var form = new Ext.form.FormPanel({
//        baseCls: 'x-plain',
//        labelWidth: 55,
//        //url:'/jsp/kor/messenger/file_save.jsp',
//        url: 'http://naravision.net/jsp/kor/messenger/file_save.jsp',
//        defaultType: 'textfield',
//        fileUpload : true,
//        items: [
//        {
//            fieldLabel: '받는사람',
//            name: buddyIndex + '_to',
//            value: toBuddyNm,
//            readOnly : true,
//            anchor: '100%'  // anchor width by percentage
//        },{
//            inputType: 'file' ,
//            fieldLabel: '파일첨부',
//            name: buddyIndex + '_attachFile',
//            anchor:'100%'  // anchor width by percentage
//        },{
//            xtype:'htmleditor',
//            name: buddyIndex + '_content',
//            hideLabel: true,
//            enableAlignments: false,
//            enableLinks: false,
//            enableSourceEdit: false,
//            enableLists: false,
//            
//            height:200,
//            anchor: '100% -53'
//        },{
//            xtype: 'hidden',
//            name: 'buddyIndex',
//            value: buddyIndex
//        },{
//            xtype: 'hidden',
//            name: 'fromBuddyId',
//            value: fromBuddyId
//        },{
//            xtype: 'hidden',
//            name: 'fromBuddyNm',
//            value: fromBuddyNm
//        },{
//            xtype: 'hidden',
//            name: 'toBuddyId',
//            value: toBuddyId
//        }]
//        
//    });
//    
        
   win = new Ext.Window({
        title: tTitle , //'쪽지보내기',
//        width: 450,
//        height:300,
        width: 410,
        //height: 353,
        height: 353,
        minWidth: 350,
        //minHeight: 250,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        collapsible: true,
        items: form,
		bodyBorder :false,
		border:false,
        buttons: [{
            text: '보내기',
            handler: function(){
                js_Note_send(win,form);
            }
        },{
            text: '취소',
            handler: function(){
                //js_Note_cancel(win);
                js_Note_cancel(win , form, buddyIndex);
               
            }
        }],
        tbar:[new Ext.Action
            ({
                id:'note_userAddAction',
                text: '받는사람추가',
                iconCls: 'buddyOn',
                handler: function()
                {  
                    multiUserNoteWindow.create(win , form , toBuddyId,toBuddyNm ,fromBuddyId,buddyIndex);
                }
            })]
    });
    
//     if(Note_popup){
//	    win.pageX = 100;
//	    win.pageY = 150;
//	 }
    
    win.show();
    
    }
    
}

function js_Note_delay()
{
    
}

var sendTotCnt = 0;
var curNoteSendCnt = 0;



//flex 로인한 전역 변수로 변경
var toBuddyIdArr;
var buddyIndex;
var fromBuddyId;
var fromBuddyNm;
var toBuddyId;
var noteMessage;
var len;

function js_Note_send(win,form)
{
//    var buddyIndex = form.getForm().findField('buddyIndex').getValue();
//    var fromBuddyId = form.getForm().findField('fromBuddyId').getValue();
//    var fromBuddyNm = form.getForm().findField('fromBuddyNm').getValue();
//    var toBuddyId = form.getForm().findField('toBuddyId').getValue();
//    var noteMessage = form.getForm().findField(buddyIndex + '_content').getValue();
//    var fileUrl = form.getForm().findField( buddyIndex + '_attachFile').getValue();
//    

	 buddyIndex = form.getForm().findField('buddyIndex').getValue();
     fromBuddyId = form.getForm().findField('fromBuddyId').getValue();
     fromBuddyNm = form.getForm().findField('fromBuddyNm').getValue();
     toBuddyId = form.getForm().findField('toBuddyId').getValue();
     noteMessage = form.getForm().findField(buddyIndex + '_content').getValue();
     form.getForm().findField('toBuddyId').setValue = '';
	
    if( toBuddyId == '' )
    {
        alert( '받는사람이 정의되지 않았습니다');
        return;   
    }
    if( noteMessage == '' )
    {
        window.setTimeout("js_Note_delay()", 500);
        noteMessage = form.getForm().findField(buddyIndex + '_content').getValue();
    }
    if( noteMessage == '' )
    {
        window.setTimeout("js_Note_delay()", 500);
        noteMessage = form.getForm().findField(buddyIndex + '_content').getValue();
    }
    if( noteMessage == '' )
    {
        window.setTimeout("js_Note_delay()", 500);
        noteMessage = form.getForm().findField(buddyIndex + '_content').getValue();
    }
    if( noteMessage == '' )
    {
        window.setTimeout("js_Note_delay()", 500);
        noteMessage = form.getForm().findField(buddyIndex + '_content').getValue();
    }
//    if( noteMessage == '' )
//    {
//        alert( '보낼 쪽지 내용이 없습니다.');
//        return;
//    }
    
//    var toBuddyIdArr = toBuddyId.split( ',');
    
    toBuddyIdArr = toBuddyId.split( ',');
    len = toBuddyIdArr.length;
    sendTotCnt = len;
    
    // flex file upload.............
 	fileUrl = document.flexUpload;
    var flashcnt = getFileCount();
    
     if(flashcnt > 0){
    
    	 if( fileUrl != '' ||  fileUrl != null )
		    {
		   		if( !fileUrl ) {
					alert("flex 파일 업로드가  로드되지 못했습니다.");
					return;
				}
				setAttechMode("msgUpload","file_save_result");
				fileUrl.upload();
				
		    }
    	
    }else{
    	if( noteMessage == '' )
	    {
	        alert( '보낼 쪽지 내용이 없거나 선택된 파일이 없습니다.');
	        return;
	    }
	     for( i = 0 ; i < len ; i++ )
        {
            var toBuddyIdReal = toBuddyIdArr[i];
            
            var fontInfo = setFonts(buddyIndex);
           // alert(fontInfo+"1");
            js_Note_Success(buddyIndex, fromBuddyId, fromBuddyNm , toBuddyIdReal ,noteMessage,'0','0','','' ,fontInfo );
            //js_Note_closeAll( win , len , i+1 ); 
            js_Note_closeAll( win , len , i+1, form , buddyIndex );
        }
	    
    }
    
//    if( fileUrl != '' )
//    {
//        form.getForm().doAction(
//                                "submit", 
//                                {   method: 'post' ,
//                                 	// method: 'get' , 
//                                    scope:'request' ,
//                                    waitMsg:'Please Wait...',
//                                    params: { method : 'remove_note', test: "박세현"},
//                                    success: function(f,a)
//                                    {
//                                        var toBuddyIdReal = toBuddyIdArr[curNoteSendCnt];
//                                        js_Note_Success(buddyIndex, 
//                                                        fromBuddyId, 
//                                                        fromBuddyNm , 
//                                                        toBuddyIdReal ,
//                                                        noteMessage,
//                                                        a.result.data.fileCount,
//                                                        a.result.data.fileSize,
//                                                        a.result.data.fileInfo,
//                                                        a.result.data.webpath );
//                                         curNoteSendCnt++;
//                                         
//                                         if( sendTotCnt > curNoteSendCnt )
//                                         {
//                                            js_Note_send(win,form);
//                                        }else{
//                                            js_Note_closeAll( win , len , curNoteSendCnt );  
//                                        }            
//                                                      
//                                    },
//                                    failure: function(f,a)
//                                    {
//                                        js_Note_fail(a.result.errors.ErrorCode);
//                                        sendTotCnt = 0;
//                                        curNoteSendCnt = 0;
//                                        return;
//                                    }  
//                                });
//    }else{
//        for( i = 0 ; i < len ; i++ )
//        {
//            var toBuddyIdReal = toBuddyIdArr[i];
//            js_Note_Success(buddyIndex, fromBuddyId, fromBuddyNm , toBuddyIdReal ,noteMessage,'0','0','','' );
//            js_Note_closeAll( win , len , i+1 ); 
//        }
//    }
//    
    
}

function setFonts(buddyIndex){
	  	 //var mlMsg_textarea = $('msg_'+dialogueID);
	  	var mlMsg_textarea  = $(buddyIndex + '_content');
       
      	var setFont = '';   
    

        var isBold      = (mlMsg_textarea.style.fontWeight == '700' ? '1' : '0');
        var isItalic    = (mlMsg_textarea.style.fontStyle == 'italic' ? '1' : '0');
        var isUnderline = (mlMsg_textarea.style.textDecoration == 'underline' ? '1' : '0');
        var fontName    = $('fontName_'+buddyIndex).value;
        var fontSize    =  $('fontSize_'+buddyIndex).value;
        var fontColor   = (mlMsg_textarea.style.color == '' ? '#000000' : mlMsg_textarea.style.color);
        var fontColors ="";
        
        if(fontColor.length >6){
        		for(var k=1; k<6; k=k+2){
        		fontColors = fontColors + hidef.js_HexToDec(fontColor.substring(k,k+2)) +","
        		}
        }else{
        		for(var k=1; k<6; k=k+2){
        		fontColors = fontColors + '00'  +","
        		}
        }		
        
		 setFont =  fontName + "," + fontSize + "," + fontColors  +  isBold + "," + isItalic + "," + isUnderline;
		 return setFont;
		 
}
function file_save_result(){
		//alert('test');
	
        form.getForm().doAction(
                                "submit", 
                                {   method: 'post' ,
                                 	// method: 'get' , 
                                    scope:'request' ,
                                    waitMsg:'Please Wait...',
                                   // params: { method : 'remove_note', test: "박세현"},
                                    success: function(f,a)
                                    {
                                    	var toBuddyIdReal = toBuddyIdArr[curNoteSendCnt];
                                        var fontInfo = setFonts(buddyIndex);
                                       
                                        js_Note_Success(buddyIndex, 
                                                        fromBuddyId, 
                                                        fromBuddyNm , 
                                                        toBuddyIdReal ,
                                                        noteMessage,
                                                        a.result.data.fileCount,
                                                        a.result.data.fileSize,
                                                        a.result.data.fileInfo,
                                                        a.result.data.webpath ,
                                                        fontInfo);
                                         curNoteSendCnt++;
                                         
                                         if( sendTotCnt > curNoteSendCnt )
                                         {
                                            js_Note_send(win,form);
                                        }else{
                                            js_Note_closeAll( win , len , curNoteSendCnt , form , buddyIndex);  
                                            //js_Note_closeAll( win , len , curNoteSendCnt);  
                                        }            
                                                      
                                    },
                                    failure: function(f,a)
                                    {
                                        js_Note_fail(a.result.errors.ErrorCode);
                                        sendTotCnt = 0;
                                        curNoteSendCnt = 0;
                                        return;
                                    }  
                                });
}



function js_Note_Reply(win,form)
{
    var now = new Date();
    var buddyIndex = now.getDateString("YYYYMMDDhhmm");
    var myid = hidef.user_id;
    var myName = hidef.uaconfArr[1];
        
    var toBuddyId = form.getForm().findField('fromBuddyId').getValue();
    var toBuddyNm = form.getForm().findField('fromBuddyNm').getValue();
    
    noteSendwindow.create( buddyIndex , myid , myName , toBuddyId , toBuddyNm);
    win.close(); 
}

//function js_Note_closeAll(win, totCnt , curCnt)
//{
//    if( totCnt == curCnt)
//    {
//        sendTotCnt = 0;
//        curNoteSendCnt = 0;
//        win.close(); 
//    }
//}

function js_Note_closeAll(win, totCnt , curCnt ,form ,buddyIndex)
{
    if( totCnt == curCnt)
    {
        sendTotCnt = 0;
        curNoteSendCnt = 0;
       
        
      
        
        if(Note_popup){
        	win.close();
         	alert('정상적으로 메시지가 전송되었습니다.'); 
         	//alert($('msg_'+tmpszIndex));
         	//if($('msg_'+tmpszIndex) != null) $('msg_'+tmpszIndex).focus();
        }	
         else{
         	win.close();
         	alert('정상적으로 메시지가 전송되었습니다.');
            // location.href='/jsp/kor/realtime/note_send_success.jsp?mailResult=<%=mailResult%>' ;
         	 //location.href='/jsp/kor/realtime/note_send_success.jsp?MailResult=' + back_url;
	       // form.getForm().findField(buddyIndex + '_content').setValue('');
	       // form.getForm().findField(buddyIndex + '_content').focus();
         }
        
    }
}


function js_Note_close(win)
{
    win.close(); 
}

function js_Note_cancel(win)
{
    win.close(); 
}

function js_Note_cancel(win ,form , buddyIndex)
{ 	
	win.close();
//	if(Note_popup)
//       		win.close();
//    else{
//	      form.getForm().findField(buddyIndex + '_content').setValue('');
//		  form.getForm().findField( buddyIndex + '_attachFile').setValue('');
//		  form.getForm().findField(buddyIndex + '_content').focus();
//    }
}

function js_Note_Success(buddyIndex, fromBuddyId, fromBuddyNm , toBuddyId ,noteMessage,fileCount,fileSize,fileInfo,webpath ,fontInfo)
{
    //var fontInfo = '';
    var secTime = '000000000000000';
    var onoffFlag = '1'; //온라인/오프라인 유저구분
    var confirm = 'N'; //수신확인여부
    // alert(webpath + ":" + fileInfo);
    
    hidef.NoteSend(buddyIndex, fromBuddyId, fromBuddyNm, toBuddyId, fontInfo, secTime,
									onoffFlag, confirm, fileCount, fileSize, fileInfo, noteMessage);
}

function js_Note_fail(errorCode)
{
    alert( '['+errorCode +']' +'첨부파일 전송이 실패했습니다.');   
}

function js_Note_open(clickBuddyId ,clickBuddyNm)
{
    var now = new Date();
    var buddyIndex = now.getDateString("YYYYMMDDhhmm");
      
    var myid = hidef.user_id;
    var myName = hidef.uaconfArr[0];
    
    var toBuddyId = clickBuddyId;
    var toBuddyNm = clickBuddyNm;
    
    noteSendwindow.create( buddyIndex , myid , myName , toBuddyId , toBuddyNm);   
    
}

function js_Note_open(clickBuddyId ,clickBuddyNm ,szIndex)
{
	//alert(clickBuddyId+":::"+clickBuddyNm+":::"+szIndex);
	tmpszIndex = szIndex;
	
	var now = new Date();
    var buddyIndex = now.getDateString("YYYYMMDDhhmm");
      
    var myid = hidef.user_id;
    var myName = hidef.uaconfArr[0];
    
//    var toBuddyId = hidef.receive_user_id;
//    var toBuddyNm =hidef.receive_user_nm;
    
    var toBuddyId = clickBuddyId;
    var toBuddyNm = clickBuddyNm;
    
    /*var myName = hidef.uaconfArr[0];
    
    var toBuddyId = clickBuddyId;
    var toBuddyNm = clickBuddyNm;
    */
    
    //alert(buddyIndex+":::"+myid+":::"+myName+":::"+toBuddyId+":::"+toBuddyNm+":::"+szIndex);
    noteSendwindow.create( buddyIndex , myid , myName , toBuddyId , toBuddyNm ,szIndex);   
    
}

function js_notify_note(obj)
{
    var buddyIndex = '';
    var fromBuddyId = '';
    var fromBuddyNm = '';
    var fontInfo = '';
    var sentTime = '';
    var secTime = '';
    var onoffFlag = '';
    var confirm = '';
    var msggroup = '';
    var backimageindex = '';
    var fileCount = '';
    var fileSize = '';
    var fileInfo = '';
    var noteMessage = '';
    
    if( obj != null )
    {
        buddyIndex = obj[0]; // 메세지인덱스
        fromBuddyId = obj[1]; // 보낸사람계정
        fromBuddyNm = obj[2]; // 보낸사람명
        fontInfo = obj[3]; // 폰트정보
        sentTime = obj[4]; // 보낸시간
        secTime = obj[5]; // 보안타임(사용안해도됨)
        onoffFlag = obj[6]; // 온/오프라인 수신여부
        confirm = obj[7]; // 수신확인여부
        msggroup = obj[8];
        backimageindex = obj[9];
        fileCount = obj[10]; // 첨부파일갯수
        fileSize = obj[11]; // 파일사이즈
        fileInfo = obj[12]; // 파일정보
        noteMessage = obj[13].split(chRecord)[0]; // 본문
    }
    noteRcvwindow.create( fromBuddyId , fromBuddyNm , fn_getDateFormatString(sentTime, 'YYYY년 MM월 DD일 hh:mm:ss' ) ,fileCount , fileSize ,fileInfo, noteMessage,fontInfo ); 
    
}

var multiUserNoteWindow = {
    create : function(originalWin , originalForm , toBuddyId,toBuddyNm ,fromBuddyId,buddyIndex) {

            Ext.grid.curtUserData = js_noteBuddyload(toBuddyId , fromBuddyId);
            
            var xg = Ext.grid;
            
            var comboValue = [
                 ['이름', 'user_nm'],
                 ['아이디', 'user_id'] ];
            
            var comboStore = new Ext.data.SimpleStore({
                fields: ['val', 'key'],
                data : comboValue 
            });
            
            var combo = new Ext.form.ComboBox({
                    store: comboStore,
                    displayField:'val',
                    valueField :'key',
                    mode: 'local',
                    triggerAction: 'all',
                    typeAhead: true,
                    editable:false,
                    selectOnFocus:true,
                    value: comboStore.getAt(0).get('key'),
                    width:100
                    });
            
            var field = new Ext.form.TextField({
                  fieldLabel:'조건',
                  id:'schType',
                  name: 'field',
                  width:100,
                  maxLength:20
                 });
            
            var searchAction = new Ext.Action
            ({
                id:'searchAction',
                text: '검색',
                iconCls: 'blist',
                handler: function()
                {  
                    userSearch();
                }
            });
            
            var preAction = new Ext.Action
            ({
                 id:'preAction',
                 text: '이전',
                 handler: function()
                 {  
                    preSearch();                  
                 }
            });
            
            var nextAction = new Ext.Action
            ({
                id:'nextAction',
                text: '다음',
                handler: function()
                {  
                  nextSearch();
                }
            });

                     

            var store = new Ext.data.ArrayReader({}, [
                   {name: 'name' },
                   {name: 'userId' }
                ]
             );
            
             var sm = new xg.CheckboxSelectionModel();
             var searchGrid = new xg.GridPanel({
                id:'button-grid',
                store: new Ext.data.Store({
                    reader: store,
                    data: xg.curtUserData
                }),
                cm: new xg.ColumnModel([
                    sm,
                     {id:'name',header:"이름", width:80,  dataIndex: 'name'},
                     {id:'userId',header:"아이디", width:160,  dataIndex: 'userId'}
                ]),
                sm: sm, 
                stripeRows: true,
                height:250,
                width:800                
             });        
            
            var addAction = new Ext.Action
            ({
                id:'addAction',
                text: '추가하기',
                handler: function()
                {  
                 js_noteBuddyAdd(originalWin , originalForm , toBuddyId,toBuddyNm ,buddyIndex , searchGrid.getSelectionModel().getSelections());
                 win.close();
                }
            });       
            
            var win = new Ext.Window({
              //el:'hello-win',
              title:'받는사람 추가하기',
              layout:'fit',
              width:280,
              height:280,
              //id: "invite_MlMsg_window_" + dialogueID,
              autoScroll:true,
              resizable:false,
              plain: true,              
              bbar: [
                     addAction
                    ],                    
              items: searchGrid
              
            });
            
            win.show();
            
            // 초대하기 창 닫기
            win.on('close', function() {
                
            });
            
                  
    }
}


/*
    초대하기 DATA 
*/
function js_noteBuddyload(toBuddyId , fromBuddyId) {
    
    var arrCrutBuddy = new Array();
    var watcherHashVal = hidef.js_getWatcherChatList();
    var keys = watcherHashVal.getKeys();

    var buddyArr;
    var len = keys.length;
    var j = 0;
    
    for ( var i = 0; i < len; i++)
    {
        buddyArr = watcherHashVal.get(keys[i]);
        
        if( toBuddyId != buddyArr[0] && fromBuddyId != buddyArr[0] )
        {
            arrCrutBuddy[j] = new Array(2);
            arrCrutBuddy[j][0] = buddyArr[1];
            arrCrutBuddy[j][1] = buddyArr[0];
            j++;
        }
    }      
    return arrCrutBuddy;

} 

function js_noteBuddyAdd(win , form , toBuddyId ,toBuddyNm ,buddyIndex , selection )
{
    var invertUserids = toBuddyId;
    var invertUserNames = toBuddyNm;
    if(selection != "") {
        
    	for( var i = 0; i < selection.length;  i++ ) {
    
    	     invertUserids = invertUserids + "," + selection[i].get("userId");
    	     invertUserNames = invertUserNames + "," + selection[i].get("name");
    	}
    	
    	form.getForm().findField('toBuddyId').setValue(invertUserids);
        form.getForm().findField(buddyIndex+ '_to').setValue(invertUserNames);
        
    } else {
        alert("초대하실 분을 선택해 주세요");   
    }
}



// Editor Actio 처리
var CtntEditorNote = {
     
    toggleBold: function(buddyIndex) {
        
        //var sendTextarea = $('msg_'+dialogueID);
        var sendTextarea  = $(buddyIndex + '_content');
        
        if(sendTextarea.style.fontWeight == '700') {
            $('bold_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn01_off.gif';
            sendTextarea.style.fontWeight = '400';
        } else {
            $('bold_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn01_over.gif';
            sendTextarea.style.fontWeight = '700';
        }
    },   
    
    toggleItalic: function(buddyIndex) {
        
        //var sendTextarea = $('msg_'+dialogueID);
          var sendTextarea  = $(buddyIndex + '_content');
           
        if(sendTextarea.style.fontStyle == 'italic') {

            $('italic_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn02_off.gif';
            sendTextarea.style.fontStyle = 'normal';
             
        } else {
            $('italic_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn02_over.gif';
            sendTextarea.style.fontStyle = 'italic';
            
        }
    },    

    toggleUnderline: function(buddyIndex) {
        
        //var sendTextarea = $('msg_'+dialogueID);
    	var sendTextarea  = $(buddyIndex + '_content');
        
        if(sendTextarea.style.textDecoration == 'underline') {

            $('underline_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn03_off.gif';
            sendTextarea.style.textDecoration = 'none';

             
        } else {
            $('underline_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn03_over.gif';
            sendTextarea.style.textDecoration = 'underline';
            
        }
    },  
    
    toggleFontName: function(buddyIndex, fontName) {
        //var sendTextarea = $('msg_'+dialogueID);
         var sendTextarea  = $(buddyIndex + '_content');
           
        sendTextarea.style.fontFamily = fontName;     
    },  

    toggleFontSize: function(buddyIndex, tfontSize) {
        //var sendTextarea = $('msg_'+dialogueID);
    	var sendTextarea  = $(buddyIndex + '_content');
       
    	sendTextarea.style.fontSize = tfontSize + "pt";
        //sendTextarea.setStyle({'top: 100px;'});
    },  

    toggleFontColor: function(buddyIndex) {
        
        var fontColorPanel = $('NotemsgFontColor_'+buddyIndex);
        var ftb = $('NotefontColorList');
        
        if(ftb.style.display == 'block') {
            $('fontColor_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn04_off.gif';
            ftb.style.display= 'none';
               
        } else {
            $('fontColor_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn04_over.gif';
//            ftb.style.left= 160;
//            ftb.style.top= 325;
            ftb.style.display= 'block';
        }
    },
    
    setFontColor : function(buddyIndex, sltColor) {

        var ftb = $('NotefontColorList');
        //var sendTextarea = $('msg_'+dialogueID);
        var sendTextarea  = $(buddyIndex + '_content');
        
        sendTextarea.style.color = sltColor;     
        ftb.style.display = 'none';
        $('fontColor_'+buddyIndex).src = '/jsp/kor/messenger/images/ico/icon_btn04_off.gif';
    }
}


