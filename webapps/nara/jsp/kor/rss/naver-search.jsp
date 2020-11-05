<%@ page language="java" contentType="text/html;charset=utf-8"%>
<script type="text/javascript">
	function getNaverSearch(){
		var objForm= document.naverSearch;
		var search_index ="";
		for(i=0; i< 8; i++){
			if(objForm.naver_search_keyindex[i].checked == true){
				search_index = objForm.naver_search_keyindex[i].value;
			}
		}	
		if( objForm.naver_search_keyWord.value ==""){
			alert("검색어를 입력하여 주십시오");
			return;
		}		
	  	var link ="/jsp/kor/rss/naver-search-result.jsp?query="+objForm.naver_search_keyWord.value+"&target="+search_index;
	  	//params = encodeURI(params);		
	  	window.open( link ,"search_naver","status=yes,location=no,resizable=yes,toolbar=no,scrollbars=yes,width=600,height=400");
    } 
    function  getDaumMp(){
    	var link ="/jsp/kor/rss/daum-map.jsp";
	  	window.open( link ,"daum_map","status=yes,location=no,resizable=yes,toolbar=no,scrollbars=auto,width=600,height=400");
	}  	
      
</script>
    
<style type="text/css">
<!--
body { margin:0; padding:0; font-family:돋움,Dotum,AppleGothic,sans-serif; font-size:12px; color:#000;}
input { vertical-align:middle; margin:-1px 0px; padding:1px 0px; border-bottom-style:1px solid #d8d8d8; border-left-style:1px solid #9b9c99; border-right-style:1px solid #d8d8d8; border-top-style:1px solid #9b9c99; font-family:돋움,Dotum,AppleGothic,sans-serif; font-size:12px; height:14px;}
img { vertical-align:middle; border:0;}

.tdTable { height:30px; _height:30px; line-height:30px; padding-left:15px;}
-->
</style>
</head>

<body>
<form name="naverSearch" method="post"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <form id="form1" name="form1" method="post" action="">
  <tr>
    <td height="20" colspan="4"></td>
  </tr>
  <tr>
    <td class="tdTable"><input type="radio" name="naver_search_keyindex" value="encyc" checked="checked" style="border:none; padding-right:8px" />  백과사전</td>
    <td class="tdTable"><input type="radio" name="naver_search_keyindex" value="krdic"  style="border:none; padding-right:8px" /> 국어사전</td>
    <td class="tdTable"><input type="radio" name="naver_search_keyindex" value="endic"  style="border:none; padding-right:8px" /> 영어사전</td>
    <td class="tdTable"><input type="radio" name="naver_search_keyindex" value="jpdic"  style="border:none; padding-right:8px" /> 일어사전</td>
  </tr>
  <tr>
    <td class="tdTable"><input type="radio" name="naver_search_keyindex" value="news" style="border:none; padding-right:8px"  /> 뉴스검색</td>
    <td class="tdTable"><input type="radio" name="naver_search_keyindex" value="webkr" style="border:none; padding-right:8px" /> 웹 문서</td>
    <td class="tdTable"><input type="radio" name="naver_search_keyindex" value="shop" style="border:none; padding-right:8px" /> 쇼  핑</td>
    <td class="tdTable"><input type="radio" name="naver_search_keyindex" value="movie" style="border:none; padding-right:8px"  /> 영  화</td>
  </tr>
  <tr>
    <td colspan="4"><img src="/images/kor/rss/img_search.gif" style="padding:3px 0 3px 15px" /><label>
    <input type="text" name="naver_search_keyWord" type="text" onkeydown="javascript:if(event.keyCode == 13) { getNaverSearch(); return false}" style=" width:200px" />
    </label> <a href="javascript:getNaverSearch();"><img src="/images/kor/rss/btn_search.gif" style="padding-bottom:-1px" /></a></td>
  </tr>
  
  <tr>
    <td height="5" colspan="4"></td>
  </tr>
  <tr>
    <td height="1" colspan="4" background="/images/kor/rss/img_dotLine10.gif.gif"></td>
  </tr>
</form>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px">
  <tr>
    <td><img src="/images/kor/rss/img_search.gif" style="padding:0 10px 0 15px" /><a href="javascript:getDaumMp();"><img src="/images/kor/rss/btn_daumMap.gif" /></a></td>
  </tr>
</table>
</form>
</body>
</html>
