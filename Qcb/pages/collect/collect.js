var t = getApp();

Page({
    data: {
      collectionarray: [],
      page: 0
    },
    onLoad: function(t) {
        // this.AjaxCollect();
      var s = this
      var userid = wx.getStorageSync('userid');
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/collection/lists',
        data: {
          userid: userid
        },
        success: function (res) {
          // console.log(res.data.lists[0])
          if (res.data.lists[0]){
            s.setData({
              collectionarray: res.data.lists
            })
          }
        },
      })
    },

    deleteid: function (e) {
      var userid = wx.getStorageSync('userid');
      
      // console.log(e.currentTarget.dataset.id);
      // console.log(userid);
      // console.log(o);
      var that = this;
      var collectionarray = that.data.collectionarray;
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/collection/de_do',
        data: {
          commodityid: e.currentTarget.dataset.id,
          userid: userid
        },
        success: function (res) {
          console.log(res.data.status);
          if (res.data.status == 1) {
            wx.showToast({
              title: "删除成功",
            })
            for (var i = 0; i < collectionarray.length; i++){
              console.log(collectionarray[i]);
              if (collectionarray[i].commodityid == e.currentTarget.dataset.id) {
                collectionarray.splice(i, 1);
              }
            }
            that.setData({
              collectionarray: collectionarray,
            })
          } else {
            wx.showModal({
              content: '删除成功',
              showCancel: false
            })
            wx.navigateTo({
              url: '/pages/collect/collect',
            })
          }

        },
      })
    },

    onReachBottom: function() {
        this.AjaxCollect();
    },
    AjaxCollect: function() {
        // var e = this, s = e.data.page;
        // s += 1, t.sendRequest({
        //     url: "/index.php?m=Mobile&c=User&a=collect_list",
        //     data: {
        //         p: s
        //     },
        //     success: function(a) {
        //         1 == a.status ? e.setData({
        //             goods_list: a.goods_list,
        //             page: s
        //         }) : -100 == a.status && (t.globalData.tUrl = "/pages/collect/collect", wx.redirectTo({
        //             url: "/pages/login/login"
        //         }));
        //     }
        // });
    },
    DelGoods: function(e) {
        // var s = this, a = e.currentTarget.dataset.index, l = this.data.goods_list, o = l[a].collect_id;
        // t.sendRequest({
        //     url: "/index.php?m=Mobile&c=User&a=cancel_collect",
        //     data: {
        //         collect_id: o
        //     },
        //     success: function(e) {
        //         1 == e.status ? (l.splice(a, 1), s.setData({
        //             goods_list: l
        //         })) : -1 == e.status ? t.showModal({
        //             content: "" + e.msg
        //         }) : -100 == e.status && (t.globalData.tUrl = "/pages/collect/collect", wx.redirectTo({
        //             url: "/pages/login/login"
        //         }));
        //     }
        // });
    }
});