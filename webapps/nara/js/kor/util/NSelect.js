var UserAgent = navigator.userAgent;
var AppVersion = (((navigator.appVersion.split('; '))[1].split(' '))[1]);

// default NSelect style
var SL_ActiveIDX = null;
var SL_Focused = null;
var SL_FocusedIDX = null;
var SL_Table = " cellspacing=0 cellpadding=0 border=0";
var SL_Text = "text-indent:2px;padding-top:3px;";
var SL_IPrefix = "http://i.dreamwiz.com/img/wd/ca/";
var SL_AImage = "arrow.gif";
var SL_BImage = "blank.gif";
var SL_SBLen = 10;
var SL_SBWidth = 18;
var SL_ScrollBar = ""
    +"scrollbar-face-color:#ffffff;"
    +"scrollbar-shadow-color:A3A2A2;"
    +"scrollbar-highlight-color:#FFFFFF;"
    +"scrollbar-3dlight-color:E0E0E0;"
    +"scrollbar-darkshadow-color:#F6F6F6;"
    +"scrollbar-track-color:#F6F6F6;"
    +"scrollbar-arrow-color:#A3A2A2;";

var SL_BGColor = "#FEFFCB";
var SL_BGColor_M = "#225688";
var SL_Border = "1px solid #AFB086";
var SL_FontSize = "10pt";
var SL_FontColor = "#000000";
var SL_Height = "18px";

SList = new Array();
document.write( "<div id=NSDiv style='position:absolute;top:-100px;z-index:3;'></div>" );

// set SL Style 
function setEnv( pSrc, pBG, pBM, pBD, pAI )
{
    var oEnv = new Object();
    var oSrc = createObject( pSrc );

    if( oSrc.style.width ) {
	oEnv.Width = oSrc.style.width;
    } else {
	document.all.NSDiv.innerHTML = ""
	    +"<table style='top:2px;'><tr><td height=1>"+pSrc+"</td></tr></table>";
	oEnv.Width = document.all.NSDiv.scrollWidth;
    }
    if( oSrc.style.height ) oEnv.Height = oSrc.style.height; else oEnv.Height = SL_Height;
    if( oSrc.style.fontSize ) oEnv.FontSize = oSrc.style.fontSize; else oEnv.FontSize = SL_FontSize;
    if( oSrc.style.color ) oEnv.FontColor = oSrc.style.color; else oEnv.FontColor = SL_FontColor;

    if( pBG ) oEnv.BGColor = pBG;	else oEnv.BGColor = SL_BGColor;
    if( pBM ) oEnv.BGColor_M = pBM;	else oEnv.BGColor_M = SL_BGColor_M;
    if( pBD ) oEnv.Border = pBD;	else oEnv.Border = SL_Border;
    if( pAI ) oEnv.AImage = pAI;	else oEnv.AImage = SL_AImage;

    return oEnv;
}

// parameter NSelect
function NSelect( HTMLSrc, KIN, BG, BM, BD, AI )
{
    if ( UserAgent.indexOf( "MSIE" ) < 0 || AppVersion < 5 ) {
	document.write( HTMLSrc );
	return;
    } else {
	var SE = setEnv( HTMLSrc, BG, BM, BD, AI );
	var SListObj = new setNSelect( HTMLSrc, KIN, SE );
	SListObj.append();

	return SListObj;
    }
}

function appendSList()
{
    document.write("<div id=TempDiv></div>\n");
    document.all.TempDiv.appendChild( this.Table );
    document.all.TempDiv.removeNode();

    return;
}

function MouseScrollHandler() {
    var f_titleObj = SList[SL_FocusedIDX].Title;
    var f_itemObj = SList[SL_FocusedIDX].Items;
    var idx_length = f_itemObj.options.length;
    var idx_selected = f_itemObj.options.selectedIndex ;

    CancelEventHandler( window.event );

    if( window.event.wheelDelta > 0 ) {
	idx_selected = Math.max( 0, --idx_selected );
    } else {
	idx_selected = Math.min( idx_length - 1, ++idx_selected );
    }

    if( f_itemObj.options.selectedIndex != idx_selected ) {
	f_itemObj.options.selectedIndex = idx_selected;
	SList[SL_FocusedIDX].ChangeTitle();
	if( f_itemObj.onchange ) f_itemObj.onchange();
    }

    return;
}

