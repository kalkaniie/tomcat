
function setBuddyGroupHtml(groupArr, buddyListArr)
{
	
	var topItem = '';
	var itemListNode = parent.frames[0].$('msgList');	
	parent.frames[0].$('msgList').innerHTML = '';
	for(i = 0; i<groupArr.length; i++)
	{		
		
		topItem = parent.frames[0].document.createElement("div");
		topItem.className='cop';
		topItem.setAttribute('id', 'cop_'+groupArr[i][0]);
		
		var _html = "	<div class='copt'>"+groupArr[i][1]+"</div>"+	//�׷��
								"	<div id='grouplist_'"+groupArr[i][0]+" class='copc'>";	//���׷췹�̾�
								
		var _subhtml = '';
		for(j=0; j<buddyListArr.length; j++)
		{
			if(buddyListArr[j][5] == groupArr[i][0])	
			{
				_subhtml = _subhtml + "<li id='buddy_"+buddyListArr[j][0]+"'>"+getStatusImage(buddyListArr[j][6],buddyListArr[j][8])+" <span id='buddy' style='cursor:hand;' onClick=\"javascript:js_openDialogue('"+buddyListArr[j][1]+"@"+buddyListArr[j][2]+"', '"+buddyListArr[j][4]+"');\">"+buddyListArr[j][4]+"</span></li>";	//���
			}
		}				
							
		_subhtml = "<ul class='copbg'>"+_subhtml+"</ul>";
		
		_html = _html + _subhtml + "</div>";
		//alert(_html);						
		topItem.innerHTML = _html;				
		itemListNode.appendChild(topItem);		
		
		parent.frames[0].js_spry('cop_'+groupArr[i][0]);	
		
	}
	
	
	
	/*var html ="<div id='cop_"+group_idx+" class='cop'>"+
							"	<div class='copt'>"+group_nm+"</div>"+
							"	<div class='copc'>"+
							"		<ul class='copbg'>"+
							"			<li><a href='#'><img src='/images/webbuddy/msg_boyBusiness.gif' /></a><span><a href='#'>ä����(aaaaaa)</a></span></li>"+ //�ٸ��빫��
							"			<li><a href='#'><img src='/images/webbuddy/msg_boyBusy.gif' /></a><span><a href='#'>ä��(aaaaaa)</a></span></li>"+				//�ٻ�
							"			<li><a href='#'><img src='/images/webbuddy/msg_boyOff.gif' /></a><span><a href='#'>ädd��(aaaaaa)</a></span></li>"+			//���v���
							"			<li><a href='#'><img src='/images/webbuddy/msg_girlBusy.gif' /></a><span><a href='#'>ä��(aaaaaa)</a></span></li>"+			//�ٻ�
							"			<li><a href='#'><img src='/images/webbuddy/msg_girlOn.gif' /></a><span><a href='#'>ä��(aaaaaa)</a></span></li>"+			  //�¶���
							"		</ul>"+
							"	</div>"+
							"</div>";
	
	return html;*/
}

/* UACONFIG��� d���� HTML�� ǥ���Ѵ�.
	uaconfArr[0] : �̸�
	uaconfArr[1] : ��ȭ��
	uaconfArr[2] : �ڵ����ȣ
*/


function setUAConfigHTML(uaconfArr)
{
	parent.frames[0].$('displayname').innerText= uaconfArr[1];
}

function updateBuddyStatusHTML(buddyid, s_code)
{	
	try
	{
		var cnt = parent.frames[0].document.all['statusimg_'+buddyid].length;
		
		if(cnt != null)
		{
			for(i=0;i<parent.frames[0].document.all['statusimg_'+buddyid].length;i++)
			{
				parent.frames[0].document.all['statusimg_'+buddyid][i].src = getStatusImageSrc(s_code);
				parent.frames[0].document.all['statusimg_'+buddyid][i].name = 'statusimg_'+buddyid;
			}
		} else
		{			
			try
			{				
				parent.frames[0].document['statusimg_'+buddyid].src = getStatusImageSrc(s_code);
				parent.frames[0].document['statusimg_'+buddyid].name = 'statusimg_'+buddyid;
			} catch(e)
			{
				parent.frames[0].document['statusimg_'+buddyid].src = getStatusImageSrc(-1);
				parent.frames[0].document['statusimg_'+buddyid].name = 'statusimg_'+buddyid;
			}
		}
	} catch(e)
	{
	}
}


