//
//  GOTArticleCell.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 10/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "ArticleCell.h"
#import "Article.h"
#import "JRRxHttpClient.h"
#import "UIImageView+Geometry.h"

@interface ArticleCell ()

@property (nonatomic, strong) Article *article;

@end

@implementation ArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)bindViewModel:(id)viewModel {
    @weakify(self)
    Article *article = viewModel;
    self.article = article;
    
    self.titleLabel.text = article.title;
    self.subtitleLabel.text = article.abstract;
    
    if (![article.thumbnail isEqual:[NSNull null]]) {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        [[[JRRxHttpClient sharedClient] fetchImageFromUrl:[NSURL URLWithString:article.thumbnail] placheholderImage:self.image] subscribeCompleted:^{
            @strongify(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.image rounded];
            });
        }];
    }
}

@end
