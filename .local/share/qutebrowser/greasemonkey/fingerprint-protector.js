// ==UserScript==
// @run-at document-start
// ==/UserScript==

(function () {
  "use strict";

  const userAgent =
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.5304.87 Safari/537.36";
  const appVersion = userAgent.substr(8);

  Object.defineProperty(window.navigator, "userAgent", {
    value: userAgent,
  });
  Object.defineProperty(window.navigator, "appVersion", {
    value: appVersion,
  });
  Object.defineProperty(window.navigator, "platform", {
    value: "Win32",
  });
})();
