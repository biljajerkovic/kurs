//
//  CityTableViewCell.h
//  Controls
//
//  Created by Djuro Alfirevic on 1/27/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface CityTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (strong, nonatomic) City *city;
@end
