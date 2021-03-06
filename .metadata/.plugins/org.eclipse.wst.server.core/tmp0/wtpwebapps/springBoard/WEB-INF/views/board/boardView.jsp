<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>

<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#delete").on("click",function(){
			
			$j.ajax({
			    url : "/board/boardDeleteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : {
			    	boardType:'${board.boardType}',
			    	boardNum:${board.boardNum}
			    },
			    success: function(data, textStatus, jqXHR)
			    {
					alert("삭제완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=0";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
	});

</script>

<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<!--<tr>
					<td width="120" align="center">
					Type
					</td>
					<td width="400">
					${board.codeVo.codeName}
					</td>
				</tr>-->	
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table align="right">
				<tr>
					<td>
						<a href="/board/boardList.do">List</a>
					</td>
					<td>
						<a href="/board/${board.boardType}/${board.boardNum}/boardUpdate.do">Update</a>
					</td>
					<td>
						<!-- a태그 형식으로 작동하는 버튼? 링크? 만들기 -->
						<!-- 클릭 시 작동하는 script 작성되어있음.(id로 필드 찾아서 onclick이벤트 발생시킴) -->
						<!-- 1.a태그 만들어서 href부분에 이동할 주소대신 javascript:void(0)설정. id 설정. -->
						<!-- 2.button으로 만들어서 id지정해주고, 따로 버튼에 a 태그처럼 동작되게 스타일을 건다. -->
						<a href="javascript:void(0);" id="delete">Delete</a>
						<!--  <input id="delete" type="button" value="delete">-->
					</td>
				</tr>		
			</table>
		</td>
	</tr>
</table>	
</body>
</html>