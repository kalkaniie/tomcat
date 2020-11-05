document.write('<script type="text/javascript" src="/jsp/kor/realtime/js/common/Flash_Define.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime/js/common/Flash_Process.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime/js/common/Flash_Design.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime/js/common/Flash_Request.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime/js/common/Flash_Response.js"></script>');



/*var Basic_flash = {
  Version: '1.0.0',
  require: function(libraryName) {
  	//alert(libraryName);
    document.write('<script type="text/javascript" src="'+libraryName+'"></script>');
  },
  load: function() {
    if((typeof Prototype=='undefined') || 
       (typeof Element == 'undefined') || 
       (typeof Element.Methods=='undefined') ||
       parseFloat(Prototype.Version.split(".")[0] + "." +
                  Prototype.Version.split(".")[1]) < 1.5)
       throw("This script requires the Prototype JavaScript framework >= 1.5.0");
    
    $A(document.getElementsByTagName("script")).findAll( function(s) {
      return (s.src && s.src.match(/Basic_flash\.js(\?.*)?$/))
    }).each( function(s) {
      var path = s.src.replace(/Basic_flash\.js(\?.*)?$/,'');
      var includes = s.src.match(/\?.*load=([a-z,]*)/);
      (includes ? includes[1] : 'Flash_Define,Flash_Design,Flash_Process,Flash_Request,Flash_Response').split(',').each(
       function(include) { Basic_flash.require(path+include+'.js') });
    });
  }
}

Basic_flash.load();*/