PKG_NAME:=ttlchanger
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/rules.mk

LUCI_TITLE:=TTL Changer
LUCI_DEPENDS:=+nftables

# Install location for the LuCI module
LUCI_INSTALL_DIR := $(INSTALL_DIR)/usr/lib/lua/luci

# Prepare the package
define Package/$(PKG_NAME)/Description
    TTL Changer for OpenWrt using LuCI to configure TTL and Hop Limit via nftables
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
endef

# Install files
define Build/Install
    # Install the Lua files for the LuCI package
    $(INSTALL_DIR)/usr/lib/lua/luci/controller/controller_ttlchanger.lua
    $(INSTALL_DIR)/usr/lib/lua/luci/model/cbi/model_ttlchanger.lua

    # Install the main ttlchanger file to /usr/bin or appropriate directory
    $(INSTALL_DIR)/usr/bin/ttlchanger
endef

# Build the package
define Package/$(PKG_NAME)/install
    $(INSTALL_DIR)$(LUCI_INSTALL_DIR)/controller/controller_ttlchanger.lua
    $(INSTALL_DIR)$(LUCI_INSTALL_DIR)/model/model_ttlchanger.lua
    $(INSTALL_DIR)/usr/bin/ttlchanger
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
