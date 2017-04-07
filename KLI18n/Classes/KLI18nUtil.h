//
//  KLI18nUtil.h
//  KLI18n
//
//  Created by klook on 2017/4/5.
//  Copyright © 2017年 klook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLI18nUtil : NSObject

// 支持的本地化语言
@property (nonatomic, strong) NSArray *supportLocalizes;
// 设备国家代码
@property (nonatomic, strong) NSString *deviceCountryCode;
// 设备语言代码
@property (nonatomic, strong) NSString *deviceLanguageCode;

@property (nonatomic, strong) NSString *defaultLocalize;
@property (nonatomic, strong) NSString *currentLocalize;


+ (instancetype)shareI18nUtil;

+ (NSString *)localizedString:(NSString *)key;

+ (NSString *)localizedString:(NSString *)key defaultValue:(NSString *)defaultValue;

+ (NSString *)localizedString:(NSString *)key defaultValue:(NSString *)defaultValue comment:(NSString *)comment;

- (void)updateLocalizesWithLanguageCode:(NSString *)languageCode;


@end
