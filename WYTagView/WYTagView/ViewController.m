//
//  ViewController.m
//  WYTagView
//
//  Created by QianLong Mac on 16/3/24.
//  Copyright (c) 2016年 wyp. All rights reserved.
//

#import "ViewController.h"
#import "TagView.h"
#import "TagListView.h"
@interface ViewController ()<TaglistViewDelegate ,tagDelegate , UITextFieldDelegate>
@property (nonatomic , strong) UITextField *readTag;
@property (nonatomic , strong) NSMutableArray *alltags;
@property (nonatomic , strong) NSMutableArray *selettags;
@property (nonatomic , strong) TagListView *listView;
@property (nonatomic , strong) TagListView *saveView;
@property (nonatomic, strong) TagView *selection;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self creatData];
    self.readTag.delegate = self;
    __weak ViewController* weakSelf = self;
    [self.listView setTapHandler:^(TagView *view) {
        weakSelf.selection = view;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                        message:[NSString stringWithFormat:@"Delete %@?", [view tagText]]
                                                       delegate:weakSelf
                                              cancelButtonTitle:@"Nope"
                                              otherButtonTitles:@"Sure!", nil];
        [alert show];
        
    }];
    self.listView.deleagte = self;
    
    
}
-(void)amt:(id)amt{
    [self.selettags addObject:amt];
    [self.saveView creatTag:[amt tagText] show:YES];
    
}
-(void)creatData{
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21", nil];
    [self.alltags addObjectsFromArray:array];
    [self.listView creatArrayTags:self.alltags show:NO];
    
}
-(void)creatUI{
    self.saveView.backgroundColor = [UIColor lightGrayColor];
    self.listView.backgroundColor = [UIColor lightGrayColor];
    self.readTag.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.readTag];
    [self.view addSubview:self.saveView];
    [self.view addSubview:self.listView];
}

-(NSMutableArray *)alltags{
    
    if (!_alltags) {
        _alltags = [[NSMutableArray alloc]init];
    }
    return _alltags;
}
-(NSMutableArray *)selettags{
    
    if (!_selettags) {
        _selettags = [[NSMutableArray alloc]init];
    }
    return _selettags;
}

- (TagListView *)listView{
    
    if (!_listView) {
        _listView = [[TagListView alloc]initWithFrame:CGRectMake(0, 100,self.view.frame.size.width, 200)];
    }
    return _listView;
}
- (TagListView *)saveView{
    if (!_saveView) {
        _saveView = [[TagListView alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 200)];
    }
    return _saveView;
    
}
- (UITextField *)readTag{
    
    if (!_readTag) {
        _readTag = [[UITextField alloc]initWithFrame:CGRectMake(0, 310, self.view.frame.size.width, 80)];
    }
    return _readTag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex > 0) {
        [self.saveView removeTag:self.selection];
        [self.selettags enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TagView *tagv = (TagView *)obj;
            if ([tagv.tagText isEqualToString: self.selection.tagText]) {
                [tagv tap:tagv.button];
                *stop = YES;
                if (*stop == YES) {
                    [self.selettags removeObjectAtIndex:idx];
                }
            }
            if (*stop) {
            }
            
        }];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.saveView creatTag:textField.text show:YES];
    [self.readTag setText:@""];
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}

@end
