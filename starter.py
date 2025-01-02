import builtins

ALLOWED_MODULES = {"math", "sys", "numpy", "scipy"}  # allowed module list

real_import = builtins.__import__

def restricted_import(name, *args, **kwargs):
    if name not in ALLOWED_MODULES:
        raise ImportError(f"Module '{name}' is not allowed.")
    return real_import(name, *args, **kwargs)

builtins.__import__ = restricted_import