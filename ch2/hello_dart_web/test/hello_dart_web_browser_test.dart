@OnPlatform( {
  // Give Windows some extra wiggle-room before timing out.
  'windows': Timeout.factor(2)
})
import 'dart:io';

import 'package:test/test.dart';
import 'package:webdriver/io.dart';

void main() {
  Process webDriverServer;
  WebDriver webDriver;

  setUpAll(() async {
//     caps = webdriver.DesiredCapabilities.CHROME.copy()
// caps['acceptInsecureCerts'] = True
// driver = webdriver.Chrome(desired_capabilities=caps)
    // webDriverServer = await Process.start('chromedriver', ['']);
    webDriverServer = await Process.start('geckodriver', []);
    
    // webDriver = await createDriver(
    //     uri: Uri.parse('http://localhost:9515'), desired: Capabilities.chrome);
         webDriver = await createDriver(
        uri: Uri.parse('http://localhost:4444'), desired: Capabilities.firefox);
  });

  // lounch chromedriver

  tearDown(() async {
    await webDriver.quit();
    webDriverServer.kill();

  });

  //test methods are here

  test('print: Hello Dart for Web', () async {
    await webDriver.get('http://localhost:8080/hello_dart_web_test.html');
    Timeout(Duration(seconds: 10));
  
    final h1 = await webDriver.findElement(By.tagName('h1'));
    
    expect(await h1.text, 'Hello Dart for Web');
  }
  // ,timeout: Timeout(Duration(seconds: 2))
  );

  // to run tests
  // run from a command line
  // "pub run test"
  // pub run -r expanded -p vm
  //chromedriver --port=4444 --url-base=wd/hub --verbose
// geckodriver --port=4445
}
