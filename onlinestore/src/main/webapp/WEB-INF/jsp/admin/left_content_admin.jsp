<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>
	$(document).ready(function()
	{
		function paging(pageSize)
		{
			$(".paging").empty();
			var total_row = $('#total_rows').val();
			var page_count = 1;
			page_count = ((parseInt(total_row) / pageSize).toFixed(0) );
			if(page_count < (parseInt(total_row) / pageSize))
				page_count = parseInt(page_count) +1;
			var id = $("#page_number_active").val();
			var page_last = parseInt($("#page_number_last").val());
			var page_active = 0;
			if(page_last >= 10)
				page_active = page_last;
			else
			{
				if(id != 0)
					page_active = parseInt(id.substr(4,id.length));
			}
			if(page_active != 0)
			{
				if(parseInt(page_active) > 10)
				{
					if(parseInt(page_active) == parseInt(page_count))
					{
						$('.paging').append('<span><a class="page_number" page='+(1)+' id="page'+(1)+'" page_last='+(10)+'>First</a></span>');
						$('.paging').append('<span><a class="page_number" page='+(page_active - 10)+' id="page'+(page_active - 10)+'" page_last='+(page_active - 1)+'><</a></span>');
						for(i = page_active -10; i < page_active; i++)
						{
							$('.paging').append('<span><a class="page_number" page='+(i+1)+' id="page'+(i+1)+'" page_last='+(page_active - 1)+'>'+(i + 1)+'</a></span>');
						}
					}
					else
					{	
						$('.paging').append('<span><a class="page_number" page='+(1)+' id="page'+(1)+'" page_last='+(10)+'>First</a></span>');
						$('.paging').append('<span><a class="page_number" page='+(page_active - 10)+' id="page'+(page_active - 10)+'" page_last='+(page_active - 1)+'><</a></span>');
						for(i = page_active -10; i < page_active; i++)
						{
							$('.paging').append('<span><a class="page_number" page='+(i+1)+' id="page'+(i+1)+'" page_last='+(page_active - 1)+'>'+(i + 1)+'</a></span>');
						}
						//var temp = page_active + 1;
						$('.paging').append('<span><a class="page_number" page='+(page_active+ 1)+' id="page'+(page_active+1)+'" page_last='+(0)+'>></a></span>');
						$('.paging').append('<span><a class="page_number" page='+(page_count)+' id="page'+(page_count)+'" page_last='+(0)+'>Last</a></span>');
					}
		
				}
				else
				{
					if(page_count < 10 && page_count > 0)
					{
						for(i = 0; i < page_count; i++)
						{
							$('.paging').append('<span><a class="page_number" page='+(i+1)+' id="page'+(i+1)+'" page_last='+(page_active - 1)+'>'+(i + 1)+'</a></span>');
						}
					}
					else if(page_count > 0)
					{
						for(i = 0; i < 10; i++)
						{
							$('.paging').append('<span><a class="page_number" page='+(i+1)+' id="page'+(i+1)+'" page_last='+(page_active - 1)+'>'+(i + 1)+'</a></span>');
						}
						$('.paging').append('<span><a class="page_number" page='+(11)+' id="page'+(11)+'" page_last='+(0)+'>></a></span>');
						$('.paging').append('<span><a class="page_number" page='+(page_count)+' id="page'+(page_count)+'" page_last='+(0)+'>Last</a></span>');
					}
				}
			}
			else
			{
					if(page_count < 10 && page_count > 0)
					{
						for(i = 0; i < page_count; i++)
						{
							$('.paging').append('<span><a class="page_number" page='+(i+1)+' id="page'+(i+1)+'" page_last='+(page_count - 1)+'>'+(i + 1)+'</a></span>');
						}
					}
					else if(page_count > 0)
					{
						for(i = 0; i < 10; i++)
						{
							$('.paging').append('<span><a class="page_number" page='+(i+1)+' id="page'+(i+1)+'" page_last='+(0)+'>'+(i + 1)+'</a></span>');
						}
						$('.paging').append('<span><a class="page_number" page='+(11)+' id="page'+(11)+'" page_last='+(0)+'>></a></span>');
						$('.paging').append('<span><a class="page_number" page='+(page_count)+' id="page'+(page_count)+'" page_last='+(0)+'>Last</a></span>');
					}
			}
			if(id != 0)
			{
				if(document.getElementById(id) != null)
					document.getElementById(id).className = "page_number_active";
				else
				{
					var new_id = "page"+parseInt(id.substr(4,id.length)) - 1;
					//document.getElementById(new_id).className = "page_number_active";
				}
			}
		}
		
		function loadCategoryCentreList(id,pageNumber)
		{
			var category_id = id;
			$(document.getElementById("category_id")).val(id);
			$.ajax({
				url: "loadProductOfCategory.html",
				type: "POST",
				data:{id:id,page_number:pageNumber},
				success: function(data){
					//var data1=JSON.parse(data);
					//var data = JSON.parse(data);
					var myTable = document.getElementById('product_of_category');
					var j = myTable.rows.length; 
					for(var i=1;i<j; i++)
					{
						var row = j - i;
						var secondRow = myTable.rows[row];
						//alert(secondRow.id);
						myTable.deleteRow(row);
					}	
					var length = data.length;
					var total_rows = data[length - 1]["total_rows"];
					var page_size = data[length-1]["page_size"];
					$("#total_rows").val(total_rows);
					for(var i = 0; i <data.length -1;i++)
					{
						$(".right_max_width table").append('<tr id="itemid'+data[i]["id"]+'"><td align="left">'+(i+1)+'</td><td align="left">'+data[i]["name"]+'</td><td align="center">'+data[i]["description"]+'</td><td align="left">'+data[i]["price"]+'</td><td align="center"><a href="#" idproduct="'+data[i]["id"]+'" class="admin_detail_product">Chi tiết</a><a href="#" idproduct="'+data[i]["id"]+'" class="admin_edit_product">Cập nhập</a><a href="#" idproduct="'+data[i]["id"]+'" class="admin_delete_product">Xóa</a></td></tr>');
					}
					paging(page_size);
					/*if(mess){
						showMess(mess);
					}*/
				}, 
				error : function(jqXHR, status, errorThrown){ 
					
				}
			});
		}
		$('.main_content .page_number').live('click', function(){
			page_number_active = $(this).attr('page');
			var page_last = $(this).attr('page_last');
			var id = "page"+page_number_active;
			document.getElementById(id).className = "page_number_active";
			document.getElementById("page_number_last").value = page_last;
			document.getElementById("page_number_active").value = id;
			var page = parseInt($(this).attr('page'));
			loadCategoryCentreList(currentNode.key,page -1);
			//alert(page_number);
		});
		$("#tree").fancytree({
			autoActivate: false, // we use scheduleAction()
			autoCollapse: true,
//			autoFocus: true,
			autoScroll: true,
			clickFolderMode: 3, // expand with single click
			minExpandLevel: 2,
			tabbable: false, // we don't want the focus frame
			// scrollParent: null, // use $container
			focus: function(event, data) {
				var node = data.node;
				// Auto-activate focused node after 1 second
				if(node.data.href){
					node.scheduleAction("activate", 1000);
				}
			},
			blur: function(event, data) {
				data.node.scheduleAction("cancel");
			},
			activate: function(event, data){
				var node = data.node,
					orgEvent = data.originalEvent;

				if(node.data.href){
					window.open(node.data.href, (orgEvent.ctrlKey || orgEvent.metaKey) ? "_blank" : node.data.target);
				}
			},
			click: function(event, data){ // allow re-loads
				var node = data.node,
				orgEvent = data.originalEvent;
				currentNode = node;
				if(node.key != "_1"){
					loadCategoryCentreList(currentNode.key,0);
				}
				if(node.isActive() && node.data.href){
					data.tree.reactivate();
					window.open(node.data.href, (orgEvent.ctrlKey || orgEvent.metaKey) ? "_blank" : node.data.target);
				}
			},
     		lazyLoad: function(event, data){
				var node = data.node;
				var classes = data.node.extraClasses;
				
				data.result = $.ajax({
					url:"category.html",
					method:"POST",
					data:{type:classes,parent:node.key},
					dataType:"json"
				});
			},
	
		});
		$(document).contextmenu({
			delegate: ".hasmenu",
			menu: [
				{title: "NEW CATEGORY", cmd: "new-category", uiIcon: "ui-icon-plus"},
				{title: "EDIT CATEGORY", cmd: "edit-category", uiIcon: "ui-icon-pencil"},
				{title: "DELETE CATEGORY", cmd: "delete-category", uiIcon: "ui-icon-minus"},
				],
			beforeOpen: function(event, ui) {
				currentNode = $.ui.fancytree.getNode(ui.target);
				
				var menu = ui.menu;
				var target = ui.target;
				var extraData = ui.extraData; // optionally passed when menu was opened by call to open()
				
				
				var arr = $(event.currentTarget);
				
				if(arr.hasClass('categorys')){
					hideCm("category",['new'],true);
				}  else if(arr.hasClass('category')){
					hideCm("category",['new','edit','delete'],true);
				}
				
				 
			
			},
			 select: function(event, ui) {

				var node = $.ui.fancytree.getNode(ui.target);
				currentNode = node;
				switch(ui.cmd){
					case 'new-category':
						$("#addCategoryCentreModal #categoryName").val("");
						$("#addCategoryCentreModal #categoryDescription").val("");
						event.preventDefault();
						$("#addCategoryCentreModal").reveal();
						$("#addCategoryCentreModal #parent_name").val(currentNode.title);
						$("#addCategoryCentreModal #parent_id").val(currentNode.key);
						
						break;
					case 'edit-category':
						var id = currentNode.key;
						$("#editCategoryCentreModal").reveal();
						currentNode = node.getParent();
						//$(".modalEditCategoryCentreContent").load("<?php echo Router::url(array('plugin' => false, 'controller' => 'settings', 'action' => 'editCostCentre'), true); ?>", {id: id}, function(e){      
						//});
						break;
					case 'delete-category':
						event.preventDefault();
						event.stopPropagation();
						//alert("Are you sure delete"+currentNode.key);
						createConfirm(".main_content", "Delete Category "+currentNode.title, "Are you sure delete?", 'delete_category');	
						var id = currentNode.key;
						currentNode = node.getParent();
						if($('#confirmModaldelete_category span').length <= 0)
						{
							$('#confirmModaldelete_category').append('<span style="display: none">'+id+'</span>');
						} else 
						{
							$('#confirmModaldelete_category span').empty().text(id);
						}	
						break;
				}
			}
		});
		
		$("#addCategoryCentreModal .bntsubmit").live('click', function(e){
				$( ".rowform span" ).remove();
				$( ".modalMess p" ).remove();
				$( "input" ).removeClass("texterror");
				e.preventDefault();
				var data_form = $('#addCategoryCentreModal #form_add_subcategory').serialize();
				$.ajax({
					url: "addSubCategory.html",
					type: "POST",
					data: data_form,
					success: function(data){
						//var data = JSON.parse(data);
						if(data.code == 1){
							$('#form_add_subcategory').trigger('reveal:close');
							 //loadCostCentreList(data.mess);
							 currentNode.resetLazy();//load node tree left
							 currentNode.toggleExpanded();
							 alert(data.mess);
						} else {
							/*$( ".rowform span" ).remove();
							$("#addCostCentreModal .modalMess").show().html("<p>" + data.mess + "</p>");
							if(data.error.code){
								$("#addCostCentreModal #CcliCode").addClass('texterror');
								if($("#addCostCentreModal #CcliCode span").length <= 0)
									$("#addCostCentreModal #CcliCode").after('<span>' + data.error.code + '</span>');
							}
							if(data.error.name){
								$("#addCostCentreModal #CcliName").addClass('texterror');
								if($("#addCostCentreModal #CcliName span").length <= 0)
									$("#addCostCentreModal #CcliName").after('<span>' + data.error.name + '</span>');
							}*/
							alert(data.mess);
						}
					},
					error : function(jqXHR, status, errorThrown){ 
						
					}
				});
			});
		$("#confirmModaldelete_category .bntsubmit").live('click',function(){
			var id= parseInt($('#confirmModaldelete_category span').text());
			$.ajax({
				url:"deleteCategory.html",
				data:{id:id},
				type:"POST",
				success:function(data){
					if(data.code == 1)
					{
						
						$('#confirmModaldelete_category').trigger('reveal:close');
						 //loadCostCentreList(data.mess);
						 currentNode.resetLazy();//load node tree left
						 currentNode.toggleExpanded();
						 alert("Successful delete category");
					}
				},
				error : function(jqXHR, status, errorThrown){ 
					
				}
			});
		});
	});
	function hideCm(name, all, is_show){
		if(all instanceof Array){
			for(var i = 0; i < all.length; i++){
				$(document).contextmenu("showEntry",all[i] + '-' + name,is_show);
			}
		}
	}
