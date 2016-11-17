//
//  GOTArticleViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "ArticleViewController.h"
#import "JRTableViewBinding.h"
#import "Article.h"
#import "ArticleDetailViewController.h"

@interface ArticleViewController ()

@property (nonatomic, strong) JRTableViewBinding *binding;
@property (nonatomic, strong) ArticleViewModel *viewModel;

@end

@implementation ArticleViewController

- (instancetype)initWithViewModel:(ArticleViewModel *)viewModel {
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
    
    UINib *nib = [UINib nibWithNibName:@"ArticleCell" bundle:nil];
    
    RACCommand *selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(Article *article) {
        @strongify(self)
        ArticleDetailViewController *detail = [[ArticleDetailViewController alloc] initWithArticle:article];
        
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
