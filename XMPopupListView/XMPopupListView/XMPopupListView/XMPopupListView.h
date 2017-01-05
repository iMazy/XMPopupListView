//
//  XMPopupListView.h
//  Towatt_OA
//
//  Created by TwtMac on 16/12/28.
//  Copyright © 2016年 Mazy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMPopupListViewDelegate <NSObject>
@optional
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol XMPopupListViewDataSource <NSObject>
@required
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
@optional
- (NSInteger)numberOfSections;
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath;
- (NSString *)titleInSection:(NSInteger)section;
@end

@interface XMPopupListView : UIControl <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<XMPopupListViewDelegate> delegate;
@property (nonatomic, weak) id<XMPopupListViewDataSource> dataSource;

- (id)initWithBoundView:(UIView *)boundView
             dataSource:(id)datasource
               delegate:(id)delegate;

- (void)bindToView:(UIView *)boundView;

- (void)show;
- (void)dismiss;

- (void)reloadListData;

@end
