/*
 * Ext JS Library 2.0.2
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
 

function js_totalMessageBox( mode )
{
	
    if( Ext.get('totalMessageWindow') == null ){
        var myid = hidef.user_id;
        //var myName = hidef.uaconfArr[1];
        var myidArr = myid.split( '@' );
      //  alert(mode + " : "+ 'A' + " : "+  myidArr[0] + " : "+ myidArr[1]);
        totalMessageBox.create(mode , 'A' , myidArr[0] ,myidArr[1])  
       
    }
}

var totalMessageBox = {
  
  create: function( mode , snd_rcv_flag , user_id ,iddomain ) {
    
    var totalMessageBox_mode = mode;//A:전체  , B:기타
    var totalMessageBox_msg_flag = 'note'; //note:쪽지 , dialog:대화
    var totalMessageBox_snd_rcv_flag = snd_rcv_flag; //A, S(보낸메세지), R(받은메세지)
    var totalMessageBox_user_id = user_id;
    var totalMessageBox_domain = iddomain;
    var totalMessageBox_start_dt = setTotalMessageBoxDateDefault(new Date('1/1/2008'), 'start');
    var totalMessageBox_end_dt = setTotalMessageBoxDateDefault(new Date('12/31/9999'), 'end');
    var totalMessageBox_keyword = '';
    
    var noteMenuData = [
        ['쪽지함','전체쪽지함','note','A'],
        ['쪽지함','받은쪽지함','note','R'],
        ['쪽지함','보낸쪽지함','note','S']
    ];
    
    var messageMenuData = [
        
        ['대화함','전체대화함','dialog','A']
    ];

    var ds = new Ext.data.Store({
        proxy: new Ext.data.HttpProxy({
            //url: 'http://210.116.116.142/jsp/kor/realtime_mysql/note_execute.jsp'
            url: 'http://demo.kebi.com/jsp/kor/realtime_mysql/note_execute.jsp'
        }),
        reader: new Ext.data.JsonReader({
            root: 'topics',
            totalProperty: 'totalCount',
            idProperty:'note_idx'
            //id: 'note_idx'
        }, [
            {name: 'flag', mapping: 'flag'},
            {name: 'note_recv_idx', mapping: 'note_recv_idx'},
            {name: 'note_idx', mapping: 'note_idx' ,type: 'int'},
            {name: 'recv_users_id', mapping: 'recv_users_id'},
            {name: 'recv_domain', mapping: 'recv_domain'},
            {name: 'recv_user_nm', mapping: 'recv_user_nm'},
            {name: 'recv_yn', mapping: 'recv_yn'},
            {name: 'recv_dt', mapping: 'recv_dt'},
            {name: 'snd_users_id', mapping: 'snd_users_id'},
            {name: 'snd_domain', mapping: 'snd_domain'},
            {name: 'snd_user_nm', mapping: 'snd_user_nm'},
            {name: 'msg_type', mapping: 'msg_type'},
            {name: 'send_dt', mapping: 'send_dt'},
            {name: 'note_del_dt', mapping: 'note_del_dt'},
            {name: 'note_contents', mapping: 'note_contents'},
            {name: 'file_yn', mapping: 'file_yn'},
            {name: 'file_count', mapping: 'file_count'},
            {name: 'file_info', mapping: 'file_info'}
        ]),

        baseParams: {limit:15, mode: totalMessageBox_mode, users_id: totalMessageBox_user_id, domain: totalMessageBox_domain, start_dt: totalMessageBox_start_dt, end_dt: totalMessageBox_end_dt, msg_flag:totalMessageBox_msg_flag, snd_rcv_flag: totalMessageBox_snd_rcv_flag, keyword:totalMessageBox_keyword  }
        //baseParams: {limit:15, users_id: totalMessageBox_user_id, domain: totalMessageBox_domain}
    });
           
   var totalMessageBox_searchField = new Ext.form.TextField({
                            id: 'totalMessageBox_search',
                            width:150
                        });
   var totalMessageBox_start_DateField = new Ext.form.DateField({
                                    name: 'startDay',
                                    id: 'startDay',
                                    width:80,
                                    format:'Ymd',
                                    allowBlank:true
                        });
   var totalMessageBox_endt_DateField = new Ext.form.DateField({
                                    name: 'endDay',
                                    width:80,
                                    format:'Ymd',
                                    allowBlank:true
                         });                
   var noteGridPanel =  new Ext.grid.GridPanel({
              autoScroll:true,
              store: ds,
              region: 'center',
              columns: [
                 {id:'flag',header:"구분", width:50, 
                    renderer: function(v)
                    {
                        if( v == 'S' )
                            return '송신';
                        else if( v == 'R' )
                            return '수신';
                        else
                            return '대화';    
                    }, 
                    dataIndex: 'flag'},
                 {id:'recv_user_nm',header:"수신", width:80,  dataIndex: 'recv_user_nm'},
                 {id:'recv_dt',header:"수신시각", width:120, dataIndex: 'recv_dt'},
                 {id:'snd_user_nm',header:"송신", width:80,  dataIndex: 'snd_user_nm'},
                 {id:'send_dt',header:"송신시각", width:120, dataIndex: 'send_dt'},
                 {id:'file_yn',header:"파일여부", width:60, dataIndex: 'file_yn'},
                 {id:'note_recv_idx', hidden:true, header:"메모수신번호", width:60, dataIndex: 'note_recv_idx'},
                 {id:'note_idx', hidden:true, header:"메모인덱스", width:60, dataIndex: 'note_idx'},
                 {id:'recv_users_id', hidden:true, header:"수신사용자ID", width:60, dataIndex: 'recv_users_id'},
                 {id:'recv_domain', hidden:true, header:"수신도메인", width:60, dataIndex: 'recv_domain'},
                 {id:'recv_yn', hidden:true, header:"확인여부", width:60, dataIndex: 'recv_yn'},
                 {id:'snd_users_id', hidden:true, header:"송신유저ID", width:60, dataIndex: 'snd_users_id'},
                 {id:'snd_domain', hidden:true, header:"송신도메인", width:60, dataIndex: 'snd_domain'},
                 {id:'msg_type', hidden:true, header:"메시지타입", width:60, dataIndex: 'msg_type'},
                 {id:'note_contents', hidden:true, header:"내용", width:60, dataIndex: 'note_contents'},
                 {id:'file_count', hidden:true, header:"파일갯수", width:60, dataIndex: 'file_count'},
                 {id:'file_info', hidden:true, header:"파일정보", width:60, dataIndex: 'file_info'}
                 ],
                 stripeRows: true,
               sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
               tbar: [
                        '검색: ',
                        ' ',
                        totalMessageBox_searchField,
                        ' ',
                        new Ext.Action
                        ({
                            id:'totMsgAction',
                            text: '검색',
                            iconCls: 'messageBox-search',
                            handler: function()
                            {  
                                js_totalMessageBox_searchClick(ds,
                                                                totalMessageBox_searchField.getValue(),
                                                                setTotalMessageBoxDateDefault(totalMessageBox_start_DateField.getValue(), 'start') ,
                                                                setTotalMessageBoxDateDefault(totalMessageBox_endt_DateField.getValue(), 'end') )
                                
                            }
                        }),
                        ' ',
                        '시작일: ',
                        totalMessageBox_start_DateField
                        ,' ','종료일: ',
                        totalMessageBox_endt_DateField      
                    ],
                bbar: new Ext.PagingToolbar({
                        store: ds,
                        pageSize: 15,
                        displayInfo: true,
                        displayMsg: '현재내역 {0} - {1} of {2}',
                        emptyMsg: "조회된 내역이 없습니다."
                    })    
    });
    
    noteGridPanel.on('dblclick', noteGridClick.createCallback( noteGridPanel ) );
    
    var noteMenuRoot;
    var messageMenuRoot;
    var noteMenuTree;
    var messageMenuTree;
    
// Panel for the west
    var nav = new Ext.Panel({
        title: '통합메시지함',
        region: 'west',
        split: true,
        width: 150,
        collapsible: true,
        layout:'accordion',
        margins:'3 0 3 3',
        cmargins:'3 3 3 3',
        ctCls:'p_kebiMessage',
        layoutConfig:{
                    animate:true
                },
        items: [
                    {
                        title:'쪽지함',
                        border:false,
                        iconCls: 'messageBox-search',
                        items: noteMenuTree = new Ext.tree.TreePanel
                                 ({
                                     loader: new Ext.tree.TreeLoader(),
                                     rootVisible:false,
                                     autoScroll:true,
                                     animate:true,
                                     enableDD:true,
                                     containerScroll: true, 
                                     dragConfig: {containerScroll :true},
                                     border:false,
                                     root : noteMenuRoot = new Ext.tree.TreeNode
                                          ({
                                            text:'note',
                                            id:'note',
                                            allowDelete:false,
                                            allowDrag:false,
                                            allowDrop:false, 
                                            draggable:false
                                         })
                                })//end panel
                    },{
                        title:'대화함',
                        border:false,
                        iconCls: 'messageBox-search',
                        items: messageMenuTree = new Ext.tree.TreePanel
                                 ({
                                     loader: new Ext.tree.TreeLoader(),
                                     rootVisible:false,
                                     autoScroll:true,
                                     animate:true,
                                     enableDD:true,
                                     containerScroll: true, 
                                     dragConfig: {containerScroll :true},
                                     border:false,
                                     root : messageMenuRoot = new Ext.tree.TreeNode
                                          ({
                                            text:'dialog',
                                            id:'dialog',
                                            allowDelete:false,
                                            allowDrag:false,
                                            allowDrop:false, 
                                            draggable:false
                                         })
                                })//end panel
                    }
                ]
    });  
    noteMenuTree.on('dblclick', totalMessageBox_MenuTreeClick.createCallback( noteMenuTree , ds ,totalMessageBox_msg_flag ,totalMessageBox_snd_rcv_flag,totalMessageBox_searchField,totalMessageBox_start_DateField,totalMessageBox_endt_DateField));
    messageMenuTree.on('dblclick', totalMessageBox_MenuTreeClick.createCallback( messageMenuTree , ds ,totalMessageBox_msg_flag ,totalMessageBox_snd_rcv_flag,totalMessageBox_searchField,totalMessageBox_start_DateField,totalMessageBox_endt_DateField));

    win = new Ext.Window({
                  id:'totalMessageWindow',
                  layout:'border',
                  width:690,
                  height:420,
                  closeAction:'close',
                  autoScroll:false,
                  resizable:false,
                  plain: true,
                  items: [nav,noteGridPanel] 
    });
    
    
    for(i = 0; i<noteMenuData.length; i++)
    {
         var child = noteMenuRoot.childNodes;

         var nodes = new Ext.tree.TreeNode
                     ({
                        id:  noteMenuData[i][1]+'^'+noteMenuData[i][2]+'^'+noteMenuData[i][3], 
                        text: noteMenuData[i][1],
                        iconCls: 'user-kid',
                        leaf:true,
                        allowDelete:true
                     })         
         noteMenuTree.getRootNode().appendChild(nodes);
    }
    for(i = 0; i<messageMenuData.length; i++)
    {
         var child = messageMenuRoot.childNodes;

         var nodes = new Ext.tree.TreeNode
                     ({
                        id:  messageMenuData[i][1]+'^'+messageMenuData[i][2]+'^'+messageMenuData[i][3], 
                        text: messageMenuData[i][1], 
                        iconCls: 'user-kid',
                        leaf:true,
                        allowDelete:true
                     })         
         messageMenuTree.getRootNode().appendChild(nodes);
    }

	
    ds.load({params:{start:0, limit:15, mode: totalMessageBox_mode, users_id: totalMessageBox_user_id, domain: totalMessageBox_domain, start_dt: totalMessageBox_start_dt, end_dt: totalMessageBox_end_dt, msg_flag:totalMessageBox_msg_flag, snd_rcv_flag: totalMessageBox_snd_rcv_flag, keyword:totalMessageBox_keyword  }});
    //ds.load({params:{start:0, limit:15, mode: 'A' }});
    
    win.show();
    
    }
}

var messageDetailForm;
var messageDetailwindow = {
  
  create: function(noteGridPanel, record,snd_users_id,snd_user_nm,send_dt,file_count,file_yn,file_info,note_contents) {
    
    messageDetailForm = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        labelWidth: 55,
        layout:'absolute',
        url:'NoteFileDownLoadSvl',
        defaultType: 'textfield',
        
        items: [{ 
            x: 0,y: 5,xtype:'label',text: '전송구분:'
        },{
            x: 60,y: 0,name: 'flag',value: '',readOnly:true,width: 150
        },{ 
            x: 215,y: 5,xtype:'label',text: '확인여부:'
        },{
            x: 275,y: 0,name: 'recv_yn',value: '',readOnly:true,anchor: '100%'
        },{ 
            x: 0,y: 35,xtype:'label',text: '받은사람:'
        },{
            x: 60,y: 30,name: 'recv_user_nm',value: '',readOnly:true,width: 150
        },{ 
            x: 215,y: 35,xtype:'label',text: '받은시각:'
        },{
            x: 275,y: 30,name: 'recv_dt',value: '',readOnly:true,anchor: '100%'
        },{ 
            x: 0,y: 65,xtype:'label',text: '보낸사람:'
        },{
            x: 60,y: 60,name: 'snd_user_nm',value: '',readOnly:true,width: 150
        },{ 
            x: 215,y: 65,xtype:'label',text: '보낸시각:'
        },{
            x: 275,y: 60,name: 'send_dt',value: '',readOnly:true,anchor: '100%'
        },{ 
            x: 0,y: 90,
            xtype:'panel',
            id:'note_contents',
            height:200,
            autoScroll:true,
            cmargins:'3 3 3 3',
            anchor: '100% 100%',
            html: '<div id="div_note_contents"></div>'
        }]
    });

    var win = new Ext.Window({
        title: '메시지보기',
        id: 'messageViewWin',
        width: 600,
        height:400,
        minWidth: 300,
        minHeight: 200,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        collapsible: true,
        items: messageDetailForm,  
        buttons: [{
            text: '이전',
            handler: function(){
                if( record.selectPrevious() )
                {
                    noteGridClick(noteGridPanel);
                }
            }
        },{
            text: '다음',
            handler: function(){
                try{
                    if( record.selectNext(true) )
                    {
                        noteGridClick(noteGridPanel);
                    }
                }catch(e){
                    record.selectPrevious();
                }
            }
        }]
    });
    
    win.show();
    }
}

function noteGridClick( noteGridPanel )
{
    var record = noteGridPanel.getSelectionModel();
    
    var flag          = record.getSelected().get( 'flag');
    var note_recv_idx = record.getSelected().get( 'note_recv_idx');
    var note_idx      = record.getSelected().get( 'note_idx');
    var recv_users_id = record.getSelected().get( 'recv_users_id');
    var recv_domain   = record.getSelected().get( 'recv_domain');
    var recv_user_nm  = record.getSelected().get( 'recv_user_nm');
    var recv_yn       = record.getSelected().get( 'recv_yn');
    var recv_dt       = record.getSelected().get( 'recv_dt');
    var snd_users_id  = record.getSelected().get( 'snd_users_id');
    var snd_domain    = record.getSelected().get( 'snd_domain');
    var snd_user_nm   = record.getSelected().get( 'snd_user_nm');
    var msg_type      = record.getSelected().get( 'msg_type');
    var send_dt       = record.getSelected().get( 'send_dt');
    var note_del_dt   = record.getSelected().get( 'note_del_dt');
    var note_contents = record.getSelected().get( 'note_contents');
    var file_yn       = record.getSelected().get( 'file_yn');
    var file_count    = record.getSelected().get( 'file_count');
    var file_info     = record.getSelected().get( 'file_info');
    
    
    if( Ext.get('messageViewWin') == null ){
        messageDetailwindow.create(noteGridPanel, record);
        setNoteDetailData(flag, recv_yn , recv_user_nm , recv_dt, snd_user_nm , send_dt , note_contents , file_yn,file_count, file_info);
    }else{
        setNoteDetailData(flag, recv_yn , recv_user_nm , recv_dt, snd_user_nm , send_dt , note_contents , file_yn,file_count, file_info);
    }    
}

function setNoteDetailData(flag, recv_yn , recv_user_nm , recv_dt, snd_user_nm , send_dt , note_contents , file_yn, file_count, file_info)
{
    var flagNm = '';
    if( flag == 'S' )
        flagNm = '송신';
    else if ( flag == 'R' )
        flagNm = '수신';
    else
        flagNm = '대화';        
     
    var valArr = [{id:'flag', value:flagNm},
                  {id:'recv_yn', value:recv_yn},
                  {id:'recv_user_nm', value:recv_user_nm},
                  {id:'recv_dt', value:recv_dt},
                  {id:'snd_user_nm', value:snd_user_nm},
                  {id:'send_dt', value:send_dt},
                  {id:'note_contents', value:note_contents}];
    messageDetailForm.getForm().setValues(valArr);
    document.getElementById('div_note_contents').innerHTML = setNoteDetailFileName(file_info , file_count) + note_contents;
    
}

function setNoteDetailFileName(fileInfo , fileCount)
{
    var fileHtml = '';
    if( fileInfo.length > 0 && fileCount > 0)
    {
        var fileArr = fileInfo.split('^');
        for( i = 0 ; i < fileCount ; i++)
        {
            var fileNmSize = '';
            var fileOrgNm = '';
            var filewebpath = '';
            var fileSize = '';
            
            fileOrgNm = fileArr[i].split(',')[2];
            filewebpath = escape(fileArr[i].split(',')[3]);
            fileSize = fileArr[i].split(',')[5];
            fileNmSize = fileOrgNm+' ['+fileSize+' byte]';
            
           
            fileHtml += '<img src="/jsp/kor/realtime_mysql/images/default/tree/leaf.gif" absmiddle>&nbsp;<a href="http://demo.kebi.com/realtime_mysql/notefiledwn?file1='+filewebpath+'&file2='+ fileOrgNm + '" target="hidef">'+fileNmSize+'</a><br>'   ;
        }
        fileHtml = fileHtml + '<br><br>';
    }
    return fileHtml;
}

function setTotalMessageBoxDateDefault( dt ,div )
{
    var result;
    if( dt != null && dt != '' )
        result = dt.format('Ymd');
        
    if( result == null || result == '' || result.length != 8 )
    {
        if( div == 'start' )
            result = '20080101';
        else
            result = '99991231';
    }
    return result;
}

function totalMessageBox_MenuTreeClick( tree , ds ,totalMessageBox_msg_flag ,totalMessageBox_snd_rcv_flag, keywordField,startDt,endDt  )
{
	 var treeArr = tree.getSelectionModel().getSelectedNode().id.split('^');
    totalMessageBox_msg_flag = treeArr[1];
    totalMessageBox_snd_rcv_flag = treeArr[2];
    
    
    keywordField.setValue('');
    startDt.setValue('');
    endDt.setValue('');
    
    var o = {start: 0};
    ds.baseParams = ds.baseParams || {};
    ds.baseParams['mode'] = 'A';
    ds.baseParams['msg_flag'] = totalMessageBox_msg_flag;
    ds.baseParams['snd_rcv_flag'] = totalMessageBox_snd_rcv_flag;
    ds.baseParams['keyword'] = '';
    ds.baseParams['start_dt'] = setTotalMessageBoxDateDefault(new Date('1/1/2008'), 'start');
    ds.baseParams['end_dt'] = setTotalMessageBoxDateDefault(new Date('12/31/9999'), 'end');
    ds.reload({params:o});
    
}

function js_totalMessageBox_searchClick( ds , keywordField , startDt , endDt )
{
	alert(keywordField);
    var o = {start: 0};
    ds.baseParams = ds.baseParams || {};
    ds.baseParams['keyword'] = keywordField;
    ds.baseParams['start_dt'] = startDt;
    ds.baseParams['end_dt'] = endDt;
    ds.reload({params:o});
    
}