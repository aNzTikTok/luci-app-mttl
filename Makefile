PKG_NAME:=luci-app-mttl
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/rules.mk

LUCI_TITLE:=TTL Changer
LUCI_DEPENDS:=+nftables

define Package/$(PKG_NAME)/Description
TTL Changer for OpenWrt using LuCI to configure TTL and Hop Limit via nftables
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
endef

define Package/$(PKG_NAME)/install
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
    $(INSTALL_DIR) $(1)/etc/config

    $(INSTALL_DATA) ./files/controller_ttlchanger.lua $(1)/usr/lib/lua/luci/controller/
    $(INSTALL_DATA) ./files/model_ttlchanger.lua $(1)/usr/lib/lua/luci/model/cbi/
    $(INSTALL_CONF) ./files/ttlchanger $(1)/etc/config/ttlchanger
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/ttlchanger
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
