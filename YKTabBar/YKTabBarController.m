//
//  YKTabBarController.m
//  YKTabBar
//
//  Created by qianzhan on 15/12/4.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import "YKTabBarController.h"

@interface YKItem (){
    UIImage *_normalImage;
    UIImage *_highLightImage;
    
    UIImageView *_logImage;
    UILabel *_titleLabel;
    NSString *_text;
}
@end

@implementation YKItem

- (id)initWithTitle:(NSString*)title image:(NSString*)imageName selectedImage:(NSString*)selectedName{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        
        _normalImage = [UIImage imageNamed:imageName];
        _highLightImage = [UIImage imageNamed:selectedName];
        _text = title;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
        
    }
    return self;
}

+ (YKItem*)itemWithTitle:(NSString*)title image:(NSString*)imageName selectedImage:(NSString*)selectedName{
    YKItem *item = [[YKItem alloc] initWithTitle:title image:imageName selectedImage:selectedName];
    return item;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        _logImage  = [[UIImageView alloc] initWithFrame:CGRectMake(50, 5, frame.size.width-20, 25)];
        [self addSubview:_logImage];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 15)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text  = _text;
        [self addSubview:_titleLabel];
    }
    
    return self;
}


- (void)setIsHighLight:(BOOL)isHighLight{
    _isHighLight = isHighLight;
    if (_isHighLight) {
        _logImage.image = _highLightImage;
        _titleLabel.textColor = [UIColor redColor];
    }else{
        _logImage.image = _normalImage;
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
}

- (void)tap{
    if ([self.delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.delegate didSelectItemAtIndex:_index];
    }
}

@end


@interface YKTabBarController ()<YKItemDelegate>
{
    UIView *YKTabbar;
}

@property (nonatomic, strong) NSMutableArray *itemArr;

@end

@implementation YKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabbar];
    [self didSelectItemAtIndex:1];
}

- (NSMutableArray*)itemArr{
    if (!_itemArr) {
        _itemArr = [NSMutableArray array];
    }
    
    return _itemArr;
}

- (void)initTabbar{
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];
    
    YKTabbar = [[UIView alloc] initWithFrame:CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height)];
    YKTabbar.backgroundColor = [UIColor redColor];
    [self.view addSubview:YKTabbar];
    
    CGFloat width = self.view.frame.size.width/3;
    for (int i = 0; i<3; i++) {
        
        if (i != 1) {
            
            YKItem *item = [YKItem itemWithTitle:@"qweqwe" image:@"1" selectedImage:@"10"];
            item.frame = CGRectMake(5+i*width, 5, width-10, rect.size.height-10);
            item.index =i;
            item.delegate = self;
            item.isHighLight = NO;
            [YKTabbar addSubview:item];
            
            [_itemArr addObject:item];
        }else{
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = i;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = rect.size.height/2;
            btn.bounds = CGRectMake(0, 0, rect.size.height, rect.size.height);
            btn.center = CGPointMake(rect.size.width/2, 0);
            btn.backgroundColor = [UIColor orangeColor];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setTitle:@"butt" forState:UIControlStateNormal];
            [YKTabbar addSubview:btn];
            btn.userInteractionEnabled = NO;
            
        }
        
    }
}

- (void)didSelectItemAtIndex:(NSInteger)index{
    
    self.selectedIndex = index;
    [self resetItemStatus];
}



- (void)resetItemStatus{
    for (YKItem *tempItem in _itemArr) {
        if (tempItem.index == self.selectedIndex) {
            tempItem.isHighLight = YES;
        }else{
            tempItem.isHighLight = NO;
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:YKTabbar];
    CALayer *layer = [YKTabbar.layer.sublayers objectAtIndex:1];
    
    NSLog(@"%f %f", layer.frame.origin.x, layer.frame.origin.y);
    if ([layer hitTest:point]) {
        self.selectedIndex = 1;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
