//
//  SegmentationTool.h
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegmentationModel.h"
@class HLCTFrameParserConfig;

@interface SegmentationTool : NSObject

+ (NSArray *)segmentationString:(NSString *)textStr WithConfig:(HLCTFrameParserConfig *)config;

@end
