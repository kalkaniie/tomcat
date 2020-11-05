function Folder(folderDescription, hreference, target, IDX) //constructor
{
  this.usergroupidx = IDX;
  //constant data
  this.desc = folderDescription
  this.hreference = hreference
  this.target = target
  this.id = -1
  this.navObj = 0
  this.iconImg = 0
  this.nodeImg = 0
  this.isLastNode = 0

  //nobreak added
  this.absIconSrc = ""

  //dynamic data
  this.isOpen = true
  this.iconSrc = "../image/kor/tree/file_folderclosed.gif"
  this.children = new Array
  this.nChildren = 0
	//sj data
	this.del_folder_msg = ''
	//sj data end
	
  //methods
  this.initialize = initializeFolder
  this.setState = setStateFolder
  this.addChild = addChild
  this.createIndex = createEntryIndex
  this.hide = hideFolder
  this.display = display
  this.renderOb = drawFolder
  this.totalHeight = totalHeight
  this.subEntries = folderSubEntries
  this.outputLink = outputFolderLink
}


function setStateFolder(isOpen)
{
  var subEntries
  var totalHeight
  var fIt = 0
  var i=0

  if (isOpen == this.isOpen)
    return

  if (browserVersion == 2)
  {
    totalHeight = 0
    for (i=0; i < this.nChildren; i++)
      totalHeight = totalHeight + this.children[i].navObj.clip.height
      subEntries = this.subEntries()
    if (this.isOpen)
      totalHeight = 0 - totalHeight
    for (fIt = this.id + subEntries + 1; fIt < nEntries; fIt++)
      indexOfEntries[fIt].navObj.moveBy(0, totalHeight)
  }
  this.isOpen = isOpen
  propagateChangesInState(this)
}

function propagateChangesInState(folder)
{
  var i=0

  if (folder.isOpen)
  {
    if (folder.nodeImg)
      if (folder.isLastNode)
        folder.nodeImg.src = "../image/kor/file_mlastnode.gif"
      else
	  folder.nodeImg.src = "../image/kor/file_mnode.gif"
    if(folder.absIconSrc == "" )
      folder.iconImg.src = "../image/kor/file_folderopen.gif"
     else if(folder.absIconSrc == "../image/kor/file_folderclosed.gif")
      folder.iconImg.src = "../image/kor/file_folderopen.gif"
    else if(folder.absIconSrc == "../image/kor/file_foldershare.gif")
      folder.iconImg.src = "../image/kor/file_folderopenshare.gif"
    else
      folder.iconImg.src = folder.absIconSrc
    for (i=0; i<folder.nChildren; i++)
      folder.children[i].display()
  }
  else
  {
    if (folder.nodeImg)
      if (folder.isLastNode)
        folder.nodeImg.src = "../image/kor/file_plastnode.gif"
      else
	    folder.nodeImg.src = "../image/kor/file_pnode.gif"
    if(folder.absIconSrc == "")
      folder.iconImg.src = "../image/kor/file_folderclosed.gif"
    else
      folder.iconImg.src = folder.absIconSrc
    for (i=0; i<folder.nChildren; i++)
      folder.children[i].hide()
  }
}

function hideFolder()
{
  if (browserVersion == 1) {
    if (this.navObj.style.display == "none")
      return
    this.navObj.style.display = "none"
  } else {
    if (this.navObj.visibility == "hiden")
      return
    this.navObj.visibility = "hiden"
  }

  this.setState(0)
}

