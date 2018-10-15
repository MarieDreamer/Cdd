var e = getApp();

Page({
    data: {
        id: 0,
        before_request: 1,
        list:[],
        stat: ['待付款', '待发货', '待收货', '已收货','已取消'],
    },
    onLoad: function(t) {
      var id=t.id;
      var that=this;
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Order/get',
        data:{
          id:id,
        },
        success:function(res){
          that.setData({
            list:res.data.data
          })
        }
      })
    },
    CancelOrder: function (t) {
      console.log(t)
      var id = t.currentTarget.dataset.id;
      var that = this;
      wx.showModal({
        title: '温馨提示',
        content: '您要继续取消订单吗？',
        confirmText: "继续",
        success: function (res) {
          if (res.confirm == true) {
            wx.request({
              url: 'https://wechat.cdd.jianfengweb.com/Order/cancel_order',
              data: {
                id: id
              },
              success: function (res) {
                var list = that.data.list;
                for (var i = 0; i < list.length; i++) {
                  if (list[i]['id'] == id) {
                    list[i]['shop_status'] = 4;
                  }
                }
                that.setData({
                  list: list
                })
              }
            })
          }
        },
      })
    },
    ReciveOrder: function() {
        var t = this.data.id;
        e.showModal({
            content: "请确定您是否收到货物？",
            showCancel: !0,
            confirmText: "继续",
            confirm: function() {
                e.sendRequest({
                    // url: "/index.php?m=Mobile&c=User&a=order_confirm&id=" + t + "&t=" + Math.random(),
                    success: function(r) {
                        1 == r.status ? wx.redirectTo({
                            url: "/pages/orderconfirm/orderconfirm?id=" + t
                        }) : -100 == r.status ? (e.globalData.tUrl = "/pages/orderdetail/orderdetail?id=" + t, 
                        wx.redirectTo({
                            url: "/pages/login/login"
                        })) : e.showModal({
                            content: "" + r.msg
                        });
                    }
                });
            }
        });
    },
    HandleOrder: function(e) {
        var t = e.currentTarget.dataset.url;
        wx.redirectTo({
            url: t
        });
    },
    GoUrl: function(e) {
        var t = e.currentTarget.dataset.url;
        "redirect" == e.currentTarget.dataset.type ? wx.redirectTo({
            url: t
        }) : wx.navigateTo({
            url: t
        });
    },
    PayOrder: function() {
        var t = this, r = t.data.id;
        1 == t.data.before_request && (t.setData({
            before_request: 0
        }), e.sendRequest({
            // url: "/index.php?m=Mobile&c=Payment&a=getCode&order_id=" + r,
            data: {
                pay_radio: "pay_code=weixin"
            },
            success: function(a) {
                t.setData({
                    before_request: 1
                }), 1 == a.status ? (t.setData({
                    Pay_para: a.Para
                }), e.Wxpay(r, a.Para, "/pages/orderdetail/orderdetail?id=" + r)) : -2 == a.status ? e.showModal({
                    content: " " + a.msg,
                    confirm: function() {
                        wx.redirectTo({
                            url: "/pages/orderdetail/orderdetail?id=" + r
                        });
                    }
                }) : -3 == a.status ? e.showModal({
                    content: " " + a.msg,
                    confirm: function() {
                        wx.redirectTo({
                            url: "/pages/orderlist/orderlist"
                        });
                    }
                }) : -100 == a.status ? (e.globalData.tUrl = "/pages/orderdetail/orderdetail?id=" + id, 
                wx.redirectTo({
                    url: "/pages/login/login"
                })) : e.showModal({
                    content: " " + a.msg
                });
            }
        }));
    }
});