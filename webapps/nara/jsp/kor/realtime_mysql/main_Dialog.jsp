<%@page language="java" contentType="text/html;charset=utf-8"%>

<script>

function js_openDialogue(args0, args1)
{		
	hidef.js_openDialogue(args0, args1);
}

function js_switch_dialogue1(id)
{	
	hidef.js_switch_dialogue1(id);
}

function js_close_dialogue(id)
{
	hidef.js_close_dialogue(id);
}

function js_repaint()
{
	hidef.rePaint();
}

function js_invite(id, sid, bm, rid, cid)
{
	hidef.js_invite(id, sid, bm, rid, cid);
}

function js_invite_arg(id, sid, bm, rid, st)
{
	hidef.js_invite_arg(id, sid, bm, rid, st);
}

function js_room_inter(id, sid, bm, rid, st)
{
	hidef.js_room_inter(id, sid, bm, rid, st);
}



</script>


<script>
    //new Draggable('mlMsg_window_main',{scroll:window,handle:'handle1',revert:function(element){return;}});
    //dialogueWindow.create('버디명');
</script>
<!--input type="button" value="로그아웃 TEST" onclick="hidef.js_testClose();" -->
