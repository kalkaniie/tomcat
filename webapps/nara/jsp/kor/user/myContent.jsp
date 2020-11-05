<%@page language="java" contentType="text/html;charset=utf-8"%>
<script language="javascript">
//var content_arr = ["mypageMailGrid","mypageGoodJobGrid","mypageNewsLetterGrid","mypageWeatherPanel"];
var content_arr = ["mypageMailGrid","mypageMailGridOut","mypageMailGridTemp","mypageBbsGrid","mypageMemo","myPageInfo","mypageWeatherPanel","myPageDaum","mypageScheduleGrid"];
var portal = Ext.getCmp('home-portal');
function mgr_content(n){
	portal.items.items[0].add({xtype: content_arr[n]});
	portal.doLayout();
	document.getElementById("add_content"+n).style.display="none";	
}	
</script>

<form name="mycontentForm">
<div class="k_popBox">
  <div class="k_popBoxTop">
    <img src="/images/kor/box/popBox_cornersTopL.gif" class="k_fltL" />
    <img src="/images/kor/box/popBox_cornersTopR.gif" class="k_fltR" />
  </div>
  <div class="k_popBoxCont">
    <div class="k_pbIn">
      <ol class="k_pbMyContent">
	    <li id="add_content0" style="display: ;"><a	href="javascript:mgr_content(0)"><img src="/images/kor/ico/myContent_icoMail.gif" /> 받은편지함</a>&nbsp;&nbsp;&nbsp;</li>
		<li id="add_content1" style="display: ;"><a	href="javascript:mgr_content(1)"><img src="/images/kor/ico/myContent_icoMail.gif" /> 보낸편지함</a>&nbsp;&nbsp;&nbsp;</li>
		<li id="add_content2" style="display: ;"><a	href="javascript:mgr_content(2)"><img src="/images/kor/ico/myContent_icoMail.gif" /> 임시보관함</a>&nbsp;&nbsp;&nbsp;</li>
		<li id="add_content3" style="display: ;"><a	href="javascript:mgr_content(3)"><img src="/images/kor/ico/myContent_icoBoard.gif" /> 공지사항</a>&nbsp;&nbsp;&nbsp;</li>
		<li id="add_content4" style="display: ;"><a	href="javascript:mgr_content(4)"><img src="/images/kor/ico/myContent_icoBoard.gif" /> 쪽지</a>&nbsp;&nbsp;&nbsp;</li>
		<li id="add_content5" style="display: ;"><a	href="javascript:mgr_content(5)"><img src="/images/kor/ico/myContent_icoBoard.gif" /> 디스크용량</a>&nbsp;&nbsp;&nbsp;</li>
		<li id="add_content6" style="display: ;"><a href="javascript:mgr_content(6)"><img src="/images/kor/ico/myContent_icoBoard.gif" /> 날씨</a>&nbsp;&nbsp;&nbsp;</li>
		<li id="add_content7" style="display: ;"><a href="javascript:mgr_content(7)"><img src="/images/kor/ico/myContent_icoBoard.gif" /> 위젯</a>&nbsp;&nbsp;&nbsp;</li>		
		<li id="add_content8" style="display: ;"><a href="javascript:mgr_content(8)"><img src="/images/kor/ico/myContent_icoBoard.gif" /> 일정</a>&nbsp;&nbsp;&nbsp;</li>
	  </ol>
	</div>
  </div>
  <div class="k_popBoxBtm">
    <img src="/images/kor/box/popBox_cornersBotL.gif" class="k_fltL" />
    <img src="/images/kor/box/popBox_cornersBotR.gif" class="k_fltR" />
  </div>
</div>
</form>
<script language="javascript">
	var stateProvider = new Ext.state.CookieProvider({ expires: new Date(new Date().getTime()+(1000*60*60*24*365)) });
	if (stateProvider.get('home-portal')){
		var c = stateProvider.get('home-portal');
		var c1= c[0];
		var c2=c[1];
		for( i=0; i<c1.length; i++){
			for( j=0; j<content_arr.length; j++){
				if(c1[i].id.indexOf(content_arr[j]) == 0 ){
					document.getElementById("add_content"+j).style.display ="none";
				}
			}	
		}
		for( i=0; i<c2.length; i++){
			for( j=0; j<content_arr.length; j++){
				if(c2[i].id.indexOf(content_arr[j]) == 0 ){
					document.getElementById("add_content"+j).style.display ="none";
				}
			}	
		}
	}
</script>