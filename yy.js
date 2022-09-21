var body = $response.body; // 声明一个变量body并以响应消息体赋值


var obj = JSON.parse($response.body); 
// 可以合并一句带过

obj = {"code":200,"msg":"操作成功","data":{"endTime":"","isVip":1}}

$done({body:JSON.stringify(obj)});
// 也一句带过
