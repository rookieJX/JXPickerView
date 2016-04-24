//
//  JXProvincesModel.h
//  JXPickerView
//
//  Created by 王加祥 on 16/4/25.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXProvincesModel : NSObject

+ (instancetype)provincesWithDict:(NSDictionary *)dict;

/** 城市 */
@property (nonatomic,strong) NSArray * cities;

/** 省份 */
@property (nonatomic,strong) NSString * name;


@end
