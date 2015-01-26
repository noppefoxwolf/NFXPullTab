//
//  NFXPullTabViewController.m
//  NFXPullTab
//
//  Created by Tomoya_Hirano on 2015/01/27.
//  Copyright (c) 2015年 Tomoya_Hirano. All rights reserved.
//

#import "NFXPullTabViewController.h"

typedef enum : NSInteger {
    NFXPullStateNone,
    NFXPullStatePull,
    NFXPullStateReverse
}NFXPullState;

@interface NFXPullTabViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITableView*_tableView;
    UIScrollView*_scrollView;
    NSArray*_viewcontrollers;
    int _currentIndex;
    NFXPullState state;
}

@end

@implementation NFXPullTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentIndex = -1;
    state = NFXPullStateNone;

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:0.078 green:0.078 blue:0.078 alpha:1];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = false;
    [self.view addSubview:_tableView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.alwaysBounceHorizontal = true;
    _scrollView.contentSize = self.view.bounds.size;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark delegate(UIScrollView)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.x);
    
    if (scrollView.contentOffset.x==0) {
        state = NFXPullStateNone;
        scrollView.userInteractionEnabled = true;
        return;
    }
    
    if (scrollView.contentOffset.x>0) {
        scrollView.contentOffset = CGPointMake(0, 0);
        return;
    }
    
    if (state != NFXPullStateReverse) {
        int index = -(scrollView.contentOffset.x+60)/(self.view.bounds.size.width/2.5-60)*(_viewcontrollers.count+1);
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:false
                          scrollPosition:UITableViewScrollPositionNone];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.x>=0) {
        return;
    }
    scrollView.userInteractionEnabled = false;
    state = NFXPullStateReverse;
    int index = -(scrollView.contentOffset.x+60)/(self.view.bounds.size.width/2.5-60)*(_viewcontrollers.count+1);
    [self setSelectedIndex:index];
}

#pragma mark delegate(UItableView)
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _viewcontrollers.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIViewController*vc = _viewcontrollers[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:0.141 green:0.141 blue:0.141 alpha:1];
    cell.textLabel.text = vc.title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


#pragma mark setter

-(void)setViewControllers:(NSArray *)controllers{
    _viewcontrollers = controllers;
}

-(void)setSelectedIndex:(int)index{
    if (_currentIndex>0) {
        [self hideContentController:_viewcontrollers[_currentIndex]];
    }
    [self displayContentController:_viewcontrollers[index]];
    _currentIndex = index;
}


#pragma mark container method
- (void)displayContentController:(UIViewController *)content{
    [self addChildViewController:content];
    content.view.bounds = self.view.bounds;
    [_scrollView addSubview:content.view];
    [content didMoveToParentViewController:self];
}

- (void)hideContentController:(UIViewController *)content{
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}
@end
