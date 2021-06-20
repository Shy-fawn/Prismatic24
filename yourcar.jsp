<!DOCTYPE html>
<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>您的購物車</title>
<link rel="stylesheet" href="CSS/yourcar.css">
<link rel="stylesheet" href="CSS/index.css">
<script src="https://unpkg.com/vue/dist/vue.min.js"></script>
</head>

<body>

	<script>
function removeItem(idx) {
	var items = sessionStorage.cart;
	if(items != undefined) {
		var ary = items.split(";");
		ary.splice(idx, 1); //移除所選擇的項目
		var newitems = "";
		for(var i=0; i<ary.length;i++) {
			if(i>0) {
				newitems += ";"
			}
			
			newitems += ary[i];
		}
		
		if(ary.length > 0) {  // 購物車尚有項目
			sessionStorage.cart = newitems;  // 取代新的購車
			console.log(newitems);
		
			window.location.href = "yourcar.jsp?items=" + newitems ;
		} else {  // 購物車已沒有項目
			sessionStorage.clear();
			window.location.href = "AllProds.jsp";
		}
		
	}
}

function changeQlt(idx) {
 var qlt=document.getElementById("quantity"+idx).value;
 var uprice=document.getElementById("uprice"+idx).innerHTML;
 var total = parseFloat(uprice) * parseInt(qlt);
 document.getElementById("total"+idx).innerHTML = total;
}

function beforeSendOrder() {
	// 組成購物單=>   商品編號1:數量;商品編號2:數量...
	var items = sessionStorage.cart;
	
	var orderlst = "";
	var qlt, uprice,total = 0;
	var ary = items.split(";");
	for(var i=0; i<ary.length; i++) {
		qlt=document.getElementById("quantity"+i).value;
		uprice=document.getElementById("uprice"+i).innerHTML;
		 total += parseFloat(uprice) * parseInt(qlt);
		 
		if(i > 0) {
			orderlst += ";";
		}
		
		orderlst += (ary[i] + ":" +  document.getElementById("quantity"+i).value);
	}
	
	console.log("Total=" + total);
	window.location.href = "ReqHandler.jsp?type=order&order=" + orderlst +
			"&total=" + total;
	
}
</script>
	<!--第一組清單 -->
	<div class="toptop">
		<ul class="minitop">
			<li><a href="member.html" class="sign_in" alt="會員專區"> <img
					src="Images/Avatar.png"></a></li>

			<li><a href="yourcar.jsp" class="sign_in" alt="我的購物車"> <img
					src="Images/shopping-cart .png"></a></li>
		</ul>

		<nav id="title_menu">
			<a href="index.html" class="Logogo"> <img
				src="Images/ourLogo.png" alt="鞋奏曲" class="Logo">
			</a>
		<li>
        <a href="AllProds.jsp" class="main">商品總覽</a>
        <ul class="sub">
          <a href="AllProds.jsp">
            <li>全站商品</li>
          </a>
          <li>最新商品</li>
        </ul>
      </li>

			<!--第二組清單 -->
			<li><a href="#" class="main">購物說明</a>
				<ul class="sub">
					<li>門市現貨一覽</li>
					<li>現貨預購怎麼看</li>
					<li>常見問題</li>
				</ul></li>
			<!--第三組清單 -->

			<li><a href="welcome.jsp" class="main">會員中心</a>
				<ul class="sub">
					<a href="shopping_record.jsp">
						<li>查詢購物紀錄</li>
					</a>
					<a href="change_edit.jsp">
						<li>修改基本資料</li>
					</a>

				</ul></li>

			<!--第四組 -->
			<li><a href="#" class="main">關於我們</a>
				<ul class="sub">
					<li>品牌理念</li>
					<li>組員介紹</li>
				</ul></li>
		</nav>

		<div id="search_box">
			<div class="search_bar">
				<form>
					<input type="text" placeholder="請輸入關鍵字">
					<button type="submit"></button>
				</form>
			</div>
		</div>
	</div>

	<div id="app">
		<div class="container">
			<div class="itemone">
				<div class="item_detail">商品</div>
				<div class="price">單價</div>
				<div class="count">數量</div>
				<div class="amount">總計</div>
				<div class="operate">是否刪除</div>
			</div>

<%
 if(session.getAttribute("UserId") == null) {
  out.println("<script type=\"text/javascript\">");
  String err = "使用者未登入!";
  out.println("alert('" + err + "');");
  out.println("location='member.html';");
  out.println("</script>");
  return;
 }

 String items = request.getParameter("items");
 if(items == null) {
  out.println("<script type=\"text/javascript\">");
  String err = "請先選擇商品至購物車!";
  out.println("alert('" + err + "');");
  out.println("location='AllProds.jsp';");
  out.println("</script>");
  return;
 }
 
 String[] ary = items.split(";");  // 取得前端要購買的商品編號
 
 try{  
	  Class.forName("com.mysql.jdbc.Driver");  
	  Connection con=DriverManager.getConnection(  
	  "jdbc:mysql://localhost:3306/shoe_shop?serverTimezone=UTC","root","775320Yui");  
   
   Statement stmt=con.createStatement();
   ResultSet rs=null;
   for(int i = 0; i < ary.length; i++) {
    	rs = stmt.executeQuery("select 圖片檔案, 商品名稱, 單價 from products where 商品編號='" + ary[i] + "'");  
  		rs.next();  
  		String file=rs.getString(1);
  		String name=rs.getString(2);
  		float price=rs.getFloat(3);
%>
			<div class="itemone item_body">
				<div class="item_detail">
					<img src=<%=file%> alt="">
					<div class="name"><%=name%>
					</div>
				</div>

				<div class="price" style="width: 150px;">
					<p style="margin: 0; display: inline; float: left">$&ensp;</p>
					<p style="margin: 0; display: inline:float:right"
						id=<%="\"uprice"+i+"\""%>><%=price%></p>
				</div>
				<div>
					<input type="number" oninput=<%="\"changeQlt("+i+")\"" %>
						id=<%="\"quantity"+i+"\""%> name="quantity" value="1" min="1"
						max="999" style="width: 50px;">
				</div>
				<div class="amount">
					<p id=<%="\"total"+i+"\""%>><%=price%></p>
				</div>
				<div class="operate">
					<button type="button" onclick=<%="\"removeItem("+i+")\""%>
						style="margin-top: -16px;">刪除</button>
				</div>
			</div>

<%
   rs.close();  
    }  // end for 
    
     stmt.close();
    con.close();
 }catch(Exception e){ 
  System.out.println(e);
 }
%>

		</div>
	</div>

	<input type="button"
		value="下一步&emsp;開始填資料"  onclick="beforeSendOrder()" class="nextfly">

	<footer>
		<div class="down">
			<p>
				c 2021 by Chung Yuan Christian University <br> Department of
				Information Management
			</p>
			<p>
				+886-9888888 &nbsp;|&nbsp; <a href="lmjguto@gmail.com"
					style="color: #edf2fb;">lmjguto@gmail.com</a>
			</p>
			<p>本站最佳瀏覽環境請使用Google Chrome、Firefox或Edge以上版本</p>
		</div>
	</footer>
	<div class="pleaseup">
		<a href="#top"> <img src="Images/up.png" alt="click and up">
		</a>
	</div>


</body>
<script src="JS/yourcar.js"></script>

</html>