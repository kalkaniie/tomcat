//버디목록 그리기..
function setBuddyExpand()
{

   var flag = true;
   var status;

   var keys = hidef.groupMap.getKeys();
   var len = keys.length;
   var groupArrs;
   
    for(i = 0; i<len; i++)
    {
      groupArrs = hidef.groupMap.get(keys[i]);


    	if (groupArrs[2]=='0' || groupArrs[2]=='N')
            flag = false;
      else
            flag = true;

        var nodes = new Ext.tree.TreeNode({
            id:  groupArrs[0], //id
            text: groupArrs[1], //name
            allowDrag:false,
            allowDrop:true, 
            allowDelete:flag,
            expanded:true,
            draggable:true,
            leaf:false
            });
          tree.getRootNode().appendChild(nodes);
    } 

   var keys = hidef.buddyMap.getKeys();
   var len = keys.length;
   var buddyListArr;

    for(i = 0; i<len; i++)
    {
         buddyListArr = hidef.buddyMap.get(keys[i]);
         
         var child = findNode(buddyListArr[5]);//groupIdx

         if (buddyListArr[10] =='3')
            status = buddyListArr[6];
         else if (buddyListArr[10] =='-5' )
            status = "100";
         else
            status = '-1';


         var nodes = new Ext.tree.TreeNode
                     ({
                        //id:  buddyListArr[i][1] +'@' + buddyListArr[i][2]+'|' + buddyListArr[i][5], //id@domain|groupIdx
                        id:  buddyListArr[7] +'|' + buddyListArr[5], //id@domain|groupIdx
                        text: buddyListArr[4], //name
                        iconCls: getStatusImage(status),
                        leaf:true,
                        editable:false,                        
                        allowDelete:true
                     })
         
         child.appendChild(nodes);
    }

   dispMethodAction.setDisabled(false);
   action.setDisabled(false);
   action1.setDisabled(false);
   action2.setDisabled(false);

   treeBuddyStatusInfo();
   progress.reset();
   progress.destroy();
   root.collapseChildNodes();
   tree.show();

   hidef.WatcherListReq(hidef.user_id, '3');
   //hidef.AppleWorkRequest('30004102', hidef.user_id);

   //window.setTimeout("hidef.WatcherListReq(hidef.user_id, '3');", 500);
   window.setTimeout("hidef.AppleWorkRequest('30004102', hidef.user_id);", 500);



   //버디승인요청 POPUP
   loginBuddyAuthRelay();
}



//Buddy Image Css Return
function getStatusImage(code)
{
   var rslt;
  
   switch(parseInt(code))	
	{
		case 100:	rslt = "buddyBlock"; break;
		case -4 :	rslt = "buddyOff"; break;
		case -3 :	rslt = "buddy"+code; break;
		case -2 :	rslt = "buddyOff"; break;
		case -1 :	rslt = "buddyOff"; break;
		case 0 :	   rslt = "buddyOn"; break;
		case 1 :	   rslt = "buddyOut"; break;
		case 2 :	   rslt = "buddyBusy"; break;
		case 3 :	   rslt = "buddyBusiness"; break;
		case 4 :	   rslt = "buddyCall"; break;
		case 5 :	   rslt = "buddyEat"; break;
		case 6 :	   rslt = "buddyDisc"; break;
		case 7 :	   rslt = "buddyMemo"; break;
		case 8 :	   rslt = "buddyOff"; break;
		default :   rslt = "buddyOff"; break;
	}
	
	return rslt;
}   

//////////////////////// Buddy Right Menu function Start ////////////////////////

var menu;
var menu1;
var menu2;


function onContextMenu(node, e)
{
      var _node = tree.getSelectionModel().select( node );
      var setDisabled =true;
      if (eval(_node.attributes.leaf))
      {
               //Menu Block Define
               var info = _node.attributes.id;
               var arr = hidef.buddyMap.get(info);
               if (arr[10] =="3" || arr[10] =="-3")
                  setDisabled =false;
               //Menu Block Define
               
               var gorupNode = root.childNodes; 
               var groupLength = gorupNode.length;
               var groupName;
               //var groupId;
   
               var copyGroupMenu = new Ext.menu.Menu();
               var moveGroupMenu = new Ext.menu.Menu();
   
   
               for(var i=0; i<groupLength; i++) 
               { 
                  groupName = gorupNode[i].attributes.text.split("(");
                  groupName = groupName[0];
   
                  var groupId   = gorupNode[i].attributes.id;
                  
                  copyGroupMenu.add({
                     text: groupName,
                     id:groupId,
                     handler : function()
                     {
                        copyBuddySend(this.id);
                     }
                  });
   
                  moveGroupMenu.add({
                     text: groupName,
                     id:groupId,
                     handler : function()
                     {
                        moveBuddySend(this.id);
                     }
                  });
               } 

              
               
               menu = new Ext.menu.Menu([{
                   id: 'profile',
                   text: '버디정보',
                   iconCls:'buddyInfoMenuIcon',
                   handler : function()
                   {
                     friendProfile(this, e);
                   }
               },{
                   id:  'note',
                   text: '쪽지보내기',
                   iconCls:'memoSendMenuIcon',
                   handler : function()
                   {
                       var n = tree.getSelectionModel().getSelectedNode();
                        
                        if(n !=null)
                        {
                           //var buddy_id = n.attributes.id.split("|");
                           //buddy_id = buddy_id[0];
                           var arr = hidef.buddyMap.get(n.attributes.id);
                           js_Note_open(arr[7], arr[3]);
                        }
                   }
               },'-',{
                        id:  'mail',
                        text: '메일보내기',
                        iconCls:'mailSendMenuIcon',
                        handler : function()
                        {
                           alert("메일보내기");
                        }
               },{
                        id:  'sms',
                        text: '문자보내기',
                        iconCls:'smsSendMenuIcon',
                        handler : function()
                        {
                           alert("문자보내기");
                        }
               },'-',{
                        id:  'intercept',
                        text: '상대(차단/해제)',
                        //iconCls:'mailSendMenuIcon',
                        handler : function()
                        {
                           buddyBlockYn();
                        }
               },{
                        id:  'delete',
                        text: '상대 삭제',
                        //iconCls:'mailSendMenuIcon',
                        handler : function()
                        {
                           buddyDelYnAuthOpen();
                        }
               },{
                        text: '상대복사',
                        id:'buddyCopyMenu',
                        menu: copyGroupMenu
                         
               },{
                         id:  'buddyMoveMenu',
                        text: '상대이동',
                         menu: moveGroupMenu
               }
            ]);
           //}
           menu.items.get('note').setDisabled(setDisabled);
           //menu.items.get('sms').setDisabled(setDisabled);
           //menu.items.get('sms').setDisabled(setDisabled);
           menu.showAt(e.getPoint());
      }
      else
      {         
           if(!menu1){ // create context menu on first right click
               menu1 = new Ext.menu.Menu([{
                   id: 'groupAdd',
                   text: '그룹추가',
                   iconCls: 'groupMenuIcon',
                   handler : function()
                   {
                     addMyGroupOpen(this, e);
                   }
/*
               },{
                   id:  'groupUdt',
                   text: '그룹수정',
                   iconCls: 'groupMenuIcon',
                   handler : function()
                   {
                     udtMyGroupOpen(this, e);
                   }
*/
                },{
                   id:  'groupDel',
                   text: '그룹삭제',
                   iconCls: 'groupMenuIcon',
                   handler : function()
                   {
                     delMyGroup();
                   }
               }]);

           }

           menu1.showAt(e.getPoint());
      }
}
//////////////////////// Buddy Right Menu function End ////////////////////////

