//
//  AddItemViewController.m
//  Checklists
//
//  Created by 郑庆登(Qingdeng Zheng)-IT服务中心 on 15/12/22.
//  Copyright © 2015年 郑庆登(Qingdeng Zheng)-IT服务中心. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Checklists/ChecklistItem.h"
@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.itemToEdit != nil){
        self.title = @"Edit xxxItem";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)addItemCancelButton:(id)sender {
    NSLog(@"you clicked the cancel Button in add Item page");
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.delegate ItemDetailViewControllerDidCancel:self];
}
- (IBAction)addItemDoneButton:(id)sender {
    NSLog(@"你点击了addItem页面的Done按钮:%@",self.textField.text);
    
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    // 给代理哥发短信 告诉他我完成任务了 顺便把item也快递给他
    if(self.itemToEdit==nil){
        ChecklistItem *item = [[ChecklistItem alloc] init];
        item.text = self.textField.text;
        item.checked = NO;
        [self.delegate ItemDetailViewController:self didFinishAddingItem:item];
    }else {
        self.itemToEdit.text = self.textField.text;
        [self.delegate getCCC];
        [self.delegate ItemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
    
}
-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    return nil;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range
                                                                withString:string];
    
    if([newText length] >0){
        
        self.doneBarButton.enabled = YES;
    }else{
        self.doneBarButton.enabled = NO;
    }
    
    return YES;
}
@end

