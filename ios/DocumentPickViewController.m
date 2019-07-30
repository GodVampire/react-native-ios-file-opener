//
//  DocumentPickViewController.m
//  CRMPro
//
//  Created by ms on 2019/5/31.
//

#import "DocumentPickViewController.h"

@interface DocumentPickViewController ()
    
@end

@implementation DocumentPickViewController

- (void)openDoucument:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock{
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    documentPickerViewController.delegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [vc presentViewController:documentPickerViewController animated:YES completion:nil];
    });
}
    
#pragma mark - UIDocumentPickerDelegate

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller{
    
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        //通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;

        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            //读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            if (error) {
                //读取出错
            } else {
                NSString *filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@", fileName]];
                [fileData writeToFile:filePath atomically:YES];
                self.successBlock(@{@"fileName": fileName, @"filePath": filePath});
            }
        }];
        // iCloud need add
    } else {
        //授权失败
    }
}
@end
