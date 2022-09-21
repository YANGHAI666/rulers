var body = $response.body; // 声明一个变量body并以响应消息体赋值

var obj = JSON.parse($response.body); 

// 可以合并一句带过

obj = {"code":200,"message":"请求成功","status":"1","data":{"token":"83553428facca51581c8d8a88caeafced9504750","expiredIn":3800000000,"user":{"cardActive":true,"paidUser":false,"totalTransfer":9915334656,"subUrl":"","email":"","channel":"GW","expiredDate":"2999-12-12","timeRemaining":999999999,"flowTotal":"9.23GB","flowUsed":"0.0KB","flowRemaining":"999999.0GB","id":131296,"username":"User_14923736089138705125","status":1,"vip":1,"isTrial":true,"inviteCode":"X200ETXT","inviteUrl":"https://telescope.name/app.html?invite_code=X200ETXT&channel=GW","inviteBy":""}}}

$done({body:JSON.stringify(obj)});

// 也一句带过
