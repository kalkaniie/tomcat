
var menus = new Array();

function Menu(){
		this.id = "";
		this.subMenus = new Array();
		this.items = new Array();
		this.hasChildren = false;
		this.isChild = false;
		this.parentMenu = null;
		this.parentItem = null;
}

function Item(){
		this.id = "";
		this.hasMenu = false;
		this.menu = null;
		this.parentMenu = null;
}

function initMenu(){
	try{
		if(!document.all) return false;
		
		menuContainer.activeMenu = null;
		menuContainer.closeAll = closeAll;
		findMenus();
		attachMenus();
	}catch(e){}	
}

function findMenus(){
	       
		var cTag = menuContainer.children;
		for(var i=0; i < cTag.length; i++){
			tcTag = cTag[i];
			if(tcTag.className == "menu"){
				var tMenu = findSubMenus(tcTag);
				menus[menus.length] = tMenu;
			}
		}
		for(var i=0; i < menus.length; i++){
			var tcTag = menus[i]
			moveHTML(tcTag);
		}
		for(var i=0; i < menus.length; i++){
			var tcTag = menus[i];
			setupMenu(tcTag);
		}
}

function findSubMenus(menu){
		var cMenu = menu.children;
		var tMenu = new Menu();
		tMenu.id = menu.id;
		
		for(var i=0; i < cMenu.length; i++){
			var tcMenu = new Item();
			tcMenu.id = cMenu[i].id;
			if(tcMenu.id.indexOf("subMenu") != -1){
				++i;
				var subMenu = cMenu[i];
				tMenu.subMenus[tMenu.subMenus.length] = findSubMenus(subMenu)
				tMenu.subMenus[(tMenu.subMenus.length - 1)].isChild = true;
				tMenu.subMenus[(tMenu.subMenus.length - 1)].parentMenu = tMenu;
				tMenu.subMenus[(tMenu.subMenus.length - 1)].parentItem = tcMenu;				
				tMenu.hasChildren = true;
				tcMenu.hasMenu = true;
				tcMenu.menu = tMenu.subMenus[(tMenu.subMenus.length - 1)];
			}
			tcMenu.parentMenu = tMenu;
			tMenu.items[tMenu.items.length] = tcMenu;
		}
		return tMenu;
}

function moveHTML(menu){
		if(menu.hasChildren == true){
			for(var i=0; i < menu.subMenus.length; i++){
				moveHTML(menu.subMenus[i]);
			}
		}
		var tMenu = eval(menu.id);
		var tMenuHTML = tMenu.outerHTML;
		
		tMenu.outerHTML = "";
		menuContainer.innerHTML += tMenuHTML;
}

function setupMenu(menu){
	        if(menu.hasChildren == true){
			for(var i=0; i < menu.subMenus.length; i++){
				setupMenu(menu.subMenus[i]);
			}
		}
		
		tMenu = eval(menu.id);
		tMenu.hasChildren = menu.hasChildren;
		tMenu.hasVisibleChild = false;
		tMenu.visibleChild = null;
		tMenu.isChild = menu.isChild;
		tMenu.onselectstart = returnFalse;
		tMenu.onclick = handleMenuClick;
		
		for(var i=0; i < menu.items.length; i++){
			setupItem(menu.items[i]);
		}
		tMenu.style.pixelWidth += 20;
		
		for(var i=0; i < menu.items.length; i++){
			tItem = eval(menu.items[i].id);
			tItem.style.width = "100%";
			if(tItem.hasMenu == true) tItem.more.style.pixelLeft = (tMenu.offsetWidth - 17);
		}
		
		if(menu.isChild == true){
			tMenu.parentMenu = eval(menu.parentMenu.id);
			tMenu.parentItem = eval(menu.parentItem.id);
		}
}

function setupItem(item){
	
		tItem = eval(item.id);
		tItem.highlight = highlight;
		tItem.unhighlight = unhighlight;
		tItem.onmouseover = tItem.highlight;
		tItem.onmouseout = tItem.unhighlight;
		tItem.parentMenu = eval(item.parentMenu.id);
		tItem.hasMenu = false;
		tItem.menu = null;
		tItem.onclick = handleItemClick;
		tItem.ondragstart = returnFalse;
		
		if(item.hasMenu == true){
			tItem.innerHTML += "<span id=\"" + item.id + "_more\" class=\"more\">4</span>";
			tItem.more = eval(item.id + "_more");
			tItem.menu = eval(item.menu.id); 
			tItem.hasMenu = true;
		}
		
		tItem.parentMenu.style.pixelWidth = Math.max(tItem.parentMenu.style.pixelWidth, tItem.offsetWidth);
		
}

