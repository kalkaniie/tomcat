Ext.onReady(function(){
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    Ext.QuickTips.init();
    var xg = Ext.grid;
    function change(val){
        if(val > 0){
            return '<span style="color:green;">' + val + '</span>';
        }else if(val < 0){
            return '<span style="color:red;">' + val + '</span>';
        }
        return val;
    }
    var sm2 = new Ext.grid.CheckboxSelectionModel();
	
	var dataStore = new Ext.data.Store({
     // load using HTTP
     proxy: new Ext.data.HttpProxy({url: 'AA.xml'}),
 
     // the return will be XML, so lets set up a reader
     reader: new Ext.data.XmlReader({
          // records will have an "T4" tag
          record: 'T4',
          id: 'ID',
          totalRecords: "recCount"
     }, [
          // set up the fields mapping into the xml doc
          'vcFirstName', 'vcLastName', 'bIsAdministrator','bIsActive','tsDateLastLogin'
     ]),
     // turn on remote sorting
     remoteSort: true
});
dataStore.setDefaultSort('vcLastName', 'desc');
    
    var colModel = new Ext.grid.ColumnModel([
    	{id: 'fname',header: "First Name",dataIndex: 'vcFirstName',width: 120},
        {header: "Last Name",dataIndex: 'vcLastName',width: 120},
        {header: "Is Admin",dataIndex: 'bIsAdministrator',width: 40},
        {header: "Is Active",dataIndex: 'bIsActive',width: 40},
        {id: 'last',header: "Last Login",dataIndex: 'tsDateLastLogin',width: 150}
     ]);
// by default columns are sortable
 
colModel.defaultSortable = true;

	dataStore.load();
    var gridRelac2 = new Ext.grid.GridPanel({
        
        ds: dataStore,
        cm: colModel,
        stripeRows: true,
        //autoExpandColumn: 'company',
        height:350,
        width:600
        //title:'Array Grid'
        });
    gridRelac2.render('grid-target');
    
    var win2 = new Ext.Window({
    	id:'kebi_ext_window',
        el:'window-win1',
        layout:'fit',
        width:300,
        height:200,
        closeAction:'hide',
        iconCls: 'icon-grid',
        constrainHeader:true,
        shim:false,
        animCollapse:false,
        items : gridRelac2
    });
    win2.show();

});