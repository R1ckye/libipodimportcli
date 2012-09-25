include theos/makefiles/common.mk

TOOL_NAME = libipodimportcli
libipodimportcli_FILES = main.m client.m
libipodimportcli_PRIVATE_FRAMEWORKS = AppSupport
libipodimportcli_FRAMEWORKS = AVFoundation

include $(THEOS_MAKE_PATH)/tool.mk
