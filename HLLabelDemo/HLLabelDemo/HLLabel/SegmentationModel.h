//
//  SegmentationModel.h
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CoreTextDataType) {
    CoreTextDataTypeText = 1,
    CoreTextDataTypeEmotion = 2,
    CoreTextDataTypeImage = 3,
};
@interface SegmentationModel : NSObject

@property (nonatomic, assign) CoreTextDataType type;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGSize emotionSize;

@property (nonatomic, assign) NSRange emotionRange;
//@property (nonatomic, assign) CGFloat height;

@end
