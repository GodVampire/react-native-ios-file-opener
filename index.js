import { NativeModules, Platform } from 'react-native';

const DocumentOpener = NativeModules.DocumentOpener;
const isIos = Platform.OS === 'ios';
const majorVersionIOS = parseInt(Platform.Version, 10);

/**
 *  打开iOS 文件app  (iOS only)。
 */
export const openIOSFileApp = () => (isIos && majorVersionIOS >= 11) ? DocumentOpener.openDocument() : Promise.resolve();

/**
 * iOS 用其他文件打开 (iOS only)。
 * @param {string} filePath 文件路径
 */
export const openWithFilePath = (filePath) => isIos ? DocumentOpener.openWithFilePath(filePath) : Promise.resolve();
