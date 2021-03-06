//
//  GOTArticleService.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 07/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleServiceProtocol.h"

@protocol RxHttpClientProtocol;

@interface ArticleService : NSObject <ArticleServiceProtocol>

@end
