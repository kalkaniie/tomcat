/*
    대화 참여중인 User 들을 Hash 에 저장
*/
function js_curtUserSet(szIndex, curtID)
{
    var currIDHashVal = curtIDHash.get(szIndex);
    if(currIDHashVal == null)
    {   
        curtID = curtID + "";
        curtIDHash.set(szIndex, curtID);
    } 	  
    //alert('ddddddddd' + curtID);
} 

/*
    대화 참여중인 User 들을 Hash 에 추가 저장
*/
function js_curtUserAdd(szIndex, curtID)
{
    var currIDAddVal = "";
    var currIDHashVal = curtIDHash.get(szIndex);

    if(Object.isUndefined(currIDHashVal) || currIDHashVal == "") {

        currIDAddVal = curtID + "";
        curtIDHash.set(szIndex, currIDAddVal);

    } else {

        currIDAddVal = currIDHashVal +","+ curtID + "";

        curtIDHash.set(szIndex, currIDAddVal);
        var uniqCurrIDVal = curtIDHash.get(szIndex).split(",").uniq()+"";
        
        curtIDHash.set(szIndex, uniqCurrIDVal);
    }
   	//alert(curtIDHash.get(szIndex)+"명");
    return curtIDHash.get(szIndex).split(",").size();
} 

/*
    대화 참여중인 User 들을 Hash 에서 제거
*/
function js_curtUserUnset(szIndex, rmUser)
{   
    var curtIDHashVal = curtIDHash.get(szIndex);
		//alert(curtIDHashVal+"222명");

    if(!Object.isUndefined(curtIDHashVal))
    {

        var arrCurtUser = curtIDHashVal.split(",");  
        var curtUserSize = arrCurtUser.size();
        var arrNewCurtUserRm;
    
        if (curtUserSize > 1) { 
            arrNewCurtUserRm = arrCurtUser.without(rmUser);
            arrNewCurtUserRm = arrNewCurtUserRm + "";
            
            curtIDHash.set(szIndex, arrNewCurtUserRm);
        }
    }
    
    return curtUserSize;
} 

/*
    대화창 관리 
*/
function js_curtDialogSet(dialogueID, buddyID)
{

    var revsDialogueID = js_revsChkDialogue(dialogueID);
    
    dialogueHash.set(dialogueID, buddyID);
    dialogueHash.set(revsDialogueID, buddyID);
    
} 

/*
   현재 채팅하고 있는 User 
*/
function getCurtRecvUsers() {

    var recvusers = "";

    if(recvIDArray != null) {
        recvIDArray.each(function(value){
                                        
                                        recvusers =  value + "," + recvusers
                                   
                                        });
    }
    return recvusers;
}

/*
    대화창 아이디 변경
*/
function js_revsChkDialogue(dialogueID)
{
    var arrRevs = dialogueID.split("_");
    var chkDialogueID =arrRevs[1]+"_"+arrRevs[0];

	return chkDialogueID;
}


function replaceAll(originalString, findText, replaceText){

        var pos = 0
        var preStr = ""
        var postStr = ""

        pos = originalString.indexOf(findText)

        while (pos != -1) {
                preString = originalString.substr(0,pos)
                postString = originalString.substring(pos+findText.length)
                originalString = preString + replaceText + postString
                pos = originalString.indexOf(findText)
        }

        return originalString
 }