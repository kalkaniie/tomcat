/*!
 * Ext JS Library 3.1.1
 * Copyright(c) 2006-2010 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
Ext.chart.Chart.CHART_URL = '/js/ext/resources/charts.swf';

Ext.onReady(function(){
   var objForm = document.f;	
   var urlStr = "MAIL_LOG_DATE_year="+objForm.MAIL_LOG_DATE_year.value+"&MAIL_LOG_DATE_month="+objForm.MAIL_LOG_DATE_month.value+"&MAIL_LOG_DATE_date="+objForm.MAIL_LOG_DATE_date.value+"&view="+objForm.view.value+"&domain="+objForm.domain.value;
   var store = new Ext.data.Store({
   		autoLoad:true,
        proxy: new Ext.data.HttpProxy({
	     		url: 'maillog.system.do?method=aj_mailLog_main&'+urlStr,
	     		method: 'POST'
	     	}),

        reader: new Ext.data.XmlReader(
	 	 	{
	        	record: 'Record',
	        	totalRecords: 'recCount'
		  	}, 
		  	 [	{name:'MAIL_LOG_KEY'},
		  	 	{name:'MAIL_LOG_RECEIVE_COUNT',type:'float'}, 
		  	 	{name:'MAIL_LOG_SEND_COUNT',type:'float'},
		  	 	{name:'MAIL_LOG_ERROR_COUNT',type:'float'} 
		  	 ]),
		  	remoteSort: false
           
    });
	//store.sort('MAIL_LOG_KEY', 'ASC' );
	
    new Ext.Panel({
        iconCls:'chart',
        frame:true,
        renderTo: 'div_chart',
        width:790,
        height:400,
        layout:'fit',

        items: {
            xtype: 'columnchart',
            store: store,
            url:'/js/ext/resources/charts.swf',
            xField: 'MAIL_LOG_KEY',
            listeners: {
				itemclick: function(o){
					var rec = store.getAt(o.index);
					drawPieChart(store,o.index);
				}
			},
            yAxis: new Ext.chart.NumericAxis({
                displayName: 'Visits',
                labelRenderer : Ext.util.Format.numberRenderer('0,0')
            }),
            tipRenderer : function(chart, record, index, series){
                if(series.yField == 'MAIL_LOG_RECEIVE_COUNT'){
                    return 'Received Mail: ' +Ext.util.Format.number(record.data.MAIL_LOG_RECEIVE_COUNT, '0,0') ;
                }else if(series.yField == 'MAIL_LOG_SEND_COUNT'){
                	return 'Send Mail:' + Ext.util.Format.number(record.data.MAIL_LOG_SEND_COUNT, '0,0') ;
                }else if(series.yField == 'MAIL_LOG_ERROR_COUNT'){
                    return 'Error Mail: ' +Ext.util.Format.number(record.data.MAIL_LOG_ERROR_COUNT, '0,0') ;
                }
            },
            chartStyle: {
                padding: 10,
                animationEnabled: true,
                font: {
                    name: 'Tahoma',
                    color: 0x444444,
                    size: 11
                },
                dataTip: {
                    padding: 5,
                    border: {
                        color: 0x99bbe8,
                        size:1
                    },
                    background: {
                        color: 0xDAE7F6,
                        alpha: .9
                    },
                    font: {
                        name: 'Tahoma',
                        color: 0x15428B,
                        size: 10,
                        bold: true
                    }
                },
                xAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xeeeeee}
                },
                yAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xdfe8f6}
                }
            },
             series: [{
                type: 'column',
                displayName: 'Page Views',
                yField: 'MAIL_LOG_RECEIVE_COUNT',
                style: {
                	image:'bar.gif',
                    mode: 'stretch',
                    color:0x40a1ff
                }
            },{
                type:'column',
                displayName: 'Visits',
                yField: 'MAIL_LOG_SEND_COUNT',
                style: {
                	image:'bar.gif',
                    mode: 'stretch',
                    color: 0xb1dd40
                }
            },{
                type:'column',
                displayName: 'Visits',
                yField: 'MAIL_LOG_ERROR_COUNT',
                style: {
                	image:'bar.gif',
                    mode: 'stretch',
                    color: 0xdc40b0
                }
            }]
        }
    });
});

function generateData(tstore,colIndex){
	var rec = tstore.getAt(colIndex);
	var data = [];
    data.push(["Receive Mail", rec.data.MAIL_LOG_RECEIVE_COUNT]);
    data.push(["Send Mail", rec.data.MAIL_LOG_SEND_COUNT]);
    data.push(["Error Mail", rec.data.MAIL_LOG_ERROR_COUNT]);
    return data;
}

function drawPieChart(tstore,colIndex){
	
    var store = new Ext.data.ArrayStore({
        fields: ['mail_log_key', 'hits'],
        data: generateData(tstore,colIndex)
    });

	var unitPanel = new Ext.Panel({
        width: 400,
        height: 400,
        items: {
            store: store,
            xtype: 'piechart',
            dataField: 'hits',
            categoryField: 'mail_log_key',
            series :[{                    
            	style :{                        
            		colors : [0xffcc00, 0xaec800, 0xff2e7d] 
            	}                
            }]
        }
    });
    
	var myDisplayNameWindow = new Ext.Window({
        title: '상세보기 - PieChart',
        width: 400,
        height:400,
        resizable:false,
        layout: 'fit',
        plain:true,
        bodyStyle:'padding:5px;',
        buttonAlign:'center',
        items: unitPanel,
        buttons: [{
            text: '닫기',
             handler: function()
             {             				
	         		myDisplayNameWindow.destroy();
             }
        }]
    });
	myDisplayNameWindow.show();   
}