function initializeFolder(level, lastNode, leftSide)
{
var j=0
var i=0
var numberOfFolders
var numberOfDocs
var nc

  nc = this.nChildren

  this.createIndex()

  var auxEv = ""

  if (browserVersion > 0)
    auxEv = "<a href='javascript:clickOnNode("+this.id+")'>"
  else
    auxEv = "<a>"

  if (level>0)
    if (lastNode) //the last 'brother' in the children array
    {
      this.renderOb(leftSide + auxEv + "<img name='nodeIcon" + this.id + "' src='../image/kor/file_mlastnode.gif' border=0 align=absmiddle></a>")
      leftSide = leftSide + "<img src='../image/kor/file_blank.gif' width=16 height=20>"
      this.isLastNode = 1
    }
    else
    {
      this.renderOb(leftSide + auxEv + "<img name='nodeIcon" + this.id + "' src='../image/kor/file_mnode.gif' border=0 align=absmiddle></a>")
      leftSide = leftSide + "<img src='../image/kor/file_vertline.gif'>"
      this.isLastNode = 0
    }
  else
  {
    this.renderOb("")
  }

  if (nc > 0)
  {
    level = level + 1
    for (i=0 ; i < this.nChildren; i++)
    {
      if (i == this.nChildren-1)
        this.children[i].initialize(level, 1, leftSide)
      else
        this.children[i].initialize(level, 0, leftSide)
      }
  }
}

function aaa(form)
{
 len = form.elements.length;
 var str = "";
 var cnt = 0;
 for( var i=0; i <len; i++)
 {
   if(form.elements[i].name == "USER_GROUP_NAME")
   {
     
     if(form.elements[i].checked && form.elements[i].value.length >= 1)
     {
       
       cnt++;
       str = form.elements[i].value; 
      
       if(cnt >1)
       {
        alert("한번에 한그룹씩 선택하여 추가를 할 수 있습니다.");
         return;
       }
     } 
   }
 } 
 //alert(str);
 document.f.str.value = str;
}

function drawFolder(leftSide)
{
  if (browserVersion == 2) {
    if (!doc.yPos)
      doc.yPos=8
    doc.write("<layer id='folder" + this.id + "' top=" + doc.yPos + " visibility=hiden>")
  }

  doc.write("<table ")
  if (browserVersion == 1)
    doc.write(" id='folder" + this.id + "' style='position:block;' ")
  doc.write(" border=0 cellspacing=0 cellpadding=0>")
  doc.write("<tr><td nowrap>")
  doc.write(leftSide)
//  this.outputLink()
  if(this.id !== 0 )
  doc.write("<input type=checkbox name=USER_GROUP_NAME value='"+this.usergroupidx+"' onclick='javascript:aaa(this.form)'>")
  doc.write("<a href='"+this.hreference+"' target='"+this.target+"'")
  if( this.target != "")
    doc.write(" onClick='javascript:clickOnFolder("+this.id+")'");
  doc.write("><img name='folderIcon" + this.id + "' ")
  doc.write("src='" + this.iconSrc+"' border=0 align=absmiddle></a>")
//  doc.write("</a>")
  doc.write("</td><td valign=middle nowrap>")
  doc.write(" ")

  if (USETEXTLINKS)
  {
    this.outputLink()
    doc.write("<a href='"+this.hreference+"' target='"+this.target+"'")
    if( this.target != "")
      doc.write(" onClick='javascript:clickOnFolder("+this.id+")'");
    doc.write(" class=css_k>"+this.desc + "</a>")
  }
  else
  doc.write(this.desc)

  doc.write("</td>")
  doc.write("</table>")

  if (browserVersion == 2) {
    doc.write("</layer>")
  }

  if (browserVersion == 1) {
    this.navObj = doc.all["folder"+this.id]
    this.iconImg = doc.all["folderIcon"+this.id]
    this.nodeImg = doc.all["nodeIcon"+this.id]
  } else if (browserVersion == 2) {
    this.navObj = doc.layers["folder"+this.id]
    this.iconImg = this.navObj.document.images["folderIcon"+this.id]
    this.nodeImg = this.navObj.document.images["nodeIcon"+this.id]
    doc.yPos=doc.yPos+this.navObj.clip.height
  }
}

