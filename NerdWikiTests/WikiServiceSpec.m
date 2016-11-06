//
//  WikiServiceSpec.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 06/11/2016.
//  Copyright 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WikiService.h"
#import "WikiArticle.h"

SPEC_BEGIN(WikiServiceSpec)

describe(@"WikiService", ^{
    __block WikiService *service = [WikiService new];
    
    context(@"When fetch top Wiki Articles", ^{
        it(@"should return an NSArray of WikiArticle elements", ^{
            
            __block NSMutableArray *result = [NSMutableArray new];
            
            [[service fetchTopWikies] subscribeNext:^(id wikies) {
                result = wikies;
            }];
            
            [[expectFutureValue(result) shouldEventually] beKindOfClass:[NSArray class]];
            
            [[expectFutureValue([result objectAtIndex:0]) shouldEventually] beKindOfClass:[WikiArticle class]];
        });
    });
});

SPEC_END
