var w_Code;
var cp = new Ext.state.CookieProvider({expires: new Date(new Date().getTime()+(1000*60*60*24*30))});
var viewType = "Unit";

	   
DSR.MypageWeatherPanelPlugin = Ext.extend(Ext.Panel, {
	plugins: Ext.ux.PortletPlugin,
    title:'날씨 ',
    closeable: true,
    height:330,
    border:false,
    tools:weatherTool,
    bodyStyle:'background:white',
	initComponent : function() {
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
	    '<table width=100% height=auto border=0 cellspacing=4 cellpadding=0 bgcolor="#ffffff" style="border:1px solid #839fd5">',	
    	'  <tr><td align=center valign=top style="padding:1px"><table width=100% height=100% border=0 cellspacing=0 cellpadding=0>',
		'      <tr>',
		'        <td valign=top align=left><table  width=100% border=0 cellspacing=0 cellpadding=0>',
		'        <tr><td><img src=/images/kor/weather/text_title.gif width=85 height=23></td>',
		'  <td style="padding:0 1px 5px 0;" align=right><select  name=select class=select_01 id=select onChange=javascript:weatherChange(this.value)>',
	          '<tpl for="city_list">',
	       		'<tpl if="this.isCity(list_f_code)">',
	          	'<option value={list_f_code} selected>{list_f_name}</option>',
	          	'</tpl>' ,
	          	'<tpl if="this.isCity(list_f_code) == false">',
	          	'<option value={list_f_code}>{list_f_name}</option>',
	          '</tpl>' , 	
	    '</tpl>',
		'    </select>', 
		'      &nbsp;<img src=/images/kor/weather/btn_areaedit.gif style="cursor:hand" onClick=javascript:myZone() width=66 height=20 align=absmiddle>',
		'      <img src=/images/kor/weather/btn_line.gif width=9 height=20 align=absmiddle>',
		'      <img src=/images/kor/weather/btn_mapview.gif style="cursor:hand" onClick=javascript:allZone(0) width=69 height=20 align=absmiddle></td>',
		'  </tr>',
		'        </table></td>',
		'      </tr>',
		'      <tr>',
		'        ',
		'        <td height=127 align=center valign=top><table width=100% border=0 cellspacing=0 cellpadding=0>',
		'          <tr>',
		'            <td width=4><img src=/images/kor/weather/table02_01.gif width=4 height=127></td>',
		'            <td align=center valign=top background=/images/kor/weather/table02_02.gif><table width=95% border=0 cellspacing=0 cellpadding=0>',
		'              <tr>',
		'                <td height=30><strong>{con_day} {DayOfWeek}</strong> <strong class=fontColor_03>현재</strong></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=3></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=82 valign=top><table width=100% border=0 cellspacing=0 cellpadding=0>',
		'                  <tr>',
		'                    <td width=84 height=84 align=center bgcolor=eef0fc><table width=100% border=0 cellspacing=1 cellpadding=0>',
		'                      <tr>',
		'                        <td><img src=/images/kor/weather/wicon-82/{today_w_code}.gif width=82 height=82></td>',
		'                      </tr>',
		'                    </table></td>',
		'                    <td width=10></td>',
		'                    <td><table width=100% border=0 cellspacing=0 cellpadding=0>',
		'                      <tr>',
		'                        <td valign=top><strong></strong> [{con_time}]</td>',
		'                      </tr>',
		'                      <tr>',
		'                        <td height=6></td>',
		'                      </tr>',
		'                      <tr>',
		'                        <td>{today_w}</td>',
		'                      </tr>',
		'                      <tr><td height=5></td></tr>',
		'                      <tr>',
		'                        <td><span class=fontColor_06>기온 <strong>{c_temp}</strong>℃</span></td>',
		'                      </tr>',
		'                    </table></td>',
		'                  </tr>',
		'                </table></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=8></td>',
		'              </tr>',
		'            </table></td>',
		'            <td width=4><img src=/images/kor/weather/table02_03.gif width=4 height=127></td>',
		'          </tr>',
		'        </table></td>',
		'        ',
		'      </tr>',
		'      <tr>',
		'        ',
		'        <td height=4 valign=top></td>',
		'        ',
		'      </tr>',
		'      <tr>',
		'        ',
		'        <td align=center valign=top><table width=100% border=0 cellspacing=0 cellpadding=0>',
		'          <tr>',
		'            <td width=2><img src=/images/kor/weather/table03_01.gif width=2 height=108></td>',
		'            <td valign=top background=/images/kor/weather/table03_02.gif><table width=100% height=108 border=0 cellspacing=1 cellpadding=0>',
		'              <tr>',
		'                <td height=22 align=center><img src=/images/kor/weather/text_02.gif width=25 height=12></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=3></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=33 align=center><img src=/images/kor/weather/wicon-32/s{today_w_code}.gif width=32 height=30></td>',
		'              </tr>',
		'              <tr>',
		'                <td align=center class=fontColor_04>{today_w}</td>',
		'              </tr>',
		'              <tr>',
		'                <td height=17 align=center valign=top><span class=fontColor_01>{today_low_temp}</span>',
		'				<img src=/images/kor/weather/img_line.gif align=absmiddle><span class=fontColor_02>{today_high_temp}</span><img src=/images/kor/weather/img_c02.gif align=absmiddle></td>',
		'              </tr>',
		'            </table></td>',
		'            <td width=2><img src=/images/kor/weather/table03_03.gif width=2 height=108></td>',
		'            <td width=2></td>',
		'            <td width=2><img src=/images/kor/weather/table03_01.gif width=2 height=108></td>',
		'            <td width=32% valign=top background=/images/kor/weather/table03_02.gif><table width=100% height=108  border=0 cellspacing=1 cellpadding=0>',
		'              <tr>',
		'                <td height=22 align=center><img src=/images/kor/weather/text_03.gif width=25 height=12></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=3></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=33 align=center><img src=/images/kor/weather/wicon-32/s{tomorrow_w_code}.gif width=32 height=30></td>',
		'              </tr>',
		'              <tr>',
		'                <td align=center class=fontColor_04>{tomorrow_w}</td>',
		'              </tr>',
		'              <tr>',
		'                <td height=17 align=center valign=top><span class=fontColor_01>{tomorrow_low_temp}</span>',
		'				<img src=/images/kor/weather/img_line.gif align=absmiddle><span class=fontColor_02>{tomorrow_high_temp}</span><img src=/images/kor/weather/img_c02.gif align=absmiddle></td>',
		'              </tr>',
		'            </table></td>',
		'            <td width=2><img src=/images/kor/weather/table03_03.gif width=2 height=108></td>',
		'            <td width=2></td>',
		'            <td width=2><img src=/images/kor/weather/table03_01.gif width=2 height=108></td>',
		'            <td width=32% valign=top background=/images/kor/weather/table03_02.gif><table width=100% height=108 border=0 cellspacing=1 cellpadding=0>',
		'              <tr>',
		'                <td height=22 align=center><img src=/images/kor/weather/text_04.gif width=25 height=12></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=3></td>',
		'              </tr>',
		'              <tr>',
		'                <td height=33 align=center><img src=/images/kor/weather/wicon-32/s{after_w_code}.gif width=32 height=30></td>',
		'              </tr>',
		'              <tr>',
		'                <td align=center class=fontColor_04>{after_w}</td>',
		'              </tr>',
		'              <tr>',
		'                <td height=17 align=center valign=top><span class=fontColor_01>{after_low_temp}</span>',
		'				<img src=/images/kor/weather/img_line.gif align=absmiddle><span class=fontColor_02>{after_high_temp}</span><img src=/images/kor/weather/img_c02.gif align=absmiddle></td>',
		'              </tr>',
		'            </table></td>',
		'            <td width=2><img src=/images/kor/weather/table03_03.gif width=2 height=108></td>',
		'          </tr>',
		'        </table></td>',
		'        ',
		'      </tr>',
		'    </table></td>',
		'  </tr>',
		'</table>',   
		'</tpl>',
		'</tpl>',
		'<tpl if="this.isAll()">',
		'<tpl for=".">',
		'<div id="apDiv1" style="position:absolute;left:70px;top:32px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_seoul.gif);">',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0101_w_code}.gif" width="32" height="30"></td>',
		'</tr><tr><td height="14" align="center" style="font-size:11px;">{CA0101_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA0101_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv2" style="position:absolute;left:149px;top:26px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_chuncheon.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0201_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA0201_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA0201_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv3" style="position:absolute;left:225px;top:28px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_gangneung.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0301_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA0301_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle"> ',
		'{CA0301_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv4" style="position:absolute;left:67px;top:99px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_daejeon.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0401_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA0401_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA0401_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv5" style="position:absolute;left:143px;top:95px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_cheongju.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0501_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA0501_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA0501_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv6" style="position:absolute;left:220px;top:101px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_daegu.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0701_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA0701_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA0701_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv7" style="position:absolute;left:60px;top:166px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_gwangju.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0815_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA0815_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA0815_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv8" style="position:absolute;left:138px;top:173px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_jeonju.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0901_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA0901_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA0901_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv9" style="position:absolute;left:219px;top:183px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_busan.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA0601_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA0601_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA0601_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<div id="apDiv10" style="position:absolute;left:15px;top:220px;width:60px;height:65px;z-index:1;background-image: url(/images/kor/weather/box_jeju.gif);"> ',
		'<table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td height="17">&nbsp;</td></tr><tr>',
		'<td height="30" align="center"><img src="/images/kor/weather/wicon-32/s{CA1001_w_code}.gif" width="32" height="30"></td></tr><tr>',
		'<td height="14" align="center"><span class="fontColor_01">{CA1001_low_temp}<img src="/images/kor/weather/img_line.gif" align="absmiddle">',
		'{CA1001_high_temp}<img src="/images/kor/weather/img_c02.gif" align="absmiddle"></td></tr><tr><td height="4"></td></tr></table></div>',
		'<table width="345" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">',
		'  <tr><td style="padding:3px 0 0 5px"><select  name=select class=select_01 id=select onChange=javascript:weatherChange(this.value)>',
			          '<tpl for="city_list">',
			       		'<tpl if="this.isCity(list_f_code)">',
			          	'<option value={list_f_code} selected>{list_f_name}</option>',
			          	'</tpl>' ,
			          	'<tpl if="this.isCity(list_f_code) == false">',
			          	'<option value={list_f_code}>{list_f_name}</option>',
			          '</tpl>' , 	
				    '</tpl>',
			'</select>', 
		'&nbsp;<img src="/images/kor/weather/btn_area.gif" align="absmiddle" style="cursor:hand" onClick="javascript:allZone(1)">',
		'&nbsp;<img src="/images/kor/weather/text_01.gif" align="absmiddle"></td>',
		'</tr><tr><td height="3"></td></tr><tr>',
		'<td height="272" align="center" valign="bottom" background="/images/kor/weather/map_bg.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">',
		'<tr><td height="30" align="right"><span class="fontColor_07">기상청 {con_day} {con_time} 발표</span>&nbsp;</td>',
		'</tr></table></td></tr></table>',
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
		        itemSelector:""
		})
		
		Ext.apply(this, {
			items:weatherDV
		 });	
        DSR.MypageWeatherPanelPlugin.superclass.initComponent.apply(this, arguments);
    }
});	
Ext.reg('mypageWeatherPanel', DSR.MypageWeatherPanelPlugin);
function weatherChange(str){
	w_Code =str;
	weatherDataStore.proxy.conn.url = "weather.auth.do?method=weather_view&wCode="+str;
	weatherDataStore.reload();
}
function myZone(){
	cp.set("myZone",w_Code);
	Ext.Msg.alert("Message", "내지역이 등록되었습니다.");
}
function allZone(val){
	if(val ==1) viewType ="Unit";
   	else if(val ==0) viewType ="All";
   	weatherDV.refresh() ;
}