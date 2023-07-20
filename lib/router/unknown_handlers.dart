import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/views/notfound_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class UnknownHandlers {
  static Handler noPageFound = Handler(
    handlerFunc: (context, parameters) {
      Provider.of<SideMenuProvider>(context!, listen: false).setCurrentPageUrl('/404');
      return const NotFoundView();
    },
  );
}
