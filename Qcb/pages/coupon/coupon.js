var t = getApp();

Page({
    data: {
        page: 1,
        before_request: 1,
        listend: 0,
        type: 0,
        show: {},
        more: "none",
        coupon_list:[],
        navbar: ['未使用', '已使用', '已过期'],
        currentTab: 3,
        bgTab:3
    },
    navbarTap: function (e) {
      this.setData({
        currentTab: e.currentTarget.dataset.idx
      })
      var that = this;
      var user_id = wx.getStorageSync('userid');      
      var coupon = this.data.coupon_list;
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Coupon/lists',
        data: {
          status: e.currentTarget.dataset.idx,
          user_id:user_id
        },
        success: function (res) {
          that.setData({
            coupon_list: res.data.data
          })
          if (!res.data.data) {
            that.setData({
              listend: 1
            })
          }else{
            that.setData({
              listend: 0
            })
          }
        }
      })
    },
    touchstart:function(e){
      this.setData({
        bgTab: e.currentTarget.dataset.idx
      })
    },
    touchend: function () {
      this.setData({
        bgTab: 3
      })
    },
    onLoad: function(e) {
      var that = this;
      var user_id = wx.getStorageSync('userid');
      var coupon = this.data.coupon_list;
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Coupon/lists',
        data: {
          user_id: user_id,
          status:3
        },
        success: function (res) {
          that.setData({
            coupon_list: res.data.data
          })
          if (!res.data.data){
            that.setData({
              listend: 1
            })
          } else {
            that.setData({
              listend: 0
            })
          }
        }
      })
      
      
        // var a = this, o = e.type;
        // "" != e.type && null != e.type || (o = 0);
        // var s = {};
        // t.sendRequest({
        //     url: "/index.php?m=Mobile&c=User&a=share_coupon&type=" + o + "&t=" + Math.random(),
        //     success: function(e) {
        //         1 == e.status ? a.setData(e.Coupon) : -100 == e.status ? (t.globalData.tUrl = "/pages/coupon/coupon", 
        //         wx.redirectTo({
        //             url: "/pages/login/login"
        //         })) : a.setData({
        //             listend: 1
        //         });
        //     }
        // }), s.type = o, s["show.type" + o] = "topanv-this", a.setData(s);
    },
    // onReachBottom: function() {
        // this.AjaxCoupon();
    // },
    AjaxCoupon: function() {
        var e = this;
        var a = e.data.page;
        var o = e.data.type;
        var s = e.data.listend;
        var n = e.data.before_request;
        0 == s && 1 == n && (e.setData({
            before_request: 0,
            more: ""
        }), a += 1, t.sendRequest({
            // url: "/index.php?m=Mobile&c=User&a=share_coupon&type=" + o + "&t=" + Math.random(),
            data: {
                p: a
            },
            success: function(o) {
                if (1 == o.status) {
                    var s = e.data.coupon_list.concat(o.Coupon.coupon_list);
                    e.setData({
                        coupon_list: s,
                        page: a
                    });
                } else -100 == o.status ? (t.globalData.tUrl = "/pages/coupon/coupon", wx.redirectTo({
                    url: "/pages/login/login"
                })) : e.setData({
                    listend: 1
                });
            },
            complete: function() {
                e.setData({
                    before_request: 1,
                    more: "none"
                });
            }
        }));
    }
});