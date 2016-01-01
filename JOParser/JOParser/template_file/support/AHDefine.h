/********************************************************
 *  NSDictionary+MultiKeys.m
 *
 *  Created by J2Objc(Json to objc) on {{date}}.
 *  Copyright (c) 2013 WesleyYang. All rights reserved.
 *
 *  THIS FILE IS AUTO-GENERATED BY J2OBJC. DO NOT TRY TO
 *  MODIFY IT UNLESS YOU ARE NOT RELYING ON J2OBJC FOR
 *  MAKING ANY CHANGES!
 *
 ********************************************************/


//
//  ARC Helper
//
//  Version 1.3
//
//  Created by Nick Lockwood on 05/01/2012.
//  Copyright 2012 Charcoal Design
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://gist.github.com/1563325
//

#ifndef AH_RETAIN
#if __has_feature(objc_arc)
#define AH_RETAIN(x) (x)
#define AH_RELEASE(x) (void)(x)
#define AH_AUTORELEASE(x) (x)
#define AH_SUPER_DEALLOC (void)(0)
#define __AH_BRIDGE __bridge
#else
#define __AH_WEAK
#define AH_WEAK assign
#define AH_RETAIN(x) [(x) retain]
#define AH_RELEASE(x) [(x) release]
#define AH_AUTORELEASE(x) [(x) autorelease]
#define AH_SUPER_DEALLOC [super dealloc]
#define __AH_BRIDGE
#endif
#endif



//  Weak reference support



#ifndef AH_WEAK

#if defined __IPHONE_OS_VERSION_MIN_REQUIRED

#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_4_3

#define __AH_WEAK __weak

#define AH_WEAK weak

#else

#define __AH_WEAK __unsafe_unretained

#define AH_WEAK unsafe_unretained

#endif

#elif defined __MAC_OS_X_VERSION_MIN_REQUIRED

#if __MAC_OS_X_VERSION_MIN_REQUIRED > __MAC_10_6

#define __AH_WEAK __weak

#define AH_WEAK weak

#else

#define __AH_WEAK __unsafe_unretained

#define AH_WEAK unsafe_unretained

#endif

#endif

#endif
//  ARC Helper ends
