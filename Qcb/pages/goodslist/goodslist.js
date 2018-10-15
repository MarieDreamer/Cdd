var t = getApp(), a = require("../../js/global.js"), e = require("../template/tabbar.js");

Page({
  data: {
    refresh: 0,
    before_request: 1,
    page: 0,
    listend: 0,
    lists: [],
    cat_id: 0,
    more: "",
    show: {
      all: "none",
      main: ""
    },
    sort_asc: "asc",
    inputShowed: !1,
    inputVal: "",
    is_screen: "", //是否为筛选
  },
  onLoad: function (i) {
    e.tabbar("tabBar", 1, this);
    console.log(i.kill);
    var shop_type = '';
    var key = '';
    var kill = '';
    if (i.kill) {
      kill = i.kill;
      // this.SearchInput();
    }
    if(i.key){
      key = i.key;
      // this.SearchInput();
    }
    if (i.id) {
      shop_type = i.id;
    }
    this.setData({
      shop_type: shop_type,
      key: key,
      kill: kill
    })
    this.getAll()
  },
  showCat: function () {
    var that = this;
    wx.request({
      url: 'https://wechat.cdd.jianfengweb.com/Category/getFatherCate',
      success: function (res) {
        that.setData({
          cateArr: res.data.data,
          show: {
            all: "",
            main: "none"
          }
        });
      }
    })
  },
  closeCat: function () {
    this.setData({
      show: {
        all: "none",
        main: ""
      }
    });
  },
  setCat: function (t) {
    var a = t.currentTarget.dataset.id;
    var t = 0;
    console.log(a)
    this.setData({
      shop_type: a,
      refresh: 1,
      cat_id: a,
      is_screen:1,
    })
    this.getAll();
    this.closeCat()
  },
  getAll: function (t) {
    var that = this;
    wx.request({
      url: 'https://wechat.cdd.jianfengweb.com/Commodity/getLists',
      data: {
        shop_type: that.data.shop_type,
        key: that.data.key,
        kill: that.data.kill,//是否为限量秒杀
        is_screen: that.data.is_screen,//是否为筛选
      },
      success: function (res) {
        console.log(res)
        that.setData({
          lists: res.data.data,
        })
      }
    })
  },
  setSort: function (t) {
    var that = this;
    var sort = '';
    var sort_asc = '';
    var shop_type = '';
    var key = '';
    if (t.currentTarget.dataset.sort) {
      sort = t.currentTarget.dataset.sort
    }
    if (t.currentTarget.dataset.sort_asc) {
      sort_asc = t.currentTarget.dataset.sort_asc
    }
    if (that.data.shop_type) {
      shop_type = that.data.shop_type
    }
    if (that.data.key) {
      key = that.data.key
    }
    wx.request({
      url: 'https://wechat.cdd.jianfengweb.com/Commodity/getLists',
      data: {
        sort: sort,
        sort_asc: sort_asc,
        shop_type: shop_type,
        key: key
      },
      success: function (res) {
        that.setData({
          lists: res.data.data,
          sort: t.currentTarget.dataset.sort,
          sort_asc: t.currentTarget.dataset.sort_asc
        })
      }
    })
  },
  SearchInput: function (t) {
    var that = this;
    if (t.detail.value) {
      that.setData({
        key: t.detail.value
      })
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Commodity/getLists',
        data: {
          key: that.data.key,
          shop_type: that.data.shop_type
        },
        success: function (res) {
          that.setData({
            lists: res.data.data,
          })
        }
      })
    }
  },
  onReachBottom: function () {
    // this.AjaxGet();
  },
  showInput: function () {
    this.setData({
      inputShowed: !0
    });
  },
  hideInput: function () {
    this.setData({
      inputVal: "",
      inputShowed: !1,
      key:''
    });
    this.getAll()
  },
  clearInput: function () {
    this.setData({
      inputVal: ""
    });
  }
});