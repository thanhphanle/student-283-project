<%@taglib  prefix="tiles"  uri="http://tiles.apache.org/tags-tiles"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><tiles:insertAttribute name="title"/></title>
<link rel="stylesheet" type="text/css" href="/onlinestore/css/style.css">
<link rel="stylesheet" type="text/css" href="/onlinestore/css/reveal.css">
<script type="text/javascript" src="/onlinestore/script/jquery.js" ></script>
<script type="text/javascript" src="/onlinestore/script/jquery.reveal.js" ></script>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".login").die('click');
		$(".login").live('click',function(){
			$("#form_login").reveal();
		});
		$("#login_submit").live("click", function(){
			$("#form_login").hideModal();
		});
		$(".register").die('click');
		$(".register").live("click", function(){
			$("#form_register_abc").reveal();
		});
		
		$("#register_submit").live('click', function(){
			var data_form = $("form.form_register").serialize();
			alert(data_form);
			$.ajax({
				url:"register.html",
				type:"POST",
				data:data_form,
				success: function(data){
					var data1 = data[0]; 
					//alert(data1);
					$('#form_register_abc').trigger('reveal:close');
				},
				error : function(jqXHR, status, errorThrown){ 
					alert("Not success");
				}
			});
		});
	});
</script>
<body>
	<div class="banner_top"></div>
    <div class="header">
    	<tiles:insertAttribute name="header"/>
    </div>
    <div class="content">
    	<tiles:insertAttribute name="content"/>
    </div>
    <div class="footer">
    	<tiles:insertAttribute name="footer"/>
    </div>
    <div id="test"></div>
</body>
</html>