//온라인상태 관리 메뉴 이벤트
function onClick(obj, e)
{

          if(!menu2){ // create context menu on first right click
               menu2 = new Ext.menu.Menu([{
                     text: '온라인',
                     id:'0',
                     iconCls: 'buddyOn',
                     handler: onItemClick                        
   
                     },{
                        text: '자리비움',
                        iconCls: 'buddyOut',
                        id:'1',
                        handler: onItemClick
                     },{
                        text: '다른용무중',
                        iconCls: 'buddyBusy',
                        id:'2',
                        handler: onItemClick
                     },{
                        text: '통화중',
                        iconCls: 'buddyCall',
                        id:'4',
                        handler: onItemClick
                     },{
                        text: '회의중',
                        iconCls: 'buddyDisc',
                        id:'6',
                        handler: onItemClick
                     },{
                        text: '오프라인표시',
                        iconCls: 'buddyOff',
                        id:'-1',
                        handler: onItemClick
                     },'-',{
                        text: '내 대화명 설정',
                        id:'myName',
                        handler: onItemClick
                     },{
                        text: '차단목록',
                        id:'blockList',
                        handler: onItemClick
               }]);
           }
           menu2.showAt(e.getPoint());   
} 

//내 상태 변경 전송
function onItemClick(item, e)
{ 		 
      var status_id = item.id;

      if (status_id == 'blockList')
      {
         hidef.AppleWorkRequest('30003115', hidef.user_id);
      }
      else if (status_id == 'myName')
      {         
        
        var position = panel.getPosition();
        
         //mlAdd_displayName.style.top  = e.getPageX()-100;
         //mlAdd_displayName.style.left = e.getPageY()-100;
   
         mlAdd_displayName.style.left = position[0]+21;
         mlAdd_displayName.style.top  = position[1]+29;
   
   
         //document.all.myDisplayName.value =  replaceStr(action.getText(), "&nbsp;" ,"");
         document.all.myDisplayName.value =hidef.uaconfArr[1];
         
         mlAdd_displayName.style.display = "block";
         //document.all.myDisplayName.focus();
         //displayNameWindow(replaceStr(action.getText(), "&nbsp;" ,""), e, action);
      }

      else
      {
         hidef.StatusSend(hidef.user_id, hidef.js_getWatcherList(), status_id, '0', '');
         action.setIconClass(getStatusImage(status_id));
      }
} 

//////////////////////// Buddy Group function End ////////////////////////
/*function addMyGroupOpen(groupId, e)
{
   mlAdd_group1.style.left=e.getPageX()-50;
   mlAdd_group1.style.top=e.getPageY() -15;
   document.all.myGroupId.value='';
   mlAdd_group1.style.display = "block"; 
}	*/
/*
var myDisplayNameWindow = null;
function displayNameWindow(olderName, e)
{
	
	if(myDisplayNameWindow != null) myDisplayNameWindow.destroy();
	var form = new Ext.form.FormPanel({
	        baseCls: 'x-plain',
	        labelWidth: 50,
	        defaultType: 'textfield',
	        items: [{
	            fieldLabel: '그룹명',
	            labelSeparator:'',
	            name: 'displayname',
	            value:replaceStr(action.getText(), "&nbsp;" ,""),
	            readOnly:false,
	            anchor:'100%'
	        }]
	    });  	
  	
  	myDisplayNameWindow = new Ext.Window({
  			x : e.getPageX()- 50,
  			y : e.getPageY() -15,
        title: '그룹추가',
        width: 180,
        height:100,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        items: form,
        buttons: [{
            text: '확인',
             handler: function()
             				{             				
	             				myDisplayNamecheck(form, action);
	                    myDisplayNameWindow.destroy();
                    }
        }]
    });
	myDisplayNameWindow.show();   	
}
*/
/*
function addMyGroupOpen(groupId, e)
{

         var child = root.childNodes;
         var len = child.length;
         
         var groupNm="새그룹";
         var _groupNm="";
         var temp;
         var max=1;
         for (var i=0; i<len; i++)
         {
            temp = child[i].attributes.text.split("(");

            
            if (temp[0].indexOf("새그룹") >=0) 
            {               
               _groupNm = temp[0].substring(3);
               _groupNm =  _groupNm*1;
               
               if (max <=_groupNm)
                  max = _groupNm+1;
            }               
         }

         if (max >9)
            groupNm = groupNm + max;
         else
            groupNm = groupNm + "0" + max;


      	var strSendData = hidef.user_id + hidef.chField_Tab + groupNm;
      	hidef.AppleWorkRequest("30003102",strSendData);
}   
*/


var newGroupWindow = null;
function addMyGroupOpen(groupId, e)
{
	
	if(newGroupWindow != null) newGroupWindow.destroy();
	var form = new Ext.form.FormPanel({
	        baseCls: 'x-plain',
	        labelWidth: 50,
	        defaultType: 'textfield',
	        items: [{
	            fieldLabel: '그룹명',
	            labelSeparator:'',
	            name: 'groupname',
	            value:'',
	            readOnly:false,
	            anchor:'100%'
	        }]
	    });  	
  	
  	newGroupWindow = new Ext.Window({
  			x : e.getPageX()- 50,
  			y : e.getPageY() -15,
        title: '그룹추가',
        width: 180,
        height:100,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        items: form,
        buttons: [{
            text: '확인',
             handler: function()
             				{             				
	             		addMyGroupCheck(form);
	                    newGroupWindow.destroy();
                    }
        }]
    });
	newGroupWindow.show();   	
}


