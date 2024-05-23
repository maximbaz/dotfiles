#!/bin/sh
':' //; exec "$(command -v nodejs || command -v node)" "$0" "$@"

var spawn = require('child_process').spawn;
var exec  = require('child_process').exec;

var env       = process.env;
var $LAUNCHER = env.UDISKIE_DMENU_LAUNCHER || 'dmenu';

main();

function main() {
    runCommand(`udiskie-info -C -a -o '"label":"{ui_label}", "isLuks":"{is_luks}", "mountPath": "{mount_path}"'`, function(err, blockDevices) {
        if (err) {
            return notifyIfErr(err);
        }

        var options = parseUdiskieInfo(blockDevices);

        if (Object.keys(options).length === 0) {
            notifyIfErr(`Nothing to unmount / mount`);
            process.exit(0);
        }

        getSelection(prettyPrint(options), function(err, selection, code) {

            if (err) {
                console.error(err);
                return notifyIfErr(err);
            } else if (!selection) {
                return;
            }

            selection = parseSelection(selection);

            var targets = [];

            Object.keys(selection).forEach(function(path) {
                Object.keys(options).forEach(function(p, index, keys) {
                    var isTheOnlyDevPath = keys.reduce(function(outcome, key, i) {
                        if (!outcome) return outcome;
                        if (~p.indexOf(path) && i !== index) return false;

                        return true;
                    }, true);

                    if (~p.indexOf(path)) {
                        if (p.match(/^\/dev\/sd[a-z]{1}\d{1}$/)
                            || isTheOnlyDevPath
                        ) {
                            targets.push(options[p]);
                        }
                    }
                });
            });

            targets.forEach(function(device) {
                var udiskieOpt = code === 10 ? '--detach' : '';

                if (device.mountPath) {
                    if (device.isLuks) {
                        udiskieOpt += '--force';
                    }
                    //
                    return runCommand(`udiskie-umount ${udiskieOpt} "${device.mountPath}"`, notifyIfErr);
                } else if (device.label) {
                    if (device.isLuks) {
                        udiskieOpt += '--recursive';
                    }
                    //
                    return runCommand(`udiskie-mount ${udiskieOpt} "${device.devPath}"`, notifyIfErr);
                } else {
                    notifyIfErr(`Unknown device - aborting`);
                }
            });
        });
    });
}

/**
 * @param {Object} parsedUdiskieInfo - output of parseUdiskieInfo
 *
 * @return {String}
 */
function prettyPrint(parsedUdiskieInfo) {
    var out = '';

    Object.keys(parsedUdiskieInfo).forEach(function(devPath) {
        var device = parsedUdiskieInfo[devPath];

        //align first column to the left side
        if (devPath.length < 9) {
            devPath = stretchStr(devPath, 9);
        }

        out += `${devPath}:  ${device.mountPath || device.label}\n`;
    });

    return out;

    function stretchStr(str, len) {
        for (var i = 0, len = len - str.length; i < len; i++) {
            str += ' ';
        }
        return str;
    }
}

/**
 * @param {Error} err
 *
 * @return {undefined}
 */
function notifyIfErr(err) {
    if (!err) {
        return
    }

    err = (err.message && err.message || err);

    return runCommand(`notify-send "${err}"`, function(err) {
        if (err) {
            console.error(err);
        }
        process.exit(1);
    });
}

/**
 * @param {String} str
 * @return {Object}
 */
function parseUdiskieInfo(str) {
    var out = {}

    str.split('\n').forEach(function(device) {
        if (!device) {
            return;
        }

        var data, labelOrMountPath, mountPath, label, deviceInfo;
        data = JSON.parse(`{${device}}`);
        deviceInfo = data.label.split(':');
        data.devPath = (deviceInfo.shift() || '').trim();
        data.label = (deviceInfo.shift() || '').trim();
        data.isLuks = data.isLuks && JSON.parse(data.isLuks.toLowerCase());

        var key = data.devPath.trim();

        if (out.hasOwnProperty(key) && out[key].mountPath && !data.mountPath) {
            return;
        } else if (out.hasOwnProperty(key) && out[key].isLuks && !data.isLuks) {
            return;
        } else if (key.startsWith('/dev/loop')) { // Filter snap packages
            return;
        }


        out[key] = data;
    });

    return out;
}

/**
 * @param {String} str
 * @return {Object}
 */
function parseSelection(str) {
    var out = {}

    str.split('\n').forEach(function(device) {
        var data = device.split(':');
        var devicePath = data[0];
        var labelOrMountPath = data[1];

        var re = devicePath.trim().match(/^\/dev\/sd[a-z]{1}\d{0,1}$/i);
        var found = devicePath.trim().match(re);

        if (found) {
            out[devicePath.trim()] = labelOrMountPath.trim();
        }
    });

    return out;
}

/**
 * runCommand
 *
 * @param {string} command - stdout from dmenu
 *
 * @callback(err, dataString)
 */
function runCommand(command, callback) {

    exec(command, function(error, stdout, stderr) {
        if (stderr) {
            console.error(command + ' error: ' + stderr.toString());
            return callback(error);
        }

        if (error) {
            console.error(error);
            return callback(error);
        }
        return callback(null, stdout);
    });
}

/**
 * getSelection
 *
 * @param {String} data - options to choose from
 *
 * @callback(err, selection)
 * @return {undefined}
 */
function getSelection(data, callback) {
    var stdout;
    var stderr
    var dmenu = spawn($LAUNCHER, process.argv.slice(2));

    dmenu.stdin.write(data);
    dmenu.stdin.end();

    dmenu.stdout.on('data', function (data) {    // register one or more handlers
        stdout = data.toString().trim();
    });

    dmenu.stderr.on('data', function (data) {
        stderr = data;
        console.error('dmenu error: ' + data.toString());
    });

    dmenu.on('exit', function (code) {
        //status: 10 => custom keybinding for --detach option
        if (code !== 0 && code !== 10 && (stdout || stderr)) {
            console.error('dmenu returned with code ' + code);
            return callback(code);
        }
        return callback(undefined, stdout, code);
    });
}
