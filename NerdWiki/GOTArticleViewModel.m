//
//  GOTAticleViewModel.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTArticleViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ReactiveCocoa/RACEXTScope.h"

@interface GOTArticleViewModel ()

@property (nonatomic, weak) id <GOTArticleServiceProtocol> service;
@property (nonatomic, strong) NSArray *result;

@end

@implementation GOTArticleViewModel

- (instancetype)initWithService:(id<GOTArticleServiceProtocol>)service {
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

- (void)initialize {
    RACSignal *validSearchSignal = [[RACObserve(self, searchText) map:^id(NSString *text) {
        return @(text.length > 3);
    }] distinctUntilChanged];
    
    [validSearchSignal subscribeNext:^(id x) {
        NSLog(@"search text is valid %@", x);
    }];
    
    @weakify(self)
    self.executeSearch = [[RACCommand alloc] initWithEnabled:validSearchSignal signalBlock:^RACSignal *(id input) {
        return [[self.service fetchTopCharacters] doNext:^(id x) {
            @strongify(self)
            self.searchResults = x;
        }];
    }];
}

@end
