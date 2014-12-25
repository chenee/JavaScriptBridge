//
//  JSContext+JavaScriptBridge.m
//  JavaScriptBridge
//
//  Created by kishikawa katsumi on 2014/01/04.
//  Copyright (c) 2014 kishikawa katsumi. All rights reserved.
//

#import "JSContext+JavaScriptBridge.h"
#import "JSBScriptingSupport+Private.h"

#import <SpriteKit/SKLabelNode.h>
#import <SpriteKit/SKSpriteNode.h>

@implementation JSContext (JavaScriptBridge)

- (void)addScriptingSupport:(NSString *)framework
{
    [JSBScriptingSupport setupSupportFunctionsToContext:self];
    
    static NSMapTable *hashTables;
    if (!hashTables) {
        hashTables = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory];
    }
    
    NSHashTable *frameworks = [hashTables objectForKey:self];
    if (!frameworks) {
        frameworks = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        [hashTables setObject:frameworks forKey:self];
    }
    
    NSString *prefix = @"JSB";
    id classObject = NSClassFromString([NSString stringWithFormat:@"%@%@", prefix, framework]);
    if (classObject && ![frameworks containsObject:framework]) {
        SEL selector = NSSelectorFromString(@"addScriptingSupportToContext:");
        
        NSMethodSignature *methodSignature = [classObject methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = classObject;
        invocation.selector = selector;
        
        JSContext *context = self;
        [invocation setArgument:&context atIndex:2];
        
        [invocation invoke];
        
        [frameworks addObject:framework];
    }
}

-(void)addCreator
{
    self[@"create_withSize"] = ^(NSString *className,CGSize size){
        Class aClass = NSClassFromString(className);
        id anInstance;
        anInstance = [[aClass alloc]initWithSize:size];

        return anInstance;
    };
    self[@"create_withFrame"] = ^(NSString *className,CGRect bounds){
        Class aClass = NSClassFromString(className);
        id anInstance;
        anInstance = [[aClass alloc]initWithFrame:bounds];

        return anInstance;
    };

    self[@"create_withStyle"] = ^(NSString *className,NSInteger styleID){
        Class aClass = NSClassFromString(className);
        id anInstance;
        anInstance = [[aClass alloc]initWithStyle:styleID];

        return anInstance;
    };

    self[@"create_withStyleReuseIdentifier"] = ^(NSString *className,NSInteger styleID,NSString* identifier){
        Class aClass = NSClassFromString(className);
        id anInstance;
        anInstance = [[aClass alloc]initWithStyle:styleID reuseIdentifier:identifier];

        return anInstance;
    };

    self[@"create_alert"] = ^(NSString *title,NSString* msg,NSString* cancel,NSString* ok){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                       message:msg
                                                      delegate:nil
                                             cancelButtonTitle:cancel otherButtonTitles:ok, nil];

        return alert;
    };
    self[@"create_collectionVC"] = ^(){
        UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];

        UICollectionViewController * obj = [[UICollectionViewController alloc]initWithCollectionViewLayout:flow];

        return obj;
    };

    self[@"create_action"] = ^(NSString*className, id target,NSString* sel){

        Class aClass = NSClassFromString(className);
        id anInstance;
        anInstance = [[aClass alloc]initWithTarget:target action:NSSelectorFromString(sel)];

        return anInstance;
    };


    //=======
    self[@"create_SKLabelNode_withFont"] = ^(NSString*className, NSString* fontName){

        Class aClass = NSClassFromString(className);
        id anInstance;
//        anInstance = [SKLabelNode labelNodeWithFontNamed:fontName];
        anInstance = [aClass labelNodeWithFontNamed:fontName];

        return anInstance;
    };

    self[@"create_SKSpriteNode_withImg"] = ^(NSString*className, NSString* imgName){

        Class aClass = NSClassFromString(className);
        id anInstance;
        anInstance = [aClass spriteNodeWithImageNamed:imgName];

        return anInstance;
    };

}

@end
