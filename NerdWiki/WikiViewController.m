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

@interface WikiViewController ()

@property (nonatomic, strong) JRTableViewBinding *binding;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) RACCommand *selectionCommand;

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
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self bindViewModel];
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
        [self.tableView reloadData];
    }];
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
