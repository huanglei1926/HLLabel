//
//  HLCoreTextData.h
//  BaoluoGamePlatform
//
//  Created by lei.huang on 16/9/14.
//  Copyright © 2016年 line. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>


@interface HLCoreTextData : NSObject

@property (assign, nonatomic) CTFrameRef ctFrame;
@property (assign, nonatomic) CGFloat height;
@property (copy, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSAttributedString *content;

@end
