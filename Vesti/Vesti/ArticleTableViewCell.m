//
//  ArticleTableViewCell.m
//  Vesti
//
//  Created by Biljana on 2/4/17.
//  Copyright © 2017 Biljana. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "UIImageView+Utilities.h"

@implementation ArticleTableViewCell

#pragma mark - Properties

- (void)setArticle:(Article *)article {
    _article = article;
    
    self.titleLabel.text = article.title;
    self.portalLabel.text = article.portal;
    self.coverImageView.layer.cornerRadius = self.coverImageView.frame.size.width/2; //da slika bude krug
    [self.coverImageView loadImageFromURL:article.imageURL];
}
@end
