# SPDX-License-Identifier: GPL-2.0

# 内核模块对象文件列表
myuvcvideo-objs := uvc_driver.o uvc_queue.o uvc_v4l2.o uvc_video.o uvc_ctrl.o \
                uvc_status.o uvc_isight.o uvc_debugfs.o uvc_metadata.o

# 检查内核配置是否启用了 MEDIA_CONTROLLER
ifeq ($(CONFIG_MEDIA_CONTROLLER),y)
myuvcvideo-objs += uvc_entity.o
endif

# 添加 uvcvideo 模块对象到内核模块构建系统
obj-$(CONFIG_USB_VIDEO_CLASS) += myuvcvideo.o

# 默认目标，编译模块
all:
	$(MAKE) -C $(KERNEL_BUILD_DIR) M=$(shell pwd) modules

# 清理生成的对象文件
clean:
	$(MAKE) -C $(KERNEL_BUILD_DIR) M=$(shell pwd) clean

# 定义内核构建目录变量
KERNEL_BUILD_DIR ?= /nix/store/$(shell uname -r)/kernel
