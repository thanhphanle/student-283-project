<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<script>
	$(document).ready(function(){
		var list_name_image = new Array();
		$('.admin_detail_product').live('click',function (e) {
			//alert("ancmada");
			var id =$(this).attr("idproduct");
			
			$.ajax({
				url:"adminDetailProduct.html",
				data:{id:id},
				type:"POST",
				success:function(data){
					//document.getElementById("form_admin_detail_product").reset();
					$(".icon_content").empty();
					$("#adminDetailProduct").reveal();
					//$(".form_admin_detail_product").html(data);
					$(".detail_producer").val(data.producer);
					$(".detail_name").val(data.name);
					$(".detail_description").val(data.description);
					$(".detail_price").val(data.price);
					$(".detail_promotion").val(data.promotion);
					$(".detail_status").val(data.status);
					$(".icon_content").append('<img alt="" src="'+data.icon+'" id="icon_content">');
					for(var i = 0; i < data.images.length; i++)
					{
						//alert(data.images[i]["imag"]);
						$(".gallery_content").append('<div class="gallery_item"><img alt="" src="'+data.images[i]["imageName"]+'"><span id="name_gallery_item">'+(i +1)+'</span></div>')
					}
						
					var length = data.name;
					
				}
			});
		});
		$('.admin_edit_product').live('click',function (e) {
			//alert("ancmada");
			var id =$(this).attr("idproduct");
			
			$.ajax({
				url:"adminDetailProduct.html",
				data:{id:id},
				type:"POST",
				success:function(data){
					document.getElementById("form_admin_edit_product").reset();
					$(".edit_gallery_content").empty();
					$(".icon_content").empty();
					$("#adminEditProduct").reveal();
					//$(".form_admin_detail_product").html(data);
					$(".edit_producer").val(data.producer);
					$(".edit_name").val(data.name);
					$(".edit_description").val(data.description);
					$(".edit_price").val(data.price);
					$(".edit_promotion").val(data.promotion);
					$(".edit_status").val(data.status);
					$(".icon_content").append('<img alt="" src="'+data.icon+'" id="icon_content">');
					for(var i = 0; i < data.images.length; i++)
					{
						//alert(data.images[i]["imag"]);
						$(".edit_gallery_content").append('<div class="gallery_item" id="image'+data.images[i]["id"]+'"><img alt="" src="'+data.images[i]["imageName"]+'"><input type="button" value="Xóa" imageId="'+data.images[i]["id"]+'" class="gallary_delete_image"></div>')
						//$(".list_name_image").val($(".list_name_image").val()+data.images[i]["imageName"]);
						var temp = data.images[i]["id"];
						list_name_image.push({"id" :data.images[i]["id"],"name":data.images[id]["imageName"]});
					}
						
					var length = data.name;
					
				}
			});
		});
		$(".save_change_icon").on("click", function() {
			var formData = new FormData($('#uploadForm')[0]);
			$.ajax({
			    url: "uploadImage.html",
			    type: "POST",
			    contentType: false,
			    processData: false,
			    cache: false,
			    data: formData,
			    success: function(data) {
			    	if(data.code == 1)
			    	{
			    		alert("success");
			    		$("#changeIconProduct").trigger('reveal:close');
			    		$('#adminEditProduct').reveal();
			    		$(".icon_content").empty();
			    		$(".icon_content").append('<img alt="" src="'+data.link+'" id="icon_content">');
			    		$(".admin_detail_product_icon").append('<input type="hidden" class="name_icon_change" value="'+data.link+'">')
			    	}
			    },
			    error: function() {
			        alert("unable to create the record");
			    }
			});
		});
		$("#button_change_icon").live('click', function() {
			$('#adminEditProduct').hideModal();
			$("#changeIconProduct").reveal();
		});
		$(".cancel_change_icon").live('click', function(){
			$('#changeIconProduct').trigger('reveal:close');
			$('#adminEditProduct').reveal();
		});
		$("save_edit_product").live('click', function(){
			var data_form = $("form.form_admin_edit_product").serialize();
			$.ajax({
				url:"editProduct.html",
				type:"POST",
				data:data_form,
				success:function(data){
					
				}
			});
		});
		$(".gallary_delete_image").die();
		$(".gallary_delete_image").live("click",function(){
			var id = $(this).attr('imageId');
			//document.getElementById("gallery").remove();
			$("#image"+id).remove();
			
			var element = document.getElementById("image"+id);
			element.parentNode.removeChild(element);
			//element.outerHTML = "";
			//delete element;
			for(var key in list_name_image)
			{
				if(list_name_image[key].id == id)
				{
					list_name_image.splice(key,1);
				}
				
			}
			
			
			
			return false;
		});
		
		$(".edit_product_add_image").live('click', function(){
			$('#adminEditProduct').hideModal();
			$("#addImageGalleryProduct").reveal();
		});
		
		$(".save_add_image").on("click", function() {
			var formData = new FormData($('#addImageForm')[0]);
			$.ajax({
			    url: "addImageToGallery.html",
			    type: "POST",
			    contentType: false,
			    processData: false,
			    cache: false,
			    data: formData,
			    success: function(data) {
			    	if(data.code == 1)
			    	{
			    		//alert("success");
			    		$("#addImageGalleryProduct").trigger('reveal:close');
			    		$('#adminEditProduct').reveal();
			    		$(".edit_gallery_content").append('<div class="gallery_item" id=""><img alt="" src="'+data.link+'"><input type="button" value="Xóa" imageId="" class="gallary_delete_image"></div>');
			    	}
			    },
			    error: function() {
			        alert("unable to create the record");
			    }
			});
		});
		/*$(".upload_image").live('click', function(){
			//var data = $("#form_upload_image").serialize();
			var data_form = $("form.form_upload_image").serialize();
			var temp = $(".file_name").val();
			alert(data_form);
			$.ajax({
				url:"uploadImage.html",
				type:"POST",
				data:data_form,
				success:function(data){
					
				}
			});
		});*/
		
	});
	
