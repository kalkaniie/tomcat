/* 오픈된 팝업 대화창을 관리*/
var openPopDialHash = new Hash();
/* 오픈된 초대하기*/
var invtDialogArr = new Array();

/*원격제어 프로그레스바......*/
var remoteCallerProgress ;

/*쪽지창 팝업 유무......*/
var Note_popup = false;

function loadingProgress(){
	
	if(remoteCallerProgress == null){
	  	remoteCallerProgress = new Ext.ProgressBar({
	      id:'pbar',
	      width:200,
	      waitConfig: {interval:200}, 
	      text : 'Please Wait...',
	      renderTo: 'progress-div'
	    });
    }
    return remoteCallerProgress;    
}


function loadTrace(win,dialogueID) {
    var handle1 = "handle1" + dialogueID;   
    var track1 = "track1" + dialogueID;   
    new Control.Slider(handle1,track1,{
      sliderValue: 1,  
      range:$R(0.5,1),
      onChange:function(v){
            if(v < 1) {
                v = v*0.5;
            }
            win.getEl().setOpacity(v);
            
            }});
}


var inviteWindow = {
    create : function(dialogueID) {

            Ext.grid.curtUserData = hidef.js_curtBuddyload(dialogueID);
            
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

            var addAction = new Ext.Action
            ({
                id:'addAction',
                text: '초대하기',
                handler: function()
                {  
                 hidef.js_inviteUser(dialogueID, searchGrid.getSelectionModel().getSelections());
                 win.close();
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
                   
            var win = new Ext.Window({
              //el:'hello-win',
              title:'초대하기',
              layout:'fit',
              width:280,
              height:280,
              //id: "invite_MlMsg_window_" + dialogueID,
              autoScroll:true,
              resizable:false,
              plain: true,
              /*
              tbar: [combo
                     ,'-' 
                     ,field
                     ,'-' 
                     ,searchAction
                     //,'-' 
                     //,preAction
                     //,'-' 
                     //,nextAction
                    ],*/
              bbar: [
                     addAction
                    ],                    
              items: searchGrid

              
            });
            
            win.show();
            // 초대하기 창 관리 
            invtDialogArr.push(dialogueID);
            // 초대하기 창 닫기
            win.on('close', function() {
                invtDialogArr = invtDialogArr.without(dialogueID);
            });            
            //parent.js_curtBuddyload();
    }
}


/* 대화창 생성 */
var dialogueWindow = {
  
  create: function(dialogueID, buddyName, buddyID, state) {
		var winCntLayer = "<div id='mlMsg_window_crutUser_"+dialogueID+"' class='msgWdw_crut_user'></div><div id='mlMsg_window_cntnt_"+dialogueID+"' class='msgWdw_cntnt'></div>"

        var fontnames = ['돋음', '굴림', '바탕', '궁서', 'Arial', 'courier new','Georgia', 'Tahoma', 'Verdana', 'impact', 'WingDings'];
        var fontsizes = ['10', '12', '14', '16', '18', '20', '22', '24', '26', '28'];
        
        var fontNameSelectHtml = ""
    
            fontNameSelectHtml += "<select id='fontName_"+dialogueID+"' name='fontName_"+dialogueID+"' style='margin: 1 2 0 2; font-size: 12px;' onChange=\"CtntEditor.toggleFontName('"+dialogueID+"',this.value);\">";
            for (var i = 0; i < fontnames.length; i++) {
                fontNameSelectHtml += "<option value='" + fontnames[i]+ "'>" + fontnames[i] + "</option>";
            }
            fontNameSelectHtml += "</select>";
    
        var fontSizeSelectHtml = ""
    
            fontSizeSelectHtml += "<select id='fontSize_"+dialogueID+"' name='fontSize_"+dialogueID+"' style='margin: 1 2 0 2; font-size: 12px;' onChange=\"CtntEditor.toggleFontSize('"+dialogueID+"',this.value);\">";
            for (var i = 0; i < fontsizes.length; i++) {
                fontSizeSelectHtml += "<option value='" + fontsizes[i]+ "'>" + fontsizes[i] + "</option>";
            }
            fontSizeSelectHtml += "</select>";
    
    
        var fontColorLayer ="<div id='fontColorList' class='msgWdw_fontColorList'>"+
                        "<table  bgcolor='E7E7E7'>"+
                        "<tr>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#000000;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#000000');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#b8b8b8;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#b8b8b8');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#b4ad3b;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#b4ad3b');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#bb5c54;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#bb5c54');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#755a5c;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#755a5c');\"></td>"+
                        "</tr>"+                                                                                                                                                              
                        "<tr>"+                                                                                                                                                               
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#a9b5ef;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#a9b5ef');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#d65a20;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#d65a20');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#e39230;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#e39230');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#a71334;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#a71334');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#590099;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#590099');\"></td>"+
                        "</tr>"+                                                                                                                                                              
                        "<tr>"+                                                                                                                                                               
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#d40088;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#d40088');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#0030ac;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#0030ac');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#676f11;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#676f11');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#769321;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#769321');\"></td>"+
                        "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#3966fe;' onclick=\"CtntEditor.setFontColor('"+dialogueID+"','#3966fe');\"></td>"+
                        "</tr>"+
                        "</table>"+
                        "</div>";
    
    
        //document.writeln(fontNameSelect);
        var webEditorButtonHtml = " <img src='/jsp/kor/realtime_mysql/images/ico/icon_btn01_off.gif' id='bold_"+dialogueID+"' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditor.toggleBold('"+dialogueID+"');\"> "+
                             " <img src='/jsp/kor/realtime_mysql/images/ico/icon_btn02_off.gif' id='italic_"+dialogueID+"' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditor.toggleItalic('"+dialogueID+"');\"> "+
                             " <img src='/jsp/kor/realtime_mysql/images/ico/icon_btn03_off.gif' id='underline_"+dialogueID+"' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditor.toggleUnderline('"+dialogueID+"');\"> "+
                             " <img src='/jsp/kor/realtime_mysql/images/ico/icon_btn04_off.gif' id='fontColor_"+dialogueID+"' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditor.toggleFontColor('"+dialogueID+"');\">"+
                          //   " <a href='' class='msgWdw_edit_icon' align='absmiddle'>원격제어 </a>|"+
                          //   " <a href='' class='msgWdw_edit_icon' align='absmiddle'>파일보내기</a>"+
                             "<div id='msgFontColor_"+dialogueID+"'></div> ";
        var webEditorHtml = " <table height='25' width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='E7E7E7'><tr><td>"+ fontNameSelectHtml + fontSizeSelectHtml + webEditorButtonHtml +"</td></tr></table>"
        var winTextareaHtml ="<form name='msg_form_"+dialogueID+"' method='post'>"+webEditorHtml+"<textarea name='msg_"+dialogueID+"' class='msgWdw_textarea' id='msg_"+dialogueID+"' onKeyUp=\"javascript:hidef.js_sendmsg('"+dialogueID+"', '"+buddyID+"');\"></textarea></form>" + fontColorLayer;

        //var winTextareaHtml = "<form name='msg_form_"+dialogueID+"' method='post'><textarea name='msg_"+dialogueID+"' class='msgWdw_textarea' id='msg_"+dialogueID+"' onKeyUp=\"javascript:hidef.js_sendmsg('"+dialogueID+"', '"+buddyID+"');\"></textarea></form>";
		//var titleHtml = '<table cellpadding="0" cellpading="0" border="0" width="85%"><tr><td width="75%"><b><font size=2>'+ buddyName + '님과  대화</font></b> </td><td aling="right"><div id="track1'+dialogueID+'" style="width:70px; height:1px; height:2px; cursor:hand; align:right;"><img src="" width="1" height="8"><br><img src="/images/default/grid/grid3-special-col-bg.gif" width="70" height="2" align="absmiddle"></div>'+
        var titleHtml = '<table cellpadding="0" cellpading="0" border="0" width="85%"><tr><td width="85%"><img src="/jsp/kor/realtime_mysql/images/ico/icon_admin.gif"><b>'+ buddyName + '</b>님과  대화</td>'+
        				'<td aling="right"><div id="track1'+dialogueID+'" style="width:70px; height:1px; height:2px; cursor:hand; align:right;">'+
        				'</div>'+
                        '</td></tr></table>';

        
        var p1 = new Ext.Panel({
            width: 100,
            height: 260,
            layout:'fit',
            collapsible: true,
            defaults:{autoScroll:true},
            margins:'3 0 3 3',
            cmargins:'3 3 3 3',
            split: true,
            region: 'center',
            bodyBorder :false,
			border:false,
            html: winCntLayer
        });

        var action1 = new Ext.Action
        ({
            id:'action1',
            //text: '초대하기',
            text: '원격제어 요청',
            iconCls: 'blist',
            handler: function()
            {  
            	activeXinstallWindow.create();
            }
        });

        var action2 = new Ext.Action
        ({
            id:'action2',
            text: '창 화면밖으로',
            iconCls: 'blist',
            handler: function()
            {  
                win.collapse(); 
                js_open_win(dialogueID, buddyName, buddyID);   
            }
        });

        /*var action3 = new Ext.Action
        ({
            id:'action3',
            text: '저장하기',
            iconCls: 'blist',
            handler: function()
            {  
                hidef.js_saveMsg(dialogueID);
            }
        });*/        
         var action3 = new Ext.Action
        ({
            id:'action3',
            text: '파일보내기',
            iconCls: 'blist',
            handler: function()
            {  
                //hidef.js_saveMsg(dialogueID);
            	Note_popup = true;
                js_Note_open();
            }
        });   
        var win = new Ext.Window({
            title: titleHtml,
            //title: buddyName + '님과 대화',
            //id: "ext_MlMsg_window_" + dialogueID,
            /*width: 340,
            height:425,
            */
            pageX:70,
            pageY:195,
            width: 383,
            height:313,
            minWidth: 300,
            minHeight: 200,
            collapsible:true,
            layout: 'border',
            plain:true,
            bodyStyle:'padding:5px;',
            buttonAlign:'center',
            bodyBorder :false,
			border:false,
            items: [p1,
                {
                    region:'south',
                    split : true,
                    margins:'3 0 3 3',
                    layout:'fit',
                    height:80,
                    html: winTextareaHtml
                }
            ],
            bbar: [ 
                    new Ext.Button(action1)
                    ,'-'
                    //,new Ext.Button(action2)  
                    //,'-'
                   ,new Ext.Button(action3)  
                  ]   
            

        });        

        win.on('close', function() {
          hidef.js_removeDialog(dialogueID);
          invtDialogArr = invtDialogArr.without(dialogueID);
        });
        
 	 	//if(hidef.prsbar!=null)hidef.prsbar.hide();
        if(parent.Ext.get('messenger_loading')!=null)
        	parent.Ext.get('messenger_loading').fadeOut({remove:true});
        
        win.show(); 
      
        loadTrace(win, dialogueID);

    }
}


/*
	대화창을 그린다.
*/
function makeDialogue(dialogueID, buddyName, buddyID)
{   
    // 다이얼 로그를 띄운다.
    dialogueWindow.create(dialogueID, buddyName, buddyID, 'show');
    js_hiddenLayCreate(dialogueID);
    // 창관리를 위한 hidden div 생성
    //alert("makeDialogue");
    
}



function js_hiddenLayCreate(dialogueID) {

    var itemListNode = hidef.$('mlMsg_window_main');
    var newItem = hidef.document.createElement("div");
    newItem.className="msgWdw";
    newItem.setAttribute("id", 'mlMsg_window_'+dialogueID);  
    newItem.style.display='block';  
  	itemListNode.appendChild(newItem); 	 

}
function js_closeDialog(dialogueID) {
    
    //alert($('ext_MlMsg_window_'+dialogueID).show());
}

/*
    떠있는 창관리
*/
function js_switch_dialogue_main(dialogueID)
{

}


/* 대화창을 레이어에서 팝업창으로 전환한다.
* @param args : 대화창아이디
*/
function js_open_win(dialogueID, buddyName, buddyID)
{	
    var rlSendID = buddyID.split('@');
	var win = window.open('/jsp/kor/realtime_mysql/dialogue.jsp?dlid='+ dialogueID +'&bn='+ buddyName +'&bid='+buddyID, 'dialogue_'+dialogueID+'_'+rlSendID[0], 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no, resizable=yes,copyhistory=no,width=400, height=500, left=100,top=100');	
	win.focus();
	openPopDialHash.set(dialogueID, win);
}


function removeLayer(dialogueID)
{
	var newArray = new Array();
	var cnt = 0;
	for(i=0; i<dialogueArray.length; i++)
	{
		
		if(dialogueArray[i] == 'mlMsg_window_'+dialogueID)
		{
			count = count - 1 ;			
		} else
		{
			newArray[cnt] = dialogueArray[i];
			cnt++;
		}
	}	
	
	dialogueArray = newArray;		
	dialogueHash.unset(dialogueID);
	hidef.$('mlMsg_window_main').removeChild(hidef.$('mlMsg_window_'+dialogueID));
}

// Editor Actio 처리
var CtntEditor = {
    
    toggleBold: function(dialogueID) {
        
        var sendTextarea = $('msg_'+dialogueID);
        
        if(sendTextarea.style.fontWeight == '700') {
            $('bold_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn01_off.gif';
            sendTextarea.style.fontWeight = '400';
        } else {
            $('bold_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn01_over.gif';
            sendTextarea.style.fontWeight = '700';
        }
    },   
    
    toggleItalic: function(dialogueID) {
        
        var sendTextarea = $('msg_'+dialogueID);
        
        if(sendTextarea.style.fontStyle == 'italic') {

            $('italic_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn02_off.gif';
            sendTextarea.style.fontStyle = 'normal';
             
        } else {
            $('italic_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn02_over.gif';
            sendTextarea.style.fontStyle = 'italic';
            
        }
    },    

    toggleUnderline: function(dialogueID) {
        
        var sendTextarea = $('msg_'+dialogueID);
        
        if(sendTextarea.style.textDecoration == 'underline') {

            $('underline_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn03_off.gif';
            sendTextarea.style.textDecoration = 'none';

             
        } else {
            $('underline_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn03_over.gif';
            sendTextarea.style.textDecoration = 'underline';
            
        }
    },  
    
    toggleFontName: function(dialogueID, fontName) {
        var sendTextarea = $('msg_'+dialogueID);
        sendTextarea.style.fontFamily = fontName;     
    },  

    toggleFontSize: function(dialogueID, tfontSize) {
        var sendTextarea = $('msg_'+dialogueID);
        sendTextarea.style.fontSize = tfontSize + "pt";
        //sendTextarea.setStyle({'top: 100px;'});
    },  

    toggleFontColor: function(dialogueID) {
        
        var fontColorPanel = $('msgFontColor_'+dialogueID);
        var ftb = $('fontColorList');
        
        if(ftb.style.display == 'block') {
            $('fontColor_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn04_off.gif';
            ftb.style.display= 'none';
               
        } else {
            $('fontColor_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn04_over.gif';
            ftb.style.left= 160;
            ftb.style.top= 25;
            ftb.style.display= 'block';
        }
    },
    
    setFontColor : function(dialogueID, sltColor) {

        var ftb = $('fontColorList');
        var sendTextarea = $('msg_'+dialogueID);
        sendTextarea.style.color = sltColor;     
        ftb.style.display = 'none';
        $('fontColor_'+dialogueID).src = '/jsp/kor/realtime_mysql/images/ico/icon_btn04_off.gif';
    }
}


var activeXinstallWindow = {
    create : function() {
   
 	//var prs= loadingProgress();
 	//prs.text = 'wati...';
    //prs.wait();
	//prs.show();
    /*
    if(hidef.prsbar!=null){
		hidef.prsbar.wait();
		hidef.prsbar.show();
    }*/
   
    //	alert(Ext.get('remoteCaller_loading'));
  
		hidef.RemoteCallSetup();
	    var room_id = hidef.GetRemoteRoomID(hidef.user_id);
		if(room_id == -1){  //설치 안되었을 경우
		   var Message ="자동으로 설치 되지 않을 경우 <br/>"+
		   				"수동 설치 하셔야 합니다. 다운 받으시겠습니까?";
		   var form = new Ext.form.FormPanel({
		        baseCls: 'x-plain',
		        labelWidth: 280,
		        defaultType: 'textfield',
		
		        items: [{
		            fieldLabel: Message,
		            labelSeparator:'',
		            name: 'to',
		            anchor:'0%'
		        }]
		    });
		   var window = new Ext.Window({
		        title: '원격제어',
		        width: 280,
		        height:120,
		        resizable:false,
		        layout: 'fit',
		        plain:true,
		        bodyStyle:'padding:5px;',
		        buttonAlign:'center',
		        closeAction:'close',
		        items: form ,
		       buttons: [{
		            text: '확인',
		             handler: function(){
		             	ifmKebiRemoteCaller.location.href =	"/jsp/kor/realtime_mysql/activeX/KebiRemoteCaller.exe";
		                     //buddyAuthSend(window, form);
		                    }
		        },{
		            text: '취소',
		             handler: function(){
		                     window.destroy();
		                    }
		        }]
		      });
		
		    window.show();
		}else{
			if(Ext.get('remoteCaller_loading')!= null)
        		Ext.get('remoteCaller_loading').show();    
			hidef.RcsInviteReq(hidef.user_id,hidef.user_nm, hidef.receive_user_id,  room_id ,hidef.real_user_id );
		}  
    }    
    
}

