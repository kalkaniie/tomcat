Ext.BLANK_IMAGE_URL = '/js/tools/resources/images/default/s.gif';
var chkWriteTabOpen = true;	// 편지쓰기탭오픈여부
var tokenDelimiter = ':';	//history manager
Docs = {};
BrowserCheck();
var ApiPanel = function(){    

	ApiPanel.superclass.constructor.call(this, {
        id:'api-tree',
        region:'west',
        split:true,
        width: 210,
        minSize: 210,
        maxSize: 210,
        collapsible: true,
        margins:'0 0 0 0',
        cmargins:'0 0 0 0',
        rootVisible:false,
        lines:false,
        autoScroll:false,
        animCollapse:false,
        animate: false,
        collapseMode:'mini',
        autoLoad: {url: leftUrl	,scripts:true}
    });
};

Ext.extend(ApiPanel, Ext.Panel, {});

var DocPanel = Ext.extend(Ext.Panel, {
    closable: true,
    autoScroll:true,
	autoDestory:true,
    initComponent : function(){
    	
        var ps = this.cclass.split('.');
        this.title = ps[ps.length-1];
        DocPanel.superclass.initComponent.call(this);
    },
    scrollToMember : function(member){
        var el = Ext.fly(this.cclass + '-' + member);
        if(el){
            var top = (el.getOffsetsTo(this.body)[1]) + this.body.dom.scrollTop;
            this.body.scrollTo('top', top-25, {duration:.75, callback: this.hlMember.createDelegate(this, [member])});
        }
    },
	scrollToSection : function(id){
		var el = Ext.getDom(id);
		if(el){
			var top = (Ext.fly(el).getOffsetsTo(this.body)[1]) + this.body.dom.scrollTop;
			this.body.scrollTo('top', top-25, {duration:.5, callback: function(){
                Ext.fly(el).next('h2').pause(.2).highlight('#8DB2E3', {attr:'color'});
            }});
        }
	},
    hlMember : function(member){
        var el = Ext.fly(this.cclass + '-' + member);
        if(el){
            el.up('tr').highlight('#cadaf9');
        }
    }
});

