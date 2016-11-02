//
//  GOTArticleDetailViewController.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GOTArticle.h"

@interface GOTArticleDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;

- (instancetype)initWithArticle:(GOTArticle *)article;

@end
