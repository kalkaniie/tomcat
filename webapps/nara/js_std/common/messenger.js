function show_pop_menu() {  // 우측/하단 여분길이계산, 필요시 커서좌측/상단출력
	//alert('show_pop_menu');
 var rightedge = document.body.clientWidth - event.clientX;  // 우측여분
 var bottomedge = document.body.clientHeight - event.clientY;  // 하단여분


 if (rightedge < mlAdd_buddy.offsetWidth) {  // 우측여분이 팝메뉴너비보다 작으면
  menuleft = document.body.scrollLeft + event.clientX - mlAdd_buddy.offsetWidth;
  mlAdd_buddy.style.left = menuleft;  // 커서x좌표에서 팝메뉴너비를 뺀 값을 팝메뉴x좌표로 할당
 } else {
  mlAdd_buddy.style.left = document.body.scrollLeft + event.clientX;
 }

 if (bottomedge < mlAdd_buddy.offsetHeight) {  // 팝메뉴의 y좌표를 할당한다.(위와동일)
  menutop = document.body.scrollTop + event.clientY - mlAdd_buddy.offsetHeight;
  mlAdd_buddy.style.top = menutop
 } else {
  mlAdd_buddy.style.top = document.body.scrollTop + event.clientY;
 }

 mlAdd_buddy.style.display = "block"; 
 return false;
}

function hide_pop_menu() {  // 팝메뉴숨김
	mlAdd_buddy.style.display = "none";
 //mlAdd_buddy.style.visibility = "hidden";
}

function highlight() {  // 커서가 위치시 활성스타일로
 if (event.srcElement.id == "menuitems") {
  event.srcElement.style.backgroundColor = "highlight";
  event.srcElement.style.color = "white";

  window.status = event.srcElement.url;
 }
}

function lowlight() {  // 커서가 벗어나면 비활성스타일로
 if (event.srcElement.id == "menuitems") {
  event.srcElement.style.backgroundColor = "";
  event.srcElement.style.color = "black";
  window.status = "";
 }
}

function jumpto() {  // 항목클릭시 해당URL로 이동
 if (event.srcElement.id == "menuitems") {
  if (event.srcElement.getAttribute("target") == null)
   window.location = event.srcElement.url;
  else
   window.open(event.srcElement.url, event.srcElement.getAttribute("target"));
  }
}