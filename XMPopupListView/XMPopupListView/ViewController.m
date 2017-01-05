//
//  ViewController.m
//  XMPopupListView
//
//  Created by TwtMac on 17/1/5.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import "ViewController.h"

#import "XMPopupListView.h"

@interface ViewController () <UITextFieldDelegate,XMPopupListViewDataSource,XMPopupListViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *sexField;

/** 弹出视图 */
@property(nonatomic,strong)XMPopupListView *popupListView;
/** 数据数组 */
@property(nonatomic,strong)NSArray *dataArray;
/** 当前需要弹出的数据源 */
@property(nonatomic,strong)NSArray *selectedArray;
/** 当前选择的UITextField */
@property(nonatomic,strong)UITextField *currentField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 输入框接受代理
    self.addressField.delegate = self;
    self.titleField.delegate = self;
    self.sexField.delegate = self;
    
    /// 初始化数据
    self.dataArray = @[@[@"北京市朝阳区东三环FFC",@"上海市浦东新区东方明珠",@"广州市海珠区广州塔",@"深圳市罗湖区京基100",@"武汉市武昌区光谷中心城",@"天津市红桥区天津之眼"],@[@"员工",@"组长",@"经理"],@[@"男",@"女"]];
    
}

/// 通过此方法,监听textField的点击
#pragma mark ----------UITextFieldDelegate----------
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.currentField = textField;
    
    /// 通过判断当前点击的textField, 选择不同的数据源
    if ([textField isEqual:self.addressField]) {
        self.selectedArray = self.dataArray.firstObject;
    } else if ([textField isEqual:self.titleField]) {
        self.selectedArray = self.dataArray[1];
    } else {
        self.selectedArray = self.dataArray.lastObject;
    }
    
    self.popupListView = [[XMPopupListView alloc] initWithBoundView:textField dataSource:self delegate:self];
    [self.view addSubview:self.popupListView];
    [self.popupListView show];
    
    return NO;
}

/// 工具类的代理方法
#pragma mark - XMPopupListViewDataSource & XMPopupListViewDelegate
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.selectedArray.count;
}
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath {
    return 44.0f;
}

/**
 选中cell后回调

 @param indexPath 返回选中的indexPath
 */
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedStr = self.selectedArray[indexPath.row];
    self.currentField.text = selectedStr;
}

- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath
{
    if (self.selectedArray.count == 0) {
        return nil;
    }
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text = self.selectedArray[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
