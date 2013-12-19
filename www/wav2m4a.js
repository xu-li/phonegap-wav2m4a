/**
 * Simple wrapper for wav2m4a
 */
var exec = require('cordova/exec');

/**
 * Convert the wav to m4a
 */
function convert(source, target, success, fail) {
    exec(success, fail, "Wav2M4a", "convert", [source, target]);
};

module.exports.convert = convert;
