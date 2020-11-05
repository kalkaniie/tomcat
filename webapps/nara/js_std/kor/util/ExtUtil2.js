Ext.NumberPagingToolbar=function(el,ds,config){
    Ext.NumberPagingToolbar.superclass.constructor.call(this, el, null, config);
    this.ds = ds;
    this.cursor = 0;
    ds.on("load", this.onLoad, this);
    this.el=el;
    this.pageSize = config.pageSize;
    this.id = config.id;
    
}
Ext.extend(Ext.NumberPagingToolbar, Ext.Toolbar, {
 ctCls :'K_pagingbar',
 onLoad : function(ds, r, o){
        this.cursor = o.params ? o.params.start : 0;
        this.sort=o.params.sort? o.params.sort:'';
        this.dir= o.params.dir?o.params.dir:'';
        var elFooter= document.getElementById(this.id);
        var dh = Ext.DomHelper;
        elFooter.innerHTML="";
       
        var d = this.getPageData();
        var currentPage= d.activePage+1;
        var numberOfPages=d.pages;
        var start= currentPage;
        if(currentPage<=5)
        {
            start=1;
        }
        else
        {
            for(var j=start-1;j> start-6;j--)
            {
	            if(j%5==0)
	            {
		            start=j;
		            break;
	            }
            }
        }
        
        tpl = new Ext.DomHelper.Template("<span class='pagination'>");
        
        var elPrin=tpl.append(elFooter);
        
        var pageListInfo="";
        var lastInfo = currentPage * this.pageSize > ds.getTotalCount() ? ds.getTotalCount() : currentPage * this.pageSize;
        pageListInfo = "<b>"+(currentPage * this.pageSize -this.pageSize +1) +"-"+ (lastInfo)+"</b>" +" / 총 "+ds.getTotalCount()+"개&nbsp;&nbsp;";
        
        
        el= dh.append(elPrin, {tag:'li',html:'&nbsp;',children:[{tag:'' ,href:'#',html:pageListInfo}]}, true);
        var i;
        
        for (i = start; i <= numberOfPages; i++)
        {
          
            if(i==start +6 ||(start==1&& i==6) )
            {
                el= dh.append(elPrin, {tag:'li',html:'&nbsp;',children:[{tag:'a' ,href:'#',html:'<img src="/images/kor/grid/page_next.gif" />'}]}, true);
                el.on("click",this.onClick.createDelegate(this, [i-1]));
	           
                var total = ds.getTotalCount();
                var extra = total % this.pageSize;
                var lastStart = extra ==0? (total / this.pageSize) : parseInt(total /this.pageSize)+1;
                if(lastStart != currentPage){
	                el= dh.append(elPrin, {tag:'li',html:'&nbsp;',children:[{tag:'a ' ,href:'#',style:"border='none'",html:'<img src="/images/kor/grid/page_last.gif"/>'}]}, true);
	                el.on("click",this.onClick.createDelegate(this, [lastStart-1]));
                }    
	            break;
            }
            if(currentPage > 5 && i==start)
            {
	            el= dh.append(elPrin, {tag:'li',html:'&nbsp;',children:[{tag:'a' ,href:'#',html:'<img src="/images/kor/grid/page_first.gif" />'}]}, true);
	            el.on("click",this.onClick.createDelegate(this, [0]));
	            
	            el= dh.append(elPrin, {tag:'li',html:'&nbsp;',children:[{tag:'a' ,href:'#',html:'<img src="/images/kor/grid/page_prev.gif" />'}]}, true);
                el.on("click",this.onClick.createDelegate(this, [start-1]));
	            continue;
            }
            if (i != currentPage)
            {
                el= dh.append(elPrin, {tag:'li',html:'&nbsp;',
                    children:[{tag:'a' ,href:'#',html:i}]                
                }, true);
                el.on("click",this.onClick.createDelegate(this, [i-1]));
	            
            }
            else
            {
                el= dh.append(elPrin, {tag:'li',html:i+'&nbsp;',cls:'currentpage'  }, true);
	        }
    		
        }  
       }
       ,onClick:function(pageNum){
        	 var ds = this.ds;
        	 ds.load({params:{nPage: pageNum+1, start: pageNum, limit: this.pageSize,sort:this.sort,dir:this.dir,sort:this.sort}});
        }
      ,getPageData : function(){
        var total = this.ds.getTotalCount();
        return {
            total : total,
            activePage : this.cursor,
            pages :  total < this.pageSize ? 1 : Math.ceil(total/this.pageSize)
        };
    }
   }
);

Ext.override(
	Ext.menu.Menu, {    
	autoWidth : function(){     
		BrowserCheck();
		var el = this.el, ul = this.ul;        
		if(!el){            return;        }        
		var w = this.width;        
		if(w){            
			el.setWidth(w);        
		}else if(Ext.isIE && !isIE8){   
			el.setWidth(this.minWidth);            
			var t = el.dom.offsetWidth;
			el.setWidth(ul.getWidth()+el.getFrameWidth("lr"));        
		}    
	}
});
//Ext.namespace('Ext.ux.plugins');
//Ext.ux.plugins.FitToParent = Ext.extend(Object, {
//    constructor: function(parent) {
//        this.parent = parent;
//    },
//    init: function(c) {
//        c.on('render', function(c) {
//            c.fitToElement = Ext.get(this.parent || c.getDomPositionEl().dom.parentNode);
//            if(!c.doLayout){
//                this.fitSizeToParent();
//                alert(9)
//                Ext.EventManager.onWindowResize(this.fitSizeToParent, this);
//            }
//        }, this, {single: true});
//        if(c.doLayout){
//            c.monitorResize = true;
//            c.doLayout = c.doLayout.createInterceptor(this.fitSizeToParent);
//        }
//    },
//    fitSizeToParent: function() {
//        var pos = this.getPosition(true), size = this.fitToElement.getViewSize();
//        this.setSize(size.width - pos[0], size.height - pos[1]);
//    }
//});
//
//Ext.override(Ext.form.ComboBox, {
//    expand : function(){
//        if(this.isExpanded() || !this.hasFocus){
//            return;
//        }
//        this.list.alignTo(this.wrap, this.listAlign);
//        this.list.show();
//        if(!Ext.isBorderBox){
//            this.innerList.setOverflow('auto'); // necessary for FF 2.0/Mac
//        }
//        Ext.getDoc().on({
//            scope: this,
//            mousewheel: this.collapseIf,
//            mousedown: this.collapseIf
//        });
//        this.fireEvent('expand', this);
//    }
//});