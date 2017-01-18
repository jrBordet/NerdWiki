//
//  WikiViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiViewController.h"
#import "ReactiveCocoa/RACEXTScope.h"
#import "NWApplicationAssembly.h"
#import "NWCoreComponents.h"
#import "WikiArticleDetailViewController.h"
@import UIKit;

@interface WikiViewController ()

@property (nonatomic, strong) RBTableViewBinding *binding;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) RACCommand *selectionCommand;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end

@implementation WikiViewController {
    //UICollectionView *_collectionView;
    id<WikiViewModelProtocol> _viewModel;
    NWApplicationAssembly *_assembly;
    NWCoreComponents *_core;
}

- (instancetype)initWithViewModel:(id<WikiViewModelProtocol>)viewModel assembly:(NWApplicationAssembly *)assembly core:(NWCoreComponents *)core {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        _assembly = assembly;
        _core = core;
        
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _spinner.frame = CGRectMake( [UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _spinner.hidesWhenStopped = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    
    [self.tableView addSubview:_spinner];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.spinner startAnimating];

    self.navigationController.navigationBarHidden = YES;
    self.tableView.backgroundColor = self.backgroundColor;
    
    [self initConstraints];
    
    [self bindViewModel];
}

-(void)initConstraints {
//    id views = @{
//                 @"view" : self.tableView,
//                 @"spinner" : _spinner
//                 };
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];

    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_spinner
//                                                          attribute:NSLayoutAttributeCenterX
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.tableView
//                                                          attribute:NSLayoutAttributeCenterX
//                                                         multiplier:1.0
//                                                           constant:0.0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_spinner
//                                                          attribute:NSLayoutAttributeCenterY
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.tableView
//                                                          attribute:NSLayoutAttributeCenterY
//                                                         multiplier:1.0
//                                                           constant:0.0]];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _searchResults = [NSMutableArray new];
    }
    
    return self;
}

- (RACCommand *)selectionCommand {
    @weakify(self)
    
    if (!_selectionCommand) {
        @strongify(self)
        _selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(WikiArticle *article) {
            
            WikiArticleDetailViewController *detail = [_assembly detailViewControllerWith:article];
            
            [self.navigationController pushViewController:detail
                                                 animated:YES];
            return [RACSignal empty];
        }];
    }
    
    return _selectionCommand;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
          
    [[_viewModel.executeSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self)
        
        self.searchResults = x;
    }];
    
    UINib *templateCell = [UINib nibWithNibName:self.templateCell bundle:nil];
    
    self.binding = [_core tableViewBinding:self.tableView
                              sourceSignal:RACObserve(self, searchResults)
                          selectionCommand:self.selectionCommand
                              templateCell:templateCell];
    
    [[_viewModel.executeSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self)
        [self.spinner stopAnimating];
        [self.tableView reloadData];
    }];
    
    //RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = _viewModel.executeSignal;
}

@end


//    self.binding = [JRCollectionViewBinding bindingHelperForCollectionView:_collectionView
//                                                                     frame:self.view.frame
//                                                              sourceSignal:RACObserve(self, searchResults)
//                                                          selectionCommand:self.selectionCommand
//                                                              templateCell:nib
//                                                           scrollDirection:UICollectionViewScrollDirectionVertical];

//- (void)createCollectionView {
//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//
//    UICollectionViewFlowLayout *layout= [UICollectionViewFlowLayout new];
//
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    [layout setItemSize:CGSizeMake(200, 147)];
//    [layout setMinimumLineSpacing:0];
//    [layout setMinimumInteritemSpacing:0];
//
//    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
//                                         collectionViewLayout:layout];
//
//    _collectionView.backgroundColor = [UIColor blackColor];
//
//    [self.view addSubview:_collectionView];
//}
