Ext.namespace('DSR', 'DSR.Home');
Ext.override(Ext.Component, {
    saveState : function(){
        if(Ext.state.Manager && this.stateful !== false){
            var state = this.getState();
            if(this.fireEvent('beforestatesave', this, state) !== false){
                Ext.state.Manager.set(this.stateId || this.id, state);
                this.fireEvent('statesave', this, state);
            }
        }
    },
    stateful : false
});
Ext.override(Ext.state.Provider, {
    decodeValue : function(cookie){
        var re = /^(a|n|d|b|s|o)\:(.*)$/;
        var matches = re.exec(unescape(cookie));
        if(!matches || !matches[1]) return;
        var type = matches[1];
        var v = matches[2];
        switch(type){
            case "n":
                return parseFloat(v);
            case "d":
                return new Date(Date.parse(v));
            case "b":
                return (v == "1");
            case "a":
                var all = [];
                if (v) {
                    var values = v.split("^");
                    for(var i = 0, len = values.length; i < len; i++){
                        all.push(this.decodeValue(values[i]));
                    }
                }
                return all;
           case "o":
                var all = {};
                if (v) {
                    var values = v.split("^");
                    for(var i = 0, len = values.length; i < len; i++){
                        var kv = values[i].split("=");
                        all[kv[0]] = this.decodeValue(kv[1]);
                    }
                }
                return all;
           default:
                return v;
        }
    }
});
Ext.override(Ext.Panel, {
    onResize : function(w, h){
        if(w !== undefined || h !== undefined){
            if(!this.collapsed){
                if(typeof w == 'number'){
                    this.body.setWidth(
                            this.adjustBodyWidth(w - this.getFrameWidth()));
                }else if(w == 'auto'){
                    this.body.setWidth(w);
                }

                if(typeof h == 'number'){
                    this.body.setHeight(
                            this.adjustBodyHeight(h - this.getFrameHeight()));
                }else if(h == 'auto'){
                    this.body.setHeight(h);
                }
            }else{
                if (!this.queuedBodySize) this.queuedBodySize = {};
                this.queuedBodySize = {width: w || this.queuedBodySize.width, height: h || this.queuedBodySize.height};
                if(!this.queuedExpand && this.allowQueuedExpand !== false){
                    this.queuedExpand = true;
                    this.on('beforeexpand', function(){
                        delete this.queuedExpand;
                        this[this.collapseEl].show();
                        this.collapsed = false;
                        this.onResize(this.queuedBodySize.width, this.queuedBodySize.height);
                        this.doLayout();
                    }, this, {single:true});
                }
            }
            this.fireEvent('bodyresize', this, w, h);
        }
        this.syncShadow();
    }
});