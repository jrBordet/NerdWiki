//
//  GOTArticleViewModelService.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 11/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

@import Foundation;
#import "GOTArticleServiceProtocol.h"

@protocol GOTArticleViewModelService <NSObject>

- (id<GOTArticleServiceProtocol>) getArticleService;

@end
