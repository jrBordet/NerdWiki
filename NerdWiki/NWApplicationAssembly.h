//
//  NWApplicationAssembly.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 21/09/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"
#import "GOTArticleServiceProtocol.h"
#import "GOTArticleViewModel.h"

@class GOTArticleService;

@interface NWApplicationAssembly : TyphoonAssembly

- (GOTArticleService *)gotArticleService;
- (GOTArticleViewModel *)gotArticleViewModel;

@end
