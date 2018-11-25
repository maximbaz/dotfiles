#!/usr/bin/env python

from subprocess import Popen, PIPE


def main(args):
    p1 = Popen(["ssh", "mse", "~/get-vms"], stdout=PIPE)
    p2 = Popen(["fzy", "-l", "999"], stdin=p1.stdout, stdout=PIPE)
    vm, _ = p2.communicate()
    return vm.decode("utf-8").strip()


def handle_result(args, vm, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    if window is not None:
        window.paste(vm)


if __name__ == "__main__":
    import sys

    print(main(sys.argv))
