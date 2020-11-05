document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Buddy_Design.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Buddy_Process.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Buddy_Request.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Buddy_Response.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Dialog_Process.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Dialog_Request.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Dialog_Response.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Dialog_Util.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Login_Request.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Login_Response.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Login_Util.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Note_Process.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Note_Request.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Note_Response.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/Note_Util.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/RemoteCaller_Process.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/RemoteCaller_Request.js"></script>');
document.write('<script type="text/javascript" src="/jsp/kor/realtime_mysql/js/bp/RemoteCaller_Response.js"></script>');

//alert('Basic_BP');
/*var Basic_BP = {
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
      return (s.src && s.src.match(/Basic_BP\.js(\?.*)?$/))
    }).each( function(s) {
      var path = s.src.replace(/Basic_BP\.js(\?.*)?$/,'');
      var includes = s.src.match(/\?.*load=([a-z,]*)/);
      
      (includes ? includes[1] : 'Buddy_Design,Buddy_Process,Buddy_Request,Buddy_Response,Buddy_Util,Dialog_Process,Dialog_Request,Dialog_Response,Dialog_Util,Login_Request,Login_Response,Login_Util,Note_Process,Note_Request,Note_Response,Note_Util').split(',').each(
       function(include) { Basic_BP.require(path+include+'.js') });
    });
  }
}

Basic_BP.load();*/
