//
//  xSearchCommand.m
//  xSearch
//
//  Created by cyan on 16/6/19.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "xSearchCommand.h"
#import "xSearch.h"
#import "xTextModifier.h"

@implementation xSearchCommand

+ (NSDictionary *)handlers {
    static NSDictionary *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = @{
            @"xsearch.google": ^NSString *(NSString *text) { return Search(text, @"google"); },
            @"xsearch.developer": ^NSString *(NSString *text) { return Search(text, @"developer"); },
            @"xsearch.translate": ^NSString *(NSString *text) { return Search(text, @"translate"); },
            @"xsearch.stackoverflow": ^NSString *(NSString *text) { return Search(text, @"stackoverflow"); },
            @"xsearch.github": ^NSString *(NSString *text) { return Search(text, @"github"); },
        };
    });
    return _instance;
}

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    [xTextModifier any:invocation handler:self.class.handlers[invocation.commandIdentifier]];
    completionHandler(nil);
}

@end