</script>
<div class="right_max_width">
<div class="form-message"></div>
	<h2 class="group_title">List Product</h2>
	<div class="clear"></div>
	<table id="product_of_category">
		<tr>
			<th align="left">#</th>
			<th align="left">Name</th>
			<th align="center">Description</th>
			<th align="left">Price</th>
			<th align="center">Action</th>
		</tr>
		
	</table>
</div>
<div class="paging">
</div>
<div>
	<input id="total_rows" type="hidden">
	<input id="page_number_active" type="hidden">
	<input id="page_number_last" type="hidden">
</div>

<div id="adminDetailProduct" class="reveal-editrecordmodalwindow">
	<h4>Chi tiết sản phẩm</h4>
	<div class="in-progress"></div>
	<div class="modalAddCategoryCentreContent">
		<div class="modalMess"></div>
		<form action="" id="form_admin_detail_product" method="post" modelAttribute="Product">
			<div class="in-progress"></div>
			<div class="modalContent">
			
				<div class=admin_detail_product_item>
					<span>Hãng sản xuất</span><input class="detail_producer" type="text" name="Producer">
				</div>
				<div class=admin_detail_product_item>
					<span>Tên sản phẩm</span><input class="detail_name" type="text">
				</div>
				<div class=admin_detail_product_item>
					<span>Mô tả</span><textarea name="Description" cols="40" rows="3" class="detail_description"></textarea>
				</div>
				<div class="admin_detail_product_icon">
					<span>Icon</span><div class="icon_content"></div>
				</div>
				<div class=admin_detail_product_item>
					<span>Giá</span><input class="detail_price" type="text">
				</div>
				<div class=admin_detail_product_item>
					<span>Trạng thái</span><input class="detail_status" type="text">
				</div>
				<div class=admin_detail_product_item>
					<span>Khuyến mãi</span><input class="detail_promotion" type="text">
				</div>
				<div class=admin_detail_product_gallery>
					<div class="gallery_title">Gallery</div>
					<div class="gallery_content"></div>
					
				</div>
			</div>
			<div class="groupFormButton">
				<input class="formButton cancel  close-reveal-all" type="button" value="Cancel"/>
			</div>
		</form>
		
	</div>
	<a class="close-reveal-modal close-reveal-all"></a>
