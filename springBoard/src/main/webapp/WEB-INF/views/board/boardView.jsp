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
					alert("�����Ϸ�");
					
					alert("�޼���:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=0";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
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
						<!-- a�±� �������� �۵��ϴ� ��ư? ��ũ? ����� -->
						<!-- Ŭ�� �� �۵��ϴ� script �ۼ��Ǿ�����.(id�� �ʵ� ã�Ƽ� onclick�̺�Ʈ �߻���Ŵ) -->
						<!-- 1.a�±� ���� href�κп� �̵��� �ּҴ�� javascript:void(0)����. id ����. -->
						<!-- 2.button���� ���� id�������ְ�, ���� ��ư�� a �±�ó�� ���۵ǰ� ��Ÿ���� �Ǵ�. -->
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