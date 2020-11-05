<%@ page language="java" contentType="text/html;charset=utf-8"%>
<% 
String wiswigEditId = request.getParameter("wiswigEditId")!=null ? request.getParameter("wiswigEditId"):"";
%>
<style type="text/css">
/* Toolbar */
.toolbar1 {
	border: 0px solid #666666;
	height: 26px;
	width: 100%
}

.toolbar1 td {
	padding: 0
}

.toolbar1 td select,.toolbar1 td img {
	vertical-align: middle
}

.toolbar2 {
	border: 0px solid #666666;
	height: 24px;
	border-bottom: 0px;
	border-top: 0px;
}

/* Command Buttons */
.button {
	width: 20px;
	height: 20px;
	border: 0px solid transparent;
	margin: 1px;
	padding: 0px;
	background: transparent;
}

.buttonOver {
	width: 20px;
	height: 20px;
	border: 1px solid #999999;
	margin: 0;
	padding: 0px;
}

/* Font Type and Size Drop Down */
.dropdown {
	background-color: #FFFFFF;
	border: 1px solid #333333;
	height: 140px;
	overflow: auto;
	padding: 1px;
}

button.mouseOver {
	background-color: #EEEEEE;
	border: 1px solid #CCCCCC;
	padding: 3px;
	cursor: default;
	text-align: left;
}

button.mouseOut {
	background-color: #FFFFFF;
	border: 1px solid #FFFFFF;
	padding: 3px;
	cursor: default;
	text-align: left;
}

/* CREATE TABLE POPUP */ /* Select Border Width/Type */
.K_tableInsert_on {
	background-color: #EEEEEE;
	border: 1px solid #CCCCCC;
	padding: 6px;
	width: 140px;
	cursor: default;
	height: 5px;
}

.K_tableInsert_off {
	background-color: #FFFFFF;
	border: 1px solid #FFFFFF;
	padding: 6px;
	width: 140px;
	cursor: default;
	height: 5px;
}
</style>
<script language="JavaScript" type="text/javascript">


var qsParm = new Array();
/* ---------------------------------------------------------------------- *\
  Function    : init()
  Description : Calls the initial functions when page loads.
\* ---------------------------------------------------------------------- */
function init() {
 // retrieveWYSIWYG(); 
	hideOnBorderStyles(); 
	hideOnBorderWidths(); 
	hideColorMenus();
}



/* ---------------------------------------------------------------------- *\
  Function    : retrieveWYSIWYG()
  Description : Retrieves the textarea ID for which the table will be inserted into.
\* ---------------------------------------------------------------------- */
function retrieveWYSIWYG() {
  var query = window.location.search.substring(1);
  var parms = query.split('&');
  for (var i=0; i<parms.length; i++) {
    var pos = parms[i].indexOf('=');
    if (pos > 0) {
       var key = parms[i].substring(0,pos);
       var val = parms[i].substring(pos+1);
       qsParm[key] = val;
    }
  }
}



/* ---------------------------------------------------------------------- *\
  Function    : buildTable()
  Description : Builds a table and inserts it into the WYSIWYG.
\* ---------------------------------------------------------------------- */
function buildTable() {
  
	// Checks if the table border will use the BORDER-COLLAPSE CSS attribute
	var collapse;
	if (document.getElementById('borderCollapse').checked == true) {
	  collapse = document.getElementById('borderCollapse').value;
		}
	else {
	  collapse = "separate";
		}
	
	// Builds a table based on the data input into the form
  var table = '<table border="0" cellpadding="0" cellspacing="0" style="';
	table += 'BORDER-COLLAPSE: ' + collapse + ';';  
	table += ' border: ' + document.getElementById('borderWidth').value + ' ' +  document.getElementById('borderStyle').value + ' ' +  document.getElementById('borderColor').value + ';';	
  table += ' width: ' + document.getElementById('tableWidth').value + document.getElementById('widthType').value + ';';
	table += ' background-color: ' + document.getElementById('shadingColor').value + ';"';
  table += ' alignment="' + document.getElementById('alignment').value + '">\n';	
	
	// Creates the number of rows and cols the table will have
	for (var i = 0; i < document.getElementById('rows').value; i++) {
	  table += '<tr>\n';
		  for (var j = 0; j < document.getElementById('cols').value; j++) {
		    table += '<td style="border: ' + document.getElementById('borderWidth').value + ' ' +  document.getElementById('borderStyle').value + ' ' +  document.getElementById('borderColor').value + '; padding: ' + document.getElementById('padding').value + ';">&nbsp;</td>\n';
		  }
		table += '</tr>\n';
  }
	
	table += '</table>\n';
	Ext.getCmp("<%=wiswigEditId%>").insertAtCursor(table);
	
	this.tablewindow.close();
}
function closeScript(){
	this.tablewindow.close();
}

