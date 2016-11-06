//
//  WikiViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "WikiViewController.h"
#import "JRCollectionViewBinding.h"
#import "GOTArticle.h"
#import "GOTArticleDetailViewController.h"
#import "ReactiveCocoa/RACEXTScope.h"

@interface WikiViewController ()

@property (nonatomic, strong) JRCollectionViewBinding *binding;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) RACCommand *selectionCommand;

@end

@implementation WikiViewController {
    UICollectionView *_collectionView;
    WikiViewModel *_viewModel;
}

- (instancetype)initWithViewModel:(WikiViewModel *)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        _selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(GOTArticle *article) {
            GOTArticleDetailViewController *detail = [[GOTArticleDetailViewController alloc] initWithArticle:article];
            
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

    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UICollectionViewFlowLayout *layout= [UICollectionViewFlowLayout new];
    
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(200, 200)];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                         collectionViewLayout:layout];
    
    [[_viewModel.executeSignal deliverOn:[RACScheduler mainThreadScheduler] ] subscribeNext:^(id x) {
        @strongify(self)

        self.searchResults = x;
    }];
    
    UINib *nib = [UINib nibWithNibName:@"WikiCell" bundle:nil];
    
    self.binding = [JRCollectionViewBinding bindingHelperForCollectionView:_collectionView
                                                                     frame:self.view.frame
                                                              sourceSignal:RACObserve(self, searchResults)
                                                          selectionCommand:self.selectionCommand
                                                              templateCell:nib
                                                           scrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_collectionView];
}

@end