function ActiveIDXHandler() {
    if( SL_ActiveIDX == null ) {
	for( i = 0; i < SList.length; i++ ) {
	    SList[i].List.style.display = "none";
	    if( i == SL_Focused ) TitleHighlightHandler( i, 1 );
	    else TitleHighlightHandler( i, 0 );
	}

	if( SL_Focused == null )
	    document.detachEvent( 'onclick', ActiveIDXHandler );
    }
    if( SL_Focused == null ) document.detachEvent( 'onmousewheel', MouseScrollHandler );
    else document.attachEvent( 'onmousewheel', MouseScrollHandler );

    SL_ActiveIDX = null;
    SL_Focused = null;

    return;
}

function TitleClickHandler()
{
    SL_ActiveIDX = this.entry;

    for( i = 0; i < SList.length; i++ ) {
	if( i == SL_ActiveIDX ) {
	    if( SList[i].List.style.display == "block" ) {
		SList[i].List.style.display = "none";
		TitleHighlightHandler( i, 1 );
		SL_Focused = i;
		SL_FocusedIDX = i;
	    } else SList[i].List.style.display = "block";
	} else {
	    SList[i].List.style.display = "none";
	    TitleHighlightHandler( i, 0 );
	}
    }

    document.detachEvent( 'onclick', ActiveIDXHandler );
    document.attachEvent( 'onclick', ActiveIDXHandler );

    return;
}

function TitleMouseOverHandler()
{
    this.Title.children(0).cells(2).children(0).style.filter = "";
    if( !this.kin ) this.Title.style.border = "1 solid #CBCBCB";

    return;
}

function TitleMouseOutHandler()
{
    this.Title.children(0).cells(2).children(0).style.filter = "alpha( opacity=80 );";
    if( !this.kin ) this.Title.style.border = "1 solid #A0A0A0";

    return;
}

function TitleHighlightHandler( entry, t )
{
    if( t ) {
	if( this.kin )
	    SList[entry].Title.children(0).cells(0).style.background = SList[entry].env.BGColor;
	else 
	    SList[entry].Title.children(0).cells(0).style.background = SList[entry].env.BGColor_M;
    } else {
	SList[entry].Title.children(0).cells(0).style.background = SList[entry].env.BGColor;
    }

    return;
}

function ListMouseDownHandler( f )
{
    var tObj = this.Title.children(0);
    var length = this.Items.length;

    for( i = 0; i < length; i++ ) {
	this.Items.options[i].selected = false;
	if ( i == f.idx ) {
	    this.Items.options[i].selected = true;
	    this.ChangeTitle();
	}
    }
    if( this.Items.onchange ) this.Items.onchange();
    if ( this.kin && ( length - 1 ) == f.idx )
	location.href = this.Items.options[f.idx].value;

    this.List.style.display = "none";

    SL_Focused = this.entry;
    SL_FocusedIDX = this.entry;

    return;
}

function ListMouseOverHandler( f )
{
    if( this.kin ) f.style.color = "#FFFFFF";
    f.style.background = this.env.BGColor_M;
    return;
}

function ListMouseOutHandler( f )
{
    f.style.color = this.env.FontColor;
    f.style.background = this.env.BGColor;
    return;
}

function CancelEventHandler( e )
{
    e.cancelBubble = true;
    e.returnValue = false;

    return;
}

function ModifyDivHandler() {
    var width = parseInt( this.Title.style.width );

    this.Items.style.width = null;
    document.all.NSDiv.innerHTML = ""
	+"<table style='top:2px;'><tr><td height=1>"+this.Items.outerHTML+"</td></tr></table>";
    var scrollWidth = parseInt( document.all.NSDiv.scrollWidth );

    if( scrollWidth > width ) {
	this.Title.style.width = scrollWidth;
	this.List.style.width = scrollWidth;
    }

    return;
}

function ChangeTitleHandler() {
    var newTitle = this.Items.options[this.Items.options.selectedIndex].innerHTML ;
    this.Title.children(0).cells(0).innerHTML = "<nobr>"+newTitle+"</nobr>";

    return;
}

