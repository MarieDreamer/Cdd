var t = getApp(), a = (require("../../js/global.js"), require("../template/tabbar.js"));

Page({
    data: {
        before_request: 1,
        select_all: 0,
        first_get: 1
    },
    onLoad: function(t) {
        var e = this;
        var user_id = wx.getStorageSync('userid')
        a.tabbar("tabBar", 2, this);
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Cart/getCart',
          data:{
            user_id: user_id
          },
          success:function(res){
            e.setData({
              cartList: res.data.data
            })
          }
        })
    },
    SwitchNum: function(a) {
        var e = a.currentTarget.dataset, s = this.data.cartList[e.id].goods_num, r = {};
        (s += parseInt(e.num)) < 1 && (s = 1), s > e.store && (t.showModal({
            content: "库存只有 " + e.store + " 件, 你只能买 " + e.store + " 件"
        }), s = e.store), r["cartList[" + e.id + "].goods_num"] = s, this.setData(r), this.AjaxCartList();
    },
    ChangeNum: function(a) {
        var e = a.currentTarget.dataset.index, s = a.detail.value, r = this.data.cartList[e].store_count, i = {};
        s < 1 && (s = 1), s > r && (t.showModal({
            content: "库存只有 " + r + " 件, 你只能买 " + r + " 件"
        }), s = r), i["cartList[" + e + "].goods_num"] = s, this.setData(i), this.AjaxCartList();
    },
    SelectChange: function(t) {
        var a = this;
        var id = t.currentTarget.dataset.id;
        var cartList = a.data.cartList;
        var amount = 0;
        var checked_num = 0
        for (var i = 0; i < cartList.length; i ++){
          if (cartList[i]['id'] == id) {
            if (!cartList[i]['selected']){
              cartList[i]['selected'] = 1
            }else{
              cartList[i]['selected'] = 0
            }
          }
          if (cartList[i]['selected'] == 1) {
            amount += cartList[i]['good_num'] * cartList[i]['member_goods_price']
          }
          if (cartList[i]['selected'] == 1) {
            checked_num++;
          }
          a.setData({
            total_price: amount
          })
        }
        if (checked_num == cartList.length){
          a.setData({
            select_all: 1
          });
        }else{
          a.setData({
            select_all: 0
          });
        }
        a.setData({
          cartList: cartList
        });
        
    },
    SelectAll: function() {
        var t = this;
        var a = t.data.select_all;
        var e = t.data.cartList;
        var s = {};
        if (1 == a) {
            s.select_all = 0;
            for (var r in e) s["cartList[" + r + "].selected"] = 0;
            t.setData({
              total_price: 0
            })
        } else {
            s.select_all = 1;
            for (var r in e) s["cartList[" + r + "].selected"] = 1;
            this.total();
        }
        t.setData(s);
        
    },
    total: function(){
      var that = this;
      var total = 0;
      var cartList = that.data.cartList;
      for (var i = 0; i < cartList.length; i ++){
        var price = parseFloat(cartList[i]['member_goods_price']);
        var num = cartList[i]['good_num'];
        total += price*num;
      }
      that.setData({
        total_price:total
      })
    },
    DelCartGoods: function(a) {
        var e = this;
        var id = a.currentTarget.dataset.id;
        var user_id = wx.getStorageSync('userid')
        t.showModal({
            content: "确定要删除吗?",
            showCancel: !0,
            confirm: function() {
                wx.request({
                  url: 'https://wechat.cdd.jianfengweb.com/Cart/delCart',
                  data:{
                    id:id,
                    user_id:user_id
                  },
                  success:function(res){
                    e.setData({
                      cartList:res.data.data
                    })
                  }
                })
            }
        });
    },
    // AjaxDelCart: function(a) {
    //     var e = this;
    //     t.sendRequest({
    //         url: "/index.php?m=Mobile&c=Cart&a=ajaxDelCart",
    //         data: {
    //             ids: a
    //         },
    //         method: "POST",
    //         success: function(t) {
    //             1 == t.status && e.AjaxCartList();
    //         }
    //     });
    // },
    SelCartSubmit: function() {
        var a = 0, e = this.data.cartList;
        for (var s in e) 1 == e[s].selected && (a += 1);
        if (!(a > 0)) return t.showModal({
            content: " 请选择要结算的商品！"
        }), !1;
        var order = [];
        for(var i in e){
          if(e[i].selected == 1){
            order.push(e[i])
          }
        }
        wx.setStorageSync('json', order);
        wx.navigateTo({
          url: "/pages/cart2/cart2"
        });
    },
    AjaxCartList: function() {
        var a = this;
        if (0 == a.data.before_request) return !1;
        a.setData({
            before_request: 0
        });
        var e = a.data.cartList;
        if (1 == a.data.first_get) s = {}; else {
            var s = {
                select_all: a.data.select_all
            };
            for (var r in e) s["goods_num[" + e[r].id + "]"] = e[r].goods_num, s["cart_select[" + e[r].id + "]"] = e[r].selected;
        }
        // t.sendNoRequest({
        //     url: "/index.php?m=Mobile&c=Cart&a=ajaxCartList",
        //     data: s,
        //     method: "POST",
        //     success: function(e) {
        //         if (a.setData({
        //             before_request: 1
        //         }), 1 == e.status) {
        //             a.setData(e.cartGoods);
        //             var s = 1;
        //             for (var r in e.cartGoods.cartList) 0 == e.cartGoods.cartList[r].selected && (s = 0);
        //             wx.setStorageSync("cart", e.cartGoods), a.setData({
        //                 first_get: 0,
        //                 select_all: s
        //             });
        //         } else -101 == e.status ? (t.globalData.tUrl = "/pages/cart/cart", wx.redirectTo({
        //             url: "/pages/login/login"
        //         })) : -2 == e.status && (a.setData({
        //             cartList: ""
        //         }), wx.setStorageSync("cart", ""));
        //     },
        //     complete: function(t) {
        //         a.setData({
        //             before_request: 1
        //         });
        //     }
        // });
    }
});