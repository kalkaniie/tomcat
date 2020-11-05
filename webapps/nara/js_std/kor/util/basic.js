var ResizableExample = {
    init : function(){
        alert(1)
        var wrapped = new Ext.Resizable('wrapped', {
            wrap:true,
            pinned:true,
            minWidth:50,
            minHeight: 50,
            preserveRatio: true
        });
        alert(2)
    }
};

Ext.EventManager.onDocumentReady(ResizableExample.init, ResizableExample, true);