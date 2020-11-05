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
//fontSizes:["8pt","9pt","10pt","11pt","12pt","14pt","18pt","24pt","36pt"],
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
    markup = markup + '<link rel="stylesheet" type="text/css" href="/css_std/km5_std.css" />';
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
  },
  reinstate : function(e){
        var tbState = this.tb.items.items;
        alert(5)
        //console.log(this);        
        e.stopEvent();
        this.reset();
        
        var foreColor = tbState[9].menu.items.items[0].palette.value;
        this.execCmd('forecolor', Ext.isSafari || Ext.isIE ? '#'+foreColor : foreColor);
        
        var backColor2 = tbState[10].menu.items.items[0].palette.value;
        
        if(Ext.isGecko){
            this.execCmd('useCSS', false);
            this.execCmd('hilitecolor', backColor2);
            this.execCmd('useCSS', true);
            this.deferFocus();
        }else{
            this.execCmd(Ext.isOpera ? 'hilitecolor' : 'backcolor', Ext.isSafari || Ext.isIE ? '#'+backColor2 : backColor2);
            this.deferFocus();
        }
                            
        this.execCmd('fontname', tbState[0].el.value);
        this.deferFocus();
                
        if(tbState[2].pressed){this.execCmd('bold');}        
        if(tbState[3].pressed){this.execCmd('italic');}        
        if(tbState[4].pressed){this.execCmd('underline');}
        if(tbState[12].pressed){this.execCmd('justifyleft');}
        if(tbState[13].pressed){this.execCmd('justifycenter');}
        if(tbState[14].pressed){this.execCmd('justifyright');}
    }
});

