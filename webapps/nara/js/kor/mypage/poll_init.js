var mypage_poll_panel;
DSR.MypagePollPanelPlugin = Ext.extend(Ext.Panel, {
	plugins: Ext.ux.PortletPlugin,
    title:'설문',
    closeable: true,
    height:240,
    tools:pollTool,
    scripts:true,
    initComponent : function() {
    	mypage_poll_panel = this;
    	DSR.MypagePollPanelPlugin.superclass.initComponent.apply(this, arguments);
    },
	autoLoad:{
		url:'poll.auth.do',
		params:{method:'proceed_poll'},
		scripts:true
	}
});
Ext.reg('mypagePollGrid', DSR.MypagePollPanelPlugin);

function myPollVote(objForm) {
	var selectedChk = false;
	var item_num;
	
	for(var i=0; i<objForm.POLL_ITEM_NUM.length; i++) {
		if (objForm.POLL_ITEM_NUM[i].checked) {
			selectedChk = true;
			item_num = objForm.POLL_ITEM_NUM[i].value;
		}
	}
	if (!selectedChk) {
		alert("설문항목을 선택하세요.");
		return;
	}
	
	mypage_poll_panel.load({
		url:'poll.auth.do',
		params:{
			method:'vote',
			POLL_IDX:objForm.POLL_IDX.value,
			POLL_ITEM_NUM:item_num
		},
		scripts:true
	});
}