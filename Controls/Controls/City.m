//
//  City.m
//  Controls
//
//  Created by Djuro Alfirevic on 1/27/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "City.h"

@implementation City

#pragma mark - Designated Initializer

- (instancetype)initWithName:(NSString *)name population:(NSString *)population {
    self = [super init];
    if (self) {
        self.name = name;
        self.population = population;
    }
    
    return self;
}

@end
