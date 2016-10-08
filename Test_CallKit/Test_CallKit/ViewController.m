//
//  ViewController.m
//  Test_CallKit
//
//  Created by 熊济源 on 2016/9/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "ViewController.h"
#import "CallDirectoryHandler.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIButton *btn;
    NSArray *numTest;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"JS更新代码" forState:UIControlStateNormal];
    [btn.layer setCornerRadius:10];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [btn.layer setBorderWidth:0.1];
    [btn addTarget:self action:@selector(updateNum1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self setArray];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateNum1{
    //将号码以NSArray的形式保存，转换为NSString再转换为CXCallDirectoryPhoneNumber
    for (int k=0; k<numTest.count; k++) {
        NSString *num = [numTest objectAtIndex:k];
        CXCallDirectoryPhoneNumber phoneNumbers[]={[num longLongValue]};
        
        NSUInteger count = (sizeof(phoneNumbers) / sizeof(CXCallDirectoryPhoneNumber));
        for (NSUInteger i = 0; i < count; i ++) {
            NSString *nss =[NSString stringWithFormat:@"%lld", phoneNumbers[i]];
            NSLog(@"%@",nss);
        }
    }
}

-(void)setArray{
    numTest =@[@"12",@"134"];
    NSLog(@"%@",numTest);
}



@end
