<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		//전체 체크박스 클릭.
		$j("#checkAll").on("click",function(){
			if($j("#checkAll").prop("checked")){
				$j("input[type=checkbox]").prop("checked", true); // 체크하기
			}else{
				$j("input[type=checkbox]").prop("checked", false); //체크해제
			}
		});
		
		$j(".checkbox").on("click",function(){
			if($j(this).prop("checked") == false){
				$j("#checkAll").prop("checked",false);
			}else{
				var cnt = 0;
				$j("input[name=boardType]").each(function(){
					if($j(this).prop("checked") == false){
						return false;
					}else{
						cnt++;
					}
				});
				if(cnt == $j("input[name=boardType]").length){
					$j("input[type=checkbox]").prop("checked", true);
				}
			}
		});
		
		$j("#selectBoardType").on("click",function(){
			var param = "";
			var cnt = 0;
			
			if($j("input[type=checkbox]:checked").length == 0){
				alert("BoardType 미선택");
			}else{
			
				$j("input[name=boardType]:checked").each(function(i){
					var type = $j(this).attr('value');
					param = param+"codeList["+cnt+"].codeId="+type+"&";
					cnt++;
				});
				param = param.slice(0, -1);		
			
				$j.ajax({
				    url : "/board/boardSeach.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success : function(data){
	
				    	//이전게시판지움
				    	$j("#changeBoard tr").remove();
				    	//새게시판생성
				    	rowItem = "<tr><td align='right'>total : "+data.totalCnt+"</td></tr>"
				    			+ "<tr><td><table id='boardTable' border = '1'>"
				    			+ "<tr><td width='80' align='center'>Type</td>"
				    			+ "<td width='40' align='center'>No</td>"
				    			+ "<td width='300' align='center'>Title</td></tr>";
				    	for(var i=0; i<data.boardList.length; i++){
				    		rowItem += "<tr><td align='center'>"+data.boardList[i].codeVo.codeName+"</td>"
				    			+ "<td>"+data.boardList[i].boardNum+"</td>"
				    			+ "<td><a href = '/board/"+data.boardList[i].boardType+"/"+data.boardList[i].boardNum+"/boardView.do?pageNo="+data.pageNo+"'>"+data.boardList[i].boardTitle+"</a></td>";  	
						}
				    		rowItem += "</table></td></tr>";
				    			
				    	$j("#changeBoard").append(rowItem);
	
				    },
				    error: function (data)
				    {
				    	alert("실패");
				    }
				});
			}
		});
		
		
	});
</script>
<body>
<table  align="center">
	<tbody id="changeBoard">
	<tr>
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.codeVo.codeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	</tbody>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkAll" value="all">전체
		<c:forEach items="${codeList}" var="clist">
			<input type="checkbox" class="checkbox" name="boardType" value="${clist.codeId}">${clist.codeName}
		</c:forEach>
		<button type="button" id="selectBoardType">조회</button>
		</td>
	</tr>
</table>	
</body>
</html>