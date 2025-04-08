import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('image_gallery_saver');
  final List<MethodCall> log = <MethodCall>[];
  bool? response;

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (message) async {
    log.add(message);
    return response;
  });

  tearDown(() {
    log.clear();
  });

  test('saveImageToGallery test', () async {
    response = true;
    Uint8List imageBytes = Uint8List(16);
    final bool? result = await ImageGallerySaver.saveImage(imageBytes);
    expect(
      log,
      <Matcher>[
        isMethodCall(
          'saveImageToGallery',
          arguments: <String, dynamic>{
            'imageBytes': imageBytes,
            'quality': 100,
            'name': null,
            "isReturnImagePathOfIOS": false,
          },
        ),
      ],
    );
    expect(result, response);
  });
}