function getStatusImage(s_code, buddyid)
{
	var path = "/images/webbuddy/";
	var _image = '';
	switch(parseInt(s_code))	
	{
		case -4 :	_image = "msg_boyOff.gif"; break;	//���v�����ô. 
		case -3 :	_image = ".gif"; break;	// �ް���
		case -2 :	_image = ".gif"; break;	//ģ���� �ƴ� ���¸� �˼��� �����.
		case -1 :	_image = "msg_boyOff.gif"; break;	//���v���. 
		case 0 :	_image = "msg_girlOn.gif"; break;	// �����
		case 1 :	_image = ".gif"; break;	// �ڸ����
		case 2 :	_image = "msg_boyBusy.gif"; break;	// ��ݹٻ�, ���� �ٸ��빫��
		case 3 :	_image = ".gif"; break;	// ������
		case 4 :	_image = ".gif"; break;	// ��ȭ��
		case 5 :	_image = ".gif"; break;	// �Ļ���
		case 6 :	_image = ".gif"; break;	// ȸ����
		case 7 :	_image = ".gif"; break;	//���� ��=
		case 8 :	_image = ".gif"; break;	// ����� d�� ����.
		default : _image = "msg_boyOff.gif"; break;	//���v���. 
	}
	//alert("<img src='"+path+_image+"' name='statusimg_"+buddyid+"'>");
	return ("<img src='"+path+_image+"' name='statusimg_"+buddyid+"'>");
	
}

function getStatusImageSrc(s_code)
{
	var path = "/images/webbuddy/";
	var _image = '';
	switch(parseInt(s_code))	
	{
		case -4 :	_image = "msg_boyOff.gif"; break;	//���v�����ô. 
		case -3 :	_image = ".gif"; break;	// �ް���
		case -2 :	_image = ".gif"; break;	//ģ���� �ƴ� ���¸� �˼��� �����.
		case -1 :	_image = "msg_boyOff.gif"; break;	//���v���. 
		case 0 :	_image = "msg_girlOn.gif"; break;	// �����
		case 1 :	_image = ".gif"; break;	// �ڸ����
		case 2 :	_image = "msg_boyBusy.gif"; break;	// ��ݹٻ�, ���� �ٸ��빫��
		case 3 :	_image = ".gif"; break;	// ������
		case 4 :	_image = ".gif"; break;	// ��ȭ��
		case 5 :	_image = ".gif"; break;	// �Ļ���
		case 6 :	_image = ".gif"; break;	// ȸ����
		case 7 :	_image = ".gif"; break;	//���� ��=
		case 8 :	_image = ".gif"; break;	// ����� d�� ����.
		default : _image = "msg_boyOff.gif"; break;	//���v���. 
	}
	//alert("<img src='"+path+_image+"' id='statusimg_"+buddyid+"'>");
	return (path+_image);
	
}


var count = 0;
/* ���µ� ��ȭâ; ���ϴ� �迭*/
var dialogueArray = new Array();

/* 
	���µ� ��ȭâ�鿡 ���ԵǾ� �ִ� ������ ���̵�d��
	key : ��ȭâ���̵�
	value : ,�� ���ӵǴ� ���̵�
*/
var dialogueHash = new Hash();

/* ���µ� �˾� ��ȭâ; ���ϴ� �迭*/
var openPopDialArray = new Array();