Ext.ux.HTMLEditorUndoRedo = function(size) {

  // PRIVATE

  // pointer to Ext.ux.HTMLEditor
  var editor;

  // IE only: variables
  // size parameter limits the rollback history
  var volume = size || -1;
  var history = new Array();
  var index = 0;
  var placeholder = 0;
  var count = 0;
  var ignore = false;

  // IE only: updates the toolbar buttons
  var updateToolbar = function() {
    editor.tb.items.map.undo.setDisabled(index < 2);
    editor.tb.items.map.redo.setDisabled(index == count);
  }

  // IE only: updates the editor body
  var reset = function() {
    editor.getEditorBody().innerHTML = history[index].content;
    resetBookmark();
  }

  // IE only: updates the element (when in source edit mode)
  var resetElement = function() {
    editor.el.dom.value = history[index].content;
    resetBookmark();
  }

  // IE only: reposition the cursor
  var resetBookmark = function() {
    var range = editor.doc.selection.createRange();
    range.moveToBookmark(history[index].bookmark);
    range.select();
  }

  // PUBLIC

  return {

    // Ext.ux.HTMLEditorUndoRedo.init
    // called upon instantiation
    init: function(htmlEditor) {
      editor = htmlEditor;

      // add the undo and redo buttons to the toolbar.
      // insert before the sourceedit button
      editor.tb.insertToolsBefore('sourceedit', ['-',
      {
        itemId: 'undo',
        cls: 'x-btn-icon x-edit-undo',
        queryEnabled: ! Ext.isIE,
        handler: Ext.isIE ? this.undo : editor.relayBtnCmd,
        scope: Ext.isIE ? this : editor,
        clickEvent: 'mousedown',
        tooltip: {
          title: 'Undo (Ctrl+Z)',
          text: 'Undo the last edit.',
          cls: 'x-html-editor-tip'
        }
      }, {
        itemId: 'redo',
        cls: 'x-btn-icon x-edit-redo',
        queryEnabled: ! Ext.isIE,
        handler: Ext.isIE ? this.redo : editor.relayBtnCmd,
        scope: Ext.isIE ? this : editor,
        clickEvent: 'mousedown',
        tooltip: {
          title: 'Redo (Ctrl+Y)',
          text: 'Redo the last edit.',
          cls: 'x-html-editor-tip'
        }
      }, '-']);

      // IE only: set up event listeners
      if (Ext.isIE) {
        
        // set element listeners on render
        editor.on('render', function() {

          // monitor for ctrl-z (undo) and ctrl-y (redo) keys
          var keyCommands = [{
            key: 'z',
            ctrl: true,
            fn: this.undo,
            scope: this
          }, {
            key: 'y',
            ctrl: true,
            fn: this.redo,
            scope: this
          }];
          new Ext.KeyMap(editor.getEditorBody(), keyCommands);

          // record changed data when in source edit mode
          editor.el.on('keyup', this.record, this);
        }, this);

        // record changed data when saved back to element
        editor.on('sync', function() {
          if (ignore) {
            ignore = false;
          }
          else {
            this.record();
          }
        }, this);
        
        // perform maintenance when edit mode has changed
        editor.on('editmodechange', function() {

          // set a placeholder when source edit mode is selected
          if (editor.sourceEditMode) {
            placeholder = index;
          }
  
          // else record all changes made in source edit mode as a
          // single historic entry.
          // note: undo/redo functions continue to work while in
          // source edit mode (even when undoing changes made before
          // the mode was changed), but those made while in source
          // edit mode are no longer available once source edit mode
          // is exited as they can appear undesirable or meaningless
          // when in normal edit mode, so they are rolled together
          // to form a single historic change
          else {

            // if changes were made while in source edit mode then
            if (index > placeholder) {
  
              // if starting point was lost to history then
              if (placeholder < 0) {

                // record all source edit mode changes as first
                // historic record
                placeholder == 0;
                history[placeholder] = history[index];
              }

              // else check to see if data has actually changed
              // while in source edit mode then
              else if (history[placeholder].content != history[index].content) {
    
                // record all source edit mode changes as single
                // historic record, to follow last record change
                // made in normal edit mode
                placeholder++;
                history[placeholder] = history[index];
              }

              // reset index and count to placeholder
              index = placeholder;
              count = index;
            }

            // if no changes were made then reset count as it
            // may have grown if changes were made and reversed
            else {
              count = placeholder;
            }
  
            // update the undo/redo buttons on the toolbar
            updateToolbar();
          }
        } , this);
      }
    },
    
    // IE only: record changes to data
    record: function() {

      // get the current html content from the element
      var content = editor.el.dom.value;

      // if no historic records exist yet or content has
      // changed since the last record then
      if (index == 0 || history[index].content != content) {

        // if size of rollbacks has been reached then drop
        // the oldest record from the array
        if (count == volume) {
          history.shift();
          placeholder--;
        }

        // else increment the index
        else {
          index++;
        }

        // record the changed content and cursor position
        history[index] = {
          content: content,
          bookmark: editor.doc.selection.createRange().getBookmark()
        };
        count = index;
      }

      // update the undo/redo buttons on the toolbar
      updateToolbar();
    },
    
    // IE only: perform the undo
    undo: function() {

      // ensure that there is data to undo
      if (index > 1) {

        // decrement the index
        index--;

        // if in source edit mode then update the element directly
        if (editor.sourceEditMode) {
          resetElement();
        }

        // else update the editor body
        else {
          reset();

          // ignore next record request as syncValue is called
          // by Ext.form.HtmlEditor.updateToolBar and we don't
          // want our undo reversed again
          ignore = true;

          // update the editor toolbar and return focus
          editor.updateToolbar();
          editor.deferFocus();
        }

        // update the undo/redo buttons on the toolbar
        updateToolbar();
      }
    },

    // IE only: perform the redo
    redo: function() {

      // ensure that there is data to redo
      if (index < count) {

        // increment the index
        index++;

        // if in source edit mode then update the element directly
        if (editor.sourceEditMode) {
          resetElement();
        }

        // else update the editor body
        else {
          reset();

          // ignore next record request as syncValue is called
          // by Ext.form.HtmlEditor.updateToolBar and we don't
          // want our redo reversed again
          ignore = true;

          // update the editor toolbar and return focus
          editor.updateToolbar();
          editor.deferFocus();
        }

        // update the undo/redo buttons on the toolbar
        updateToolbar();
      }
    }
  }
}
