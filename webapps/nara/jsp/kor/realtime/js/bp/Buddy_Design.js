/* UACONFIG관련 정보를 HTML로 표현한다.
	uaconfArr[0] : 이름
	uaconfArr[1] : 대화명
	uaconfArr[2] : 핸드폰번호
*/


function setUAConfigHTML(uaconfArr)
{
	//parent.$('displayname').innerText= uaconfArr[1];
    parent.setDisplayName(uaconfArr[1]);
	UAConfig_Flag = 1;
}

