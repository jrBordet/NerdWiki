//
//  GOTArticleViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "GOTArticleViewController.h"
#import "JRTableViewBinding.h"
#import "GOTArticle.h"
#import "GOTArticleDetailViewController.h"

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

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [self bindViewModel];
}

- (void)bindViewModel {
    @weakify(self)
    
    UINib *nib = [UINib nibWithNibName:@"GOTArticleCell" bundle:nil];
    
    RACCommand *selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(GOTArticle *article) {
        @strongify(self)
        GOTArticleDetailViewController *detail = [[GOTArticleDetailViewController alloc] initWithArticle:article];
        
        [self.navigationController pushViewController:detail animated:YES];
        return [RACSignal empty];
    }];
    
    self.binding = [JRTableViewBinding bindingHelperForTableView:self.tableView
                                                    sourceSignal:RACObserve(self.viewModel, self.searchResults)
                                                selectionCommand:selectionCommand
                                                    templateCell:nib];
    
    [[self.viewModel.executeSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

@end
