//
//  Bookmark.m
//  Browser
//
//  Created by Biljana on 3/10/17.
//  Copyright © 2017 Biljana. All rights reserved.
//

#import "Bookmark.h"

@implementation Bookmark

- (instancetype)initWithTitle:(NSString *)title andURL:(NSString *)url {
    if (self = [super init]) { //ja bookmark pozivam svoj super tj nsobject tj inicijalizujem se kao nsobject
        self.title = title; // i dodajem title i url
        self.url = url;
    }
    return self;
}
@end
