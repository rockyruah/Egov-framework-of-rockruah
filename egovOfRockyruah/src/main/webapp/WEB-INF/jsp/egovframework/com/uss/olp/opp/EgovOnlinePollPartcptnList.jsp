<%--
  Class Name : EgovOnlinePollResultList.jsp
  Description : 온라인POLL결과 목록 페이지
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2008.03.09    장동한          최초 생성

    author   : 공통서비스 개발팀 장동한
    since    : 2009.03.09
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="ImgUrl" value="/images/egovframework/com/uss/olp/opp/"/>
<%--  자마스크립트 메세지 출력 --%>
${reusltScript}
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<title>EGOV-COM</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/egovframework/com/cmm/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/uss/olp/opp/listOnlinePollPartcptn.do'/>";
   	document.listForm.submit();
}

/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_regist_OnlinePollPartcptn(pollId,sDate,eDate){
	var iToDate = <fmt:formatDate value="${now}" pattern="yyyyMMdd" />;
	var iBeginDate = Number(sDate.replaceAll("-",""));
	var iEndDate = Number(eDate.replaceAll("-",""));


	if(iToDate >= iBeginDate && iToDate <= iEndDate){

		var vFrom = document.listForm;
		vFrom.pollId.value = pollId;
		vFrom.action = "<c:url value='/uss/olp/opp/registOnlinePollPartcptn.do' />";
		vFrom.submit();
	}else{
		alert("지금은 온라인POLL 투표기간이 아닙니다!");
		return;
	}

}

/* ********************************************************
 * 검색 함수
 ******************************************************** */
function fn_egov_search_OnlinePollPartcptn(){
	var vFrom = document.listForm;

	vFrom.action = "<c:url value='/uss/olp/opp/listOnlinePollPartcptn.do' />";
	vFrom.submit();

}

/* ********************************************************
* PROTOTYPE JS FUNCTION
******************************************************** */
String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/g, "");
}

String.prototype.replaceAll = function(src, repl){
	 var str = this;
	 if(src == repl){return str;}
	 while(str.indexOf(src) != -1) {
	 	str = str.replace(src, repl);
	 }
	 return str;
}
</script>
</head>
<body>
<DIV id="content" style="width:712px">
<%-- noscript 테그 --%>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

<form name="listForm" action="<c:url value='/uss/olp/opp/listOnlinePollPartcptn.do'/>" method="post">
<table width="100%" cellpadding="1" class="table-search" border="0">
 <tr>
  <td class="title_left">
   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목아이콘이미지">&nbsp;온라인POLL참여 목록</td>
  <th>
  </th>
  <td width="110px">
   	<select name="searchCondition" class="select" style="width:100%" title="검색조건선택">
		   <option value=''>--선택하세요--</option>
		   <option value='POLL_NM' <c:if test="${searchCondition == 'POLL_NM'}">selected</c:if>>POLL명</option>
	   </select>
	</td>
  <td width="180px">
    <input name="searchKeyword" type="text" size="10" value="${searchKeyword}" maxlength="35" style="width:100%" title="검색내용입력">
  </td>
  <td width="2px"></td>
  <th width="35px" align="center">
 	<table border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td><span class="button"><input type="submit" value="<spring:message code="button.inquire" />" onclick="fn_egov_search_OnlinePollPartcptn(); return false;"></span></td>
	   </tr>
	</table>

  </th>
 </tr>
</table>
<input name="pollId" type="hidden" value="">
<input name="searchMode" type="hidden" value="">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form>

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>
<table width="100%" cellpadding="0" class="table-line" border="0">
<thead>
  <tr>
    <th class="title" width="35px" nowrap>순번</th>
    <th class="title" nowrap>온라인POLL명</th>
    <th class="title" width="70px" nowrap>시작일</th>
    <th class="title" width="70px" nowrap>종료일</th>
    <th class="title" width="50px" nowrap>통계</th>
    <th class="title" width="70px" nowrap>등록자</th>
    <th class="title" width="70px" nowrap>등록일자</th>
  </tr>
</thead>
<tbody>
<%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
<c:if test="${fn:length(resultList) == 0}">
<tr>
<td class="lt_text3" colspan="8">
	<spring:message code="common.nodata.msg" />
</td>
</tr>
</c:if>
<%-- 데이터를 화면에 출력해준다 --%>
<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
<tr>
    <td class="lt_text3" nowrap><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
    <td class="lt_text3L" nowrap>

	    	<form name="subForm" method="post" action="<c:url value='/uss/olp/opp/registOnlinePollPartcptn.do'/>">
			<input name="pollId" type="hidden" value="<c:out value="${resultInfo.pollId}"/>">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<span class="link"><input type="button" style="width:350px;text-align:left;" value="<c:out value="${resultInfo.pollNm}"/>" onclick="fn_egov_regist_OnlinePollPartcptn('<c:out value="${resultInfo.pollId}"/>','<c:out value="${fn:substring(resultInfo.pollBeginDe, 0, 10)}"/>','<c:out value="${fn:substring(resultInfo.pollEndDe, 0, 10)}"/>'); return false;"></span>
	    	</form>
    </td>
    <td class="lt_text3"><c:out value="${resultInfo.pollBeginDe}"/></td>
    <td class="lt_text3"><c:out value="${resultInfo.pollEndDe}"/></td>
    <td class="lt_text3">
    <form name="subFormStatistics" method="post" action="<c:url value='/uss/olp/opp/statisticsOnlinePollPartcptn.do'/>">
    <input name="pollId" type="hidden" value="<c:out value="${resultInfo.pollId}"/>">
    <input name="linkType" type="hidden" value="2">
    <span class="button"><input type="submit" value="보기"></span>
    </form>
    </td>
    <td class="lt_text3"><c:out value="${resultInfo.frstRegisterNm}"/></td>
    <td class="lt_text3"><c:out value="${fn:substring(resultInfo.frstRegisterPnttm, 0, 10)}"/></td>
</tr>
</c:forEach>
</tbody>
</table>

<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td height="3px"></td>
</tr>
</table>

<div align="center">
	<div>
		<ui:pagination paginationInfo = "${paginationInfo}"
				type="image"
				jsFunction="linkPage"
				/>
	</div>
</div>


</DIV>

</body>
</html>
