//
//  NWApplicationAssembly.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 21/09/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"
#import "NWCoreComponents.h"
#import "AppDelegate.h"

@class NWCoreComponents;

@class WikiViewController;
@class WikiCell;
@class WikiArticleDetailViewController;
@class WikiArticle;
@class ArticleDetailViewController;
@class Article;

@class ArticleViewController;

@interface NWApplicationAssembly : TyphoonAssembly

@property (nonatomic, strong) NWCoreComponents *coreComponents;

- (AppDelegate *)appDelegate;

- (WikiViewController *)wikiViewController;

- (WikiArticleDetailViewController *)detailViewControllerWith:(WikiArticle *)article;

- (ArticleViewController *)articleViewControllerWithArticleRequest:(NSString *)articleRequest;

- (ArticleDetailViewController *)articleDetailwithArticle:(Article *)article;

@end
