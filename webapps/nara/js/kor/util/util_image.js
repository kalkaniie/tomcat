
function resizeImgSub(img) {
  var imgTemp = new Image();
  imgTemp.src = img.src; 

  if ( imgTemp.width > img.visibleImgObj.width || imgTemp.height > img.visibleImgObj.height ){
    if ( (img.width / img.visibleImgObj.width) > (img.height / img.visibleImgObj.height) )
      img.visibleImgObj.height = Math.round(img.height * (img.visibleImgObj.width / img.width));
    else
      img.visibleImgObj.width = Math.round(img.width * (img.visibleImgObj.height / img.height));
  } else {
    img.visibleImgObj.width = imgTemp.width;
    img.visibleImgObj.height = imgTemp.height;
  }
}

function resizeImg(imgObj) {
  var imgOriginal = new Image();
  imgOriginal.visibleImgObj = imgObj;
  imgOriginal.onload = function() { resizeImgSub(this); }  
  if(imgObj.width != 0 || imgObj.height != 0)
      imgOriginal.src = imgObj.src;
}

