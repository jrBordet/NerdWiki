//
//  JRRxHttpClientSpecSpec.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 24/10/2016.
//  Copyright 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "JRRxHttpClient.h"
#import "GOTArticle.h"

SPEC_BEGIN(JRRxHttpClientSpec)
//
describe(@"JRRxHttpClientSpec", ^{
    context(@"When fetch top 10 GOT Articles", ^{
        it(@"should return an array of 10 elements", ^{
            NSDictionary *queryString = @ {
                @"expand": @"1",
                @"Category": @"Characters",
                @"limit": @"10"
            };
            
            NSString *baseUrl = @"http://gameofthrones.wikia.com/api/v1/Articles/Top";
            __block NSMutableArray *result = [NSMutableArray new];
            
            [[[JRRxHttpClient sharedClient] performRequestWithBaseUrl:baseUrl query:queryString transform:^id(NSDictionary *jsonResponse) {
                [[jsonResponse objectForKey:@"items"] enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
                    [result addObject:[[GOTArticle alloc]initWithTitle:object[@"title"]
                                                              Basepath:jsonResponse[@"basepath"]
                                                                   Url:object[@"url"]
                                                              Abstract:object[@"abstract"]
                                                             Thumbnail:object[@"thumbnail"]]];
                }];
                
                return result;
            }] subscribeCompleted:^{
                NSLog(@"%@", result);
            }];
            
            [[expectFutureValue(result) shouldEventually] haveCountOf:10];
        });
    });
    
    context(@"When fetch image thumbnail", ^{
        __block UIImage *result;
        it(@"should return a valid image", ^{
            [[[JRRxHttpClient sharedClient] fetchImageFromUrl:[NSURL URLWithString:@"http://vignette3.wikia.nocookie.net/gameofthrones/images/4/49/Battle_of_the_Bastards_08.jpg/revision/latest/window-crop/width/200/x-offset/0/y-offset/0/window-width/2700/window-height/2700?cb=20160615184845"]
                                            placheholderImage:[UIImageView new]]
             subscribeNext:^(UIImage *value) {
                 result = value;
             }];
            
            [[expectFutureValue(result) shouldEventually] beNonNil];
        });
    });
});

SPEC_END
