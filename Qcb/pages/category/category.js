var t = getApp(), a = require("../../js/global.js"), e = require("../template/tabbar.js");

Page({
    data: {
        refresh: 0,
        before_request: 1,
        page: 0,
        listend: 0,
        lists: [],
        cat_id: 0,
        inputShowed: !1,
        inputVal: ""
    },
    navbarTap: function(t) {
      var e = t.currentTarget.dataset.idx;
      var a = this.data.category;
      for (var i in a) {
        a[i].selected = i == e ? 1 : 0;
      }
      this.setData({
        category:a
      })
    },
    onLoad: function(i) {
      var that = this;
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Category/getCategory',
        data: {
        },
        success: function (res) {
          res.data.data[0].selected = 1;
          that.setData({
            category: res.data.data
          });
        }
      })
      e.tabbar("tabBar", 1, this);
    //     a.isBlank(i.id) || i.id;
    //     var s = this;
    //     t.sendRequest({
    //         url: "/index.php?m=Mobile&c=Goods&a=categoryList",
    //         success: function(t) {
    //             1 == t.status && s.setData(t.Cat);
    //         }
    //     });
    },
    SearchInput: function(t) {
        wx.reLaunch({
            url: "/pages/goodslist/goodslist?key=" + t.detail.value
        });
    },
    GoReLaunch: function(t) {
        wx.reLaunch({
            url: "/pages/goodslist/goodslist"
        });
    },
    showInput: function() {
        this.setData({
            inputShowed: !0
        });
    },
    hideInput: function() {
        this.setData({
            inputVal: "",
            inputShowed: !1
        });
    },
    clearInput: function() {
        this.setData({
            inputVal: ""
        });
    },
    inputTyping: function(t) {
        this.setData({
            inputVal: t.detail.value
        });
    },
    confirm:function(t){
      wx.navigateTo({
        url: "/pages/goodslist/goodslist?key=" + t.detail.value
      })
    }
});