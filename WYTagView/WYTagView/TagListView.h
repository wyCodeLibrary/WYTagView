//
//  TagListView.h
//  
//
//  Created by QianLong Mac on 16/3/22.
//
//

#import <UIKit/UIKit.h>
@class TagView;
typedef void (^AMTagListViewTapHandler)(TagView*);
typedef void (^TagListViewTapHandler)(TagView*);
@protocol TaglistViewDelegate <NSObject>

-(void)amt:(id)amt;

-(void)amBtn:(TagView *)amt;

@end
@interface TagListView : UIView

@property (nonatomic, assign) float marginX;

@property (nonatomic, assign) float marginY;

@property (nonatomic, strong) NSMutableArray *tags;

@property (nonatomic , strong) TagView *views;

@property (nonatomic , assign) BOOL hideBlcok;

@property (nonatomic , assign) id<TaglistViewDelegate> deleagte;

-(void)creatTag:(NSString *)str show:(BOOL)show;

-(void)creatArrayTags:(NSMutableArray *)array show:(BOOL)show;

-(void)removeTag:(TagView *)str;

- (void)setTapHandler:(AMTagListViewTapHandler)tapHandler;

- (void)setTapHandlers:(TagListViewTapHandler)tapHandlers;

@end
