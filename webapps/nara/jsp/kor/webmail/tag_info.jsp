<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.nara.springframework.service.UserTagService"%>
<%@page import="com.nara.jdf.db.entity.UserTagEntity"%>
<%@page import="com.nara.jdf.db.entity.UserEntity"%>
<%@page import="com.nara.web.narasession.UserSession"%>
<%@page import="com.ibatis.dao.client.DaoManager"%>
<%@page import="com.nara.springframework.dao.DaoConfig"%>

<% 
	UserEntity userEntity = UserSession.getUserInfo(request);
	DaoManager daoManager = DaoConfig.getDaoManager();
%>

<table>
	<%
List tmpList = UserTagService.getUsingUserTagList(daoManager, userEntity.DOMAIN, userEntity.USERS_IDX);
Iterator tIterator = tmpList.iterator();	
tmpList = UserTagService.getUserTagList(daoManager, userEntity.DOMAIN, userEntity.USERS_IDX);
	tIterator = tmpList.iterator();
	if(!tIterator.hasNext()) {
%>
	<tr>
		<td>정보가 없습니다.</td>
	</tr>
	<%
	} else {
		UserTagEntity tagEntity = new UserTagEntity();
		while(tIterator.hasNext()) {
			tagEntity = (UserTagEntity)tIterator.next();
			if (tagEntity.TAG_TYPE != 0) {
				if (tagEntity.TAG_NAME.equals("")) {
%>

	<tr>
		<td style="padding: 0 0 0 5px; height: 17px"><img src="/images/kor/ico/<%=tagEntity.TAG_IMG_NAME %>" style="padding: 0 5px 0 0" />
		<input name="M_TAG_NAME" type="text" /><a href="javascript:;" onClick="tagAdd(this);" tag_img="<%=tagEntity.TAG_IMG_NAME %>" tag_type="<%=tagEntity.TAG_TYPE %>" tag_name="<%=tagEntity.TAG_NAME %>">
		<img src="/images/kor/btn/btnD_entry.gif" style="padding: 0 5px" /></a></td>
	</tr>
	<%			
} else {
%>
	<tr>
		<td style="padding: 0 0 0 5px; height: 17px"><img src="/images/kor/ico/<%=tagEntity.TAG_IMG_NAME %>" style="padding: 0 5px 0 0" /><%=tagEntity.TAG_NAME %>
		<a href="javascript:;" onClick="tagEditMode(this);" tag_img="<%=tagEntity.TAG_IMG_NAME %>" tag_type="<%=tagEntity.TAG_TYPE %>" tag_name="<%=tagEntity.TAG_NAME %>">
		<img src="/images/kor/btn/btnD_modify.gif" style="padding: 0 5px;_padding-bottom:1px" /></a>
		<a href="javascript:;" onClick="tagDelete(this);" tag_img="<%=tagEntity.TAG_IMG_NAME %>" tag_type="<%=tagEntity.TAG_TYPE %>" tag_name="<%=tagEntity.TAG_NAME %>">
		<img src="/images/kor/btn/btnD_entry_del.gif" style="padding: 0 5px;_padding-bottom:1px" /></a></td>
	</tr>
	<%					
				}
			}
		}
	}
%>
</table>