/*var groupText;
function udtMyGroupOpen(groupId, e)
{
      mlAdd_group2.style.left=e.getPageX()-50;
      mlAdd_group2.style.top=e.getPageY() -15;


      var n = tree.getSelectionModel().getSelectedNode();
      if(n !=null )
      {
         if (n.attributes.allowDelete == false)
         {
               alert("변경이 불가능한 그룹 입니다.");
               return;
         }          


         groupText =n.attributes.text.split("(");
		   document.all.myGroupId1.value=groupText[0];
   		mlAdd_group2.style.display = "block"; 
      }
}	*/

/*
var udpGroupWindow = null;
function udtMyGroupOpen(groupId, e)
{
	if(udpGroupWindow != null) udpGroupWindow.destroy();
	var n = tree.getSelectionModel().getSelectedNode();
	var groupText;
  if(n !=null )
  {
     if (n.attributes.allowDelete == false)
     {
           alert("변경이 불가능한 그룹 입니다.");
           return;
     } 
     
     groupText =n.attributes.text.split("(");
     
     var form = new Ext.form.FormPanel({
	        baseCls: 'x-plain',
	        labelWidth: 50,
	        defaultType: 'textfield',
	        items: [{
	            fieldLabel: '그룹명',
	            labelSeparator:'',
	            name: 'groupname',
	            value:groupText[0],
	            readOnly:false,
	            anchor:'100%'
	        }]
	    });  	
  	
  	udpGroupWindow = new Ext.Window({
  			x : e.getPageX()- 50,
  			y : e.getPageY() -15,
        title: '그룹변경',
        width: 180,
        height:100,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        items: form,
        buttons: [{
            text: '확인',
             handler: function()
             				{             				
	             				udtMyGroupCheck(form);
	                    udpGroupWindow.destroy();
                    }
        }]
    });
	udpGroupWindow.show();   
     
     
  }
}
*/


function addMyGroupCheck(form)
{
	var groupNm = trim(trim(form.getForm().findField('groupname').getValue())); //trim 추가!!!
	if ( groupNm == '')
	{
      //공백이면 닫기
      //mlAdd_group1.style.display = "none"; 
      alert("그룹명을 입력해 주세요");		
			return;
	}
   
   else
   {
      var n = tree.getSelectionModel().getSelectedNode();

      if (n !=null)
      {
         var child = root.childNodes;
         var len = child.length;
         var temp;
         for (var i=0; i<len; i++)
         {
            temp = child[i].attributes.text.split("(");

            if(temp[0] == groupNm)      
            {
               alert("중복된 그룹명 입니다.");
               obj.focus();
               return;
               break;
   			}
         }

      	var strSendData = hidef.user_id + hidef.chField_Tab + groupNm;
      	hidef.AppleWorkRequest("30003102",strSendData);
      	//mlAdd_group1.style.display = "none"; 
      	
      }
   }
}	


/*function udtMyGroupCheck(obj)
{
   var groupNm = trim(obj.value); 
	if ( groupNm == '')
	{
      mlAdd_group2.style.display = "none"; 

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
         for (var i=0; i<len; i++)
         {
            temp = child[i].attributes.text.split("(");

            if(temp[0] == groupNm)      
            {
               alert("중복된 그룹명 입니다.");
               obj.focus();
               return;
               break;
   			}
         }
   
   	   var strSendData = groupId + hidef.chField_Tab + groupNm;
   	   hidef.AppleWorkRequest("30003103", strSendData);
         n.setText(groupNm+"("+temp[1]);
   	   mlAdd_group2.style.display = "none"; 

         treeBuddyStatusInfo();
      }
   }
}	*/
function udtMyGroupCheck(form)
{
   var groupNm = trim(form.getForm().findField('groupname').getValue()); 
	if ( groupNm == '')
	{
		alert("그룹명을 입력해 주세요");		
		return;
	}
   else
   {      
      var n = tree.getSelectionModel().getSelectedNode();
      if (n !=null)
      {
         var child = root.childNodes;
         var groupId = n.attributes.id;
         //alert(groupId);
         var len = child.length;
         var temp;
         for (var i=0; i<len; i++)
         {
            temp = child[i].attributes.text.split("(");

            if(temp[0] == groupNm)      
            {
               alert("중복된 그룹명 입니다.");
               obj.focus();
               return;
               break;
            }
         }
   
   	   var strSendData = groupId + hidef.chField_Tab + groupNm;
   	   hidef.AppleWorkRequest("30003103", strSendData);
         n.setText(groupNm+"("+temp[1]);

   	   //mlAdd_group2.style.display = "none"; 
       //  treeBuddyStatusInfo();
      }
   }
}	


function GetAppendMyGroup(szResult)
{
   //IDX, NAME
   var tmp = szResult.split(hidef.chRecord_Enter);
   var arr = tmp[0].split(hidef.chField_Tab);
   var flag = true; 

   var n = new Ext.tree.TreeNode({
      id:  arr[0], //id
      text: arr[1]+"(0/0)", //name
      allowDelete:true,
      expanded:true,
      leaf:false
   })
   var gArray = new Array(3);
   gArray[0]= arr[0]; //idx
   gArray[1]= arr[1]; //name
   gArray[2]= "Y"; //default 
   
   hidef.groupMap.put(arr[0], gArray);
   tree.getRootNode().appendChild(n);
   tree.getSelectionModel().select(n);
   buddyTreeEditor.editNode = n;
   buddyTreeEditor.focus();
   //buddyTreeEditor.startEdit(n.ui.textNode);   
   
}   

function delMyGroup()
{

   var n = tree.getSelectionModel().getSelectedNode();

   if (n !=null)
   {
      var groupId = n.attributes.id;
      var child = n.childNodes;
   
      //alert("flag:"+ n.attributes.allowDelete);
   
      if (n.attributes.allowDelete == false)
      {
         alert("삭제가 불가능한 그룹 입니다.");
         return;
      }      
   
      if (child.length > 0)
      {
   		alert("버디가 존재하므로 삭제가 불가능 합니다.");
   		return;
      }
   
   	var yes = confirm("삭제 하시겠습니까?");
   	if (yes)
   	{
      		var strSendData = groupId + hidef.chField_Tab; 
      		hidef.AppleWorkRequest("30003104",strSendData);
            n.parentNode.removeChild(n);
			
            hidef.groupMap.remove(groupId);

   	}
	}
}	
//////////////////////// Buddy Group function End ////////////////////////


