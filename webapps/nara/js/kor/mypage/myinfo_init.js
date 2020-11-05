DSR.MypageMyInfoPanelPlugin = Ext.extend(Ext.Panel, {
	plugins: Ext.ux.PortletPlugin,
    title:'DISK 사용량',
    closeable: true,
    height:230,
    tools:weatherTool,
    bodyStyle:'background:white',
    autoLoad: {url: 'mbox.auth.do?method=manager2'	,scripts:true}
    });	
Ext.reg('myPageInfo', DSR.MypageMyInfoPanelPlugin);
DSR.MypageDaumPanelPlugin = Ext.extend(Ext.Panel, {
	plugins: Ext.ux.PortletPlugin,
    title:'위젯',
    closeable: true,
    height:330,
    frame:'true',
    tools:weatherTool,
    bodyStyle:'background:white',
    autoLoad: {url: '/jsp/kor/rss/daum-widget.jsp',scripts:true}
    });	
Ext.reg('myPageDaum', DSR.MypageDaumPanelPlugin);