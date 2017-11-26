export TARGET = iphone:9.3

INSTALL_TARGET_PROCESSES = Preferences

ifeq ($(RESPRING),1)
INSTALL_TARGET_PROCESSES += SpringBoard
endif

include $(THEOS)/makefiles/common.mk

# the main stuff
SUBPROJECTS = Vultus SpringBoard
# side stuff
SUBPROJECTS += Settings Flipswitch

include $(THEOS_MAKE_PATH)/aggregate.mk
