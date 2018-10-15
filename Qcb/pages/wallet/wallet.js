var t = getApp();

Page({
    data: {
        before_request: 1,
        page: 0,
        listend: 0,
        account_log: [1,2],
        balance:0,
        hiddenmodalput:1,
        money:0,
    },
    onLoad: function() {
    //     var a = this;
    //     t.sendRequest({
    //         url: "/index.php?m=Mobile&c=User&a=account&t=" + Math.random(),
    //         success: function(e) {
    //             1 == e.status ? a.setData({
    //                 user: e.user
    //             }) : -100 == e.status && (t.globalData.tUrl = "/pages/wallet/wallet", wx.redirectTo({
    //                 url: "/pages/login/login"
    //             }));
    //         }
    //     });
      var that = this;
      var user_id = wx.getStorageSync('userid');
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/WechatUser/getBalance',
        data:{
          user_id:user_id
        },
        success:function(res){
          that.setData({
            balance:res.data.data
          })
        }
      })

      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Account/getUserAccount',
        data: {
          user_id: user_id
        },
        success: function (res) {
          that.setData({
            account_log: res.data.data
          })
        }
      })
    },
    refund:function(){
      var that = this;
      var user_id = wx.getStorageSync('userid');
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/Refund/checkRefund',
        data:{
          user_id:user_id
        },
        success:function(res){
          if(res.data.result){
            wx.showModal({
              title: '提示',
              content: '退款申请中...',
            })
          }else{
            that.setData({
              hiddenmodalput: 0
            })
          }
        }
      })
      
      
    },
    amount:function(e){
      this.setData({
        money: e.detail.value
      })
    },
    confirm:function(){
      var that = this;
      var user_id = wx.getStorageSync('userid');
      if (!this.data.money || this.data.money ==0){
        wx.showModal({
          title: '提示',
          content: '请输入金额',
        })
      }else if(this.data.balance>=this.data.money){
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Refund/addRefund',
          data:{
            user_id:user_id,
            money:that.data.money
          },
          success:function(res){
            wx.showModal({
              title: '提示',
              content: '申请退款成功',
            })
            that.cancel();
          },
          fail:function(){
            wx.showModal({
              title: '提示',
              content: '申请退款失败',
            })
          }
        })
      } else if (this.data.balance < this.data.money){
        wx.showModal({
          title: '提示',
          content: '余额不足，请重新输入',
        })
      }
    },
    cancel: function () {
      this.setData({
        hiddenmodalput: 1
      })
    },
    onReachBottom: function() {
        // this.AjaxPoints();
    },
    // AjaxPoints: function() {
    //     var a = this, e = a.data.page, s = a.data.listend, o = a.data.before_request;
    //     0 == s && 1 == o && (a.setData({
    //         before_request: 0
    //     }), e += 1, t.sendRequest({
    //         url: "/index.php?m=Mobile&c=User&a=points&t=" + Math.random(),
    //         data: {
    //             p: e
    //         },
    //         success: function(s) {
    //             if (a.setData({
    //                 before_request: 1
    //             }), 1 == s.status) {
    //                 var o = a.data.account_log.concat(s.account_log);
    //                 a.setData({
    //                     account_log: o,
    //                     page: e
    //                 });
    //             } else -100 == s.status ? (t.globalData.tUrl = "/pages/wallet/wallet", wx.redirectTo({
    //                 url: "/pages/login/login"
    //             })) : a.setData({
    //                 listend: 1
    //             });
    //         }
    //     }));
    // }
});