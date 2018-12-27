var exec = require('cordova/exec');
exports.faceLiveness = function(arg0, success, error) {
  exec(success, error, 'callFacePlugin', 'FaceLivenessExp', [arg0]);
};
exports.faceDetect = function(arg0, success, error) {
  exec(success, error, 'callFacePlugin', 'FaceDetectExp', [arg0]);
};
