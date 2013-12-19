/**
 * Simple wrapper for wav2m4a
 */
var exec = require('cordova/exec');

/**
 * Convert the wav to m4a
 *
 * Usage: wav2m4a.convert(src, target, function () { alert('Success!'); });
 */
function convert(source, target, success, fail) {
    exec(success, fail, "Wav2M4a", "convert", [source, target]);
};

module.exports.convert = convert;
