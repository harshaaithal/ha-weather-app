import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ha_weather_app/main.dart';

void main() {
  testWidgets('App loads without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: WeatherApp(),
      ),
    );

    // Verify the app loads (loading state is shown)
    expect(find.text('Getting weather...'), findsOneWidget);
  });
}
