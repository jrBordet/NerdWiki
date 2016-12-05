//
//  RxTableViewController.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/12/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NWApplicationAssembly;
@class NWCoreComponents;

@interface RxTableViewController : UITableViewController

@property (nonatomic, strong) NSString *templateCell;

- (instancetype)initWithViewModel:(id)viewModel
                   request:(NSString *)request
                         assembly:(NWApplicationAssembly *)assembly
                             core:(NWCoreComponents *)core;

@end
