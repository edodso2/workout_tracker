import './model_tests/all_model_tests.dart' as model_tests;
import './service_tests/all_service_tests.dart' as service_tests;
import './widget_tests/all_widget_tests.dart' as widget_tests;
import './router_param_parser_test.dart' as router_parser_test;

main() {
  model_tests.main();
  service_tests.main();
  widget_tests.main();
  router_parser_test.main();
}
