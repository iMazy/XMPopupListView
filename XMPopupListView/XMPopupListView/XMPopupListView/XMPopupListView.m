//
//  XMPopupListView.m
//  Towatt_OA
//
//  Created by TwtMac on 16/12/28.
//  Copyright © 2016年 Mazy. All rights reserved.
//

#import "XMPopupListView.h"

@interface XMPopupListView ()

@property (nonatomic, strong) UIView *boundView; // 绑定的视图

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowing;

@end

@implementation XMPopupListView

- (id)initWithBoundView:(UIView *)boundView
             dataSource:(id)datasource
               delegate:(id)delegate
{
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0.0f, -0.0f, screenBounds.size.width, screenBounds.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.3];
        self.frame = frame;
        
        self.dataSource = datasource;
        self.delegate = delegate;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.tableView.clipsToBounds = YES;
        self.tableView.layer.cornerRadius = 3.0f;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.backgroundColor = [UIColor whiteColor];
        
        
        self.boundView = boundView;

        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        self.isShowing = NO;
    }
    return self;
}

- (void)bindToView:(UIView *)boundView {
    self.boundView = boundView;
}

- (void)show {
    
    if (_isShowing) {
        return;
    }
    
    UIView *boundViewSuperView = self.superview;
    
    CGRect boundViewframe = self.boundView.frame;
    
    CGRect rect = [self.boundView.superview convertRect:self.boundView.frame toView:self.superview];
    
    self.tableView.frame = CGRectMake(CGRectGetMinX(rect),
                                  CGRectGetMaxY(rect)+5,
                                  boundViewframe.size.width,
                                  0.0f);
    
    [boundViewSuperView addSubview:self];
    [boundViewSuperView addSubview:self.tableView];
    
    NSInteger rows = [self.dataSource numberOfRowsInSection:0] <= 5 ? [self.dataSource numberOfRowsInSection:0] : 5;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(CGRectGetMinX(rect),
                                      CGRectGetMaxY(rect)+5,
                                      boundViewframe.size.width,
                                      44*rows);
    }];
    
    
    self.isShowing = YES;
    
    [self.tableView reloadData];
}

- (void)dismiss {
    if (!self.isShowing) {
        return;
    }
    CGRect boundViewframe = self.boundView.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        self.tableView.frame = CGRectMake(CGRectGetMinX(boundViewframe),
                                      CGRectGetMaxY(boundViewframe),
                                      boundViewframe.size.width,
                                      0.0f);
        
        [self.tableView removeFromSuperview];
        [self removeFromSuperview];
    }];
    self.isShowing = NO;
}

- (void)reloadListData {
    [self.tableView reloadData];
}

#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(itemCellHeight:)]) {
        return [self.dataSource itemCellHeight:indexPath];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(clickedListViewAtIndexPath:)]) {
        [self.delegate clickedListViewAtIndexPath:indexPath];
    }
    [self dismiss];
}

#pragma mark -- UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSections)]) {
        [self.dataSource numberOfSections];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInSection:)]) {
        return [self.dataSource numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(itemCell:)]) {
        return [self.dataSource itemCell:indexPath];
    }
    return nil;
}

@end
