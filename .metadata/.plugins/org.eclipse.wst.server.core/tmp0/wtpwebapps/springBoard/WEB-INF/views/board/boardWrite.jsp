<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	var row_cnt = 0;

	$j(document).ready(function(){
		
		
		$j("#submit").on("click",function(){
			
			// �Է°���ȭ
			var isRight = true;
            $j(".boardWrite").find("input").each(function(index, item){
                // �ƹ������� ���⸸ ���� ���� �� ������ üũ�ǵ��� trim() �Լ� ȣ��
                if ($j(this).val().trim() == '') {
                    alert(" �� ���� �ֽ��ϴ�. �ۼ��� Ȯ�����ּ���.");
                    isRight = false;
                    return false;
                }
            });

            if (!isRight) {
                return;
            }
            
            var typeArray = new Array(); // �� ���� �迭
			// ����Ʈ�ڽ��� �ִ� ���� �ϳ��� ���� �迭�� ��� ����.
			$j('select[class=select] option:selected').each(function(index){
				var type = $j(this).attr('value');
				typeArray.push(type);
			});
            
			var $frm = $j('.boardWrite :input');
			var param = 'boardVolist[0].boardType='+typeArray[0]+'&'+$frm.serialize();
			
			
            //param ���� ���� �ٲ�. �߰��� board ��ŭ. list<vo>�� �����Բ�.
			for(var i=1; i<=$j('.deleteForm').length; i++){
				param = param.replace('&boardTitle=','&boardVolist['+i+'].boardType='+typeArray[i]+'&boardTitle=');
				param = param.replace('&boardTitle=','&boardVolist['+i+'].boardTitle=');
				param = param.replace('&boardComment=','&boardVolist['+i+'].boardComment=');
				
			}
			
            
            console.log(param);
            
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("�ۼ��Ϸ�");
					
					alert("�޼���:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=0";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
		});
		
		
		$j("#addRow").on("click",function(){
			row_cnt = row_cnt +1;
			var rowItem = "<tr id='boardType"+row_cnt+"'>"
				 + "<td width='120' align='center'>Type</td>"
				 + "<td width='400'>"
				 + "<select class='select'>"
				 + "<c:forEach items='${codeList}' var='clist'>"
				 + "<option value='${clist.codeId}'>${clist.codeName}</option>"
				 + "</c:forEach></select>"
				 + "<button type='button' id='"+row_cnt+"' style='float:right' class='deleteForm'>x</button></td></tr>"
				 + "<tr id='title"+row_cnt+"'>"
				 + "<td width='120' align='center'>Title</td>"
				 + "<td width='400'><input type='text' name='boardTitle' style='width:92%;float:left' size='50' value='${board.boardTitle}'></td>"
				 + "</tr>"
				 + "<tr id='comment"+row_cnt+"'>"
				 + "<td height='300' align='center'>Comment</td>"
				 + "<td valign='top'><textarea name='boardComment' rows='20' cols='55'>${board.boardComment}</textarea></td>"
				 + "</tr>";
				 
				
				$j('#writer').before(rowItem); // �������� board �߰�(�ۼ��� before).
			
		});
		
	});
	
	// ���� �߰��� �±״� �ٸ� ������� �̺�Ʈ �ɾ��־����.
	$j(document).on("click",".deleteForm",function(){
		var id = $j(this).attr("id");
		$j("#title"+id).remove();
		$j("#comment"+id).remove();
		$j("#boardType"+id).remove();
		
	});

</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="�ۼ�">
			<input id="addRow" type="button" value="���߰�">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1">
					<tr id="type0">
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
							<select class="select">
								<c:forEach items="${codeList}" var="clist">
									<option value="${clist.codeId}">${clist.codeName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr id="title0">
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardVolist[0].boardTitle" type="text" style="width:92%;float:left" size="50" value="${board.boardTitle}"> 
						<!-- <button type="button" id="1" style="float:right" class="deleteForm">x</button>-->
						</td>
					</tr>
					<tr id="comment0">
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardVolist[0].boardComment" rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>				
					<tr id="writer">
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
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>