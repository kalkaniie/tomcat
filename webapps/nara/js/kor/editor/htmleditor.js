Ext.namespace('Ext.ux');
Ext.ux.HTMLEditorToolbar = Ext.extend(Ext.Toolbar,{
  initComponent: function() {
    Ext.ux.HTMLEditorToolbar.superclass.initComponent.call(this);
    this.tools = new Ext.util.MixedCollection(false, function(tool) {
      return tool.itemId || tool.id || Ext.id();
    });
  },addTools: function(tools) {
    tools = (tools instanceof Array) ? tools : [tools];
    for (var i = 0, len = tools.length; i < len; i++) {
      this.tools.add(tools[i]);
    }
  },insertTools: function(index, tools) {
    tools = (tools instanceof Array) ? tools : [tools];
    for (var i = 0, len = tools.length; i < len; i++) {
      this.tools.insert(index + i, tools[i]);
    } 
  },insertToolsBefore: function(itemId, tools) {
    var index = this.tools.indexOfKey(itemId);
    this.insertTools(index, tools);
  },insertToolsAfter: function(itemId, tools) {
    var index = this.tools.indexOfKey(itemId) + 1;
    this.insertTools(index, tools);
  },renderTool: function(tool) {
    if (typeof tool == "object" && tool.xtype && tool.xtype == "tbcombo") {
      this.addItem(Ext.ComponentMgr.create(tool));
    }else{
      this.add(tool);
    }
  },onRender: function(ct, position) {
    Ext.ux.HTMLEditorToolbar.superclass.onRender.call(this, ct, position);
    this.tools.each(this.renderTool, this);
  }
});
Ext.ux.HTMLEditorToolbar.ComboBox = function(config) {
  Ext.apply(this, config);
  var selEl = document.createElement("select");
  selEl.className = this.cls;
  for (var i = 0, len = this.opts.length; i < len; i++) {
    var opt = this.opts[i];
    var optEl = document.createElement('option');
    optEl.text = opt.text;
    optEl.value = opt.value;
    if (opt.selected) {
      optEl.selected = true;
      this.defaultValue = opt.value;
    }
    selEl.options.add(optEl);
  }
  if (! this.defaultValue) {
    this.defaultValue = this.opts[0].value;
  }
  Ext.ux.HTMLEditorToolbar.ComboBox.superclass.constructor.call(this, selEl);
}
Ext.extend(Ext.ux.HTMLEditorToolbar.ComboBox, Ext.Toolbar.Item, {
  render: function(td) {
    Ext.ux.HTMLEditorToolbar.ComboBox.superclass.render.call(this, td);
    Ext.EventManager.on(this.el, 'change', this.handler, this.scope);
  }
});
Ext.ComponentMgr.registerType('tbcombo', Ext.ux.HTMLEditorToolbar.ComboBox);
Ext.ux.HTMLEditor = Ext.extend(Ext.form.HtmlEditor,{
fontFamilies:['굴림','굴림체','돋움','돋움체','궁서','궁서체','Arial','Courier New','Tahoma','Verdana'],
fontSizes:[1,2,3,4,5,6,7],
defaultFont:'굴림',
ctCls:'aaa',
copyRange:true,
toolbarItems: ['fonts','allfontsizes','allformats','allcolors','allalignments','alllinks','alllists','sourceedit'],
  toolbarItemExcludes: [],
  initComponent: function() {
    Ext.ux.HTMLEditor.superclass.initComponent.call(this);
    this.addEvents({
      editorevent: true
    });
    for (var i = 0, iMax = this.toolbarItemExcludes.length; i < iMax; i++) {
      var item = this.toolbarItemExcludes[i].toLowerCase();
      for (var j = 0, jMax = this.toolbarItems.length; j < jMax; j++) {
        if (this.toolbarItems[j] == item) {
          this.toolbarItems.splice(j, 1);
          break;
        }
      }
    }
    this.tb = new Ext.ux.HTMLEditorToolbar();
    this.createTools(this.toolbarItems);
  },createFontOptions: function() {
    var opts = [], ffs = this.fontFamilies, ff;
    for (var i = 0, len = ffs.length; i < len; i++) {
      ff = ffs[i];
      fflc = ff.toLowerCase();
      var opt = {text: ff, value: fflc};
      if (fflc == this.defaultFont) opt.selected = true;
      opts.push(opt);
    }
    return opts;
  },createFontSizeOptions: function() {
    var opts = [], ffs = this.fontSizes, ff;
    for (var i = 0, len = ffs.length; i < len; i++) {
      ff = ffs[i];
      fflc = ff ;//.toLowerCase();
      var opt = {text: ff, value: fflc};
      if (fflc == 2) opt.selected = true;
      opts.push(opt);
    }
    
    return opts;  
  },btn: function(id, toggle, queryState, handler) {
    return {
      itemId: id,
      cls: 'x-btn-icon x-edit-' + id,
      enableToggle: toggle !== false,
      queryState: queryState !== false,
      handler: handler || this.relayBtnCmd,
      scope: this,
      clickEvent: 'mousedown',
      tooltip: this.buttonTips[id] || undefined,
      tabIndex: -1
    };
  },createTools: function(toolbarItems) {
    toolbarItems = (toolbarItems instanceof Array) ? toolbarItems : [toolbarItems];
    for (var i = 0, len = toolbarItems.length; i < len; i++) {
      var item = toolbarItems[i];
      switch (item) {
        case 'fonts':
          if (! Ext.isSafari) {
            this.tb.addTools({
              itemId: 'fontname',
              xtype: 'tbcombo',
              cls: 'x-font-select',
              opts: this.createFontOptions(),
              queryValue: true,
              handler: function(event, el) {
                this.relayCmd('fontname', el.value);
                this.deferFocus();
              },
              scope: this
            });
  	      }
          break;
        case 'allfontsizes':
          if (! Ext.isSafari) {
            this.tb.addTools({
              itemId: 'fontsize',
              xtype: 'tbcombo',
              cls: 'x-font-select',
              opts: this.createFontSizeOptions(),
              queryValue: true,
              handler: function(event, el) {
                this.relayCmd('fontsize', el.value);
                this.deferFocus();
              },
              scope: this
            });
  	      }
          break; 
        case 'bold':
          this.tb.addTools(this.btn('bold'));
          break;
        case 'italic':
          this.tb.addTools(this.btn('italic'));
          break;
        case 'underline':
          this.tb.addTools(this.btn('underline'));
          break;
        case 'allformats':
          this.createTools(['-', 'bold', 'italic', 'underline']);
          break;
         
//        case 'increasefontsize':
//          this.tb.addTools(this.btn('increasefontsize', false, false, this.adjustFont));
//          break;
//        case 'decreasefontsize':
//          this.tb.addTools(this.btn('decreasefontsize', false, false, this.adjustFont));
//          break;
//        case 'allfontsizes':
//          this.createTools(['-', 'increasefontsize', 'decreasefontsize']);
//          break;
        case 'forecolor':
          this.tb.addTools({
            itemId: 'forecolor',
            cls: 'x-btn-icon x-edit-forecolor',
            clickEvent: 'mousedown',
            tooltip: this.buttonTips['forecolor'],
            tabIndex: -1,
            menu: new Ext.menu.ColorMenu({
              allowReselect: true,
              focus: Ext.emptyFn,
              value: '000000',
              plain: true,
              selectHandler: function(cp, color) {
                this.execCmd('forecolor', Ext.isSafari || Ext.isIE ? '#' + color : color);
                this.deferFocus();
              },
              scope: this,
              clickEvent:'mousedown'
            })
          });
          break;
        case 'backcolor':
          this.tb.addTools({
            itemId: 'backcolor',
            cls: 'x-btn-icon x-edit-backcolor',
            clickEvent: 'mousedown',
            tooltip: this.buttonTips['backcolor'],
            tabIndex: -1,
            menu: new Ext.menu.ColorMenu({
              focus: Ext.emptyFn,
              value: 'FFFFFF',
              plain: true,
              allowReselect: true,
              selectHandler: function(cp, color) {
                if (Ext.isGecko) {
                  this.execCmd('useCSS', false);
                  this.execCmd('hilitecolor', color);
                  this.execCmd('useCSS', true);
                  this.deferFocus();
                }else {
                  this.execCmd(Ext.isOpera ? 'hilitecolor' : 'backcolor',
                    Ext.isSafari || Ext.isIE ? '#' + color : color);
                  this.deferFocus();
                }
              },scope: this,
              clickEvent: 'mousedown'
            })
          });
          break;
        case 'allcolors':
          this.createTools(['-', 'forecolor', 'backcolor']);
          break;
        case 'justifyleft':
          this.tb.addTools(this.btn('justifyleft'));
          break;
        case 'justifycenter':
          this.tb.addTools(this.btn('justifycenter'));
          break;
        case 'justifyright':
          this.tb.addTools(this.btn('justifyright'));
          break;
        case 'allalignments':
          this.createTools(['-', 'justifyleft', 'justifycenter', 'justifyright']);
          break;
        case 'link':
          if (! Ext.isSafari) {
            this.tb.addTools(this.btn('createlink', false, false, this.createLink));
          }
          break;
        case 'alllinks':
          if (! Ext.isSafari) {
            this.createTools(['-', 'link']);
          }
          break;
        case 'orderedlist':
          if (! Ext.isSafari) {
            this.tb.addTools(this.btn('insertorderedlist'));
          }
          break;
        case 'unorderedlist':
          if (! Ext.isSafari) {
            this.tb.addTools(this.btn('insertunorderedlist'));
          }
          break;
        case 'alllists':
          if (! Ext.isSafari) {
            this.createTools(['-', 'orderedlist', 'unorderedlist']);
          }
          break;
        case 'sourceedit':
          if (! Ext.isSafari) {
            this.tb.addTools(this.btn('sourceedit', true, false, function(btn) {
              this.toggleSourceEdit(btn.pressed);
            }));
          }
          break;
        default:
          this.tb.addTools(item);
      }
    }
  },createToolbar: function() {
    this.tb.render(this.wrap.dom.firstChild);
    this.tb.el.on('click', function(e) {
      e.preventDefault();
    });
  },getDocMarkup: function() {
    var markup = '<html><head><style type="text/css">body{border:0;margin:0;padding:3px;height:98%;cursor:text;}</style>';
    if (this.styles) {
      for (var i = 0; i < this.styles.length; i++) {
        markup = markup + '<link rel="stylesheet" type="text/css" href="' + this.styles[i] + '" />';
      }
    }
    markup = markup + '</head><body></body></html>';
    return markup;
  },onEditorEvent: function(e) {
  	 if(Ext.isIE) this.copyRange = this.doc.selection.createRange(); //Added this bit

    Ext.ux.HTMLEditor.superclass.onEditorEvent.call(this, e);
    this.fireEvent('editorevent', this, e);    
  },updateToolbar: function() {
    if (! this.activated) {
      this.onFirstFocus();
      return;
    }
    this.tb.items.each(function(item) {
      if (item.queryState) {
        item.toggle(this.doc.queryCommandState(item.itemId));
      }else if (item.queryEnabled) {
        item.setDisabled(! this.doc.queryCommandEnabled(item.itemId));
      }else if (item.xtype = "tbcombo" && item.queryValue) {
      	if(item.itemId =="fontname" ){
	      	var value = (this.doc.queryCommandValue("fontname") || item.defaultValue).toLowerCase();
	        if (value != item.el.value) {
	          item.el.value = value;
	        }
      	}else if( item.itemId =="fontsize" ){
	      	var value = (this.doc.queryCommandValue("fontsize") ||2);
	        if (value != item.el.value) {
	          item.el.value = value;
	        }
      	}   
      }
    }, this);
    Ext.menu.MenuMgr.hideAll();
    this.syncValue();
  }
});
