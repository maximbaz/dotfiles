// ==UserScript==
// @run-at document-start
// ==/UserScript==

(function () {
  "use strict";

  const userAgent =
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36";
  const version = userAgent.substr(8);

  window.navigator.__defineGetter__("appVersion", function () {
    return version;
  });
  window.navigator.__defineGetter__("platform", function () {
    return "Win32";
  });
  window.navigator.__defineGetter__("userAgent", function () {
    return userAgent;
  });
})();
