var panel;

var tree;
var root;
var buddyTreeEditor;
var action, _action;
var action1;
var action2;
var dispMethodAction;

//메뉴클릭 좌표
var menuX;
var menuY;

var wins;
var store;
var combo;
var comboGroup;
var field;


var preAction;
var nextAction;


//버디검색관련
var schType='';
var keyword='';
var startNum = 1;
var isNext ='0';
var searchGrid;
var comboGroupValue;
var comboGroupStore;
var progress;
var buddySearchMenu;

//대화명표시 상태값
var itemClickDisp ="name";

Ext.onReady(function init(){
//function init(){
	
	Ext.QuickTips.init();


    store = new Ext.data.SimpleStore({
        fields: [
           {name: 'name'},
           {name: 'userId' },
           {name: 'gubun' },
           {name: 'dept'},
           {name: 'team'},
           {name: 'position'},
           {name: 'enter', type: 'date', dateFormat: 'Ymd'},
           {name: 'mobile'}
        ]
    });

    progress = new Ext.ProgressBar({
      id:'pbar',
      width:200,
      waitConfig: {interval:200},      
      renderTo: 'progress-div'
    });


    // The action
    action = new Ext.Action
    ({
        id:'action',
        tooltip:'내상태 변경',
        text: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
        minwidth:150,
        width:200,
        iconCls: 'buddyOff',
        handler: onClick  
    });

    action1 = new Ext.Action
    ({
        id:'action1',
        text: ' 0',
        iconCls: 'memoStatusIcon',
        tooltip:'쪽지 읽기',
        handler: function()
        {  
            if (action1.getText !="0")
            {
            
               //신규쪽지
               js_totalMessageBox('B');
            }
            else
            {   
            
               //통합메시지함
               js_totalMessageBox('A');
            }
            action1.setText('0');
        }
    });

   dispMethodAction = new Ext.Action
    ({
        id:'dispMethodAction',
        iconCls: 'dispMethodIcon',
        tooltip:'보기방식',
        handler: onClickdispMethod
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


    preAction = new Ext.Action
    ({
         id:'preAction',
         text: '이전',
         handler: function()
         {
            preSearch();
         }
    });

    nextAction = new Ext.Action
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
        text: '상대추가',
        handler: function()
        {  
         buddyAddWindow();
        }
    });

    action2 = new Ext.Action
    ({
         id:'buddySearch',
         text: '상대추가',
         //iconCls: 'blist',
         handler: function()
         {  
            if(!wins)
            {
                 var comboValue = [
                     ['이름', 'user_nm'],
                     ['아이디', 'users_id'] ];
            
                var comboStore = new Ext.data.SimpleStore({
                    fields: ['val', 'key'],
                    data : comboValue 
                    });

               comboGroupValue = makeGroupCombo();


               comboGroupStore = new Ext.data.SimpleStore({
                 fields: ['val', 'key'],
                 data : comboGroupValue 
                 });

                combo = new Ext.form.ComboBox({
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

               comboGroup = new Ext.form.ComboBox({
                    store: comboGroupStore,
                    fieldLabel:'추가할 그룹선택',
                    displayField:'val',
                    valueField :'key',
                    mode: 'local',
                    triggerAction: 'all',
                    typeAhead: true,
                    editable:false,
                    selectOnFocus:true,
                    value: comboGroupStore.getAt(0).get('key'),
                    width:150
                    });


                
                field = new Ext.form.TextField({
                      fieldLabel:'조건',
                      id:'schType',
                      name: 'field',
                      width:100,
                      maxLength:20
                     });
                     
               wins = new Ext.Window({
                  //el:'hello-win',
                  title:'상대검색 및 추가',
                  layout:'fit',
                  width:750,
                  height:350,
                  closeAction:'close',
                  autoScroll:true,
                  resizable:false,
                  plain: true,
                  tbar: [combo
                         ,'-' 
                         ,field
                         ,'-'
                         ,searchAction
                         ,'-' 
                         ,preAction
                         ,'-' 
                         ,nextAction
                        ],
   
                  bbar: [
                           '추가할 그룹선택'
                           ,'-'
                           ,comboGroup
                           ,'-'
                           ,addAction
                        ],
                   
                   items:   searchGrid = new Ext.grid.GridPanel({
                              store: store,
                              columns: [
                                 {id:'name',header:"이름", width:80,  dataIndex: 'name'},
                                 {id:'userId',header:"아이디", width:160,  dataIndex: 'userId'},
                                 {id:'gubun',header:"구분", width:70,  dataIndex: 'gubun'},
                                 {id:'dept',header:"부서명", width:80,  dataIndex: 'dept'},
                                 {id:'team',header:"팀명", width:80,  dataIndex: 'team'},
                                 {id:'position',header:"직위", width:100,  dataIndex: 'position'},
                                 {id:'enter',header:"입사일", width:80,  renderer: Ext.util.Format.dateRenderer('Y-m-d'), dataIndex: 'enter'},
                                 {id:'mobile',header:"핸드폰", width:100,  dataIndex: 'mobile'}
                                 ],
                                 stripeRows: true,
                               sm: new Ext.grid.RowSelectionModel({singleSelect:true}),
                              //frame:true,
                              height:250,
                              width:800
                              })
               });
           }
           preAction.setDisabled(true);
           nextAction.setDisabled(true);
           wins.on('close', afterClose);
           field.on("specialkey", specialKeysOn, this);

           searchGrid.on('rowcontextmenu', onContextMenuGrid, this);
           searchGrid.on('dblclick', dodbClickGrid);

           store.removeAll();
           wins.show(this);
         }
     });
 
    _action =    new Ext.Button(action);
    panel = new Ext.Panel
    ({
        //title: '웹메신저',
        width:191,
        height:200,
        collapsible: true,
        autoScroll:true,
        bodyStyle: 'padding:2px;',     // lazy inline style
        ctCls:'t_kebiMessage',
        iconCls:'buddyTitle',
        tbar: [
                   _action
                   ,'->'
                   ,new Ext.Button(action1)
                   ,'-'
                   ,new Ext.Button(dispMethodAction)
               ],

        items: [
                 tree = new Ext.tree.TreePanel
                 ({
                     loader: new Ext.tree.TreeLoader(),
                     ctCls:'t_kebiMessage',
                     iconCls:'buddyTitle',
                     rootVisible:false,
                     lines:false, 
                     useArrows:false,
                     autoScroll:true,
                     animate:true,
                     containerScroll: true, 
                     dragConfig: {containerScroll :true},
                     border:false,
//                   tbar: [_action,'->',new Ext.Button(action1),'-',new Ext.Button(dispMethodAction)], 
//		             bbar: [new Ext.Button(action2)],
                     root : root = new Ext.tree.TreeNode
                      ({
                        text:'Online',
                        id:'root',
                        allowDelete:false,
                        allowDrag:false,
                        allowDrop:false, 
                        draggable:false
                        //leaf:false
                     })
                  })//end panel
               ],
        bbar: [new Ext.Button(action2)]
         });

		
		/*alert(parent.document.getElementById('ssss'))*/
         
    	
         buddyTreeEditor = new Ext.tree.TreeEditor(tree, null); 

         Ext.apply(tree, {ignoreNoChange:true,	
                         completeOnEnter:true,
                         cancelOnEsc:true,
                         constrain:true,
                         allowBlank:false
                    });

         buddyTreeEditor.on('complete', buddyTreeValueChcek);
         buddyTreeEditor.on('beforestartedit', buddyTreeEditYn);
         buddyTreeEditor.on('startedit', buddyTreeEditYn);
       
        
    	mboxnWinM = new Ext.Window({
		id :'massanger_win',
		title:'웹메신저',
		autoScroll:false,
		colsable:true,
		border:false,
		width:200,
		height:230,
		bodyStyle:'background:white',
		autoDestroy :true,
		// items :tree,
		items :panel,
		pageX:10,
		pageY:430
		});
		mboxnWinM.show();	
        
		//tree.setDisabled(true);
         dispMethodAction.setDisabled(true);
         action.setDisabled(true);
         action1.setDisabled(true);
         action2.setDisabled(true);
         tree.on('contextmenu', onContextMenu, this);
         tree.on('dblclick', dodbClick);
         tree.hide();
         progress.wait();
    

});
//};


//complete : ( Editor this, Mixed value, Mixed startValue ) 
function buddyTreeValueChcek(editor, groupNm, before)
{
   tree.resumeEvents();


   //alert("buddyTreeEditorFlag:"+ buddyTreeEditorFlag+ "|groupNm:"+ groupNm +"|before:"+ before);
 	if ( groupNm == '')
	{
		alert("그룹명을 입력해 주세요");		

      var n = tree.getSelectionModel().getSelectedNode(); 
      if (n !=null)
      {            
         n.setText(before);
      }         
		return false;
	}
   else
   {      
 
      var n = tree.getSelectionModel().getSelectedNode();

      if (n !=null)
      {

         var child = root.childNodes;
         var groupId = n.attributes.id;
         var len = child.length;
         var temp;
         var beforeVal = before.split("(");
         for (var i=0; i<len; i++)
         {
            temp = child[i].attributes.text.split("(");

            //alert(i+"before:"+ "|temp:"+ temp[0]+ "|groupNm:"+ groupNm+"|");   
            if (groupId !=child[i].attributes.id)
            {
               if(temp[0] == groupNm)      
               {
                  n.setText(before);
                  alert("중복된 그룹명 입니다.");
                  //editor.setValue(before);
                  return false;
                  break;
               }
            }
            else
            {                  
               if(temp[0] == beforeVal[0])      
               {
                  //alert("중복된 그룹명 입니다.");
                  n.setText(before);
                  //editor.setValue(before);
                  return false;
                  break;
               }                
            }

            var   gArray = new Array(3);
                  gArray[0]= groupId;
                  gArray[1]= groupNm;
                  gArray[2]= "Y";

            hidef.groupMap.put(groupId, gArray);
         }

   	   var strSendData = groupId + hidef.chField_Tab + groupNm;
         //n.setText(groupNm+"("+temp[1]);
   	   editor.setValue(groupNm+"("+temp[1]);
   	   hidef.AppleWorkRequest("30003103", strSendData);


         treeBuddyStatusInfo();
      }
   }
}   

//Editor this, Ext.Element boundEl, Mixed value 
function buddyTreeEditYn(el, before)
{
      var n = tree.getSelectionModel().getSelectedNode();

      if (n.attributes.allowDelete == false)
      {
         buddyTreeEditor.cancelEdit();
         alert("변경이 불가능한 그룹 입니다.");
         return false;
      } 
      
      var temp = before.split("(");
      
      //buddyTreeEditor.startEdit(el, temp[0]);
      //tree.setDisabled(true);
      tree.suspendEvents();
      buddyTreeEditor.setValue(temp[0]);
} 
  
function buddyBlockYn()
{
   var n = tree.getSelectionModel().getSelectedNode();

   if(n !=null )
   {
         var auth_type = "1";

         var buddy_id = n.attributes.id.split("|");
         buddy_id = buddy_id[0];

         var arr = hidef.buddyMap.get(n.attributes.id);
         var buddy_idx = arr[0];
         var owner_id= hidef.user_id;
         var status = arr[6];
         var auth = arr[10];


         if  ( auth == "-5" )//차단이면 해제
         {
            n.getUI().getIconEl().className = 'x-tree-node-icon ' + getStatusImage(status);
            auth_type = "1";
         }
         else
         {
            n.getUI().getIconEl().className = 'x-tree-node-icon ' + getStatusImage("100");
            auth_type = "6";
         }
         hidef.authModifyReq(owner_id, buddy_id, buddy_idx, auth_type);
         //hidef.WatcherListReq(hidef.user_id, '3');
   }      
   
}   



function updateBuddyStatusAll(buddyId, code)
{	
   var child = root.childNodes;
   var len = child.length;
   var n;
   for (var i=0; i<len; i++)
   {
      n = findChildRecursively(child[i], buddyId +"|" +child[i].attributes.id);

      if (n !=null)
      {

         var arr = hidef.buddyMap.get(buddyId +"|" +child[i].attributes.id);
         //alert(arr);
        
         var auth_type = arr[10];

         //승인만 update!!
         if (auth_type == "3")
         {
            //n.getUI().getIconEl().src = getStatusImageSrc(code);
            n.getUI().getIconEl().className = 'x-tree-node-icon ' + getStatusImage(code);

/*
               var iconEl = n.getUI().rendered ? Ext.get(n.getUI().getIconEl()) : null;

               alert("iconEl:"+ iconEl);

               if (iconEl) {
               	iconEl.removeClass("buddyOff");
               	iconEl.addClass("buddyOn");
               }
*/
               
            arr[6] = code;            
            hidef.buddyMap.put(buddyId +"|" +child[i].attributes.id, arr);
            hidef.watcherMap.put(buddyId, code);
         }
      }
   }

   treeBuddyStatusInfo();
}

function updateBuddyStatusOne(buddyListArr)
{
   var group = findNode(buddyListArr[5]);//groupIdx
   var n = findChildRecursively(group, buddyListArr[2]+ "|" + buddyListArr[5]);
   var auth_type = buddyListArr[10];
   var status = buddyListArr[6];
   var watchFlag = "-1";

   if (n !=null)
   {
         if (auth_type =="3")
         {
            n.getUI().getIconEl().className = 'x-tree-node-icon ' + getStatusImage(status);
            watchFlag = status;
         }

         else if  (auth_type =="-5")
         {
            n.getUI().getIconEl().className = 'x-tree-node-icon ' + getStatusImage("100");
         }
         else if  (auth_type =="-6")//상대방이 차단Relay
         {
            n.getUI().getIconEl().className = 'x-tree-node-icon ' + getStatusImage("-1");
         }

         else
         {
            n.getUI().getIconEl().className = 'x-tree-node-icon ' + getStatusImage("-1");
         }

         var arr = hidef.buddyMap.get(buddyListArr[2]+ "|" + buddyListArr[5]);
         arr[6] = status;
         arr[10]= auth_type;
         hidef.buddyMap.put(buddyListArr[2]+ "|" + buddyListArr[5], arr);
         hidef.watcherMap.put(buddyListArr[2], watchFlag);
   }

   treeBuddyStatusInfo();
}   

//친구추가 내자신 목록만들기
function defaultBuddyAdd(buddyListArr)
{
   var group = findNode(buddyListArr[5]);//groupIdx
   var node = findChildRecursively(group, buddyListArr[2]+"|"+ buddyListArr[5]);

   if (node == null) //추가된 버디가 없으면
   {
      var status;
      
      if (buddyListArr[10] =='3') //승인 또는 승인수신
         status = buddyListArr[6];
      else if (buddyListArr[10] =='-5') //차단상태이면
         status ='100';      
      else //if (buddyListArr[10] !='3') //승인상태가 아니면
         status ='-1';
/*   
		var listArray  = new Array(17);
		listArray[0] = Field_arr[1]; // 버디Index
		var id_domain = Field_arr[2].split('@');

		listArray[1] = id_domain[0]; // 버디ID
		listArray[2] = id_domain[1]; // 버디DOMAIN

		listArray[3] = Field_arr[3]; // 버디이름
		listArray[4] = Field_arr[4]; // 버디대화명
		listArray[5] = Field_arr[5]; // 버디그룹인덱스
		listArray[6] = Field_arr[6]; // 버디상태값
		listArray[7] = Field_arr[2]; //버디아이디@도메인
		listArray[8] = Field_arr[8]; //버디로그인서버IP
		listArray[9] = Field_arr[9]; // 버디로그인서버PORT
*/
			var _id_domain = buddyListArr[2].split('@');

   
      var _dispName ="";
      if (itemClickDisp =="dispName")
         _dispName = buddyListArr[4];
      else if (itemClickDisp =="userId")
         _dispName =  _id_domain[0];
      else if (itemClickDisp =="nameUserId")
         _dispName = buddyListArr[3]+"("+ _id_domain[0] +")";
      else if (itemClickDisp =="nameDispName")
         _dispName = buddyListArr[3]+"("+buddyListArr[4] +")";
      else if (itemClickDisp =="userIdDispName")
         _dispName =  _id_domain[0]+"("+buddyListArr[4] +")";
      else
         _dispName = buddyListArr[3];//이름
   
      var nodes = new Ext.tree.TreeNode
                  ({
                     id:  buddyListArr[2]+"|" + buddyListArr[5], //id@domain|groupIdx
                     text: _dispName, //dispName
                     //text: buddyListArr[4], //dispName
                     iconCls: getStatusImage(status), //status
                     leaf:true,
                     allowDelete:true
                  })
      //alert("defaultBuddyAdd:" + buddyListArr[2] + "||대화명:" + buddyListArr[4] + "||상태:" + buddyListArr[6]+ "||인증상태:" + buddyListArr[10]);

      group.appendChild(nodes);
      group.expand();
      //최초추가시 맵 put
      buddyMapInfoPut(buddyListArr);
   }

   else  
   {
      //OffLine시 승인창이 왔을때는 노드가 있으믁로 status만 update!         
      updateBuddyStatusOne(buddyListArr);
   }
   


}


//친구추가 내자신 목록만들기
function defaultBuddyAddFromMap(buddyListArr)
{
   var group = findNode(buddyListArr[5]);//groupIdx
   var node = findChildRecursively(group, buddyListArr[7]+"|" + buddyListArr[5]);

   if (node == null) //추가된 버디가 없으면
   {
      var status;
      
      if (buddyListArr[10] =='3') //승인
         status = buddyListArr[6];
      else if (buddyListArr[10] =='-5') //차단상태이면
         status ='100';      
      else //if (buddyListArr[10] !='3') //승인상태가 아니면
         status ='-1';

      var _dispName ="";
      if (itemClickDisp =="dispName")
         _dispName = buddyListArr[4];
      else if (itemClickDisp =="userId")
         _dispName = buddyListArr[1];
      else if (itemClickDisp =="nameUserId")
         _dispName = buddyListArr[3]+"("+buddyListArr[1] +")";
      else if (itemClickDisp =="nameDispName")
         _dispName = buddyListArr[3]+"("+buddyListArr[4] +")";
      else if (itemClickDisp =="userIdDispName")
         _dispName = buddyListArr[1]+"("+buddyListArr[4] +")";
      else
         _dispName = buddyListArr[3];//이름

   
      var nodes = new Ext.tree.TreeNode
                  ({
                     id:  buddyListArr[7]+"|" + buddyListArr[5], //id@domain|groupIdx
                     text: _dispName, //dispName
                     //text: buddyListArr[4], //dispName
                     iconCls: getStatusImage(status), //status
                     leaf:true,
                     allowDelete:true
                  })
   
      group.appendChild(nodes);
      group.expand();
   }
 
   treeBuddyStatusInfo();
}



function findChildRecursively(_tree, val) 
{ 
    var cs = _tree.childNodes; 
    
    for(var i = 0, len = cs.length; i < len; i++) 
    { 
         if(cs[i].attributes.id == val)
         { 
            return cs[i]; 
         } 
         else 
         { 
            // Find it in this tree 
            if(found = findChildRecursively(cs[i], val)) 
            { 
               return found; 
            } 
        } 
    } 
    return null; 
}  

   
function findNode(groupId) 
{ 
   var cs = root.childNodes; 
   var len=cs.length;
   for(var i=0; i<len; i++) 
   { 
      if (cs[i].attributes.id == groupId)
      {
         return cs[i];
      }         
   } 
   return null; 
}  


function afterClose()
{
   wins= null;  
}  



function makeGroupCombo()
{
   var child = root.childNodes;
   var len = child.length;
   var combo;
   var text;

   if (len >0 )
   {
      combo = new Array(len);
   
      for (var i=0; i<len; i++)
      {
         text = child[i].attributes.text.split("(");
         combo[i] = [ [text[0]], [child[i].attributes.id] ];
      }
   }
   return combo; 
}   



function buddyMapInfoPut(Field_arr)
{

		var listArray  = new Array(17);

		listArray[0] = Field_arr[1]; // 버디Index
		var id_domain = Field_arr[2].split('@');

		listArray[1] = id_domain[0]; // 버디ID
		listArray[2] = id_domain[1]; // 버디DOMAIN

		listArray[3] = Field_arr[3]; // 버디이름
		listArray[4] = Field_arr[4]; // 버디대화명
		listArray[5] = Field_arr[5]; // 버디그룹인덱스
		listArray[6] = Field_arr[6]; // 버디상태값
		listArray[7] = Field_arr[2]; //버디아이디@도메인
		listArray[8] = Field_arr[8]; //버디로그인서버IP
		listArray[9] = Field_arr[9]; // 버디로그인서버PORT
		listArray[10] = Field_arr[10]; //버디인증상태(0:알수없음,1:승인신청발신,2:승인신청수신,3:승인, -1:거절, -2:거절및차단,-3:삭제, -4:삭제및차단, -5:내가상대방차단 -6:상대방이차단)
		listArray[11] = Field_arr[11]; //버디사용자타입(1:일반_개인고객,2:일반_기업고객,3:회사직원,4:호스팅고객)
		listArray[12] = Field_arr[12]; //버디요청자이름
		listArray[13] = Field_arr[13]; //버디요청메세지
		listArray[14] = Field_arr[14]; //버디고객등급
		listArray[15] = Field_arr[15]; //핸드폰번호
		listArray[16] = Field_arr[7]; //버디메모

       hidef.buddyMap.put(Field_arr[2]+"|"+Field_arr[5] , listArray);


       if (Field_arr[10] =="3")
         hidef.watcherMap.put(Field_arr[2], Field_arr[6]);
       else
         hidef.watcherMap.put(Field_arr[2], "-1");

         
      treeBuddyStatusInfo();
         
}   

function treeBuddyStatusInfo()
{
   var onLine=0;

   var gorupNode = root.childNodes; 
   var groupLength = gorupNode.length;

   var buddyNode;
   var buddyLength;
   var buddy_id;
   var status;
   var _groupText;
   var groupText;
   var arr;
   
   for(var i=0; i<groupLength; i++) 
   { 
      onLine = 0;

      buddyNode = gorupNode[i].childNodes; 
      buddyLength = buddyNode.length;

      for (var k=0; k<buddyLength; k++) 
      {
         buddy_id = buddyNode[k].attributes.id;
         
         arr = hidef.buddyMap.get(buddy_id);

         if (arr[10] =="3")
         {
            if ( arr[6] >="0" & arr[6] !="100") 
            {
               onLine++;
            }
         }         
      }
      _groupText = gorupNode[i].attributes.text.split("(");

      groupText = _groupText[0] +"("+onLine + "/" + buddyLength +")";
      gorupNode[i].setText(groupText);
   } 
}   


function buddyMapInfoRemove(key)
{

}   


function watcherList()
{
   alert( hidef.js_getWatcherList());
}  


   
   