//////////////////////// Buddy Search  function Start ////////////////////////
function GetUserSearch(rslt, isNextPage, totCnt)
{
   totCnt = parseInt(totCnt);
   startNum = parseInt(startNum);   
   isNext = isNextPage;

   if (totCnt <=10) //10개미만이면 pre/next false
   {
         preAction.setDisabled(true);
         nextAction.setDisabled(true);
   }
   
   else
   {
      if (startNum == 1 )	//최초이면 pre:false, next:true
      {
            if ( !preAction.isDisabled() )
               preAction.setDisabled(true);

            
            if ( nextAction.isDisabled() )
               nextAction.setDisabled(false);
      }
      else if (totCnt - startNum <=9 ) //요청이 마지막이면
      {         
            preAction.setDisabled(false);
            nextAction.setDisabled(true);
      }

      else //이전다음중간의경우
      {
            preAction.setDisabled(false);
            nextAction.setDisabled(false);
      }         
   }            
   
   store.removeAll();

   if (totCnt ==0)
      alert("검색 결과가 없습니다.");
   else
      store.loadData(rslt);
}



function userSearch()
{
	var _schType = trim(combo.getValue());
   var _keyword = trim(field.getRawValue());
/*
   if (_keyword.length < 2 )
   {
      alert("조건은 두자이상 입력해 주세요.");
      field.focus();
      return;
   }      
*/

   if (schType =='')
   {
      schType = _schType;
   }      
   else if (schType != _schType)
   {
      startNum=1;
      schType = _schType;
   }
   
   if (keyword =='')
   {
      keyword = _keyword;
   }
   else if ( keyword != _keyword)
   {
      startNum=1;  
      keyword = _keyword;
   }            

   //alert(schType + "||" + keyword +"||"+ startNum);
	hidef.userSearchReq(schType, keyword, startNum);
} 

function nextSearch()
{
	if (isNext !=0)
	{
      var _startNum = startNum + 10;   
	   hidef.userSearchReq(schType, keyword, _startNum);
      startNum = _startNum;
   }
}


function preSearch()
{   
	if (startNum >=11)
	{
      var _startNum = startNum - 10;   
	   hidef.userSearchReq(schType, keyword, _startNum);
      startNum = _startNum;
   }
   else
   {
	   hidef.userSearchReq(schType, keyword, startNum);
   }
}   

function specialKeysOn( field, e ) 
{
   if ( e.getKey() == e.RETURN || e.getKey() == e.ENTER ) 
   {
      userSearch();
   }
}

function onContextMenuGrid(grid, rowIdx, e)
{
   grid.getSelectionModel().selectRow(rowIdx);
   e.preventDefault(); 

   if(!buddySearchMenu)
   { 
      buddySearchMenu = new Ext.menu.Menu([{
         id: 'buddyAddMenu',
         text: '상대추가',
         //iconCls: 'groupMenuIcon',
         handler : function()
         {
            buddyAddWindow();
         }
      }]);
   }
   
   buddySearchMenu.showAt(e.getPoint());
}  

function dodbClickGrid()
{
   //alert("그리드더블클릭");  
}


//////////////////////// Buddy Search  function End ////////////////////////


function buddyAddWindow()
{
      var record = searchGrid.getSelectionModel().getSelected();
      if (record != null)
      {
         var owner_id = hidef.uaconfArr[3];
         var owner_nm = hidef.uaconfArr[0];

         var buddy_nm = record.get("name");
         var buddy_id = record.get("userId");

         var groupIdx = comboGroup.getValue();
         //alert("그룹:"+ groupIdx+ "**버디:"+ buddy_id + "||" + buddy_nm + "**사용자:"+ owner_id +"||" +owner_nm);

         if (buddy_id == owner_id)
         {
            alert("자기 자신을 상대로 등록 할 수 없습니다.");  
            return;
         }            

         var group = findNode(groupIdx);
         if (group !=null)
         {
            var node = findChildRecursively(group, buddy_id+"|"+ groupIdx);
            if (node != null)
            {
               alert("같은 그룹에 이미 추가되어 있습니다");
               return;
            }               
         }            

		 //상대 등록 요청 잠시 보류
         //buddyAuthReqWindow(buddy_id, buddy_nm, owner_id, owner_nm, groupIdx);
         //상대 등록 2009.05.28 by 박세현 
         buddyAuthWindow(buddy_id, buddy_nm, owner_id, owner_nm, groupIdx);
      }

      else
      {         
         alert("추가할 대상을 선택해 주세요");
      }
}   



function buddyAuthReqWindow(buddy_id, buddy_nm, owner_id, owner_nm,  groupIdx)
{
   
   var _id = owner_id.split("@");
   var user_id ="";

   if (_id[0] !=null) user_id = _id[0];

   var fromMessage ="안녕하세요?  '" + owner_nm +"' 입니다.  상대 등록을 요청 합니다.";
   var toMessage ="'" + buddy_nm + "("+ user_id + ")'님에게 상대 등록을 요청 합니다.";
   var form = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        labelWidth: 370,
        defaultType: 'textfield',

        items: [{
            fieldLabel: toMessage,
            labelSeparator:'',
            name: 'to',
            anchor:'0%'
        },{
            fieldLabel: "아래에 요청 메세지를 입력하고 '상대요청' 버튼을 클릭하세요.",
            labelSeparator:'',
            name: 'subject',
            anchor: '0%'
       }, {
            xtype: 'hidden',
            name: 'buddy_id',
            value : buddy_id
       }, {
            xtype: 'hidden',
            name: 'owner_id',
            value : owner_id
       }, {
            xtype: 'hidden',
            name: 'owner_nm',
            value : owner_nm
       }, {
            xtype: 'hidden',
            name: 'groupIdx',
            value : groupIdx
       }, {
            xtype: 'textarea',
            maxLength:62,
            hideLabel: true,
            name: 'msg',
            width:390,
            height:60,
            value:fromMessage

        }]
    });

    var window = new Ext.Window({
        title: '상대등록 요청',
        width: 420,
        height:200,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        closeAction:'close',
        items: form,
       buttons: [{
            text: '상대요청',
             handler: function(){
                     buddyAuthSend(window, form);
                    }
        },{
            text: '취소',
             handler: function(){
                     window.destroy();
                    }
        }]
      });

    window.show();
}



