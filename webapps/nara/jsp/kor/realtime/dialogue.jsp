<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*, com.nara.jdf.http.*, com.nara.jdf.util.*, com.nara.jdf.data.*" %>
<%@ include file = "/jsp/kor/common/common.jsp" %>
<%
	HttpAttributes attr = getAttributes( request );
	DataSet input = attr.getDataSet();   
	
	String dialogueID = input.getText("dlid");
	String buddyName  = input.getText("bn"); 
	String buddyID    = input.getText("bid"); 
	
%>
<HTML>

<head>
<title>대화하기</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/basic.css" rel="stylesheet" type="text/css" />
<SCRIPT SRC="js/lib/prototype.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<!-- 
<SCRIPT SRC="js/lib/ext-2.0.2/adapter/ext/ext-base.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/lib/ext-2.0.2/ext-all.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
 -->
 
<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>

<SCRIPT SRC="js/lib/ajax.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>
<SCRIPT SRC="js/lib/scriptaculous/scriptaculous.js" LANGUAGE="javascript" type="text/javascript"></SCRIPT>

<script type="text/javascript">

var inviteWindow = {
    create : function(dialogueID) {

            Ext.grid.curtUserData = opener.hidef.js_curtBuddyload(dialogueID);
            
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
                 opener.hidef.js_inviteUser(dialogueID, searchGrid.getSelectionModel().getSelections());
                 js_curtUserDisplay(dialogueID);
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
            
            //parent.js_curtBuddyload();
    }
}

