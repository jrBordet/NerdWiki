//
//  WikiCell.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiCell.h"
#import "WikiArticle.h"
#import "JRRxHttpClient.h"
#import "UIImageView+Geometry.h"

@implementation WikiCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindViewModel:(id)viewModel {
    @weakify(self)
    WikiArticle *article = viewModel;
    
    self.testLabel.text = article.title;
    
    if (![article.url isEqual:[NSNull null]]) {
        self.thumbnailImage.contentMode = UIViewContentModeScaleToFill;
        [[[JRRxHttpClient sharedClient] fetchImageFromUrl:[NSURL URLWithString:article.wordmark] placheholderImage:self.thumbnailImage] subscribeCompleted:^{
            @strongify(self)
            NSLog(@"");
        }];
    }
}

@end