function ChangeListHandler() {
    var length = this.Items.length;
    var item = "";

    var listHeight = parseInt( this.env.Height ) * Math.min( SL_SBLen, length ) + 2;
    var overflowY = ( length > SL_SBLen ) ? "scroll" : "hidden";

    this.List.innerHTML = "";
    for( i = 0; i < this.Items.options.length; i++ ) {
	item = ""
	    +"<DIV idx="+i+" style='height:"+this.env.Height+";"+SL_Text+"'"
	    +"  onMouseDown='SList["+this.entry+"].ListMouseDown( this );'"
	    +"  onMouseOver='SList["+this.entry+"].ListMouseOver( this );'"
	    +"  onMouseOut='SList["+this.entry+"].ListMouseOut( this );'>"
	    +"    <nobr>"+this.Items.options[i].innerText+"</nobr>"
	    +"</DIV>";
	oItem = createObject( item );
	this.List.appendChild( oItem );
    }

    this.List.style.height = listHeight;
    this.List.style.overflowY = overflowY;

    return;
}

function AddOptionHandler( sText, sValue, iIndex ) {
    var oOption = document.createElement("OPTION");
    this.Items.options.add(oOption, iIndex);

    oOption.innerText = sText;
    oOption.value = sValue;

    return;
}

function setNSelect( pSrc, pKIN, pSE )
{
    this.entry = SList.length;
    this.lower = null;
    this.src = pSrc;
    this.env = pSE;
    this.kin = pKIN;

    // NSelect Object
    this.Items;
    this.Title;
    this.List;
    this.Table;

    // Create NSelect Element
    this.ItemObj = createObject;
    this.ListObj  = createList;
    this.TitleObj = createTitle;
    this.TableObj = createSList;

    // NSelect EventHandler
    this.TitleClick = TitleClickHandler;
    this.TitleMouseOver = TitleMouseOverHandler;
    this.TitleMouseOut = TitleMouseOutHandler;
    this.ListMouseDown = ListMouseDownHandler;
    this.ListMouseOver = ListMouseOverHandler;
    this.ListMouseOut = ListMouseOutHandler;
    this.CancelEvent = CancelEventHandler;

    // NSelect Function
	  this.select = Selected;
    this.ModifyDiv = ModifyDivHandler;
    this.ChangeTitle = ChangeTitleHandler;
    this.ChangeList = ChangeListHandler;
    this.AddOption = AddOptionHandler;

    this.append = appendSList; 
    this.Table = this.TableObj();

    SList[this.entry] = this;

    return;
}

function createObject( pSrc )
{
    oObj = new Object();
    oObj.Div = document.createElement("DIV");
    oObj.Div.insertAdjacentHTML("afterBegin", pSrc);

    return oObj.Div.children(0);
}

function createTitle()
{
    var length = this.Items.length;

    for ( i = 0; i < length; i++ ) {
	if (this.Items.options[i].selected) {
	    SIName = this.Items.options[i].innerText;
	    SIValue = this.Items.options[i].value;
	}
    }

    this.Title = createObject(""
	+"<DIV id=title style='width:"+this.env.Width+";overflow-X:hidden;position:relative;left:0px;top:0px;"
	+"border:"+this.env.Border+";cursor:default;background:"+this.env.BGColor+";'"
	+"	onClick='SList["+this.entry+"].TitleClick( window.event );'"
	+"	onMouseOver='SList["+this.entry+"].TitleMouseOver( window.event );'"
	+"	onMouseOut='SList["+this.entry+"].TitleMouseOut( window.event );'"
	+">"
        +"<table height="+this.env.Height+" "+SL_Table+" style='table-layout:fixed;text-overflow:hidden;'>"
	+"<tr>"
        +"    <td style='width:100%;font-size:"+this.env.FontSize+";color:"+this.env.FontColor+";"+SL_Text+"'><nobr>"+SIName+"</nobr></td>"
        +"    <td style='display:none;'></td>"
        +"    <td align=center valign=center width="+SL_SBWidth+"><img src='"+SL_IPrefix+this.env.AImage+"' border=0 style='Filter:Alpha( Opacity=80 )'></td>"
	+"</tr>"
	+"</table>"
	+"</DIV>");

    oTitle_Sub = createObject(""
	+"<img style='position:absolute;top:1px;left:0;width:"+this.env.Width+";height:"+this.env.Height+";'"
	+"    ondragstart='SList["+this.entry+"].CancelEvent( window.event );'"
	+" src='"+SL_IPrefix+SL_BImage+"'>");

    this.Title.childNodes(0).cells(1).appendChild( this.Items );
    this.Title.childNodes(0).cells(2).appendChild( oTitle_Sub );

    return;
}

