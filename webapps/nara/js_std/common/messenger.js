function show_pop_menu() {  // ����/�ϴ� ���б��̰��, �ʿ�� Ŀ������/������
	//alert('show_pop_menu');
 var rightedge = document.body.clientWidth - event.clientX;  // ��������
 var bottomedge = document.body.clientHeight - event.clientY;  // �ϴܿ���


 if (rightedge < mlAdd_buddy.offsetWidth) {  // ���������� �˸޴��ʺ񺸴� ������
  menuleft = document.body.scrollLeft + event.clientX - mlAdd_buddy.offsetWidth;
  mlAdd_buddy.style.left = menuleft;  // Ŀ��x��ǥ���� �˸޴��ʺ� �� ���� �˸޴�x��ǥ�� �Ҵ�
 } else {
  mlAdd_buddy.style.left = document.body.scrollLeft + event.clientX;
 }

 if (bottomedge < mlAdd_buddy.offsetHeight) {  // �˸޴��� y��ǥ�� �Ҵ��Ѵ�.(���͵���)
  menutop = document.body.scrollTop + event.clientY - mlAdd_buddy.offsetHeight;
  mlAdd_buddy.style.top = menutop
 } else {
  mlAdd_buddy.style.top = document.body.scrollTop + event.clientY;
 }

 mlAdd_buddy.style.display = "block"; 
 return false;
}

function hide_pop_menu() {  // �˸޴�����
	mlAdd_buddy.style.display = "none";
 //mlAdd_buddy.style.visibility = "hidden";
}

function highlight() {  // Ŀ���� ��ġ�� Ȱ����Ÿ�Ϸ�
 if (event.srcElement.id == "menuitems") {
  event.srcElement.style.backgroundColor = "highlight";
  event.srcElement.style.color = "white";

  window.status = event.srcElement.url;
 }
}

function lowlight() {  // Ŀ���� ����� ��Ȱ����Ÿ�Ϸ�
 if (event.srcElement.id == "menuitems") {
  event.srcElement.style.backgroundColor = "";
  event.srcElement.style.color = "black";
  window.status = "";
 }
}

function jumpto() {  // �׸�Ŭ���� �ش�URL�� �̵�
 if (event.srcElement.id == "menuitems") {
  if (event.srcElement.getAttribute("target") == null)
   window.location = event.srcElement.url;
  else
   window.open(event.srcElement.url, event.srcElement.getAttribute("target"));
  }
}