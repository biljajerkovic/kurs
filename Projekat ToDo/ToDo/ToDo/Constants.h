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
#define kAnimationDuration 0.3f

// Notifications
static NSString *const LOCALITY_UPDATED_NOTIFICATION = @"LOCALITY_UPDATED_NOTIFICATION";

// User defaults
static NSString *const USER_IMAGE = @"USER_IMAGE";
static NSString *const USER_UD = @"USER_UD";

#endif /* Constants_h */
