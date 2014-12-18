<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
.cart {
	background-color: white;
	padding: 20px;
	border: 1px solid;
}

.cart_product_list {
	border-bottom: 1px;
	border-top: 1px;
	text-align: right;
}

.cart_product_table {
	
}

.cart_summary {
	text-align: right;
	padding-right: 100px;
}
</style>

<script>
	function removeProductOnClick() {
		if (confirm("Xóa sản phẩm này khỏi giỏ hàng?") == true) {
		}
	}

	function createOrderOnClick() {
		if (confirm("Bạn có muốn lập hóa đơn?") == true) {
		}
	}
</script>
<div class="cart">
	<div class="cart_product_list">
		<table class="cart_product_table" border="1">
			<tr>
				<td></td>
				<td>Sản phẩm</td>
				<td>Số lượng</td>
				<td>Đơn giá</td>
			</tr>
			<c:forEach var="cp" items="${cpMapList}">
				<tr>
					<td><img src="${cp['productIcon']}" width="70" height="70"></td>
					<td><a href="productDetail.html?product_id=${cp['productId']}">${cp['productName']}</a></td>
					<td><input type="text" name="quantity"
						value="${cp['quantity']}"></td>
					<td>${cp['price']}</td>
					<td><input type="button" value="Xoá" name="${cp['id']}"
						id="delete_cart_product${cp['id']}"
						onClick="removeProductOnClick()"></td>
					<td><input type="text" value="${cp['id']}"></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="cart_summary">
		<p>
			Tổng tiền: <span>0</span> đ
		</p>
		<p>
			Phí giao hàng: <span>0</span> đ
		</p>
		<p>
			Thanh toán: <span>0</span> đ
		</p>
		<input type="button" value="Lập hóa đơn" onclick="createOrderOnClick()">
	</div>
</div>