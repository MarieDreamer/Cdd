function e(e, t) {
    1 == e.data.before_request && (e.setData({
        before_request: 0
    }), a.sendRequest({
        url: "/index.php?m=Mobile&c=Payment&a=getCode&order_id=" + t,
        data: {
            pay_radio: "pay_code=weixin"
        },
        success: function(s) {
            e.setData({
                before_request: 1
            }), 1 == s.status ? (e.setData({
                Pay_para: s.Para
            }), a.Wxpay(t, s.Para, "/pages/payok/payok?id=" + t)) : -2 == s.status ? a.showModal({
                content: " " + s.msg,
                confirm: function() {
                    wx.redirectTo({
                        url: "/pages/orderlist/orderlist"
                    });
                }
            }) : -3 == s.status ? a.showModal({
                content: " " + s.msg,
                confirm: function() {
                    wx.redirectTo({
                        url: "/pages/orderlist/orderlist"
                    });
                }
            }) : -100 == s.status ? (a.globalData.tUrl = "/pages/cart2/cart2", wx.redirectTo({
                url: "/pages/login/login"
            })) : a.showModal({
                content: " " + s.msg
            });
        }
    }));
}

var a = getApp();

require("../../js/global.js");

Page({
    data: {
        address_id: 0,
        Shipping_Name: "",
        shipping_code: "",
        coupon_id: 0,
        coupon_num: 0,
        user_note: "",
        pay_points: 0,
        pay_balance: "",
        postFee: 0,
        couponFee: 0,
        pointsFee: 0,
        before_request: 1,
        is_balace: !1,
        showbonus: "none",
        sid: 0,
        is_address:0,
        consignee: "", //收货人
        mobile: "",//联系号码
        region: "",//所在地区
        address: "",//详细地址
        shippingList:[
          { name: '包邮', code: 'url' },
          { name: '其他', code: 'url' }
        ],
    },
    onLoad: function(s) {
        var that = this;
        var cartList = wx.getStorageSync('json');
        var user_id = wx.getStorageSync('userid');
        var total_num = 0;
        var total_price = 0;
        for(var i=0 ; i <cartList.length; i ++){
          total_num += parseInt(cartList[i].good_num);
          total_price += cartList[i].good_num * cartList[i].member_goods_price
        }
        this.setData({
          cartList: cartList,
          shipping_code: that.data.shippingList[0].code,
          Shipping_Name: that.data.shippingList[0].name,
          total_num: total_num,
          total_price: total_price,
          origin_total: total_price
        })
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Coupon/lists',
          data:{
            user_id:user_id,
            status:0
          },
          success:function(res){
            if(res.data.data){
              that.setData({
                coupon_num: res.data.data.length,
                coupon: res.data.data
              })
            }
            
          }
        })
        var userid = wx.getStorageSync('userid')
        if (s.user_address_id){
          var choose_address = s.user_address_id
          wx.request({
            url: 'https://wechat.cdd.jianfengweb.com/UserAddress/address_lists',
            data: {
              id: choose_address
            },
            success: function (res) {
              that.setData({
                address: res.data.data[0]
              })
            }
          })
        }else{
          wx.request({
            url: 'https://wechat.cdd.jianfengweb.com/UserAddress/address_lists',
            data: {
              userid: userid,
              is_default: 1
            },
            success: function (res) {
              if(res.data.data){
                that.setData({
                  address: res.data.data[0],
                })
              }
              
            }
          })
        }
        
        // if(s.user_address_id){
        //     wx.request({
        //       url: 'https://wechat.cdd.jianfengweb.com/UserAddress/get',
        //       data:{
        //         id: s.user_address_id
        //       },
        //       success:function(res){
        //           console.log(res)
        //           var consignee = res.data.data.consignee;
        //           var mobile = res.data.data.mobile;
        //           var region = res.data.data.region;
        //           var address = res.data.data.address;
        //           that.setData({
        //             is_address: 1,
        //             consignee: consignee,
        //             mobile: mobile,
        //             region: region,
        //             address: address,
        //           })
        //       }
        //     })
        // }
        
        
    },
    onShow:function(s){
    },
    ChangeShipping: function() {
        var e = this, a = e.data.shippingList, t = new Array();
        for (var s in a) t.push(a[s].name);
        wx.showActionSheet({
            itemList: t,
            success: function(t) {
                1 != t.cancel && e.setData({
                    shipping_code: a[t.tapIndex].code,
                    Shipping_Name: a[t.tapIndex].name
                });
            }
        });
    },
    InputUserNote: function(e) {
        "" == e.detail.value && this.setData({
            user_note: ""
        }), this.setData({
            user_note: e.detail.value
        });
    },
    ChangeBalance: function(e) {
        "" == e.detail.value && this.setData({
            pay_balance: ""
        }), this.setData({
            pay_balance: e.detail.value
        }), this.AjaxOrderPrice();
    },
    AjaxOrderPrice: function() {
        var e = this, t = {
            address_id: e.data.address_id,
            shipping_code: e.data.shipping_code,
            coupon_id: e.data.coupon_id,
            pay_points: e.data.pay_points,
            user_money: e.data.pay_balance,
            user_note: e.data.user_note,
            sid: e.data.sid
        };
        a.sendRequest({
            url: "/index.php?m=Mobile&c=Cart&a=cart3&act=order_price&t=" + Math.random(),
            data: t,
            success: function(s) {
                if (1 == s.status) {
                    var r = {};
                    r.balance = s.result.balance, r.postFee = s.result.postFee, r.couponFee = s.result.couponFee, 
                    r.pointsFee = s.result.pointsFee, r.payables = s.result.payables, r.order_prom_amount = s.result.order_prom_amount, 
                    e.data.user.user_money > s.result.payables ? r.use_balance = s.result.payables : r.use_balance = e.data.user.user_money, 
                    r.bonus_price = s.result.bonus_price, e.setData(r);
                } else -100 == t.status ? (a.globalData.tUrl = "/pages/cart2/cart2", wx.redirectTo({
                    url: "/pages/login/login"
                })) : a.showModal({
                    content: " " + s.msg
                });
            }
        });
    },
    
    CheckBalance: function() {
        var e = this;
        1 == e.data.is_balance ? e.setData({
            is_balance: !1,
            pay_balance: 0
        }) : e.setData({
            is_balance: !0,
            pay_balance: e.data.use_balance
        }), this.AjaxOrderPrice();
    },
    showBonus: function() {
        "none" == this.data.showbonus ? this.setData({
            showbonus: ""
        }) : this.setData({
            showbonus: "none"
        });
    },
    SelectCoupon: function(e) {
      var a = e.currentTarget.dataset.index, t = this.data.coupon, s = 0;
      for(var i in t){
        t[i].selected = ''
      }
      var id = e.currentTarget.dataset.id;
      var bonus = e.currentTarget.dataset.bonus;
      for (var r in t) {
        r == a && "" == t[r].selected ? (t[r].selected = "my-thc", s = t[r].id) : t[r].selected = "";
      }
      var total_price = this.data.origin_total - parseFloat(bonus);
      if (total_price<0){
        total_price = 0;
      }
      this.setData({
          sharebonus: t,
          sid: s,
          select_coupon_id:id,
          total_price: total_price
      })
    },
    submitOrder:function(){
      var that = this;
      var selected_coupon = '';
      var user_id = wx.getStorageSync('userid')
      
      var shop = [];
      for(var i = 0 ; i < that.data.cartList.length ; i ++){
        var arr = [that.data.cartList[i]['good_id'], that.data.cartList[i]['good_num']]
        shop.push(arr)
      }
      wx.request({
        url:"https://wechat.cdd.jianfengweb.com/Order/addOrder",
        data:{
          user_id: user_id,
          address: that.data.address,
          shop: shop,
          shipping_name: that.data.Shipping_Name,
          coupon_id: that.data.select_coupon_id,
          user_note:that.data.user_note,
          total_num: that.data.total_num,
          total_price: that.data.total_price,
          cartList:that.data.cartList
        },
        success:function(a){
          //获取微信预支付id
          wx.request({
            url: 'https://wechat.cdd.jianfengweb.com/Order/getPrepay',
            data:{
              total_fee: that.data.total_price,
              product_id:a.data.data,
              user_id:wx.getStorageSync('userid')
            },
            success:function(res){
              
              // 获取成功后
              wx.requestPayment(
                {
                  'timeStamp': parseInt(res.data.data['startTimeStamp'] / 1000).toString() ,
                  'nonceStr': res.data.data['nonce_str'],
                  'package': "prepay_id="+res.data.data['prepay_id'],
                  'signType': 'MD5',
                  'paySign': res.data.data['paySign'],
                  'success': function (e) {
                    that.toOrderList(a.data.data);
                   },
                  'fail': function (e) {
                    wx.navigateTo({
                      url: '../orderlist/orderlist',
                    })
                   }
                }) 
            },
            fail:function(e){
              console.log(e)
            }
          })
          
        }
      })
    },
    toOrderList:function(e){
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Order/findOrder',
        data:{
          order_number:e
        },
        success:function(res){
          if (res.data.data['trade_state'] == 'SUCCESS'){
            wx.navigateTo({
              url: '../orderlist/orderlist',
            })
          }
        }
      })
    }
});