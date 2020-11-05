<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.mail.Header"%>
<%@page import="com.nara.jdf.db.entity.ArchiveMailEntity"%>
<%@page import="com.nara.util.ChkValueUtil"%>
<%@page import="com.nara.util.*"%>
<%@page import="com.nara.jdf.jsp.HtmlUtility"%>
<%@page import="com.nara.jdf.db.entity.UserTagEntity"%>
<%@page import="com.nara.util.UtilFileApp"%>

<jsp:useBean id="userEntity" class="com.nara.jdf.db.entity.UserEntity"
	scope="request" />
<jsp:useBean id="webMailEntityList" class="java.util.ArrayList"
	scope="request" />
<jsp:useBean id="M_IDX" class="java.lang.String" scope="request" />
<jsp:useBean id="uniqStr" class="java.lang.String" scope="request" />

<%
 	ArchiveMailEntity archiveEntity = (ArchiveMailEntity)webMailEntityList.get(0);
%>

<script language="javascript">
//첨부파일다운로드
function downloadBlocking<%=uniqStr%>(mIdx, fNum, fIdx, fName) {
   	var blockingFile = new Array();
   	blockingFile.push("mdb");
   
   	var objForm = document.archive_preview<%=uniqStr%>;
    var chk = 0;
    for (i=0; i<blockingFile.length; i++) {
      	if (fName.substring(fName.lastIndexOf(".") + 1) == blockingFile[i]) {
        	alert("다운로드 불가능한 파일이 포함되어 있습니다.");
        	chk++;
      	}
    }
    if (chk == 0) {
      	objForm.action = "webmail.auth.do?method=attache&M_IDX="+mIdx+"&nFileNum="+fNum+"&nSubIndex="+fIdx;
      	objForm.submit();
    }
}
  
function arkFileDownLoad(_mail_seq, _file_seq, _url) {
	Ext.Ajax.request({
		scope :this,
		url: 'anaconda.public.do',
		method : 'POST',
		params: {
			method:'anaFileDelStatus',
			MAIL_SEQ:_mail_seq,
			FILE_SEQ:_file_seq
		},
		success : function(response, options) {
			try {
				var reader = new Ext.data.XmlReader({record: 'RESPONSE'},['SUCCESS','FILE_DEL']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.SUCCESS == "true") {
		  			if (resultXML.records[0].data.FILE_DEL == "3" || resultXML.records[0].data.FILE_DEL == "4") {
		  				alert("유효기간이 만료된 파일입니다.");
		  			} else if (resultXML.records[0].data.FILE_DEL == "5" || resultXML.records[0].data.FILE_DEL == "6" || resultXML.records[0].data.FILE_DEL == "7") {
		  				alert("메일 발신자에 의해 삭제된 메일 입니다.");
		  			} else {
		  				location.href = _url;
		  			}
		  		}else{
					alert("잠시후 다운로드를 시도하여 주시기 바랍니다.");
		  		}  
			} catch(e) {}
		},
		failure : function(response, options) {
			alert("잠시후 다운로드를 시도하여 주시기 바랍니다.");
		}
	});	
}  
</script>

<form method=post name="archive_preview<%=uniqStr%>"><input
	type='hidden' name='method' value=''> <input type='hidden'
	name='M_IDX' value='<%=M_IDX%>'> <input type='hidden'
	name='MBOX_IDX' value='<%=archiveEntity.MBOX_IDX%>'> <%
java.text.DecimalFormat df = new java.text.DecimalFormat("#,###.##");
try {
    javax.mail.internet.InternetAddress addr = 
        new javax.mail.internet.InternetAddress(archiveEntity.M_SENDER);
    out.println("<input type='hidden' name='ADDRESS_EMAIL' value='"+ ChkValueUtil.translate(addr.toString()) + "'>");
} catch (Exception e) {
    out.println("<input type='hidden' name='ADDRESS_EMAIL' value='"+ ChkValueUtil.translate(archiveEntity.M_SENDER) + "'>");
}
%>
<div class="k_gridA3"><!-- <a href="javascript:deleteArchive()"><img src="/images/kor/btn/btnA_delete.gif" /></a> -->
</div>
<div class="k_txViewHed">
<table>
	<caption><%=HtmlUtility.translate(archiveEntity.M_TITLE)%></caption>
	<tr>
		<th width="155" scope="row">
		<div class="k_fltL">보내는 사람</div>
		<div class="k_more"><a href="#" class="k_ibtnPlus"
			onclick="mb_infoDet<%=M_IDX%>.style.display='block';btn_infoOp<%=M_IDX%>.style.display='none';btn_infoCl<%=M_IDX%>.style.display='block'"
			id="btn_infoOp<%=M_IDX%>"><b>+</b></a> <a href="#"
			class="k_ibtnMinus"
			onclick="mb_infoDet<%=M_IDX%>.style.display='none';btn_infoOp<%=M_IDX%>.style.display='block';btn_infoCl<%=M_IDX%>.style.display='none'"
			id="btn_infoCl<%=M_IDX%>"><b>-</b></a></div>
		<em class="K_boxTh_em">세부정보</em></th>
		<td><a href="#"><%=HtmlUtility.translate(archiveEntity.M_SENDER)%></a>
		</td>
	</tr>
</table>
<table id="mb_infoDet<%=M_IDX%>" style="display: none">
	<tr>
		<th width="155" scope="row">받는사람</th>
		<td><%=HtmlUtility.translate(archiveEntity.M_TO)%></td>
	</tr>
	<tr>
		<th scope="row">참조</th>
		<td><%=HtmlUtility.translate(archiveEntity.M_CC)%></td>
	</tr>
	<tr>
		<th scope="row">보낸날짜</th>
		<td><%=HtmlUtility.translate(archiveEntity.M_TIME)%></td>
	</tr>
