An absolute bare-bones web app.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

To run the app from the command line, use webdev to build and serve the app:

`webdev serve`

To view your app, use the Chrome browser to visit the app’s URL — for example, `localhost:8080`.

Whether you use an IDE or the command line, `webdev serve` builds and serves your app using the Dart development compiler, `dartdevc`. Startup is slowest the first time `dartdevc` builds and serves your app. After that, assets are cached on disk and incremental builds are much faster.

Once your app has compiled, the browser should display you app.
