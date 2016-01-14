//
//  YKTabBarController.h
//  YKTabBar
//
//  Created by qianzhan on 15/12/4.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKItemDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface YKItem : UIView

@property (assign, nonatomic) BOOL isHighLight;

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) id<YKItemDelegate> delegate;


+ (YKItem*)itemWithTitle:(NSString*)title image:(NSString*)imageName selectedImage:(NSString*)selectedName;

@end


@interface YKTabBarController : UITabBarController

@end
