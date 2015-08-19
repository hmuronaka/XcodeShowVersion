//
//  XCodeShowVersion.m
//  XCodeShowVersion
//
//  Created by MuronakaHiroaki on 2015/08/19.
//  Copyright (c) 2015年 hmu. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "XCodeShowVersion.h"
#import "XcodeComponents.h"

@implementation XCodeShowVersion

static XCodeShowVersion* _sharedInstance = nil;

+(void)pluginDidLoad:(NSBundle*)plugin {
    NSLog(@"XcodeShowVersion test!!!");
    [self sharedInstance];
}

#pragma mark class methods.

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark instance methods.

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

-(void)applicationDidFinishLaunching:(NSNotification*)noti {
    NSLog(@"XcodeShowVersion launching!!");
    [self initMenu];
}

-(NSString*)getXcodeVersion {
    IDEWelcomeWindowController* vc = [IDEWelcomeWindowController sharedWelcomeWindowController];
    return vc.versionLabel.stringValue;
}

-(void)initMenu {
    [self addVersionMenu];
}

-(void)addVersionMenu {
    NSMenu* mainMenu = [NSApp mainMenu];
    
    NSMenu *versionMenu = [[NSMenu alloc] initWithTitle:[self getXcodeVersion]];
    NSMenuItem *newMenuItem = [[NSMenuItem alloc] initWithTitle:[self getXcodeVersion] action:NULL keyEquivalent:@""];
    [newMenuItem setSubmenu:versionMenu];
    [mainMenu addItem:newMenuItem];
}

-(void)dmmyAction:(id)obj {
    
}

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end