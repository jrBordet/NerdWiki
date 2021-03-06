//
//  NWApplicationAssembly.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 21/09/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "NWApplicationAssembly.h"
#import "WikiViewModel.h"
#import "WikiViewModelProtocol.h"
#import "WikiService.h"
#import "WikiServiceProtocol.h"
#import "WikiArticleDetail.h"
#import "WikiArticleDetailViewController.h"
#import "WikiCell.h"
#import "ArticleViewController.h"
#import "ArticleViewModel.h"
#import "ArticleServiceProtocol.h"
#import "ArticleService.h"
#import "ArticleDetailViewController.h"
#import "UIColor+NWTheme.h"

@implementation NWApplicationAssembly

#pragma mark - Bootstrapping

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(window) with:[self mainWindow]];
        [definition injectProperty:@selector(wikiViewController) with:[self wikiViewController]];
    }];
}

- (UIWindow *)mainWindow {
    return [TyphoonDefinition withClass:[UIWindow class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithFrame:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[NSValue valueWithCGRect:[[UIScreen mainScreen] bounds]]];
        }];
    }];
}

#pragma mark - view

- (WikiViewController *)wikiViewController {
    return [TyphoonDefinition withClass:[WikiViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(templateCell) with:@"WikiCell"];
        [definition injectProperty:@selector(backgroundColor) with:[UIColor bgColor]];
        
        [definition useInitializer:@selector(initWithViewModel:assembly:core:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self wikiModel]];
            [initializer injectParameterWith:self];
            [initializer injectParameterWith:_coreComponents];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (WikiArticleDetailViewController *)detailViewControllerWith:(WikiArticle *)article {
    return [TyphoonDefinition withClass:[WikiArticleDetailViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(sharedClient) with:[_coreComponents rxHttpClient]];
        [definition injectProperty:@selector(backgroundColor) with:[UIColor bgColor]];
        [definition injectProperty:@selector(navigationItemColor) with:[UIColor greenColor]];

        [definition useInitializer:@selector(initWitArticleDetail:assembly:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self wikiArticleDetailWith:article]];
            [initializer injectParameterWith:self];
        }];
    }];
}

- (ArticleViewController *)articleViewControllerWithArticleRequest:(NSString *)articleRequest {
    return [TyphoonDefinition withClass:[ArticleViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(templateCell) with:@"ArticleCell"];
        [definition injectProperty:@selector(backgroundColor) with:[UIColor bgColor]];
        
        [definition useInitializer:@selector(initWithViewModel:articleRequest:assembly:core:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self articleViewModel]];
            [initializer injectParameterWith:articleRequest];
            [initializer injectParameterWith:self];
            [initializer injectParameterWith:_coreComponents];
        }];
    }];
}

- (ArticleDetailViewController *)articleDetailwithArticle:(Article *)article {
    return [TyphoonDefinition withClass:[ArticleDetailViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithArticle:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:article];
        }];
    }];
}

#pragma mark - model

- (ArticleViewModel *)articleViewModel {
    return [TyphoonDefinition withClass:[ArticleViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self articleService]];
        }];
    }];
}

- (id<WikiArticleDetailProtocol>)wikiArticleDetailWith:(WikiArticle *)article {
    return [TyphoonDefinition withClass:[WikiArticleDetail class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithObject:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:article];
        }];
    }];
}

- (id<WikiViewModelProtocol>)wikiModel {
    return [TyphoonDefinition withClass:[WikiViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self wikiService]];
        }];
    }];
}

#pragma mark - services

- (id<WikiServiceProtocol>)wikiService {
    return [TyphoonDefinition withClass:[WikiService class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(serviceUrl) with:@"http://www.wikia.com/api/v1/Wikis/List?expand=1"];
        [definition injectProperty:@selector(sharedClient) with:[_coreComponents rxHttpClient]];
    }];
}

- (id<ArticleServiceProtocol>)articleService {
    return [TyphoonDefinition withClass:[ArticleService class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(sharedClient) with:[_coreComponents rxHttpClient]];
        [definition useInitializer:@selector(init)];
    }];
}

@end
