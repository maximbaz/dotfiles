# -*- coding: utf-8 -*-
"""
Allow, Block, and Reject USB devices.

USBGuard is a software framework for implementing USB device authorization
policies. For best results, don't add Reject option and to use filters too.

Configuration parameters:
    filters: specify a list of filters: [None, 'allow', 'block', 'reject']
        (default [])
    format: display format for this module
        (default '[{format_device} ]{format_button_filter}')
    format_action_allow: display format for allow action filter
        (default '\?color=good \[Allow\]')
    format_action_block: display format for block action filter
        (default '\?color=degraded \[Block\]')
    format_action_reject: display format for reject action filter
        (default '\?color=bad \[Reject\]')
    format_button_filter: display format for filter button
        (default '[{filter}|\?show ALL]')
    format_button_permanent: display format for permanent button
        (default '[\?if=permanent&color=white \[P\]|\?color=darkgray \[P\]]')
    format_device: display format for USB devices
        *(default '[{name}|Unknown {id} [\?color=darkgray {usb_id}]]'
        '[ {format_action_allow}][ {format_action_block}]')*
    format_device_separator: show separator if more than one (default ' ')
    format_notification_message: specify notification message to use
        *(default 'USB ID: {usb_id}\nName: {name}\nPort: {port}')*
    format_notification_title: specify notification title to use
        *(default 'USB Device [\?if=policy=allow Allowed]'
        '[\?if=policy=block Blocked][\?if=policy=reject Rejected]')*
    permanent: specify behavior to use, otherwise auto False (default None)

Format placeholders:
    {device}                  number of USB devices
    {format_button_filter}    button to toggle USB device display filters
    {format_button_permanent} button to toggle permanent states
    {format_device}           format for USB devices

format_button_filter:
    {filter}      USB device filter, eg None, allow, block, reject

format_button_permanent:
    {permanent}   permanent boolean, eg False, True

format_device:
    {id}          eg 1, 2, 5, 6, 7, 22, 23, 33
    {policy}      eg allow, block, reject
    {usb_id}      eg 054c:0268
    {name}        eg Poker II, PLAYSTATION(R)3 Controller
    {serial}      eg 0000:00:00.0
    {port}        eg usb1, usb2, usb3, 1-1, 4-1.2.1
    {interface}   eg 00:00:00:00 00:00:00 00:00:00
    {hash}        eg ihYz60+8pxZBi/cm+Q/4Ibrsyyzq/iZ9xtMDAh53sng
    {parent_hash} eg npSDT1xuEIOSLNt2RT2EbFrE8XRZoV29t1n7kg6GxXg

format_notification_message:
    See `format_device`

format_notification_title:
    See `format_device`

Requires:
    pydbus: pythonic dbus library
    python-gobject: pythonic binding for gobject
    usbguard: USB device authorization policy framework

Examples:
```
# specify a list of filters - easy copy and paste
usbguard {
    filters = ['block']
    filters = ['block', None]
    filters = ['block', 'allow']
    filters = ['block', 'allow', None]
}

# different button filters
usbguard {
    format_button_filter = '[\?if=filter=allow \[a\]]'
    format_button_filter += '[\?if=filter=block \[b\]]'
    format_button_filter += '[\?if=filter=reject \[r\]]'
    format_button_filter += '[\?if=!filter \[*\]]'
}

# show block device only, hide button
usbguard {
    format_button_filter = ''
    filters = ['block']
}
```

@author Cyril Levis (@cyrinux)
@license BSD

SAMPLE OUTPUT
[
    {'full_text': 'Poker II '},
    {'full_text': 'Allow ', 'color': '#00ff00'},
    {'full_text': 'Block ', 'color': '#ffff00'},
    {'full_text': 'Reject', 'color': '#ff0000'},
]

filters
[
    {'full_text': 'PLAYSTATION(R)3 Controller '},
    {'full_text': 'Allow ', 'color': '#00ff00'},
    {'full_text': 'Block', 'color': '#ffff00'},
]

unknown
[
    {'full_text': 'Unknown 12 '},
    {'full_text': '8087:0024 ', 'color': '#a9a9a9'},
    {'full_text': 'Allow ', 'color': '#00ff00'},
    {'full_text': 'Block', 'color': '#ffff00'},
]
"""

import threading
from gi.repository import GLib
from pydbus import SystemBus
import re

STRING_USBGUARD_DBUS = "start usbguard-dbus.service"


class UsbguardListener(threading.Thread):
    """
    """

    def __init__(self, parent):
        super(UsbguardListener, self).__init__()
        self.parent = parent

    def _on_devices_policy_changed(self, *event):
        self.parent.py3.update()

    def _on_devices_presence_changed(self, *event):
        self.parent.py3.update()

    def run(self):
        while not self.parent.killed.is_set():
            self.parent._init_dbus()

            self.parent.dbus.subscribe(
                object="/org/usbguard/Devices",
                signal="DevicePolicyChanged",
                signal_fired=self._on_devices_policy_changed,
            )

            self.parent.dbus.subscribe(
                object="/org/usbguard/Devices",
                signal="DevicePresenceChanged",
                signal_fired=self._on_devices_presence_changed,
            )

            self.loop = GLib.MainLoop()
            self.loop.run()


