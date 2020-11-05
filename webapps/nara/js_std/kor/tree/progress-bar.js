/*
 * Ext JS Library 2.0.2
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

Ext.onReady(function(){
    //==== Progress bar 1 ====
    var pbar1 = new Ext.ProgressBar({
       text:'Initializing...'
    });
    var btn1 = Ext.get('btn1');
    btn1.on('click', function(){
        //Ext.fly('p1text').update('Working');
        if (!pbar1.rendered){
            pbar1.render('p1');
        }else{
            pbar1.text = 'Initializing...';
            pbar1.show();
        }
        Runner.run(pbar1, Ext.get('btn1'), 10, function(){
            pbar1.reset(true);
            Ext.fly('p1text').update('Done.').show();
        });
    });

   
});

//Please do not use the following code as a best practice! :)
var Runner = function(){
    var textData = [];
    var f = function(v, pbar, btn, count, cb){
        return function(){
            if(v > count){
                btn.dom.disabled = false;
                cb();
            }else{
                pbar.updateProgress(v/count, 'Loading item ' + v + ' of '+count+'...');
                Ext.Ajax.request({
                method: 'GET',
                timeout: 100000,
                url: '/mail/pop3.auth.do?method=aj_getPopmail',
                success: function(response){
                       textData.push( response.responseText); //array buffering faster!
                       //upText.setValue(textData.join('\n'));
                       
                      setTimeout(self,10);   //  <--- Adjust this to smooth out UI response time during loop
               }
          		});

            }
       };
    };
    return {
        run : function(pbar, btn, count, cb){
            btn.dom.disabled = true;
            var ms = 5000/count;
            for(var i = 1; i < (count+2); i++){
               setTimeout(f(i, pbar, btn, count, cb), i*ms);
            }
        }
    }
}();