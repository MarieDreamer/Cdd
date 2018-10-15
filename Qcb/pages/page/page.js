var e = getApp(), t = require("../../js/global.js"), i = require("../../js/wxParse/wxParse.js");

Page({
    data: {
      rulearray:[]
    },
    onLoad: function(a) {
        // console.log(a);
        var rulearray=''
        var s = 0;
        t.isBlank(a.id) ? wx.redirectTo({
            url: "/pages/index/index"
        }) : s = a.id;
        var n = this;
        e.sendRequest({
            // url: "/index.php?m=Mobile&c=Index&a=page&id=" + s,
            success: function(e) {
                1 == e.status && (n.setData(e.info), i.wxParse("content", "html", e.info.content, n, 10), 
                wx.setNavigationBarTitle({
                    title: e.info.title
                }));
            }
        });

        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Rule/ruledisplay',
          data: {
          },
          success: function (res) {
            // console.log(res.data.data)
            rulearray = res.data.data;
            // console.log(rulearray)
            n.setData({
              rulearray : rulearray
            })
          },
        })
    }
});