//로그인시 버디인증창 띠우기
function loginBuddyAuthRelay()
{

   var keys = hidef.buddyMap.getKeys();
   var len = keys.length;
   var arr;

   for (var i=0; i<len; i++)
   {
      arr = hidef.buddyMap.get(keys[i]);


      if (arr[10] =='2') //승인요청 쪽지 수신시)
      {
          var buddy_id = arr[1] + "@" + arr[2];
          var buddy_nm = arr[3];
          var toMessage = arr[13];
          buddyAuthRelayWindow(buddy_id, buddy_nm, toMessage);
      }         
   }      
}





//버디요청 승인창
function buddyAuthRelayWindow(buddy_id, buddy_nm, toMessage)
{
   var _id = buddy_id.split("@");
   var user_id ="";
   if (_id[0] !=null) user_id = _id[0];   
   
   
   var fromMessage = buddy_nm +"(" + user_id +")님으로 부터 상대요청이 왔습니다.";
   var form = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        defaultType: 'textfield',
        labelWidth: 370,        
        items: [{
            fieldLabel: fromMessage,
            labelSeparator:'',
            name: 'to',
            anchor:'0%'
        },{
            fieldLabel: "요청 메세지",
            //labelSeparator:'',
            name: 'subject',
            anchor: '0%'
        }, {
            xtype: 'textarea',
            maxLength:62,
            hideLabel: true,
            readOnly:true,
            name: 'msg',
            width:390,
            height:60,
            value:toMessage
       }, {
            xtype: 'hidden',
            name: 'buddyId',
            value : buddy_id
        }, {
            xtype: 'checkbox',
            id: 'chkbox',
            name: 'chkbox',
            hideLabel:true,
            boxLabel: ' 거절시 차단 목록에 자동 추가',
            labelSeparator:''
        }]
    });

    var window = new Ext.Window({
        title: '상대 등록 요청',
        width: 420,
        height:210,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        closeAction:'close',
        items: form,
        buttons: [{
            text: '수락',
             handler: function(){
                     buddyAcceptSend(window, form, '1');
                    }
        },{
            text: '거절',
             handler: function(){
                     buddyAcceptSend(window, form, '2');
                    }
        }]
    });

    window.show();
}

//친구추가 수락/차단 전송
function buddyAcceptSend(window, form, authType)
{
   var userId = hidef.user_id;
   var buddyId = form.getForm().findField('buddyId').getValue();
   var isBlock =form.getForm().findField('chkbox').getValue();
   
   
   if (authType=='2' & isBlock)
      authType = '3';

   //alert(buddyId + authType);
   
   hidef.BuddyAcceptReq(userId, buddyId, authType);
   
   window.destroy();
} 


//친구추가 요청
function buddyAuthSend(window, form)
{
   var owner_id = form.getForm().findField('owner_id').getValue();
   var owner_nm = form.getForm().findField('owner_nm').getValue();
   var buddy_id = form.getForm().findField('buddy_id').getValue();
   var groupIdx = form.getForm().findField('groupIdx').getValue();
   var reqMsg   = form.getForm().findField('msg').getValue();
   
   hidef.BuddyAddReq(owner_id, owner_nm, buddy_id, groupIdx, reqMsg);
   window.destroy();
} 


//버디승인 결과 승인시 Relay....
function updateBuddyStatusResp(buddyListArr)
{	
   var group = findNode(buddyListArr[5]);//groupIdx
   var node = findChildRecursively(group, buddyListArr[2]+"|"+buddyListArr[5]);

   if (node != null) //추가된 버디가 있으면
   {
      var status = "-1";
      if (buddyListArr[10] =='3') //승인상태이면
      {
         status = buddyListArr[6];

         node.getUI().getIconEl().className = 'x-tree-node-icon ' + getStatusImage(status);
         ///node.getUI().getIconEl().src = getStatusImageSrc(status); 
         alert(buddyListArr[2]+  "님이 상대로 등록을 수락 하셨습니다.");
      }
   }

   //hidef.watcherMap.put(buddyListArr[2], status);
   buddyMapInfoPut(buddyListArr);
}




//친구삭제/차단 창
function buddyDelYnAuthOpen()
{

   var n = tree.getSelectionModel().getSelectedNode();
   if(n !=null)
   {
      var buddy_id = n.attributes.id.split("|");
      buddy_id = buddy_id[0];
      var owner_id = hidef.user_id;
      var childNode = n.parentNode;
      var groupIdx = childNode.attributes.id;

      var arr = hidef.buddyMap.get(buddy_id +"|" + groupIdx);

      //alert("buddyDelYnAuthOpen:"+ arr);

      var buddy_nm = arr[3]; //버디명
      var buddy_idx = arr[0]; //버디IDX
      var group_idx = arr[5]; //버디그룹IDX

      var fromMessage = buddy_nm +"(" + buddy_id +")님을 삭제 하시겠습니까?";

      var form = new Ext.form.FormPanel({
        frame:true,
        title: fromMessage,
        bodyStyle:'padding:5px 5px 0',
        items: [{
                  xtype:'fieldset',
                  title: '선택사항',
                  autoHeight:true,
                  defaults: {width: 310},
                  defaultType: 'textfield',
                  items :[{
                           xtype: 'checkbox',
                           name: 'chkbox',
                           hideLabel:true,
                           boxLabel  : ' 이 사용자가 온라인 상태 정보 확인과 메세지 전송을 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;못하도록 차단함',
                           labelSeparator:''
                  }, {
                  xtype: 'hidden',
                  name: 'owner_id',
                  value : owner_id
                  }, {
                  xtype: 'hidden',
                  name: 'buddy_id',
                  value : buddy_id
                  }, {
                  xtype: 'hidden',
                  name: 'group_idx',
                  value : group_idx
                  }, {
                  xtype: 'hidden',
                  name: 'buddy_idx',
                  value : buddy_idx
            }]
        }]
    });

    var window = new Ext.Window({
        title: '상대삭제',
        width: 400,
        height:200,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        closeAction:'close',
        items: form,
        buttons: [{
            text: '확인',
             handler: function(){
                    authModifySend(window, form);
                    }
        },{
            text: '취소',
             handler: function(){
                     window.destroy();
                    }
        }]
    });

    window.show();  
   }
}   

