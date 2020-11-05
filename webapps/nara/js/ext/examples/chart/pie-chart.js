/*!
 * Ext JS Library 3.1.1
 * Copyright(c) 2006-2010 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.chart.Chart.CHART_URL = '../../resources/charts.swf';

Ext.onReady(function(){
    var store = new Ext.data.Store({
        proxy: new Ext.data.HttpProxy({
	     		url: '/ext/examples/chart/sheldon.xml',
	     		method: 'POST'
	     	}),

        reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Item',
	        	id: 'season',
	        	totalRecords: 'recCount'
		  	}, 
		  	 ['season','total']),
		  	remoteSort: true
           
    });
   store.reload();
    
    new Ext.Panel({
        width: 400,
        height: 400,
        title: 'Pie Chart with Legend - Favorite Season',
        renderTo: 'container',
        items: {
            store: store,
            xtype: 'piechart',
            dataField: 'total',
            categoryField: 'season',
            //extra styles get applied to the chart defaults
            extraStyle:
            {
                legend:
                {
                    display: 'bottom',
                    padding: 5,
                    font:
                    {
                        family: 'Tahoma',
                        size: 13
                    }
                }
            }
        }
    });
});