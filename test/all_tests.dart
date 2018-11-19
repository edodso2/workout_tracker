import './model_tests/all_model_tests.dart' as modelTests;
import './service_tests/all_service_tests.dart' as serviceTests;
import './widget_tests/all_widget_tests.dart' as widgetTests;
import './router_param_parser_test.dart' as routerParserTest;

main() {
  modelTests.main();
  serviceTests.main();
  widgetTests.main();
  routerParserTest.main();
}