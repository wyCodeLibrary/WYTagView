//
//  TagView.h
//  
//
//  Created by QianLong Mac on 16/3/21.
//
//

#import <UIKit/UIKit.h>
@class TagView;
#define kDefaultFont			[UIFont systemFontOfSize:14]
#define kDefaultTagLength		10
#define kDefaultTextPadding		10
#define kDefaultTextColor		[UIColor whiteColor]
extern NSString * const AMTagViewNotification;

extern NSString * const TagViewNotification;

@protocol tagDelegate <NSObject>

-(void)delect:(TagView *)View;

-(void)delectBtn:(TagView *)view;

@end

@interface TagView : UIView

@property (nonatomic , strong) UILabel * textlabel;
@property (nonatomic , strong) UIButton * button;
@property (nonatomic , strong) UIButton * delect;
@property (nonatomic , strong)  UIFont* textFont;
@property (nonatomic, assign) float		textPadding;
@property (nonatomic, assign) float		tagLength;
@property (nonatomic, strong) UIColor	*tagColor;
@property (nonatomic, assign) id<tagDelegate> delegate;
-(void)setupWithText:(NSString *)text;
-(NSString *)tagText;
- (void)tap:(UIButton *)button;
- (id)initWithFrame:(CGRect)frame show:(BOOL)show;

@end
