
function renderPairDateField(_sdiv, _ediv, _sname, _ename, _sdt, _edt) {
	var sDivObj = document.getElementById(_sdiv);
	var eDivObj = document.getElementById(_ediv);
	
	if (sDivObj == null || eDivObj == null) {
		return;
	} else {
		sDivObj.innerHTML = "";
		eDivObj.innerHTML = "";
	}

	if (_sdt == "" || _sdt == null) {
		_sdt = (new Date()).format('Y-m-d');
	}
	
	if (_edt == "" || _edt == null) {
		_edt = (new Date()).format('Y-m-d');
	}
	
	var df1 = new Ext.form.DateField({
		id:_sname,
		name:_sname,
		format: 'Y-m-d',
		width:85,
		//vtype: 'daterange',
		vtype: '',
		endDateField: _ename,
		itemCls:'s_picker'
	})
	df1.render(_sdiv);

	var df2 = new Ext.form.DateField({
		id:_ename,
		name:_ename,
		format: 'Y-m-d',
		width:85,
        vtype: '',
		startDateField: _sname,
		itemCls:'s_picker'
	})
	
	df2.render(_ediv);
	df1.setValue(_sdt);
	df2.setValue(_edt);
};

function renderDateField(_div, _name, _date) {
	var divObj = document.getElementById(_div);
	if (divObj != null) {
		divObj.innerHTML = "";
	} else {
		return;
	}
	
	if (_date == "") {
		_date = (new Date()).format('Y-m-d');
	}

	var df1 = new Ext.form.DateField({
		id:_name,
		name:_name,
		format: 'Y-m-d',
		itemCls:'s_picker'
	})
	df1.render(_div);		
	df1.setValue(_date);
};
	
function renderTimeField(_div, _name, _time) {
	var divObj = document.getElementById(_div);
	if (divObj != null) {
		divObj.innerHTML = "";
	} else {
		return;
	}
	
	var timeField =new Ext.form.TimeField({
		id:_name,
		name:_name,
        format: 'H:i',
        value: _time,
        readOnly :false,
        width:60
        
    })
    
    timeField.render(_div);
};

function renderPairDateField_Schedule_regist(_sdiv, _ediv, _sname, _ename, _sdt, _edt) {
	var sDivObj = document.getElementById(_sdiv);
	var eDivObj = document.getElementById(_ediv);
	
	if (sDivObj == null || eDivObj == null) {
		return;
	} else {
		sDivObj.innerHTML = "";
		eDivObj.innerHTML = "";
	}

	if (_sdt == "") {
		_sdt = (new Date()).format('Y-m-d');
	}
	if (_edt == "") {
		_edt = (new Date()).format('Y-m-d');
	}

	var df1 = new Ext.form.DateField({
		id:_sname,
		name:_sname,
		format: 'Y-m-d',
		width:85,
		vtype: 'daterange',
		//endDateField: _ename,
		itemCls:'s_picker'
	})
	df1.render(_sdiv);

	var df2 = new Ext.form.DateField({
		id:_ename,
		name:_ename,
		format: 'Y-m-d',
		width:85,
        vtype: 'daterange',
		//startDateField: _sname,
		itemCls:'s_picker'
	})
	df2.render(_ediv);

	df1.setValue(_sdt);
	df2.setValue(_edt);
};