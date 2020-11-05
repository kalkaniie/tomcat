Ext.grid.RowSelectionModel.override({initEvents : function(){if(!this.grid.enableDragDrop && !this.grid.enableDrag){this.grid.on("rowmousedown", this.handleMouseDown, this);}else{this.grid.on("rowclick", function(grid, rowIndex, e){var target = e.getTarget();if(target.className !== 'x-grid3-row-checker' && e.button === 0 && !e.shiftKey && !e.ctrlKey){this.selectRow(rowIndex, false);grid.view.focusRow(rowIndex);}},this);}
this.rowNav = new Ext.KeyNav(this.grid.getGridEl(),{"up" : function(e){if(!e.shiftKey){this.selectPrevious(e.shiftKey);}else if(this.last !== false && this.lastActive !== false){var last = this.last;this.selectRange(this.last,  this.lastActive-1);this.grid.getView().focusRow(this.lastActive);if(last !== false){this.last = last;}}else{this.selectFirstRow();}},"down" : function(e){if(!e.shiftKey){this.selectNext(e.shiftKey);}else if(this.last !== false && this.lastActive !== false){var last = this.last;this.selectRange(this.last,  this.lastActive+1);this.grid.getView().focusRow(this.lastActive);if(last !== false){this.last = last;}}else{this.selectFirstRow();}},scope: this});var view = this.grid.view;view.on("refresh", this.onRefresh, this);view.on("rowupdated", this.onRowUpdated, this);view.on("rowremoved", this.onRemove, this);},toggleChecked : function(rowIndex, c){if(this.locked) return;var record = this.grid.store.getAt(rowIndex);if(c === true){record.set(this.dataIndex, true);}else if(c === false){record.set(this.dataIndex, false);}else{record.set(this.dataIndex, !record.data[this.dataIndex]);}},handleMouseDown : function(g, rowIndex, e){if(e.button !== 0 || this.isLocked()){return;};var view = this.grid.getView();if(e.shiftKey && this.last !== false){var last = this.last;this.selectRange(last, rowIndex, e.ctrlKey);this.selectRangeChecked(last, rowIndex, e.ctrlKey);this.last = last;view.focusRow(rowIndex);}else{var t = e.getTarget();if( t.className != 'x-grid3-row-checker'){this.selectRow(rowIndex, true);}}}});
Ext.apply(Ext.form.VTypes, {daterange: function(val, field) {var date = field.parseDate(val); var dispUpd = function(picker) {var ad = picker.activeDate;picker.activeDate = null;picker.update(ad);};if (field.startDateField) {var sd = Ext.getCmp(field.startDateField);sd.maxValue = date;if (sd.menu && sd.menu.picker) {sd.menu.picker.maxDate = date;dispUpd(sd.menu.picker);}} else if (field.endDateField) {var ed = Ext.getCmp(field.endDateField);ed.minValue = date;if (ed.menu && ed.menu.picker) {ed.menu.picker.minDate = date;dispUpd(ed.menu.picker);}}return true;}});
/*ie8 form serializeForm */
Ext.apply(Ext.lib.Ajax,{serializeForm : function(form) {var fElements = form.elements || (document.forms[form] || Ext.getDom(form)).elements,hasSubmit = false,encoder = encodeURIComponent,element,options,name,val,data = '',type;Ext.each(fElements, function(element) {name = element.name;type = element.type;if (!element.disabled && name){if(/select-(one|multiple)/i.test(type)){Ext.each(element.options, function(opt) {if (opt.selected) {data += String.format("{0}={1}&",encoder(name),(opt.hasAttribute ? opt.hasAttribute('value') : opt.getAttribute('value') !== null) ? opt.value : opt.text);}});} else if(!/file|undefined|reset|button/i.test(type)) {if(!(/radio|checkbox/i.test(type) && !element.checked) && !(type == 'submit' && hasSubmit)){data += encoder(name) + '=' + encoder(element.value) + '&';hasSubmit = /submit/i.test(type);}}}});return data.substr(0, data.length - 1);}});
//Ext.override(Ext.form.ComboBox, {initComponent : function(){Ext.form.ComboBox.superclass.initComponent.call(this);this.addEvents('expand','collapse','beforeselect','select','beforequery');if(this.transform){this.allowDomMove = false;var s = Ext.getDom(this.transform);if(!this.hiddenName){this.hiddenName = s.name;}if(!this.store){this.mode = 'local';var d = [], opts = s.options;for(var i = 0, len = opts.length;i < len; i++){var o = opts[i];var value = (o.hasAttribute ? o.hasAttribute('value') : o.getAttribute('value') !== null) ? o.value : o.text;if(o.selected && !Ext.isEmpty(this.value, true)) {this.value = value;}d.push([value, o.text]);}this.store = new Ext.data.ArrayStore({'id': 0,fields: ['value', 'text'],data : d,autoDestroy: true});this.valueField = 'value';this.displayField = 'text';}s.name = Ext.id();if(!this.lazyRender){this.target = true;this.el = Ext.DomHelper.insertBefore(s, this.autoCreate || this.defaultAutoCreate);Ext.removeNode(s);this.render(this.el.parentNode);}else{Ext.removeNode(s);}}else if(Ext.isArray(this.store)){if (Ext.isArray(this.store[0])){this.store = new Ext.data.ArrayStore({fields: ['value','text'],data: this.store,autoDestroy: true});this.valueField = 'value';}else{this.store = new Ext.data.ArrayStore({fields: ['text'],data: this.store,expandData: true,autoDestroy: true});this.valueField = 'text';}this.displayField = 'text';this.mode = 'local';}this.selectedIndex = -1;if(this.mode == 'local'){if(this.initialConfig.queryDelay === undefined){this.queryDelay = 10;}if(this.initialConfig.minChars === undefined){this.minChars = 0;}}}});
BrowserCheck();
Ext.override(
		Ext.menu.Menu, {    
		autoWidth : function(){     
			
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
Ext.override(Ext.EventObjectImpl, {
    getTarget : function(selector, maxDepth, returnEl){
        var targetElement;

        try {
            targetElement = selector ? Ext.fly(this.target).findParent(selector, maxDepth, returnEl) : this.target;
        } catch(e) {
            targetElement = this.target;
        }
//if(targetElement==null) alert(targetElement)
        return targetElement;
    }
});