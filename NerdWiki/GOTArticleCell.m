//
//  GOTArticleCell.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 10/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTArticleCell.h"
#import "GOTArticle.h"

@implementation GOTArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)bindViewModel:(id)viewModel {
    GOTArticle *article = viewModel;
    
    self.textLabel.text = article.title;
    self.detailTextLabel.text = article.abstract;
}

@end
