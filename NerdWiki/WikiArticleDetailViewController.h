//
//  WikiArticleDetailViewController.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 28/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiArticleDetail.h"

@class NWApplicationAssembly;

@protocol RxHttpClientProtocol;

@interface WikiArticleDetailViewController : UIViewController

@property (nonatomic, strong) id<RxHttpClientProtocol> sharedClient;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *navigationItemColor;

- (instancetype)initWitArticleDetail:(WikiArticleDetail *)articleDetail assembly:(NWApplicationAssembly *)assembly;

@property (weak, nonatomic) IBOutlet UIImageView *wordmarkImage;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
