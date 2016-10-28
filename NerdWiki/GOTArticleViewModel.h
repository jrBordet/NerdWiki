//
//  GOTAticleViewModel.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GOTArticleServiceProtocol.h"

@interface GOTArticleViewModel : NSObject

// an Array of GOTArticle
@property (nonatomic, strong) NSArray *searchResults;

- (RACSignal *)executeSignal;

- (instancetype)initWithService:(id<GOTArticleServiceProtocol>)service;

@property (strong, nonatomic) NSString *searchText;

@end