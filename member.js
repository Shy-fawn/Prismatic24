'use strict';

//會員登入------------------
var attempt = 10; // 可變數來計算嘗試次數。
function myFormCheck() { // 以下功能單擊登錄按鈕執行。
  var username = document.getElementById("username").value;
  var password = document.getElementById("password").value;
  if (username === "Formget" && password === "formget#123") {
    alert("Login successfully");
    window.location = "../pages/member_register.html";
    // 重定向到其他頁面。
    return false;
  } else {
    attempt--; // 減少一個。
    alert("You have left " + attempt + " attempt;");


    // 多次嘗試後禁用字段。
    if (attempt === 0) {
      document.getElementById("username").disabled = true;
      document.getElementById("password").disabled = true;
      document.getElementById("submit").disabled = true;
      return false;
    }
  }
}


if (JSON && JSON.stringify && JSON.parse) var Session = Session || (function () {

  // window object
  var win = window.top || window;

  // session store
  var store = (win.name ? JSON.parse(win.name) : {});

  // save store on page unload
  function Save() {
    win.name = JSON.stringify(store);
  }

  // page unload event
  if (window.addEventListener) window.addEventListener("unload", Save, false);
  else if (window.attachEvent) window.attachEvent("onunload", Save);
  else window.onunload = Save;

  // public methods
  return {

    // set a session variable
    set: function (name, value) {
      store[name] = value;
    },

    // get a session value
    get: function (name) {
      return (store[name] ? store[name] : undefined);
    },

    // clear session
    clear: function () {
      store = {};
    },

    // dump session data
    dump: function () {
      return JSON.stringify(store);
    }

  };

})();

// store a session value/object
Session.set(name, object);

// retreive a session value/object
Session.get(name);

// clear all session data
Session.clear();

// dump session data
Session.dump();