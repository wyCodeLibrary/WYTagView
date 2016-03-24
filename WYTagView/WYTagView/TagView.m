//
//  TagView.m
//  
//
//  Created by QianLong Mac on 16/3/21.
//
//

#import "TagView.h"
@implementation TagView
NSString * const AMTagViewNotification = @"AMTagViewNotification";
NSString * const TagViewNotification = @"TagViewNotification";

- (id)initWithFrame:(CGRect)frame show:(BOOL)show
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.button setBackgroundImage:[self image:@"标签_选中"] forState:UIControlStateNormal];
        if (show == NO) {
         [self.button setBackgroundImage:[self image:@"标签_未选中"] forState:UIControlStateSelected];
        }
        [self.delect setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        self.textlabel.textAlignment = NSTextAlignmentCenter;
        [self.button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self.delect addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        [self addSubview:self.textlabel];
        [self addSubview:self.delect];
    }
    return self;
}

-(void)click:(UIButton *)button{
      [[NSNotificationCenter defaultCenter] postNotification:[[NSNotification alloc] initWithName:AMTagViewNotification object:self userInfo:nil]];
}

- (void)tap:(UIButton *)button
{
    
    if (button.selected == NO) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(delect:)]) {
            [self.delegate delect:self];
        }
        button.selected = YES;
        button.userInteractionEnabled = NO;
    }
    else{
        button.selected = NO;
        button.userInteractionEnabled = YES;
    }

}

- (void)setupWithText:(NSString*)text
{
    self.textlabel.text = text;
    
}
-(UILabel *)textlabel{

    if (!_textlabel) {
        _textlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height)];
    }
    return _textlabel;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _button;
    
}
- (UIButton *)delect{

    if (!_delect) {
        _delect = [UIButton buttonWithType:UIButtonTypeCustom];
        _delect.frame =CGRectMake(CGRectGetMaxX(self.textlabel.frame),CGRectGetMinY(self.textlabel.frame)+5 , 10, 10);
    }
    return _delect;
}
- (NSString*)tagText
{
    return self.textlabel.text;
}

-(UIImage *)image:(NSString *)imagestr{
    UIImage * image =[UIImage imageNamed:imagestr];
    UIEdgeInsets insets = UIEdgeInsetsMake(25, 25, 10, 10);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}

@end