function highlight(){
		event.cancelBubble = true;
	
		this.className = "menuItemOver";

		// dont open a menu thats already open
		if((this.hasMenu == true) && (this.parentMenu.hasVisibleChild == true) && (this.parentMenu.visibleChild == this.menu)) return;
		
		// if there is a menu open, close it
		if(this.parentMenu.hasChildVisible == true){
			hideMenu(this.parentMenu.visibleChild);
		}
		
		// if this item has a menu, show it
		if(this.hasMenu){
			showMenu(this.menu);
		}
}

function unhighlight(){
		event.cancelBubble = true;
		this.className = "menuItem";
}

function showMenu(menu, x, y){
	  menuContainer.closeAll();
		event.cancelBubble = true;
		if(menu){
			if(menu.isChild == true){
				Menu.style.pixelTop = menu.parentItem.offsetTop + menu.parentMenu.offsetTop + 4;
				menu.style.pixelLeft = menu.parentMenu.offsetLeft + menu.parentMenu.offsetWidth - 4;
				menu.parentMenu.hasChildVisible = true;
				menu.parentMenu.visibleChild = menu;
				menu.style.zIndex = menu.parentMenu.style.zIndex + 1;
			} else if(x && y){
		  		menu.style.pixelTop = y;
				menu.style.pixelLeft = x;
				menuContainer.activeMenu = menu;
				document.onclick = menuContainer.closeAll;
			} 
		} else {
			menu = eval(this.menu);
			menu.style.pixelTop = event.clientY+document.body.scrollTop;
			menu.style.pixelLeft = event.clientX;
			menuContainer.activeMenu = menu;
			document.onclick = menuContainer.closeAll;
		}
		menu.className = "visibleMenu";
		//resizeFrame("file",0,230);
		return false;
}

function hideMenu(menu){
		// to handle the careless child menu hiding down below
		if(menu == null) return false;
		event.cancelBubble = true;

		// i do this kind of carelessly.  i was having trouble otherwise
		hideMenu(menu.visibleChild);

		if(menu.isChild == true){
			menu.parentMenu.hasChildVisible = false;
			menu.parentMenu.visibleChild = null;
		} else {
		  document.onclick = "";
		  menuContainer.activeMenu = null;
		}
		menu.className = "menu";
		//resizeIframe("file",0,230);
}

function closeAll(){
		hideMenu(menuContainer.activeMenu);
}

// simple function to return false
function returnFalse(){return false;}

// function to be used for later functionality
// for now it just keeps the menu open when it receives a click;
function handleMenuClick(){
		event.cancelBubble = true;
		return false;
		
}

// just like the function above, only it closes the menu
function handleItemClick(){
		event.cancelBubble = true;
		menuContainer.closeAll();
}

// searches the document for elements with a menu paramater
function attachMenus(){
	        for(var i in document.all){
			if(document.all[i].menu){
				document.all[i].onclick = showMenu;
			}
		}
}

/*문자열 내 공백 제거*/
function trim(str){
  return str.replace(/(^\s+)|(\s+)$/,"");
}

function setUserMenu(nNum,USERS_IDX,USERS_NAME,B_EMAIL){
  USERS_IDX = trim(USERS_IDX);
  USERS_NAME = trim(USERS_NAME);
  B_EMAIL = trim(B_EMAIL);
  document.write("<div id='usermenu"+nNum+"' class='menu'>\n");
  document.write("<div id='menuItem"+nNum+"_1' class='menuItem'><a href=javascript:onClick=showUserInfo('"+USERS_IDX+"')>상세정보보기</a></div>\n");
  document.write("<div id='menuItem"+nNum+"_2' class='menuItem'><a href='webmail.WebMailServ?cmd=sendto&M_TO="+USERS_NAME+" <"+B_EMAIL+">'>메일 보내기</a></div>\n");
  document.write("<div id='menuItem"+nNum+"_3' class='menuItem'><a href=javascript:onClick=registAddress('"+USERS_IDX+"','"+USERS_NAME+"')>주소록 추가</a></div>\n");
  document.write("</div>");
}

/*frame 스크롤이 안보이도록 사이즈 조절
하위 프레임에서 호출
@param name (프레임명)
@param 프레임 최소크기
*/
function resizeIframe(name,min_width,min_height){
  var oBody =  document.body;
  var oFrame = parent.document.all(name); 
  if(oFrame != null){
    var i_height = oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);
    var i_width = oBody.scrollWidth + (oBody.offsetWidth-oBody.clientWidth);
    if(i_height < min_height) i_height = min_height;
    if(i_width < min_width) i_width = min_width;
    oFrame.style.height = i_height;
    oFrame.style.width = i_width;
  }
}