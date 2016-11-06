//
//  WikiViewModel.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 06/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiViewModel.h"
#import "ReactiveCocoa/RACEXTScope.h"

@interface WikiViewModel ()

@property (nonatomic, weak) id <WikiServiceProtocol> service;

@end

@implementation WikiViewModel

- (instancetype)initWithService:(id<WikiServiceProtocol>)service {
    self = [super init];
    if (self) {
        _service = service;        
    }
    
    return self;
}

- (RACSignal *)executeSignal {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        
        [[self.service fetchTopWikies] subscribeNext:^(id result) {
            
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

@end