</script>
<div class="left_content">
<div class="title_box">Quản lý danh mục</div>
<div class="group_product">
	<div class="top_group_product">
		<p><?php echo __('All items');?></p>
		<div class="clear"></div>
	</div>
	<div id="tree">
		<ul>
			<li class="categorys lazy folder hasmenu expand">
				Category
			</li>
		</ul>
	</div>
</div>
	<div class="title_box"><a href="viewPromotionList.html">Quản lý khuyến mãi</a></div>
	<div class="title_box"><a href="viewConfigInfo.html">Quản lý cấu hình</a></div>
	<div class="title_box"><a href="viewReportDashboard.html">Báo cáo</a></div>
<div class="title_box"><a href="viewOrdersInfo.html">Quản lý đơn hàng</a></div>
</div>


<div id="addCategoryCentreModal" class="reveal-modaladd medium">
	<h4>Add Category Centre</h4>
	<div class="in-progress"></div>
	<div class="modalAddCategoryCentreContent">
		<div class="modalMess"></div>
		<form action="" id="form_add_subcategory" class="addSubCategory" method="post" modelAttribute="Category">
			<div class="in-progress"></div>
			<div class="modalContent">
				
				<div class="info_add_category">
					<span>Parent Category</span>
					<input id="parent_name" type="text">
					<input id="parent_id" type="hidden" name="parentId">
				</div>
				<div class="info_add_category">
					<span>Name Category</span>
					<input id="name" type="text" name="name">
				</div>
				
				
			</div>
			<div class="groupFormButton">
				<input type="submit" class="formButton addCcliButton bntsubmit" value="Add"/>
				<input class="formButton cancel close-reveal-all" type="button" value="Cancel"/>
			</div>
		</form>
		
	</div>
	<a class="close-reveal-modal close-reveal-all"></a>
</div>