var v_leftmenuUrl ="";
var MainPanel = function(v_uses_index_page){
	var v_title = "";
	var v_id = "";
	v_title ="마이페이지";
	v_id = "docs-마이페이지";
	v_leftmenuUrl = "/jsp/kor/menu/leftbase.jsp";
	
	MainPanel.superclass.constructor.call(this, {
        id:'doc-body',
        region:'center',
        margins:'0 5 0 0',
        resizeTabs: true,
        minTabWidth: 135,
        tabWidth: 135,
        enableTabScroll: true,
        activeTab: 0,
        frame:true,
        border:false,
        autoDestroy:true,
        items: {
            id:v_id,
            title: '마이페이지',
            frame:false,
            autoLoad: {url: contentUrl , scripts:true, scope: this},
            iconCls:'icon-docs',
            autoScroll:true
        }
    });
};
Ext.extend(MainPanel, Ext.ux.InlineToolbarTabPanel, {
    cls:'kebi_tab',
    frame:false,
    width :400,
    toolbar:{ width:60},
    deferredRender:false,
    layoutOnTabChange:true,
    initEvents : function(){
        MainPanel.superclass.initEvents.call(this);
        this.body.on('click', this.onClick, this);
    },
    onClick: function(e, target){
    },
    loadClass : function(href, cls, member){
    	var id = 'docs-' + cls;
        var tab = this.getComponent(id);
        this.deferredRender =false;
        this.layoutOnTabChange = true;
        if(tab){
            this.setActiveTab(tab);
            if(href.indexOf("webmail.auth.do?method=mail_list_view") ==0){
            	mainPanel.getActiveTab().body.load(href);
            } else if(href.indexOf("webmail.auth.do?method=mail_list&READ_MODE=NEW") ==0){
            	mainPanel.getActiveTab().body.load(href);
            } else if (href.indexOf("webmail.auth.do?method=mail_write") ==0) {
				if( tab.id.indexOf("docs-편지쓰기") != -1){
					var oForm = searchFormByActiveTab("form_mail_write");
					if(oForm != null){
						var uniqStr = oForm.uniqStr.value;
						oForm.m_content.value = Ext.getCmp("editor_m_content"+uniqStr).getValue();
						
						if( (oForm != null && oForm.M_TO != null && oForm.M_TO.value !="") || ( oForm.m_content != null && oForm.m_content.value !="")){
							var isValid = confirm("현재탭을 닫습니다.\n작성된 메일을 임시보관함에 보관하시겠습니까?");
	      					if(isValid){
	        					saveTempMail();
	      					}	
						}
					}	
					
				}            	
            	mainPanel.getActiveTab().body.load(href);
            } else if (href.indexOf("board.auth.do?method=board_main") ==0) {
             	left_board_space.left_board.goBoardMain(0);
            } else {
            	mainPanel.getActiveTab().body.load(href);
            }
            
            if(member){
                tab.scrollToMember(member);
            }
        }else{
        	var autoLoad = {url: href ,scripts:true};
            if(member){
                autoLoad.callback = function(){
                    Ext.getCmp(id).scrollToMember(member);
                }
            }
            var pp = Docs;
            var p = this.add(new DocPanel({
                id: id,
                frame :false,
                cclass : cls,
                autoScroll:true,
                border:false,
                autoLoad: autoLoad,
                iconCls: Docs.icons[cls]
            }));
            
            Ext.getCmp(id).doLayout();    
            this.setActiveTab(p);
        }
    },
    loadClassParams : function(href, params, cls, member){
      	var id = 'docs-' + cls;
        var tab = this.getComponent(id);
        this.deferredRender =false;
        this.layoutOnTabChange = true;
        
        if(tab){
            this.setActiveTab(tab);
            if(member){
                tab.scrollToMember(member);
            }
        }else{
            var autoLoad={
            	url:href,
            	scripts:true,
            	scope: this,
            	params : Ext.urlDecode(params)
            	};
            if(member){
                autoLoad.callback = function(){
                    Ext.getCmp(id).scrollToMember(member);
                }
            }
            var pp = Docs;
            var p = this.add(new DocPanel({
                id: id,
                frame :false,
                cclass : cls,
                autoScroll:true,
                autoLoad: autoLoad
                , iconCls: Docs.icons[cls]
            }));
            
            this.setActiveTab(p);
        }
    },
    listeners: {
       'activate': function(){
        	this.doLayout();
		},
		'tabchange': function(tabPanel, tab){
                    var pp = tabPanel;
                    Ext.History.add(tabPanel.id + tokenDelimiter + tab.id+ tokenDelimiter+ tab.autoLoad.url.substring(0,20));
        },
      	beforetabchange: function(tabs, newTab, prevTab ){
      	  	var changeLeftUrl;
          	var newIdx = -1;
          	var prevIdx = -1;
          	if(newTab.id =="docs-게시판") { changeLeftUrl = "/jsp/kor/menu/leftboard.jsp"; newIdx = 1; myBoxClean();}
			else if(newTab.id =="docs-인트라넷") { changeLeftUrl = "/jsp/kor/menu/leftintranet.jsp"; newIdx = 2; myBoxClean();}
			else if(newTab.id =="docs-일정")   { changeLeftUrl = "/jsp/kor/menu/leftschedule.jsp"; newIdx = 3; myBoxClean();}
			else if(newTab.id =="docs-sms")   { changeLeftUrl = "/jsp/kor/menu/leftbase.jsp"; newIdx = 4; myBoxClean();}
			else if(newTab.id =="docs-주소록") { changeLeftUrl = "/jsp/kor/menu/leftbase.jsp"; newIdx = 5; myBoxClean();}
			else if(newTab.id =="docs-파일관리") { changeLeftUrl = "/jsp/kor/menu/leftbase.jsp"; newIdx = 6; myBoxClean();}
			else if(newTab.id =="docs-쪽지") { changeLeftUrl = "/jsp/kor/menu/leftnote.jsp"; newIdx = 7; myBoxClean();}
			else if(newTab.id =="docs-카드") { changeLeftUrl = "/jsp/kor/menu/leftecard.jsp"; newIdx = 8; myBoxClean();}
			else {
					if(newTab.id =="first_page" && v_leftmenuUrl!=null 
						&& v_leftmenuUrl !=''
						&&  v_leftmenuUrl !="undefined"
						) 
						changeLeftUrl = v_leftmenuUrl ;
					else			
						changeLeftUrl = "/jsp/kor/menu/leftbase.jsp";
						
					newIdx = 9;
					
				  }
			
			if (prevTab != null) {
				if(prevTab.id =="docs-게시판"){prevIdx = 1; }
				else if(prevTab.id =="docs-인트라넷"){prevIdx = 2; }
				else if(prevTab.id =="docs-일정"){prevIdx = 3; }
				else if(prevTab.id =="docs-sms"){prevIdx = 4; }
				else if(prevTab.id =="docs-주소록"){prevIdx = 5; }
				else if(prevTab.id =="docs-파일관리"){prevIdx = 6; }
				else if(prevTab.id =="docs-쪽지"){prevIdx = 7; }
				else if(prevTab.id =="docs-카드"){prevIdx = 8; }
				else {prevIdx = 9;}
			}
			
			if (prevTab != null && prevIdx != newIdx) {
				api.getUpdater().update(changeLeftUrl);
			}
			setFooterMessageNull();
	   },beforeremove: function(tabs , thisTab){
	   	if (thisTab.id != null) {
				if ( thisTab.id.indexOf("docs-편지쓰기") != -1
                   ||thisTab.id.indexOf("docs-답장:") != -1
                   ||thisTab.id.indexOf("docs-전체답장:") != -1
                   ||thisTab.id.indexOf("docs-전달:") != -1) {
					this.setActiveTab(thisTab);
					var oForm = searchFormByActiveTab("form_mail_write");
					if(oForm != null && chkWriteTabOpen == true){
						var uniqStr = oForm.uniqStr.value;
						oForm.m_content.value = Ext.getCmp("editor_m_content"+uniqStr).getValue();
						if( (oForm != null && oForm.M_TO != null && oForm.M_TO.value !="") || ( oForm.m_content != null && oForm.m_content.value !="")){
							var isValid = confirm("현재탭을 닫습니다.\n작성된 메일을 임시보관함에 보관하시겠습니까?");
	      					if(isValid){
	        					saveTempMail();
	      					}	
						}
					}
					chkWriteTabOpen=true;
					
				}
			}
	   },
	   beforetabclose: function(tabs, newTab, prevTab ){
          	var changeLeftUrl;
          	var newIdx = -1;
          	var prevIdx = -1;
          	if(newTab.id =="docs-게시판") { changeLeftUrl = "/jsp/kor/menu/leftboard.jsp"; newIdx = 1; }
			else if(newTab.id =="docs-인트라넷") { changeLeftUrl = "/jsp/kor/menu/leftintranet.jsp"; newIdx = 2; }
			else if(newTab.id =="docs-일정")   { changeLeftUrl = "/jsp/kor/menu/leftschedule.jsp"; newIdx = 3; }
			else if(newTab.id =="docs-sms")   { changeLeftUrl = "/jsp/kor/menu/leftbase.jsp"; newIdx = 4; }
			else if(newTab.id =="docs-주소록") { changeLeftUrl = "/jsp/kor/menu/leftbase.jsp"; newIdx = 5; }
			else if(newTab.id =="docs-파일관리") { changeLeftUrl = "/jsp/kor/menu/leftbase.jsp"; newIdx = 6; }
			else if(newTab.id =="docs-쪽지") { changeLeftUrl = "/jsp/kor/menu/leftnote.jsp"; newIdx = 7; }
			else if(newTab.id =="docs-카드") { changeLeftUrl = "/jsp/kor/menu/leftecard.jsp"; newIdx = 8; }
			else { changeLeftUrl = "/jsp/kor/menu/leftbase.jsp"; newIdx = 9; }
			
			if (prevTab != null) {
				if(prevTab.id =="docs-게시판"){prevIdx = 1; }
				else if(prevTab.id =="docs-인트라넷"){prevIdx = 2; }
				else if(prevTab.id =="docs-일정"){prevIdx = 3; }
				else if(prevTab.id =="docs-sms"){prevIdx = 4; }
				else if(prevTab.id =="docs-주소록"){prevIdx = 5; }
				else if(prevTab.id =="docs-파일관리"){prevIdx = 6; }
				else if(prevTab.id =="docs-쪽지"){prevIdx = 7; }
				else if(prevTab.id =="docs-카드"){prevIdx = 8; }
				else {prevIdx = 9;}
			} 
			
			if (prevTab != null && prevIdx != newIdx) {
				api.getUpdater().update(changeLeftUrl);
			}
			setFooterMessageNull();
	   }
    }
});
var api ;
var mainPanel;
Ext.onReady(function(){
    Ext.QuickTips.init();
    api = new ApiPanel();
    mainPanel = new MainPanel(USERS_INDEX_PAGE);
    var kebi_header = new Ext.Panel({
        border: false,
        layout:'anchor',
        region:'north',
        height:68,
		margins:'0',
        items: [{
            xtype:'box',
            el:'kebi_header',
            border:false,
            anchor: 'none -25'
        }]
    })

    var kebi_footer = new Ext.Panel({
        border: false,
        layout:'anchor',
        region:'south',
        height:28,
        items: [{
            xtype:'box',
            el:'kebi_footer',
            border:false
        }]
    })
    
    var viewport = new Ext.Viewport({
        layout:'border', 
        items:[kebi_header, api, mainPanel,kebi_footer]
    });
    viewport.doLayout();
	
    Ext.History.init();
    Ext.History.on('change', function(token){
        if(token){
            var parts = token.split(tokenDelimiter);
            var tabPanel = Ext.getCmp(parts[0]);
            var tabId = parts[1];
            var tabUrl = parts[2];
            tabPanel.show();
            tabPanel.setActiveTab(tabId);
			var curUrl = api.getUpdater().defaultUrl;
			
            if(tabUrl.indexOf("board.auth.do") != -1 && curUrl.indexOf("leftboard") !=-1 ){ api.getUpdater().update("/jsp/kor/menu/leftboard.jsp")}
			else if(tabUrl.indexOf("intranet.auth.do") != -1 && curUrl.indexOf("leftintranet") !=-1){ api.getUpdater().update("/jsp/kor/menu/leftintranet.jsp")}
			else if(tabUrl.indexOf("schedule.auth.do") != -1 && curUrl.indexOf("leftschedule") !=-1){ api.getUpdater().update("/jsp/kor/menu/leftschedule.jsp")}
			else if(tabUrl.indexOf("note.auth.do") != -1 && curUrl.indexOf("leftnote") !=-1){ api.getUpdater().update("/jsp/kor/menu/leftnote.jsp")}
			else if(curUrl.indexOf("leftbase") ==-1){ api.getUpdater().update("/jsp/kor/menu/leftbase.jsp")}
        }else{
            mainPanel.setActiveTab(0);
//            mainPanel.getItem(0).setActiveTab(0);
        }
    });
    
	
	setTimeout(function(){
        Ext.get('loading').remove();
        Ext.get('loading-mask').fadeOut({remove:true});
    }, 100);
});


