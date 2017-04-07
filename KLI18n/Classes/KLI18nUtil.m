//
//  KLI18nUtil.m
//  KLI18n
//
//  Created by klook on 2017/4/5.
//  Copyright © 2017年 klook. All rights reserved.
//

#import "KLI18nUtil.h"

@interface KLI18nUtil()

@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation KLI18nUtil


+ (instancetype)shareI18nUtil
{
    static KLI18nUtil *_shareI18nUtil = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _shareI18nUtil = [[self alloc] init];
    });
    
    return _shareI18nUtil;
}

+ (NSBundle *)localizationBundle {
    
    static NSString * bundleName = @"KLI18n-Resources";
    NSString *localizationBundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    if (!localizationBundlePath) {
        localizationBundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:bundleName ofType:@"bundle"];
    }
    
    return localizationBundlePath ? [NSBundle bundleWithPath:localizationBundlePath] : [NSBundle mainBundle];
}

+ (NSString *)localizationTable {
    return @"i18n";
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self updateLocalizesWithLanguageCode:self.defaultLocalize];
    }
    return self;
}

+ (NSString *)localizedString:(NSString *)key
{
    return [self localizedString:key defaultValue:key comment:nil];
}

+ (NSString *)localizedString:(NSString *)key defaultValue:(NSString *)defaultValue
{
    return [self localizedString:key defaultValue:defaultValue comment:nil];
}

+ (NSString *)localizedString:(NSString *)key defaultValue:(NSString *)defaultValue comment:(NSString *)comment
{
    return NSLocalizedStringWithDefaultValue(key, [self localizationTable], [KLI18nUtil shareI18nUtil].bundle, defaultValue, comment);
}


- (void)updateLocalizesWithLanguageCode:(NSString *)languageCode
{
    self.currentLocalize = languageCode;
    NSString *path = [[KLI18nUtil localizationBundle] pathForResource:self.currentLocalize ofType:@"lproj" ];
    self.bundle = [NSBundle bundleWithPath:path];
}

#pragma mark - getter/setter

- (NSArray *)supportLocalizes
{
    if (!_supportLocalizes) {
        NSMutableArray *localizes = [NSMutableArray array];
        NSArray *i18nLocalizes = [[KLI18nUtil localizationBundle] pathsForResourcesOfType:@"lproj" inDirectory:nil];
        for (NSString *i18nLocalize in i18nLocalizes) {
            NSURL *i18nUrl = [NSURL URLWithString:i18nLocalize];
            NSString *fileName = i18nUrl.pathComponents.lastObject;
            
            NSString *localize = [fileName componentsSeparatedByString:@"."].firstObject;
            if (![localizes containsObject:localize]) {
                [localizes addObject:localize];
            }
        }
        _supportLocalizes = [localizes copy];
    }
    return _supportLocalizes;
}

- (NSString *)deviceCountryCode
{
    if (!_deviceCountryCode) {
        NSLocale *currentLocale = [NSLocale currentLocale];
        _deviceCountryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    }
    return _deviceCountryCode;
}

- (NSString *)deviceLanguageCode
{
    if (!_deviceLanguageCode) {
        NSArray *languages = [NSLocale preferredLanguages];
        _deviceLanguageCode = [languages objectAtIndex:0];
    }
    return _deviceLanguageCode;
}


- (NSString *)defaultLocalize
{
    if (!_defaultLocalize) {
        for (NSString *localizeCode in self.supportLocalizes) {
            NSString *localizeCountryCode = [NSString stringWithFormat:@"%@-%@", localizeCode, self.deviceCountryCode];
            if ([localizeCode isEqualToString:self.deviceLanguageCode] || [localizeCountryCode isEqualToString:self.deviceLanguageCode]) {
                _defaultLocalize = localizeCode;
            }
        }
        if (!_defaultLocalize) {
            // 没匹配到 设置为英文
            _defaultLocalize = @"en";
        }
        _currentLocalize = _defaultLocalize;
    }
    return _defaultLocalize;
}

@end
