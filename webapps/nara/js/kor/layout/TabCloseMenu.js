Ext.namespace('Ext.ux.InlineToolbarTabPanel');
Ext.ux.InlineToolbarTabPanel = function(config){
	this.toolbar ={width:150,id:this.id+'Toolbar'};
	Ext.apply(this,config);
	this.config = config;
	Ext.ux.InlineToolbarTabPanel.superclass.constructor.call(this,config);
	this.addEvents('beforerender','onrender');
}
Ext.ux.InlineToolbarTabPanel = Ext.extend(Ext.TabPanel, {
  onRender: function(ct, position) {
    if(!this.itemTpl){
      var tt;

      if (this.tabToolbars) {
        tt = new Ext.Template(
          '<li class="{cls}" id="{id}"><a class="x-tab-strip-close" onclick="return false;"></a>',
          '<a class="x-tab-right" href="#" onclick="return false;"><em class="x-tab-left">',
          '<table cellpadding="1" cellspacing="0" class="x-tab-strip-inner"><tr><td>',
          '<span class="x-tab-strip-text {iconCls}">{text}</span></td><td>&nbsp;</td>',
          '<td style="padding-top:1px;"><div id="{tabTB}" style="position:relative;"></div></td></tr></table></em></a></li>'
        );
      } else {
        tt = new Ext.Template(
          '<li class="{cls}" id="{id}"><a class="x-tab-strip-close" onclick="return false;"></a>',
          '<a class="x-tab-right" href="#" onclick="return false;"><em class="x-tab-left">',
          '<span class="x-tab-strip-inner"><span class="x-tab-strip-text {iconCls}">{text}</span></span>',
          '</em></a></li>'
        );
      }
      tt.disableFormats = true;
      tt.compile();
      this.itemTpl = tt;
    }

    Ext.ux.InlineToolbarTabPanel.superclass.onRender.call(this, ct, position);
  }

  ,afterRender: function() {
    Ext.ux.InlineToolbarTabPanel.superclass.afterRender.call(this);
    if (!Ext.isEmpty(this.toolbar)) {
      this.setToolbar(this.toolbar);
    }
  }

  ,onResize: function() {
    Ext.ux.InlineToolbarTabPanel.superclass.onResize.apply(this, arguments);
    if (Ext.isEmpty(this.inlineToolbar)) return;

    var tbEl = this.inlineToolbar.getEl();
    var tbWidth = tbEl.dom.offsetWidth;
    var w = this.header.dom.offsetWidth - tbWidth - (this.headerToolbar?0:10);
    var h = this.header.getHeight();
    var defaultHeight = 32;

    this.header.setHeight(h < defaultHeight? defaultHeight:h);
    this.tbHeader.setHeight(this.header.dom.offsetHeight);
    this.stripWrap.setHeight(this.header.dom.offsetHeight);
    this.tbWrap.setHeight(this.stripWrap.dom.offsetHeight);
    this.strip.setHeight(this.stripWrap.dom.offsetHeight - 4);
    this.tbContainer.setHeight(this.strip.dom.offsetHeight - 1);

    this.header.setWidth((Ext.isIE6)?(w-2):(Ext.isIE7 || Ext.isGecko3)?w-4:w);
    this.stripWrap.setWidth(w);
    this.tbHeader.setWidth(tbWidth + (this.headerToolbar?4:10));
    this.inlineToolbar.setWidth(tbWidth);
    this.inlineToolbar.setHeight(this.tbContainer.dom.offsetHeight-1);

    this.tbHeader.alignTo(this.header, 'tr', (Ext.isGecko && !Ext.isGecko3)?[-1,-1]:[0,0]);
    this.delegateUpdates();
  }

  ,getToolbar: function() {
    return this.inlineToolbar;
  }

  ,setToolbar: function(obj) {
    var cls = 'x-tab-panel-header1';
    var tbStyle = {style: 'border-width:0px;background:transparent none;' +
      (this.headerToolbar? 'padding:0px;background:transparent none;': '')};

    if (this.headerToolbar)
      cls += (this.border? '':
        ' x-tab-panel-noborder1 x-tab-panel-header-noborder1');
    else
      cls += ' x-tab-strip-wrap1 x-tab-strip-top1';

    this.tbHeader = this.header.insertSibling({
      id:"tbHeader",
      style: 'position:absolute;' + (Ext.isIE6? 'width:0px;' : '')
    });

    this.tbWrap = this.tbHeader.createChild({
      id:'tbWrap'
      ,style: 'border-left:0px none;border-left-width:0px;'
      ,cls: cls
    });

    this.tbContainer = this.tbWrap.createChild({
      id:'tbContainer',
      style: 'margin:5px 5px 6px 0; text-align:right; background:url(/js/tools/resources/images/default/tabs/k_tab-strip-bg-right.gif) no-repeat left bottom;'
      ,html:'<a href="javascript:;" onClick="javascript:closeAllTab()"><img src="/images/kor/tabmenu/topTab_closeAll.gif"></a>'
      , tag: this.headerToolbar? 'ul': 'div'
      , cls: this.headerToolbar? 'x-tab-strip-top1': 'x-tab-right x-tab-panel-header1'
    });

    this.header.setStyle('border-right', '0px none');

    Ext.apply(this.toolbar, tbStyle);
    var tt = this.toolbar;
    this.inlineToolbar = new Ext.Toolbar(this.toolbar);

    if (!this.headerToolbar) {
      this.inlineToolbar.removeClass('x-toolbar');
      this.inlineToolbar.addClass('x-tab-strip-inner1');
    }

    this.inlineToolbar.render(this.tbContainer);
    if (this.toolbar != obj) {
      this.onResize(this.getSize().width);
      this.toolbar = obj;
    }
  }

  ,initTab: function(item, index){
    var before = this.strip.dom.childNodes[index];
    var cls = item.closable ? 'x-tab-strip-closable' : '';
    if(item.disabled){
      cls += ' x-item-disabled';
    }
    if(item.iconCls){
      cls += ' x-tab-with-icon';
    }
    if(item.tabCls){
      cls += ' ' + item.tabCls;
    }

    cls += this.shadowTabs? ' x-tab-strip-disabled': '';

    var tbID = Ext.id();
    var p = {
      id: this.id + this.idDelimiter + item.getItemId(),
      text: item.title,
      cls: cls,
      tabTB: tbID,
      iconCls: item.iconCls || ''
    };

    var el = before ?
             this.itemTpl.insertBefore(before, p) :
             this.itemTpl.append(this.strip, p);

    Ext.fly(el).addClassOnOver('x-tab-strip-over');

    if (this.tabToolbars && !Ext.isEmpty(item.tabToolbar)) {
    item.tabToolbar = new Ext.Toolbar(item.tabToolbar);
    item.tabToolbar.render(tbID);
      item.tabToolbar.removeClass('x-toolbar');
    }

    if(item.tabTip){
      Ext.fly(el).child('span.x-tab-strip-text', true).qtip = item.tabTip;
    }

    item.on('disable', this.onItemDisabled, this);
    item.on('enable', this.onItemEnabled, this);
    item.on('titlechange', this.onItemTitleChanged, this);
    item.on('beforeshow', this.onBeforeShowItem, this);
  }

  ,setActiveTab: function(item){
    item = this.getComponent(item);
    if (!item || this.fireEvent('beforetabchange', this, item, this.activeTab) === false) {
      return;
    }
    if (!this.rendered) {
      this.activeTab = item;
      return;
    }
    if (this.activeTab != item) {
      if (this.activeTab) {
        var oldEl = this.getTabEl(this.activeTab);
        if(oldEl) {
          Ext.fly(oldEl).removeClass('x-tab-strip-active');
          Ext.fly(oldEl).setStyle('padding-top', '0px');
          if (this.shadowTabs) {
            Ext.fly(oldEl).addClass('x-tab-strip-disabled');
          }
        }
        this.activeTab.fireEvent('deactivate', this.activeTab);
      }
      var el = this.getTabEl(item);
      Ext.fly(el).addClass('x-tab-strip-active');
      Ext.fly(el).setStyle('padding-top', '1px');
      if (this.shadowTabs) {
        Ext.fly(el).removeClass('x-tab-strip-disabled');
      }

      this.activeTab = item;
      this.stack.add(item);

      this.layout.setActiveItem(item);
      if (this.layoutOnTabChange && item.doLayout) {
        item.doLayout();
      }
      if (this.scrolling) {
        this.scrollToTab(item, this.animScroll);
      }

      item.fireEvent('activate', item);
      this.fireEvent('tabchange', this, item);
    }
  }

  ,createScrollers: function(){
    var h = this.strip.dom.offsetHeight;

    // left
    var sl = this.header.insertFirst({
      cls:'x-tab-scroller-left'
    });
    sl.setHeight(h);
    sl.addClassOnOver('x-tab-scroller-left-over');
    this.leftRepeater = new Ext.util.ClickRepeater(sl, {
      interval : this.scrollRepeatInterval,
      handler: this.onScrollLeft,
      scope: this
    });
    this.scrollLeft = sl;

    // right
    var sr = this.header.insertFirst({
        cls:'x-tab-scroller-right'
    });
    sr.setHeight(h);
    sr.addClassOnOver('x-tab-scroller-right-over');
    this.rightRepeater = new Ext.util.ClickRepeater(sr, {
      interval : this.scrollRepeatInterval,
      handler: this.onScrollRight,
      scope: this
    });
    this.scrollRight = sr;
  }
});