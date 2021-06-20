<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>填寫基本資料</title>
  <link rel="stylesheet" href="CSS/car_write.css">
  <link rel="stylesheet" href="CSS/index.css">
</head>

<body>
<script>
function beforeSubmit() {
	sessionStorage.clear();
	return true;
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
        <a href="yourcar.jsp" class="sign_in" alt="我的購物車">
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
          <li>全站商品</li>
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
        <a href="welcome.html" class="main">會員中心</a>
        <ul class="sub">
          <a href="shopping_record.html">
            <li>查詢購物紀錄</li>
          </a>
          <a href="change_edit.html">
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
  
<%
	String order_no = request.getParameter("orderno");

%>
  <!--login會員登入-->
  <form action="ReqHandler.jsp" class="backcard" method="post" onsubmit="return beforeSubmit();">
	<input type="hidden" name="type" value="fillorder">

    <div id="right" class="youth">
      <fieldset>

        <h1 class="ttlog">請填寫收件資料</h1>
        <p></p>
        <div class="side">訂單編號</div>
        <input type="text" name="orderno" value=<%=order_no%> readonly>
        <br>
        <p></p>
        <div class="side">收件者名稱</div>
        <input type="text" id="username" class="username" name="username" placeholder="收件人姓名" required>
        <br>
        <p></p>
        <div class="side">住址</div>
        <input type="text" id="useremail" class="username_email" name="useremail" placeholder="您的收件人地址" required>
        <br>
        <p></p>
        <div class="side"> 電話號碼</div>
        <input type="text" id="phoneno" class="phoneno" name="phoneno" placeholder="您的電話號碼" required>

        <div class="choose_pay">
          <div class="choose_pay">
            <div class="payw">
              <p>選擇付款方式</p>
              <select name="pay" class="sel">
                <option>超商取貨付款</option>
                <option>LINE Pay</option>
                <option>信用卡付款</option>
              </select>
            </div>
          </div>

        </div>

        <div class="bill">
          <div class="choose_deliver">
            <div class="deliverw">
              <p>選擇取件方式</p>
              <select name="delive" class="sel">
                <option>7-11取貨</option>
                <option>全家取貨</option>
                <option>急件宅配</option>
              </select>
            </div>
          </div>

          <input type="submit" style="background-color: gray;" value="確認並提交" class="btn" id="submit" />

          <div id="rmbr">
            <!--4.1--> <input type="checkbox" id="chkbox" name="remberme" required>
            <!--4.2--> <label for="remberme" id="remberme0">我同意網站服務條款及隱私政策</label>
          </div>

          <p class="member_b">您可以使用以下帳號密碼直接登入為 會員</p>
          <div class="img_btn">
            <div class="c_btn facebook-btn fb">
              <a href="javascript:;"><img src="img/facebook.png" alt=""></a>
            </div>
            <div class="c_btn google-btn go">
              <a href="javascript:;"><img src="img/google.png" alt=""></a>
            </div>
          </div>
          <!--</div>-->
      </fieldset>
    </div>
    <!--two-thirds-->
  </form>

  <footer>
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