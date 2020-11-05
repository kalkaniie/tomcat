/*!
 * Ext JS Library 3.1.1
 * Copyright(c) 2006-2010 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.chart.Chart.CHART_URL = '../../resources/charts.swf';
var store;
var kk;
Ext.onReady(function(){

	store = new Ext.data.Store({
        proxy: new Ext.data.HttpProxy({
	     		url: '/ext/examples/chart/sheldon.xml',
	     		method: 'POST'
	     	}),

        reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Item',
	        	id: 'name',
	        	totalRecords: 'recCount'
		  	}, 
		  	 ['name', {name:'visits',type:'float'}, {name:'views',type:'float'},{name:'visits2',type:'float'} ]),
		  	remoteSort: true
           
    });
   
   
//    var store = new Ext.data.JsonStore({
//        fields:['name', 'visits', 'views'],
//        data: [
//            {name:'Jul 07', visits: 245000, views: 3000000},
//            {name:'Aug 07', visits: 240000, views: 3500000},
//            {name:'Sep 07', visits: 355000, views: 4000000},
//            {name:'Oct 07', visits: 375000, views: 4200000},
//            {name:'Nov 07', visits: 490000, views: 4500000},
//            {name:'Dec 07', visits: 495000, views: 5800000},
//            {name:'Jan 08', visits: 520000, views: 6000000},
//            {name:'Feb 08', visits: 620000, views: 7500000}
//        ]
//    });

    // extra extra simple
   kk=  new Ext.Panel({
        title: 'ExtJS.com Visits Trend, 2007/2008 (No styling)',
        renderTo: 'container',
        id:'kk',
        width:500,
        height:300,
        layout:'fit',
        items: {
            xtype: 'linechart',
            store: store,
            id:'ssss',
            xField: 'name',
            yField: 'visits',
			listeners: {
				itemclick: function(o){
					var rec = store.getAt(o.index);
					Ext.example.msg('Item Selected', 'You chose {0}.', rec.get('name'));
				}
			}
        }
    });

   store.reload(); 
   
});
Ext.override(Ext.chart.Chart,{ 
    onDestroy: function(){
        Ext.chart.Chart.superclass.onDestroy.call(this);
        this.bindStore(null);
        var tip = this.tipFnName;
        if(!Ext.isEmpty(tip)){
            delete window[tip];
        }
    }
});
function aa(){
	//alert(kk.items.items[0].yField)
	//var pp=kk.items.items[0].yField;
	//kk.items.items[0].yField="visits2";
	//alert(kk.items.items[0].yField)
	//alert(Ext.getCmp('ssss'))
	
	var chart = Ext.getCmp('ssss');
	//alert(chart.yField)
	chart.yField = "visits2";
//chart.bindStore(store);
//chart.getEl().repaint();
var tt;
store.reload();

//store.loadData();
}