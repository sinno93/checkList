//
//  ViewController.h
//  Checklists
//
//  Created by 郑庆登(Qingdeng Zheng)-IT服务中心 on 15/11/23.
//  Copyright © 2015年 郑庆登(Qingdeng Zheng)-IT服务中心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"
#import "ItemDetailViewController.h"
@interface ViewController : UITableViewController<ItemDetailViewControllerDelegate>


- (IBAction)addItem:(id)sender;
@end

