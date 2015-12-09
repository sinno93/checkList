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

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ChecklistItemxx"];
    UILabel *label = (UILabel*)[cell viewWithTag:1993];
    NSInteger x = indexPath.row%5;
    if( x== 0){
        label.text = @"吃晚饭";
    }else if(x==1){
        label.text=@"买pc配件";
    }else if(x == 2){
        label.text = @"继续学习";
    }else if (x == 3){
        label.text = @"休息一会儿";
    }else if(x == 4){
        label.text = @"继续学习";
    }
    
    
    return cell;
    
}
@end
