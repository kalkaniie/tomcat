var isSaveTempMail = false;
function pageEventHandler(){
  if(isSaveTempMail){
    var objForm = document.f;
    if((objForm.M_TO != null && objForm.M_TO.value.length > 0 )
      || (objForm.M_TITLE != null && objForm.M_TITLE.value.length > 0 )
      || (objForm.content != null && objForm.content.value.length > 0 )){
      var isValid = confirm("다른 페이지로 이동합니다.\n작성된 메일을 임시보관함에 보관하시겠습니까?");
      if(isValid){
        saveTempMail();
      }
    }
  }
}