function outputFolderLink()
{
  if (this.hreference)
  {
    doc.write("<a href='" + this.hreference + "'")
    if (browserVersion > 0)
      doc.write("onClick='javascript:clickOnFolder("+this.id+")'")
    doc.write(">")
  }
  else
    doc.write("<a>")
}

function addChild(childNode)
{
  this.children[this.nChildren] = childNode
  this.nChildren++
  return childNode
}

function folderSubEntries()
{
  var i = 0
  var se = this.nChildren

  for (i=0; i < this.nChildren; i++){
    if (this.children[i].children) //is a folder
      se = se + this.children[i].subEntries()
  }

  return se
}


// Definition of class Item (a document or link inside a Folder)
// *************************************************************

function Item(itemDescription, itemLink) // Constructor
{
  // constant data
  this.desc = itemDescription
  this.link = itemLink
  this.id = -1 //initialized in initalize()
  this.navObj = 0 //initialized in render()
  this.iconImg = 0 //initialized in render()

  this.iconSrc = "../image/kor/file_folderclosed.gif"

  //sj data
  this.item_del_msg = ''
  //sj data end

  // methods
  this.initialize = initializeItem
  this.createIndex = createEntryIndex
  this.hide = hideItem
  this.display = display
  this.renderOb = drawItem
  this.totalHeight = totalHeight
}

function hideItem()
{
  if (browserVersion == 1) {
    if (this.navObj.style.display == "none")
      return
    this.navObj.style.display = "none"
  } else {
    if (this.navObj.visibility == "hiden")
      return
    this.navObj.visibility = "hiden"
  }
}

function initializeItem(level, lastNode, leftSide)
{
  this.createIndex()

  if (level>0)
    if (lastNode) //the last 'brother' in the children array
    {
      this.renderOb(leftSide + "<img src='../image/kor/file_lastnode.gif'>")
      leftSide = leftSide + "<img src='../image/kor/file_blank.gif'>"
    }else {
      this.renderOb(leftSide + "<img src='../image/kor/file_node.gif'>")
      leftSide = leftSide + "<img src='../image/kor/file_vertline.gif'>"
    }
  else
  {
    this.renderOb("")
  }
  
}

function drawItem(leftSide)
{
  if (browserVersion == 2)
  {
    doc.write("<layer id='item" + this.id + "' top=" + doc.yPos + " visibility=hiden>")
  }
  doc.write("<table ")
  if (browserVersion == 1)
    doc.write(" id='item" + this.id + "' style='position:block;' ")
  doc.write(" border=0 cellspacing=0 cellpadding=0>")
  doc.write("<tr><td nowrap>")
  doc.write(leftSide + "<a href='" + this.link + "' target='"+this.target+"'><img id='itemIcon"+this.id+"' src='"+this.iconSrc+"' border=0></a>")
  doc.write("</td><td valign=middle nowrap>")
  doc.write(" ")

  if (USETEXTLINKS)
    doc.write("<a href='" + this.link + "' target='file' class=css_k>" + this.desc + "</a>")
  else
    doc.write(this.desc)
  
  doc.write("</td>")
  doc.write("</table>")

  if (browserVersion == 2)
    doc.write("</layer>")

  if (browserVersion == 1) {
    this.navObj = doc.all["item"+this.id]
    this.iconImg = doc.all["itemIcon"+this.id]
  } else if (browserVersion == 2) {
    this.navObj = doc.layers["item"+this.id]
    this.iconImg = this.navObj.document.images["itemIcon"+this.id]
    doc.yPos=doc.yPos+this.navObj.clip.height
  }
}


// Methods common to both objects (pseudo-inheritance)
// ********************************************************

function display()
{
  if (browserVersion == 1){
    this.navObj.style.display = "block";

  }else
    this.navObj.visibility = "show"
}

function createEntryIndex()
{
  this.id = nEntries
  indexOfEntries[nEntries] = this
  nEntries++
}

