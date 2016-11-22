//
//  WikiViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiViewController.h"
#import "JRCollectionViewBinding.h"
#import "WikiArticle.h"
#import "ArticleDetailViewController.h"
#import "ReactiveCocoa/RACEXTScope.h"
#import "JRTableViewBinding.h"

@interface WikiViewController ()

@property (nonatomic, strong) JRTableViewBinding *binding;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) RACCommand *selectionCommand;

@end

@implementation WikiViewController {
    UICollectionView *_collectionView;
    id<WikiViewModelProtocol> _viewModel;
}

- (instancetype)initWithViewModel:(id<WikiViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        
        if (!viewModel) {
            _searchResults = [NSMutableArray new];

            for (int i = 0; i < 10; i++) {
                WikiArticle *a = [[WikiArticle alloc] initWithTitle:@"ksdfh"
                                                             domain:@"elderscrolls.wikia.com"
                                                                url:@"http://elderscrolls.wikia.com/"
                                                           wordmark:@"http://img4.wikia.nocookie.net/__cb20150420200658/elderscrolls/images/8/89/Wiki-wordmark.png"
                                                               desc:@"sldiflisdjflijdsf"];
                [_searchResults addObject:a];
            }
        }
    }
    return self;
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
        _selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(Article *article) {
            ArticleDetailViewController *detail = [[ArticleDetailViewController alloc] initWithArticle:article];
            
            [self.navigationController pushViewController:detail animated:YES];
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
    
    //[self createCollectionView];
    
    [[_viewModel.executeSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self)

        self.searchResults = x;
    }];
    
    UINib *nib = [UINib nibWithNibName:@"WikiCell" bundle:nil];
    
//    self.binding = [JRCollectionViewBinding bindingHelperForCollectionView:_collectionView
//                                                                     frame:self.view.frame
//                                                              sourceSignal:RACObserve(self, searchResults)
//                                                          selectionCommand:self.selectionCommand
//                                                              templateCell:nib
//                                                           scrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.binding = [JRTableViewBinding bindingHelperForTableView:self.tableView
                                                    sourceSignal:RACObserve(self, searchResults)
                                                selectionCommand:self.selectionCommand
                                                    templateCell:nib];
    
    [[_viewModel.executeSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}

- (void)createCollectionView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UICollectionViewFlowLayout *layout= [UICollectionViewFlowLayout new];
    
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(200, 147)];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                         collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_collectionView];
}

@end