Ext.onReady(function(){

    var drLayer = "<div id='mlMsg_window_crutUser_<%=dialogueID%>' class='msgWdw_crut_user'></div><div id='mlMsg_window_cntnt_<%=dialogueID%>' class='msgWdw_cntnt'></div>";

    var fontnames = ['돋음', '굴림', '바탕', '궁서', 'Arial', 'courier new','Georgia', 'Tahoma', 'Verdana', 'impact', 'WingDings'];
    var fontsizes = ['10', '12', '14', '16', '18', '20', '22', '24', '26', '28'];
    
    var fontNameSelectHtml = ""

        fontNameSelectHtml += "<select id='fontName_<%=dialogueID%>' name='fontName_<%=dialogueID%>' style='margin: 1 2 0 2; font-size: 12px;' onChange=\"CtntEditor.toggleFontName('<%=dialogueID%>',this.value);\">";
        for (var i = 0; i < fontnames.length; i++) {
            fontNameSelectHtml += "<option value='" + fontnames[i]+ "'>" + fontnames[i] + "</option>";
        }
        fontNameSelectHtml += "</select>";

    var fontSizeSelectHtml = ""

        fontSizeSelectHtml += "<select id='fontSize_<%=dialogueID%>' name='fontSize_<%=dialogueID%>' style='margin: 1 2 0 2; font-size: 12px;' onChange=\"CtntEditor.toggleFontSize('<%=dialogueID%>',this.value);\">";
        for (var i = 0; i < fontsizes.length; i++) {
            fontSizeSelectHtml += "<option value='" + fontsizes[i]+ "'>" + fontsizes[i] + "</option>";
        }
        fontSizeSelectHtml += "</select>";


    var fontColorLayer ="<div id='fontColorList' class='msgWdw_fontColorList'>"+
                    "<table  bgcolor='E7E7E7'>"+
                    "<tr>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#000000;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#000000');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#b8b8b8;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#b8b8b8');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#b4ad3b;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#b4ad3b');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#bb5c54;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#bb5c54');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#755a5c;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#755a5c');\"></td>"+
                    "</tr>"+                                                                                                                                                              
                    "<tr>"+                                                                                                                                                               
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#a9b5ef;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#a9b5ef');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#d65a20;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#d65a20');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#e39230;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#e39230');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#a71334;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#a71334');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#590099;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#590099');\"></td>"+
                    "</tr>"+                                                                                                                                                              
                    "<tr>"+                                                                                                                                                               
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#d40088;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#d40088');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#0030ac;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#0030ac');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#676f11;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#676f11');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#769321;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#769321');\"></td>"+
                    "<td style='width:13px;height:13px;border:1px solid #E7E7E7;background-color:#3966fe;' onclick=\"CtntEditor.setFontColor('<%=dialogueID%>','#3966fe');\"></td>"+
                    "</tr>"+
                    "</table>"+
                    "</div>";


    //document.writeln(fontNameSelect);
    var webEditorButtonHtml = " <img src='/jsp/kor/realtime/images/ico/icon_btn01_off.gif' id='bold_<%=dialogueID%>' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditor.toggleBold('<%=dialogueID%>');\"> "+
                         " <img src='../images/ico/icon_btn02_off.gif' id='italic_<%=dialogueID%>' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditor.toggleItalic('<%=dialogueID%>');\"> "+
                         " <img src='../images/ico/icon_btn03_off.gif' id='underline_<%=dialogueID%>' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditor.toggleUnderline('<%=dialogueID%>');\"> "+
                         " <img src='../images/ico/icon_btn04_off.gif' id='fontColor_<%=dialogueID%>' class='msgWdw_edit_icon' align='absmiddle' onclick=\"CtntEditor.toggleFontColor('<%=dialogueID%>');\"><div id='msgFontColor_<%=dialogueID%>'></div> ";
    var webEditorHtml = " <table height='25' width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='E7E7E7'><tr><td>"+ fontNameSelectHtml + fontSizeSelectHtml + webEditorButtonHtml +"</td></tr></table>"
    var winTextareaHtml ="<form name='msg_form_<%=dialogueID%>' method='post'>"+webEditorHtml+"<textarea name='msg_<%=dialogueID%>' class='msgWdw_textarea' id='msg_<%=dialogueID%>' onKeyUp=\"javascript:js_pop_sendmsg('<%=dialogueID%>', '<%=buddyID%>');\"></textarea></form>" + fontColorLayer;


    //var winTextareaHtml = "<form name='msg_form_<%=dialogueID%>' method='post'><textarea name='msg_<%=dialogueID%>' class='msgWdw_textarea_pop'  onKeyDown=\"javascript:js_pop_sendmsg('<%=dialogueID%>', '<%=buddyID%>');\"></textarea></form>";

    var p1 = new Ext.Panel({
        width: 400,
        height: 375,
        layout:'fit',
        collapsible: true,
        defaults:{autoScroll:true},
        margins:'3 0 3 3',
        cmargins:'3 3 3 3',
        split: true,
        region: 'center'
        ,html: drLayer
    });

    var action1 = new Ext.Action
    ({
        id:'action1',
        text: '초대하기',
        iconCls: 'blist',
        handler: function()
        {  
            inviteWindow.create('<%=dialogueID%>');
        }
    });

    var action2 = new Ext.Action
    ({
        id:'action2',
        text: '창 화면안으로',
        iconCls: 'blist',
        handler: function()
        {  
            switchDialogue();
        }
    });

    var action3 = new Ext.Action
    ({
        id:'action3',
        text: '저장하기',
        iconCls: 'blist',
        handler: function()
        {  
            opener.hidef.js_saveMsg('<%=dialogueID%>');
        }
    });     
    
    var panel = new Ext.Panel
    ({
        title: '웹메신저',
        width:400,
        height:500,
        bodyStyle: 'padding:1px;',     // lazy inline style
        collapsible: false,
        layout: 'border',
        renderTo: 'container',
        items : [p1,
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
                ,new Ext.Button(action2)  
                //,'-'
                //,new Ext.Button(action3)  
              ]   
                

     });
    
    load(); 
});


