<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="cmd" class="java.lang.String" scope="request" />
<jsp:useBean id="users_idx" class="java.lang.String" scope="request" />
<jsp:useBean id="gubun" class="java.lang.String" scope="request" />
<jsp:useBean id="yyyymm" class="java.lang.String" scope="request" />
<jsp:useBean id="cur_page" class="java.lang.String" scope="request" />
<jsp:useBean id="rownum" class="java.lang.String" scope="request" />
<jsp:useBean id="list_cnt" class="java.lang.String" scope="request" />
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="list2" class="java.util.ArrayList" scope="request" />

<%
    String target = "/nara/servlet/sms01";
    String img_path = "/nara/img/kor/sms";
    int msgLength = 80;
%>
<div id="tooltip" style="display:none;position:absolute;left:22; top:178; width:165; height:160; z-index:1; visibility: hidden"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
<tr> 
    <td height="215" valign=top><iframe name="fContent" height="100%" width="100%" frameborder=0 scrolling="no"></iframe></td>
</tr>
</table>
</div>
<SCRIPT LANGUAGE=JavaScript src=../js/sms/sms_tooltip.js></SCRIPT>

<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}

function checkAll(){
  objForm = document.f;
  len = objForm.elements.length;
 
  for ( var i = 0; i < len; i++ ){
    if(objForm.elements[i].name == "msgkey"){
      objForm.elements[i].checked = objForm.chkall.checked;
    }
  }
}


function deleteResult(){
  if(!isCheckedOfBox(document.f, "msgkey")) {
    alert("��f�� �޽��� �������ֽʽÿ�.");
  } else {
    if(confirm("��f�Ͻðڽ4ϱ�?"))
    {
       document.f.cmd.value = "sms_01_020d";
       document.f.submit();
    } else
    {}
  }
}

function js_go()
{
   var val = document.selectform.select.options[document.selectform.select.selectedIndex].value;
   location.href="<%=target%>?cmd=sms_01_020&cur_page=<%=cur_page%>&gubun=<%=gubun%>&rownum=<%=rownum%>&yyyymm="+val;
}



function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}  



function setText(str)
{
    var re, sq, dq, bs;	
	re = /cR_/g;
	sq = /sQ_/g;
	dq = /dQ_/g;
	bs = /bS_/g;
	r1 = str.replace(re, "\r\n");	
	r1 = r1.replace(sq, "'");	
	r1 = r1.replace(dq, "\"");	
	r1 = r1.replace(bs, "\\");
	
	location.href="<%=target%>?cmd=sms_01_010cb&msg_str="+r1;	    
}

//-->
</script>


<!-- ���� -->
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
<tr>
    <td height="22" bgcolor="00D5F3">&nbsp;&nbsp;<span class="style2"> <img src="../image/kor/main_index_arrow.gif" width="10" height="12" align="absmiddle"> ����'ġ : <a href="/nara/servlet/sms01?cmd=sms_01_010cb" class="css_h">SMS</a> &gt; </span><span class="top_text_location">SMS ��۰�� Ȯ��</span></td>
</tr>
<tr>
    <td height="5" bgcolor="#FFFFFF"></td>
