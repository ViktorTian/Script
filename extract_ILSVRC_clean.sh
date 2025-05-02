#!/bin/bash
set -e

##############################################
# ImageNet ILSVRC2012 解压脚本（支持断点续解）
##############################################

# 一、训练集
if [ ! -d train ]; then
    mkdir train
fi

if [ -f ILSVRC2012_img_train.tar ]; then
    echo "开始解压 train 根目录..."
    tar -xf ILSVRC2012_img_train.tar -C train
else
    echo "警告：ILSVRC2012_img_train.tar 不存在，跳过 train 根目录解压"
fi

echo "开始解压 train 类别子 tar 包..."
cd train

find . -name "*.tar" | while read TARFILE; do
    DIRNAME="${TARFILE%.tar}"
    # 如果子文件夹不存在或为空，才解压
    if [ ! -d "$DIRNAME" ] || [ -z "$(ls -A "$DIRNAME" 2>/dev/null)" ]; then
        echo "解压：$TARFILE -> $DIRNAME"
        mkdir -p "$DIRNAME"
        tar -xf "$TARFILE" -C "$DIRNAME"
    else
        echo "跳过已解压类别：$DIRNAME"
    fi
done

cd ..

##############################################
# 二、验证集
##############################################

if [ ! -d val ]; then
    mkdir val
fi

if [ -f ILSVRC2012_img_val.tar ]; then
    echo "开始解压 val..."
    tar -xf ILSVRC2012_img_val.tar -C val
else
    echo "警告：ILSVRC2012_img_val.tar 不存在，跳过 val 解压"
fi

echo "整理 val 图片到各类别目录（官方脚本）..."
cd val
wget -qO- https://raw.githubusercontent.com/soumith/imagenetloader.torch/master/valprep.sh | bash
cd ..

##############################################
echo "解压完成！"
##############################################