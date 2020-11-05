Ext.namespace('addressCommon_space');

addressCommon_space.main = function() {
	function addressAddByMBox() {
		window.open('address.auth.do?method=address_mbox_list','address_popup','width=700,height=500, scrollbars=yes');
	};

	function closeAddressAddByMBox() {
		if (win_address_add instanceof Ext.Window) {
			win_address_add.close();
		}
	};

	function closeAddressListByMBox() {
		if (win_address_list instanceof Ext.Window) {
			win_address_list.close();
		}
	};

	function closeAddressUpDown() {
		if (win_address_up_down instanceof Ext.Window) {
			win_address_up_down.close();
		}
	};

	function mailAddreList() {
  		var objForm = document.f_address_mbox_list;
  		var isChk = false;
  		for(var i = 0;i<objForm.MBOX_IDX.length; i++) {
			if (objForm.MBOX_IDX[i].checked) {
				isChk = true;
				break;
			}
		}

		if (!isChk) {
			alert("선택된 편지함이 없습니다.");
			return ;
		}

  		openAddressListByMBox(objForm);
	};

	function openAddressListByMBox(objForm) {
		var MBOX_IDX_LIST = new Array();
		for(var i=0; i<objForm.MBOX_IDX.length; i++) {

			if (objForm.MBOX_IDX[i].checked) {
				MBOX_IDX_LIST.push(objForm.MBOX_IDX[i].value);
				}
		}
		
		window.open('address.auth.do?method=search_mail_address&MBOX_IDX='+MBOX_IDX_LIST,'address_popup2','width=700,height=500, scrollbars=yes');
		
//		win_address_list = new Ext.Window({
//			id:'kebi_ext_window',
//			title:'편지함에 있는 주소추가',
//			colsable:true,
//			width:700,
//			plain:true,
//			autoScroll:true,
//			autoSize:true,
//			modal:true,
//			bodyStyle:'background:white',
//			closeAction:'close',
//			items:new Ext.Panel({
//				autoScroll: false,
//				method:'POST',
//				autoLoad:{
//					url:'address.auth.do',
//					params: {method:'search_mail_address', MBOX_IDX: MBOX_IDX_LIST},
//					scripts:true
//				}
//			}),
//			callback: closeAddressAddByMBox()
//		});
//
//		win_address_list.show();
	};

	function addressUpDown() {
		win_address_up_down = new Ext.Window({
			id:'win_address_up_down',
			title:'주소록 다운/업로드',
			colsable:true,
			width:330,
			height:391,
			plain:true,
			modal:true,
			closeAction:'close',
			bodyStyle:'background:white',
			border:false,
			items:[ create_address_down_panel()
			,create_address_up_panel()
				  ]
		});
		win_address_up_down.show();

	};


	function fn_addressGrp_ds(str){
	    ds_addressGrp = new Ext.data.JsonStore({
	     	url: 'address.auth.do?method=aj_addressGroupListJson&preAppend='+str,
	     	root: 'addressGrp',
    		fields: [{name:'GROUP_IDX',type:'string'}, {name:'GROUP_NM',type:'string'}]
		});
		ds_addressGrp.load();
		return ds_addressGrp;
	}

	function create_address_down_panel(){

		var fp = new Ext.FormPanel({
		id:'address_down_fm',
        width: 314,
        height:230,
        frame: true,
        autoScroll:false,
        labelWidth: 1,
        title:'주소록 다운로드 ',
        defaults: {
            anchor: '90%',
            allowBlank: false,
            msgTarget: 'side'
        },
        items: [
	        new Ext.form.ComboBox({
	            fieldLabel: '',
	            labelSeparator :'',
	            name:'sel_down_group',
	            store: fn_addressGrp_ds('1'),
	            valueField:'GROUP_IDX',
	            displayField:'GROUP_NM',
	            typeAhead: true,
	            triggerAction: 'all',
	            emptyText:'저장할 주소록 그룹 선택',
	            selectOnFocus:true,
	            width:190,
	            mode:'local'
	        }),{
                bodyStyle: 'padding:0 5px;',
                items: {
                    xtype:'fieldset',
                    title: 'outlook version',
                    defaultType: 'radio',
                    autoHeight:true,
                    labelSeparator :'',
                    items: [{
                        checked: true,
                        labelSeparator :'',
                        fieldLabel: '',
                        boxLabel: 'Outlook Express',
                        name: 'nType',
                        inputValue: '1'
                    },{
                        fieldLabel: '',
                        labelSeparator: '',
                        boxLabel: 'Microsoft Outlook 2000',
                        name: 'nType',
                        inputValue: '2'
                    },{
                        fieldLabel: '',
                        labelSeparator: '',
                        boxLabel: 'Microsoft Outlook 2003',
                        name: 'nType',
                        inputValue: '3'
                    }]
                }
	        }
		],
        buttons: [{
            text: '다운로드',
            handler: function(){
                var nType = Ext.get('address_down_fm').child('input[name=nType]:checked').getValue();
                var sel_down_group_idx = fp.getForm().findField('sel_down_group').getValue();
                var sel_down_group_name = fp.getForm().findField('sel_down_group').el.dom.value;

                if (sel_down_group_idx != "") {
                	//fp.getForm().getEl().dom.target = document.address_temp_frame;
	                fp.getForm().getEl().dom.action = 'address.auth.do?method=download&GROUP_IDX='+sel_down_group_idx+"&GROUP_NM="+sel_down_group_name;
	                fp.getForm().getEl().dom.submit();
                } else {
                	alert("주소록 그룹을 선택하세요.");
                }
            }
        }]
	    });
	    return fp;
	};

	function create_address_up_panel(){

		var fp_up = new Ext.FormPanel({
        id:'address_up_fm',
        fileUpload: true,
        width: 314,
        height:130,
        frame: true,
        autoScroll:false,
        labelWidth: 1,
        title: '주소록 업로드',
        defaults: {
            anchor: '90%',
            allowBlank: false,
            msgTarget: 'side'
        },
        items: [
	        {
	        	xtype : 'combo',
	        	fieldLabel: '',
	            readOnly:true,
	            labelSeparator :'',
	            name:'sel_upload_group',
	            store: fn_addressGrp_ds('2'),
	            valueField:'GROUP_IDX',
	            displayField: 'GROUP_NM',
	            typeAhead: true,
	            triggerAction: 'all',
	            emptyText:'저장될 주소록 그룹 선택',
	            selectOnFocus:true,
	            width:100
	        }
		    ,{
	            xtype: 'fileuploadfield',
	            emptyText: '',
	            labelSeparator :'',
	            name: 'ADDRESS_LIST_FILE',
	            buttonCfg: {
	                text: '',
	                iconCls: 'K_upload-icon'
	            },
	            width:150
	        }
		],
        buttons: [{
            text: '업로드',
            handler: function(){

            	var strFileName = "";
	            if(Ext.isIE) strFileName =  fp_up.form.el.dom.ADDRESS_LIST_FILE.value.substr(fp_up.form.el.dom.ADDRESS_LIST_FILE.value.lastIndexOf("\\") + 1);
	            else strFileName = fp_up.form.el.dom.ADDRESS_LIST_FILE[0].value.substr(fp_up.form.el.dom.ADDRESS_LIST_FILE[0].value.lastIndexOf("\\") + 1);

	            var sel_upload_group_idx = fp_up.getForm().findField('sel_upload_group').getValue();
	            if(fp_up.getForm().isValid()){
		        	fp_up.getForm().submit({
		            	url: 'addressupload.auth.do?method=aj_upload',
		            	params:{strFileName:strFileName,GROUP_IDX:sel_upload_group_idx},
		                waitMsg: 'Uploading your address...',
		                failure: function(fp_up, o){
		                	var response = Ext.util.JSON.decode(o.response.responseText);
		                	alert(response.errors.msg);
		                },
		                success: function(fp_up, o){
		                	var response = Ext.util.JSON.decode(o.response.responseText);
		                	if (response.errors.msg == "") {
								alert("등록 성공했습니다.");
		                	} else {
		                		alert("등록 실패했습니다.");
		                	}
                        }
					});
				}
            }
        },{
            text: '양식다운로드',
            handler: function(){
                return addressSampleDown();
            }
        },{
            text: '취소',
            handler: function(){
                return closeAddressUpDown();
            }
        }]
	    });
	    return fp_up;
	};

	function addressSampleDown() {
		var objForm = win_address_up_down.getEl().dom.getElementsByTagName("form")[0] ;
		var link = "address.auth.do?method=sampledn";
		MM_openBrWindow(link,'address_down_sample','status=no,toolbar=no,scrollbars=no,resizable=no,width=0,height=0');
	};

	function warning() {
		alert("양식의 칼럼 순서가 변경될 경우 정상적인 업로드가 되지 않습니다\n\n변경하지 마시고 필요정보만 입력 후 업로드하세요\n\n");
	};

	function setUploadFile(strFileName) {
		var objForm = win_address_up_down.getEl().dom.getElementsByTagName("form")[0] ;
		objForm.ADDRESS_LIST_FILE_TEMP.value=strFileName;
	};

	function addressAdd() {
	  	var objForm = document.f_pop_mail_address_list;

		if (!isCheckedCheckBox(objForm.ADDRESS_EMAIL)) {
			alert("선택된 항목이 없습니다.");
			return ;
		} else {
			if (!confirm("선택하신 항목을 주소록에 추가 하시겠습니까?")) {
				return ;
			} else {
				Ext.Ajax.request({
					scope :this,
					url: 'address.auth.do',
					method: 'POST',
					form: objForm,
					success : function(response, options) {
				  		var reader = new Ext.data.XmlReader({
				  		   	record: 'RESPONSE'
				  		},
			  			['RESULT','MESSAGE']);
				  		var resultXML = reader.read(response);
				  		if (resultXML.records[0].data.RESULT == "success") {
							alert("주소록에 추가 되었습니다.");
//							opener.opener.mainPanel.body.load( {
//								url: "address.auth.do?method=address_list_std",
//								scripts: true
//						    });
				  		}else{
				  			alert(resultXML.records[0].data.MESSAGE);
				  		}
					},
					failure : function(response, options) {callAjaxFailure(response, options);}
				});
			}
		}
	};


	return {
		addressAddByMBox: function(){return addressAddByMBox();},
		closeAddressAddByMBox: function(){return closeAddressAddByMBox();},
		closeAddressListByMBox: function(){return closeAddressListByMBox();},
		mailAddreList: function(){return mailAddreList();},
		addressUpDown: function(){return addressUpDown();},
		closeAddressUpDown: function(){return closeAddressUpDown();},
		addressListDownLoad: function(){return addressListDownLoad();},
		addressListUpload: function(){return addressListUpload();},
		addressSampleDown: function(){return addressSampleDown();},
		warning: function(){return warning();},
		setUploadFile: function(strFileName) {return setUploadFile(strFileName)},
		addressAdd: function() {return addressAdd()},
		popupaddressAdd: function() {return popupaddressAdd()},
		create_address_up_panel:function(){return create_address_up_panel()},

		init : function() {

		}
	}
}();

Ext.onReady(addressCommon_space.main.init, addressCommon_space.main, true);