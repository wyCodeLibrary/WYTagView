//
//  TagListView.m
//  
//
//  Created by QianLong Mac on 16/3/22.
//
//

#import "TagListView.h"
#import "TagView.h"
@interface TagListView ()<tagDelegate>
@property (nonatomic, copy) AMTagListViewTapHandler tapHandler;
@property (nonatomic, copy) TagListViewTapHandler tapHandlers;
@property (nonatomic, strong) id orientationNotification;
@property (nonatomic, strong) id tagNotification;
@property (nonatomic, strong) id tagNotifications;

@end
@implementation TagListView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame] ) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    _marginX = 4;
    _marginY = 4;
    _tags = [@[] mutableCopy];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        self.orientationNotification = [center addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            [self rearrangeTags];
        }];
    self.tagNotification = [center addObserverForName:AMTagViewNotification object:nil queue:nil usingBlock:^(NSNotification *notification) {
        if (_tapHandler) {
            self.tapHandler(notification.object);
            
        }
    }];
    self.tagNotification = [center addObserverForName:TagViewNotification object:nil queue:nil usingBlock:^(NSNotification *notification) {
        if (_tapHandlers) {
            self.tapHandlers(notification.object);
            
        }
    }];

    
}
- (void)setTapHandler:(AMTagListViewTapHandler)tapHandler
{
    _tapHandler = tapHandler;
}
- (void)setTapHandlers:(TagListViewTapHandler)tapHandlers
{
    _tapHandlers = tapHandlers;
}

-(void)creatTag:(NSString *)str show:(BOOL)show{
    
    UIFont* font = [[TagView appearance] textFont] ? [[TagView appearance] textFont] : kDefaultFont;
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName: font}];
    float padding = [[TagView appearance] textPadding] ? [[TagView appearance] textPadding] : kDefaultTextPadding;
    float tagLength = [[TagView appearance] tagLength] ? [[TagView appearance] tagLength] : kDefaultTagLength;
    size.width = (int)size.width + padding * 2 + tagLength;
    size.height = (int)size.height + padding;
    size.width = MIN(size.width, self.frame.size.width - self.marginX * 2 );
    
    TagView* tagViews = [[TagView alloc] initWithFrame:(CGRect){0, 0, size.width, size.height} show:show];
    if (show == NO) {
        tagViews.delect.hidden = YES;
    }
    tagViews.delegate = self;
    [tagViews setupWithText:str];
    [self.tags addObject:tagViews];
    [self rearrangeTags];
    
}

-(void)delect:(TagView *)View{

    if (self.deleagte && [self.deleagte respondsToSelector:@selector(amt:)]) {
        [self.deleagte amt:View];
    }
    
}
-(void)delectBtn:(TagView *)view{

    if (self.deleagte && [self.deleagte respondsToSelector:@selector(amBtn:)]) {
        [self.deleagte amBtn:view];
    }
}


-(void)creatArrayTags:(NSMutableArray *)array show:(BOOL)show{
    if (show == NO) {
        for (NSString *str in array) {
            [self creatTag:str show:NO];
        }
    }
    else{
        for (NSString *str in array) {
            [self creatTag:str show:YES];
        }
        
    }
    
}

-(void)selectTag:(TagView *)titleStr{
    [self removeTag:titleStr];
}

- (void)rearrangeTags
{
    [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    __block float maxY = 0;
    __block float maxX = 0;
    __block CGSize size;
    [self.tags enumerateObjectsUsingBlock:^(TagView* obj, NSUInteger idx, BOOL *stop) {
        size = obj.frame.size;
        [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[TagView class]]) {
                maxY = MAX(maxY, obj.frame.origin.y);
            }
        }];
        
        [self.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[TagView class]]) {
                if (obj.frame.origin.y == maxY) {
                    maxX = MAX(maxX, obj.frame.origin.x + obj.frame.size.width);
                }
            }
        }];
        
        // Go to a new line if the tag won't fit
        if (size.width + maxX > (self.frame.size.width - self.marginX)) {
            maxY += size.height + self.marginY;
            maxX = 0;
        }
        obj.frame = (CGRect){maxX + self.marginX, maxY, size.width, size.height};
        [self addSubview:obj];
    }];
    if (size.height +self.marginY> self.frame.size.height) {
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,maxY + size.height +self.marginY);
    }
}


-(void)removeTag:(TagView *)str{
    
    [self.tags removeObject:str];
    [self rearrangeTags];
}

- (TagView *)views{

    if (!_views) {
        _views = [[TagView alloc]init];
    }
    return _views;
}

- (void)deleteNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:_tagNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:_orientationNotification];
}

@end