// total height of subEntries open
function totalHeight() //used with browserVersion == 2
{
  var h = this.navObj.clip.height
  var i = 0

  if (this.isOpen) //is a folder and _is_ open
    for (i=0 ; i < this.nChildren; i++)
      h = h + this.children[i].totalHeight()

  return h
}


// Events
// *********************************************************

function clickOnFolder(folderId)
{
  var clicked = indexOfEntries[folderId]

  if (!clicked.isOpen)
    clickOnNode(folderId)

  return

  if (clicked.isSelected)
    return
}

function clickOnNode(folderId)
{
  var clickedFolder = 0
  var state = 0

  clickedFolder = indexOfEntries[folderId]
  state = clickedFolder.isOpen

  clickedFolder.setState(!state) //open<->close
}

function initializeDocument()
{
  if (doc.all)
    browserVersion = 1 //IE4
  else
    if (doc.layers)
      browserVersion = 2 //NS4
    else
      browserVersion = 0 //other

  aux0.initialize(0, 1, "")
  aux0.display()

  if (browserVersion > 0)
  {
    doc.write("<layer top="+indexOfEntries[nEntries-1].navObj.top+">&nbsp;</layer>")

    // close the whole tree
    clickOnNode(0)
    // open the root folder
    clickOnNode(0)
  }
}

// Auxiliary Functions for Folder-Treee backward compatibility
// *********************************************************

function gFld(description, hreference, target, IDX)
{
  folder = new Folder(description, hreference, target, IDX)
  return folder
}

function gFld2(description, hreference, iconsrc, target )
{
  IDX = "";
  folder = new Folder(description, hreference, target, IDX)
  folder.absIconSrc = iconsrc
  return folder
}

function gFld3(description, hreference, iconsrc, target)
{
  folder = new Folder(description, hreference, target)
  return folder
}


function gLnk(description, linkData, target)
{
  fullLink = "'"+linkData+"' TARGET='"+target+"'"
  linkItem = new Item(description, fullLink)
  return linkItem
}

function gLnk2(description, linkData, iconsrc, target)
{
  fullLink = "'"+linkData+"' TARGET='"+target+"'"
  linkItem = new Item(description, fullLink)
  linkItem.iconSrc = iconsrc
  return linkItem
}

function insFld(parentFolder, childFolder)
{
  return parentFolder.addChild(childFolder)
}

function insDoc(parentFolder, document)
{
  parentFolder.addChild(document)
}


// folder open
// ***********

function preOPEN(name, value)
{
  keyword = name+"="+value
  thisGroupID = getID(keyword)
  openFolder(thisGroupID)
}

function preOPENParent(name, value)
{
  keyword = name+"="+value
  thisGroupID = getID(keyword)
  openFolder(getParentID(thisGroupID))
}

function openFolder(childID)
{
  if(childID != 0)
  {
    if(indexOfEntries[childID].hreference != null)
      clickOnFolder(childID) // open this Folder
    parentID = getParentID(childID)
    openFolder(parentID) // search parent
  }
}

function getParentID(childID)
{
  parentID = 0
  for(i=0; i<childID; i++)
  {
    if(indexOfEntries[i].hreference != null)
    {
      for(j=0; j<indexOfEntries[i].children.length; j++)
      {
        if(indexOfEntries[i].children[j].id == childID) // got it
        {
          parentID = indexOfEntries[i].id
        }
      }
    }
  }
  return parentID
}

function getID(keyword)
{
  tempURL = ""
  foundID = 0
  for(i=0; i<indexOfEntries.length; i++)
  {
    if(indexOfEntries[i].hreference != null)
      tempURL = indexOfEntries[i].hreference
    else if(indexOfEntries[i].link != null)
     tempURL = indexOfEntries[i].link
    if(tempURL.indexOf(keyword) != -1)
    {
      foundID = indexOfEntries[i].id
      break;
    }
  }
  return foundID
}

// Global variables
// ****************

USETEXTLINKS = 1
indexOfEntries = new Array
nEntries = 0
doc = document
browserVersion = 0
selectedFolder=0