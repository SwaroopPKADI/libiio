import ctypes
import ctypes.util
import os


if os.name == "nt":
    _original_find_library = ctypes.util.find_library

    def _find_library(name):
        result = _original_find_library(name)
        if name != "c" or result:
            return result

        for candidate in ("ucrtbase", "msvcrt", "vcruntime140",
                          "api-ms-win-crt-runtime-l1-1-0"):
            try:
                ctypes.CDLL(candidate)
                return candidate
            except OSError:
                continue

        return result

    ctypes.util.find_library = _find_library