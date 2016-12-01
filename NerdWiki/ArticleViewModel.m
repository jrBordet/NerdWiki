//
//  GOTAticleViewModel.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "ArticleViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ReactiveCocoa/RACEXTScope.h"
#import "Article.h"

@interface ArticleViewModel ()

@property (nonatomic, strong) id <ArticleServiceProtocol> service;
@property (nonatomic, strong) NSArray *result;

@end

@implementation ArticleViewModel

- (instancetype)initWithService:(id<ArticleServiceProtocol>)service {
    self = [super init];
    if (self) {
        _service = service;
        
        self.searchText = @"test this more than 3";
        
        [self initialize];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (RACSignal *)executeSignal {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        [[self.service fetchTopCharacters] subscribeNext:^(id result) {
            @strongify(self)
            self.searchResults = result;
            
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (void)initialize {
}

@end
