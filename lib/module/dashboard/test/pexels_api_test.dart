import 'package:evermos_test1/module/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Testing API',
    () async {
      testWidgets('Testing Dashboard', (WidgetTester tester) async{

        await tester.pumpWidget(DashboardScreen());
        
      },);
    },
  );
}
