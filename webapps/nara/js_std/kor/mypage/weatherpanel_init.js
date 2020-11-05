var w_Code;
var cp = new Ext.state.CookieProvider({expires: new Date(new Date().getTime()+(1000*60*60*24*30))});
var viewType = "Unit";

	   
		w_Code = cp.get("myZone","CA0101");
		weatherDataStore = new Ext.data.JsonStore({
			url: "weather.auth.do?method=aj_weather_view&wCode="+w_Code,
			fields : ["f_code","f_name","f_day","f_time","today_low_temp","tomorrow_low_temp","after_low_temp","today_high_temp","tomorrow_high_temp","after_high_temp","today_w_code",
					  "tomorrow_w_code","after_w_code","today_w","tomorrow_w","after_w","DayOfWeek","con_time","con_day","c_temp",
					  {name:"city_list"},{name:"list_f_code", mapping: "city_list.list_f_code"},{name:"list_f_name", mapping: "city_list.list_f_name"},{name:"CA0101_low_temp", mapping:"CA0101.today_low_temp"},
					  {name:"CA0101_high_temp", mapping:"CA0101.today_high_temp"},{name:"CA0101_w_code", mapping:"CA0101.today_w_code"},{name:"CA0201_low_temp", mapping:"CA0201.today_low_temp"},
					  {name:"CA0201_high_temp", mapping:"CA0201.today_high_temp"},{name:"CA0201_w_code", mapping:"CA0201.today_w_code"},{name:"CA0301_low_temp", mapping:"CA0301.today_low_temp"},
					  {name:"CA0301_high_temp", mapping:"CA0301.today_high_temp"},{name:"CA0301_w_code", mapping:"CA0301.today_w_code"},{name:"CA0401_low_temp", mapping:"CA0401.today_low_temp"},
					  {name:"CA0401_high_temp", mapping:"CA0401.today_high_temp"},{name:"CA0401_w_code", mapping:"CA0401.today_w_code"},{name:"CA0501_low_temp", mapping:"CA0501.today_low_temp"},
					  {name:"CA0501_high_temp", mapping:"CA0501.today_high_temp"},{name:"CA0501_w_code", mapping:"CA0501.today_w_code"},{name:"CA0701_low_temp", mapping:"CA0701.today_low_temp"},
					  {name:"CA0701_high_temp", mapping:"CA0701.today_high_temp"},{name:"CA0701_w_code", mapping:"CA0701.today_w_code"},{name:"CA0815_low_temp", mapping:"CA0815.today_low_temp"},
					  {name:"CA0815_high_temp", mapping:"CA0815.today_high_temp"},{name:"CA0815_w_code", mapping:"CA0815.today_w_code"},{name:"CA0901_low_temp", mapping:"CA0901.today_low_temp"},
					  {name:"CA0901_high_temp", mapping:"CA0901.today_high_temp"},{name:"CA0901_w_code", mapping:"CA0901.today_w_code"},{name:"CA0601_low_temp", mapping:"CA0601.today_low_temp"},
					  {name:"CA0601_high_temp", mapping:"CA0601.today_high_temp"},{name:"CA0601_w_code", mapping:"CA0601.today_w_code"},{name:"CA1001_low_temp", mapping:"CA1001.today_low_temp"},
					  {name:"CA1001_high_temp", mapping:"CA1001.today_high_temp"},{name:"CA1001_w_code", mapping:"CA1001.today_w_code"}]});
		
		weatherDataStore.load();

	    var weatherTpl = new Ext.XTemplate(
		'<tpl if="this.isAll() == false">',
		'<tpl for=".">',
		'<table border="0" cellspacing="0" cellpadding="0" style="margin:6px 0 4px 0;" align="right">',
		'	<tr>',
		'		<td width="152" height="29" align="right" colspan=2">',
		'			<select name=select id=select_weather onChange="javascript:weatherChange(this.value)" style="font-size:11px; height:16px;display:;">',
					'<tpl for="city_list">',
	       		'<tpl if="this.isCity(list_f_code)">',
	          	'<option value={list_f_code} selected>{list_f_name}</option>',
	          	'</tpl>' ,
	          	'<tpl if="this.isCity(list_f_code) == false">',
	          	'<option value={list_f_code}>{list_f_name}</option>',
	          '</tpl>' , 	
	    '</tpl>',	
		'			</select>',
		'			<a href="#"><img onClick=javascript:myZone() src="/images_std/kor/btn/myspace.gif" align="top"></a></td>',
		'	</tr>',
		'	<tr>',
		'		<td align="center" width="76" style="border-right:1px dashed #EEE; border:1px solid #F0F0F0;">',
		'		<table width="70" border="0" cellspacing="0" cellpadding="0" style="margin-top:3px;" align="center">',
		'			<tr>',
		'				<td align="center" class="wea_tt" style="text-align:center;">오늘</td>',
		'			</tr>',
		'			<tr>',
		'				<td height="44" align="center" style="text-align:center;"><img src="/images/kor/weather/wicon-32/s{today_w_code}.gif" /></td>',
		'			</tr>',
		'			<tr>',
		'				<td align="center" class="wea_td" style="text-align:center;">{today_w}</td>',
		'			</tr>',
		'			<tr>',
		'				<td align="center" class="wea_te" style="text-align:center;"><span>{today_low_temp}</span> / <span class="h">{today_high_temp}</span></td>',
		'			</tr>',
		'		</table>',
		'		</td>',
		'		<td align="center" width="76" style="border-top:1px solid #F0F0F0; border-bottom:1px solid #F0F0F0; border-right:1px solid #F0F0F0;">',
		'		<table width="70" border="0" cellspacing="0" cellpadding="0" style="margin-top:3px;" align="center">',
		'			<tr>',
		'				<td align="center" class="wea_tt" style="text-align:center;">내일</td>',
		'			</tr>',
		'			<tr>',
		'				<td height="44" align="center" style="text-align:center;"><img src="/images/kor/weather/wicon-32/s{tomorrow_w_code}.gif" /></td>',
		'			</tr>',
		'			<tr>',
		'				<td align="center" class="wea_td" style="text-align:center;">{tomorrow_w}</td>',
		'			</tr>',
		'			<tr>',
		'				<td align="center" class="wea_te" style="text-align:center;"><span>{tomorrow_low_temp}</span> / <span class="h">{tomorrow_high_temp}</span></td>',
		'			</tr>',
		'		</table>',
		'		</td>',
		'	</tr>',
		'</table>',
		'</tpl>',
		'</tpl>',
		'<tpl if="this.isAll()">',
		'<tpl for=".">',
		'</tpl>',
		'</tpl>',
		{
	     isCity: function(wC){
	         return wC == w_Code;
	     },
	     isAll :function(){
	     	if( viewType=="All"){
	     		return true;
	     	}else{
	     		return false;
	     	}
	     }
	    });
		weatherDV= new Ext.DataView({
		        store: weatherDataStore,
		        tpl: weatherTpl,
		        itemSelector:"",
		        renderTo:"mypage_weather_div"
		})
        
function weatherChange(str){
	w_Code =str;
	weatherDataStore.proxy.conn.url = "weather.auth.do?method=aj_weather_view&wCode="+str;
	weatherDataStore.reload();
	weatherDV.refresh();
}
function myZone(){
	cp.set("myZone",w_Code);
	alert("내지역이 등록되었습니다.");
}
function allZone(val){
	if(val ==1) viewType ="Unit";
   	else if(val ==0) viewType ="All";
   	weatherDV.refresh() ;
}