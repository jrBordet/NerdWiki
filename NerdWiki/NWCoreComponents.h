//
//  NWCoreComponents.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 28/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Typhoon/Typhoon.h>
#import <UIKit/UIKit.h>
#import "JRTableViewBinding.h"

@protocol RxHttpClientProtocol;

@interface NWCoreComponents : TyphoonAssembly

- (id<RxHttpClientProtocol>)rxHttpClient;

- (JRTableViewBinding *)tableViewBinding:(UITableView *)tableView
                            sourceSignal:(RACSignal *)source
                        selectionCommand:(RACCommand *)selection
                            templateCell:(UINib *)templateCellNib;

@end
