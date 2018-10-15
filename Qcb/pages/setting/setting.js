var e = getApp();

Page({
    data: {
        sex: "",
        list:["","男","女"],
        address: "",
        before_request: 1
    },
    onLoad: function() {
      var that = this;
      var userid = wx.getStorageSync('userid');
      wx.request({
        url: 'https://wechat.cdd.jianfengweb.com/WechatUser/setting_list',
        data: {
          id: userid,
        },
        success: function (res) {
          if (res) {
            that.setData({
              sex: res.data.data.gender,
              address: res.data.data.province + res.data.data.city
            })
          }
        }
      })
    },
    onShow: function() {
        
    },
    GoUrl: function(e) {
        var t = e.target.dataset.url;
        wx.navigateTo({
            url: t
        });
    },
});