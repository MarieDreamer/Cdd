var t = getApp(), e = require("../../js/global.js"), o = require("../../js/wxParse/wxParse.js");

Page({
    data: {
      commodityid:'',
      goods_id: 0,
      goodsNumber: 1,
      swiper_Height: "",
      commentlist: "",
      goods_spec_arr: [],
      goods_spec: {},
      show: {
          selshow: "none"
      },
      CartBtn: "AddCart",
      cart_type: "add_cart",
      before_request: 1,
      spec_goods_price: {},
      collectImg: "sc.png"
    },
    onLoad: function(o) {
        var id = o.id;
        var that = this;
        that.setData({
          commodityid:id
        })
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Commodity/getDetail',
          data:{
            id:id
          },
          success:function(res){
            that.setData({
              goods: res.data.data,
              goods_images_list: res.data.data.shop_index_image
            })
          }
        })
    },
    CallBack: function(t) {
        var e = this, s = t.goods.goods_content;
        o.wxParse("goods.content", "html", s, e, 10), 1 == t.collect && e.setData({
            collectImg: "sc-2.png"
        }), e.GetGoodsPrice();
    },
    InputNumber: function(t) {
        var e = t.detail.value;
        (e <= 0 || "" == e) && (e = 1), e = parseInt(e), this.setData({
            goodsNumber: e
        });
    },
    CartBtn:function(){
      var user_id = wx.getStorageSync('userid');
      var that = this;
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Cart/addCart',
        data:{
          user_id: user_id,
          good_id: that.data.goods.id,
          good_num: that.data.goodsNumber
        },
        success:function(res){
          wx.showModal({
            title: '温馨提示',
            content: '成功加入购物车',
            cancelText: '再逛逛',
            confirmText: '去购物车',
            success: function (res) {
              if (res.confirm) {
                wx.navigateTo({
                  url: '../cart/cart'
                })
              }else{
                that.CloseSpec()
              }
            }
          })
        }
      })
    },
    SpecChange: function(t) {
        var e = t.currentTarget.dataset.type, o = {};
        "none" == this.data.show.selshow ? (o["show.selshow"] = "block", o.cart_type = e) : o["show.selshow"] = "none", 
        this.setData(o);
    },
    AddCart: function(e) {
        var o = this, s = o.data.goods, a = o.data.goods_spec, r = o.data.goodsNumber, n = s.store_count, d = o.data.goods_spec_arr, i = o.data.spec_goods_price, c = "" != d && null != d ? d.sort(o.sortNumber).join("_") : "", g = !1;
        if (Object.keys(i).length > 0) for (var l in i) c == l && (g = !0); else g = !0;
        return 0 == g ? (t.showModal({
            content: "请选择商品规格！"
        }), !1) : 0 == n ? (t.showModal({
            content: "商品库存不足"
        }), !1) : ("" != a && null != a || (a = ""), void o.AjaxAddCart(s.goods_id, r, a));
    },
    AjaxAddCart: function(e, o, s) {
        var a = this, r = a.data.before_request, n = a.data.show.selshow, d = a.data.cart_type, i = {};
        1 == r && (a.setData({
            before_request: 0
        }), t.sendRequest({
            // url: "/index.php?m=Mobile&c=Cart&a=ajaxAddCart",
            data: {
                goods_id: e,
                goods_num: o,
                goods_spec: s,
                cart_type: d
            },
            success: function(o) {
                if (a.setData({
                    before_request: 1
                }), o.status < 0) {
                    if (-101 != o.status) return t.showModal({
                        content: " " + o.msg
                    }), !1;
                    t.globalData.tUrl = "/pages/goods/goods?id=" + e, wx.redirectTo({
                        url: "/pages/login/login"
                    });
                }
                "add_cart" == a.data.cart_type ? t.showModal({
                    content: " " + o.msg,
                    showCancel: !0,
                    cancelText: "再逛逛",
                    confirmText: "去购物车",
                    confirm: function() {
                        wx.navigateTo({
                            url: "/pages/cart/cart"
                        });
                    }
                }) : wx.navigateTo({
                    url: "/pages/cart2/cart2"
                }), "block" == n && (i["show.selshow"] = "none"), a.setData(i);
            }
        }));
    },
    Collect: function (o) {
      var userid = wx.getStorageSync('userid');
      // console.log(o);
      var that=this;
      var commodityid = that.data.commodityid;
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/collection/adds_do',
        data: {
          userid: userid,
          commodityid: commodityid
        },
        success: function (res) {
          console.log(res.data.status);
          if (res.data.status==1){
            wx.showToast({
              title: "收藏成功",
            })
          }else{
            wx.showModal({
              content: '收藏失败',
              showCancel : false
            })
          }
          
        },
      })
    },
    TellCall: function() {
        var t = this;
        wx.makePhoneCall({
            phoneNumber: t.data.phone
        });
    },
    CloseSpec: function() {
        this.setData({
            show: {
                selshow: "none"
            }
        });
    },
    switch_Sepc: function(t) {
        for (var e = t.currentTarget.dataset, o = this.data.filter_spec[e.name], s = {}, a = 0; a < o.length; a++) o[a].item_id == e.key ? s["filter_spec." + e.name + "[" + a + "].selected"] = " active " : s["filter_spec." + e.name + "[" + a + "].selected"] = "";
        this.setData(s), this.GetGoodsPrice();
    },
    GetGoodsPrice: function() {
        var t = this, e = t.data.goods, o = e.shop_price, s = e.store_count, a = t.data.spec_goods_price, r = this.data.filter_spec, n = this.data.goodsNumber, d = new Array(), i = {};
        if (null != a && "" != a) {
            for (var c in r) for (var g = 0; g < r[c].length; g++) "" != r[c][g].selected && null != r[c][g].selected && (d.push(r[c][g].item_id), 
            i[c] = r[c][g].item_id);
            var l = d.sort(t.sortNumber).join("_"), u = !1;
            for (var h in a) l == h && (u = !0);
            1 == u && (o = a[l].price, s = a[l].store_count);
        }
        n > s ? n = s : 0 == n && (n = 1), t.setData({
            "goods.store_count": s,
            goodsNumber: n,
            "goods.shop_price": o,
            goods_spec_arr: d,
            goods_spec: i
        });
    },
    sortNumber: function(t, e) {
        return t - e;
    },
    goods_cut: function() {
        var t = this.data.goodsNumber;
        t > 1 && (t -= 1), this.setData({
            goodsNumber: t
        });
    },
    goods_add: function() {
      var that = this;
      var t = this.data.goodsNumber;
      if (t < this.data.goods.shop_num) {
        t += 1, that.setData({
          goodsNumber: t
        });
      }
    },
    GoUrl: function(t) {
        var e = t.currentTarget.dataset.url;
        "1" == t.currentTarget.dataset.tab ? wx.navigateTo({
            url: e
        }) : wx.redirectTo({
            url: e
        });
    },
    onShareAppMessage: function(e) {
        return {
            title: this.data.goods.goods_name,
            path: "/pages/index/index?url=goods&id=" + this.data.goods_id + "&uid=" + t.globalData.userInfo.user_id
        };
    },
    previewImage: function(t) {
        var e = t.currentTarget.dataset.idx, o = [], s = this.data.goods_images_list;
        for (var a in s) o.push(s[a].image_url);
        wx.previewImage({
            current: o[e],
            urls: o
        });
    }
});