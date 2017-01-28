//
//  City.h
//  Controls
//
//  Created by Djuro Alfirevic on 1/27/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *population;
- (instancetype)initWithName:(NSString *)name population:(NSString *)population;
@end
