Ext.ux.PortletPlugin = {
    AUTO_IDs : {},
    init: function(panel) {
        if (!this.AUTO_IDs[panel.xtype])
            this.AUTO_IDs[panel.xtype] = 0;
        if (panel.id.substring(0, 8) == 'ext-comp')
            panel.id = panel.xtype + '-' + (++this.AUTO_IDs[panel.xtype]);
        else if (panel.id.substring(0, panel.xtype.length) == panel.xtype)
            this.AUTO_IDs[panel.xtype] = Math.max(this.AUTO_IDs[panel.xtype], parseInt(panel.id.substr(panel.xtype.length+1)) + 1);
        Ext.apply(panel, {
            anchor: '100%',
            frame:true,
            draggable: {ddGroup:'portal'},
            hideBorders:true,
            cls:'x-portlet'
        });
        Ext.applyIf(panel, {
            collapsible:true,
            settings: false,
            settingHandler: Ext.emptyFn,
            closeable: true,
            tools: []
        });
//        if (panel.closeable)
//            panel.tools.push({
//                id:'close',
//                handler: function(e, target, panel){
//                    panel.ownerCt.remove(panel, true);
//                }
//            });
        panel.on('expand', function() {
            panel.initialConfig.collapsed = false;
            panel.ownerCt.ownerCt.saveState();
            panel.ownerCt.ownerCt.doLayout();
        });
        panel.on.defer(50, panel, ['collapse', function() {
            panel.initialConfig.collapsed = true;
            panel.ownerCt.ownerCt.saveState();
            panel.ownerCt.ownerCt.doLayout();
        }]);
        if (panel.resizeable)
        {
            
            panel.on('render', function() {
                panel.resizer = new Ext.Resizable(panel.el, {handles: 's', minHeight: 100, maxHeight:800, pinned: true});
                if (Ext.version < 2.2)
                {
                    panel.resizer.proxy.remove();
                    panel.resizer.proxy.appendTo(Ext.getBody());
                }
                panel.resizer.on('resize', function(resizer, width, height, e) {
                    panel.setSize(width, height);
                    panel.initialConfig.height = height;
                    panel.ownerCt.ownerCt.saveState();
                });
            });
        }
    }
};
var mailTool = [{id:"right",handler: function(){ goLeftAndRightDivRender('webmail.auth.do?method=mail_list&MBOX_TYPE=1','받은편지함','mail')}},{id:'close',handler: function(e, target, panel){panel.ownerCt.remove(panel, true);}}];
var mailTool2 = [{id:"right",handler: function(){ goLeftAndRightDivRender('webmail.auth.do?method=mail_list&MBOX_TYPE=2','보낸편지함','mail')}},{id:'close',handler: function(e, target, panel){panel.ownerCt.remove(panel, true);}}];
var mailTool3 = [{id:"right",handler: function(){ goLeftAndRightDivRender('webmail.auth.do?method=mail_list&MBOX_TYPE=4','임시보관함','mail')}},{id:'close',handler: function(e, target, panel){panel.ownerCt.remove(panel, true);}}];
var bbsTool = [{id:"right",handler: function(){ goLeftAndRightDivRender('board.auth.do?method=board_main','게시판','bbs')}},{id:'close',handler: function(e, target, panel){panel.ownerCt.remove(panel, true);}}];
var noteTool = [{id:"right",handler: function(){ goLeftAndRightDivRender('note.auth.do?method=showMain','쪽지','note')}},{id:'close',handler: function(e, target, panel){panel.ownerCt.remove(panel, true);}}];
var pollTool = [{id:'close',handler: function(e, target, panel){panel.ownerCt.remove(panel, true);}}];
var weatherTool = [{id:'close',handler: function(e, target, panel){panel.ownerCt.remove(panel, true);}}];
var schedualTool = [{id:"right",handler: function(){ goLeftAndRightDivRender('schedule.auth.do?method=schedule_view','일정','schedule')}},{id:'close',handler: function(e, target, panel){panel.ownerCt.remove(panel, true);}}];