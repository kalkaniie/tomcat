<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.nara.jdf.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="domainEntity" class="com.nara.jdf.db.entity.DomainEntity" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="/css/km5.css" />
<script type="text/javascript" src="/js/common/common.js"></script>
<script language=javascript>
function chkUserValue(){
  var objForm = document.f;
  if(objForm.isAgree1.checked != true){
    alert("회원약관에 동의 하셔야 가입하실 수 있습니다.");
    return;
  //}else if(objForm.isAgree2.checked != true){
  //	    alert("개인정보 취급방침에 동의 하셔야 가입하실 수 있습니다.");
  //	    return;  
  }else{
    objForm.submit();
  }
}
</script>

</head>
<body>
<form method=post name="f" action="user.public.do?method=show_conf_form">
<div class="k_joinUser"><img src="/images/kor/join/join_user.gif" />
<div>
<img src="/images/kor/join/join_userImg01.gif" />
<img src="/images/kor/join/join_step01On.gif" />
<img src="/images/kor/join/join_userImg02.gif" />
<img src="/images/kor/join/join_step02Off.gif" />
<img src="/images/kor/join/join_userImg03.gif" />
<img src="/images/kor/join/join_step03Off.gif" />
<img src="/images/kor/join/join_userImg04.gif" />
</div>
<div class="k_boxSp" style="width: 800px">
<div class="k_boxSpTop">
<img src="/images/kor/box/boxSp_cornersTl.gif" class="k_fltL" />
<img src="/images/kor/box/boxSp_cornersTr.gif" class="k_fltR" />
</div>
<div class="k_boxSpCont">
<div class="k_boxSpCont_in">

<fieldset class="k_fieldSet" style="padding: 5px 10px 5px;">
<legend class="k_legend">&nbsp; 회원가입약관&nbsp;</legend> <pre>
웹사이트의 회원으로 가입하세요. 보다 편리하고 알찬 서비스를 받으실 수 있습니다.

귀하가 입력하신 회원정보는 회원약관 과 개인정보정책에 의해 철저히 관리됩니다.
회원가입전, 아래의 이용자약관 및 개인정보보호정책을 반드시 읽어보시기 바랍니다.
</pre></fieldset>
<div class="k_joinPdg">
<p class="k_juTxInfo">가입을 원하시면 아래의 <b>‘약관’</b>을 반드시 확인 하신 후 <b>‘동의’</b>를 체크해 주세요.</p>
<textarea name="textarea2" style="width: 700px; height: 223px" readonly><%=domainEntity.DOMAIN_AGREEMENT_STMT%></textarea>
<p class="k_juAgree"><label><input type=checkbox name="isAgree1" value="Y"> 회원 약관에 동의합니다.</label></p>
</div>
<!--
<div class="k_joinPdg">
<p class="k_juTxInfo">가입을 원하시면 아래의 <b>'개인정보 수집 및 이용 사항'</b>을 반드시 확인
하신 후 <b>‘동의’</b>를 체크해 주세요.</p>
<textarea name="textarea2" style="width: 700px; height: 223px" readonly>
  ■ 수집하는 개인정보 항목
  본회는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.

  ο 수집항목
  - 이름 , 생년월일 , 로그인ID , 비밀번호 , 비밀번호 질문과 답변 , 자택 전화번호 , 자택 주소 , 휴대전화번호 ,
  이메일 , 직업 , 회사명 , 부서 , 회사전화번호 , 결혼여부 , 기념일 , 법정대리인정보 , 주민등록번호 ,
  서비스 이용기록 , 접속 로그 , 쿠키 
  ο 개인정보 수집방법
  - 홈페이지(회원가입,민원처리,게시판) , 생성정보 수집 툴을 통한 수집 

  ■ 개인정보의 수집 및 이용목적

  본회는 수집한 개인정보를 다음의 목적을 위해 활용합니다.

  ο 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산
  ο 콘텐츠 제공
  ο 회원 관리
  - 회원제 서비스 이용에 따른 본인확인, 개인 식별, 불량회원의 부정 이용 방지와 비인가 사용 방지,
  가입의사 확인, 연령확인, 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 불만처리 등 
  민원처리, 고지사항 전달
  ο 마케팅 및 광고에 활용
  - 이벤트 등 광고성 정보 전달, 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계

  ■ 개인정보의 보유 및 이용기간 본회는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를
  지체 없이 파기합니다.
  단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 본회는 관계법령이 정한 일정한 기간 동안
  회원정보를 보관합니다.

  - 계약 또는 청약철회 등에 관한 기록: 5년 
  - 대금결제 및 재화 등의 공급에 관한 기록: 5년 
  - 소비자의 불만 또는 분쟁처리에 관한 기록: 3년 
  - 방문에 관한 기록 : 3개월 
  - 보유기간을 이용자에게 미리 고지하거나 개별적으로 이용자의 동의를 받은 경우
  : 고지하거나 개별 동의한 기간 
  </textarea>
<p class="k_juAgree"><label><input type=checkbox name="isAgree2" value="Y"> 위 사항에 동의합니다.</label></p>
</div>
-->

<div class="k_juButn">
<a href="javascript:chkUserValue()" style="margin-left: 30px"><img src="/images/kor/btn/btnJoin_agree.gif" /></a> 
<a href="/"><img src="/images/kor/btn/btnJoin_agreeNot.gif" /></a>
</div>
</div>
</div>
<div class="k_boxSpBtm">
<img src="/images/kor/box/boxSp_cornersBl.gif" class="k_fltL" />
<img src="/images/kor/box/boxSp_cornersBr.gif" class="k_fltR" />
</div>
</div>
</div>
</form>
</body>
</html>