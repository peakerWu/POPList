//
//  ViewController.m
//  POPList
//
//  Created by zhuke on 2018/6/5.
//  Copyright © 2018年 zhuke. All rights reserved.
//

#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ViewController () <ASTableDelegate, ASTableDataSource>
@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) NSArray *animationsArray;
@property (nonatomic, strong) NSArray *controllersArray;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.navigationItem.title = @"POPList";
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        [self.view addSubnode:_tableNode];
        _tableNode.frame = self.view.bounds;
        _tableNode.view.tableFooterView = [[UIView alloc] init];
        _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableNode.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = _tableNode.indexPathForSelectedRow;
    if (indexPath) {
        [_tableNode deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _animationsArray = @[@"倒计时", @"图片放大与缩小", @"按钮动画", @"转场动画", @"重力加速度", @"微博弹出", @"呼吸灯"];
    _controllersArray = @[@"Countdown", @"Picture", @"Button", @"CustomTransition", @"CMMotion", @"WB", @"Twinkle"];
}

#pragma mark - ASTableDelegate, ASTableDataSource
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section
{
    return _animationsArray.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASCellNode *cellNode = [ASCellNode new];
    
    ASTextNode *text = [[ASTextNode alloc] init];
    text.attributedText = [[NSAttributedString alloc] initWithString:_animationsArray[indexPath.row] attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Avenir-Light" size:20], NSForegroundColorAttributeName : [UIColor blackColor]}];
    cellNode.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
        ASStackLayoutSpec *textSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
        textSpec.justifyContent = ASStackLayoutJustifyContentStart;
        textSpec.children = @[text];
        return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(12, 8, 8, 12) child:textSpec];
    };
    [cellNode addSubnode:text];
    
    return ^{
        
        return cellNode;
    };
}
- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableNode deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *pushVC = (UIViewController *)[[NSClassFromString([NSString stringWithFormat:@"%@ViewController", _controllersArray[indexPath.row]]) alloc] init];
    pushVC.view.backgroundColor = [UIColor whiteColor];
    pushVC.navigationItem.title = _animationsArray[indexPath.row];
    [self.navigationController pushViewController:pushVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
