//
//  TaskSource.m
//  CoreDataTest
//
//  Created by AirMyac on 6/3/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "TaskSource.h"
#import "Notebook.h"


@implementation TaskSource

@dynamic task_name;
@dynamic interval;
@dynamic last_execute_time;
@dynamic note_title;
@dynamic tag;
@dynamic params;
@dynamic type;
@dynamic notebook;

-(void)print{
    NSLog(@"{\n"
          "\ttask_name:%@\n"
          "\type:%@\n"
          "\tinterval:%@\n"
          "\tlast_execte_time:%@\n"
          "\tnote_title:%@\n"
          "\ttag:%@\n"
          "\tparams:%@\n"
          "\tnotebook_guid:%@\n"
          "\tnotebook_name:%@\n}",
          self.task_name, self.type, self.interval, self.last_execute_time, self.note_title, self.tag, self.params, self.notebook.guid, self.notebook.name);
}

@end
