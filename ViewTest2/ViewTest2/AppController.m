//
//  AppController.m
//  ViewTest2
//
//  Created by AirMyac on 6/13/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "AppController.h"

@implementation AppController

// enum定義
enum{
    firstViewTag = 0,
    secondViewTag
};

// 各viewのcontroller
NSString *const firstView = @"FirstViewController";
NSString *const secondView = @"SecondViewController";

// びびり
-(IBAction)getPrint:(id)sender{


}
//


-(NSString*)getField{
//    FirstViewController *cont = self.mainViewController;
    NSString *str = [_firstCont first];
    NSLog(@"viewcont:%@",str);
    return str;
}


-(IBAction)fuga:(id)sender{
    NSLog(@"first:%@", [self getField]);
//    NSLog(@"first:%@", @"hige");
}



-(void)awakeFromNib{
    [self changeViewController:firstViewTag];
}

-(IBAction)changeView:(id)sender{
    NSInteger tag = [[sender selectedCell] tag];
    [self changeViewController:tag];
}

-(IBAction)openView:(id)sender{
    NSLog(@"open View");
    self.mainViewController = [[FirstViewController alloc]initWithNibName:firstView bundle:nil];
    
}

-(void)changeViewController:(NSInteger)tag{
    [[_mainViewController view] removeFromSuperview];
    switch (tag) {
        case firstViewTag:
            _firstCont = [[FirstViewController alloc]initWithNibName:firstView bundle:nil];
            self.mainViewController = _firstCont;
            break;
        case secondViewTag:
            _secondCont = [[SecondViewController alloc]initWithNibName:secondView bundle:nil];
            self.mainViewController = _secondCont;
            break;
    }
    [_mainView addSubview:[_mainViewController view]];
    [[_mainViewController view] setFrame:[_mainView bounds]];
}

-(IBAction)printAll:(id)sender{
    NSInteger tag = [[sender selectedCell] tag];
    NSString *hoge;
    int flag = (int)[_btn indexOfSelectedItem];
    NSLog(@"%ld, %d", tag, flag);
    
    
//    switch (tag) {
//        case firstViewTag:
//            hoge = [_firstCont first];
//            NSLog(@"first:%@", hoge);
//            break;
//        case secondViewTag:
//            hoge = [_secondCont first];
//            NSLog(@"second:%@", hoge);
//            break;
//    }

    switch (flag) {
        case 0:
            hoge = [_firstCont first];
            NSLog(@"first:%@", hoge);
            break;
        case 1:
            hoge = [_secondCont first];
            NSLog(@"second:%@", hoge);
            break;
    }

}

@end
