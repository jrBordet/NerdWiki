//
//  NWApplicationAssembly.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 21/09/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "NWApplicationAssembly.h"
#import "WikiViewModel.h"
#import "WikiViewModelProtocol.h"
#import "WikiService.h"
#import "WikiServiceProtocol.h"

@implementation NWApplicationAssembly

#pragma mark - Bootstrapping

- (AppDelegate *)appDelegate {
    return [TyphoonDefinition withClass:[AppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(window) with:[self mainWindow]];
        [definition injectProperty:@selector(rootViewController) with:[self rootViewController]];
    }];
}

- (UIWindow *)mainWindow {
    return [TyphoonDefinition withClass:[UIWindow class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithFrame:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[NSValue valueWithCGRect:[[UIScreen mainScreen] bounds]]];
        }];
    }];
}

- (WikiViewController *)rootViewController {
    return [TyphoonDefinition withClass:[WikiViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithViewModel:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self wikiModel]];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (id<WikiViewModelProtocol>)wikiModel {
    return [TyphoonDefinition withClass:[WikiViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self wikiService]];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (id<WikiServiceProtocol>)wikiService {
    return [TyphoonDefinition withClass:[WikiService class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(init)];
        [definition injectProperty:@selector(serviceUrl) with:@"http://www.wikia.com/api/v1/Wikis/List?expand=1&lang=en&batch=1"];
    }];
}

@end
