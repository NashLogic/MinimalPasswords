#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SQLite 2.h"
#import "SQLite.h"
#import "SQLiteObjc 2.h"
#import "SQLiteObjc.h"

FOUNDATION_EXPORT double SQLiteVersionNumber;
FOUNDATION_EXPORT const unsigned char SQLiteVersionString[];

