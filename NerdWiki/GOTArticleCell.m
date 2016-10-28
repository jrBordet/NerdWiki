//
//  GOTArticleCell.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 10/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTArticleCell.h"
#import "GOTArticle.h"
#import "JRRxHttpClient.h"

@interface GOTArticleCell ()

@property (nonatomic, strong) GOTArticle *article;

@end

@implementation GOTArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)bindViewModel:(id)viewModel {
    GOTArticle *article = viewModel;
    self.article = article;
    
    self.titleLabel.text = article.title;
    self.subtitleLabel.text = article.abstract;
    
    if (![article.thumbnail isEqual:[NSNull null]]) {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        [[[JRRxHttpClient sharedClient] fetchImageFromUrl:[NSURL URLWithString:article.thumbnail]
                                        placheholderImage:self.image] subscribeCompleted:^{
        }];
    }
}

@end
