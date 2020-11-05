var div2print;
function printDiv (id) {
  if (document.all && window.print) {
    div2print = document.all[id];
    window.onbeforeprint = hideDivs;
    window.onafterprint = showDivs;
    window.print();
  }
  else if (document.layers) {
    div2print = document[id];
    hideDivs();
    window.print();
  } 
}
function hideDivs () {
  if (document.all) {
    var divs = document.all.tags('DIV');
    for (var d = 0; d < divs.length; d++)
      if (divs[d] != div2print)
        divs[d].style.display = 'none';
  }
  else if (document.layers) {
    for (var l = 0; l < document.layers.length; l++)
      if (document.layers[l] != div2print)
        document.layers[l].visibility = 'hide';

  }
}

function showDivs () {
  var divs = document.all.tags('DIV');
  for (var d = 0; d < divs.length; d++)
    divs[d].style.display = 'block';
}