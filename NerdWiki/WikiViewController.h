//
//  WikiViewController.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiViewModel.h"

@interface WikiViewController : UITableViewController

- (instancetype)initWithViewModel:(WikiViewModel *)viewModel;

@end
