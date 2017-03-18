//
//  Constants.h
//  ToDo
//
//  Created by Biljana on 2/24/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// Enums
typedef NS_ENUM(NSInteger, TaskGroup) {
    TaskGroupComplited = 1,
    TaskGroupNotComplited,
    TaskGroupInProgress
};

// Constants
#define kAnimationDuration  0.3f
#define kSpanDelta          0.5f
#define kMenuOffset         100.0f
static NSString *const DATE_FORMAT = @"yyyy-MM-dd";

// Macros
#define DATA_MANAGER [DataManager sharedManager]
#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// Colors
#define kColorCompleted     COLOR(73.0,211.0,194.0,1.0)
#define kColorNotComplited  COLOR(254.0,172.0,73.0,1.0)
#define kColorInProgress    COLOR(187.0,114.0,255.0,1.0)

// Notifications
static NSString *const LOCALITY_UPDATED_NOTIFICATION    = @"LOCALITY_UPDATED_NOTIFICATION";
static NSString *const OPEN_SIDE_MENU_NOTIFICATION      = @"OPEN_SIDE_MENU_NOTIFICATION";
static NSString *const CLOSE_SIDE_MENU_NOTIFICATION     = @"CLOSE_SIDE_MENU_NOTIFICATION";
static NSString *const OPEN_VC_NOTIFICATION             = @"OPEN_VC_NOTIFICATION";


// User defaults
static NSString *const USER_IMAGE = @"USER_IMAGE";
static NSString *const USER_UD =    @"USER_UD";

#endif /* Constants_h */
