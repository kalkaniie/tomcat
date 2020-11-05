Ext.BLANK_IMAGE_URL = '/js/ext/resources/images/default/s.gif';
Docs = {};
var isMailSend = false;					// 메일 임시보관 여부
var v_leftmenuUrl ="";
BrowserCheck();
var panel_body_style="padding-right:10px; overflow-y:auto;";
if(isIE6 || isIE7) panel_body_style="padding-right:20px; overflow-y:auto;";	//ie7 panel properties
var MainPanel = function(v_uses_index_page){
	var v_title = "";
	var v_id = "";
	v_title ="마이페이지";
	v_id = "docs-마이페이지";
	v_leftmenuUrl = "/jsp_std/kor/menu/leftbase.jsp";
	MainPanel.superclass.constructor.call(this, {
        id:'doc-body',
        region:'center',
        margins:'0 0 0 0',
        bodyStyle : panel_body_style,
        frame:false,
        border:false,
        autoDestroy:true
        ,autoLoad: {url: contentUrl , scripts:true, scope: this}
    });
};

Ext.extend(MainPanel, Ext.Panel, {});

var api;
var mainPanel;
var kebi_header;
Ext.onReady(function(){
    Ext.QuickTips.init();
    mainPanel = new MainPanel(USERS_INDEX_PAGE);
    api = new Ext.Panel ({
        id:'api-tree',
        region:'west',
        width:190,
        minSize:190,
        maxSize:190,
        margins:'0 10 5 0',
        autoScroll:false,
        animCollapse:false,
        frame:false,
        border:false,
        ref: 'kebi_viewport'
        ,autoLoad:{url:leftUrl,scripts:true,scope: this}
    });

    kebi_header = new Ext.Panel({
        border: false,
        layout:'anchor',
        region:'north',
        height:68
        ,autoLoad: {url: "/jsp_std/kor/common/header.jsp" , scripts:true, scope: this}
        //,items: [{xtype:'box',el:'kebi_header',border:false,anchor:'none -25'}]
    })

//    var kebi_footer = new Ext.Panel({
//        border: false,
//        layout:'anchor',
//        region:'south',
//        height:23,
//        items: [{xtype:'box',el:'kebi_footer',border:false}]
//    })
    
    var viewport = new Ext.Viewport({renderTo:Ext.getBody(),id:'kebi_viewport',layout:'border',style:'background:#FFFFFF',items:[kebi_header,api,mainPanel]});
    viewport.doLayout();
    viewport.syncSize();
    if(Ext.isIE || Ext.isGecko){
    	Ext.History.init();
    	var tokenDelimiter = ':';
		mainPanel.getUpdater().on("update", function(){
			var npageQryStr = "";
   			try{
   				if(mainPanel.getUpdater().defaultUrl.indexOf("nPage") == -1){
   					var objF = searchForm("form_mail_list");
   					npageQryStr ="&MBOX_IDX="+objF.MBOX_IDX.value+"&VIEW_TYPE="+objF.VIEW_TYPE.value+"&nPage="+objF.nPage.value;
   					mainPanel.getUpdater().defaultUrl = mainPanel.getUpdater().defaultUrl+npageQryStr;
   				}	
   			}catch(e){}
			
			Ext.History.add("mainPanel"+tokenDelimiter + mainPanel.getUpdater().defaultUrl);
			try{document.getElementById("kebi_footer_message").innerHTML="";}catch(e){}
			
		});
		
		mainPanel.getUpdater().on("beforeupdate", function(){
			try{
				if( document.getElementById("board_detail_iframe") != null){
				 	document.getElementById("board_detail_iframe").style.visibility="hidden";
				}
				
			}catch(e){}
			if( mainPanel.getUpdater().defaultUrl != null 
				&& mainPanel.getUpdater().defaultUrl.indexOf("webmail.auth.do?method=mail_write") ==0
				&& isMailSend == false){
				var oForm = searchFormByActiveTab("form_mail_write");
				if(oForm != null){
					var uniqStr = oForm.uniqStr.value;
					oForm.m_content.value = eval("iframe_editor"+uniqStr).Editor.getContent() == "<P>&nbsp;</P>" ? "" : eval("iframe_editor"+uniqStr).Editor.getContent();
					if( (oForm != null && oForm.M_TO != null && oForm.M_TO.value !="") || ( oForm.m_content != null && oForm.m_content.value !="")){
						var isValid = confirm("편지쓰기 페이지를  닫습니다.\n작성된 메일을 임시보관함에 보관하시겠습니까?");
      					if(isValid){
        					saveTempMail();
      					}	
					}
				}	
			}
		});
		
		Ext.History.fireEvent('change', Ext.History.getToken());
	    Ext.History.on('change', function(token){
	        if(token){
	            var parts = token.split(tokenDelimiter);
	            var panel = Ext.getCmp(parts[0]);
	            var panelUrl = parts[1];
	            if(panelUrl != mainPanel.getUpdater().defaultUrl){
	            	mainPanel.getUpdater().update(panelUrl)
	            }
				var curUrl = api.getUpdater().defaultUrl;
				if(panelUrl.indexOf("board.auth.do") != -1 && curUrl.indexOf("leftboard") ==-1 && curUrl.indexOf("leftintranet") ==-1){ api.getUpdater().update("/jsp_std/kor/menu/leftboard.jsp")}
				else if(panelUrl.indexOf("intranet.auth.do") != -1 && curUrl.indexOf("leftintranet") ==-1 && curUrl.indexOf("leftboard") ==-1){ api.getUpdater().update("/jsp_std/kor/menu/leftintranet.jsp")}
				else if(panelUrl.indexOf("schedule.auth.do") != -1 && curUrl.indexOf("leftschedule") ==-1){ api.getUpdater().update("/jsp_std/kor/menu/leftschedule.jsp")}
				else if(panelUrl.indexOf("note.auth.do") != -1 && curUrl.indexOf("leftnote") ==-1){ api.getUpdater().update("/jsp_std/kor/menu/leftnote.jsp")}
			}
	    });
	}    
    
	setTimeout(function(){
        Ext.get('loading').remove();
        Ext.get('loading-mask').fadeOut({remove:true});
    }, 50);
});