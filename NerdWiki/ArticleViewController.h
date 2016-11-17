//
//  GOTArticleViewController.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleViewModel.h"

@interface ArticleViewController : UITableViewController

- (instancetype)initWithViewModel:(ArticleViewModel *)viewModel;

@end
