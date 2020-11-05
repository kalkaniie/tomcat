/*
	쪽지창을 그린다.
*/

var noteRcvwindow = {
  
  create: function( fromBuddyId , fromBuddyNm , sentTime ,fileCount, fileSize ,fileInfo, noteMessage ) {
    
    var fileNmSize = '';
    var fileOrgNm = '';
    var filewebpath = '';
    var buttonLive = true;
    if( fileInfo.length > 0 && fileCount > 0)
    {
        fileOrgNm = fileInfo.split(',')[0];
        filewebpath = escape(fileInfo.split(',')[1]);
        
        //alert(filewebpath);
        
        fileNmSize = fileOrgNm+' ['+fileSize+' byte]';
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
            height:22,
            xtype:'panel',
            id: 'fileProgress',
            html: '<img src="/jsp/kor/realtime_mysql/images/default/tree/leaf.gif" absmiddle>&nbsp;<a href="http://demo.kebi.com/realtime_mysql/notefiledwn?file1='+filewebpath+'&file2='
            	+ encodeURIComponent(fileOrgNm) + '">'+fileNmSize+'</a>'
        },{ 
            x: 0,
            y: 90,
            xtype:'panel',
            height:500,
            autoScroll:true,
            cmargins:'3 3 3 3',
            anchor: '100% 100%',
            html: createNoteDiv(noteMessage)
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


var noteSendwindow = {
  
  create: function(buddyIndex, fromBuddyId, fromBuddyNm , toBuddyId , toBuddyNm) {
    if( Ext.QuickTips.isEnabled() ) 
      {
        
      }else{
        Ext.QuickTips.init();
      }
    
    
    var form = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        labelWidth: 55,
        //url:'/jsp/kor/realtime_mysql/file_save.jsp',
        url: 'http://demo.kebi.com/jsp/kor/realtime_mysql/file_save.jsp',
        defaultType: 'textfield',
        fileUpload : true,
        items: [
        {
            fieldLabel: '받는사람',
            name: buddyIndex + '_to',
            value: toBuddyNm,
            readOnly : true,
            anchor: '100%'  // anchor width by percentage
        },{
            inputType: 'file' ,
            fieldLabel: '파일첨부',
            name: buddyIndex + '_attachFile',
            anchor:'100%'  // anchor width by percentage
        },{
            xtype:'htmleditor',
            name: buddyIndex + '_content',
            hideLabel: true,
            enableAlignments: false,
            enableLinks: false,
            enableSourceEdit: false,
            enableLists: false,
            
            height:200,
            anchor: '100% -53'
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
    
        
    var win = new Ext.Window({
        title: '쪽지보내기',
        /*width: 450,
        height:300,*/
        pageX:70,
        pageY:195,
        width: 383,
        height: 313,
        minWidth: 350,
        minHeight: 250,
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
                js_Note_cancel(win , form, buddyIndex);
            }
        }]/*,
        tbar:[new Ext.Action
            ({
                id:'note_userAddAction',
                text: '받는사람추가',
                iconCls: 'buddyOn',
                handler: function()
                {  
                    multiUserNoteWindow.create(win , form , toBuddyId,toBuddyNm ,fromBuddyId,buddyIndex);
                }
            })]*/
    });
    if(Note_popup){
	    win.pageX = 100;
	    win.pageY = 150;
    }
    
    win.show();
   // if(hidef.prsbar!=null)hidef.prsbar.hide();
    if(parent.Ext.get('messenger_loading')!=null)
        parent.Ext.get('messenger_loading').fadeOut({remove:true});
    
    }
  
}

function js_Note_delay()
{
    
}

var sendTotCnt = 0;
var curNoteSendCnt = 0;
function js_Note_send(win,form)
{
	 
    var buddyIndex = form.getForm().findField('buddyIndex').getValue();
    var fromBuddyId = form.getForm().findField('fromBuddyId').getValue();
    var fromBuddyNm = form.getForm().findField('fromBuddyNm').getValue();
    var toBuddyId = form.getForm().findField('toBuddyId').getValue();
     form.getForm().findField('toBuddyId').setValue = '';
    var noteMessage = form.getForm().findField(buddyIndex + '_content').getValue();
    var fileUrl = form.getForm().findField( buddyIndex + '_attachFile').getValue();
    
    //alert(1 + ":" + fromBuddyNm);
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
    if( noteMessage == '' )
    {
        alert( '보낼 쪽지 내용이 없습니다.');
        return;
    }
    
    var toBuddyIdArr = toBuddyId.split( ',');
    var len = toBuddyIdArr.length;
    sendTotCnt = len;
    
    if( fileUrl != '' )
    {
   		
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
                                        js_Note_Success(buddyIndex, 
                                                        fromBuddyId, 
                                                        fromBuddyNm , 
                                                        toBuddyIdReal ,
                                                        noteMessage,
                                                        a.result.data.fileCount,
                                                        a.result.data.fileSize,
                                                        a.result.data.fileInfo,
                                                        a.result.data.webpath );
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
    }else{
        for( i = 0 ; i < len ; i++ )
        {
            var toBuddyIdReal = toBuddyIdArr[i];
            js_Note_Success(buddyIndex, fromBuddyId, fromBuddyNm , toBuddyIdReal ,noteMessage,'0','0','','' );
            //js_Note_closeAll( win , len , i+1 ); 
            js_Note_closeAll( win , len , i+1, form , buddyIndex );
        }
    }
    
    
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

/*
function js_Note_closeAll(win, totCnt , curCnt)
{
    if( totCnt == curCnt)
    {
        sendTotCnt = 0;
        curNoteSendCnt = 0;
        win.close(); 
        alert('정상적으로 메시지가 전송되었습니다. \n감사합니다. ')
    }
}
*/

function js_Note_closeAll(win, totCnt , curCnt ,form ,buddyIndex)
{
    if( totCnt == curCnt)
    {
        sendTotCnt = 0;
        curNoteSendCnt = 0;
       
        
        alert('정상적으로 메시지가 전송되었습니다.');
        
        if(Note_popup)
         	win.close();
         else{
	        form.getForm().findField(buddyIndex + '_content').setValue('');
	        form.getForm().findField( buddyIndex + '_attachFile').setValue('');
	        form.getForm().findField(buddyIndex + '_content').focus();
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
	if(Note_popup)
       		win.close();
    else{
	      form.getForm().findField(buddyIndex + '_content').setValue('');
		  form.getForm().findField( buddyIndex + '_attachFile').setValue('');
		  form.getForm().findField(buddyIndex + '_content').focus();
    }
}

function js_Note_Success(buddyIndex, fromBuddyId, fromBuddyNm , toBuddyId ,noteMessage,fileCount,fileSize,fileInfo,webpath)
{
    var fontInfo = '';
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

function js_Note_open()
{
	var now = new Date();
    var buddyIndex = now.getDateString("YYYYMMDDhhmm");
      
    var myid = hidef.user_id;
    var myName = hidef.user_nm;
    
    var toBuddyId = hidef.receive_user_id;
    var toBuddyNm =hidef.receive_user_nm;
    
    /*var myName = hidef.uaconfArr[0];
    
    var toBuddyId = clickBuddyId;
    var toBuddyNm = clickBuddyNm;
    */
    noteSendwindow.create( buddyIndex , myid , myName , toBuddyId , toBuddyNm);   
    
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
    
    if( obj != null && obj.length == 14 )
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
    noteRcvwindow.create( fromBuddyId , fromBuddyNm , fn_getDateFormatString(sentTime, 'YYYY년 MM월 DD일 hh:mm:ss' ) ,fileCount , fileSize ,fileInfo, noteMessage ); 
    
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

