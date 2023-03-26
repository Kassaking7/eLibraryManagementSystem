"use strict";
/*
 * ATTENTION: An "eval-source-map" devtool has been used.
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file with attached SourceMaps in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
(() => {
var exports = {};
exports.id = "pages/api/email";
exports.ids = ["pages/api/email"];
exports.modules = {

/***/ "emailjs":
/*!**************************!*\
  !*** external "emailjs" ***!
  \**************************/
/***/ ((module) => {

module.exports = import("emailjs");;

/***/ }),

/***/ "(api)/./pages/api/email.js":
/*!****************************!*\
  !*** ./pages/api/email.js ***!
  \****************************/
/***/ ((module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.a(module, async (__webpack_handle_async_dependencies__, __webpack_async_result__) => { try {\n__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => (/* binding */ handler)\n/* harmony export */ });\n/* harmony import */ var emailjs__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! emailjs */ \"emailjs\");\nvar __webpack_async_dependencies__ = __webpack_handle_async_dependencies__([emailjs__WEBPACK_IMPORTED_MODULE_0__]);\nemailjs__WEBPACK_IMPORTED_MODULE_0__ = (__webpack_async_dependencies__.then ? (await __webpack_async_dependencies__)() : __webpack_async_dependencies__)[0];\n\nfunction handler(req, res) {\n    res.status(200).end(JSON.stringify({\n        message: \"Send Mail\"\n    }));\n}\n\n__webpack_async_result__();\n} catch(e) { __webpack_async_result__(e); } });//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiKGFwaSkvLi9wYWdlcy9hcGkvZW1haWwuanMuanMiLCJtYXBwaW5ncyI6Ijs7Ozs7Ozs7QUFBcUM7QUFFdEIsU0FBU0MsUUFBUUMsR0FBRyxFQUFFQyxHQUFHLEVBQUU7SUFDdENBLElBQUlDLE1BQU0sQ0FBQyxLQUFLQyxHQUFHLENBQUNDLEtBQUtDLFNBQVMsQ0FBQztRQUFFQyxTQUFRO0lBQVk7QUFDN0QsQ0FBQyIsInNvdXJjZXMiOlsid2VicGFjazovL2xvZ2luLXRlc3QvLi9wYWdlcy9hcGkvZW1haWwuanM/ODkyMyJdLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgeyBTTVRQQ2xpZW50IH0gZnJvbSAnZW1haWxqcyc7XG5cbmV4cG9ydCBkZWZhdWx0IGZ1bmN0aW9uIGhhbmRsZXIocmVxLCByZXMpIHtcbiAgICByZXMuc3RhdHVzKDIwMCkuZW5kKEpTT04uc3RyaW5naWZ5KHsgbWVzc2FnZTonU2VuZCBNYWlsJyB9KSlcbn0iXSwibmFtZXMiOlsiU01UUENsaWVudCIsImhhbmRsZXIiLCJyZXEiLCJyZXMiLCJzdGF0dXMiLCJlbmQiLCJKU09OIiwic3RyaW5naWZ5IiwibWVzc2FnZSJdLCJzb3VyY2VSb290IjoiIn0=\n//# sourceURL=webpack-internal:///(api)/./pages/api/email.js\n");

/***/ })

};
;

// load runtime
var __webpack_require__ = require("../../webpack-api-runtime.js");
__webpack_require__.C(exports);
var __webpack_exec__ = (moduleId) => (__webpack_require__(__webpack_require__.s = moduleId))
var __webpack_exports__ = (__webpack_exec__("(api)/./pages/api/email.js"));
module.exports = __webpack_exports__;

})();