</tr>
<tr>
    <td align="right" bgcolor="#FFFFFF">
    <table width="99%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="9" align="left" valign="top" background="../image/kor/main_def_tabl_a_bg.gif"><img src="../image/kor/main_def_tabl_a_00.gif" width="9" height="228"></td>
        <td valign="top" background="../image/kor/main_def_tabl_a_bg.gif">
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" bgcolor="#FFFFFF">
            <table width="100%" height="92"  border="0" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td width="10" align="left" background="../image/kor/main_def_tabl_title_bg.gif"><img src="../image/kor/main_def_tabl_title_00.gif" width="10" height="92"></td>
                <td background="../image/kor/main_def_tabl_title_bg.gif">
                <table width="98%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                    <table width="98%" height="53"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td background="../image/kor/main_def_tabl_title_02.gif">
                        <table width="100%" height="53"  border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td height="6"></td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle">
                            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="20"><img src="../image/kor/main_def_icon_00.gif" width="7" height="9" align="absmiddle"> <span class="style13">SMS ��۰�� Ȯ�� �Ͻ� �� �ֽ4ϴ�.</span></td>
                            </tr>
                            </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="4"></td>
                        </tr>
                        </table>
                        </td>
                        <td width="9" align="right"><img src="../image/kor/main_def_tabl_title_01.gif" width="9" height="53"></td>
                    </tr>
                    </table>
                    </td>
                </tr>
                <tr>
                    <td height="11"></td>
                </tr>
                <tr>
                    <td>
                    <table width="98%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="6" height="6"><img src="../image/kor/main_def_tabl_h_00.gif" width="6" height="6"></td>
                            <td height="6" background="../image/kor/main_def_tabl_h_01.gif"></td>
                            <td width="6" height="6"><img src="../image/kor/main_def_tabl_h_02.gif" width="6" height="6"></td>
                        </tr>
                        <tr>
                            <td width="6" background="../image/kor/main_def_tabl_h_03.gif">&nbsp;</td>
                            <td height="22" valign="middle">&nbsp;�� <strong><%=list_cnt%>��</strong>�� �˻�Ǿ�4ϴ�. </td>
                            <td width="6" background="../image/kor/main_def_tabl_h_04.gif">&nbsp;</td>
                        </tr>
                        <tr>
                            <td width="6" height="6"><img src="../image/kor/main_def_tabl_h_05.gif" width="6" height="6"></td>
                            <td height="6" background="../image/kor/main_def_tabl_h_06.gif"></td>
                            <td width="6" height="6"><img src="../image/kor/main_def_tabl_h_07.gif" width="6" height="6"></td>
                        </tr>
                        </table>
                        </td>
                    </tr>
                    </table>
                    </td>
                    <td width="228" align="right" background="../image/kor/main_def_tabl_title_bg.gif"><img src="../image/kor/main_def_tabl_title_sms.gif" width="228" height="92"></td>
                </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF">
                <table width="97%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="10"></td>
                </tr>
                <tr>
                    <td height="36" align="left" background="../image/kor/main_tab_00_bg.gif">
                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td >
                        <%
                            if(gubun.equals("1"))
                            {
                        %>
                        <a href="/nara/servlet/sms01?cmd=sms_01_020&cur_page=<%=cur_page%>&gubun=1&rownum=<%=rownum%>"><img src="../image/kor/sms/main_sms_butt_tab_00_a.gif" width="94" height="36" border=0 align="absmiddle"></a><a href="/nara/servlet/sms01?cmd=sms_01_020&cur_page=<%=cur_page%>&gubun=2&rownum=<%=rownum%>"><img src="../image/kor/sms/main_sms_butt_tab_01_b.gif" width="94" height="36" border=0 align="absmiddle"></a></td>
                        <%
                            } else
                            {
                        %>
                        <a href="/nara/servlet/sms01?cmd=sms_01_020&cur_page=<%=cur_page%>&gubun=1&rownum=<%=rownum%>"><img src="../image/kor/sms/main_sms_butt_tab_00_b.gif" width="94" height="36" border=0 align="absmiddle"></a> 
                        <a href="/nara/servlet/sms01?cmd=sms_01_020&cur_page=<%=cur_page%>&gubun=2&rownum=<%=rownum%>"><img src="../image/kor/sms/main_sms_butt_tab_01_a.gif" width="94" height="36" border=0 align="absmiddle"></a></td>
                        <%
                            }
                        %>
						</td>
<form name=selectform method=post>                        
                        <td align="right" valign="bottom">
<%
    if(gubun.equals("1"))
    {
%>                        
                        <select name=select class="boxline00" onChange="javascript:js_go();">
<%
    String tbl_name = null;
    String yyyymm2 = null;
    if(list2.size() > 0)
    {
        for(int adx=0; adx<list2.size(); adx++)
        {
            tbl_name = (String)list2.get(adx);
            yyyymm2 = tbl_name.substring(tbl_name.lastIndexOf("_")+1);
            //out.println(Format.selectOption(yyyymm2,yyyymm,DateTime.getFormatDate(yyyymm2, "yyyy-MM")));

%>
                        <option value='<%=yyyymm2%>' <%if(yyyymm2.equals(yyyymm)){%> selected<%}%>><%=DateTime.getFormatDate(yyyymm2, "yyyy-MM")%></option>
<%                
        }
    } else
    {
        out.println("<option></option>");
    }
%>
                    </select>
<%
    }
%> 
</form>                   
                    </td>
                </tr>
                <tr>
                    <td height="2"></td>
                    <td height="2"></td>
                </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td>
                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="20%" height="3" bgcolor="9DC9D1"></td>
                    <td width="20%" height="3" bgcolor="9DC9D1"></td>
                    <td width="20%" bgcolor="9DC9D1"></td>
                    <td width="20%" bgcolor="9DC9D1"></td>
                    <td width="20%" bgcolor="9DC9D1"></td>
                </tr>
                <tr>
                    <td height="2"></td>
                    <td height="2" align="center"></td>
                    <td align="center"></td>
                    <td align="center"></td>
                    <td align="center"></td>
                </tr>
                <tr bgcolor="D5E4E4">
                    <td height="1"></td>
                    <td height="1"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
