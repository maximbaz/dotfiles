# -*- coding: utf-8 -*-
"""
Display status of MEGAcmd.

Configuration parameters:
    cache_timeout: refresh interval for this module (default 10)
    format: display format for the module (default "MEGA {format_sync}|No MEGA")
    format_sync: display format for every sync (default "{syncstate}")
    format_sync_separator: show separator if more than one sync (default " ")

Format placeholders:
    {format_sync} Format for every sync returned by 'mega-sync' command.

format_sync placeholders:
    Any column returned by 'mega-sync' command - in lower case!
    For example: id, syncstate, localpath

Requires:
    MEGAcmd: command-line interface for MEGA

@author Maxim Baz (https://github.com/maximbaz)
@license BSD

SAMPLE OUTPUT
{'full_text': 'MEGA Synced'}
"""

STRING_NOT_INSTALLED = "MEGAcmd is not installed"


class Py3status:
    """
    """

    # available configuration parameters
    cache_timeout = 10
    format = "MEGA {format_sync}|No MEGA"
    format_sync = "{syncstate}"
    format_sync_separator = " "

    def post_config_hook(self):
        if not self.py3.check_commands("mega-sync"):
            raise Exception(STRING_NOT_INSTALLED)

    def mega(self):
        output = self.py3.command_output("mega-sync").splitlines()

        format_sync = None
        if len(output) > 0:
            columns = output[0].lower().split()
            megasync_data = []
            for line in output[1:]:
                cells = dict(zip(columns, line.split()))
                megasync_data.append(self.py3.safe_format(self.format_sync, cells))

            format_sync_separator = self.py3.safe_format(self.format_sync_separator)
            format_sync = self.py3.composite_join(format_sync_separator, megasync_data)

        return {
            "cached_until": self.py3.time_in(self.cache_timeout),
            "full_text": self.py3.safe_format(
                self.format, {"format_sync": format_sync}
            ),
        }


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test

    module_test(Py3status)
