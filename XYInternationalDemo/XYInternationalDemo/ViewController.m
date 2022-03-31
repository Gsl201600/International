//
//  ViewController.m
//  XYInternationalDemo
//
//  Created by Yostar on 2020/6/10.
//  Copyright © 2020 Yostar. All rights reserved.
//

#import "ViewController.h"
#import "NSBundle+XY.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [XYBundleSubClass setMainBundleLanguage:@"ja"];
    [self configUI];
}

- (void)configUI{
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, self.view.bounds.size.width - 60, 44)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 150, self.view.bounds.size.width - 60, 44);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:NSLocalizedString(@"支付", nil) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(30, 220, self.view.bounds.size.width - 60, 44);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:NSLocalizedStringFromTable(@"初始化", @"MyString", nil) forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didBtnClicked2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 290, (self.view.bounds.size.width - 65)/2, (self.view.bounds.size.width - 65)/2)];
    imageView1.image = [UIImage imageNamed:@"3.jpg"];
    [self.view addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 + 2.5, 290, (self.view.bounds.size.width - 65)/2, (self.view.bounds.size.width - 65)/2)];
    imageView2.image = [UIImage imageNamed:NSLocalizedStringFromTable(@"3.jpg", @"MyImage", nil)];
    [self.view addSubview:imageView2];
}

- (void)didBtnClicked{
    NSLog(@":::%@", self.textField.text);
    
    [NSBundle setUserLanguage:@"ja"];
    
    UIApplication.sharedApplication.keyWindow.rootViewController = [[ViewController alloc] init];
//    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController *vc = [sb instantiateInitialViewController];
//    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    
    //更新当前storyboard
//    UITabBarController *tbc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
//    tbc.selectedIndex = 2;
//    DALanguageSettingsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([DALanguageSettingsViewController class])];
//    UINavigationController *nvc = tbc.selectedViewController;
//    NSMutableArray *vcs = nvc.viewControllers.mutableCopy;
//    [vcs addObject:vc];
//    //解决奇怪的动画bug。异步执行
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [UIApplication sharedApplication].keyWindow.rootViewController = tbc;
//        nvc.viewControllers = vcs;
//        NSLog(@"已切换到语言 %@", [NSBundle currentLanguage]);
//    });
}

- (void)didBtnClicked2{
    NSLog(@"%@", @"ddddd");
}

@end