/* ---------------------------------------------------------------------- *\
  Function    : hideOnBorderWidths()
  Description : Hides any table cell with an ID of "#px on" (e.g. "3px on").
\* ---------------------------------------------------------------------- */
function hideOnBorderWidths() {

  var onBorderWidths = new Array();
    onBorderWidths[0] = "1px on";
    onBorderWidths[1] = "2px on";
    onBorderWidths[2] = "3px on";
		onBorderWidths[3] = "4px on";
		onBorderWidths[4] = "5px on";
		onBorderWidths[5] = "6px on";
	
  for (var j = 0; j < onBorderWidths.length;) {
    document.getElementById(onBorderWidths[j]).style.display = 'none';
	  j++;
  }
}


/* ---------------------------------------------------------------------- *\
  Function    : showOffBorderWidths()
  Description : Shows all table cells with an ID of "#px" (e.g. "3px"). 
\* ---------------------------------------------------------------------- */
function showOffBorderWidths() {

  var offBorderWidths = new Array();
    offBorderWidths[0] = "1px";
    offBorderWidths[1] = "2px";
    offBorderWidths[2] = "3px";
		offBorderWidths[3] = "4px";
		offBorderWidths[4] = "5px";
		offBorderWidths[5] = "6px";
	
  for (var j = 0; j < offBorderWidths.length;) {
    document.getElementById(offBorderWidths[j]).style.display = 'block';
	  j++;
  }
}



/* ---------------------------------------------------------------------- *\
  Function    : selectWidth()
  Description : Selects the width to be used in the output table.
	Usage       : selectWidth("3px")
\* ---------------------------------------------------------------------- */
function selectWidth(id) {

  // Hide the currently selected width
  hideOnBorderWidths();
	
	// Show all of the width options as unselected
	showOffBorderWidths();
	
	// Hide the "off" element and replace with an "on" element so option appears selected
	document.getElementById(id).style.display = 'none';
	document.getElementById(id + ' on').style.display = 'block';
	
	// Assign value to <input type="hidden" id="borderWidth">
	document.getElementById('borderWidth').value = id;
} 


/* ---------------------------------------------------------------------- *\
  Function    : hideOnBorderStyles()
  Description : Hides any table cell with an ID of "borderstyle on" 
	              (e.g. "dashed on").
\* ---------------------------------------------------------------------- */
function hideOnBorderStyles() {

  var onBorderStyles = new Array();
    onBorderStyles[0] = "No Border on";
    onBorderStyles[1] = "solid on";
    onBorderStyles[2] = "dashed on";
		onBorderStyles[3] = "dotted on";
		onBorderStyles[4] = "double on";
		onBorderStyles[5] = "inset on";
		onBorderStyles[6] = "outset on";
		onBorderStyles[7] = "groove on";
		onBorderStyles[8] = "ridge on";
	
  for (var j = 0; j < onBorderStyles.length;) {
 	  document.getElementById(onBorderStyles[j]).style.display = 'none';
	  j++;
  }
}



/* ---------------------------------------------------------------------- *\
  Function    : showOffBorderStyles()
  Description : Shows all table cells with an ID of "borderstyle" 
	              (e.g. "solid"). 
\* ---------------------------------------------------------------------- */
function showOffBorderStyles() {

  var offBorderStyles = new Array();
    offBorderStyles[0] = "No Border";
    offBorderStyles[1] = "solid";
    offBorderStyles[2] = "dashed";
		offBorderStyles[3] = "dotted";
		offBorderStyles[4] = "double";
		offBorderStyles[5] = "inset";
		offBorderStyles[6] = "outset";
		offBorderStyles[7] = "groove";
		offBorderStyles[8] = "ridge";
	
  for (var j = 0; j < offBorderStyles.length;) {
    document.getElementById(offBorderStyles[j]).style.display = 'block';
	  j++;
  }
}



