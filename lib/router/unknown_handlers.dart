import 'package:admin_dashboard/ui/views/notfound_view.dart';
import 'package:fluro/fluro.dart';

class UnknownHandlers {
  static Handler noPageFound =
      Handler(handlerFunc: (context, parameters) => const NotFoundView());
}
