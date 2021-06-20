var app = new Vue({
  el: '#app',
  data: {
    list: [{
        id: 1,
        name: 'iphone 7',
        price: 6188,
        count: 1,
        check: false,
      },
      {
        id: 2,
        name: 'ipad',
        price: 5888,
        count: 1,
        check: false,
      },
      {
        id: 3,
        name: 'macbook pro',
        price: 21488,
        count: 1,
        check: false,
      }
    ]
  },
  computed: {
    totalPrice: function () {
      var total = 0;
      this.list.forEach(function (val, index) {
        if (val.check == true)
          total += parseFloat(val.price * val.count);
      })

      return total.toString().replace(/\B(?=(d{3})+$)/g, ','); //千位分隔符轉換
    }
  },
  methods: {
    handleReduce: function (index) {
      if (this.list[index].count === 1) return;
      this.list[index].count--;
    },
    handleAdd: function (index) {
      this.list[index].count++;
    },
    handleRemove: function (index) {
      this.list.splice(index, 1);
    },
    selAll: function () { //商品全选
      let isAll = document.querySelector('#all');

      if (isAll.checked == true) {
        this.list.forEach(function (item, index) {
          item.check = true;
        })
      } else {
        this.list.forEach(function (item, index) {
          item.check = false;
        })
      }
    }

  }
});