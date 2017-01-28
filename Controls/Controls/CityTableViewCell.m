//
//  CityTableViewCell.m
//  Controls
//
//  Created by Djuro Alfirevic on 1/27/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "CityTableViewCell.h"

@interface CityTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@end

@implementation CityTableViewCell

#pragma mark - Properties

- (void)setCity:(City *)city {
    _city = city;
    
    self.titleLabel.text = city.name;
    self.subtitleLabel.text = city.population;
}

@end
