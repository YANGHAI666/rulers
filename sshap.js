var body = $response.body; 


var obj = JSON.parse($response.body); 


obj = {"id":"b25be20b-704f-42d0-8e49-0aeb3fe1e47c","email":"yh6320141@icloud.com","subscriptionType":"pro_year","subscriptions":[{"id":555354,"type":"appstore","tier":"pro","period":"yearly","purchaseDate":"2022-04-04T19:23:11.000Z","expirationDate":"2023-06-18T19:23:11.000Z","autoRenewStatus":true,"isTrial":true}],"subscriptionExpires":"2061-06-18T19:23:11.000Z","hasEmail":true,"hasPassword":true,"hasFacebookID":false}

$done({body:JSON.stringify(obj)});

