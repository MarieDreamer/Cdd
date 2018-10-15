var s = getApp();

require("../../js/global.js");

Page({
    data: {
      lists:[],
    },
    onLoad: function() {
        var that = this;
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Lottery/lists',
          success: function (res) {
            console.log(res)
            that.setData({
              lists:res.data.data
            })
          }
        })
    }
});