</table>
</div>

<div class="k_view">
<div class="k_txView">
<div class="k_txViewIn"><%=archiveEntity.M_CONTENT%> <%
    if (webMailEntityList.size() > 1) {
        webMailEntityList.remove(0);
        for (int i = 0; i < webMailEntityList.size(); i++) {
            ArchiveMailEntity subArchiveEntity = (ArchiveMailEntity) webMailEntityList.get(i);        
%>

<div class="k_mailFd">
<div class="k_mailFd_tit">
<p class="k_mailFd_titIco"><b>전달된편지 : </b><%=HtmlUtility.translate(subArchiveEntity.M_TITLE)%></p>
<p class="k_mailFd_titTag"><img src="/images/kor/ico/ico_tag06.gif" /></p>
</div>
<table class="k_mailFd_head">
	<tr>
		<th width="100" scope="row" class="k_mailFd_headTh">보내사람</th>
		<td class="k_mailFd_headTd"><%=HtmlUtility.translate(subArchiveEntity.M_SENDER)%></td>
	</tr>
	<tr>
		<th scope="row" class="k_mailFd_headTh">받는사람</th>
		<td class="k_mailFd_headTd"><%=HtmlUtility.translate(subArchiveEntity.M_TO)%></td>
	</tr>
	<tr>
		<th scope="row" class="k_mailFd_headTh">보낸날짜</th>
		<td class="k_mailFd_headTd"><%=HtmlUtility.translate(subArchiveEntity.M_TIME)%></td>
	</tr>
</table>
<div class="k_mailFd_txt"><%=subArchiveEntity.M_CONTENT%></div>
</div>

</div>
</div>
</form>
<form name="mail_view_attache_form<%=uniqStr%>"><input
	type='hidden' name='M_IDX' value='<%=M_IDX%>'> <input
	type='hidden' name='nSubIndex' value=''> <input type='hidden'
	name='strDir' value=''> <%
          if (subArchiveEntity.M_ATTNUM != null
                  && subArchiveEntity.M_ATTNUM.length() > 0) {
              String[] attachNums = subArchiveEntity.M_ATTNUM.split("[;]");
              String[] attachNames = subArchiveEntity.M_ATTNAME.split("[;]");
              String[] attachSize = subArchiveEntity.M_ATTSIZE.split("[;]");
              String[] attachType = subArchiveEntity.M_ATTTYPE.split("[;]");
%>

<table class="k_attNma">
	<caption>일반 첨부파일</caption>
	<tr>
		<th width="29" scope="col" class="k_pickChk"><img
			src="/images/kor/grid/pick_butt2.gif" /></th>
		<th scope="col">파일명</th>
		<th width="204" scope="col">파일종류</th>
		<th width="116" scope="col">용량</th>
	</tr>
	<%                    
  for (int idx = 0; idx < attachNums.length; idx++) { 
  try {
  String[] fileType = com.nara.util.UtilFileApp.getFileType(
  attachNames[idx].substring(attachNames[idx].lastIndexOf('.') + 1));
%>
	<tr>
		<td><input type="checkbox" name="checkbox" id="checkbox" /></td>
		<td class="k_txAliL"><img
			src="../images/kor/ico/<%=fileType[1]%>" /> <a
			href="javascript:downloadBlocking<%=uniqStr%>('<%=archiveEntity.M_IDX%>', '<%=attachNums[idx]%>', '<%=i%>', '<%=attachNames[idx]%>');"><%=attachNames[idx]%></a></td>
		<td><%=fileType[2]%></td>
		<td><%=df.format(Double.parseDouble(attachSize[idx])/1024)%>KB</td>
	</tr>
	<%                    
                } catch (ArrayIndexOutOfBoundsException e) {
                    
                }
            }
%>
</table>


<%
          }
%> <%
        }
    }
%> <%
    if (archiveEntity.M_ATTNUM != null               
        && archiveEntity.M_ATTNUM.length() > 0) {
        String[] attachNums = archiveEntity.M_ATTNUM.split("[;]");
        String[] attachNames = archiveEntity.M_ATTNAME.split("[;]");
        String[] attachSize = archiveEntity.M_ATTSIZE.split("[;]");
        String[] attachType = archiveEntity.M_ATTTYPE.split("[;]");
%>
<table class="k_attNma">
	<caption>일반 첨부파일 <span> </span></caption>
	<%
      for (int i = 0; i < attachNums.length; i++) { 
          try {
              String[] fileType = com.nara.util.UtilFileApp.getFileType(
                      attachNames[i].substring(attachNames[i].lastIndexOf('.') + 1));
%>
	<tr>
		<th width="29" scope="col" class="k_pickChk"><img
			src="/images/kor/grid/pick_butt2.gif" /></th>
		<th scope="col">파일명</th>
		<th width="204" scope="col">파일종류</th>
		<th width="116" scope="col">용량</th>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkbox" id="checkbox" /></td>
		<td class="k_txAliL"><img
			src="../images/kor/ico/<%=fileType[1]%>" /> <a
			href="javascript:downloadBlocking<%=uniqStr%>('<%=archiveEntity.M_IDX%>', '<%=attachNums[i]%>', '-1', '<%=attachNames[i]%>');"><%=attachNames[i]%></a></td>
		<td><%=fileType[2]%></td>
		<td><%=df.format(Double.parseDouble(attachSize[i])/1024)%>KB</td>
	</tr>
	<%
          } catch (ArrayIndexOutOfBoundsException e) {
              
          }
      }
%>
</table>
<%
    }
%>
</form>