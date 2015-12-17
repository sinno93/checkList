//
//  ViewController.m
//  Checklists
//
//  Created by 郑庆登(Qingdeng Zheng)-IT服务中心 on 15/11/23.
//  Copyright © 2015年 郑庆登(Qingdeng Zheng)-IT服务中心. All rights reserved.
//

#import "ViewController.h"

//@interface ViewController ()
//
//@end

@implementation ViewController
{
//    // 列表文字
//    NSString *_row0text;
//    NSString *_row1text;
//    NSString *_row2text;
//    NSString *_row3text;
//    NSString *_row4text;
////     列表选择标志
//    BOOL _row0checked;
//    BOOL _row1checked;
//    BOOL _row2checked;
//    BOOL _row3checked;
//    BOOL _row4checked;
    
    ChecklistItem *_row0item;
    ChecklistItem *_row1item;
    ChecklistItem *_row2item;
    ChecklistItem *_row3item;
    ChecklistItem *_row4item;
    NSMutableArray *_items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view, typically from a nib.
    _row0item = [[ChecklistItem alloc] init];
    _row1item = [[ChecklistItem alloc] init];
    _row2item = [[ChecklistItem alloc] init];
    _row3item = [[ChecklistItem alloc] init];
    _row4item = [[ChecklistItem alloc] init];
    
    _row0item.text = @"学习工作半小时嘿嘿嘿";
    _row1item.text = @"休息五分钟";
    _row2item.text = @"走路回家";
    _row3item.text = @"做饭吃饭";
    _row4item.text = @"哦嘿嘿嘿";
    
    _items = [[NSMutableArray alloc] initWithCapacity:20];
    [_items addObject:_row0item];
    [_items addObject:_row1item];
    [_items addObject:_row2item];
    [_items addObject:_row3item];
    [_items addObject:_row4item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}
// 更新checkmark函数
-(void)configureCheckmarkForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem *)item{
    if(item.checked){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
}
-(void)configureTextForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem *)item{
    UILabel *label = (UILabel*)[cell viewWithTag:1993];
    label.text = item.text;
    
}
 // 获取cell的函数
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取可重用的cell
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ChecklistItemxx"];
    ChecklistItem * item = _items[indexPath.row];
    // 更新checkmark
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [self configureTextForCell:cell withChecklistItem:item];
    // 更新label
    
    return cell;
}
// 选择(点击)一行数据时 处理函数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ChecklistItem * item = _items[indexPath.row];
    [item toggleCheckMark];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
