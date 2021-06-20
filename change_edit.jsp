<!DOCTYPE html>
<html lang="en">
<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>會員中心:更改資料</title>
  <link rel="stylesheet" href="CSS/index.css">
  <link rel="stylesheet" href="CSS/welcome.css">
  <link rel="stylesheet" href="CSS/change_ed.css">
</head>

<scrip>


</scrip>

<body>
<script>
function beforeShopCart() {
	 if (sessionStorage.cart != undefined) {
	  document.getElementById("shopcart").href="yourcar.jsp?items=" + sessionStorage.cart;
	 } else {
		 document.getElementById("shopcart").href="yourcar.jsp";
	 }
}

      function myFunction() {
        var x = document.getElementById("myInput");
        if (x.type === "password") {
          x.type = "text";
        } else {
          x.type = "password";
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
    
    <div class="centerr">
      <h1>會員中心</h1>
    </div>

    <!--會員資料修改開始-->
    <div style="height: 650px; margin-top:20px;">
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
      
	  	String name=null;
	  	String password=null;
	  	String phonenumber=null;
	  	String addplace=null;
	  	String Email=null;
	  	
      try{  
    	  Class.forName("com.mysql.jdbc.Driver");  
    	  Connection con=DriverManager.getConnection(  
    	  "jdbc:mysql://localhost:3306/shoe_shop?serverTimezone=UTC","root","775320Yui");  

    	   
    	   Statement stmt=con.createStatement();
    	   ResultSet rs=null;
    	    	
    	   rs = stmt.executeQuery("select 名稱,密碼 ,電話,住址,信箱 from members where 帳號 ='"+accnt+"'");  
    	  	rs.next();  
    	  	name=rs.getString(1);
    	  	password=rs.getString(2);
    	  	phonenumber=rs.getString(3);
    	  	addplace=rs.getString(4);
    	  	Email=rs.getString(5);
    	  	
      		stmt.close();
			con.close();

			} catch (Exception e) {
				out.println("<script type=\"text/javascript\">");
				String err = "會員資料修改失敗: 原因=" + e.getMessage();
				err = err.replaceAll("'", "");
				out.println("alert('" + err + "');");
				out.println("location='change_edit.jsp';");
				out.println("</script>");
				}
 %>
      <h3>修改基本資料</h3>
      <hr>
      <form action="ReqHandler.jsp" >
      	 <input type="hidden" name="type" value="edituinfo">
        <div class="data">
          <label>姓名 </label>
          <input type="text" class="form-name" name="name" value=<%=name%>>
        </div>

        <div class="data">
          <label>帳號 </label>
          <input type="text" class="form-name" name="realname" value=<%=accnt%>>
        </div>

        <div class="data">
          <label>密碼 </label>
          <input type="text" class="form-name" name="password" value=<%=password%>>
        </div>

        <div class="data">
          <label>手機(電話)號碼 </label>
          <input type="text" class="form-name" name="phonenumber" value=<%=phonenumber%>>
        </div>

        <div class="data">
          <label>住址 </label>
          <input type="text" class="form-name" name="addplace" value=<%=addplace%>>
        </div>

        <div class="data">
          <label>信箱 </label>
          <input type="text" class="form-name" name="Email" value=<%=Email%>>
        </div>

        <button style="margin-top:30px; width:100px; margin-left:500px;"" type="submit" class="form-name" name="button">確定修改</button>
      </form>
    </div>

    


    <footer style="margin-top:100px;"> 
      <div class="down">
        <p>
          © 2021 by Chung Yuan Christian University <br>
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

  
</body>

</html>