//친구삭제/차단창 SendData Set..
function authModifySend(window, form)
{

   var auth_type='4';//삭제
   var owner_id   = form.getForm().findField('owner_id').getValue();
   var buddy_id   = form.getForm().findField('buddy_id').getValue();
   var buddy_idx  = form.getForm().findField('buddy_idx').getValue();
   var isCheck    = form.getForm().findField('chkbox').getValue();
   var group_idx  = form.getForm().findField('group_idx').getValue();
   if (isCheck)
      auth_type='5';   //삭제&차단

   //Buddy가 복수로 등록될수 있으므로 해당 노드의 buddy를 가져온다.
   var group = findNode(group_idx);//groupIdx
   var node = findChildRecursively(group, buddy_id+ "|" + group_idx);

   if (node != null)
   {
      group.removeChild(node);
      hidef.authModifyReq(owner_id, buddy_id, buddy_idx, auth_type);
      hidef.buddyMap.remove(buddy_id+"|"+ group_idx);
   }

   if (auth_type =='5')
   {
      //차단삭제이면 watcher에서제게
      hidef.watcherMap.remove(buddy_id);
   }

   //alert("owner_id:"+ owner_id +"||buddy_id:"+ buddy_id+"||buddy_idx:"+ buddy_idx+"||auth_type:"+ auth_type+"||group_idx:"+group_idx);

   window.destroy();
   treeBuddyStatusInfo();
}  


/*
function myDisplayNamecheck(form, obj)
{
  var displayName = trim(form.getForm().findField('displayname').getValue());
	//alert("displayName:"+displayName);
	if ( displayName == '')
	{
		alert("내 대화명을 입력해 주세요");		
		return;
	}

   var before =   trim( action.getText() );
   //alert("before:"+before);
   if (before != displayName)
   {
      hidef.myDisplayNameReq(displayName);
      //mlAdd_displayName.style.display = "none"; 
      action.setText(displayName);
   }
}
*/
var myDisplayNameFlag = "N";

function myDisplayNamecheckEnter(obj, keyCod)
{
 
   if (myDisplayNameFlag == "N")
   {
      myDisplayNameFlag = "Y";

      var displayName = trim(obj.value);

   	if ( displayName == '')
   	{
   		alert("내 대화명을 입력해 주세요");
   		obj.focus();
   		return;
   	}
   
   	if ( displayName.length > 19)
   	{
   		alert("내 대화명을 조정해 주세요");
   		obj.focus();
   		return;
   	}
   
      var before =   trim( hidef.uaconfArr[1] );
      
      if (before != displayName)
      {
         setTooltip(_action, displayName);

         hidef.myDisplayNameReq(displayName);
         mlAdd_displayName.style.display = "none"; 
   
         var name = displayName;
         if (displayName.length >=8)
            name = displayName.substring(0,8)+"...";
   
         _action.setText(name);
         hidef.uaconfArr[1] = displayName;
      }
      else
      {      
         mlAdd_displayName.style.display = "none"; 
      }
   }
   else
   {      
      myDisplayNameFlag = "N";
   }

}   


function myDisplayNamecheck(obj)
{

   if (myDisplayNameFlag=="N")
   {
      myDisplayNameFlag="Y";

      var displayName = trim(obj.value);

   	if ( displayName == '')
   	{
   		alert("내 대화명을 입력해 주세요");
   		obj.focus();
   		return;
   	}
   
   	if ( displayName.length > 19)
   	{
   		alert("내 대화명을 조정해 주세요");
   		obj.focus();
   		return;
   	}
   
      var before =   trim( hidef.uaconfArr[1] );
      
      if (before != displayName)
      {
         setTooltip(_action, displayName);

         hidef.myDisplayNameReq(displayName);
         mlAdd_displayName.style.display = "none"; 

         var name = displayName;
         if (displayName.length >=8)
            name = displayName.substring(0,8)+"...";

         _action.setText(name);  
         hidef.uaconfArr[1] = displayName;
      }
      else
      {      
         mlAdd_displayName.style.display = "none"; 
      }
   }
   else
   {      
      myDisplayNameFlag = "N";
   }
}

//상대방 대화명 변경 Update
function NameNotify(sendId, dispName)
{
   //복수 Buddy가 존재할수 있다!!
   
   var child = root.childNodes;
   var len = child.length;
   var n;
   var tmp;

   for (var i=0; i<len; i++)
   {
      n = findChildRecursively(child[i], sendId+ "|"+ child[i].attributes.id);

      if (n !=null)
      {
         n.setText(dispName);
      }
   }
}   

//Off Line Memo Count Set
function GetOffLineNoteCnt(szResult)
{
   action1.setText(szResult);
}

//친구 프로파일
var friendProfileEvent = null;
function friendProfile(item, e)
{
   var n = tree.getSelectionModel().getSelectedNode();

   if (n !=null)
   {
      var buddy_id = n.attributes.id.split("|");

      var arr = hidef.buddyMap.get(n.attributes.id);
      
      if (arr[10] =="3" ||  arr[10] =="-3")
      {
         menuX = e.getPageX();
         menuY = e.getPageY();
      
         friendProfileEvent = e;
   
         buddy_id = buddy_id[0];
   	   var strSendData = hidef.user_id + hidef.chField_Tab + buddy_id;
   	   hidef.AppleWorkRequest("30003112",strSendData);
      }
      else
      {
         alert("요청하신 사용자 정보에 대한 권한이 없습니다.");
      }                  
   }

}	


