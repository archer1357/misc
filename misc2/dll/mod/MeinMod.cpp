
#ifdef _MSC_VER
#pragma comment(lib, "Gdi32.lib")
#pragma comment(lib, "User32.lib")
#pragma comment(lib, "Kernel32.lib")
#endif

//
#define WIN32_LEAN_AND_MEAN
#define WIN32_WINNT 0x0501

#ifndef WINVER
#define WINVER 0x0501
#endif

//
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <stdint.h>

#if defined(_MSC_VER)
#define snprintf _snprintf
#endif

#ifndef __cplusplus
#include <stdbool.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>

#ifndef __cplusplus
extern "C" {
#endif

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#ifndef __cplusplus
}
#endif

#define DllExport   __declspec( dllexport )



//extern "C"
DllExport
 int abc() {
    printf("wwwat\n");

    //
    return 10;
}
