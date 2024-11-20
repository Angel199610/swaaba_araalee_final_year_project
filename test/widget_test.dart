import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import your main app file where SwaabaAraaleeApp is defined
import 'package:swaaba_aralee/main.dart'; // Ensure this matches your actual package path

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SwaabaAraaleeApp());

    // Navigate to the SplashScreen if needed (if you're using a navigation flow)
    await tester.pumpAndSettle(); // Wait for animations to finish

    // Find the counter text. Make sure the initial value is '0'
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Trigger a frame to update the UI

    // Verify that our counter has incremented to '1'.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
































// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// // Ensure this path is correct

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(SwaabaAraleeApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