var displayFiendInfoWindow = null;
function displayFiendInfo(arr) {
	
		if(displayFiendInfoWindow != null) displayFiendInfoWindow.destroy();
    var gender = '비공개';
    if(arr[4] == 'Y') gender = transSex(arr[3]);
    
    var age = '비공개'
    if(arr[6] == 'Y') age = arr[5];
    
    var telno = '비공개'
    if(arr[9] == 'Y') telno = arr[8];
    
    var hpno = '비공개'
    if(arr[11] == 'Y') hpno = arr[10];
    
  	var form = new Ext.form.FormPanel({
	        baseCls: 'x-plain',
	        labelWidth: 70,
	        defaultType: 'textfield',
	        items: [{
	            fieldLabel: 'ID',
	            labelSeparator:'',
	            name: 'users_id',
	            value:arr[0],
	            readOnly:true,
	            anchor:'100%'
	        },{
	            fieldLabel: "성명",
	            labelSeparator:'',
	            name: 'user_nm',
	            value:arr[1],
	            readOnly:true,
	            anchor:'100%'
	       },{
	            fieldLabel: "대화명",
	            labelSeparator:'',
	            name: 'displayname',
	            value:arr[2],
	            readOnly:true,
	            anchor:'100%'
	       },{
	       			
	            fieldLabel: "성별",
	            labelSeparator:'',
	            name: 'gender',
	            value: gender,
	            readOnly:true,
	            anchor:'100%'
	       },{
	            fieldLabel: "나이",
	            labelSeparator:'',
	            name: 'age',
	            value: age,
	            readOnly:true,
	            anchor:'100%'
	       },{
	            fieldLabel: "이메일",
	            labelSeparator:'',
	            name: 'email',
	            value:arr[7],
	            readOnly:true,
	            anchor:'100%'
	       },{
	            fieldLabel: "전화번호",
	            labelSeparator:'',
	            name: 'telno',
	            value:telno,
	            readOnly:true,
	            anchor:'100%'
	       },{
	            fieldLabel: "핸드폰",
	            labelSeparator:'',
	            name: 'hpno',
	            value:hpno,
	            readOnly:true,
	            anchor:'100%'
	       },{
	       			fieldLabel: "버디메모",
	       			labelSeparator:'',
	       		  xtype: 'textarea',            
	            readOnly:true,
	            name: 'msg',
	            width:194,
	            height:50,
	            value:replaceStr(arr[17], "", "\n")
	        }]
	    });
  	
  	displayFiendInfoWindow = new Ext.Window({
  			x : friendProfileEvent.getPageX()- 50,
  			y : friendProfileEvent.getPageY() -15,
        title: '버디정보',
        width: 300,
        height:350,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        items: form,
        buttons: [{
            text: '확인',
             handler: function(){
                     displayFiendInfoWindow.destroy();
                    }
        }]
    });

    displayFiendInfoWindow.show();
    
}

function transSex(val)
{
   var rslt ='';

   if (val =='M')      rslt = '남자';
   else if (val =='F')      rslt = '여자';

   return rslt;
}  


//Login 후 대와명 상태 Set
function setDisplayName(myName)
{
   var name="";
	
   if (myName.length >=8)
      name = myName.substring(0,8)+"...";
   else
      name = myName;

   action.setText(name);
   action.setIconClass('buddyOn');
   setTooltip(_action, myName);
}

//BlockList List 창
var blockWindow = null;
function blockListView(_arrayData)
{
		 if(blockWindow != null) blockWindow.destroy();
		 
		 var len = _arrayData.length-1;
		 if(parseInt(len) < 1) 
		 {
			 	alert("등록된 차단리스트가 없습니다."); 
			 	return;
		 }
	   var arrayData = null;
	   if (len >0 )
	   {
	      arrayData = new Array(len);
					   
	      for (var i=0; i<len; i++)
	      {
	      	 var _temp = _arrayData[i].split("\t");	      	 
	         arrayData[i] = [ _temp[0],  _temp[1], _temp[2], _temp[3] ];
	      }
	   }
		
		
   
    var xg = Ext.grid;

    // shared reader
    var reader = new Ext.data.ArrayReader({}, [
    	 {name: 'buddyindex', type:'float'},
       {name: 'users_id'},
       {name: 'user_nm'},
       {name: 'auth_type'}
    ]);
    
    var sm = new xg.CheckboxSelectionModel();
    sm.singleSelect = true;
    
    var grid2 = new xg.GridPanel({
        store: new Ext.data.Store({
            reader: reader,
            data: arrayData
        }),
        cm: new xg.ColumnModel([
            sm,
            {id:'buddyindex',header: "버디인덱스",  hidden:true, dataIndex: 'buddyindex'},
            {header: "ID", width: 100, sortable: false, dataIndex: 'users_id'},
            {header: "이름", width: 150, sortable: false, dataIndex: 'user_nm'},
            {header: "AUTH_TYPE", hidden:true,  dataIndex: 'auth_type'}
        ])
    });   
    
   blockWindow = new Ext.Window({
   title: '차단리스트',
   width: 300,
   height:350,
   resizable:false,
   layout: 'fit',
   plain:true,
   bodyStyle:'padding:5px;',
   buttonAlign:'center',
   items: grid2,
   buttons: [
               {text:'차단해제', handler: function(){
                  removeBlock(grid2.getSelectionModel().getSelected(), blockWindow);
               }},
               {text:'취소',  handler: function(){
                  blockWindow.destroy();
               }}
             ]
   });
   blockWindow.show(); 	
}


function removeBlock(record, window)
{
	if(record == null)
	{
		alert('차단 해제할 사용자를 선택하세요');
		return;
	}
	
	var buddyindex = record.get("buddyindex");
	var buddyid = record.get("users_id");
	var buddyname = record.get("user_nm");
	var auth_type = record.get("auth_type");
	
	hidef.authModifyReq(hidef.user_id, buddyid, buddyindex, "1");
	//alert(auth_type);
	window.destroy();
}



//버디창 열기.
function dodbClick()
{
		
      var n = tree.getSelectionModel().getSelectedNode();
      
      if(n !=null)
      {
         var name = n.attributes.text;
         var buddy_id = n.attributes.id.split("|");
         buddy_id = buddy_id[0];
         var status = hidef.watcherMap.get(buddy_id);
		
		
      	if(buddy_id == hidef.user_id)
      	{
      		return;
      	}
      	if (status >="0" && (status !="-1" || status !="-4") )
         {
        	 hidef.DialogIndexReq(hidef.user_id, buddy_id);
	        
         }
      }
}

function copyBuddySend(groupId)
{
   var n = tree.getSelectionModel().getSelectedNode();
   
   if(n !=null)
   {
      var name = n.attributes.text;
      var buddy_id = n.attributes.id.split("|");
      buddy_id = buddy_id[0];

      var check = hidef.buddyMap.get(buddy_id+"|"+ groupId);
      if (check != null)
      {
         alert("같은 그룹에 이미 추가되어 있습니다.");
         return;        
      }

      else
      {         
         //alert("groupId:"+ groupId +"||buddy_id:"+buddy_id+"||user_id:"+ hidef.user_id);
         hidef.BuddyCopyGroupReq(groupId, hidef.user_id, buddy_id);
      }
   }
}   


function moveBuddySend(groupId)
{

   var n = tree.getSelectionModel().getSelectedNode();
   
   if(n !=null)
   {
      var name = n.attributes.text;
      var buddy_id = n.attributes.id.split("|");
      buddy_id = buddy_id[0];
      var beforeId = n.attributes.id;

      var check = hidef.buddyMap.get(buddy_id+"|"+ groupId);
      if (check != null)
      {
         alert("같은 그룹에 이미 추가되어 있습니다.");
         return;        
      }

      else
      {         

         var buddyListArr = hidef.buddyMap.get(beforeId);
         var buddyindex = buddyListArr[0];
         
         hidef.BuddyMoveGroupReq(buddyindex, groupId);
         n.parentNode.removeChild(n);
         hidef.buddyMap.remove(beforeId);

         buddyListArr[5] = groupId;
         hidef.buddyMap.put(buddy_id+"|"+ groupId, buddyListArr);

         defaultBuddyAddFromMap(buddyListArr);
      }
   }
   
}   

