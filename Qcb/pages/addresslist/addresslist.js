var s = getApp(), t = require("../../js/global.js");

Page({
    data: {
        source: "",
        address_lists: {},
        show_no_data: 0,
    },
    onLoad: function(s) {
        if (s.is_cart2){
          wx.setStorageSync('is_cart2', s.is_cart2);
        }
        
        var a = this;
        t.isBlank(s.source) || a.setData({
            source: s.source
        });
    },
    Go_address_edit:function(t){
      var id = t.currentTarget.dataset.id;
      wx.navigateTo({
        url: '/pages/address_edit/address_edit?id='+id,
      })
    },
    onShow: function(t) {
        var that = this;
        var userid = wx.getStorageSync('userid');
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/UserAddress/address_lists',
          data: {
            userid: userid,
          },
          success: function (res) {
            var address_lists = res.data.data;
            that.setData({
              address_lists: address_lists
            })
            // console.log(that.data.address_lists)
          }
        })
        
        // var t = this;
        // s.sendRequest({
        //     url: "/index.php?m=Mobile&c=User&a=address_list&t=" + Math.random(),
        //     success: function(a) {
        //         1 == a.status ? t.setData({
        //             address_lists: a.address_lists
        //         }) : -100 == a.status ? (s.globalData.tUrl = "/pages/addresslist/addresslist", wx.redirectTo({
        //             url: "/pages/login/login"
        //         })) : t.setData({
        //             show_no_data: 1
        //         });
        //     }
        // });
    },
    // DefaultAddr: function(t) {
    //     var a, e = this, d = t.currentTarget.dataset.index, r = e.data.address_lists, i = {};
    //     for (var o in r) i["address_lists[" + o + "].is_default"] = 0;
    //     i["address_lists[" + d + "].is_default"] = 1, a = r[d].address_id, s.sendNoRequest({
    //         url: "/index.php?m=Mobile&c=User&a=set_default&id=" + a,
    //         success: function(s) {
    //             1 == s.status && ("cart2" == e.data.source ? wx.redirectTo({
    //                 url: "/pages/cart2/cart2"
    //             }) : e.setData(i));
    //         }
    //     });
    // },
    DelAddress: function(t) {
        console.log(t)
        var that=this;
        var id = t.currentTarget.dataset.id;
        var address_lists = that.data.address_lists;
        for(var i=0;i<address_lists.length;i++){
            if(address_lists[i].id==id){
              address_lists.splice(i, 1);
            }
        }
        that.setData({
          address_lists: address_lists,
        })
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/UserAddress/delete_do',
          data:{
            id:id,
          },
          success:function(res){
            console.log(res)
            that.setData({
              address_lists: address_lists,
            })
          }
        })
    },
    choose:function(res){
      var that=this;
      var user_address_id = res.currentTarget.dataset.id;
      var is_cart2 = wx.getStorageSync('is_cart2');
      if (is_cart2){
        wx.removeStorageSync('is_cart2');
        wx.navigateTo({
          url: '/pages/cart2/cart2?user_address_id=' + user_address_id,
        })
      }
      
    }
});