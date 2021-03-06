<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>群发短信</title>
	<base href="<%=basePath%>"/>
	<script src="scripts/base/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="scripts/sui/mini-all-min.js" type="text/javascript"></script>
	<link href="scripts/sui/themes/default/miniui.css" rel="stylesheet" type="text/css" />
	<link href="scripts/sui/themes/default/plugin.css" rel="stylesheet" type="text/css" />
	<link href="scripts/sui/themes/icons.css" rel="stylesheet" type="text/css" />
	<link href="scripts/sui/themes/sqt/skin.css" rel="stylesheet" type="text/css" />
	<link href="styles/style_sqt.css" rel="stylesheet" type="text/css" />

</head>

<body class="body_fit" >
<form id="form1" method="post">
	<div class="mini-fit" id="datagrid">
		<div align="center" style="padding-top: 30px">
			<table style="width:80%;">
			    <tr>
                    <td class="mini-item_18">
                                              短信内容：
                    </td>
                    <td class="mini-content_32">
                      <input id="type" class="mini-hidden" value="0" name="type" type="hidden"/>   
                 	  <textarea class="mini-textarea" name="message" emptyText="请输入短信内容，长度不超过80个字.内容为空将不发送短信" required id="message" maxLength="80" validateOnLeave="true" width="300px" height="100px"></textarea>
                    </td>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<td style="text-align: center;" colspan="2">
						<a class="mini-button font13 blue"
							style="margin: 5px 10px 0px 0; padding: 1px 10px;"
							onclick="handle('sure')">确定</a> 
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="mini-button font13 blue"
							style="margin: 5px 10px 0px 0; padding: 1px 10px;"
							onclick="handle('cancel')">取消</a>
					</td>
					
				</tr>
			</table>
		</div>
	</div>
	 </form>
<script type="text/javascript">
    mini.parse();
    var gridUrl = "api/stock/web/manager/sendMsgToAll";
    function handle(type) {
		if (type == 'sure') {
			var form = new mini.Form("form1");
			var o = form.getData();  
			form.validate();
			if (form.isValid() == false) return;
			var json = mini.encode(o);
			
			$.ajax({
                url: gridUrl,
                type: "POST",
                data: { data: json },
                success: function(data) {
                	if(data=='1'){
                		mini.alert("发送成功！","",function(action){
	                		if (action == "ok") {
	                			CloseWindow('save');
	                		}
	                	});
                	}else{
                		mini.alert('发送失败，请联系管理员');
                	}
                }
            });
		}else{
			close();
		}
	}
	
    
    function SetData(data) {
       data = mini.clone(data);
       //mini.get("nickname").setValue(data.text);
       //mini.get("telephone").setValue(data.telephone); 
    }
    
	function CloseWindow(action) {
      	if (window.CloseOwnerWindow){
      		return window.CloseOwnerWindow(action);
      	}else{
      		window.close();
      	}
    }

	function close() {
    	CloseWindow("cancel");
    }
    
</script>
</body>
</html>
