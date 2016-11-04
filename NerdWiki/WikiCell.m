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
    // Initialization code
}

- (void)bindViewModel:(id)viewModel {
    @weakify(self)
    
    WikiArticle *article = viewModel;
    
    self.testLabel.text = article.title;
    
    if (![article.url isEqual:[NSNull null]]) {
        self.thumbnailImage.contentMode = UIViewContentModeScaleToFill;
        [[[JRRxHttpClient sharedClient] fetchImageFromUrl:[NSURL URLWithString:article.url] placheholderImage:self.thumbnailImage] subscribeCompleted:^{
            @strongify(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.thumbnailImage rounded];
            });
        }];
    }
    
}

@end
