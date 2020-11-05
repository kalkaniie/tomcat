function bluring(){ 
  if(event != null && event.srcElement != null && event.srcElement.tagName != null)
    if( event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus(); 
} 

document.onfocusin=bluring;

floater.style.top = main_table.offsetTop ;
window.onscroll = WindScroll;
window.onresize = WindReset;
window.onload = WindScroll;

function WindScroll(){
  /*
  floater.style.top = document.body.scrollTop;
  if(document.body.scrollTop <= main_table.offsetTop){
  	floater.style.top = main_table.offsetTop;
  }else{
  	floater.style.top = document.body.scrollTop;
  }
  */
}

function WindReset(){
	floater.style.top = main_table.offsetTop;
}