/*
	��ȭâ; �׸���.
*/
function makeDialogue(dialogueID, buddyName, buddyID)
{
	
	var newItem = parent.frames[0].document.createElement("div");
  newItem.className="msgWdw";
  newItem.setAttribute("id", 'mlMsg_window_'+dialogueID);  
  newItem.style.marginTop=10;  
	
  var _html = "<div><h2><img src='/images/webbuddy/msg_girlOn.gif' class='msgWico' name='mlMsg_window_icon_"+dialogueID+"' />"+buddyName+"�԰��� ��ȭ<img src='/images/btn/btnB_mlClose.gif' onClick=\"javascript:js_close_dialogue('"+dialogueID+"');\" class='btnAct'/><img src='/images/btn/btnB_mlReduce.gif' class='btnAct' onClick=\"javascript:js_switch_dialogue1('"+dialogueID+"');\"></h2></div>\n"+
  						"<div id='mlMsg_window_cntnt_"+dialogueID+"' class='msgWdw_cntnt'></div>"+
							"<div class='msgWdw_entry' id='mlMsg_window_text_"+dialogueID+"'><form name='msg_form_"+dialogueID+"' method='post'><textarea name='msg_"+dialogueID+"' style='width:210;height:25; border-top: 1px solid #d9d9d9; border-bottom: 1px solid #d9d9d9;padding: 5px; margin:5px 0 0 0;'  onKeyDown=\"javascript:js_sendmsg('"+dialogueID+"', '"+buddyID+"');\"></textarea></form></div>\n"+
							"<div class='msgWdw_opt' id='mlMsg_window_opt_"+dialogueID+"'><span onclick=''>�ɼ�</span><a href=\"javascript:js_open_win('"+dialogueID+"');\">â ȭ���8��</a><img src='/images/box/msgBox_corner.gif'/></div>\n";							
	
	
  newItem.innerHTML = _html;
  newItem.style.display='block';  
  var itemListNode = parent.frames[0].$('mlMsg_window_main');
    
  dialogueArray[count] = 'mlMsg_window_'+dialogueID;
  var currHashVal = dialogueHash.get(dialogueID);
  if(currHashVal == null)
  {
  	dialogueHash.set(dialogueID, buddyID);
  } else
  {
  	dialogueHash.set(dialogueID, currHashVal + "," +buddyID);
  } 
    
  if(count == 0)
  {
  	itemListNode.appendChild(newItem); 	  	
  } else
  {		  	
  	itemListNode.insertBefore(newItem,  parent.frames[0].$(dialogueArray[count-1]));  	
  }	 
  
  count++;
  
  //alert(dialogueHash.get(dialogueID));
}



function js_switch_dialogue_main(dialogueID)
{
	var _diplay = parent.frames[0].$('mlMsg_window_'+dialogueID).style.display;	
	//alert(_diplay);
	if( _diplay == 'none')
	{
		
		parent.frames[0].$('mlMsg_window_'+dialogueID).show();
		parent.frames[0].$('mlMsg_window_'+dialogueID).style.display = 'block';
		
		js_switch_dialogue1(dialogueID);
		
	} /*else
	{
		js_switch_dialogue(dialogueID);
	}*/
}

function test(args)
{
	alert(args);	
}

/* ��ȭâ �ּ�ȭ �Ǵ� �ִ�ȭ
* @param args : ��ȭâ���̵�
*/
function js_switch_dialogue1(dialogueID)
{		
	var _diplay = parent.frames[0].$('mlMsg_window_text_'+dialogueID).style.display;
	
	if( _diplay == '' || _diplay == 'block')
	{
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).hide();
		parent.frames[0].$('mlMsg_window_text_'+dialogueID).hide();
		parent.frames[0].$('mlMsg_window_opt_'+dialogueID).hide();
		
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).style.display = 'none';
		parent.frames[0].$('mlMsg_window_text_'+dialogueID).style.display = 'none';
		parent.frames[0].$('mlMsg_window_opt_'+dialogueID).style.display = 'none';
	} else
	{
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).show();
		parent.frames[0].$('mlMsg_window_text_'+dialogueID).show();
		parent.frames[0].$('mlMsg_window_opt_'+dialogueID).show();
		
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).style.display = 'block';
		parent.frames[0].$('mlMsg_window_text_'+dialogueID).style.display = 'block';
		parent.frames[0].$('mlMsg_window_opt_'+dialogueID).style.display = 'block';
		
	}
}

