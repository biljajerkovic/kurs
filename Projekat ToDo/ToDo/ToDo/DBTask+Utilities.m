//
//  DBTask+Utilities.m
//  ToDo
//
//  Created by Biljana on 3/4/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DBTask+Utilities.h"

@implementation DBTask (Utilities)

#pragma mark - Public API

- (UIColor *)groupColor {
    if (self.group == TaskGroupComplited) {
        return kColorCompleted;
    } else if (self.group == TaskGroupNotComplited) {
        return kColorNotComplited;
    } else {
        return kColorInProgress;
    }
}
@end