/* ---------------------------------------------------------------------- *\
  Function    : selectBorder()
  Description : Selects the border style to be used in the output table.
	Usage       : selectBorder("dashed")
\* ---------------------------------------------------------------------- */
function selectBorder(id) {
  
	// Hide the currently selected border style
  hideOnBorderStyles();
	
	// Show all of the border style options as unselected
	showOffBorderStyles();
	
	// Hide the "off" element and replace with an "on" element so option appears selected
	document.getElementById(id).style.display = 'none';
	document.getElementById(id + ' on').style.display = 'block';
	
	// Assign value to <input type="hidden" id="borderStyle">
	document.getElementById('borderStyle').value = id;
} 
 


/* ---------------------------------------------------------------------- *\
  Function    : hideColorMenus()
  Description : Hide the menus used for selecting the border color and 
	              shading color. 
\* ---------------------------------------------------------------------- */
function hideColorMenus() {
  document.getElementById('borderColorMenu').style.display = "none";
	document.getElementById('shadingColorMenu').style.display = "none";
}


/* ---------------------------------------------------------------------- *\
  Function    : showBorderColorMenu()
  Description : Show the border color menu so user can select the table's 
	              border color. 
\* ---------------------------------------------------------------------- */
function showBorderColorMenu() {
  document.getElementById('borderColorMenu').style.display = "block";
}


/* ---------------------------------------------------------------------- *\
  Function    : previewBorderColor()
  Description : When mousing over a border color display the color in the 
	              preview square.
\* ---------------------------------------------------------------------- */
function previewBorderColor(color) {
  document.getElementById('borderColorPreview').style.backgroundColor = color;  
}


/* ---------------------------------------------------------------------- *\
  Function    : selectBorderColor()
  Description : Assigns the selected border color to 
	              <input type="hidden" id="borderColor">.
\* ---------------------------------------------------------------------- */
function selectBorderColor(color) {
  document.getElementById('borderColorPreview').style.backgroundColor = color;  
	document.getElementById('borderColorMenu').style.display = "none";
	document.getElementById('borderColor').value = color;
}



/* ---------------------------------------------------------------------- *\
  Function    : showShadingColorMenu()
  Description : Show the shading color menu so user can select the table's 
	              shading color. 
\* ---------------------------------------------------------------------- */
function showShadingColorMenu() {
  document.getElementById('shadingColorMenu').style.display = "block";
}



/* ---------------------------------------------------------------------- *\
  Function    : previewShadingColor()
  Description : When mousing over a shading color display the color in the 
	              preview square.
\* ---------------------------------------------------------------------- */
function previewShadingColor(color) {
  document.getElementById('shadingColorPreview').style.backgroundColor = color;  
}



/* ---------------------------------------------------------------------- *\
  Function    : selectShadingColor()
  Description : Assigns the selected shading color to 
	              <input type="hidden" id="shadingColor">.
\* ---------------------------------------------------------------------- */
function selectShadingColor(color) {
  document.getElementById('shadingColorPreview').style.backgroundColor = color;  
	document.getElementById('shadingColorMenu').style.display = "none";
	document.getElementById('shadingColor').value = color;
}
</script>

