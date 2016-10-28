//
//  GOTArticleViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTArticleViewController.h"
#import "JRTableViewBinding.h"

@interface GOTArticleViewController ()

@property (nonatomic, strong) JRTableViewBinding *binding;
@property (nonatomic, strong) GOTArticleViewModel *viewModel;

@end

@implementation GOTArticleViewController

- (instancetype)initWithViewModel:(GOTArticleViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];

    [self bindViewModel];
}

- (void)bindViewModel {
    @weakify(self)
    
    [[self.viewModel.executeSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^ {
        @strongify(self)
        [self.tableView reloadData];
    }];
    
    UINib *nib = [UINib nibWithNibName:@"GOTArticleCell" bundle:nil];
    
    self.binding = [JRTableViewBinding bindingHelperForTableView:self.tableView
                                                    sourceSignal:RACObserve(self.viewModel, self.searchResults)
                                                selectionCommand:nil
                                                    templateCell:nib];
    
    [RACObserve(self.viewModel, self.searchResults) subscribeNext:^(id x) {
        @strongify(self)
        NSLog(@"%@ result", self);
    }];
}

@end
