<?php


namespace app\tourist\controller;


class UpFiles extends Base
{
    public function upImg()
    {
        // 获取上传文件表单字段名
        $fileKey = array_keys(request()->file());
        // 获取表单上传文件
        $file = request()->file($fileKey['0']);
        // 移动到框架应用根目录/public/uploads/ 目录下
        $info = $file->validate(['ext' => 'jpg,png,gif,jpeg'])->move('uploads');
        if ($info) {
            $result['code'] = 1;
            $result['info'] = '图片上传成功!';
            $path = str_replace('\\', '/', $info->getSaveName());
            $result['url'] = '/uploads/' . $path;
            db('owner')->where('owner_id',session('user_id'))->update(['avatar'=>$result['url']]);
            return $result;
        } else {
            // 上传失败获取错误信息
            $result['code'] = 0;
            $result['info'] = $file->getError();
            $result['url'] = '';
            return $result;
        }
    }

    public function file()
    {
        $fileKey = array_keys(request()->file());
        // 获取表单上传文件 例如上传了001.jpg
        $file = request()->file($fileKey['0']);
        // 移动到框架应用根目录/public/uploads/ 目录下
        $info = $file->validate(['ext' => 'zip,rar,pdf,swf,ppt,psd,ttf,txt,xls,doc,docx'])->move('uploads');
        if ($info) {
            $result['code'] = 0;
            $result['info'] = '文件上传成功!';
            $path = str_replace('\\', '/', $info->getSaveName());

            $result['url'] = '/uploads/' . $path;

            $result['ext'] = $info->getExtension();
            $result['size'] = byte_format($info->getSize(), 2);
            return $result;
        } else {
            // 上传失败获取错误信息
            $result['code'] = 1;
            $result['info'] = '文件上传失败!';
            $result['url'] = '';
            return $result;
        }
    }
}