"""Display editable command references, then hand control to the user's shell."""

import argparse
import os
from pathlib import Path
import shlex


REFERENCE = Path(__file__).resolve().with_name("commands.md")
GROUPS = {"performance": ("cpu", "gpu"), "networking": ("wifi", "network", "bluetooth")}


def sections():
    result = {}
    for section in REFERENCE.read_text().split("\n## ")[1:]:
        name, _, body = section.partition("\n")
        result[name.strip()] = body.strip()
    return result


def main():
    entries = sections()
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("topic", choices=["all", *GROUPS, *entries], default="all", nargs="?")
    parser.add_argument("--print", action="store_true", dest="print_only",
                        help="Print the reference without starting a shell")
    args = parser.parse_args()
    topics = entries if args.topic == "all" else GROUPS.get(args.topic, (args.topic,))
    print("COMMAND GLOSSARY — run commands manually\n")
    print("Replace uppercase placeholders (ID, PID, SSID, etc.) with your values.")
    print("Some optional tools may need installing. Use man COMMAND for more help.")
    for topic in topics:
        print(f"\n{topic.upper()}\n{'=' * len(topic)}\n{entries[topic]}\n")
    print(f"Edit entries: {REFERENCE}")
    print(f"Show again: python3 {shlex.quote(str(Path(__file__).resolve()))} {args.topic} --print")
    print("\nScroll up to consult the reference. Type commands below; exit closes this window.", flush=True)
    if not args.print_only:
        shell = os.environ.get("SHELL") or "/bin/sh"
        os.chdir(Path.home())
        os.execv(shell, [shell, "-i"])


if __name__ == "__main__":
    main()
