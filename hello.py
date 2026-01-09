#!/usr/bin/env python3

import sys
from datetime import datetime


def main() -> str:
    """
    Batch-style application.

    - Emits a timestamped message
    - Exits cleanly on success
    - Returns output for testability
    """
    timestamp = datetime.utcnow().isoformat()
    message = f"[{timestamp}] Hello, DevOps!"
    print(message)
    return message


if __name__ == "__main__":
    try:
        main()
        sys.exit(0)
    except Exception as exc:
        print(f"Application failed: {exc}", file=sys.stderr)
        sys.exit(1)
