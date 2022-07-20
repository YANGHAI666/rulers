
/**
 * @fileoverview Template to compose HTTP reqeuest.
 * 
 */

const url = `https://ios.prod.ftl.netflix.com/iosui/user/14.36`;
const method = `POST`;
const headers = {
'Accept' : `*/*`,
'X-Netflix.Request.Client.Context' : `{"appState":"foreground"}`,
'Accept-Encoding' : `gzip, deflate, br`,
'x-netflix.context.profile-guid' : `S3PZMGLQQBCMXD5CHQDITUSWKM`,
'x-netflix.context.app-version' : `14.36.0`,
'x-netflix.context.form-factor' : `pad`,
'x-netflix.context.sdk-version' : `2012.4`,
'X-Netflix.client.appVersion' : `14.36.0`,
'x-netflix.context.max-device-width' : `1194`,
'X-Netflix.Argo.abTests' : `3210:1`,
'X-Netflix.Request.Routing' : `{"path":"/nq/mobile/nqios/~14.36.0/user","control_tag":"iosui_argo"}`,
'Cookie' : `NetflixId=ct%3DBQAOAAEBEDEjbEiEsmIKNhPMOSxWhCmCkCDLhQpm1gkgthhezqUOhrDh5X9WpQW0igGUnrr3xFEvFjHKVqEhiO3B8938_AwL-GBCgNAA3BL6rz9drq-DKKChTh2ZYMLdfzRw0b3R5jxZMG-iQOZN0uIhogQyHkllHqM2WuVzMKSyrCJ5ycBnYoxE4ar9WHqEHvvmPu8jQEonXqrI8KYvWAXvs7Py46ZpoF6EcQF4i8NwMQthzKyf_30ti6n6ejz0hDeOGLe40iakYVpvOnCmRxf3kKgQTAnWPJ1JZK5VhSfIskJo6wX82EtDCP_IwXP2Spc63oSb3zBniSt9kSLDxoVhIOnpqISF0NbP7T57TvHH5-H3ouuAMaeOMtDtVZGVy058xutYaYmkObZYeWr-GlxUVLdhtlX-A23Gdg3vdLnqaF_2Aq4YIRf25O97qj93s3LaPh_xjg7slPE7YWKalvIA1LIJVu0FVx7IQrhK28i8MWwixtYS3rb_N-Y1JOZ1vEtjcYlXdiri_qdq0h-heJGNnL3dCcG1XNgP6WrYYHKTkaGOqw60aLQLLSzwnkFrj6ZBcfYztTwJfmXn8ntHHdDdO3IIOCXoKk2fk42ODudT9vnMIwqttO3eIWZXW_4c4TZ-y8137jvTfbnW8nD3iQK0KYPGmvFql3KeFl8CPJbZNXYRgXZL6tfs9gvdLJEe2iR1pyNrrwCpsl7ZBGXcl_XALIJEwICMz2HT0wNQmHcEkiOyCD5C3Gm_da83Hd5JqkB0nXceUxvLuSaoxlKNX-hR3QgHVDYs7tq5-Of5_9jthE73vADJ356Te0JH5Viw_GX5Hja9hcChWFyAOW_ZvhWt4TWWJwVSX27DAUGVHpNM-xtL8jSjl_-t3CwUzK0S_wuixD6a9xvj%26bt%3Ddbl%26ch%3DAQEAEAABABQMbB57hO7Kj9LX9m6a2FzkMILcaxqDp0M.%26v%3D2%26mac%3DAQEAEAABABSeIh2lyFNxJLcUhAsEgkeKOJZAdK0tlYo.; SecureNetflixId=v%3D2%26mac%3DAQEAEQABABS9r0axpuvdesa3giDp5crUCBGl5eNwh_M.%26dt%3D1652968490647; nfvdid=BQFmAAEBEI56z6E6jeQG_4YgtAf2jJlgeKWutuBxvZ65F98rs1kqazyE7vDI_4QV0G-ap-1a2s22fg73WqNCekz6a0n96UqhYKzSTr-JZj6L6OA2UbXu-MFRc9Rz_sutA7nIRm89NY77GburGZK2QkdGpkzMQrZR`,
'x-netflix.context.ab-tests' : `3210:1`,
'X-Netflix.tracing.cl.userActionId' : `813309C3-7681-4CFA-85C8-E25FD0CF00DB`,
'X-Netflix.request.toplevel.uuid' : `49D59B0C-EAB3-44B7-AEC7-4360076E5FA7`,
'Content-Type' : `application/x-www-form-urlencoded`,
'X-Netflix.Request.Attempt' : `1`,
'User-Agent' : `Argo/14.36.0 (iPad; iOS 15.3; Scale/2.00)`,
'Accept-Language' : `zh-Hans-CN;q=1, en-CN;q=0.9, zh-Hant-CN;q=0.8`,
'X-Netflix.client.iosVersion' : `15.3`,
'x-netflix.context.supports-games' : `true`,
'x-netflix.context.top-level-uuid' : `49D59B0C-EAB3-44B7-AEC7-4360076E5FA7`,
'X-Netflix.client.type' : `argo`,
'X-Netflix.Argo.NFNSM' : `9`,
'Host' : `ios.prod.ftl.netflix.com`,
'x-netflix.context.os-version' : `15.3`,
'Connection' : `keep-alive`,
'X-Netflix.request.client.supportsgames' : `true`,
'x-netflix.context.ui-flavor' : `argo`,
'X-Netflix.client.idiom' : `pad`,
'X-Netflix.Argo.translated' : `true`,
'X-Netflix.client.ftl.esn' : `NFAPPL-01-IPAD8=9-A5458A1654F34DB40B13B2A5C5CFE773D67DAB7A8DFF8A9D320573A1738480C5`,
'X-Netflix.request.client.user.guid' : `S3PZMGLQQBCMXD5CHQDITUSWKM`,
'x-netflix.context.pixel-density' : `2.0`
};
const body = `appInternalVersion=14.36.0&appVersion=14.36.0&callPath=%5B%22ablanguagestrings%22%5D&config=%7B%22fastLaughsRowV2Enabled%22%3A%22false%22%2C%22comedyFeedEnabled%22%3A%22false%22%2C%22addHorizontalBoxArtToVideoSummariesEnabled%22%3A%22false%22%2C%22kidsBillboardEnabled%22%3A%22true%22%2C%22staffPicksRowEnabled%22%3A%22false%22%2C%22profilePreferencesUIRefreshEnabled%22%3A%22true%22%2C%22bypassContextualAssetsEnabled%22%3A%22false%22%2C%22roarEnabled%22%3A%22true%22%2C%22pullToMyStuffBillboardArtEnabled%22%3A%22false%22%2C%22kidsFavRowEnabled%22%3A%22false%22%2C%22isSharksDisabledForLessThanIOS15%22%3Atrue%2C%22kidsMyListEnabled%22%3A%22true%22%2C%22useCDSGalleryEnabled%22%3A%22true%22%2C%22billboardEnabled%22%3A%22true%22%2C%22seasonRenewalPostPlayEnabled%22%3A%22true%22%2C%22kidsClipsLolomoRowEnabled%22%3A%22false%22%2C%22cdsSearchForceGameGridEnabled%22%3A%22false%22%2C%22cdsSearchLolomoEnabled%22%3A%22false%22%2C%22contentWarningEnabled%22%3A%22true%22%2C%22videosInPopularGamesEnabled%22%3A%22true%22%2C%22fastLaughsRowV2DisabledEnabled%22%3A%22false%22%2C%22sharksEnabled%22%3A%22true%22%7D&device_type=NFAPPL-01-&esn=NFAPPL-01-IPAD8%3D9-A5458A1654F34DB40B13B2A5C5CFE773D67DAB7A8DFF8A9D320573A1738480C5&idiom=pad&iosVersion=15.3&isTablet=true&maxDeviceWidth=1194&method=call&model=hall&modelType=IPAD8-9&odpAware=true&param=%22zh-AR%22&pathFormat=graph&pixelDensity=2.0&progressive=false&responseFormat=json`;

const myRequest = {
    url: url,
    method: method,
    headers: headers,
    body: body
};

$task.fetch(myRequest).then(response => {
    console.log(response.statusCode + "\n\n" + response.body);
    $done();
}, reason => {
    console.log(reason.error);
    $done();
});
