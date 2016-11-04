//
//  JRCollectionViewBinding.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 28/10/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "JRCollectionViewBinding.h"
#import "JRReactiveView.h"

@interface JRCollectionViewBinding () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UICollectionViewCell *templateCell;

@end

@implementation JRCollectionViewBinding

+ (instancetype)bindingHelperForCollectionView:(UICollectionView *)collectionView
                                         frame:(CGRect)frame
                                  sourceSignal:(RACSignal *)source
                              selectionCommand:(RACCommand *)selection
                                  templateCell:(UINib *)templateCellNib
                               scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    
    return [[JRCollectionViewBinding alloc] initWithCollectionView:collectionView
                                                             frame:frame
                                                      sourceSignal:source
                                                  selectionCommand:selection
                                                      templateCell:templateCellNib
                                                   scrollDirection:scrollDirection];
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                                 frame:(CGRect)frame
                          sourceSignal:(RACSignal *)source
                      selectionCommand:(RACCommand *)selection
                          templateCell:(UINib *)templateCellNib
                       scrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    
    if (self = [super init]) {
        _collectionView = collectionView;

        _data = [NSArray array];
        
        [source subscribeNext:^(id x) {
            self.data = x;
            [self.collectionView reloadData];
        }];
        
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        
        [collectionView registerNib:templateCellNib
         forCellWithReuseIdentifier:_templateCell.reuseIdentifier];
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<JRReactiveView> cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.templateCell.reuseIdentifier
                                                                        forIndexPath:indexPath];
    
    [cell bindViewModel:self.data[indexPath.row]];
    
    return (UICollectionViewCell *)cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end
