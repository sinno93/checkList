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
    NSMutableArray *_items;
}
// 初始化方法
-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self =[super initWithCoder:aDecoder])){
        [self loadChecklistItems];
    }
    return self;
    
}
-(void)loadChecklistItems{
    
    NSString *path =[self dataFilePath];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
        
        NSData *data = [[NSData alloc]initWithContentsOfFile:path
                        ];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver
                                          alloc]initForReadingWithData:data];
        
        _items = [unarchiver decodeObjectForKey:@"ChecklistItems"];
        [unarchiver finishDecoding];
        
    }else{
        
        _items = [[NSMutableArray alloc]initWithCapacity:20];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view, typically from a nib.
    NSLog(@"文件夹的目录是：%@",[self documentsDirectory]);
    NSLog(@"数据文件的最终路径是：%@",[self dataFilePath]);
}
-(NSString*)documentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}
-(NSString*)dataFilePath{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklistItems{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_items forKey:@"ChecklistItems"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
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
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    if(item.checked){
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        label.text = @"√";
        
    }else{
        label.text = @"";
//        cell.accessoryType = UITableViewCellAccessoryNone;
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
    [self saveChecklistItems];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addItem:(id)sender {
    NSLog(@"%@",sender);
    // 获取现有的列表长度
    NSInteger newRowIndex = [_items count];
    // 新增数据 并加入数据数组中
    ChecklistItem *item =[[ChecklistItem alloc]init];
    item.text = @"我是新来的菜⻦，求照顾求虐";
    item.checked = NO;
    [_items addObject:item];
    // 将数据加入tableView
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
     [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -self.tableView.bounds.size.height) animated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    [self saveChecklistItems];
    [tableView deleteRowsAtIndexPaths:indexPaths
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView reloadData];
}
// 代理 取消增加事项
- (void)ItemDetailViewControllerDidCancel:(ItemDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 代理 完成增加事项
- (void)ItemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item{
    NSLog(@"%@",item.text);
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    // 保存修改后的数据至文件中
    [self saveChecklistItems];
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 代理 完成编辑事项
-(void)ItemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item{
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item];
    [self saveChecklistItems];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"AddItem"]){
        
        //1
        UINavigationController *navigationController = segue.destinationViewController;
        
        //2
        ItemDetailViewController *controller = (ItemDetailViewController*)
        navigationController.topViewController;
        //3
        controller.delegate = self;
    }else if([segue.identifier isEqualToString:@"EditItem"]){
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        ItemDetailViewController *controller = (ItemDetailViewController*)
        navigationController.topViewController;
        
        controller.delegate = self;
        
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        
        controller.itemToEdit = _items[indexPath.row];
        
    }
}
@end
