# -*- coding: utf-8 -*-
"""
Display output of a given script.

Display output of any executable script set by `script_path`.
Only the first two lines of output will be used. The first line is used
as the displayed text. If the output has two or more lines, the second
line is set as the text color (and should hence be a valid hex color
code such as #FF0000 for red).
The script should not have any parameters, but it could work.

Configuration parameters:
    cache_timeout: how often we refresh this module in seconds
        (default 15)
    format: see placeholders below (default '{output}')
    localize: should script output be localized (if available)
        (default True)
    notifications: specify a nested dict to send a notification if matched
        against the keys, see ``Notifications`` section for more information
        (default {})
    script_path: script you want to show output of (compulsory)
        (default None)
    strip_output: shall we strip leading and trailing spaces from output
        (default False)

Format placeholders:
    {line} number of lines in the output
    {output} first line of the output of script given by "script_path"
    {output_full} full output of script given by "script_path"

Notifications:
    Specify a nested dictionary of notification states and options to use.

    Notification states:
        'changed': display a notification only if it is changed
        'click': display a notification of last output on click
        'current': display a current notification regardless

    Notification options:
        'title': notification title
        'msg': notification message
        'level': must be 'info', 'error' or 'warning'.
        'rate_limit': time period in seconds not to be repeated
        'icon': must be an icon path or icon name.

        You can add `format` placeholders in `msg` and `title`.
        The `msg` and `title` options will also be formatted.

Examples:
```
# add a script
external_script {
    format = "my name is {output}"
    script_path = "/usr/bin/whoami"
}

# display changed notifications, same output means no notification
external_script {
    notifications = {'changed': {'msg': '{output}'}}
    script_path = "~/my_script.py"
}

# display current notifications, no output means no notification
external_script {
    notifications = {'current': {'msg': '{output}'}}
    script_path = "~/my_script.py"
}

# display current notification only if output have more than 20 lines
external_script {
    notifications = {'current': {'msg': '\?if=line>20 {output}'}}
    script_path = "~/my_script.py"
}

# display a notification of last full output on click
external_script {
    notifications = {'click': {'msg': '{output_full}'}}
    script_path = "~/my_script.py"
}
```

@author frimdo ztracenastopa@centrum.cz

SAMPLE OUTPUT
{'full_text': 'script output'}

example
{'full_text': 'It is now: Wed Feb 22 22:24:13'}
"""

import re
STRING_ERROR = 'missing script_path'


class Py3status:
    """
    """
    # available configuration parameters
    cache_timeout = 15
    format = '{output}'
    localize = True
    notifications = {}
    script_path = None
    strip_output = False

    def post_config_hook(self):
        if not self.script_path:
            raise Exception(STRING_ERROR)

        self.button_refresh = 2
        self.notification = {'normal': [], 'click': False}
        if self.notifications:
            for x in ['changed', 'click', 'current']:
                self.notification[x] = self.notifications.get(x, False)
                if self.notification[x]:
                    if x in ['changed', 'current']:
                        self.notification['normal'].append(x)
            self.last_changed = self.py3.storage_get('changed')

    def _get_notification(self, state):
        temporary = self.notification[state].copy()
        for x in ['title', 'msg']:
            if x in temporary:
                temporary[x] = self.py3.get_composite_string(
                    self.py3.safe_format(temporary[x], self.script_data)
                )
        return temporary

    def _notify_user(self, state=None):
        if state is None:
            if self.notification['changed']:
                changed = self._get_notification('changed')
                if changed != self.last_changed:
                    self.last_changed = changed
                    self.py3.storage_set('changed', changed)
                    self.py3.notify_user(**changed)
            if self.notification['current']:
                self.py3.notify_user(**self._get_notification('current'))
        elif state == 'click':
            self.py3.notify_user(**self._get_notification('click'))

    def external_script(self):
        output_lines = None
        response = {}
        response['cached_until'] = self.py3.time_in(self.cache_timeout)
        try:
            output_full = self.py3.command_output(
                self.script_path, shell=True, localized=self.localize
            )
            output_lines = output_full.splitlines()
            if len(output_lines) > 1:
                output_color = output_lines[1]
                if re.search(r'^#[0-9a-fA-F]{6}$', output_color):
                    response['color'] = output_color
        except self.py3.CommandError as e:
            # something went wrong show error to user
            output = e.output or e.error
            self.py3.error(output)

        if output_lines:
            output = output_lines[0]
            if self.strip_output:
                output = output.strip()
            # If we get something that looks numeric then we convert it
            # to a numeric type because this can be helpful. for example:
            #
            # external_script {
            #     format = "file is [\?if=output>10 big|small]"
            #     script_path = "cat /tmp/my_file | wc -l"
            # }
            try:
                output = int(output)
            except ValueError:
                try:
                    output = float(output)
                except ValueError:
                    pass
        else:
            output = ''

        self.script_data = {
            'line': len(output_lines),
            'output': output,
            'output_full': ' '.join(output_full.splitlines())
        }
        response['full_text'] = self.py3.safe_format(
            self.format, self.script_data
        )

        self.script_data['output_full'] = output_full
        if self.notification['normal']:
            self._notify_user()

        return response

    def on_click(self, event):
        button = event["button"]
        if button != self.button_refresh:
            if self.notification['click']:
                self._notify_user('click')
            self.py3.prevent_refresh()


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)
