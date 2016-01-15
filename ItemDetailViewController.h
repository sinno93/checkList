//
//  AddItemViewController.h
//  Checklists
//
//  Created by 郑庆登(Qingdeng Zheng)-IT服务中心 on 15/12/22.
//  Copyright © 2015年 郑庆登(Qingdeng Zheng)-IT服务中心. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemDetailViewController;
@class ChecklistItem;
@protocol ItemDetailViewControllerDelegate <NSObject>
-(void)ItemDetailViewControllerDidCancel:(ItemDetailViewController*)controller;
-(void)ItemDetailViewController:(ItemDetailViewController*)controller
         didFinishAddingItem:(ChecklistItem*)item;
-(void)ItemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;
-(void)getCCC;
@end
@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>

- (IBAction)addItemCancelButton:(id)sender;
- (IBAction)addItemDoneButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property(nonatomic,weak) id <ItemDetailViewControllerDelegate> delegate;
@property(nonatomic,strong) ChecklistItem *itemToEdit;
@end
