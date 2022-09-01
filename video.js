
var body = $response.body;


var obj = JSON.parse($response.body); 


obj = {"response":[{"regions":{},"variantDebugInfo":{"abTests":[{"id":5652427186438144,"variantId":6118677561802752,"vars":{"vl_template_editor_experiment_05_2022":"EVDTemplateEditorExperimentVariant1"}},{"id":5227014022823936,"variantId":6133509249892352,"vars":{"highlight_feature_experiment_v_1_19_1":"EVDHighlightExperimentEnabled"}}]},"success":true,"messages":{},"vars":{"vla_system_trial_run_experiment_v2":"Baseline","vl_template_editor_experiment_05_2022":"EVDTemplateEditorExperimentVariant1","highlight_feature_experiment_v_1_19_1":"EVDHighlightExperimentEnabled"},"variants":[{"name":"Overrides","id":6118677561802752,"abTestName":"Template Editor Activation","abTestId":5652427186438144},{"name":"Overrides","id":6133509249892352,"abTestName":"Highlight Tool Activation","abTestId":5227014022823936}],"syncNewsfeed":false,"localCaps":[],"token":"Jsde52WlRnGipPLPudCJfBlAPt92gUyYlpUq1ty7pyE","reqId":"2342D511-D686-4D2D-96A8-3208757E9002"}]}

$done({body:JSON.stringify(obj)});
