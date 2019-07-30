//
//  DocumentOpener.m
//
//
//  Created by Vampire on 2019/7/29.
//

#import "DocumentOpener.h"
#import "DocumentPickViewController.h"
#include <UIKit/UIKit.h>

@interface DocumentOpener ()

@property (strong, nonatomic) UIDocumentInteractionController *FileOpener;
@property (strong, nonatomic) DocumentPickViewController *document;

@end

@implementation DocumentOpener
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(openDocument:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    self.document = [[DocumentPickViewController alloc] init];
    [self.document openDoucument:^(id obj) {
        resolve(JSONSTRING(obj));
    } failure:^(id err) {
        reject(@"DocumentOpener", @"open failure", err);
    }];
}

RCT_REMAP_METHOD(openWithFilePath, filePath:(NSString *)filePath
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:fileURL.path]) {
            NSError *error = [NSError errorWithDomain:@"File not found" code:404 userInfo:nil];
            reject(@"File not found", @"File not found", error);
            return;
        }
        self.FileOpener = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        self.FileOpener.delegate = self;
        UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        BOOL wasOpened = [self.FileOpener presentOpenInMenuFromRect:ctrl.view.bounds inView:ctrl.view animated:YES];
        if (wasOpened) {
            resolve(@"{\"result\":\"open success\"}");
        } else {
            NSError *error = [NSError errorWithDomain:@"Open error" code:500 userInfo:nil];
            reject(@"Open error", @"Open error", error);
        }
    });
}

@end
