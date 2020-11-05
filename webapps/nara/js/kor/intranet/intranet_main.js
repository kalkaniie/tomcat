/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */
Ext.namespace('intranet_main_space');

intranet_main_space.intranet_main = function() {
	
	function goOrganizeHome(_organize_idx) {
		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=organize_home&ORGANIZE_IDX=" + _organize_idx,
			scripts: true
	    });	 
	};
	
	function mailSend(_m_to) {
		goRightDivRenderParams("webmail.auth.do", "method=mail_write&M_TO=" + _m_to, "편지쓰기:인터라넷-" + getUniqueString());
	};
	
	function goOrganizeBoard() {
		mainPanel.getActiveTab().body.load( {
			url: "intranet.auth.do?method=intranet_main",
			scripts: true
	    });	 
	};
	
	return {
		goOrganizeHome: function(_organize_idx){return goOrganizeHome(_organize_idx);},
		mailSend: function(_m_to){return mailSend(_m_to);},
		goOrganizeBoard: function(){return goOrganizeBoard();},		
		init : function() {
		}
	}
}();

Ext.onReady(intranet_main_space.intranet_main.init, intranet_main_space.intranet_main, true);