function createList()
{
    var ListDiv = ""
	+"<DIV id=list style='position:absolute;z-index:2;display:none;background:"+this.env.BGColor+";"
	+"border:"+this.env.Border+";font-size:"+this.env.FontSize+";color:"+this.env.FontColor+";cursor:default;"
	+"width:"+this.env.Width+";overflow-X:hidden;"+SL_ScrollBar+"'></DIV>";

    this.List = createObject( ListDiv );
    this.ChangeList();

    return;
}

function createSList()
{
    this.Items = this.ItemObj( this.src );

    this.TitleObj();
    this.ListObj();

    var table = createObject(""
        +"<table cellspacing=0 cellpadding=1 border=0>"
        +"<tr><td></td></tr>"
        +"</table>");

    table.cells(0).appendChild( this.Title );
    table.cells(0).appendChild( this.List );

    return table;
}

function changeSubNS( t, oSub ) {
    var s_idx = t.options.selectedIndex;
    oSub.Items.options.length = 0;

    for( i = 0; i < section_list[s_idx].length; i++ ) {
	content = section_list[s_idx][i].split(",");
	oSub.AddOption( content[0], content[1], 0 );
    }
    oSub.ChangeTitle();
    oSub.ChangeList();

    return;
}

/* Select Guide ALT function 
	t : this
	f : form name 
	e : event
*/
var pDoc = false;
function showSelectGuide( f, e )
{
    if ( UserAgent.indexOf("MSIE") < 0 || AppVersion < 5 ) return;
    else 
    {
        var realWidth = document.body.clientWidth - 148;
        var divWidth = document.all.NSDiv.scrollWidth;
    }   

    if( pDoc && document.all.NSDiv.innerHTML )
	document.all.NSDiv.style.display = "block";
    else
	document.all.NSDiv.style.display = "none";

    if( e.x < realWidth / 2 )
        document.all.NSDiv.style.left = e.x+document.body.scrollLeft + 5;
    else
        document.all.NSDiv.style.left = e.x+document.body.scrollLeft - divWidth -5;
        
    document.all.NSDiv.style.top = e.y + document.body.scrollTop + 5;

    return;
}   

function showSelectGuide_ALT(t, f, e)
{
    if ( UserAgent.indexOf("MSIE") < 0 || AppVersion < 5 ) return;
    else 
    {
	var s_idx = 0;
	var realWidth = document.body.clientWidth - 148;
	var meanWidth = realWidth / 2;
	var divWidth = document.all.NSDiv.scrollWidth;

	if( f.u ) {
	    if( f.u.options ) {
		s_idx = f.u.options.selectedIndex;
		sub_name = f.u.options[s_idx].innerText; 
		sub_url = f.u.options[s_idx].value; 
	    } else {
		sub_url = f.u.value; 
	    }
	}

	if ( f.desc ) {
	    sub_url = f.desc.options[s_idx].innerText;
	}

	if ( sub_url.length >= 70 ) { 
	    sub_url = sub_url.substring(0, 60); 
	    sub_url = sub_url + "...";
	}

	if( sub_url.length ) {
	    pDoc = true;
	    content = ""
	    	+"<table height=20 bgcolor=#FEFFCB cellspacing=0 cellpadding=0"
		+" style='filter:alpha(opacity=100); border:1 solid #AFB086'>"
		+"<tr><td style='text-indent:2px;cursor:hand;font-size:9pt;height:16px;padding-top:2px;'>"
	    	+"<font color=black style='font-size:9pt'>"+sub_url+"</font>"
	    	+"</td><td width=10 nowrap></td></tr></table>";

	    document.all.NSDiv.innerHTML = content;
	    document.all.NSDiv.style.display = "block";

	    if ( e.x < realWidth / 2 )
	        document.all.NSDiv.style.left = e.x+document.body.scrollLeft + 5;
	    else
	        document.all.NSDiv.style.left = e.x+document.body.scrollLeft - divWidth -5;
	
	    document.all.NSDiv.style.top = e.y + document.body.scrollTop + 5;
	} else {
	    pDoc = false;
	    document.all.NSDiv.style.display= "none";
	}
    }

    return;
}

function hideSelectGuide_ALT()
{
    document.all.NSDiv.style.display = "";
    document.all.NSDiv.style.display = "none";
    pDoc = false;

    return;
}

//Fixed By Lion
function Selected( index ) {
    var newTitle = this.Items.options[ index ].innerHTML ;
	this.Items.options.selectedIndex = index;
	this.Title.children(0).cells(0).innerHTML = "<nobr>"+newTitle+"</nobr>";

    return;
}

