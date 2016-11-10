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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.thumbnailImage.image = [[UIImage alloc] initWithContentsOfFile:@"placeholder.png"];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:[UIDevice currentDevice]];
}

- (void)bindViewModel:(id)viewModel {
    WikiArticle *article = viewModel;
    
    if (![article.url isEqual:[NSNull null]]) {        
        [[[JRRxHttpClient sharedClient] fetchImageFromUrl:[NSURL URLWithString:article.wordmark] placheholderImage:self.thumbnailImage] subscribeCompleted:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.thumbnailImage centerWithSize:self.contentView.bounds.size];
                
                [self needsUpdateConstraints];
                [self updateConstraints];
            });
        }];
    }
}

- (void)orientationChanged:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.thumbnailImage centerWithSize:self.contentView.bounds.size];
        
        [self needsUpdateConstraints];
        [self updateConstraints];
    });
}

@end
