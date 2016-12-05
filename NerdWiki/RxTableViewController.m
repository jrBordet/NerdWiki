//
//  RxTableViewController.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/12/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "RxTableViewController.h"
#import "JRTableViewBinding.h"
#import "NWApplicationAssembly.h"
#import "NWCoreComponents.h"

@interface RxTableViewController ()

@end

@implementation RxTableViewController{
    NSString *_request;
    NWApplicationAssembly *_assembly;
    NWCoreComponents *_core;
    JRTableViewBinding *_binding;
    id _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
}

- (instancetype)initWithViewModel:(id)viewModel request:(NSString *)request assembly:(NWApplicationAssembly *)assembly core:(NWCoreComponents *)core {
    self = [super init];
    
    if (self) {
        _viewModel = viewModel;
        _request = request;
        _assembly = assembly;
        _core = core;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    
    RACCommand *selectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id article) {
       // @strongify(self)
       // id *detail = [_assembly articleDetailwithArticle:article];
        
        //[self.navigationController pushViewController:detail animated:YES];
        return [RACSignal empty];
    }];
    
//    self.binding = [_core tableViewBinding:self.tableView
//                              sourceSignal:RACObserve(self.viewModel, self.searchResults)
//                          selectionCommand:selectionCommand
//                              templateCell:[UINib nibWithNibName:self.templateCell
//                                                          bundle:nil]];
    
//    [[[self.viewModel executeSignalWithRequest:_articleRequest] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//        @strongify(self)
//        [self.tableView reloadData];
//    }];
}

@end
