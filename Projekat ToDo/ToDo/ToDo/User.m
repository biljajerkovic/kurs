//
//  User.m
//  ToDo
//
//  Created by Biljana on 3/1/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "User.h"

@implementation User

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
}

@end
