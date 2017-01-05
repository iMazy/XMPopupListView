//
//  XMPopupListView.h
//
//  Created by Mac on 16/12/28.
//  Copyright © 2016年 Mazy. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 代理
@protocol XMPopupListViewDelegate <NSObject>
@optional
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath;
@end

/// 数据源
@protocol XMPopupListViewDataSource <NSObject>
// 必选
@required
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
// 可选
@optional
- (NSInteger)numberOfSections;
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath;
- (NSString *)titleInSection:(NSInteger)section;
@end

@interface XMPopupListView : UIControl <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<XMPopupListViewDelegate> delegate;
@property (nonatomic, weak) id<XMPopupListViewDataSource> dataSource;

/// 构造初始化方法
- (id)initWithBoundView:(UIView *)boundView
             dataSource:(id)datasource
               delegate:(id)delegate;

/**
 绑定依附视图

 @param boundView 依附的视图
 */
- (void)bindToView:(UIView *)boundView;

/** 展示 */
- (void)show;

/** 消失 */
- (void)dismiss;

/** 刷新数据 */
- (void)reloadListData;

@end