/* POPUP 창에서 서버에 대화 메세지를 보낸다.
//  value : dindex      - Index
//          userid      - 보내는사람 ID
//          username    - 보내는사람 Display Name
//          recvusers   - 받는사람들. ','로 구분
//          strfont     - 화면 Font
//          strTime     - 보내는 시각
//          msg         - 대화 메세지
*/
function js_pop_sendmsg(dialogueID, recvID)
{	
	
	var trnsMsg = '';
	if(event.keyCode == 13)
	{
		msg = $F('msg_'+dialogueID);
        var mlMsg_textarea = $('msg_'+dialogueID);
         
        // msg 가 없을때 
        if(msg.blank()) {
            return;   
        }


        var isBold      = (mlMsg_textarea.style.fontWeight == '700' ? 'true' : 'false');
        var isItalic    = (mlMsg_textarea.style.fontStyle == 'italic' ? 'true' : 'false');
        var isUnderline = (mlMsg_textarea.style.textDecoration == 'underline' ? 'true' : 'false');
        var fontName    =  $('fontName_'+dialogueID).value;
        var fontSize    =  $('fontSize_'+dialogueID).value;
        var fontColor   = (mlMsg_textarea.style.color == '' ? '#000000' : mlMsg_textarea.style.color);

        setFont = isBold + "," + isItalic + "," + isUnderline + "," + fontName + "," + fontSize + "," + fontColor;
        
        trnsMsg = opener.hidef.js_msgStyeTras(msg, isBold, isItalic, isUnderline, fontName, fontSize, fontColor);

        if(opener.hidef.curtIDHash.get(dialogueID) == "") {
            recvusers = recvID;
        } else {
            recvusers = opener.hidef.curtIDHash.get(dialogueID);
        }
	    opener.parent.$('mlMsg_window_cntnt_'+dialogueID).innerHTML = $('mlMsg_window_cntnt_'+dialogueID).innerHTML + "<b>"+opener.hidef.uaconfArr[1]+":</b><br/>"+trnsMsg;	
		opener.parent.$('mlMsg_window_cntnt_'+dialogueID).scrollTop = opener.parent.$('mlMsg_window_cntnt_'+dialogueID).scrollTop + 600;
        opener.hidef.DialogSend(dialogueID,opener.hidef.uaconfArr[3],opener.hidef.uaconfArr[1],setFont,recvusers, msg.stripTags().stripScripts());


		$('mlMsg_window_cntnt_'+dialogueID).innerHTML =$('mlMsg_window_cntnt_'+dialogueID).innerHTML + "<b>"+opener.hidef.uaconfArr[1]+":</b><br/>"+trnsMsg;		
		$('mlMsg_window_cntnt_'+dialogueID).scrollTop = $('mlMsg_window_cntnt_'+dialogueID).scrollTop + 500;
		mlMsg_textarea.value="";
		mlMsg_textarea.focus();
		
	}
}

function js_pop_receivemsg(dialogueID, szSendID, szSendName, szFont, szDate, szCont, szDisplayID)
{	
    var arrSzFont = szFont.split(",");
    msg = opener.hidef.js_msgStyeTras(szCont, arrSzFont[0], arrSzFont[1], arrSzFont[2], arrSzFont[3], arrSzFont[4], arrSzFont[5]);
	
    $('mlMsg_window_cntnt_'+dialogueID).innerHTML =$('mlMsg_window_cntnt_'+dialogueID).innerHTML + "<b>"+szSendName+":</b><br/>"+msg;		
	$('mlMsg_window_cntnt_'+dialogueID).scrollTop = $('mlMsg_window_cntnt_'+dialogueID).scrollTop + 600;

}

function js_pop_receiveAlertmsg(szIndex, szCont)
{	
	$('mlMsg_window_cntnt_'+szIndex).innerHTML = $('mlMsg_window_cntnt_'+szIndex).innerHTML + szCont;		
	$('mlMsg_window_cntnt_'+szIndex).scrollTop = $('mlMsg_window_cntnt_'+szIndex).scrollTop + 500;
}

function js_pop_receiveAlertmsgUpdate(szIndex, szCont, gubun)
{	
	$('mlMsg_window_cntnt_'+szIndex).innerHTML = $('mlMsg_window_cntnt_'+szIndex).innerHTML + szCont;		
	$('mlMsg_window_cntnt_'+szIndex).scrollTop = $('mlMsg_window_cntnt_'+szIndex).scrollTop + 500;

	if(gubun == '1') {
        $('msg_'+szIndex).style.backgroundColor='#C0C0C0';
	    $('msg_'+szIndex).disabled = true;
	} else {
        $('msg_'+szIndex).style.backgroundColor='#FFFFFF';
	    $('msg_'+szIndex).disabled = false;
	}
}

function switchDialogue() {
    opener.hidef.openPopDialHash.unset('<%=dialogueID%>');
    self.close();
}   


function closePopupDialogue() {
    
    if(self.screenTop > 9000) {

    }   
    
}