class Py3status:
    """
    """

    filters = []
    format = "[{format_device} ]{format_button_filter}"
    format_action_allow = "\?color=good \[Allow\]"
    format_action_block = "\?color=degraded \[Block\]"
    format_action_reject = "\?color=bad \[Reject\]"
    format_button_filter = "[{filter}|\?show ALL]"
    format_button_permanent = (
        "[\?if=permanent&color=white \[P\]|\?color=darkgray \[P\]]"
    )
    format_device = (
        "[{name}|Unknown {id} [\?color=darkgray {usb_id}]]"
        "[ {format_action_allow}][ {format_action_block}]"
    )
    format_device_separator = " "
    format_notification_message = "USB ID: {usb_id}\nName: {name}\nPort: {port}"
    format_notification_title = (
        "USB Device [\?if=policy=allow Allowed]"
        "[\?if=policy=block Blocked]"
        "[\?if=policy=reject Rejected]"
    )
    permanent = None

    def post_config_hook(self):
        self.init = {
            "format_action": self.py3.get_placeholders_list(
                self.format_device, "format_action_*"
            ),
            "notifications": (
                self.format_notification_title or self.format_notification_message
            ),
            "permanent": self.permanent is None,
            "target": {"allow": 0, "block": 1, "reject": 2},
        }

        self.active_index = 0
        self.length = len(self.filters)
        self.permanent = self.permanent or False

        self.keys = [
            ("serial", re.compile(r"\S*serial \"(\S+)\"\S*")),
            ("policy", re.compile(r"^(\S+)")),
            ("usb_id", re.compile(r"id (\S+)")),
            ("name", re.compile(r"name \"(.*)\" hash")),
            ("hash", re.compile(r"hash \"(.*)\" parent-hash")),
            ("parent_hash", re.compile(r"parent-hash \"(.*)\" via-port")),
            ("port", re.compile(r"via-port \"(.*)\" with-interface")),
            ("interface", re.compile(r"with-interface \{ (.*) \}$")),
        ]

        self._init_dbus()
        self.killed = threading.Event()
        UsbguardListener(self).start()

    def _init_dbus(self):
        self.dbus = SystemBus()
        try:
            self.proxy = self.dbus.get("org.usbguard", "/org/usbguard/Devices")
        except Exception:
            raise Exception(STRING_USBGUARD_DBUS)

    def _get_devices(self):
        devices = self.proxy.listDevices("match")
        new_device = []
        for device_id, string in devices:
            device = {"id": device_id}
            for name, regex in self.keys:
                value = regex.findall(string) or None
                if value:
                    value = value[0]
                    value = value.encode("latin-1").decode("unicode_escape")
                    value = value.encode("latin-1").decode("utf-8")
                device[name] = value
            new_device.append(device)

        return new_device

    def _manipulate_devices(self, data):
        new_device = []
        try:
            action = self.filters[self.active_index]
        except IndexError:
            action = None
        for device in data:
            if action and device["policy"] not in action:
                continue
            for x in self.init["format_action"]:
                composite = self.py3.safe_format(getattr(self, x), device)
                device[x] = self.py3.composite_update(
                    composite, {"index": "{}/{}".format(device["id"], x.split("_")[-1])}
                )

            new_device.append(self.py3.safe_format(self.format_device, device))

        format_device_separator = self.py3.safe_format(self.format_device_separator)
        format_device = self.py3.composite_join(format_device_separator, new_device)

        return format_device, action

    def _notify_user(self, device):
        format_notification_message = self.py3.safe_format(
            self.format_notification_message, device
        )
        format_notification_title = self.py3.safe_format(
            self.format_notification_title, device
        )
        self.py3.notify_user(
            msg=format_notification_message,
            title=format_notification_title,
            icon="/usr/share/icons/hicolor/scalable/apps/usbguard-icon.svg",
        )

    def usbguard(self):
        self.devices = self._get_devices()
        format_device, device_filter = self._manipulate_devices(self.devices)

        format_button_filter = self.py3.safe_format(
            self.format_button_filter, {"filter": device_filter}
        )
        self.py3.composite_update(format_button_filter, {"index": "button_filter"})
        format_button_permanent = self.py3.safe_format(self.format_button_permanent)
        self.py3.composite_update(
            format_button_permanent, {"index": "button_permanent"}
        )

        usbguard_data = {
            "device": len(self.devices),
            "format_button_filter": format_button_filter,
            "format_button_permanent": format_button_permanent,
            "format_device": format_device,
        }

        return {
            "cached_until": self.py3.CACHE_FOREVER,
            "full_text": self.py3.safe_format(self.format, usbguard_data),
            "urgent": True,
        }

    def kill(self):
        self.killed.set()

    def on_click(self, event):
        index = event["index"]
        if isinstance(index, int):
            return
        elif index == "button_filter":
            if self.length > 1:
                self.active_index += 1
                if self.active_index >= self.length:
                    self.active_index = 0
        elif index == "button_permanent":
            self.permanent = not self.permanent
        else:
            device_id, policy_name = index.split("/")
            device_id = int(device_id)

            if self.init["notifications"]:
                for device in self.devices:
                    if device["id"] == device_id:
                        break
                device["policy"] = policy_name
                self._notify_user(device)

            policy = self.init["target"][policy_name]
            self.proxy.applyDevicePolicy(device_id, policy, self.permanent)

            if self.init["permanent"]:
                self.permanent = False


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test

    module_test(Py3status)
