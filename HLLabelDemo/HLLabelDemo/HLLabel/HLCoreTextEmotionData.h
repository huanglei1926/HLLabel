//
//  HLCoreTextEmotionData.h
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HLCoreTextEmotionData : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger position;

// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
@property (nonatomic, assign) CGRect imagePosition;

@end
