//
//  GOTAticleViewModel.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleServiceProtocol.h"

@interface ArticleViewModel : NSObject

// an Array of GOTArticle
@property (nonatomic, strong) NSArray *searchResults;

- (RACSignal *)executeSignal;

- (instancetype)initWithService:(id<ArticleServiceProtocol>)service;

@property (strong, nonatomic) NSString *searchText;

@end
