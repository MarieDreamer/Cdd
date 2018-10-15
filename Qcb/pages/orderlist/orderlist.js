var e = getApp(), t = require("../../js/global.js"), a = require("../template/tabbar.js");

Page({
    data: {
        page: 1,
        before_request: 1,
        listend: 0,
        type: "",
        more: "none",
        lists:[],
        stat:['待付款','待发货','待收货','已收货','已取消'],
    },
    onLoad: function(r) {
      var type_status=r.type;
      var that = this;
      var s = "";
      var userid = wx.getStorageSync('userid');
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Order/lists',
        data:{
          userid:userid,
          type_status: type_status,
        },
        success:function(res){
          that.setData({
              lists:res.data.data,
              type_status: type_status,
          })
        }
      })
      t.isBlank(r.type) || (s = r.type), this.setData({
          type: s,
          is_comment: e.globalData.config.is_comment
      }), a.tabbar("tabBar", 3, this);

    },
    onShow: function() {
        // var t = this, a = t.data.type;
        // t.setData({
        //     page: 1
        // }), e.sendRequest({
        //     url: "/index.php?m=Mobile&c=User&a=order_list&type=" + a + "&t=" + Math.random(),
        //     success: function(a) {
        //         1 == a.status ? t.setData(a.List) : -100 == a.status ? (e.globalData.tUrl = "/pages/orderlist/orderlist", 
        //         wx.redirectTo({
        //             url: "/pages/login/login"
        //         })) : t.setData({
        //             listend: 1
        //         });
        //     }
        // });
    },
    GoUrl: function (e) {
      var t = e.currentTarget.dataset.type;
      wx.redirectTo({
        url: "/pages/orderlist/orderlist?type=" + t
      });
    },
    Go_Orderdetail: function(e) {
        var id = e.currentTarget.dataset.id;
        wx.navigateTo({
          url: '/pages/orderdetail/orderdetail?id=' + id,
        })
    },
    Go_guess: function (e) {
      var id = e.currentTarget.dataset.id;
      wx.navigateTo({
        url: '/pages/guess/guess?id=' + id,
      })
    },
    Go_cue:function(e){
      var id = e.currentTarget.dataset.id;
      wx.navigateTo({
        url: '/pages/cue/cue?id=' + id,
      })
    },
    onReachBottom: function() {
        this.AjaxOrderList();
    },
    // HandleOrder: function(e) {
    //     var t = e.currentTarget.dataset.url;
    //     wx.navigateTo({
    //         url: t
    //     });
    // },
    ReciveOrder: function (t) {
      var id = t.currentTarget.dataset.id;
      var that = this;
      wx.showModal({
        title: '温馨提示',
        content: '确认收货？',
        confirmText: "确认",
        success: function (res) {
          if (res.confirm == true) {
            wx.request({
              url: 'https://wechat.cdd.jianfengweb.com/Order/confirm_order',
              data: {
                id: id
              },
              success: function (res) {
                var lists = that.data.lists;
                for (var i = 0; i < lists.length; i++) {
                  if (lists[i]['id'] == id) {
                    lists[i]['shop_status'] = 3;
                  }
                }
                that.setData({
                  lists: lists
                })
              }
            })
          }
        },
      })
    },
    CancelOrder: function(t) {
        var id=t.currentTarget.dataset.id;
        var that=this;
        wx.showModal({
          title: '温馨提示',
          content: '您要继续取消订单吗？',
          confirmText:"继续",
          success:function(res){
            if(res.confirm==true){
              wx.request({
                url: 'https://wechat.cdd.jianfengweb.com/Order/cancel_order',
                data:{
                  id:id
                },
                success:function(res){
                  var lists=that.data.lists;
                    for(var i=0;i<lists.length;i++){
                      if(lists[i]['id']==id){
                        lists[i]['shop_status']=4;
                      }
                    }
                  that.setData({
                    lists: lists
                  })
                }
              })
            }
          },
        })
    },
    PayOrder: function(t) {
        var that = this;
        var r = t.currentTarget.dataset.id;
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Order/get',
          data:{
            id:r
          },
          success:function(a){
            console.log(a.data.data.total_price)
            //获取微信预支付id
            wx.request({
              url: 'https://wechat.cdd.jianfengweb.com/Order/getPrepay',
              data: {
                total_fee: a.data.data.total_price*100,
                product_id: a.data.data.order_number,
              },
              success: function (res) {
                console.log(res.data.data)
                // 获取成功后
                wx.requestPayment(
                  {
                    'timeStamp': new Date().getTime().toString(),
                    'nonceStr': res.data.data['nonce_str'],
                    'package': "prepay_id=" + res.data.data['prepay_id'],
                    'signType': 'MD5',
                    'paySign': res.data.data['sign'],
                    'success': function (e) {
                      console.log('success')
                    },
                    'fail': function (e) {
                      console.log(e)
                    },
                    'complete': function (e) { }
                  })
              }
            })
          }
        })
        
        
    }
});