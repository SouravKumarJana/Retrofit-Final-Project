import 'package:get/get.dart';
import '../network/network_module.dart';
class DioBinding extends Bindings {
  @override
  void dependencies() {
    NetworkModule.prepareDio();
  }
}
