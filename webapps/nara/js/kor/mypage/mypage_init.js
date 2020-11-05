DSR.Home.Portal = Ext.extend(Ext.ux.Portal, {
    id:'home-portal',
    stateful: true,
    region:'center',
    initComponent: function() {
    	this.items = [{columnWidth:.49},{columnWidth:.49}];
        DSR.Home.Portal.superclass.initComponent.apply(this, arguments);
    }
});
Ext.reg('home-portal', DSR.Home.Portal);

DSR.Home.Main = Ext.extend(Ext.Panel, {
    id: 'home-main',
    layout:'fit',
    width: Ext.get(document.getElementById("doc-body")).getWidth()-90,		
    height :Ext.get(document.getElementById("doc-body")).getHeight()-70,
    bodyStyle:'background:white',
    frame:true,
    cls:'x-portlet',
    initComponent: function() {
        this.items = [{xtype: 'home-portal'}];
        DSR.Home.Main.superclass.initComponent.apply(this, arguments);
    }
});
Ext.reg('home-main', DSR.Home.Main);

Ext.onReady(function() { 
  	var stateProvider = new Ext.state.CookieProvider({ expires: new Date(new Date().getTime()+(1000*60*60*24*365)) });
	Ext.state.Manager.setProvider(stateProvider);
	
	try{
    setTimeout(function(){
	    DSR.Panel = new Ext.Panel({layout: 'fit', items: [{xtype: 'home-main'}], renderTo: 'centerid'});
    	Ext.EventManager.onWindowResize(function(){Ext.getCmp('home-main').setWidth(Ext.get(document.getElementById("doc-body")).getWidth())}, Ext.getCmp('home-main'), true);		
   		Ext.EventManager.onWindowResize(function(){Ext.getCmp('home-main').setHeight(Ext.get(document.getElementById("doc-body")).getHeight()-70)}, Ext.getCmp('home-main'), true);
   		var portal = Ext.getCmp('home-portal');
   		var ss = portal.getState();
   		if(ss ==","){
        	//var content_arr = ["mypageMailGrid","mypageGoodJobGrid","mypageNewsLetterGrid","mypageWeatherPanel"];
        	//var content_arr = ["mypageMailGrid","mypageMailGridOut","mypageMailGridTemp","mypageBbsGrid","mypageMemo","myPageInfo","mypageWeatherPanel"];
        	var content_arr = ["mypageMailGrid","mypageBbsGrid","mypageMemo","myPageInfo","mypageWeatherPanel"];
			for (var i = 0; i < content_arr.length; i++) {
        		if (i%2 == 0) {
        			portal.items.items[0].add({xtype: content_arr[i]});
        		} else if (i%2 == 1) {
        			portal.items.items[1].add({xtype: content_arr[i]});
        		}
        	}
        	portal.doLayout();
   		}
			
    }, 100);
	}catch(e){}
    
});

function addContent(){
var addContentPanel = new Ext.Panel({width:200,height:270,autoLoad: {url: '/jsp/kor/user/myContent.jsp', scripts:true, scope: this}}); 
var	addContent = new Ext.Window({id:'addContent',title:'미리보기 포틀릿 추가',colsable:true,width:200,height:273,layout:'fit',autoShow:true,modal:true,autoDestroy:true,items:addContentPanel});
addContent.show();
}	