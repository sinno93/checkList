//
//  ChecklistItem.h
//  Checklists
//
//  Created by 郑庆登(Qingdeng Zheng)-IT服务中心 on 15/12/10.
//  Copyright © 2015年 郑庆登(Qingdeng Zheng)-IT服务中心. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject

@property(nonatomic,copy)   NSString *text;
@property(nonatomic,assign) BOOL     checked;
- (void)toggleCheckMark;
@end
