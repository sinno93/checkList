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

// 实现NSCoding 协议中的encodeWithCoder:(NSCoder*);
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"ItemText"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}
// 实现NSCoding 协议中的initWithCoder
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self =[super init]))
    {
        self.text = [aDecoder decodeObjectForKey:@"ItemText"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}
@end
