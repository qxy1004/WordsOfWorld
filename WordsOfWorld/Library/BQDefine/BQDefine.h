//
//  BQDefine.h
//
//  Created by Brian Quan on 19/04/2013.
//  QXY1004@GMAIL.COM
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

//****************************************************************//****************************************************************//****************************************************************
//Debug/Release
#ifdef DEBUG
//Debug Mode
#else
//Release Mode
#define NSLog(...) {};
#endif
//****************************************************************//****************************************************************//****************************************************************
//Simulator/Device
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif
//****************************************************************//****************************************************************//****************************************************************
//ARC/Non-ARC
#if __has_feature(objc_arc)
//Compiling with ARC
#else
//Compiling without ARC
#endif
//****************************************************************//****************************************************************//****************************************************************
//Image
#define ResizableImage(name,top,left,bottom,right)              [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#define ResizableImageWithMode(name,top,left,bottom,right,mode) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]
//****************************************************************//****************************************************************//****************************************************************
//file
//UTF-8
#define FileString(name,ext)     [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)] encoding:NSUTF8StringEncoding error:nil]
#define FileDictionary(name,ext) [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)]]
#define FileArray(name,ext)      [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(name) ofType:(ext)]]
//****************************************************************//****************************************************************//****************************************************************
//NSLog
#define LogFrame(f) NSLog(@"\nx:%f\ny:%f\nwidth:%f\nheight:%f\n",f.origin.x,f.origin.y,f.size.width,f.size.height)
#define LogBool(b)  NSLog(@"%@",b?@"YES":@"NO");
//****************************************************************//****************************************************************//****************************************************************
//UIAlert
#define Alert(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show]
//****************************************************************//****************************************************************//****************************************************************
//App
#define kApp ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kNav ((AppDelegate *)[UIApplication sharedApplication].delegate.navigationController)
//****************************************************************//****************************************************************//****************************************************************
//Color
#define RGB(r, g, b)            [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1.0]
#define RGBAlpha(r, g, b, a)    [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]
#define RGB255(r, g, b)         [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGB255Alpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define RGBHex(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
//****************************************************************//****************************************************************//****************************************************************
//Convert
#define IToS(number) [NSString stringWithFormat:@"%d",number]
#define FToS(number) [NSString stringWithFormat:@"%f",number]
#define DATE(stamp) [NSDate dateWithTimeIntervalSince1970:[stamp intValue]];
//****************************************************************//****************************************************************//****************************************************************
//Device Screen
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kScreenFrame    (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))
#define kScreenCenterX  kScreen_Width/2
#define kScreenCenterY  kScreen_Height/2
#define kScreenStatusBarHeight 20
#define kScreenNavigationBarHeight 44
#define kScreenNavigationBarHeightLandScape (isPad?44:32)
#define kScreenToolBarHeight 49
//****************************************************************//****************************************************************//****************************************************************
//Content Screen
#define kContentHeight   ([UIScreen mainScreen].applicationFrame.size.height)
#define kContentWidth    ([UIScreen mainScreen].applicationFrame.size.width)
#define kContentFrame    (CGRectMake(0, 0 ,kContent_Width,kContent_Height))
#define kContentCenterX  kContent_Width/2
#define kContentCenterY  kContent_Height/2
//****************************************************************//****************************************************************//****************************************************************
//GCD
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
//****************************************************************//****************************************************************//****************************************************************
//Device
#define isIOS4      ([[[UIDevice currentDevice] systemVersion] intValue]==4)
#define isIOS5      ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define isIOS6      ([[[UIDevice currentDevice] systemVersion] intValue]==6)
#define isAfterIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]>4)
#define isAfterIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]>5)
#define isAfterIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]>6)
#define iOSVersion  ([[[UIDevice currentDevice] systemVersion] floatValue])
#define isRetina    ([[UIScreen mainScreen] scale]==2)
#define isIPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//****************************************************************//****************************************************************//****************************************************************
//Phone
#define canTel                 ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]])
#define tel(phoneNumber)       ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define telprompt(phoneNumber) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]])
//****************************************************************//****************************************************************//****************************************************************
//OpenURL
#define canOpenURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define openURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])