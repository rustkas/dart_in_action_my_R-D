define(['dart_sdk'], function(dart_sdk) {
  'use strict';
  const core = dart_sdk.core;
  const html = dart_sdk.html;
  const dart = dart_sdk.dart;
  const dartx = dart_sdk.dartx;
  var main = Object.create(dart.library);
  var $_get = dartx._get;
  const CT = Object.create(null);
  main.main = function main$() {
    let text = "Hello Dart for Web";
    let h1 = html.Element.as(html.document.getElementsByTagName("h1")[$_get](0));
    h1.innerText = text;
  };
  dart.trackLibraries("web/main", {
    "org-dartlang-app:///web/main.dart": main
  }, {
  }, '{"version":3,"sourceRoot":"","sources":["main.dart"],"names":[],"mappings":";;;;;;;;;;AAGM,eAAO;AACH,6BAAK,AAAS,AAA0B,mCAAL,aAAM;AAC9B,IAAnB,AAAG,EAAD,aAAa,IAAI;EAErB","file":"main.ddc.js"}');
  // Exports:
  return {
    web__main: main
  };
});

//# sourceMappingURL=main.ddc.js.map
