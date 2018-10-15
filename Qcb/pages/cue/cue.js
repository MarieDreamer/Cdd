var e = getApp(), t = require("../../js/global.js");

Page({
    data: {
        fail_img: "https://wechat.cdd.jianfengweb.com/images/bg2.png",
        success_img: "https://wechat.cdd.jianfengweb.com/images/cue-bg.png",
        show: "",
        Tshow: "none",
        id: 0,
        list:"",
    },
    onLoad: function(s) {
        console.log(s);
        var id=s.id;
        var that=this;
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Order/is_free?id='+id,
          data:{
            id:id
          },
          success:function(res){
            console.log(res)
            that.setData({
              list: res.data.data
            })
          }
        })
    },
    GoUrl: function(e) {
        var t = e.currentTarget.dataset.url;
        "nav" == e.currentTarget.dataset.nav ? wx.navigateTo({
            url: t
        }) : wx.redirectTo({
            url: t
        });
    },
    Go_Orderdetail: function (e) {
      var id = e.currentTarget.dataset.id;
      wx.navigateTo({
        url: '/pages/orderdetail/orderdetail?id=' + id,
      })
    },
    onShareAppMessage: function() {
        var s = this;
        return {
            title: "购物猜单双   猜中能免单",
            path: "/pages/index/index?uid=" + e.globalData.userInfo.user_id,
            success: function(a) {
                console.log(!t.isBlank(a.shareTickets)), t.isBlank(a.shareTickets) ? e.showModal({
                    content: "请分享到群，未分享到群不能获得返利"
                }) : wx.getShareInfo({
                    shareTicket: a.shareTickets[0],
                    success: function(t) {
                        console.log(a.shareTickets[0]), 1 == s.data.get_status && e.checkSession().then(function(a) {
                            e.sendNoRequest({
                                // url: "/index.php?m=Mobile&c=User&a=checkGid&t=" + Math.random(),
                                data: {
                                    sessionkey: e.getSessionKey(),
                                    encryptedData: t.encryptedData,
                                    iv: t.iv,
                                    id: s.data.id
                                },
                                success: function(t) {
                                    1 == t.status ? s.setData({
                                        Tshow: "",
                                        is_back: 2,
                                        back_money: t.back_money
                                    }) : 2 == t.status && e.showModal({
                                        content: "请分享到群，未分享到群不能获得返利"
                                    });
                                }
                            });
                        });
                    },
                    complete: function(e) {}
                });
            }
        };
    },
    CloseShow: function() {
        this.setData({
            Tshow: "none"
        });
    }
});