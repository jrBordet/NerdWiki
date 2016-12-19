//
//  GOTArticleViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 08/08/16.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "ArticleViewController.h"
#import "Article.h"
#import "ArticleDetailViewController.h"
#import "NWApplicationAssembly.h"
#import "NWCoreComponents.h"

@interface ArticleViewController ()

@property (nonatomic, strong) RBTableViewBinding *binding;
@property (nonatomic, strong) ArticleViewModel *viewModel;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end

@implementation ArticleViewController {
    NSString *_articleRequest;
    NWApplicationAssembly *_assembly;
    NWCoreComponents *_core;
}

- (instancetype)initWithViewModel:(ArticleViewModel *)viewModel articleRequest:(NSString *)articleRequest assembly:(NWApplicationAssembly *)assembly core:(NWCoreComponents *)core {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _articleRequest = articleRequest;
        _assembly = assembly;
        _core = core;
        
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _spinner.frame = CGRectMake( [UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _spinner.hidesWhenStopped = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    self.spinner.startAnimating;
    [self.tableView addSubview:_spinner];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = self.backgroundColor;
            
    [self bindViewModel];
}

- (void)bindViewModel {
    @weakify(self)
        
    RACCommand *selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(Article *article) {
        @strongify(self)
        ArticleDetailViewController *detail = [_assembly articleDetailwithArticle:article];
        
        [self.navigationController pushViewController:detail animated:YES];
        return [RACSignal empty];
    }];
    
    self.binding = [_core tableViewBinding:self.tableView
                              sourceSignal:RACObserve(self.viewModel, self.searchResults)
                          selectionCommand:selectionCommand
                              templateCell:[UINib nibWithNibName:self.templateCell
                                                          bundle:nil]];
    
    [[[self.viewModel executeSignalWithRequest:_articleRequest] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self)
        self.spinner.stopAnimating;
        [self.tableView reloadData];
    }];
}

@end