function js_curtUserDisplay(szIndex) {
    
    var curtUserList = "";
    var curtUserVal = opener.hidef.curtIDHash.get(szIndex) + "";

    var arrCurtUsers = curtUserVal.split(",");
    /*
    */
    if(arrCurtUsers.size() > 1) {
        var watcherHash = opener.hidef.js_getWatcherChatList();
    
        for(i = 0 ; i < arrCurtUsers.length ; i++) 
        {   
           var watcherHashVal = watcherHash.get(arrCurtUsers[i]); 
           curtUserList = curtUserList + watcherHashVal[1] + " (" + watcherHashVal[0] + ")" + "<br/>"     
        }
    
        $('mlMsg_window_crutUser_'+szIndex).innerHTML = "";
        $('mlMsg_window_crutUser_'+szIndex).style.display='block';
        $('mlMsg_window_crutUser_'+szIndex).innerHTML = "<a href=\"javascript:js_curtInviteUserShow('"+szIndex+"');\">대화 참여자 ("+ arrCurtUsers.size() +"명)</a>";

        var curtUserListNode = $('mlMsg_window_crutUser_'+szIndex);
    
        var newCurtItem = document.createElement("div");
        newCurtItem.className="msgWdw_crut_user_item";
        newCurtItem.setAttribute("id", 'mlMsg_window_crutUser_item_'+szIndex);  
      	curtUserListNode.appendChild(newCurtItem); 	  	
        $('mlMsg_window_crutUser_item_'+szIndex).innerHTML = curtUserList;

    } else {
        //$('mlMsg_window_crutUser_item_'+szIndex).innerHTML = "";
        //$('mlMsg_window_crutUser_'+szIndex).removeChild($('mlMsg_window_crutUser_item_'+szIndex));
        $('mlMsg_window_crutUser_'+szIndex).style.display='none';
        $('mlMsg_window_cntnt_'+szIndex).style.height='100%';
    }
}

function js_curtInviteUserShow(szIndex) {
    
    if($('mlMsg_window_crutUser_item_'+szIndex).style.display == "block") {
        $('mlMsg_window_crutUser_item_'+szIndex).style.display='none'; 
        $('mlMsg_window_cntnt_'+szIndex).style.height='100%';
    } else {
        $('mlMsg_window_crutUser_item_'+szIndex).style.display='block'; 
        $('mlMsg_window_cntnt_'+szIndex).style.height='75%';
        
    }
}

window.onload=function() {
   
}

window.onunload = function() {
        self.opener.hidef.openPopDialHash.unset('<%=dialogueID%>');
        //self.opener.hidef.js_switch_dialogue2('<%=dialogueID%>','block');
}

function load()
{
  $('mlMsg_window_cntnt_<%=dialogueID%>').innerHTML = opener.parent.$('mlMsg_window_cntnt_<%=dialogueID%>').innerHTML;
  js_curtUserDisplay('<%=dialogueID%>');
  //opener.js_closeDialog('<%=dialogueID%>');   
}

//dialogueViewport.create('<%=dialogueID%>',opener.hidef.uaconfArr[1],'<%=buddyID%>');


// Editor Actio 처리
var CtntEditor = {
    
    toggleBold: function(dialogueID) {
        
        var sendTextarea = $('msg_'+dialogueID);
        
        if(sendTextarea.style.fontWeight == '700') {
            $('bold_'+dialogueID).src = 'images/ico/icon_btn01_off.gif';
            sendTextarea.style.fontWeight = '400';
        } else {
            $('bold_'+dialogueID).src = '../images/ico/icon_btn01_over.gif';
            sendTextarea.style.fontWeight = '700';
        }
    },   
    
    toggleItalic: function(dialogueID) {
        
        var sendTextarea = $('msg_'+dialogueID);
        
        if(sendTextarea.style.fontStyle == 'italic') {

            $('italic_'+dialogueID).src = '../images/ico/icon_btn02_off.gif';
            sendTextarea.style.fontStyle = 'normal';
             
        } else {
            $('italic_'+dialogueID).src = '../images/ico/icon_btn02_over.gif';
            sendTextarea.style.fontStyle = 'italic';
            
        }
    },    

    toggleUnderline: function(dialogueID) {
        
        var sendTextarea = $('msg_'+dialogueID);
        
        if(sendTextarea.style.textDecoration == 'underline') {

            $('underline_'+dialogueID).src = '../images/ico/icon_btn03_off.gif';
            sendTextarea.style.textDecoration = 'none';

             
        } else {
            $('underline_'+dialogueID).src = '../images/ico/icon_btn03_over.gif';
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
            $('fontColor_'+dialogueID).src = '../images/ico/icon_btn04_off.gif';
            ftb.style.display= 'none';
               
        } else {
            $('fontColor_'+dialogueID).src = '../images/ico/icon_btn04_over.gif';
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
        $('fontColor_'+dialogueID).src = '../images/ico/icon_btn04_off.gif';
    }
}
</script> 

</head>
<body>
<div id="container">
</div>
</body>


<script>
//$('buddyName').innerHTML = "<%=buddyName%>";
//opener.dialogueWindow.create('', '', '', 'hide');
//
//alert($('mlMsg_window_cntnt_<%=dialogueID%>'));
//alert(opener.document.getElementById('xmlsocket'));
</script>
</html>
