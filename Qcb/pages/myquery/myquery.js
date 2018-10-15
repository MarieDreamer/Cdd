var e = getApp(), t = require("../../js/global.js");

Page({
    data: {
        type: "",
        before_request: 1,
        page: 0,
        listend: 0,
        more: "none",
        lists: "",
        list:"",
    },
    onLoad: function(e) {
        console.log(e)
        var that=this;
        var type_status=e.type;
        var userid = wx.getStorageSync('userid');
        wx.request({
          url: 'https://wechat.cdd.jianfengweb.com/Order/myquery',
          data:{
            userid:userid,
            type_status: type_status,
          },
          success:function(res){
            console.log(res.data.data)
            that.setData({
              list:res.data.data,
              type_status: type_status
            })
          }
        })
    },
    AjaxGet: function() {
        var t = this, a = t.data.page, s = t.data.listend, r = t.data.before_request;
        0 == s && 1 == r && (a += 1, t.setData({
            before_request: 0,
            more: ""
        }), e.sendNoRequest({
            // url: "/index.php?m=Mobile&c=User&a=myquery&t=" + Math.random(),
            method: "POST",
            data: {
                p: a,
                type: t.data.type
            },
            success: function(e) {
                if (1 == e.status) {
                    var s = {};
                    s = "" == t.data.lists ? e.lists : t.data.lists.concat(e.lists), t.setData({
                        lists: s,
                        page: a
                    });
                } else t.setData({
                    listend: 1
                });
            },
            complete: function(e) {
                t.setData({
                    before_request: 1,
                    more: "none"
                });
            }
        }));
    },
    onReachBottom: function() {
        this.AjaxGet();
    },
    GoUrl: function(e) {
        var t = e.currentTarget.dataset.type;
        wx.redirectTo({
            url: "/pages/myquery/myquery?type=" + t
        });
    }
});