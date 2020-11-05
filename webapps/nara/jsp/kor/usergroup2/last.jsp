<%@ page language="java"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.nara.springframework.service.UsersService"%>

<jsp:useBean id="userGroupEntity"
	class="com.nara.jdf.db.entity.UserGroupEntity" scope="request" />
<link rel="stylesheet" type="text/css"
	href="/js/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css"
	href="/js/ext/examples/examples.css" />


<script type="text/javascript" src="/js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/js/ext/ext-all.js"></script>
<script type="text/javascript" src="/js/tree/admin_user_group.js"></script>
<script type="text/javascript" src="/js/ext/examples/examples.js"></script>



<script language="JavaScript">

var rootName ="<%= userGroupEntity.USER_GROUP_NAME%>";
var rootNode ="<%= userGroupEntity.USER_GROUP_IDX%>";


function registGroup() {
  var objForm = document.f;
  var link = "usergroup.admin.do?method=regist_form&USER_GROUP_IDX="+objForm.USER_GROUP_IDX.value;
  window.open( link ,"pop","scrollbars=yes,status=no,toolbar=no,width=670,height=600");
}

function modify(){			// �׷�d������
  objForm = document.f;

  objForm.USER_GROUP_NAME.value = objForm.str.value.substring(1,objForm.str.value.length-1);
  var list = objForm.str.value.split('$'); 
  if(list.length == 1){
  	alert("�׷�; �����Ͽ� �ֽʽÿ�.");
  }else if(list.length != 2)
  {
    alert("2�� �̻��� �׷�; ������ �� ��4ϴ�.");
    return;
  } else if(objForm.str.value == '') {
    alert("�׷�; ������ �ֽʽÿ�.");
    return;
  } else {
    objForm.USER_GROUP_IDX.value = objForm.groupstr.value;
    var link = "usergroup.admin.do?method=modify_form&USER_GROUP_IDX="+objForm.USER_GROUP_IDX.value;
    window.open( link ,"modify","status=no,toolbar=no,scrollbars=yes,resizable=no,width=670,height=600");
  }

}

function deleteGroup(){
  objForm = document.f;

  var list = objForm.str.value.split('$'); 
  if(list.length != 2)
  {
    alert("2�� �̻��� �׷�; ������ �� ��4ϴ�.");
    return;
  } else if(objForm.str.value.length < 1)
  {
    alert("�׷�; ������ �ֽʽÿ�.");
    return;
  }else{
    var isDel = confirm('������ �׷�; ��f �Ͻðڽ4ϱ�?');
    if(isDel){
      location.href = "usergroup.admin.do?method=deleteGroup&USER_GROUP_IDX="+objForm.groupstr.value;
    }
  }
}

