-- mylib.lua
local ffi = require("ffi")

-- define C interface
ffi.cdef[[
    int add(int a, int b);
    int multiply(int a, int b);
    char* greet(const char* name);
    void free_string(char* s);
    void mylib_init(void);
]]

local libpath = vim.fn.expand("../../extensions/src/mylib.so")
local mylib = ffi.load(libpath)

mylib.mylib_init()

print("3 + 5 =", mylib.add(3, 5))
print("4 * 7 =", mylib.multiply(4, 7))

local greeting = mylib.greet("Neovim")
print(ffi.string(greeting))

-- WARNING: Must free heaps, or memory will leak.
mylib.free_string(greeting)
