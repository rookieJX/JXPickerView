//
//  JXProvincesModel.m
//  JXPickerView
//
//  Created by 王加祥 on 16/4/25.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXProvincesModel.h"

@implementation JXProvincesModel

+ (instancetype)provincesWithDict:(NSDictionary *)dict {
    JXProvincesModel * model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
