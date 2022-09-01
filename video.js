var body = $response.body; 

var obj = JSON.parse($response.body); 


obj = {"latestProductId":"com.lightricks.EnlightVideo_V2.PQ.1Y.SA_1Y.SA_TRIAL.1W","latestPurchaseDateMs":1662043889000,"originalPurchaseDateMs":1662043890000,"originalTransactionId":"210001177415261","pendingRenewalInfo":{"nextProductId":"com.lightricks.EnlightVideo_V2.PQ.1Y.SA_1Y.SA_TRIAL.1W","isAutoRenewEnabled":true,"expirationIntent":null},"isExpired":false,"latestTransactionId":"210001177415261","latestExpirationDateMs":3871723889000,"fullRefundDateMs":null}

$done({body:JSON.stringify(obj)});
