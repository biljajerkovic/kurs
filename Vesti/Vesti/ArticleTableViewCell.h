//
//  ArticleTableViewCell.h
//  Vesti
//
//  Created by Biljana on 2/4/17.
//  Copyright © 2017 Biljana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *portalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) Article *article;
@end
