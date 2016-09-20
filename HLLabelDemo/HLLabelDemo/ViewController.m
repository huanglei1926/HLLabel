//
//  ViewController.m
//  HLLabelDemo
//
//  Created by lei.huang on 16/9/20.
//  Copyright © 2016年 len.wang. All rights reserved.
//

#import "ViewController.h"
#import "HLLabel.h"
#import "HLCTFrameParser.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

@interface ViewController ()

@property (nonatomic, strong) HLLabel *contentLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpLabel];
}

- (void)setUpLabel
{
    _contentLabel = [[HLLabel alloc] init];
    _contentLabel.backgroundColor = UIColorFromRGB(0xf2f2f2);
    NSString *text = @"就是这么任性，呵呵哈哈哈哈哈哈[em:b026][em:b026][em:b026][em:b025][em:b030][em:b030][em:b037][em:b035]我也是醉了";
    
    HLCTFrameParserConfig *config = [[HLCTFrameParserConfig alloc] init];
    config.width = CGRectGetWidth([UIScreen mainScreen].bounds) - 22;
    config.fontSize = 13;
    config.textColor = UIColorFromRGB(0x333333);
    config.emotionSize = CGSizeMake(20, 20);
    config.lineSpace = 3.0f;
    
    HLCoreTextData *textContainer = [HLCTFrameParser parseTemplateText:text config:config];
    _contentLabel.frame = CGRectMake(11, 100, [UIScreen mainScreen].bounds.size.width - 22, textContainer.height);
    _contentLabel.data = textContainer;
    [self.view addSubview:_contentLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
