<!DOCTYPE html>
<html lang="en">
<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>管理員-商品修改</title>
  <link rel="stylesheet" href="CSS/index.css">
  <link rel="stylesheet" href="CSS/welcome.css">
  <link rel="stylesheet" href="CSS/shop_record.css">
</head>


<body>
<script>

function beforeShopCart() {
 if (sessionStorage.cart != undefined) {
  document.getElementById("shopcart").href="yourcar.jsp?items=" + sessionStorage.cart;
 } else {
  document.getElementById("shopcart").href="yourcar.jsp";
 }
}
</script>

<!--第一組清單 -->
  <div class="toptop">
    <ul class="minitop">
      <li>
        <a href="member.html" class="sign_in" alt="會員專區">
          <img src="Images/Avatar.png"></a>
      </li>

      <li>
          <a href="#" id="shopcart" onclick="beforeShopCart()" class="sign_in" title="我的購物車">
          <img src="Images/shopping-cart .png"></a>
      </li>
    </ul>

    <nav id="title_menu">
       <a href="index.html" class="Logogo">
        <img src="Images/ourLogo.png" alt="鞋奏曲" class="Logo">
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
      <li>
        <a href="#" class="main">購物說明</a>
        <ul class="sub">
          <li>門市現貨一覽</li>
          <li>現貨預購怎麼看</li>
          <li>常見問題</li>
        </ul>

      </li>
      <!--第三組清單 -->

      <li>
        <a href="welcome.jsp" class="main">會員中心</a>
        <ul class="sub">
          <a href="shopping_record.jsp">
            <li>查詢購物紀錄</li>
          </a>
          <a href="change_edit.jsp">
            <li>修改基本資料</li>
          </a>

        </ul>
      </li>

      <!--第四組 -->
      <li>
        <a href="#" class="main">關於我們</a>
        <ul class="sub">
          <li>品牌理念</li>
          <li>組員介紹</li>
        </ul>
      </li>
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



 <div style="margin-top:200px; height: 700px;" >
      <h3>商品資料操作</h3>
      <hr>
        
      <table id="shop_record">
      	<tr>
      		<th>商品編號</th>
      		<th>商品名稱</th>
      		<th>動作</th>
      	</tr>
 
<%
 String accnt = (String) session.getAttribute("UserId");
 if(accnt == null) {
  out.println("<script type=\"text/javascript\">");
  String err = "使用者未登入!";
  out.println("alert('" + err + "');");
  out.println("location='member.html';");
  out.println("</script>");
  return;
 }
 
 try{  
   Class.forName("com.mysql.jdbc.Driver");  
   Connection con=DriverManager.getConnection(  
		   "jdbc:mysql://localhost:3306/shoe_shop?serverTimezone=UTC","root","775320Yui");  
   
   Statement stmt=con.createStatement();
   ResultSet rs=null;
   
   rs = stmt.executeQuery("select 商品編號, 商品名稱 from products");
   while(rs.next()) { 
  		String no=rs.getString(1);
  		String prod=rs.getString(2);
%> 	
      	<tr>
      		<td><%=no%></td>
      		<td><%=prod%></td>
      		<td><div id="divbut"><input id="opbut" type="button" onclick=<%="\"editProd("+no+")\""%> value="編輯" > 
 				<input type="button" id="opbut" onclick=<%="\"delProd("+no+")\""%> value="刪除" ></div></td>
    	</tr>
    	
<%
   		  
    }  // end while
   
     stmt.close();
    con.close();
 }catch(Exception e){ 
  System.out.println(e);
 }
%>
      	
      </table>
    </div>


    <footer style="margin-top:200px;">
      <div class="down" >
        <p>
          c 2021 by Chung Yuan Christian University <br>
          Department of Information Management
        </p>
        <p>
          +886-9888888 &nbsp;|&nbsp;
          <a href="lmjguto@gmail.com" style="color: #edf2fb;">lmjguto@gmail.com</a>
        </p>
        <p>
          本站最佳瀏覽環境請使用Google Chrome、Firefox或Edge以上版本
        </p>
      </div>
    </footer>
    <div class="pleaseup">
      <a href="#top">
        <img src="Images/up.png" alt="click and up">
      </a>
    </div>

  </div>
</body>

</html>