//
//  UIImageView+Utilities.m
//  Vesti
//
//  Created by Biljana on 2/4/17.
//  Copyright © 2017 Biljana. All rights reserved.
//

#import "UIImageView+Utilities.h"

@implementation UIImageView (Utilities)

#pragma mark - Public API

- (void)loadImageFromURL:(NSString *)url {
    dispatch_queue_t downloadQueue = dispatch_queue_create("ImageDownloader", NULL);
    //asinhrono po tom queue downloaduj sliku
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    });
}
@end
