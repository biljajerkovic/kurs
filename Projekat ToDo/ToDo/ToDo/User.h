//
//  User.h
//  ToDo
//
//  Created by Biljana on 3/1/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@end
