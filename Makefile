include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-mttl
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Your Name <you@example.com>

LUCI_TITLE:=TTL Changer
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+luci +nftables

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/luci.mk

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_BIN) ./luasrc/controller/controller_ttlchanger.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_BIN) ./luasrc/model/cbi/model_ttlchanger.lua $(1)/usr/lib/lua/luci/model/cbi/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/ttlchanger $(1)/etc/config/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