function deleteUser(){
  objForm = document.list.f;
  if(objForm == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(objForm.USER_GROUP_IDX == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(objForm.USER_GROUP_IDX.value == 0){
    alert("���� �ֻ�' �׷��Դϴ�. �׷�; �����Ͻʽÿ�.");
    return;
  }else if(!isCheckedOfBox(objForm,"USERS_IDX")){
    alert("��f�� /�� �����Ͻʽÿ�.");
    return;
  }else{
    var isDel = confirm('������ /�� �׷쿡�� f�� �Ͻðڽ4ϱ�?');
    if(isDel){
      objForm.cmd.value="remove";
      objForm.action = "usergroup.UserGroupListServ";
      objForm.submit();
    }
  }
}

function checkAll(){
  objForm = document.list.f;
  if(objForm == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(objForm.USER_GROUP_IDX == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(objForm.elements != null){
    len = objForm.elements.length;
    for ( var i = 0; i < len; i++ ){
      if(objForm.elements[i].name == "USER_GROUP_IDX"){
       objForm.elements[i].checked = document.f.chkall.checked;
      }
	}
  }
}

function selectGroup(){
  objForm = document.list.f;
  if(objForm == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(objForm.USER_GROUP_IDX == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(!isCheckedOfBox(objForm, "USERS_IDX")){
    alert("�̵��� ����ڸ� �����ϼ���.");
    return;
  }
  var link = "usergroup.admin.do?method=usergroup_wiew_pop";
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=350,height=360");
}

function intranetGroup(){
  objForm = document.list.f;
  if(objForm == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(objForm.USER_GROUP_IDX == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(!isCheckedOfBox(objForm, "USERS_IDX")){
    alert("�̵��� ����ڸ� �����ϼ���.");
    return;
  }
  var link = "intranet.OrganizeServ?cmd=intranetGroup";
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=450");
}

function copyGroup(){
  objForm = document.list.f;
  if(objForm == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(objForm.USER_GROUP_IDX == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(!isCheckedOfBox(objForm, "USERS_IDX")){
    alert("������ ����ڸ� �����ϼ���.");
    return;
  }
  var link = "usergroup.admin.do?method=copyGroup";
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=450");
}

function selectPublic(){
  objForm = document.list.f;
  if(objForm == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(objForm.USER_GROUP_IDX == null){
    alert("���� ����Ʈ; ��n�4� ���Դϴ�.��� ��ٷ� �ֽʽÿ�");
    return;
  }
  if(!isCheckedOfBox(objForm, "USERS_IDX")){
    alert("������ ����ڸ� �����ϼ���.");
    return;
  }
  var link = "address.PublicGroupServ?cmd=selectPublicGroup";
  window.open( link ,"move","status=no,toolbar=no,scrollbars=yes,resizable=yes,width=400,height=450");
}

function search(){
  var objForm = document.sear;
  var listForm = document.list.f;
  if(objForm.strIndex.value== ""){
    alert("�˻�ɼ�; �����ϼ���.");
    objForm.strIndex.focus();
    return;
  }else if(objForm.strKeyword.value == ""){
    alert("�˻� �Է��ϼ���.");
    objForm.strKeyword.focus();
    return;
  }
  var check_value =0;
  if(objForm.strIndex[0].checked)
    check_value = "USERS_NAME";
  else check_value = "USERS_ID";

  listForm.action="usergroup.UserGroupListServ";
  listForm.strIndex.value = check_value;
  listForm.strKeyword.value = objForm.strKeyword.value;
  listForm.strType.value = objForm.strType.value;
  listForm.submit();
}


//�⺻��8�� ������ �̸��� '$'�� ������ �Ǿ ���� ����ȴ�.
//��/�ּҷ� : !
//v�� : $
//�ּҷ� : #
function sendmail(){
  objForm = document.f;
  objListForm = document.list.f;

  var isUser = false;
  var isGroup = false;

  len = objListForm.elements.length;
  lenb = objForm.elements.length;
  objForm.M_TO.value = "";
  
//alert(objForm.str.value);
  
  objForm.USER_GROUP_NAME.value = objForm.str.value;
  if(objForm.USER_GROUP_NAME.value.length > 1)
  {
    objForm.M_TO.value=objForm.USER_GROUP_NAME.value;
    isGroup = true;
  }
  objForm.cmd.value="sendto";
  objForm.action="webmail.WebMailServ";
  objForm.target="_parent";
  for ( var i = 0; i < len; i++ ){
    if(objListForm.elements[i].name == "USERS_IDX"){
      if(objListForm.elements[i].checked){
        objForm.M_TO.value=objForm.M_TO.value+objListForm.elements[i].value+",";
        isUser = true;
      }
    }
  }

  if(isGroup && isUser)
  {
    alert("�׷�� ����ڸ� ���ÿ� ������ �� ��4ϴ�");
    return;
  }

  if(!isGroup && !isUser)
  {
    alert("���Ϲ߼� ����ڸ� �����ϼ���.");
    return;
  }

  //objForm.M_TO.value = objForm.M_TO.value.substring(0,objForm.M_TO.value.length-1);
  objForm.submit();
}


function sendSms_old()
{
    objForm = document.f;
    objListForm = document.list.f;
    if(!isCheckedOfBox(objListForm, "USERS_IDX"))
    {
        alert("SMS�� �߼��� ����ڸ� �����ϼ���.");
        return;
    }

    len = objListForm.elements.length;
    objForm.receiveHpValue.value = "";
    objForm.receiveHpText.value = "";
    for ( var i = 0; i < len; i++ )
    {
        if(objListForm.elements[i].name == "USERS_IDX")
        {
            if(objListForm.elements[i].checked)
            {
                if(objListForm.elements[i+1].name == "USERS_CELLNO" && objListForm.elements[i+1].value != "")
                {
                    if(checkMobileNumber(objListForm.elements[i+1].value) != 'none')
                        valid_number = checkMobileNumber(objListForm.elements[i+1].value);
                    else
                    {
                        alert("/ȿ���� ��: �ڵ��� ��ȣ�� ���� �Ǿ� �ֽ4ϴ�!\n["+objListForm.elements[i+1].value+"]");
                        continue;
                    }

                    objForm.receiveHpValue.value=objForm.receiveHpValue.value+valid_number+",";
                    objForm.receiveHpText.value=objForm.receiveHpText.value+valid_number+",";
                }
            }
        }
    }


  objForm.receiveHpValue.value = objForm.receiveHpValue.value.substring(0,objForm.receiveHpValue.value.length-1);
  objForm.receiveHpText.value = objForm.receiveHpText.value.substring(0,objForm.receiveHpText.value.length-1);
  objForm.action = "/nara/servlet/sms.SmsServ?cmd=sms_01_010cb";
  objForm.target="_parent";
  objForm.submit();
}

function sendSms()
{
   objForm = document.f;
   //alert(objForm.str.value + ":" + objForm.groupstr.value);
   var phone_text = objForm.str.value.split(',');
   var phone_value = objForm.groupstr.value.split(',');
   
   //������ �ʱ�ȭ
   objForm.receiveHpText.value = "";
   objForm.receiveHpValue.value = "";
   for(var i=0; i < phone_text.length; i++) {
      if(phone_text[i].length > 0) {
          //alert(phone_text[i].substring(1, phone_text[i].length) + ":" + phone_value[i]);
          objForm.receiveHpValue.value = objForm.receiveHpValue.value+"$|"+phone_value[i]+",";
          objForm.receiveHpText.value = objForm.receiveHpText.value+"[�׷�]"+phone_text[i].substring(1, phone_text[i].length)+",";
      }
   }
//alert(objForm.receiveHpText.value + ":" + objForm.receiveHpValue.value);
   objForm.action = "/nara/servlet/sms.SmsServ?cmd=sms_01_010cb";
   objForm.submit();
}

function aa(){
//var tree=Ext.getCmp('1'); 
	var bb = Ext.query('input:checked')
	//var bb = Ext.query('input:contains')
	for(i=0; i<bb.length;i++){
		//alert(bb[i].parentNode.getAttribute('ext:tree-node-id'));
		//alert(bb[i].previousSibling.textContent);
		
		alert(  bb[i].offsetParent.textContent);
		//alert(  Ext.get('ser'));
		//alert(bb[i].parentNode.parentNode.parentNode.innerText);
		//alert(bb[i].parentNode.parentNode.parentNode.textContent);
		//alert(bb[i].parentNode.textContent);
		
	}	
}	
</script>
<a href="javascript:aa()">click node</a>
<div id="tree-div"
	style="overflow: auto; height: 300px; width: 250px; border: 1px solid #c3daf9;"></div>
<%--
<form name="f" action='usergroup.admin.do' method=post >
<input type=hidden name="cmd" value="main">
<input type=hidden name="USER_GROUP_IDX" value="<%=userGroupEntity.USER_GROUP_IDX%>">
<input type=hidden name="M_TO" value="">
<input type=hidden name=receiveHpValue value=''>
<input type=hidden name=receiveHpText value=''>
<input type=hidden name="USER_GROUP_NAME" value="">
<input type=hidden name="str" value="">
<input type=hidden name="USER_GROUP_IDX_SELECT" value="">
<input type=hidden name="groupstr" value="">

<div id="mb">
<h2 class="titTop2">�ý��۰� <strong>v���</strong>
  <hr />
</h2>
<ul>
<li>�ϰ��� �� ����ڸ� �ڵ�8�� �׷��� ���ָ�, ����� v��; ���� �� �ֽ4ϴ�.</li>
</ul>
   <table class="admin02_box">
     <tr>
       <td>
					<div id="tree-div" style="overflow:auto; height:300px;width:250px;border:1px solid #c3daf9;"></div>
       </td>
       <td>
       <iframe name="list" src="usergrouplist.admin.do?method=usergroup_list_main" scrolling="auto" frameborder="NO" border="0" marginwidth="0" marginheight="0" width=490 height="610" ></iframe>
       
       
 </div>
  
  <div class="admin01_sBox" style="margin:10px 15px 0"> 
     <input type="radio" name="radio" id="radio" value="radio" />
     <label for="radio">�̸�</label>&nbsp;&nbsp;&nbsp;
     <input type="radio" name="radio2" id="radio2" value="radio2" />
     <label for="radio2">ID</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <select>
       <option>��ü�׷�</option>
       <option>����׷�</option>
     </select> 
    <input type="text" style="width:180px" class="intx00"/>
   <a href="#"><img src="/images/btn/btnA_search.gif" /></a></div>
  
       </td>
       </tr>
   </table>
  <div class="floatR" style="padding:10px 5px">
		<span class="floatR">
		<a href='javascript:onClick=selectGroup()'><img src="/images/btn/btnC_groupIn.gif"></a>
		<a href='javascript:onClick=deleteUser()'><img src="/images/btn/btnC_groupOut.gif" class="st_btn2"/></a> 
		<a href="javascript:onClick=sendmail();"><img src="/images/btn/btnC_mailWrite2.gif" /></a> 
		<% if(UsersService.isValidModule(request,"sms")){ %>
		<a href="javascript:onclick=sendSms();"><img src="/images/btn/btnC_smsSend.gif" /></a>
		<%}%>
		</span></div>
  <p class="floatR" style="padding:10px 5px">
  <a href='javascript:onClick=registGroup()'><img src="/images/btn/btnC_groupCreat.gif"/> </a>
  <a href='javascript:onClick=modify()'><img src="/images/btn/btnC_groupInfoModify.gif"/></a> 
  <a href='javascript:onClick=deleteGroup()'><img src="/images/btn/btnC_groupDele.gif" class="st_btn2" /></a> 
  <a href="javascript:onClick=intranetGroup();"><a href="#" onclick="MM_openBrWindow('admin105_popCopyIntra.html','','width=350,height=400')" ><img src="/images/btn/btnC_copyIntra.gif" /></a> 
  <a href="javascript:onClick=selectPublic();"><a href="#" onclick="MM_openBrWindow('admin105_popCopyIntra.html','','width=350,height=400')"><img src="/images/btn/btnC_copyCommAdr.gif" /></a> </p>

</div>
--%>