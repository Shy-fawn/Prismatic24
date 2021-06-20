<!DOCTYPE html>
<html lang="en">
<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>註冊會員</title>
<link rel="stylesheet" href="CSS/index.css">
<link rel="stylesheet" href="CSS/member_register.css">
<script src="JS/member_er.js"></script>
</head>

<body>
	<!--第一組清單 -->
	<div class="toptop">
		<ul class="minitop">
			<li><a href="member.html" class="sign_in" alt="會員專區"> <img
					src="Images/Avatar.png"></a></li>

			<li><a href="yourcar.html" class="sign_in" alt="我的購物車"> <img
					src="Images/shopping-cart .png"></a></li>
		</ul>

		<nav id="title_menu">
			<a href="../index.html" class="Logogo"> <img
				src="Images/ourLogo.png" alt="鞋奏曲" class="Logo">
			</a>
			<li><a href="#" class="main">商品總覽</a>
				<ul class="sub">
					<a href="All_shop.html">
						<li>全站商品</li>
					</a>
					<li>最新商品</li>
				</ul></li>

			<!--第二組清單 -->
			<li><a href="#" class="main">購物說明</a>
				<ul class="sub">
					<li>門市現貨一覽</li>
					<li>現貨預購怎麼看</li>
					<li>常見問題</li>
				</ul></li>
			<!--第三組清單 -->

			<li><a href="welcome.html" class="main">會員中心</a>
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



		<%
			request.setCharacterEncoding("utf-8");
			String type = request.getParameter("type");

			  Class.forName("com.mysql.jdbc.Driver");  
			  Connection con=DriverManager.getConnection(  
			  "jdbc:mysql://localhost:3306/shoe_shop?serverTimezone=UTC","root","775320Yui");  

			if (type.equals("register")) {				
				String name = request.getParameter("fullname");
				String account = request.getParameter("username");
				String password = request.getParameter("password");
				String phone = request.getParameter("phone_number");
				String address = request.getParameter("Address");
				String email = request.getParameter("e-mail");
				String sex = request.getParameter("M_or_F"); 
				String bdate = request.getParameter("birthday");

				try {
					// 編會員編號
					Statement stmt1=con.createStatement();
					  
					// 從取號機取得目前號碼
					ResultSet rs=stmt1.executeQuery("select 號碼 from seqno_machine where 類型='會員號碼' for update "); 
					rs.next();
					int seqno = rs.getInt(1);
					
					//取號機號碼加1
					stmt1.executeUpdate("Update seqno_machine set 號碼=號碼+1 where 類型='會員號碼'");
					stmt1.close();
					
					// 組成會員編號
					String member_no = String.format("M%04d", seqno);

					String sql = "INSERT INTO members(`會員編號`,`帳號`,`密碼`,`名稱`,`電話`,`住址`,`信箱`,`性別`,`生日`) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
					PreparedStatement stmt2 = con.prepareStatement(sql);

					stmt2.setString(1, member_no);
					stmt2.setString(2, account);
					stmt2.setString(3, password);
					stmt2.setString(4, name);
					stmt2.setString(5, phone);
					stmt2.setString(6, address);
					stmt2.setString(7, email);
					stmt2.setString(8, sex);
					stmt2.setString(9, bdate);

					stmt2.executeUpdate();

					stmt2.close();
					con.close();

					response.sendRedirect("index.html");
				} catch (Exception e) {
					out.println("<script type=\"text/javascript\">");
					String err = "會員註冊失敗: 原因=" + e.getMessage();
					err = err.replaceAll("'", "");
					out.println("alert('" + err + "');");
					out.println("location='index.html';");
					out.println("</script>");
				}
			} else if (type.equals("login")) {
				String account = request.getParameter("username");
				String password = request.getParameter("password");

				try {
					String sql = "select 密碼  from members where 帳號=?";

					PreparedStatement stmt = con.prepareStatement(sql);
					stmt.setString(1, account);

					ResultSet rs = stmt.executeQuery();
					if (rs.next() == false) {
						out.println("<script type=\"text/javascript\">");
						String err = "查無帳號: 帳號=" + account;
						out.println("alert('" + err + "');");
						out.println("location='index.html';");
						out.println("</script>");
					} else {
						String pwd = rs.getString(1);
						if (pwd.equals(password) == false) {
							out.println("<script type=\"text/javascript\">");
							String err = "密碼錯誤: 帳號=" + account;
							out.println("alert('" + err + "');");
							out.println("location='index.html';");
							out.println("</script>");
						} else {
							session.setAttribute("UserId", account);
							response.sendRedirect("index.html");
						}
					}

				} catch (Exception e) {
					out.println("<script type=\"text/javascript\">");
					String err = "登入失敗: 原因=" + e.getMessage();
					err = err.replaceAll("'", "");
					out.println("alert('" + err + "');");
					out.println("location='index.html';");
					out.println("</script>");
				}
			} else if(type.equals("order")) {
				// 購物單=>   商品編號1:數量;商品編號2:數量...
				System.out.println("Order=" + request.getParameter("order"));	
				System.out.println("Total=" + request.getParameter("total"));
				float total = Float.parseFloat(request.getParameter("total"));
				
				String[] order_ary = request.getParameter("order").split(";");
				
				String[] name_ary = new String[order_ary.length];
				int[] qlt_ary = new int[order_ary.length];
				
				int k = 0;
				for(String odr : order_ary) {
					String[] tmpary = odr.split(":");
					
					name_ary[k] = tmpary[0];  // 商品編號
					qlt_ary[k] = Integer.parseInt(tmpary[1]);  // 數量
					k++;
				}
				
				// 編訂單編號
				Statement stmt1=con.createStatement();
				  
				// 從取號機取得目前號碼
				ResultSet rs=stmt1.executeQuery("select 號碼 from seqno_machine where 類型='訂單號碼' for update "); 
				rs.next();
				int seqno = rs.getInt(1);
				
				//取號機號碼加1
				stmt1.executeUpdate("Update seqno_machine set 號碼=號碼+1 where 類型='訂單號碼'");
				stmt1.close();
				
				// 組成訂單編號
				String order_no = String.format("O%04d", seqno);

				// 加入購買商品和數量至Table orders_detail
				String sql = "INSERT INTO orders_detail(`訂單編號`,`商品編號`,`購買數量`) values(?, ?, ?)";
				PreparedStatement stmt2 = con.prepareStatement(sql);

				for(int i = 0; i < name_ary.length; i++) {
					stmt2.setString(1, order_no);
					stmt2.setString(2, name_ary[i]);
					stmt2.setInt(3, qlt_ary[i]);
					stmt2.executeUpdate();
				}
				
				stmt2.close();
				
				// 加一筆資料至table order
				sql = "INSERT INTO orders(`訂單編號`,`帳號`,`購買日期`,`總價`) values(?, ?, ?, ?)";
				PreparedStatement stmt3 = con.prepareStatement(sql);

				stmt3.setString(1, order_no);
				stmt3.setString(2, (String) session.getAttribute("UserId"));
				stmt3.setDate(3, new java.sql.Date(System.currentTimeMillis()));;
				stmt3.setFloat(4, total);
				stmt3.executeUpdate();
				
				stmt3.close();
				con.close();

				response.sendRedirect("FillOrder.jsp?orderno=" + order_no);  
				
			} else if (type.equals("edituinfo")) {
				String name = request.getParameter("name");
				String realname = request.getParameter("accnt");
				String password = request.getParameter("password");
				String phonenumber = request.getParameter("phonenumber");
				String addplace = request.getParameter("addplace");
				String Email = request.getParameter("Email");
				String accnt = (String) session.getAttribute("UserId");
				
				try{
					String sql = "Update members set 名稱 = ?, 密碼 = ?, 電話=?, 住址=?, 信箱=?  WHERE 帳號 = ?";
					PreparedStatement stmt =con.prepareStatement(sql);
					
					stmt.setString(1,name);
					stmt.setString(2,password);
					stmt.setString(3,phonenumber);
					stmt.setString(4,addplace);
					stmt.setString(5,Email);
					stmt.setString(6,accnt);
					
					stmt.executeUpdate();
					con.close();

					response.sendRedirect("index.html");
				} catch(Exception e) {
						out.println("<script type=\"text/javascript\">");
						String err = "資料修改失敗: 原因=" + e.getMessage();
						err = err.replaceAll("'", "");
						out.println("alert('" + err + "');");
						out.println("location='welcome.html';");
						out.println("</script>");
					
				}
			} else if(type.equals("fillorder")) {
				String order_no = request.getParameter("orderno");
				String username = request.getParameter("username");
				String useremail = request.getParameter("useremail");
				String phoneno = request.getParameter("phoneno");
				String pay = request.getParameter("pay");
				String delive = request.getParameter("delive");
				
				System.out.println("收件人資料: order_no=" + order_no +
						"  username=" + username +
						"  useremail=" + useremail +
						"  phoneno=" + phoneno +
						"  pay=" + pay +
						"  delive=" + delive);
				try{
					String sql = "Update orders set 付款方式 = ?, 取件方式 = ?, 收件者名稱=?, 收件者地址=?, 收件者電話=?  WHERE 訂單編號 = ?";
					PreparedStatement stmt =con.prepareStatement(sql);
					
					stmt.setString(1,useremail);
					stmt.setString(2,delive);
					stmt.setString(3,username);
					stmt.setString(4,phoneno);
					stmt.setString(5,useremail);
					stmt.setString(6,order_no);
					
					stmt.executeUpdate();
					con.close();

					response.sendRedirect("index.html");
				} catch(Exception e) {
						out.println("<script type=\"text/javascript\">");
						String err = "資料修改失敗: 原因=" + e.getMessage();
						err = err.replaceAll("'", "");
						out.println("alert('" + err + "');");
						out.println("location='welcome.html';");
						out.println("</script>");
					
					}
				}else if (type.equals("addprod")) {
					
					String no = request.getParameter("no");
					String name = request.getParameter("name");
					String pic = request.getParameter("pic");
					float price = Float.parseFloat(request.getParameter("price"));
					String feature = request.getParameter("feature");
					String spec = request.getParameter("spec");
					String supplier = request.getParameter("supplier");
					
					
					try {
					
						String sql = "INSERT INTO products (`商品編號`,`商品名稱`,`圖片檔案`,`單價`,`商品特色`,`商品規格`,`供應商編號`) values(?, ?, ?, ?, ?, ?, ?)";
						PreparedStatement stmt=con.prepareStatement(sql);
							stmt.setString(1,no);
							stmt.setString(2,name);
							stmt.setString(3,pic);
							stmt.setFloat(4,price);
							stmt.setString(5,feature);
							stmt.setString(6,spec);
							stmt.setString(7,supplier);
							
							
							stmt.executeUpdate();
							stmt.close();
							con.close();

							response.sendRedirect("index.html");
						} catch(Exception e) {
								out.println("<script type=\"text/javascript\">");
								String err = "資料修改失敗: 原因=" + e.getMessage();
								err = err.replaceAll("'", "");
								out.println("alert('" + err + "');");
								out.println("location='welcome.html';");
								out.println("</script>");
							
						}
					} 
				
				/* 尚未完成
				try {
					String sql = "山心木";

					PreparedStatement stmt = con.prepareStatement(sql);
					stmt.setString(1, account);

					ResultSet rs = stmt.executeQuery();
					if (rs.next() == false) {
						out.println("<script type=\"text/javascript\">");
						String err = "查無帳號: 帳號=" + account;
						out.println("alert('" + err + "');");
						out.println("location='index.html';");
						out.println("</script>");
					} else {
						String pwd = rs.getString(1);
						if (pwd.equals(password) == false) {
							out.println("<script type=\"text/javascript\">");
							String err = "密碼錯誤: 帳號=" + account;
							out.println("alert('" + err + "');");
							out.println("location='index.html';");
							out.println("</script>");
						} else {
							session.setAttribute("UserId", account);
							response.sendRedirect("index.html");
						}
					}

				} catch (Exception e) {
					out.println("<script type=\"text/javascript\">");
					String err = "登入失敗: 原因=" + e.getMessage();
					err = err.replaceAll("'", "");
					out.println("alert('" + err + "');");
					out.println("location='index.html';");
					out.println("</script>");
				}
				*/
				
			
		%>

		<footer>
			<div class="down" style="margin-top: 100px;">
				<p>
					© 2021 by Chung Yuan Christian University <br> Department of
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

	</div>
</body>

</html>