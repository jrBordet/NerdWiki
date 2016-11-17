//
//  NWApplicationAssembly.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 21/09/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "NWApplicationAssembly.h"
#import "JRRxHttpClient.h"
//#import "GOTArticleService.h"
#import "AppDelegate.h"

@implementation NWApplicationAssembly

#pragma mark - Bootstrapping

//- (GOTArticleViewModel *)gotArticleViewModel {
//    return [TyphoonDefinition withClass:[GOTArticleViewModel class] configuration:^(TyphoonDefinition *definition) {
//        [definition injectProperty:@selector(initWithService:) with:[self gotArticleService]];
//    }];
//}
//
//- (GOTArticleService *)gotArticleService {
//    return [TyphoonDefinition withClass:[GOTArticleService class] configuration:^(TyphoonDefinition *definition) {
//        [definition injectProperty:@selector(rxSharedClient) with:[self sharedClient]];
//    }];
//}

- (id<RxHttpClientProtocol>)sharedClient {
    return [TyphoonDefinition withClass:[JRRxHttpClient class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(sharedClient) parameters:^(TyphoonMethod *initializer) {
            definition.scope = TyphoonScopeSingleton;
        }];
    }];
}

@end