//온라인상태 관리 메뉴 이벤트
function onClickdispMethod(obj, e)
{
      var menu3 = new Ext.menu.Menu([{
            text: '이름',
            id:'name',
            handler: onItemClickDispMethod
            },{
               text: '대화명',
               id:'dispName',
               handler: onItemClickDispMethod
            },{
               text: '아이디',
               id:'userId',
               handler: onItemClickDispMethod
            },{
               text: '이름(아이디)',
               id:'nameUserId',
               handler: onItemClickDispMethod
            },{
               text: '이름(대화명)',
               id:'nameDispName',
               handler: onItemClickDispMethod
            },{
               text: '아이디(대화명)',
               id:'userIdDispName',
               handler: onItemClickDispMethod
      }]);

      menu3.showAt(e.getPoint());   
} 


function onItemClickDispMethod(item, e)
{ 		 
   var id = item.id;

   //대화명표시설정
   itemClickDisp = id;

   var gorupNode = root.childNodes; 
   var groupLength = gorupNode.length;

   var buddyNode;
   var buddyLength;
   var buddy_id;
   var arr;
   
   for(var i=0; i<groupLength; i++) 
   { 
      buddyNode = gorupNode[i].childNodes; 
      buddyLength = buddyNode.length;

      for(var k=0; k<buddyLength; k++) 
      {
         buddy_id = buddyNode[k].attributes.id;
         
         arr = hidef.buddyMap.get(buddy_id);

         if (id =="dispName")
            buddyNode[k].setText(arr[4]);
         else if (id =="userId")
            buddyNode[k].setText(arr[1]);
         else if (id =="nameUserId")
            buddyNode[k].setText(arr[3]+"("+arr[1] +")" );
         else if (id =="nameDispName")
            buddyNode[k].setText(arr[3]+"("+arr[4] +")" );
         else if (id =="userIdDispName")
            buddyNode[k].setText(arr[1]+"("+arr[4] +")" );
         else
            buddyNode[k].setText(arr[3]);//이름
      }
   } 
} 

function doClick()
{
   alert("원클릭");
}  

function buddyOff()
{
   panel.destroy();
   hidef.js_allClose();
}   


function setTooltip(btn, tooltip) 
{
   btn.tooltip = tooltip;
   var btnEl = btn.getEl().child(btn.buttonSelector);
   if(typeof tooltip == 'object')
   {
      Ext.QuickTips.register(Ext.apply({target: btnEl.id}, tooltip));
   } 
   else 
   {
      btnEl.dom[btn.tooltipType] = tooltip;
   }
}




function ltrim(str) {
    
    var i;
    var ch;
    var retStr = '';
    
    if(str==null)
      return retStr;
      
    if (str.length == 0)
        return str;
    for (i=0;i<str.length;i++) {
        ch = str.charAt(i);
        if (retStr.length == 0 && (ch == ' ' || ch == '\r' || ch == '\n'))
            continue;
         retStr += ch;
    }
    return retStr;
}


function rtrim(str) {
    var i;
    var ch;
    var retStr = '';
    if (str.length == 0)
        return str;
    for (i=str.length-1;i>=0;i--) {
        ch = str.charAt(i);
        if (ch != ' ' && ch != '\r' && ch != '\n') {
            break;
        }
    }
    retStr = str.substring(0, i+1);
    return retStr;
}


function trim(str) {
    var retStr;
    retStr = ltrim(str);
    retStr = rtrim(retStr);
    return retStr;
}


// 특장문자열을 정해진 문자열로 변경
function replaceStr( str, oldstr, newstr )
{	
	var index = 1;
	var temp = String(str);
	while( index > 0 )
	{
		temp = temp.replace( oldstr, newstr );		
		index = temp.indexOf( oldstr );
	}

	return temp;
}

function replaceAll(originalString, findText, replaceText){

	var pos = 0;
	var preStr = "";
	var postStr = "";

	pos = originalString.indexOf(findText);
	//alert(pos);
	while (pos != -1) {
		preString = originalString.substr(0,pos);
		postString = originalString.substring(pos+findText.length);
		originalString = preString + replaceText + postString;
		pos = originalString.indexOf(findText);
	}
	
	return originalString;
}

 //상대 등록 요청 by 박세현 2009.05.28

function buddyAuthWindow(buddy_id, buddy_nm, owner_id, owner_nm,  groupIdx)
{
   
   var _id = owner_id.split("@");
   var user_id ="";

   if (_id[0] !=null) user_id = _id[0];

   var fromMessage ="안녕하세요?  '" + owner_nm +"' 입니다.  상대 등록을 요청 합니다.";
   var toMessage ="'" + buddy_nm + "("+ user_id + ")'님을 등록합니다.";
   var form = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        labelWidth: 370,
        defaultType: 'textfield',

        items: [{
            fieldLabel: toMessage,
            labelSeparator:'',
            name: 'to',
            anchor:'0%'
        }/*,{
            fieldLabel: "아래에 요청 메세지를 입력하고 '상대요청' 버튼을 클릭하세요.",
            labelSeparator:'',
            name: 'subject',
            anchor: '0%'
       }*/, {
            xtype: 'hidden',
            name: 'buddy_id',
            value : buddy_id
       }, {
            xtype: 'hidden',
            name: 'owner_id',
            value : owner_id
       }, {
            xtype: 'hidden',
            name: 'owner_nm',
            value : owner_nm
       }, {
            xtype: 'hidden',
            name: 'groupIdx',
            value : groupIdx
       },{
            xtype: 'hidden',
            name: 'msg',
            value:fromMessage

        } /*{
            xtype: 'textarea',
            maxLength:62,
            hideLabel: true,
            name: 'msg',
            width:390,
            height:60,
            value:fromMessage

        }*/]
    });

    var window = new Ext.Window({
        title: '상대등록',
        width: 300,
        height:100,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        closeAction:'close',
        items: form,
       buttons: [{
            text: '확인',
             handler: function(){
                     buddyAuthSend(window, form);
                    }
        },{
            text: '취소',
             handler: function(){
                     window.destroy();
                    }
        }]
      });

    window.show();
}
