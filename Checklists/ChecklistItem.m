//
//  ChecklistItem.m
//  Checklists
//
//  Created by 郑庆登(Qingdeng Zheng)-IT服务中心 on 15/12/10.
//  Copyright © 2015年 郑庆登(Qingdeng Zheng)-IT服务中心. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem
- (void)toggleCheckMark{
    self.checked = !self.checked;
}
@end
