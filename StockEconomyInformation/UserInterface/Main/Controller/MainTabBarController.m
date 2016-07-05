//
//  MainTabBarController.m
//  StockEconomyInformation
//
//  Created by 陆金鑫 on 16/1/8.
//  Copyright © 2016年 陆金鑫. All rights reserved.
//

#import "MainTabBarController.h"
#import "Common.h"

@interface MainTabBarController () {
    UIImageView *_tabBarView;
    UIImageView *_selectedImgView;
    
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createViewControllers];
    
    [self _removeTabBarSubviews];
    
    [self _createTabBarView];
    
}

//------------------------------创建子控制器----------------------------
- (void)_createViewControllers {
    
    //故事版的名字
    NSArray *storyboardNames = @[@"Home", @"List", @"Options", @"News", @"More"];
    //五个控制器
    NSMutableArray *viewCtrls = [NSMutableArray arrayWithCapacity:storyboardNames.count];
    for (int i = 0; i < storyboardNames.count; i++) {
        NSString *sbName = [storyboardNames objectAtIndex:i];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
        //从故事版加载
        UIViewController *viewCtrl = [sb instantiateInitialViewController];
        
        [viewCtrls addObject:viewCtrl];
    }
    
    self.viewControllers = viewCtrls;
    
}


//--------------------------移除 TabBar 上的默认的按钮------------------------
- (void)_removeTabBarSubviews {
    
    NSArray *subviews = self.tabBar.subviews;
    
    for (UIView *view in subviews) {
        
        //定义 UITabBarButton 类
        Class tabBarButtonClass = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:tabBarButtonClass]) {
            [view removeFromSuperview];
        }
    }
    
}


//----------------------------创建 TabBar 上的按钮-------------------------
- (void)_createTabBarView {
    
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    
//    _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 49)];
    
//    _tabBarView.userInteractionEnabled = YES;
    
    _tabBarView.image = [UIImage imageNamed:@"tabBar_bg"];
    
    [self.tabBar addSubview:_tabBarView];
    
    CGFloat buttonWidth = KScreenWidth/5.0;
    
    _selectedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 49)];
    
    _selectedImgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_selected"]];
    
//    _selectedImgView.image = [UIImage imageNamed:@"tab_selected"];
    _selectedImgView.alpha = 0.8;
    
    [self.tabBar addSubview:_selectedImgView];
    
    NSArray *imgNames = @[@"tab_home", @"tab_list", @"tab_options", @"tab_news", @"tab_more"];
    
    for (int i = 0; i <imgNames.count; i++) {
        NSString *imgName = imgNames[i];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, 49)];
        
        button.tag = i;
        
        [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
    }
    
    
    
}


- (void)buttonAction:(UIButton *)button {
    
    self.selectedIndex = button.tag;
    
    [UIView animateWithDuration:.3 animations:^{
        _selectedImgView.center = button.center;
    }];
    
    
    
    
    
    
}





























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
