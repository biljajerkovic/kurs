//
//  DBTask+Utilities.h
//  ToDo
//
//  Created by Biljana on 3/4/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DBTask+CoreDataClass.h"
#import <MapKit/MapKit.h>

@interface DBTask (Utilities) <MKAnnotation>
- (UIColor *)groupColor;
@end
