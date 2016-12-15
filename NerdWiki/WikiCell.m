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
#import "NWCoreComponents.h"

@implementation WikiCell

- (void)awakeFromNib {
    [super awakeFromNib];
        
    [self needsUpdateConstraints];
    [self updateConstraints];
    
    _thumbnailImage.contentMode = UIViewContentModeScaleAspectFill;
    
    self.backgroundColor = [UIColor colorWithRed:255/29 green:255/29 blue:255/29 alpha:0.75];
    
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
