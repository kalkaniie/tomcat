var isDOM = (document.getElementById ? true : false); 
var isIE4 = ((document.all && !isDOM) ? true : false);
var isNS4 = (document.layers ? true : false);
var isNS = navigator.appName == "Netscape";	

// @param div_name : ���̾� �̸�
// @param left_pos : LEFT ���������� ���̾� ��ġ
// @param top_fromPos : TOP ���������� ���̾� �ʱ���ġ (�ʱ⿡ ���̾ ��ġ�ϴ� ��)
// @param top_toPos : ��ũ�ѽ� ���̾ �����ϰ� �� TOP ���������� �Ÿ��� (top_toPos ���Ϸ� �Ÿ��� �������� ���̾ �����̱� �����Ѵ�)
initLayer("floater", document.body.clientWidth/2 + 384, 160, 50);

function initLayer(div_name, left_pos, top_fromPos, top_toPos) {
	if (isNS4) {
		var floater = document[div_name];
		floater.top = top.pageYOffset + top_fromPos;		
		floater.visibility = "visible";
		moveRightEdge(top_fromPos);
	} else if (isDOM) {
		var floater = getRef(div_name);
		floater.style.top = (isNS ? window.pageYOffset : document.body.scrollTop) + top_fromPos;
		floater.style.left = left_pos;
		floater.style.visibility = "visible";
		moveRightEdge(top_fromPos, top_toPos);
	}	
}

function getRef(id) {
	if (isDOM) return document.getElementById(id);
	if (isIE4) return document.all[id];
	if (isNS4) return document.layers[id];
}

function moveRightEdge(top_fromPos, top_toPos) {
	var yMenuFrom, yMenuTo, yOffset, timeoutNextCheck;
	if (isNS4) {
		yMenuFrom   = floater.top;
		yMenuTo     = windows.pageYOffset+top_toPos;
	} else if (isDOM) {
		yMenuFrom   = parseInt (floater.style.top, 10);
		yMenuTo     = (isNS ? window.pageYOffset : document.body.scrollTop)+top_toPos;
	}
	
	if(yMenuTo < top_fromPos) 
		yMenuTo = top_fromPos;
	timeoutNextCheck = 600;

	if (yMenuFrom != yMenuTo) {
		yOffset = Math.ceil(Math.abs(yMenuTo - yMenuFrom) / 10);
		if (yMenuTo < yMenuFrom) 
			yOffset = -yOffset;
		if (isNS4) 
			floater.top += yOffset;
		else if (isDOM) 
			floater.style.top = parseInt (floater.style.top, 10) + yOffset;
		timeoutNextCheck = 10;
	}
	setTimeout ("moveRightEdge("+top_fromPos+","+top_toPos+")", timeoutNextCheck);
}