<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="entity" class="com.nara.jdf.db.entity.BoardEntity" scope="request" />
<style type="text/css">
<!--
*{padding:0; margin:0}
body, html { margin:0; padding:0; height:100%; width:100%; SCROLLBAR-FACE-COLOR: #FFFFFF; font: 12px 돋움, 굴림, Dotum, Dotum Che, Gulim, Gulim Che, Arial, Tahoma, Verdana; color:#333333; word-wrap:break-word; word-break:break-all; }
img{ border:0;padding:0;margin:0 }

.k_popHdBox{ width:550px; height:400px}
.k_popHdBody{ background:url(/images/kor/popup/pop_noticeBg.gif) repeat-y left top;}
.k_popHdBott{ background:url(/images/kor/popup/pop_noticeBgBott.gif) no-repeat left bottom; padding:0 0 21px 35px}
.k_popHdBott th{ background:#e8f8f8; width:100px;border-top:1px solid #a6cbcb; color:#477381}
.k_popHdBott td{ border-top:1px solid #a6cbcb; padding:5px;}
.k_popHdCon{ height:170px; overflow-y:auto;scrollbar-face-color: #bdeaf2;
scrollbar-track-color: #e8f8f8;
scrollbar-highlight-color: #7accc8;
scrollbar-3dlight-color: #bdeaf2;
scrollbar-shadow-color: #80D9D9;
scrollbar-darkshadow-color: #a3dde8;
scrollbar-arrow-color: #ffffff;}
.k_popHdBtn{ text-align:center}
-->
</style>
<div class="k_popHdBox">
    <div>
    <img src="/images/kor/popup/pop_noticeTopImg.gif" />
    </div>
    <div class="k_popHdBody">
    <div class="k_popHdBott">
     <table width="480" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th height="28">작성자</th>
    <td><%=entity.B_NAME %></td>
  </tr>
  <tr>
    <th height="28">제 목</th>
    <td><%=entity.B_TITLE %></td>
  </tr>
  <tr>
    <td height="180" colspan="2" valign="top">
    <div class="k_popHdCon">
   <%=entity.B_CONTENT %>

    </div>
    </td>
    </tr>
</table>
</div>

    </div>
    <div class="k_popHdBtn">
      <a href="javascript:window.close()"><img src="/images/kor/btn/pop_noticeClose.gif" /></a>

  </div>
</div>
