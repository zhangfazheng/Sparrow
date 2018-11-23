//
//  NetWorkManager.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//
import Foundation
import UIKit
import AFNetworking
import Argo
import AVFoundation


class NetWorkManager: AFHTTPSessionManager {
    enum HttpRequestType {
        case HttpRequestTypeGet
        case HttpRequestTypePost
    }
    
    
    
    static let shareManager: NetWorkManager = {
        let manager = NetWorkManager(baseURL:URL(string: BaseURL))
        
        /**设置请求超时时间*/
        manager.requestSerializer.timeoutInterval = 15
        /**设置相应的缓存策略*/
        manager.requestSerializer.cachePolicy =  NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /**设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
        //manager.requestSerializer.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        
        /**分别设置响应的序列化器*/
        let response: AFJSONResponseSerializer = AFJSONResponseSerializer()
        
        response.removesKeysWithNullValues = true;
        
        /**设置接受的类型*/
        let contentTypes:Set = Set(arrayLiteral: "text/plain","application/json","text/json","text/javascript","text/html")
        response.acceptableContentTypes = contentTypes;
        
        manager.responseSerializer = response;
        
        return manager
    }()
    

    override init(baseURL url: URL?, sessionConfiguration configuration: URLSessionConfiguration?) {
        super.init(baseURL: url, sessionConfiguration: configuration)
        self.requestSerializer.timeoutInterval = 15
        /**设置相应的缓存策略*/
        self.requestSerializer.cachePolicy =  NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        self.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /**设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
        //manager.requestSerializer.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        
        /**分别设置响应的序列化器*/
        let response: AFJSONResponseSerializer = AFJSONResponseSerializer()
        
        response.removesKeysWithNullValues = true;
        
        /**设置接受的类型*/
        let contentTypes:Set = Set(arrayLiteral: "text/plain","application/json","text/json","text/javascript","text/html")
        response.acceptableContentTypes = contentTypes;
        
        self.responseSerializer = response;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 网络请求的类方法---get/post
    
    /**
     *  网络请求的实例方法
     *
     *  @param type         get / post
     *  @param urlString    请求的地址
     *  @param paraments    请求的参数
     *  @param successBlock 请求成功的回调
     *  @param failureBlock 请求失败的回调
     *  @param progress 进度
     */
    public func request(type:HttpRequestType,urlString:String,paraments:Any,success:@escaping (JSON)->(),failure:@escaping (Error)->(),progress:@escaping (Int64)->()){
        switch type {
        case .HttpRequestTypeGet:do {
            NetWorkManager.shareManager.get(urlString, parameters: paraments, progress: { (downloadProgress) in
                progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount)
            }, success: { (_, object) in
                if let reslut = object{
                    success(JSON(reslut))
                }
                
            }, failure: { (_, error) in
                failure(error)
            })
            break
            }
        case .HttpRequestTypePost:do {
            NetWorkManager.shareManager.post(urlString, parameters: paraments, progress: { (uploadProgress) in
                progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount)
            }, success: { (_, object) in
                if let reslut = object{
                    success(JSON(reslut))
                }
                
            }, failure: { (_, error) in
                failure(error)
            })
            break
            }
            
        }
    }

    //MARK: - 多图上传
    /**
     *  上传图片
     *
     *  @param operations   上传图片等预留参数---视具体情况而定 可移除
     *  @param imageArray   上传的图片数组
     *  @parm width      图片要被压缩到的宽度
     *  @param urlString    上传的url---请填写完整的url
     *  @param successBlock 上传成功的回调
     *  @param failureBlock 上传失败的回调
     *  @param progress     上传进度
     *
     */
    public func uploadImage(Operations:[String:Any],imageArray:[UIImage],targetWidth:Float,UrlString:String,success:@escaping (JSON)->(),failure:@escaping (Error)->(),progress:@escaping (Int64)->()){
        NetWorkManager.shareManager.post(UrlString, parameters: Operations, constructingBodyWith: { (formData) in
            var i:Int = 0
            for image in imageArray{
                //image的分类方法
                let resizedImage:UIImage? = UIImage.IMGCompressed(sourceImage: image, defineWidth: CGFloat(targetWidth))
                //                let resizedImage:UIImage = UIImage.IMGCompressed(sourceImage:$0,defineWidth:targetWidth)
                guard let newImage = resizedImage else{
                    continue
                }
                let imgData:Data? = UIImageJPEGRepresentation(newImage, 0.5)
                
                //拼接data
                if let data = imgData{
                    formData.appendPart(withFileData: data, name: "picflie", fileName: "image.png", mimeType: " image/jpeg")
                    i+=1;
                }
            }
        }, progress: { (loadProgress) in
            progress(loadProgress.completedUnitCount / loadProgress.totalUnitCount)
        }, success: { (_, object) in
            if let reslut = object{
                success(JSON(reslut))
            }
        }) { (_, error) in
            failure(error)
        }
    }
    
    //MARK: - 视频上传
    
    /**
     *  视频上传
     *
     *  @param operations   上传视频预留参数---视具体情况而定 可移除
     *  @param videoPath    上传视频的本地沙河路径
     *  @param urlString     上传的url
     *  @param successBlock 成功的回调
     *  @param failureBlock 失败的回调
     *  @param progress     上传的进度
     */
    public func uploadVideo(operaitons:[String:Any],videoPath:String,urlString:String,success:@escaping (JSON)->(),failure:@escaping (Error)->(),progress:@escaping (Int64)->()){
         /**获得视频资源*/
        let avAsset:AVURLAsset? = AVURLAsset(url: URL(string:urlString)!)
        
        /**压缩*/
        //    NSString *const AVAssetExportPreset640x480;
        //    NSString *const AVAssetExportPreset960x540;
        //    NSString *const AVAssetExportPreset1280x720;
        //    NSString *const AVAssetExportPreset1920x1080;
        //    NSString *const AVAssetExportPreset3840x2160;
        guard let asset = avAsset else {
            return
        }
        let avAssetExport:AVAssetExportSession? = AVAssetExportSession(asset: asset, presetName: AVAssetExportPreset640x480)
        
        /**创建日期格式化器*/
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
        
        /**转化后直接写入Library---caches*/
        let videoPath:String? = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        guard var videoWritePath:String = videoPath, let assetExport:AVAssetExportSession = avAssetExport else {
            return
        }
        videoWritePath.append("/output-\(formatter.string(from: Date())).mp4")
        
        assetExport.outputURL = URL(fileURLWithPath: videoWritePath)
        assetExport.outputFileType = AVFileType.mp4
        assetExport.exportAsynchronously {
            switch(assetExport.status){
            case .completed: do{
                NetWorkManager.shareManager.post(urlString, parameters: operaitons, constructingBodyWith: { (formData) in
                    //获得沙盒中的视频内容
                    try? formData.appendPart(withFileURL: URL(fileURLWithPath:videoWritePath), name: "write you want to writre", fileName: videoWritePath, mimeType: "video/mpeg4")
                }, progress: { (loadProgress) in
                    progress(loadProgress.completedUnitCount / loadProgress.totalUnitCount)
                }, success: { (_, object) in
                    if let reslut = object{
                        success(JSON(reslut))
                    }
                }, failure: { (_, error) in
                    failure(error)
                })
                break
            }

            default: break
            }
        }
        
    }

    
    //MARK: - 文件下载
    
    /**
     *  文件下载
     *
     *  @param operations   文件下载预留参数---视具体情况而定 可移除
     *  @param savePath     下载文件保存路径
     *  @param urlString        请求的url
     *  @param successBlock 下载文件成功的回调
     *  @param failureBlock 下载文件失败的回调
     *  @param progress     下载文件的进度显示
     */

    public func downLoadFile(operations:[String:Any],savaPath:String,urlString:String,success:@escaping (JSON)->(),failure:@escaping (Error)->(),progress:@escaping (Int64)->()){
        NetWorkManager.shareManager.downloadTask(with: URLRequest(url:URL(string:urlString)!) , progress: { (downloadProgress) in
            progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount)
        }, destination: { (_, _) -> URL in
            return URL(string:savaPath)!
        }) { (_, _, error) in
            if let error1 = error {
                failure(error1)
            }
        }
    }
    
    //MARK: -  取消所有的网络请求
    
    /**
     *  取消所有的网络请求
     *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
     */
    
    public func cancelAllRequest(){
        NetWorkManager.shareManager.operationQueue.cancelAllOperations()
    }
    
    //MARK: -   取消指定的url请求/
    /**
     *  取消指定的url请求
     *
     *  @param requestType 该请求的请求类型
     *  @param string      该请求的完整url
     */
    public func cancelHttpRequest(requestType:String,requestUrlString:String){
        /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
        let error:AutoreleasingUnsafeMutablePointer<NSError?>?=nil
        let urlToPeCanced:String? = NetWorkManager.shareManager.requestSerializer.request(withMethod: requestType, urlString: requestUrlString, parameters: nil, error: error).url?.path
        
        for operation in NetWorkManager.shareManager.operationQueue.operations{
            //如果是请求队列
            if operation is URLSessionTask{
                //请求的类型匹配
                let session:URLSessionTask = (operation as? URLSessionTask)!
                let hasMatchRequestType:Bool = requestType == session.currentRequest!.httpMethod
                
                //请求的url匹配
                let hasMatchRequestUrlString = urlToPeCanced == session.currentRequest!.url?.path
                
                //两项都匹配的话  取消该请求
                if hasMatchRequestType && hasMatchRequestUrlString{
                    operation.cancel()
                }
                
            }
        }

            
    }
    


    
}
