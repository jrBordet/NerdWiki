//
//  GOTArticleViewController.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleViewModel.h"

@class NWApplicationAssembly;
@class NWCoreComponents;

@interface ArticleViewController : UITableViewController

@property (nonatomic, strong) NSString *templateCell;
@property (nonatomic, strong) UIColor *backgroundColor;

- (instancetype)initWithViewModel:(ArticleViewModel *)viewModel articleRequest:(NSString *)articleRequest assembly:(NWApplicationAssembly *)assembly core:(NWCoreComponents *)core;

@end
