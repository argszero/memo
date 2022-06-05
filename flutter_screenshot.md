# flutter使用integration_test生成截图

1. 修改flutter源码：
   1. 目录下packages/integration_test/ios/Classes/IntegrationTestPlugin.m
```
--- a/packages/integration_test/ios/Classes/IntegrationTestPlugin.m
+++ b/packages/integration_test/ios/Classes/IntegrationTestPlugin.m
@@ -49,6 +49,7 @@ static NSString *const kMethodRevertImage = @"revertFlutterImage";
   // bundles.  Setup on static variables can be disregarded when a new static
   // instance of IntegrationTestPlugin is allocated when the bundle is reloaded.
   // See also: https://github.com/flutter/plugins/pull/2465
+  [[IntegrationTestPlugin instance] setupChannels:registrar.messenger];
 }
```
2. 添加依赖
```
--- a/pubspec.yaml
+++ b/pubspec.yaml
@@ -38,6 +38,8 @@ dependencies:
 dev_dependencies:
   flutter_test:
     sdk: flutter
+  integration_test:
+    sdk: flutter
```
3. 创建driver（从模拟器下载截图）：在lib平级目录下，创建test_driver，在test_driver目录下新建文件integration_test.dart
```
import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
      final File image =
          await File('screenshots/$screenshotName.png').create(recursive: true);
      image.writeAsBytesSync(screenshotBytes);
      return true;
    },
  );
}


```
1. 创建测试类: 在lib平级目录下，创建integration_test，在integration_test目录下新建文件screenshot_test.dart
```
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  testWidgets('screenshot', (WidgetTester tester) async {
    // Build the app.
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('screenshot-0');

    // Finds the floating action button to tap on.
    final Finder fab = find.byTooltip('Increment');

    // Emulate a tap on the floating action button.
    await tester.tap(fab);

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Verify the counter increments by 1.
    expect(find.text('1'), findsOneWidget);

    await binding.takeScreenshot('screenshot-1');
  });
}


```
3. 运行

```
flutter drive \           
  --driver=test_driver/integration_test.dart \
  --target=integration_test/screenshot_test.dart
```