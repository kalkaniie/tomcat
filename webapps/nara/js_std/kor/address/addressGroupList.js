Ext.namespace('addressGroupList_space');
addressGroupList_space.main = function() {
	/*
	Ext.override(Ext.tree.TreeNodeUI, {
    renderElements: function(n, a, targetNode, bulkRender) {
        this.indentMarkup = n.parentNode ? n.parentNode.ui.getChildIndent() : '';
        var cb = a.checked !== undefined;
        var href = a.href ? a.href : Ext.isGecko ? "" : "#";
        var iconCls = a.iconCls || 'x-tree-node-icon';
        var buf = [
            '<li class="x-tree-node">',
                '<table table border="0" cellpadding="0" cellspacing="0">',
                    '<tbody>',
                        '<tr ext:tree-node-id="', n.id, '" class="x-tree-node-el x-tree-node-leaf x-unselectable ', a.cls, '" unselectable="off">',
                            '<td class="x-tree-node-indent">', this.indentMarkup, '</td>',
                            '<td class="' + (n.nextSibling ? 'x-tree-elbow-line' : '') + '">',
                                '<img src="', this.emptyIcon, '" class="x-tree-ec-icon x-tree-elbow" />',
                            '</td>',
                            '<td>',
                                '<img src="', a.icon || this.emptyIcon, '" class="' + iconCls, (a.icon ? " x-tree-node-inline-icon" : ""), (a.iconCls ? " " + a.iconCls : ""), '" unselectable="on" />',
                            '</td>',
                            cb ? ('<td><img src="' + this.emptyIcon + '" class="x-tree-checkbox' + (a.checked === true ? ' x-tree-node-checked' : (a.checked !== false ? ' x-tree-node-grayed' : '')) + '" /></td>') : '',
                            '<td>',
                                '<a hidefocus="on" class="x-tree-node-anchor" href="', href, '" tabIndex="1" ', a.hrefTarget ? ' target="' + a.hrefTarget + '"' : "", '>',
                                    '<span unselectable="on" style="white-space:normal;">',
                                        n.text,
                                    '</span>',
                                '</a>',
                            '</td>',
                        '</tr>',
                    '</tbody>',
                '</table>',
                '<ul class="x-tree-node-ct" style="display:none;"/></ul>',
             "</li>"].join('');
        var nel;
        if (bulkRender !== true && n.nextSibling && (nel = n.nextSibling.ui.getEl())) {
            this.wrap = Ext.DomHelper.insertHtml("beforeBegin", nel, buf);
        }
        else {
            this.wrap = Ext.DomHelper.insertHtml("beforeEnd", targetNode, buf);
        }
        this.elNode = this.wrap.firstChild.firstChild.firstChild;
        this.ctNode = this.wrap.childNodes[1];

        var cs = this.elNode.childNodes;
        this.indentNode = cs[0].firstChild;
        this.ecNode = cs[1].firstChild;
        this.iconNode = cs[2].firstChild;
        var index = 3; //cs.length-2; //3
        if (cb) {
            this.checkbox = cs[index].firstChild;
            index++;
        }
        this.anchor = cs[index].firstChild;
        this.textNode = cs[index].firstChild.firstChild;
    }
});
*/
	var objForm = document.form_address_group_list;
	var tree = new Ext.tree.TreePanel({
		id:'main_addressgroup_tree',
        el:'addr_address_group_tree',
        autoScroll:true,
		width:180,
		height:370,
		bodyStyle:'background:#FBFBFB',
        animate:true,
        containerScroll: true,
        rootVisible:true,
        loader: new Ext.tree.TreeLoader({
            dataUrl:'/mail/address.auth.do?method=aj_getAddressGroup'
        }) 
    });

	var root = new Ext.tree.AsyncTreeNode({
        text:'주소록',
        draggable:false,
        id:'0'
    });
    tree.on('click', function(node, e){
		var objForm = document.form_address_group_list;
    	document.getElementById('iframe_address_list').src = "/mail/address.auth.do?method=address_list_bygroup_std&GROUP_IDX="+node.id;
    	objForm.GROUP_IDX.value = node.id;
    });
	tree.setRootNode(root);
	root.expand(); 
    tree.render();
    tree.on('checkchange', function() {
		checkedNode = this.getChecked();
	}, tree);
    function getCheckedNode(){
    	return tree.getChecked();
    };

    function keywordSearch(){
		var objForm = document.form_address_group_list;
		if (objForm.strKeyword.value.length == 0) {
			alert("검색어를 입력하세요.");
			objForm.strKeyword.focus();
			return;
		}
    	document.getElementById('iframe_address_list').src = "/mail/address.auth.do?method=address_list_bygroup_std&GROUP_IDX="+objForm.GROUP_IDX.value+"&strIndex="+objForm.strIndex.value+"&strKeyword="+objForm.strKeyword.value;
	};
	
	function address_list(group_Idx) {
		var objForm = document.form_address_group_list;
    	document.getElementById('iframe_address_list').src = "/mail/address.auth.do?method=address_list_bygroup_std&GROUP_IDX="+node.id;
    	objForm.GROUP_IDX.value = node.id;		
	};
	
	function group_add() {
		newWindowOpen("그룹별 주소록",400,395,"address.auth.do?method=address_grp_add_form","");
	};

	function group_modify() {
		var _GROUP_IDX;
		if(addressGroupList_space.main.getCheckedNode().length >1){
			alert("하나의 그룹만 선택하여 주십시요");
			return;
		}else if( addressGroupList_space.main.getCheckedNode().length ==1){
			_GROUP_IDX = addressGroupList_space.main.getCheckedNode()[0].attributes.id;
		}else{
			alert("수정할 그룹을 선택하여 주십시요");
			return;
		}
		newWindowOpen("그룹별 주소록",400,238,"/mail/address.auth.do?method=address_grp_modify_form&GROUP_IDX="+_GROUP_IDX,"");
			
	};
	
	//주소록 그룹 삭제
	function group_delete() {
		var objForm = document.form_address_group_list;
	
		if(addressGroupList_space.main.getCheckedNode().length <1){
			alert("그룹을 선택하여 주십시요");
			return;
		}else {
			if (!window.confirm("선택하신 그룹을 삭제 하시겠습니까?")) {
				return ;
			}
		}
		var CHK_GROUP_IDX = new Array();
		for( i=0; i< addressGroupList_space.main.getCheckedNode().length; i++){
			CHK_GROUP_IDX.push(addressGroupList_space.main.getCheckedNode()[i].id);
		}	
		
		Ext.Ajax.request({
			scope :this,
			url: '/mail/address.auth.do?method=aj_delete_address_group',
			params:{CHK_GROUP_IDX :CHK_GROUP_IDX},
			method: 'POST',
			success : function(response, options) {
	  		var reader = new Ext.data.XmlReader({
	  		   	record: 'RESPONSE'
	  			}, 
	  			['RESULT','MESSAGE']);
		  		var resultXML = reader.read(response);
		  		if (resultXML.records[0].data.RESULT == "success") {
		  			Ext.getCmp("main_addressgroup_tree").getRootNode().reload();
		  		}else{
		  			alert(resultXML.records[0].data.MESSAGE);
		  		}
			},
			failure : function(response, options) {
				alert("오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.");
			}
		});
	};
	
	function address_delete() {
		var CHK_ADDRESS_IDX = new Array();
		var addressIdxs = iframe_address_list.document.getElementsByName("ADDRESS_IDX");

		if (addressIdxs != null) {
			for (var i=0; i<addressIdxs.length; i++) {
				if (addressIdxs[i].checked) {
					CHK_ADDRESS_IDX.push(addressIdxs[i].value);
				}
			}
			
			if (CHK_ADDRESS_IDX.length == 0) {
				alert("삭제할 주소를 선택하여 주십시요");
				return;
			}
		} else {
			return;
		}
		
		if (confirm("선택하신 주소를 삭제 하시겠습니까?")) {
			Ext.Ajax.request({
				scope :this,
				url: '/mail/address.auth.do?method=aj_delete_addressByGroup',
				params:{
					CHK_ADDRESS_IDX :CHK_ADDRESS_IDX
				},
				method: 'POST',
				success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
			  			iframe_address_list.document.location.reload();
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
				},
				failure : function(response, options) {
					alert("오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.");
				}
			});
		}
	};	

	function move_address() { 
		var objForm = document.form_address_group_list;
		var objFrame = iframe_address_list.document.form_address_list_frame;
		if(!isCheckedOfBox(objFrame, "ADDRESS_IDX")){
	    	alert("이동할 메일주소를 선택하십시요.");
	    	return;
	  	}
	
		if (objForm.SEL_GROUP_IDX.value == "") {
			alert("이동할 그룹을 선택하세요");
			return;
		}
	
		var selected_key= new Array();
		selected_key = getCheckedAllValue(objFrame,"ADDRESS_IDX",selected_key);
		
		if (confirm("선택하신 주소를 이동 하시겠습니까?")) {
			Ext.Ajax.request({
				scope :this,
				url: 'address.auth.do',
				params:{
					method: 'aj_move_address_type2',
					GROUP_IDX: objForm.SEL_GROUP_IDX.value,
					CHK_ADDRESS_IDX :selected_key
				},
				method: 'POST',
				success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
			  			alert("선택하신 주소가 이동 되었습니다.");
			  			iframe_address_list.document.location.reload();
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
				},
				failure : function(response, options) {
					alert("오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.");
				}
			});
		}
	};
	
	function copy_address() {
		var objForm = document.form_address_group_list;
		var objFrame = iframe_address_list.document.form_address_list_frame;
		if(!isCheckedOfBox(objFrame, "ADDRESS_IDX")){
	    	alert("복사할 메일주소를 선택하십시요.");
	    	return;
	  	}
	
		if (objForm.SEL_GROUP_IDX.value == "") {
			alert("복사할 그룹을 선택하세요");
			return;
		}
	
		var selected_key= new Array();
		selected_key = getCheckedAllValue(objFrame,"ADDRESS_IDX",selected_key);
		
		if (confirm("선택하신 주소를 복사 하시겠습니까?")) {
			Ext.Ajax.request({
				scope :this,
				url: 'address.auth.do',
				params:{
					method: 'aj_copy_address_type2',
					GROUP_IDX: objForm.SEL_GROUP_IDX.value,
					CHK_ADDRESS_IDX :selected_key
				},
				method: 'POST',
				success : function(response, options) {
		  		var reader = new Ext.data.XmlReader({
		  		   	record: 'RESPONSE'
		  			}, 
		  			['RESULT','MESSAGE']);
			  		var resultXML = reader.read(response);
			  		if (resultXML.records[0].data.RESULT == "success") {
			  			alert("선택하신 주소가 복사 되었습니다.");
			  			iframe_address_list.document.location.reload();
			  		}else{
			  			alert(resultXML.records[0].data.MESSAGE);
			  		}
				},
				failure : function(response, options) {
					alert("오류가 발생하였습니다.\n관리자에게 문의 하시기 바랍니다.");
				}
			});
		}
	};
	
	return {
    	getCheckedNode:function(){return getCheckedNode();},
    	keywordSearch:function(){return keywordSearch();},
    	adddress_list:function(group_idx){return adddress_list(group_idx);},
    	group_add:function(){return group_add();},
    	group_modify:function(){return group_modify();},
    	group_delete:function(){return group_delete();},
    	address_delete:function(){return address_delete();},
    	copy_address:function(){return copy_address();},
    	move_address:function(){return move_address();},
    	init : function() { }	
    }
}();
Ext.onReady(addressGroupList_space.main.init, addressGroupList_space.main, true);