<form method="post" name="f" action="<%=target%>">
<input type=hidden name=cmd value=''>
<input type=hidden name=yyyymm value='<%=yyyymm%>'>
<input type=hidden name=rownum value='<%=rownum%>'>
<input type=hidden name=gubun value='<%=gubun%>'>
<input type=hidden name=cur_page value='<%=cur_page%>'>                
                <tr bgcolor="F2F7F7">
                    <td height="22">
                    <table width="100%" height="22"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center"><strong>�Ͻ�</strong></td>
                        <td width="1" bgcolor="D5E4E4"></td>
                    </tr>
                    </table>
                    </td>
                    <td>
                    <table width="100%" height="22"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center"><strong>����ڹ�ȣ</strong></td>
                        <td width="1" bgcolor="D5E4E4"></td>
                    </tr>
                    </table>
                    </td>
                    <td>
                    <table width="100%" height="22"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center"><strong>�޽���</strong></td>
                        <td width="1" bgcolor="D5E4E4"></td>
                    </tr>
                    </table>
                    </td>
                    <td>
                    <table width="100%" height="22"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center"><strong>/��</strong></td>
                        <td width="1" bgcolor="D5E4E4"></td>
                    </tr>
                    </table>
                    </td>
                    <td align="center"><strong>��Ȳ</strong></td>
                </tr>
                <tr bgcolor="D5E4E4">
                    <td height="1"></td>
                    <td height="1"></td>
                    <td></td>
                    <td></td>
                    <td align="center"></td>
                </tr>
<%
    if(list.size()<=0)
    {
    
%>     
                <tr>
                    <td colspan=5 height="22" align=center><%if(gubun.equals("1")){%>�߼۵� <%}else{%>������� <%}%> �޼��� ��4ϴ�.</td>
                </tr>           
<%
    } else
    {
         SMS_MSG item = null;
         String type1 = null;
         String type2 = null;
         
         int len = 0;
         String phone1 = null;
         String phone2 = null;
         String phone3 = null;
         for(int idx=0; idx<list.size(); idx++) 
         {    
             item = (SMS_MSG) list.get(idx);
             if(item.etc2.equals("1"))
                type1 = "����߼�";
             else
                type1 = "��ù߼�";
                
            if(item.rslt == null || item.rslt.equals(""))
            {
                type2 = "�����";
            } else
            {
             
                if(item.rslt.equals("0"))
                    type2 = "Bind����";
                else if(item.rslt.equals("1"))
                    type2 = "�ý������";
                else if(item.rslt.equals("2"))
                    type2 = "�������";
                else if(item.rslt.equals("3"))
                    type2 = "�޼�����Ŀ7�";
                else if(item.rslt.equals("4"))
                    type2 = "Bind�ȵ�";
                else if(item.rslt.equals("5"))
                    type2 = "����� �̵��";
                else if(item.rslt.equals("6"))
                    type2 = "����";
                else if(item.rslt.equals("7"))
                    type2 = "����,���,����d��";
                else if(item.rslt.equals("8"))
                    type2 = "�ܸ������OFF";                
                else if(item.rslt.equals("9"))
                    type2 = "��Ÿ����";
                else if(item.rslt.equals("12"))
                    type2 = "10�ʴ� �޼��� ��۷� �ʰ�";
                else if(item.rslt.equals("16"))
                    type2 = "���Թ�ȣ";
                else if(item.rslt.equals("30"))
                    type2 = "�޼���/ȿ�ð��ʰ�";
                else if(item.rslt.equals("31"))
                    type2 = "��ȣ�7�";
                else if(item.rslt.equals("32"))
                   type2 = "SMS_NUMLIST�� ��ϵ� ����";
                else if(item.rslt.equals("33"))
                   type2 = "�޽��� ������ 24�ð����� �4��=";
                else if(item.rslt.equals("99"))
                   type2 = "�ĺ�f";
                else 
                    type2="��Ÿ����";
            }
                
             if(gubun.equals("1"))
             {
                len = item.phone.length();
                if(len == 11)
                {
                   phone1 = item.phone.substring(0, 3);
                   phone2 = item.phone.substring(3, 7);
                   phone3 = item.phone.substring(7); 
                   item.phone = phone1+"-"+phone2+"-"+phone3;
                }
                else if(len == 10)
                {
                   phone1 = item.phone.substring(0, 3);
                   phone2 = item.phone.substring(3, 6);
                   phone3 = item.phone.substring(6); 
                   item.phone = phone1+"-"+phone2+"-"+phone3;
                }
             }
%>
                <tr>
                    <td>
                    <table width="100%" height="22"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center"><%=item.reqdate%> </td>
                        <td width="1" bgcolor="D5E4E4"></td>
                    </tr>
                    </table>
                    </td>
                    <td align="left">
                    <table width="100%" height="22"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center"><a href="<%=target%>?cmd=sms_01_010cb&phone=<%=item.phone%>"><%=item.phone%></a> </td>
                        <td width="1" bgcolor="D5E4E4"></td>
                    </tr>
                    </table>
                    </td>
                    <td>
                    <table width="100%" height="22"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center"><a onmouseover="showTip('<%=item.msgkey%>')" onmouseout="hideTip()" href="javascript:setText('<%=translate(item.msg)%>');"><%=HtmlUtil.fixLength(item.msg, 22)%></a></td>
                        <td width="1" bgcolor="D5E4E4"></td>
                    </tr>
                    </table>
                    </td>
                    <td>
                    <table width="100%" height="22"  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center"><%=type1%></td>
                        <td width="1" bgcolor="D5E4E4"></td>
                    </tr>
                    </table>
                    </td>
                    <td align="center"><%=type2%></td>
                </tr>
                <tr bgcolor="D5E4E4">
                    <td height="1"></td>
                    <td height="1"></td>
                    <td></td>
                    <td></td>
                    <td align="center"></td>
                </tr>
<%
        }
    }