/* ��ȭâ �ּ�ȭ �Ǵ� �ִ�ȭ
* @param args : ��ȭâ���̵�
*/
function js_switch_dialogue2(dialogueID, visiable)
{	
	if(visiable == 'block')
	{
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).show();
		parent.frames[0].$('mlMsg_window_text_'+dialogueID).show();
		parent.frames[0].$('mlMsg_window_opt_'+dialogueID).show();
		
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).style.display = 'block';
		parent.frames[0].$('mlMsg_window_text_'+dialogueID).style.display = 'block';
		parent.frames[0].$('mlMsg_window_opt_'+dialogueID).style.display = 'block';
	} else
	{	
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).hide();
		parent.frames[0].$('mlMsg_window_text_'+dialogueID).hide();
		parent.frames[0].$('mlMsg_window_opt_'+dialogueID).hide();
		
		parent.frames[0].$('mlMsg_window_cntnt_'+dialogueID).style.display = 'none';
		parent.frames[0].$('mlMsg_window_text_'+dialogueID).style.display = 'none';
		parent.frames[0].$('mlMsg_window_opt_'+dialogueID).style.display = 'none';
	}
}


/* ��ȭâ; �ݴ´�(��f�� ������� �ʰ� ���)
* @param args : ��ȭâ���̵�
*/
function js_close_dialogue(dialogueID)
{	
	parent.frames[0].$('mlMsg_window_'+dialogueID).hide();
	parent.frames[0].$('mlMsg_window_'+dialogueID).style.display='none';
}

/* ��ȭâ; ���̾�� �˾�â8�� ��ȯ�Ѵ�.
* @param args : ��ȭâ���̵�
*/
function js_open_win(dialogueID)
{	
	var win = window.open('/jsp/kor/messenger/dialogue.jsp?id='+dialogueID, 'dialogue_'+dialogueID, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no, resizable=yes,copyhistory=no,width=300, height=500, left=100,top=100');	
	openPopDialArray.push(win);
	
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
	
	parent.frames[0].$('mlMsg_window_main').removeChild(parent.frames[0].$('mlMsg_window_'+dialogueID));
}





















/* ��ȭâ'ġ �ʱ�ȭ
*  : not use
*/
function init()
{
	parent.frames[0].$('mlMsg_window_main').style.top = 
		parseInt(parent.frames[0].document.body.clientHeight) - parseInt(parent.frames[0].$('mlMsg_window_main').offsetHeight)-250;
	//parent.frames[0].$('mlMsg_window_main').style.top = parent.frames[0].document.body.clientHeight - parent.frames[0].$('mlMsg_window_main').offsetHeight-127;
	//parent.frames[0].$('mlMsg_window_main').style.top = parent.frames[0].document.body.clientHeight - parent.frames[0].$('mlMsg_window_main').offsetHeight;
	parent.frames[0].$('mlMsg_window_main').style.left = parent.frames[0].document.body.clientWidth - parent.frames[0].$('mlMsg_window_main').offsetWidth-235;
}

/* ��ȭâ�� 'ġ�� ��´�.
*  : not use
*/
function setPosition()
{	
	try
	{
		if(count == 1)
		{			
			/*parent.frames[0].$('mlMsg_window_main').style.top = 
				parseInt(parent.frames[0].document.body.clientHeight) - parseInt(parent.frames[0].$('mlMsg_window_main').offsetHeight)-16;*/
				return;
		} else
		{
			parent.frames[0].$('mlMsg_window_main').style.top = 
				parseInt(parent.frames[0].document.body.clientHeight) - parseInt(parent.frames[0].$('mlMsg_window_main').offsetHeight);
		}			
			
		parent.frames[0].$('mlMsg_window_main').style.left = 
			parseInt(parent.frames[0].document.body.clientWidth)-parseInt(parent.frames[0].$('mlMsg_window_main').offsetWidth) - 12;
	} catch(e)
	{
	}
	
	
	/*if(parseInt($('mlMsg_window_main').style.top) <= 0)
	{
		$('mlMsg_window_main').style.top = document.body.clientHeight - $('mlMsg_window_main').offsetHeight + 110;
	}*/
	
}

/* ��ȭâ�� 'ġ�� �ֱ���8�� ��d�Ѵ�.
*  : not use
*/
function rePaint()
{	
	setPosition();
	window.setTimeout("rePaint();", 1000);
}

//rePaint();

try
{
	//parent.frames[0].$('mlMsg_window_main').style.maxHeight = parent.frames[0].document.body.clientHeight;
	//parent.frames[0].$('mlMsg_window_main').style.overflow = 'auto';
	//alert('sucess');
} catch(e)
{	
	//alert('failed');
}