</div>
<div id="adminEditProduct" class="reveal-editrecordmodalwindow">
	<h4>Chi tiết sản phẩm</h4>
	<div class="in-progress"></div>
	<div class="modalAddCategoryCentreContent">
		<div class="modalMess"></div>
		<form id="form_admin_edit_product" class="form_admin_edit_product" method="post">
			<div class="in-progress"></div>
			<div class="modalContent">
			
				<div class=admin_detail_product_item>
					<span>Hãng sản xuất</span><input class="edit_producer" type="text" name="producer">
				</div>
				<div class=admin_detail_product_item>
					<span>Tên sản phẩm</span><input class="edit_name" type="text" name="name">
				</div>
				<div class=admin_detail_product_item>
					<span>Mô tả</span><textarea name="description" cols="40" rows="3" class="edit_description"></textarea>
				</div>
				<div class="admin_detail_product_icon">
					<span>Icon</span>
					<div class="icon_content">
					</div>
					<input type="button" value="Thay đổi icon" id="button_change_icon">
				</div>
				<div class=admin_detail_product_item>
					<span>Giá</span><input class="edit_price" type="text" name="price">
				</div>
				<div class=admin_detail_product_item>
					<span>Trạng thái</span><input class="edit_status" type="text" name="status">
				</div>
				<div class=admin_detail_product_item>
					<span>Khuyến mãi</span><input class="edit_promotion" type="text" name="promotion">
				</div>
				<div class=admin_detail_product_gallery id="gallery">
					<div class="gallery_title">Gallery</div>
					<div class="edit_gallery_content"></div>
					<input type="hidden" class="list_name_image" >
					<input type="button" value="Thêm ảnh" class="edit_product_add_image">
				</div>
				
			</div>
			<div class="groupFormButton">
				<input class="formButton save_edit_product" type="button" value="Lưu"/>
				<input class="formButton cancel  close-reveal-all" type="button" value="Thoát"/>
			</div>
		</form>
	</div>
	<a class="close-reveal-modal close-reveal-all"></a>
</div>
<div id="changeIconProduct" class="reveal-recordmodalwindow medium">
	<h4>Thay đổi icon sản phẩm</h4>
	<div class="in-progress"></div>
	<div class="modalChangeIconCentreContent">
		<div class="modalMess"></div>
			<div class="in-progress"></div>
			<div class="modalContent">							
				<form id="uploadForm">
				     <input type="file" name="myimage" id="imageid" accept=".png" />				     
				</form>
			</div>
			<div class="groupFormButton">
				<input class="formButton save_change_icon" type="button" value="Lưu"/>
				<input class="formButton cancel_change_icon" type="button" value="Thoát"/>
			</div>
	</div>
</div>
<div id="addImageGalleryProduct" class="reveal-recordmodalwindow medium">
	<h4>Thay đổi icon sản phẩm</h4>
	<div class="in-progress"></div>
	<div class="modalChangeIconCentreContent">
		<div class="modalMess"></div>
			<div class="in-progress"></div>
			<div class="modalContent">							
				<form id="addImageForm">
				     <input type="file" name="myimage" id="image_item_id" accept=".png" />				     
				</form>
			</div>
			<div class="groupFormButton">
				<input class="formButton save_add_image" type="button" value="Lưu"/>
				<input class="formButton cancel_add_image" type="button" value="Thoát"/>
			</div>
	</div>
</div>