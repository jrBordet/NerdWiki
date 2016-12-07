//
//  NWCoreComponents.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 28/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "NWCoreComponents.h"
#import "JRRxHttpClient.h"

@implementation NWCoreComponents

- (id<RxHttpClientProtocol>)rxHttpClient {
    return [TyphoonDefinition withClass:[JRRxHttpClient class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(sharedClient) parameters:^(TyphoonMethod *initializer) {
            definition.scope = TyphoonScopeSingleton;
        }];
    }];
}

- (RBTableViewBinding *)tableViewBinding:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)selection templateCell:(UINib *)templateCellNib {
    return [TyphoonDefinition withClass:[RBTableViewBinding class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithTableView:sourceSignal:selectionCommand:templateCell:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:tableView];
            [initializer injectParameterWith:source];
            [initializer injectParameterWith:selection];
            [initializer injectParameterWith:templateCellNib];
        }];
    }];
}

@end