<div style="background: #fff;">
<table border="0" align="center" cellpadding="0" cellspacing="0"
	style="padding-left: 4px">
	<tr>
		<td><input type="hidden" name="borderWidth" id="borderWidth"
			value="0px"> <input type="hidden" name="borderStyle"
			id="borderStyle" value="solid"> <input type="hidden"
			name="borderColor" id="borderColor" value="#000000"> <input
			type="hidden" name="shadingColor" id="shadingColor" value="#FFFFFF">
		<table width="380" border="0" align="center" cellpadding="0"
			cellspacing="0"
			style="background-color: #F7F7F7; border: 1px solid #ccc; text-align: justify; margin-top: 5px">
			<tr>
				<td
					style="padding-bottom: 2px; width: 50px; font-family: arial, verdana, helvetica; font-size: 11px; padding-left: 3px">Rows:</td>
				<td style="padding-bottom: 2px; width: 80px;"><input
					type="text" size="4" id="rows" name="rows" value="5"
					style="font-size: 10px; width: 65px;"></td>
				<td
					style="padding-bottom: 2px; width: 80px; font-family: arial, verdana, helvetica; font-size: 11px;">Table
				Width:
				<td style="padding-bottom: 2px; width: 180px;"><input
					type="text" name="tableWidth" id="tableWidth" value="100" size="10"
					style="font-size: 10px; width: 65px;">&nbsp; <select
					name="widthType" id="widthType"
					style="margin-right: 10px; font-size: 10px;">
					<option value="%">Percent</option>
					<option value="px">Pixels</option>
				</select></td>
			</tr>
			<tr>
				<td
					style="padding-bottom: 2px; padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px; padding-left: 3px">Cols:</td>
				<td style="padding-bottom: 2px; padding-top: 0px;"><input
					type="text" size="4" id="cols" name="cols" value="5"
					style="font-size: 10px; width: 65px;"></td>
				<td
					style="padding-bottom: 2px; padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px;">Alignment:</td>
				<td style="padding-bottom: 2px; padding-top: 0px;"><select
					name="alignment" id="alignment"
					style="margin-right: 10px; font-size: 10px; width: 65px;">
					<option value="">Not Set</option>
					<option value="Left">Left</option>
					<option value="Right">Right</option>
					<option value="Center">Center</option>
				</select></td>
			</tr>
			<tr>
				<td
					style="padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px; padding-left: 3px">Padding:</td>
				<td style="padding-top: 0px;"><input type="text" size="4"
					id="padding" name="padding" value="5"
					style="font-size: 10px; width: 65px;"></td>
				<td
					style="padding-top: 0px; font-family: arial, verdana, helvetica; font-size: 11px;">Collapse:</td>
				<td style="padding-top: 0px;"><input type="checkbox"
					name="borderCollapse" id="borderCollapse"></td>
			</tr>
		</table>

		<div
			style="font-family: Dotum, Dotum Che, arial, verdana, helvetica; font-size: 12px; font-weight: bold; padding: 8px 0 0 5px">테두리
		스타일/굵기</div>
		<table width="380" border="0" align="center" cellpadding="5"
			cellspacing="0"
			style="background-color: #F7F7F7; border: 1px solid #ccc; margin-top: 5px; padding: 3px 0 0">
			<tr>
				<td>

				<div
					style="overflow: auto; width: 135px; height: 150px; border: 1px inset #CCCCCC; margin: 3px; background-color: #FFFFFF;">
				<table border="0" cellpadding="0" cellspacing="0" width="115">
					<tr id="No Border">
						<td class='K_tableInsert_off' onClick="selectBorder('No Border');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'"
							style="font-family: arial, verdana, helvetica; font-size: 11px;">&nbsp;No
						Border&nbsp;</td>
					</tr>
					<tr id="No Border on">
						<td class='K_tableInsert_on'
							style="font-family: arial, verdana, helvetica; font-size: 11px;">&nbsp;No
						Border&nbsp;</td>
					</tr>

					<tr id="solid">
						<td class='K_tableInsert_off' onClick="selectBorder('solid');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<hr style="border: 1px solid #000000;">
						</td>
					</tr>
					<tr id="solid on">
						<td class='K_tableInsert_on'>
						<hr style="border: 1px solid #000000;">
						</td>
					</tr>

					<tr id="dashed">
						<td class='K_tableInsert_off' onClick="selectBorder('dashed');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<hr style="border: 2px dashed #000000;">
						</td>
					</tr>
					<tr id="dashed on">
						<td class='K_tableInsert_on'>
						<hr style="border: 2px dashed #000000;">
						</td>
					</tr>


					<tr id="dotted">
						<td class='K_tableInsert_off' onClick="selectBorder('dotted');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<hr style="border: 2px dotted #000000;">
						</td>
					</tr>
					<tr id="dotted on">
						<td class='K_tableInsert_on'>
						<hr style="border: 2px dotted #000000;">
						</td>
					</tr>

					<tr id="double">
						<td class='K_tableInsert_off' onClick="selectBorder('double');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<div
							style="border-top-width: 6px; border-top-style: double; border-top-color: #000000; font-size: 1px; margin: 6 0 2 0;">&nbsp;</div>
						</td>
					</tr>
					<tr id="double on">
						<td class='K_tableInsert_on'>
						<div
							style="border-top-width: 6px; border-top-style: double; border-top-color: #000000; font-size: 1px; margin: 6 0 2 0;">&nbsp;</div>
						</td>
					</tr>

					<tr id="inset">
						<td class='K_tableInsert_off' onClick="selectBorder('inset');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<div
							style="border: 2px inset #DDDDDD; font-size: 4px; padding: 4px;">&nbsp;</div>
						</td>
					</tr>
					<tr id="inset on">
						<td class='K_tableInsert_on'>
						<div
							style="border: 2px inset #DDDDDD; font-size: 4px; padding: 4px;">&nbsp;</div>
						</td>
					</tr>

					<tr id="outset">
						<td class='K_tableInsert_off' onClick="selectBorder('outset');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<div
							style="border: 2px outset #DDDDDD; font-size: 4px; padding: 4px;">&nbsp;</div>
						</td>
					</tr>
					<tr id="outset on">
						<td class='K_tableInsert_on'>
						<div
							style="border: 2px outset #DDDDDD; font-size: 4px; padding: 4px;">&nbsp;</div>
						</td>
					</tr>

					<tr id="groove">
						<td class='K_tableInsert_off' onClick="selectBorder('groove');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<div
							style="border: 2px groove #DDDDDD; font-size: 4px; padding: 4px;">&nbsp;</div>
						</td>
					</tr>
					<tr id="groove on">
						<td class='K_tableInsert_on'>
						<div
							style="border: 2px groove #DDDDDD; font-size: 4px; padding: 4px;">&nbsp;</div>
						</td>
					</tr>

					<tr id="ridge">
						<td class='K_tableInsert_off' onClick="selectBorder('ridge');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<div
							style="border: 2px ridge #DDDDDD; font-size: 4px; padding: 4px;">&nbsp;</div>
						</td>
					</tr>
					<tr id="ridge on">
						<td class='K_tableInsert_on'>
						<div
							style="border: 2px ridge #DDDDDD; font-size: 4px; padding: 4px;">&nbsp;</div>
						</td>
					</tr>
				</table>
				</div>

				</td>
				<td>

				<div
					style="overflow: auto; width: 135px; height: 150px; border: 1px inset #CCCCCC; margin: 3px; background-color: #FFFFFF;">
				<table border="0" cellpadding="0" cellspacing="0" width="115">

					<tr id="1px">
						<td class='K_tableInsert_off' onClick="selectWidth('1px');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">1px&nbsp;</td>
								<td
									style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="1px on">
						<td class='K_tableInsert_on'>
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">1px&nbsp;</td>
								<td
									style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr id="2px">
						<td class='K_tableInsert_off' onClick="selectWidth('2px');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">2px&nbsp;</td>
								<td
									style="border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="2px on">
						<td class='K_tableInsert_on'>
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">2px&nbsp;</td>
								<td
									style="border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr id="3px">
						<td class='K_tableInsert_off' onClick="selectWidth('3px');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">3px&nbsp;</td>
								<td
									style="border-bottom-width: 3px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="3px on">
						<td class='K_tableInsert_on'>
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">3px&nbsp;</td>
								<td
									style="border-bottom-width: 3px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr id="4px">
						<td class='K_tableInsert_off' onClick="selectWidth('4px');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">4px&nbsp;</td>
								<td
									style="border-bottom-width: 4px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="4px on">
						<td class='K_tableInsert_on'>
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">4px&nbsp;</td>
								<td
									style="border-bottom-width: 4px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr id="5px">
						<td class='K_tableInsert_off' onClick="selectWidth('5px');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">5px&nbsp;</td>
								<td
									style="border-bottom-width: 5px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="5px on">
						<td class='K_tableInsert_on'>
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">5px&nbsp;</td>
								<td
									style="border-bottom-width: 5px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr id="6px">
						<td class='K_tableInsert_off' onClick="selectWidth('6px');"
							onMouseOver="this.className = 'K_tableInsert_on'"
							onMouseOut="this.className = 'K_tableInsert_off'">
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">6px&nbsp;</td>
								<td
									style="border-bottom-width: 6px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="6px on">
						<td class='K_tableInsert_on'>
						<table cellpaddin="0" cellspacing="0" border="0">
							<tr>
								<td
									style="font-family: arial, verdana, helvetica, sans serif; font-size: 12px;">6px&nbsp;</td>
								<td
									style="border-bottom-width: 6px; border-bottom-style: solid; border-bottom-color: #000000; font-size: 1px; margin: 6 0 0 0; width: 80px;">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>

				</table>
				</div>

				</td>
				<td style="font-family: arial, verdana, helvetica; font-size: 11px;"
					valign="top">Color:
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="25">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td
									style="width: 25px; background-color: #000000; border: 1px solid #000000; font-size: 10px;"
									id="borderColorPreview">&nbsp;</td>
							</tr>
						</table>
						</td>
						<td>
						<button
							style="font-size: 10px; font-family: arial, verdana, helvetica, sans serif; margin-left: 2px; width: 28px;"
							onClick="showBorderColorMenu();">Pick</button>
						</td>
					</tr>
				</table>


				<div style="position: absolute; right: 30px;" id="borderColorMenu">
				<table border="0" cellpadding="0" cellspacing="0"
					class="selectColorTable">
					<tr>
						<td>

						<table border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#000000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#000000');">
								<div style="background-color: #000000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#993300');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#993300');">
								<div style="background-color: #993300; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#333300');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#333300');">
								<div style="background-color: #333300; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#003300');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#003300');">
								<div style="background-color: #003300; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#003366');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#003366');">
								<div style="background-color: #003366; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#000080');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#000080');">
								<div style="background-color: #000080; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#333399');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#333399');">
								<div style="background-color: #333399; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#333333');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#333333');">
								<div style="background-color: #333333; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#800000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#800000');">
								<div style="background-color: #800000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FF6600');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FF6600');">
								<div style="background-color: #FF6600; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#808000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#808000');">
								<div style="background-color: #808000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#008000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#008000');">
								<div style="background-color: #008000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#008080');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#008080');">
								<div style="background-color: #008080; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#0000FF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#0000FF');">
								<div style="background-color: #0000FF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#666699');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#666699');">
								<div style="background-color: #666699; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#808080');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#808080');">
								<div style="background-color: #808080; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FF0000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FF0000');">
								<div style="background-color: #FF0000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FF9900');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FF9900');">
								<div style="background-color: #FF9900; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#99CC00');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#99CC00');">
								<div style="background-color: #99CC00; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#339966');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#339966');">
								<div style="background-color: #339966; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#33CCCC');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#33CCCC');">
								<div style="background-color: #33CCCC; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#3366FF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#3366FF');">
								<div style="background-color: #3366FF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#800080');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#800080');">
								<div style="background-color: #800080; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#999999');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#999999');">
								<div style="background-color: #999999; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FF00FF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FF00FF');">
								<div style="background-color: #FF00FF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FFCC00');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FFCC00');">
								<div style="background-color: #FFCC00; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FFFF00');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FFFF00');">
								<div style="background-color: #FFFF00; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#00FF00');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#00FF00');">
								<div style="background-color: #00FF00; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#00FFFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#00FFFF');">
								<div style="background-color: #00FFFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#00CCFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#00CCFF');">
								<div style="background-color: #00CCFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#993366');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#993366');">
								<div style="background-color: #993366; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#C0C0C0');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#C0C0C0');">
								<div style="background-color: #C0C0C0; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FF99CC');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FF99CC');">
								<div style="background-color: #FF99CC; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FFCC99');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FFCC99');">
								<div style="background-color: #FFCC99; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FFFF99');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FFFF99');">
								<div style="background-color: #FFFF99; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#CCFFCC');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#CCFFCC');">
								<div style="background-color: #CCFFCC; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#CCFFFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#CCFFFF');">
								<div style="background-color: #CCFFFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#99CCFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#99CCFF');">
								<div style="background-color: #99CCFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#CC99FF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#666699');">
								<div style="background-color: #666699; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewBorderColor('#FFFFFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectBorderColor('#FFFFFF');">
								<div style="background-color: #FFFFFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
						</table>
					</tr>
				</table>
				</div>

				<br>
				Shading:
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="25">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td
									style="width: 25px; background-color: #FFFFFF; border: 1px solid #000000; font-size: 10px;"
									id="shadingColorPreview">&nbsp;</td>
							</tr>
						</table>
						</td>
						<td>
						<button
							style="font-size: 10px; font-family: arial, verdana, helvetica, sans serif; margin-left: 2px; width: 28px;"
							onClick="showShadingColorMenu();">Pick</button>
						</td>
					</tr>
				</table>

				<div style="position: absolute; right: 30px;" id="shadingColorMenu">
				<table border="0" cellpadding="0" cellspacing="0"
					class="selectColorTable">
					<tr>
						<td>

						<table border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#000000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#000000');">
								<div style="background-color: #000000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#993300');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#993300');">
								<div style="background-color: #993300; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#333300');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#333300');">
								<div style="background-color: #333300; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#003300');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#003300');">
								<div style="background-color: #003300; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#003366');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#003366');">
								<div style="background-color: #003366; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#000080');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#000080');">
								<div style="background-color: #000080; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#333399');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#333399');">
								<div style="background-color: #333399; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#333333');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#333333');">
								<div style="background-color: #333333; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#800000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#800000');">
								<div style="background-color: #800000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FF6600');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FF6600');">
								<div style="background-color: #FF6600; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#808000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#808000');">
								<div style="background-color: #808000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#008000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#008000');">
								<div style="background-color: #008000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#008080');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#008080');">
								<div style="background-color: #008080; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#0000FF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#0000FF');">
								<div style="background-color: #0000FF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#666699');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#666699');">
								<div style="background-color: #666699; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#808080');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#808080');">
								<div style="background-color: #808080; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FF0000');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FF0000');">
								<div style="background-color: #FF0000; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FF9900');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FF9900');">
								<div style="background-color: #FF9900; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#99CC00');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#99CC00');">
								<div style="background-color: #99CC00; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#339966');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#339966');">
								<div style="background-color: #339966; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#33CCCC');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#33CCCC');">
								<div style="background-color: #33CCCC; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#3366FF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#3366FF');">
								<div style="background-color: #3366FF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#800080');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#800080');">
								<div style="background-color: #800080; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#999999');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#999999');">
								<div style="background-color: #999999; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FF00FF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FF00FF');">
								<div style="background-color: #FF00FF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FFCC00');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FFCC00');">
								<div style="background-color: #FFCC00; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FFFF00');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FFFF00');">
								<div style="background-color: #FFFF00; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#00FF00');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#00FF00');">
								<div style="background-color: #00FF00; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#00FFFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#00FFFF');">
								<div style="background-color: #00FFFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#00CCFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#00CCFF');">
								<div style="background-color: #00CCFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#993366');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#993366');">
								<div style="background-color: #993366; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#C0C0C0');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#C0C0C0');">
								<div style="background-color: #C0C0C0; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FF99CC');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FF99CC');">
								<div style="background-color: #FF99CC; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FFCC99');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FFCC99');">
								<div style="background-color: #FFCC99; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FFFF99');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FFFF99');">
								<div style="background-color: #FFFF99; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#CCFFCC');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#CCFFCC');">
								<div style="background-color: #CCFFCC; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#CCFFFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#CCFFFF');">
								<div style="background-color: #CCFFFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#99CCFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#99CCFF');">
								<div style="background-color: #99CCFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#CC99FF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#666699');">
								<div style="background-color: #666699; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
								<td class="selectColorBorder"
									onMouseOver="className = 'selectColorOn'; previewShadingColor('#FFFFFF');"
									onMouseOut="className = 'selectColorOff'"
									onClick="selectShadingColor('#FFFFFF');">
								<div style="background-color: #FFFFFF; cursor: pointer"
									class="selectColorBox">&nbsp;</div>
								</td>
							</tr>
						</table>
					</tr>
				</table>
				</div>

				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<div style="padding: 5px 0; text-align: center"><input
	type="image" onClick="buildTable();"
	src="/images/kor/btn/btnA_save.gif">&nbsp;<input type="image"
	onClick="javascript:closeScript()" style="margin-right: 15px;"
	src="/images/kor/btn/btnA_cancel.gif"></div>
</div>
<script language="JavaScript">
	init();
</script>
