//
//  ViewController.m
//  GetPoint
//
//  Created by 北冥 on 2016/11/8.
//  Copyright © 2016年 BM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *PointX11;
@property (strong, nonatomic) IBOutlet UITextField *PointX12;
@property (strong, nonatomic) IBOutlet UITextField *PointX21;
@property (strong, nonatomic) IBOutlet UITextField *PointX22;

@property (strong, nonatomic) IBOutlet UITextField *PointY11;
@property (strong, nonatomic) IBOutlet UITextField *PointY12;
@property (strong, nonatomic) IBOutlet UITextField *PointY21;
@property (strong, nonatomic) IBOutlet UITextField *PointY22;

@property (strong, nonatomic) IBOutlet UILabel *lblLine1;
@property (strong, nonatomic) IBOutlet UILabel *lblLine2;
@property (strong, nonatomic) IBOutlet UILabel *lblLine22;

@property (strong, nonatomic) IBOutlet UILabel *lblPointX;
@property (strong, nonatomic) IBOutlet UILabel *lblPointY;

@end

@implementation ViewController
{
    NSMutableArray *textfieldArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    textfieldArr = [NSMutableArray new];
    [textfieldArr addObject:_PointX11];
    [textfieldArr addObject:_PointX12];
    [textfieldArr addObject:_PointX21];
    [textfieldArr addObject:_PointX22];
    [textfieldArr addObject:_PointY11];
    [textfieldArr addObject:_PointY12];
    [textfieldArr addObject:_PointY21];
    [textfieldArr addObject:_PointY22];
}

- (IBAction)jisuan:(id)sender {
   
    if(_PointX11.text.length && _PointX12.text.length && _PointX21.text.length && _PointX22.text.length && _PointY11.text.length &&_PointY12.text.length && _PointY21.text.length &&_PointY22.text.length) {
        [self textfiledRegis];
        
//        CGPoint point11 = CGPointMake(1, 3);
//        CGPoint point12 = CGPointMake(2, 6);
//        CGPoint point21 = CGPointMake(1, 5);
//        CGPoint point22 = CGPointMake(-1, 3);
//        x:2.000000 ,y:6.000000
        
        CGPoint point11 = CGPointMake([_PointX11.text floatValue], [_PointY11.text floatValue]);
        CGPoint point12 = CGPointMake([_PointX12.text floatValue], [_PointY12.text floatValue]);
        CGPoint point21 = CGPointMake([_PointX21.text floatValue], [_PointY21.text floatValue]);
        CGPoint point22 = CGPointMake([_PointX22.text floatValue], [_PointY22.text floatValue]);
        float K1,K2,N1,N2;
        float x,y;
        K1 = [self getLineK:point11 Point2:point12 ConstN:&N1];
        K2 = [self getLineK:point21 Point2:point22 ConstN:&N2];
        if(K1 == K2){
            UIAlertController *alert=  [UIAlertController alertControllerWithTitle:@"提示" message:@"两条直线平行，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击取消");
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"重置输入" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击取消");
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            

            return ;
        }
        x = (N2 - N1 )/(K1 - K2);
        y = K1 * x + N1;
        NSLog(@"x:%f ,y:%f",x,y);
        _lblPointX.text = [NSString stringWithFormat:@"%f",x];
        _lblPointY.text = [NSString stringWithFormat:@"%f",y];
    
        _lblLine1.text = [NSString stringWithFormat:@"y1 = %0.1fx + %0.1f",K1,N1];
        _lblLine2.text = [NSString stringWithFormat:@"y2 = %0.1fx + %0.1f",K2,N2];
    }else {
       
        
        UIAlertController *alert=  [UIAlertController alertControllerWithTitle:@"提示" message:@"输入不完整" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
- (void)textfiledRegis {
    for(UITextField *field in textfieldArr) {
        [field resignFirstResponder];
    }
}

- (void)textfieldChongzhi {
    for(UITextField *field in textfieldArr) {
        field.text = @"";
    }
}
- (float)getLineK:(CGPoint)point1 Point2:(CGPoint)point2 ConstN:(float *)N{
    float K = (point1.y - point2.y)/(point1.x - point2.x) ;
    *N = point1.y - K * point1.x;
    return K;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