%>                
</form>
                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2"></td>
                </tr>
                <tr>
                    <td height="1" bgcolor="D5E4E4"></td>
                </tr>
                <tr>
                    <td height="5" bgcolor="F2F7F7"></td>
                </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td>
                <!-----{{����}} ���������� �ϴܹ�ư�� �������̺�------->
                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="6"></td>
                </tr>
                <tr>
                    <td>
                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="6" height="6"><img src="../image/kor/main_def_tabl_h_00.gif" width="6" height="6"></td>
                        <td height="6" background="../image/kor/main_def_tabl_h_01.gif"></td>
                        <td width="6" height="6"><img src="../image/kor/main_def_tabl_h_02.gif" width="6" height="6"></td>
                    </tr>
                    <tr>
                        <td width="6" background="../image/kor/main_def_tabl_h_03.gif">&nbsp;</td>
                        <td>
                        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="left">&nbsp;&nbsp;&nbsp;<%=HtmlUtil.setPageNumber(Double.parseDouble(list_cnt), Integer.parseInt(rownum), Integer.parseInt(cur_page), "")%></td>
                        </tr>
                        </table>
                        </td>
                        <td width="6" background="../image/kor/main_def_tabl_h_04.gif">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="6" height="6"><img src="../image/kor/main_def_tabl_h_05.gif" width="6" height="6"></td>
                        <td height="6" background="../image/kor/main_def_tabl_h_06.gif"></td>
                        <td width="6" height="6"><img src="../image/kor/main_def_tabl_h_07.gif" width="6" height="6"></td>
                    </tr>
                    </table>
                    </td>
                </tr>
                </table>
                <!-----{{��}} ���������� �ϴܹ�ư�� �������̺�------->
                </td>
            </tr>
            <tr>
                <td height="2"></td>
            </tr>
            <tr>
                <td> </td>
            </tr>
            <tr>
                <td height="8">&nbsp;</td>
            </tr>
            </table>
            </td>
        </tr>
        <tr>
            <td align="center" bgcolor="#FFFFFF">&nbsp;</td>
        </tr>
        </table>
        </td>
            <td width="9" align="right" valign="top" background="../image/kor/main_def_tabl_a_bg.gif"><img src="../image/kor/main_def_tabl_a_01.gif" width="9" height="228"></td>
    </tr>
    </table>
    </td>
</tr>
</table>
<!-- �� -->
<form name=form method=post>
      <div style="display:none">
<%
    SMS_MSG item2 = null;
    for(int i=0; i<list.size(); i++)
    {
        item2 = (SMS_MSG) list.get(i);
%>
        <textarea name="content_<%=item2.msgkey%>"><%=item2.msg%></textarea>
<%
    }
%>
      </div>
</form>
<script>
function call(cur_page)
{
	document.paging_form.cur_page.value = cur_page;	
	document.paging_form.submit();
}
</script>
<FORM NAME=paging_form ACTION='/nara/servlet/sms01?cmd=<%=cmd%>' METHOD='post'>
<INPUT type=hidden name=cur_page value=''>
<INPUT type=hidden name=yyyymm value='<%=yyyymm%>'>
<INPUT type=hidden name=gubun value='<%=gubun%>'>
<INPUT type=hidden name=rownum value='<%=rownum%>'>
</FORM>
<script>
document.onmousemove=movetip;
</script>

<%!
public final static String translate(String s) 
{
    if ( s == null ) return null;

    StringBuffer buf = new StringBuffer();
    char[] c = s.toCharArray();
    int len = c.length;
    for ( int i=0; i < len; i++) 
    {
        if      ( c[i] == '\n' ) buf.append("cR_");
        else if ( c[i] == '\'') buf.append("sQ_");
        else if ( c[i] == '"' ) buf.append("dQ_");
        else if ( c[i] == '\\' ) buf.append("bS_");       
        else buf.append(c[i]);
    }
    return buf.toString();
}
%>