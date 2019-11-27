Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4710AEA5
	for <lists+linux-crypto@lfdr.de>; Wed, 27 Nov 2019 12:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfK0L1K (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 Nov 2019 06:27:10 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:37243 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfK0L1J (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 Nov 2019 06:27:09 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2c378c9e;
        Wed, 27 Nov 2019 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=h0iIdcE2uBNzBeD1L3dZvyjMq
        9Y=; b=JDWyTxuLbO8rfB07PchI9+CyK92lg23YhOyNZPeJiw/vi6Uf3EuxV2Xz0
        P+B6U2kcHZQ/VlHkmCytfYH3rYsnPaIQlKBlVQhyjgx+8tLjn/jhDlJ3A8I3DVje
        i5IEHJ8om2PIuY/KOTYIHUfFAxR9wMC90NpQI0PARAkBkUtRT00dUwqAhjaUjAaG
        /jfLCzCx+99OQtIZE51HXf9InPZF8KNooZzXIV9XhLUdcdvU2EpjkN8jqfUZ6kXd
        D7tOSyUkItMkNt+KVu2e6M8oP+Nx7u35nSX2rBhu1cJRnnbKmLIeXoOkgVHRRyuG
        T96aE6h5OskLuHutlwbZJrfV0Qd9w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fad9b7d0 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 27 Nov 2019 10:33:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v1] net: WireGuard secure network tunnel
Date:   Wed, 27 Nov 2019 12:26:43 +0100
Message-Id: <20191127112643.441509-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

WireGuard is a layer 3 secure networking tunnel made specifically for
the kernel, that aims to be much simpler and easier to audit than IPsec.
Extensive documentation and description of the protocol and
considerations, along with formal proofs of the cryptography, are
available at:

  * https://www.wireguard.com/
  * https://www.wireguard.com/papers/wireguard.pdf

This commit implements WireGuard as a simple network device driver,
accessible in the usual RTNL way used by virtual network drivers. It
makes use of the udp_tunnel APIs, GRO, GSO, NAPI, and the usual set of
networking subsystem APIs. It has a somewhat novel multicore queueing
system designed for maximum throughput and minimal latency of encryption
operations, but it is implemented modestly using workqueues and NAPI.
Configuration is done via generic Netlink, and following a review from
the Netlink maintainer a year ago, several high profile userspace
have already implemented the API.

This commit also comes with several different tests, both in-kernel
tests and out-of-kernel tests based on network namespaces, taking profit
of the fact that sockets used by WireGuard intentionally stay in the
namespace the WireGuard interface was originally created, exactly like
the semantics of userspace tun devices. See wireguard.com/netns/ for
pictures and examples.

The source code is fairly short, but rather than combining everything
into a single file, WireGuard is developed as cleanly separable files,
making auditing and comprehension easier. Things are laid out as
follows:

  * noise.[ch], cookie.[ch], messages.h: These implement the bulk of the
    cryptographic aspects of the protocol, and are mostly data-only in
    nature, taking in buffers of bytes and spitting out buffers of
    bytes. They also handle reference counting for their various shared
    pieces of data, like keys and key lists.

  * ratelimiter.[ch]: Used as an integral part of cookie.[ch] for
    ratelimiting certain types of cryptographic operations in accordance
    with particular WireGuard semantics.

  * allowedips.[ch], peerlookup.[ch]: The main lookup structures of
    WireGuard, the former being trie-like with particular semantics, an
    integral part of the design of the protocol, and the latter just
    being nice helper functions around the various hashtables we use.

  * device.[ch]: Implementation of functions for the netdevice and for
    rtnl, responsible for maintaining the life of a given interface and
    wiring it up to the rest of WireGuard.

  * peer.[ch]: Each interface has a list of peers, with helper functions
    available here for creation, destruction, and reference counting.

  * socket.[ch]: Implementation of functions related to udp_socket and
    the general set of kernel socket APIs, for sending and receiving
    ciphertext UDP packets, and taking care of WireGuard-specific sticky
    socket routing semantics for the automatic roaming.

  * netlink.[ch]: Userspace API entry point for configuring WireGuard
    peers and devices. The API has been implemented by several userspace
    tools and network management utility, and the WireGuard project
    distributes the basic wg(8) tool.

  * queueing.[ch]: Shared function on the rx and tx path for handling
    the various queues used in the multicore algorithms.

  * send.c: Handles encrypting outgoing packets in parallel on
    multiple cores, before sending them in order on a single core, via
    workqueues and ring buffers. Also handles sending handshake and cookie
    messages as part of the protocol, in parallel.

  * receive.c: Handles decrypting incoming packets in parallel on
    multiple cores, before passing them off in order to be ingested via
    the rest of the networking subsystem with GRO via the typical NAPI
    poll function. Also handles receiving handshake and cookie messages
    as part of the protocol, in parallel.

  * timers.[ch]: Uses the timer wheel to implement protocol particular
    event timeouts, and gives a set of very simple event-driven entry
    point functions for callers.

  * main.c, version.h: Initialization and deinitialization of the module.

  * selftest/*.h: Runtime unit tests for some of the most security
    sensitive functions.

  * tools/testing/selftests/wireguard/netns.sh: Aforementioned testing
    script using network namespaces.

This commit aims to be as self-contained as possible, implementing
WireGuard as a standalone module not needing much special handling or
coordination from the network subsystem. I expect for future
optimizations to the network stack to positively improve WireGuard, and
vice-versa, but for the time being, this exists as intentionally
standalone.

We introduce a menu option for CONFIG_WIREGUARD, as well as providing a
verbose debug log and self-tests via CONFIG_WIREGUARD_DEBUG.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: David Miller <davem@davemloft.net>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
Note: This benefits from [1], which is currently in Herbert's tree, but
will be in Linus' for 5.5 pretty shortly. In the meanwhile, this code
here still does work fine.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git/commit/?id=8394bfec51e0e565556101bcc4e2fe7551104cd8

 MAINTAINERS                                  |   8 +
 drivers/net/Kconfig                          |  41 +
 drivers/net/Makefile                         |   1 +
 drivers/net/wireguard/Makefile               |  18 +
 drivers/net/wireguard/allowedips.c           | 381 +++++++++
 drivers/net/wireguard/allowedips.h           |  59 ++
 drivers/net/wireguard/cookie.c               | 236 ++++++
 drivers/net/wireguard/cookie.h               |  59 ++
 drivers/net/wireguard/device.c               | 458 ++++++++++
 drivers/net/wireguard/device.h               |  65 ++
 drivers/net/wireguard/main.c                 |  64 ++
 drivers/net/wireguard/messages.h             | 128 +++
 drivers/net/wireguard/netlink.c              | 642 ++++++++++++++
 drivers/net/wireguard/netlink.h              |  12 +
 drivers/net/wireguard/noise.c                | 828 +++++++++++++++++++
 drivers/net/wireguard/noise.h                | 137 +++
 drivers/net/wireguard/peer.c                 | 240 ++++++
 drivers/net/wireguard/peer.h                 |  83 ++
 drivers/net/wireguard/peerlookup.c           | 221 +++++
 drivers/net/wireguard/peerlookup.h           |  64 ++
 drivers/net/wireguard/queueing.c             |  53 ++
 drivers/net/wireguard/queueing.h             | 197 +++++
 drivers/net/wireguard/ratelimiter.c          | 223 +++++
 drivers/net/wireguard/ratelimiter.h          |  19 +
 drivers/net/wireguard/receive.c              | 595 +++++++++++++
 drivers/net/wireguard/selftest/allowedips.c  | 683 +++++++++++++++
 drivers/net/wireguard/selftest/counter.c     | 104 +++
 drivers/net/wireguard/selftest/ratelimiter.c | 226 +++++
 drivers/net/wireguard/send.c                 | 424 ++++++++++
 drivers/net/wireguard/socket.c               | 436 ++++++++++
 drivers/net/wireguard/socket.h               |  44 +
 drivers/net/wireguard/timers.c               | 243 ++++++
 drivers/net/wireguard/timers.h               |  31 +
 drivers/net/wireguard/version.h              |   1 +
 include/uapi/linux/wireguard.h               | 196 +++++
 tools/testing/selftests/wireguard/netns.sh   | 537 ++++++++++++
 36 files changed, 7757 insertions(+)
 create mode 100644 drivers/net/wireguard/Makefile
 create mode 100644 drivers/net/wireguard/allowedips.c
 create mode 100644 drivers/net/wireguard/allowedips.h
 create mode 100644 drivers/net/wireguard/cookie.c
 create mode 100644 drivers/net/wireguard/cookie.h
 create mode 100644 drivers/net/wireguard/device.c
 create mode 100644 drivers/net/wireguard/device.h
 create mode 100644 drivers/net/wireguard/main.c
 create mode 100644 drivers/net/wireguard/messages.h
 create mode 100644 drivers/net/wireguard/netlink.c
 create mode 100644 drivers/net/wireguard/netlink.h
 create mode 100644 drivers/net/wireguard/noise.c
 create mode 100644 drivers/net/wireguard/noise.h
 create mode 100644 drivers/net/wireguard/peer.c
 create mode 100644 drivers/net/wireguard/peer.h
 create mode 100644 drivers/net/wireguard/peerlookup.c
 create mode 100644 drivers/net/wireguard/peerlookup.h
 create mode 100644 drivers/net/wireguard/queueing.c
 create mode 100644 drivers/net/wireguard/queueing.h
 create mode 100644 drivers/net/wireguard/ratelimiter.c
 create mode 100644 drivers/net/wireguard/ratelimiter.h
 create mode 100644 drivers/net/wireguard/receive.c
 create mode 100644 drivers/net/wireguard/selftest/allowedips.c
 create mode 100644 drivers/net/wireguard/selftest/counter.c
 create mode 100644 drivers/net/wireguard/selftest/ratelimiter.c
 create mode 100644 drivers/net/wireguard/send.c
 create mode 100644 drivers/net/wireguard/socket.c
 create mode 100644 drivers/net/wireguard/socket.h
 create mode 100644 drivers/net/wireguard/timers.c
 create mode 100644 drivers/net/wireguard/timers.h
 create mode 100644 drivers/net/wireguard/version.h
 create mode 100644 include/uapi/linux/wireguard.h
 create mode 100755 tools/testing/selftests/wireguard/netns.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f075b866aaf..348a5cef40ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17679,6 +17679,14 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-ws16c48.c
 
+WIREGUARD SECURE NETWORK TUNNEL
+M:	Jason A. Donenfeld <Jason@zx2c4.com>
+S:	Maintained
+F:	drivers/net/wireguard/
+F:	tools/testing/selftests/wireguard/
+L:	wireguard@lists.zx2c4.com
+L:	netdev@vger.kernel.org
+
 WISTRON LAPTOP BUTTON DRIVER
 M:	Miloslav Trmac <mitr@volny.cz>
 S:	Maintained
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d02f12a5254e..ffe8d4e2b206 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -71,6 +71,47 @@ config DUMMY
 	  To compile this driver as a module, choose M here: the module
 	  will be called dummy.
 
+config WIREGUARD
+	tristate "WireGuard secure network tunnel"
+	depends on NET && INET
+	depends on IPV6 || !IPV6
+	select NET_UDP_TUNNEL
+	select DST_CACHE
+	select CRYPTO
+	select CRYPTO_LIB_CURVE25519
+	select CRYPTO_LIB_CHACHA20POLY1305
+	select CRYPTO_LIB_BLAKE2S
+	select CRYPTO_CHACHA20_X86_64 if X86 && 64BIT
+	select CRYPTO_POLY1305_X86_64 if X86 && 64BIT
+	select CRYPTO_BLAKE2S_X86 if X86 && 64BIT
+	select CRYPTO_CURVE25519_X86 if X86 && 64BIT
+	select CRYPTO_CHACHA20_NEON if (ARM || ARM64) && KERNEL_MODE_NEON
+	select CRYPTO_POLY1305_NEON if ARM64 && KERNEL_MODE_NEON
+	select CRYPTO_POLY1305_ARM if ARM
+	select CRYPTO_CURVE25519_NEON if ARM && KERNEL_MODE_NEON
+	select CRYPTO_CHACHA_MIPS if CPU_MIPS32_R2
+	select CRYPTO_POLY1305_MIPS if CPU_MIPS32 || (CPU_MIPS64 && 64BIT)
+	help
+	  WireGuard is a secure, fast, and easy to use replacement for IPSec
+	  that uses modern cryptography and clever networking tricks. It's
+	  designed to be fairly general purpose and abstract enough to fit most
+	  use cases, while at the same time remaining extremely simple to
+	  configure. See www.wireguard.com for more info.
+
+	  It's safe to say Y or M here, as the driver is very lightweight and
+	  is only in use when an administrator chooses to add an interface.
+
+config WIREGUARD_DEBUG
+	bool "Debugging checks and verbose messages"
+	depends on WIREGUARD
+	help
+	  This will write log messages for handshake and other events
+	  that occur for a WireGuard interface. It will also perform some
+	  extra validation checks and unit tests at various points. This is
+	  only useful for debugging.
+
+	  Say N here unless you know what you're doing.
+
 config EQUALIZER
 	tristate "EQL (serial line load balancing) support"
 	---help---
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 0d3ba056cda3..953b7c12f0b0 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_BONDING) += bonding/
 obj-$(CONFIG_IPVLAN) += ipvlan/
 obj-$(CONFIG_IPVTAP) += ipvlan/
 obj-$(CONFIG_DUMMY) += dummy.o
+obj-$(CONFIG_WIREGUARD) += wireguard/
 obj-$(CONFIG_EQUALIZER) += eql.o
 obj-$(CONFIG_IFB) += ifb.o
 obj-$(CONFIG_MACSEC) += macsec.o
diff --git a/drivers/net/wireguard/Makefile b/drivers/net/wireguard/Makefile
new file mode 100644
index 000000000000..fc52b2cb500b
--- /dev/null
+++ b/drivers/net/wireguard/Makefile
@@ -0,0 +1,18 @@
+ccflags-y := -O3
+ccflags-y += -D'pr_fmt(fmt)=KBUILD_MODNAME ": " fmt'
+ccflags-$(CONFIG_WIREGUARD_DEBUG) += -DDEBUG
+wireguard-y := main.o
+wireguard-y += noise.o
+wireguard-y += device.o
+wireguard-y += peer.o
+wireguard-y += timers.o
+wireguard-y += queueing.o
+wireguard-y += send.o
+wireguard-y += receive.o
+wireguard-y += socket.o
+wireguard-y += peerlookup.o
+wireguard-y += allowedips.o
+wireguard-y += ratelimiter.o
+wireguard-y += cookie.o
+wireguard-y += netlink.o
+obj-$(CONFIG_WIREGUARD) := wireguard.o
diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
new file mode 100644
index 000000000000..72667d5399c3
--- /dev/null
+++ b/drivers/net/wireguard/allowedips.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "allowedips.h"
+#include "peer.h"
+
+static void swap_endian(u8 *dst, const u8 *src, u8 bits)
+{
+	if (bits == 32) {
+		*(u32 *)dst = be32_to_cpu(*(const __be32 *)src);
+	} else if (bits == 128) {
+		((u64 *)dst)[0] = be64_to_cpu(((const __be64 *)src)[0]);
+		((u64 *)dst)[1] = be64_to_cpu(((const __be64 *)src)[1]);
+	}
+}
+
+static void copy_and_assign_cidr(struct allowedips_node *node, const u8 *src,
+				 u8 cidr, u8 bits)
+{
+	node->cidr = cidr;
+	node->bit_at_a = cidr / 8U;
+#ifdef __LITTLE_ENDIAN
+	node->bit_at_a ^= (bits / 8U - 1U) % 8U;
+#endif
+	node->bit_at_b = 7U - (cidr % 8U);
+	node->bitlen = bits;
+	memcpy(node->bits, src, bits / 8U);
+}
+#define CHOOSE_NODE(parent, key) \
+	parent->bit[(key[parent->bit_at_a] >> parent->bit_at_b) & 1]
+
+static void node_free_rcu(struct rcu_head *rcu)
+{
+	kfree(container_of(rcu, struct allowedips_node, rcu));
+}
+
+static void push_rcu(struct allowedips_node **stack,
+		     struct allowedips_node __rcu *p, unsigned int *len)
+{
+	if (rcu_access_pointer(p)) {
+		WARN_ON(IS_ENABLED(DEBUG) && *len >= 128);
+		stack[(*len)++] = rcu_dereference_raw(p);
+	}
+}
+
+static void root_free_rcu(struct rcu_head *rcu)
+{
+	struct allowedips_node *node, *stack[128] = {
+		container_of(rcu, struct allowedips_node, rcu) };
+	unsigned int len = 1;
+
+	while (len > 0 && (node = stack[--len])) {
+		push_rcu(stack, node->bit[0], &len);
+		push_rcu(stack, node->bit[1], &len);
+		kfree(node);
+	}
+}
+
+static void root_remove_peer_lists(struct allowedips_node *root)
+{
+	struct allowedips_node *node, *stack[128] = { root };
+	unsigned int len = 1;
+
+	while (len > 0 && (node = stack[--len])) {
+		push_rcu(stack, node->bit[0], &len);
+		push_rcu(stack, node->bit[1], &len);
+		if (rcu_access_pointer(node->peer))
+			list_del(&node->peer_list);
+	}
+}
+
+static void walk_remove_by_peer(struct allowedips_node __rcu **top,
+				struct wg_peer *peer, struct mutex *lock)
+{
+#define REF(p) rcu_access_pointer(p)
+#define DEREF(p) rcu_dereference_protected(*(p), lockdep_is_held(lock))
+#define PUSH(p) ({                                                             \
+		WARN_ON(IS_ENABLED(DEBUG) && len >= 128);                      \
+		stack[len++] = p;                                              \
+	})
+
+	struct allowedips_node __rcu **stack[128], **nptr;
+	struct allowedips_node *node, *prev;
+	unsigned int len;
+
+	if (unlikely(!peer || !REF(*top)))
+		return;
+
+	for (prev = NULL, len = 0, PUSH(top); len > 0; prev = node) {
+		nptr = stack[len - 1];
+		node = DEREF(nptr);
+		if (!node) {
+			--len;
+			continue;
+		}
+		if (!prev || REF(prev->bit[0]) == node ||
+		    REF(prev->bit[1]) == node) {
+			if (REF(node->bit[0]))
+				PUSH(&node->bit[0]);
+			else if (REF(node->bit[1]))
+				PUSH(&node->bit[1]);
+		} else if (REF(node->bit[0]) == prev) {
+			if (REF(node->bit[1]))
+				PUSH(&node->bit[1]);
+		} else {
+			if (rcu_dereference_protected(node->peer,
+				lockdep_is_held(lock)) == peer) {
+				RCU_INIT_POINTER(node->peer, NULL);
+				list_del_init(&node->peer_list);
+				if (!node->bit[0] || !node->bit[1]) {
+					rcu_assign_pointer(*nptr, DEREF(
+					       &node->bit[!REF(node->bit[0])]));
+					call_rcu(&node->rcu, node_free_rcu);
+					node = DEREF(nptr);
+				}
+			}
+			--len;
+		}
+	}
+
+#undef REF
+#undef DEREF
+#undef PUSH
+}
+
+static unsigned int fls128(u64 a, u64 b)
+{
+	return a ? fls64(a) + 64U : fls64(b);
+}
+
+static u8 common_bits(const struct allowedips_node *node, const u8 *key,
+		      u8 bits)
+{
+	if (bits == 32)
+		return 32U - fls(*(const u32 *)node->bits ^ *(const u32 *)key);
+	else if (bits == 128)
+		return 128U - fls128(
+			*(const u64 *)&node->bits[0] ^ *(const u64 *)&key[0],
+			*(const u64 *)&node->bits[8] ^ *(const u64 *)&key[8]);
+	return 0;
+}
+
+static bool prefix_matches(const struct allowedips_node *node, const u8 *key,
+			   u8 bits)
+{
+	/* This could be much faster if it actually just compared the common
+	 * bits properly, by precomputing a mask bswap(~0 << (32 - cidr)), and
+	 * the rest, but it turns out that common_bits is already super fast on
+	 * modern processors, even taking into account the unfortunate bswap.
+	 * So, we just inline it like this instead.
+	 */
+	return common_bits(node, key, bits) >= node->cidr;
+}
+
+static struct allowedips_node *find_node(struct allowedips_node *trie, u8 bits,
+					 const u8 *key)
+{
+	struct allowedips_node *node = trie, *found = NULL;
+
+	while (node && prefix_matches(node, key, bits)) {
+		if (rcu_access_pointer(node->peer))
+			found = node;
+		if (node->cidr == bits)
+			break;
+		node = rcu_dereference_bh(CHOOSE_NODE(node, key));
+	}
+	return found;
+}
+
+/* Returns a strong reference to a peer */
+static struct wg_peer *lookup(struct allowedips_node __rcu *root, u8 bits,
+			      const void *be_ip)
+{
+	/* Aligned so it can be passed to fls/fls64 */
+	u8 ip[16] __aligned(__alignof(u64));
+	struct allowedips_node *node;
+	struct wg_peer *peer = NULL;
+
+	swap_endian(ip, be_ip, bits);
+
+	rcu_read_lock_bh();
+retry:
+	node = find_node(rcu_dereference_bh(root), bits, ip);
+	if (node) {
+		peer = wg_peer_get_maybe_zero(rcu_dereference_bh(node->peer));
+		if (!peer)
+			goto retry;
+	}
+	rcu_read_unlock_bh();
+	return peer;
+}
+
+static bool node_placement(struct allowedips_node __rcu *trie, const u8 *key,
+			   u8 cidr, u8 bits, struct allowedips_node **rnode,
+			   struct mutex *lock)
+{
+	struct allowedips_node *node = rcu_dereference_protected(trie,
+						lockdep_is_held(lock));
+	struct allowedips_node *parent = NULL;
+	bool exact = false;
+
+	while (node && node->cidr <= cidr && prefix_matches(node, key, bits)) {
+		parent = node;
+		if (parent->cidr == cidr) {
+			exact = true;
+			break;
+		}
+		node = rcu_dereference_protected(CHOOSE_NODE(parent, key),
+						 lockdep_is_held(lock));
+	}
+	*rnode = parent;
+	return exact;
+}
+
+static int add(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
+	       u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	struct allowedips_node *node, *parent, *down, *newnode;
+
+	if (unlikely(cidr > bits || !peer))
+		return -EINVAL;
+
+	if (!rcu_access_pointer(*trie)) {
+		node = kzalloc(sizeof(*node), GFP_KERNEL);
+		if (unlikely(!node))
+			return -ENOMEM;
+		RCU_INIT_POINTER(node->peer, peer);
+		list_add_tail(&node->peer_list, &peer->allowedips_list);
+		copy_and_assign_cidr(node, key, cidr, bits);
+		rcu_assign_pointer(*trie, node);
+		return 0;
+	}
+	if (node_placement(*trie, key, cidr, bits, &node, lock)) {
+		rcu_assign_pointer(node->peer, peer);
+		list_move_tail(&node->peer_list, &peer->allowedips_list);
+		return 0;
+	}
+
+	newnode = kzalloc(sizeof(*newnode), GFP_KERNEL);
+	if (unlikely(!newnode))
+		return -ENOMEM;
+	RCU_INIT_POINTER(newnode->peer, peer);
+	list_add_tail(&newnode->peer_list, &peer->allowedips_list);
+	copy_and_assign_cidr(newnode, key, cidr, bits);
+
+	if (!node) {
+		down = rcu_dereference_protected(*trie, lockdep_is_held(lock));
+	} else {
+		down = rcu_dereference_protected(CHOOSE_NODE(node, key),
+						 lockdep_is_held(lock));
+		if (!down) {
+			rcu_assign_pointer(CHOOSE_NODE(node, key), newnode);
+			return 0;
+		}
+	}
+	cidr = min(cidr, common_bits(down, key, bits));
+	parent = node;
+
+	if (newnode->cidr == cidr) {
+		rcu_assign_pointer(CHOOSE_NODE(newnode, down->bits), down);
+		if (!parent)
+			rcu_assign_pointer(*trie, newnode);
+		else
+			rcu_assign_pointer(CHOOSE_NODE(parent, newnode->bits),
+					   newnode);
+	} else {
+		node = kzalloc(sizeof(*node), GFP_KERNEL);
+		if (unlikely(!node)) {
+			kfree(newnode);
+			return -ENOMEM;
+		}
+		INIT_LIST_HEAD(&node->peer_list);
+		copy_and_assign_cidr(node, newnode->bits, cidr, bits);
+
+		rcu_assign_pointer(CHOOSE_NODE(node, down->bits), down);
+		rcu_assign_pointer(CHOOSE_NODE(node, newnode->bits), newnode);
+		if (!parent)
+			rcu_assign_pointer(*trie, node);
+		else
+			rcu_assign_pointer(CHOOSE_NODE(parent, node->bits),
+					   node);
+	}
+	return 0;
+}
+
+void wg_allowedips_init(struct allowedips *table)
+{
+	table->root4 = table->root6 = NULL;
+	table->seq = 1;
+}
+
+void wg_allowedips_free(struct allowedips *table, struct mutex *lock)
+{
+	struct allowedips_node __rcu *old4 = table->root4, *old6 = table->root6;
+
+	++table->seq;
+	RCU_INIT_POINTER(table->root4, NULL);
+	RCU_INIT_POINTER(table->root6, NULL);
+	if (rcu_access_pointer(old4)) {
+		struct allowedips_node *node = rcu_dereference_protected(old4,
+							lockdep_is_held(lock));
+
+		root_remove_peer_lists(node);
+		call_rcu(&node->rcu, root_free_rcu);
+	}
+	if (rcu_access_pointer(old6)) {
+		struct allowedips_node *node = rcu_dereference_protected(old6,
+							lockdep_is_held(lock));
+
+		root_remove_peer_lists(node);
+		call_rcu(&node->rcu, root_free_rcu);
+	}
+}
+
+int wg_allowedips_insert_v4(struct allowedips *table, const struct in_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	/* Aligned so it can be passed to fls */
+	u8 key[4] __aligned(__alignof(u32));
+
+	++table->seq;
+	swap_endian(key, (const u8 *)ip, 32);
+	return add(&table->root4, 32, key, cidr, peer, lock);
+}
+
+int wg_allowedips_insert_v6(struct allowedips *table, const struct in6_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock)
+{
+	/* Aligned so it can be passed to fls64 */
+	u8 key[16] __aligned(__alignof(u64));
+
+	++table->seq;
+	swap_endian(key, (const u8 *)ip, 128);
+	return add(&table->root6, 128, key, cidr, peer, lock);
+}
+
+void wg_allowedips_remove_by_peer(struct allowedips *table,
+				  struct wg_peer *peer, struct mutex *lock)
+{
+	++table->seq;
+	walk_remove_by_peer(&table->root4, peer, lock);
+	walk_remove_by_peer(&table->root6, peer, lock);
+}
+
+int wg_allowedips_read_node(struct allowedips_node *node, u8 ip[16], u8 *cidr)
+{
+	const unsigned int cidr_bytes = DIV_ROUND_UP(node->cidr, 8U);
+	swap_endian(ip, node->bits, node->bitlen);
+	memset(ip + cidr_bytes, 0, node->bitlen / 8U - cidr_bytes);
+	if (node->cidr)
+		ip[cidr_bytes - 1U] &= ~0U << (-node->cidr % 8U);
+
+	*cidr = node->cidr;
+	return node->bitlen == 32 ? AF_INET : AF_INET6;
+}
+
+/* Returns a strong reference to a peer */
+struct wg_peer *wg_allowedips_lookup_dst(struct allowedips *table,
+					 struct sk_buff *skb)
+{
+	if (skb->protocol == htons(ETH_P_IP))
+		return lookup(table->root4, 32, &ip_hdr(skb)->daddr);
+	else if (skb->protocol == htons(ETH_P_IPV6))
+		return lookup(table->root6, 128, &ipv6_hdr(skb)->daddr);
+	return NULL;
+}
+
+/* Returns a strong reference to a peer */
+struct wg_peer *wg_allowedips_lookup_src(struct allowedips *table,
+					 struct sk_buff *skb)
+{
+	if (skb->protocol == htons(ETH_P_IP))
+		return lookup(table->root4, 32, &ip_hdr(skb)->saddr);
+	else if (skb->protocol == htons(ETH_P_IPV6))
+		return lookup(table->root6, 128, &ipv6_hdr(skb)->saddr);
+	return NULL;
+}
+
+#include "selftest/allowedips.c"
diff --git a/drivers/net/wireguard/allowedips.h b/drivers/net/wireguard/allowedips.h
new file mode 100644
index 000000000000..e5c83cafcef4
--- /dev/null
+++ b/drivers/net/wireguard/allowedips.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_ALLOWEDIPS_H
+#define _WG_ALLOWEDIPS_H
+
+#include <linux/mutex.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+struct wg_peer;
+
+struct allowedips_node {
+	struct wg_peer __rcu *peer;
+	struct allowedips_node __rcu *bit[2];
+	/* While it may seem scandalous that we waste space for v4,
+	 * we're alloc'ing to the nearest power of 2 anyway, so this
+	 * doesn't actually make a difference.
+	 */
+	u8 bits[16] __aligned(__alignof(u64));
+	u8 cidr, bit_at_a, bit_at_b, bitlen;
+
+	/* Keep rarely used list at bottom to be beyond cache line. */
+	union {
+		struct list_head peer_list;
+		struct rcu_head rcu;
+	};
+};
+
+struct allowedips {
+	struct allowedips_node __rcu *root4;
+	struct allowedips_node __rcu *root6;
+	u64 seq;
+};
+
+void wg_allowedips_init(struct allowedips *table);
+void wg_allowedips_free(struct allowedips *table, struct mutex *mutex);
+int wg_allowedips_insert_v4(struct allowedips *table, const struct in_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
+int wg_allowedips_insert_v6(struct allowedips *table, const struct in6_addr *ip,
+			    u8 cidr, struct wg_peer *peer, struct mutex *lock);
+void wg_allowedips_remove_by_peer(struct allowedips *table,
+				  struct wg_peer *peer, struct mutex *lock);
+/* The ip input pointer should be __aligned(__alignof(u64))) */
+int wg_allowedips_read_node(struct allowedips_node *node, u8 ip[16], u8 *cidr);
+
+/* These return a strong reference to a peer: */
+struct wg_peer *wg_allowedips_lookup_dst(struct allowedips *table,
+					 struct sk_buff *skb);
+struct wg_peer *wg_allowedips_lookup_src(struct allowedips *table,
+					 struct sk_buff *skb);
+
+#ifdef DEBUG
+bool wg_allowedips_selftest(void);
+#endif
+
+#endif /* _WG_ALLOWEDIPS_H */
diff --git a/drivers/net/wireguard/cookie.c b/drivers/net/wireguard/cookie.c
new file mode 100644
index 000000000000..4956f0499c19
--- /dev/null
+++ b/drivers/net/wireguard/cookie.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "cookie.h"
+#include "peer.h"
+#include "device.h"
+#include "messages.h"
+#include "ratelimiter.h"
+#include "timers.h"
+
+#include <crypto/blake2s.h>
+#include <crypto/chacha20poly1305.h>
+
+#include <net/ipv6.h>
+#include <crypto/algapi.h>
+
+void wg_cookie_checker_init(struct cookie_checker *checker,
+			    struct wg_device *wg)
+{
+	init_rwsem(&checker->secret_lock);
+	checker->secret_birthdate = ktime_get_coarse_boottime_ns();
+	get_random_bytes(checker->secret, NOISE_HASH_LEN);
+	checker->device = wg;
+}
+
+enum { COOKIE_KEY_LABEL_LEN = 8 };
+static const u8 mac1_key_label[COOKIE_KEY_LABEL_LEN] = "mac1----";
+static const u8 cookie_key_label[COOKIE_KEY_LABEL_LEN] = "cookie--";
+
+static void precompute_key(u8 key[NOISE_SYMMETRIC_KEY_LEN],
+			   const u8 pubkey[NOISE_PUBLIC_KEY_LEN],
+			   const u8 label[COOKIE_KEY_LABEL_LEN])
+{
+	struct blake2s_state blake;
+
+	blake2s_init(&blake, NOISE_SYMMETRIC_KEY_LEN);
+	blake2s_update(&blake, label, COOKIE_KEY_LABEL_LEN);
+	blake2s_update(&blake, pubkey, NOISE_PUBLIC_KEY_LEN);
+	blake2s_final(&blake, key);
+}
+
+/* Must hold peer->handshake.static_identity->lock */
+void wg_cookie_checker_precompute_device_keys(struct cookie_checker *checker)
+{
+	if (likely(checker->device->static_identity.has_identity)) {
+		precompute_key(checker->cookie_encryption_key,
+			       checker->device->static_identity.static_public,
+			       cookie_key_label);
+		precompute_key(checker->message_mac1_key,
+			       checker->device->static_identity.static_public,
+			       mac1_key_label);
+	} else {
+		memset(checker->cookie_encryption_key, 0,
+		       NOISE_SYMMETRIC_KEY_LEN);
+		memset(checker->message_mac1_key, 0, NOISE_SYMMETRIC_KEY_LEN);
+	}
+}
+
+void wg_cookie_checker_precompute_peer_keys(struct wg_peer *peer)
+{
+	precompute_key(peer->latest_cookie.cookie_decryption_key,
+		       peer->handshake.remote_static, cookie_key_label);
+	precompute_key(peer->latest_cookie.message_mac1_key,
+		       peer->handshake.remote_static, mac1_key_label);
+}
+
+void wg_cookie_init(struct cookie *cookie)
+{
+	memset(cookie, 0, sizeof(*cookie));
+	init_rwsem(&cookie->lock);
+}
+
+static void compute_mac1(u8 mac1[COOKIE_LEN], const void *message, size_t len,
+			 const u8 key[NOISE_SYMMETRIC_KEY_LEN])
+{
+	len = len - sizeof(struct message_macs) +
+	      offsetof(struct message_macs, mac1);
+	blake2s(mac1, message, key, COOKIE_LEN, len, NOISE_SYMMETRIC_KEY_LEN);
+}
+
+static void compute_mac2(u8 mac2[COOKIE_LEN], const void *message, size_t len,
+			 const u8 cookie[COOKIE_LEN])
+{
+	len = len - sizeof(struct message_macs) +
+	      offsetof(struct message_macs, mac2);
+	blake2s(mac2, message, cookie, COOKIE_LEN, len, COOKIE_LEN);
+}
+
+static void make_cookie(u8 cookie[COOKIE_LEN], struct sk_buff *skb,
+			struct cookie_checker *checker)
+{
+	struct blake2s_state state;
+
+	if (wg_birthdate_has_expired(checker->secret_birthdate,
+				     COOKIE_SECRET_MAX_AGE)) {
+		down_write(&checker->secret_lock);
+		checker->secret_birthdate = ktime_get_coarse_boottime_ns();
+		get_random_bytes(checker->secret, NOISE_HASH_LEN);
+		up_write(&checker->secret_lock);
+	}
+
+	down_read(&checker->secret_lock);
+
+	blake2s_init_key(&state, COOKIE_LEN, checker->secret, NOISE_HASH_LEN);
+	if (skb->protocol == htons(ETH_P_IP))
+		blake2s_update(&state, (u8 *)&ip_hdr(skb)->saddr,
+			       sizeof(struct in_addr));
+	else if (skb->protocol == htons(ETH_P_IPV6))
+		blake2s_update(&state, (u8 *)&ipv6_hdr(skb)->saddr,
+			       sizeof(struct in6_addr));
+	blake2s_update(&state, (u8 *)&udp_hdr(skb)->source, sizeof(__be16));
+	blake2s_final(&state, cookie);
+
+	up_read(&checker->secret_lock);
+}
+
+enum cookie_mac_state wg_cookie_validate_packet(struct cookie_checker *checker,
+						struct sk_buff *skb,
+						bool check_cookie)
+{
+	struct message_macs *macs = (struct message_macs *)
+		(skb->data + skb->len - sizeof(*macs));
+	enum cookie_mac_state ret;
+	u8 computed_mac[COOKIE_LEN];
+	u8 cookie[COOKIE_LEN];
+
+	ret = INVALID_MAC;
+	compute_mac1(computed_mac, skb->data, skb->len,
+		     checker->message_mac1_key);
+	if (crypto_memneq(computed_mac, macs->mac1, COOKIE_LEN))
+		goto out;
+
+	ret = VALID_MAC_BUT_NO_COOKIE;
+
+	if (!check_cookie)
+		goto out;
+
+	make_cookie(cookie, skb, checker);
+
+	compute_mac2(computed_mac, skb->data, skb->len, cookie);
+	if (crypto_memneq(computed_mac, macs->mac2, COOKIE_LEN))
+		goto out;
+
+	ret = VALID_MAC_WITH_COOKIE_BUT_RATELIMITED;
+	if (!wg_ratelimiter_allow(skb, dev_net(checker->device->dev)))
+		goto out;
+
+	ret = VALID_MAC_WITH_COOKIE;
+
+out:
+	return ret;
+}
+
+void wg_cookie_add_mac_to_packet(void *message, size_t len,
+				 struct wg_peer *peer)
+{
+	struct message_macs *macs = (struct message_macs *)
+		((u8 *)message + len - sizeof(*macs));
+
+	down_write(&peer->latest_cookie.lock);
+	compute_mac1(macs->mac1, message, len,
+		     peer->latest_cookie.message_mac1_key);
+	memcpy(peer->latest_cookie.last_mac1_sent, macs->mac1, COOKIE_LEN);
+	peer->latest_cookie.have_sent_mac1 = true;
+	up_write(&peer->latest_cookie.lock);
+
+	down_read(&peer->latest_cookie.lock);
+	if (peer->latest_cookie.is_valid &&
+	    !wg_birthdate_has_expired(peer->latest_cookie.birthdate,
+				COOKIE_SECRET_MAX_AGE - COOKIE_SECRET_LATENCY))
+		compute_mac2(macs->mac2, message, len,
+			     peer->latest_cookie.cookie);
+	else
+		memset(macs->mac2, 0, COOKIE_LEN);
+	up_read(&peer->latest_cookie.lock);
+}
+
+void wg_cookie_message_create(struct message_handshake_cookie *dst,
+			      struct sk_buff *skb, __le32 index,
+			      struct cookie_checker *checker)
+{
+	struct message_macs *macs = (struct message_macs *)
+		((u8 *)skb->data + skb->len - sizeof(*macs));
+	u8 cookie[COOKIE_LEN];
+
+	dst->header.type = cpu_to_le32(MESSAGE_HANDSHAKE_COOKIE);
+	dst->receiver_index = index;
+	get_random_bytes_wait(dst->nonce, COOKIE_NONCE_LEN);
+
+	make_cookie(cookie, skb, checker);
+	xchacha20poly1305_encrypt(dst->encrypted_cookie, cookie, COOKIE_LEN,
+				  macs->mac1, COOKIE_LEN, dst->nonce,
+				  checker->cookie_encryption_key);
+}
+
+void wg_cookie_message_consume(struct message_handshake_cookie *src,
+			       struct wg_device *wg)
+{
+	struct wg_peer *peer = NULL;
+	u8 cookie[COOKIE_LEN];
+	bool ret;
+
+	if (unlikely(!wg_index_hashtable_lookup(wg->index_hashtable,
+						INDEX_HASHTABLE_HANDSHAKE |
+						INDEX_HASHTABLE_KEYPAIR,
+						src->receiver_index, &peer)))
+		return;
+
+	down_read(&peer->latest_cookie.lock);
+	if (unlikely(!peer->latest_cookie.have_sent_mac1)) {
+		up_read(&peer->latest_cookie.lock);
+		goto out;
+	}
+	ret = xchacha20poly1305_decrypt(
+		cookie, src->encrypted_cookie, sizeof(src->encrypted_cookie),
+		peer->latest_cookie.last_mac1_sent, COOKIE_LEN, src->nonce,
+		peer->latest_cookie.cookie_decryption_key);
+	up_read(&peer->latest_cookie.lock);
+
+	if (ret) {
+		down_write(&peer->latest_cookie.lock);
+		memcpy(peer->latest_cookie.cookie, cookie, COOKIE_LEN);
+		peer->latest_cookie.birthdate = ktime_get_coarse_boottime_ns();
+		peer->latest_cookie.is_valid = true;
+		peer->latest_cookie.have_sent_mac1 = false;
+		up_write(&peer->latest_cookie.lock);
+	} else {
+		net_dbg_ratelimited("%s: Could not decrypt invalid cookie response\n",
+				    wg->dev->name);
+	}
+
+out:
+	wg_peer_put(peer);
+}
diff --git a/drivers/net/wireguard/cookie.h b/drivers/net/wireguard/cookie.h
new file mode 100644
index 000000000000..c4bd61ca03f2
--- /dev/null
+++ b/drivers/net/wireguard/cookie.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_COOKIE_H
+#define _WG_COOKIE_H
+
+#include "messages.h"
+#include <linux/rwsem.h>
+
+struct wg_peer;
+
+struct cookie_checker {
+	u8 secret[NOISE_HASH_LEN];
+	u8 cookie_encryption_key[NOISE_SYMMETRIC_KEY_LEN];
+	u8 message_mac1_key[NOISE_SYMMETRIC_KEY_LEN];
+	u64 secret_birthdate;
+	struct rw_semaphore secret_lock;
+	struct wg_device *device;
+};
+
+struct cookie {
+	u64 birthdate;
+	bool is_valid;
+	u8 cookie[COOKIE_LEN];
+	bool have_sent_mac1;
+	u8 last_mac1_sent[COOKIE_LEN];
+	u8 cookie_decryption_key[NOISE_SYMMETRIC_KEY_LEN];
+	u8 message_mac1_key[NOISE_SYMMETRIC_KEY_LEN];
+	struct rw_semaphore lock;
+};
+
+enum cookie_mac_state {
+	INVALID_MAC,
+	VALID_MAC_BUT_NO_COOKIE,
+	VALID_MAC_WITH_COOKIE_BUT_RATELIMITED,
+	VALID_MAC_WITH_COOKIE
+};
+
+void wg_cookie_checker_init(struct cookie_checker *checker,
+			    struct wg_device *wg);
+void wg_cookie_checker_precompute_device_keys(struct cookie_checker *checker);
+void wg_cookie_checker_precompute_peer_keys(struct wg_peer *peer);
+void wg_cookie_init(struct cookie *cookie);
+
+enum cookie_mac_state wg_cookie_validate_packet(struct cookie_checker *checker,
+						struct sk_buff *skb,
+						bool check_cookie);
+void wg_cookie_add_mac_to_packet(void *message, size_t len,
+				 struct wg_peer *peer);
+
+void wg_cookie_message_create(struct message_handshake_cookie *src,
+			      struct sk_buff *skb, __le32 index,
+			      struct cookie_checker *checker);
+void wg_cookie_message_consume(struct message_handshake_cookie *src,
+			       struct wg_device *wg);
+
+#endif /* _WG_COOKIE_H */
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
new file mode 100644
index 000000000000..c9062e0779dc
--- /dev/null
+++ b/drivers/net/wireguard/device.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "queueing.h"
+#include "socket.h"
+#include "timers.h"
+#include "device.h"
+#include "ratelimiter.h"
+#include "peer.h"
+#include "messages.h"
+
+#include <linux/module.h>
+#include <linux/rtnetlink.h>
+#include <linux/inet.h>
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/if_arp.h>
+#include <linux/icmp.h>
+#include <linux/suspend.h>
+#include <net/icmp.h>
+#include <net/rtnetlink.h>
+#include <net/ip_tunnels.h>
+#include <net/addrconf.h>
+
+static LIST_HEAD(device_list);
+
+static int wg_open(struct net_device *dev)
+{
+	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
+	struct inet6_dev *dev_v6 = __in6_dev_get(dev);
+	struct wg_device *wg = netdev_priv(dev);
+	struct wg_peer *peer;
+	int ret;
+
+	if (dev_v4) {
+		/* At some point we might put this check near the ip_rt_send_
+		 * redirect call of ip_forward in net/ipv4/ip_forward.c, similar
+		 * to the current secpath check.
+		 */
+		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
+	}
+	if (dev_v6)
+		dev_v6->cnf.addr_gen_mode = IN6_ADDR_GEN_MODE_NONE;
+
+	ret = wg_socket_init(wg, wg->incoming_port);
+	if (ret < 0)
+		return ret;
+	mutex_lock(&wg->device_update_lock);
+	list_for_each_entry(peer, &wg->peer_list, peer_list) {
+		wg_packet_send_staged_packets(peer);
+		if (peer->persistent_keepalive_interval)
+			wg_packet_send_keepalive(peer);
+	}
+	mutex_unlock(&wg->device_update_lock);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int wg_pm_notification(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct wg_device *wg;
+	struct wg_peer *peer;
+
+	/* If the machine is constantly suspending and resuming, as part of
+	 * its normal operation rather than as a somewhat rare event, then we
+	 * don't actually want to clear keys.
+	 */
+	if (IS_ENABLED(CONFIG_PM_AUTOSLEEP) || IS_ENABLED(CONFIG_ANDROID))
+		return 0;
+
+	if (action != PM_HIBERNATION_PREPARE && action != PM_SUSPEND_PREPARE)
+		return 0;
+
+	rtnl_lock();
+	list_for_each_entry(wg, &device_list, device_list) {
+		mutex_lock(&wg->device_update_lock);
+		list_for_each_entry(peer, &wg->peer_list, peer_list) {
+			del_timer(&peer->timer_zero_key_material);
+			wg_noise_handshake_clear(&peer->handshake);
+			wg_noise_keypairs_clear(&peer->keypairs);
+		}
+		mutex_unlock(&wg->device_update_lock);
+	}
+	rtnl_unlock();
+	rcu_barrier();
+	return 0;
+}
+
+static struct notifier_block pm_notifier = { .notifier_call = wg_pm_notification };
+#endif
+
+static int wg_stop(struct net_device *dev)
+{
+	struct wg_device *wg = netdev_priv(dev);
+	struct wg_peer *peer;
+
+	mutex_lock(&wg->device_update_lock);
+	list_for_each_entry(peer, &wg->peer_list, peer_list) {
+		wg_packet_purge_staged_packets(peer);
+		wg_timers_stop(peer);
+		wg_noise_handshake_clear(&peer->handshake);
+		wg_noise_keypairs_clear(&peer->keypairs);
+		wg_noise_reset_last_sent_handshake(&peer->last_sent_handshake);
+	}
+	mutex_unlock(&wg->device_update_lock);
+	skb_queue_purge(&wg->incoming_handshakes);
+	wg_socket_reinit(wg, NULL, NULL);
+	return 0;
+}
+
+static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct wg_device *wg = netdev_priv(dev);
+	struct sk_buff_head packets;
+	struct wg_peer *peer;
+	struct sk_buff *next;
+	sa_family_t family;
+	u32 mtu;
+	int ret;
+
+	if (unlikely(wg_skb_examine_untrusted_ip_hdr(skb) != skb->protocol)) {
+		ret = -EPROTONOSUPPORT;
+		net_dbg_ratelimited("%s: Invalid IP packet\n", dev->name);
+		goto err;
+	}
+
+	peer = wg_allowedips_lookup_dst(&wg->peer_allowedips, skb);
+	if (unlikely(!peer)) {
+		ret = -ENOKEY;
+		if (skb->protocol == htons(ETH_P_IP))
+			net_dbg_ratelimited("%s: No peer has allowed IPs matching %pI4\n",
+					    dev->name, &ip_hdr(skb)->daddr);
+		else if (skb->protocol == htons(ETH_P_IPV6))
+			net_dbg_ratelimited("%s: No peer has allowed IPs matching %pI6\n",
+					    dev->name, &ipv6_hdr(skb)->daddr);
+		goto err;
+	}
+
+	family = READ_ONCE(peer->endpoint.addr.sa_family);
+	if (unlikely(family != AF_INET && family != AF_INET6)) {
+		ret = -EDESTADDRREQ;
+		net_dbg_ratelimited("%s: No valid endpoint has been configured or discovered for peer %llu\n",
+				    dev->name, peer->internal_id);
+		goto err_peer;
+	}
+
+	mtu = skb_dst(skb) ? dst_mtu(skb_dst(skb)) : dev->mtu;
+
+	__skb_queue_head_init(&packets);
+	if (!skb_is_gso(skb)) {
+		skb_mark_not_on_list(skb);
+	} else {
+		struct sk_buff *segs = skb_gso_segment(skb, 0);
+
+		if (unlikely(IS_ERR(segs))) {
+			ret = PTR_ERR(segs);
+			goto err_peer;
+		}
+		dev_kfree_skb(skb);
+		skb = segs;
+	}
+	do {
+		next = skb->next;
+		skb_mark_not_on_list(skb);
+
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (unlikely(!skb))
+			continue;
+
+		/* We only need to keep the original dst around for icmp,
+		 * so at this point we're in a position to drop it.
+		 */
+		skb_dst_drop(skb);
+
+		PACKET_CB(skb)->mtu = mtu;
+
+		__skb_queue_tail(&packets, skb);
+	} while ((skb = next) != NULL);
+
+	spin_lock_bh(&peer->staged_packet_queue.lock);
+	/* If the queue is getting too big, we start removing the oldest packets
+	 * until it's small again. We do this before adding the new packet, so
+	 * we don't remove GSO segments that are in excess.
+	 */
+	while (skb_queue_len(&peer->staged_packet_queue) > MAX_STAGED_PACKETS) {
+		dev_kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
+		++dev->stats.tx_dropped;
+	}
+	skb_queue_splice_tail(&packets, &peer->staged_packet_queue);
+	spin_unlock_bh(&peer->staged_packet_queue.lock);
+
+	wg_packet_send_staged_packets(peer);
+
+	wg_peer_put(peer);
+	return NETDEV_TX_OK;
+
+err_peer:
+	wg_peer_put(peer);
+err:
+	++dev->stats.tx_errors;
+	if (skb->protocol == htons(ETH_P_IP))
+		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
+	else if (skb->protocol == htons(ETH_P_IPV6))
+		icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0);
+	kfree_skb(skb);
+	return ret;
+}
+
+static const struct net_device_ops netdev_ops = {
+	.ndo_open		= wg_open,
+	.ndo_stop		= wg_stop,
+	.ndo_start_xmit		= wg_xmit,
+	.ndo_get_stats64	= ip_tunnel_get_stats64
+};
+
+static void wg_destruct(struct net_device *dev)
+{
+	struct wg_device *wg = netdev_priv(dev);
+
+	rtnl_lock();
+	list_del(&wg->device_list);
+	rtnl_unlock();
+	mutex_lock(&wg->device_update_lock);
+	wg->incoming_port = 0;
+	wg_socket_reinit(wg, NULL, NULL);
+	/* The final references are cleared in the below calls to destroy_workqueue. */
+	wg_peer_remove_all(wg);
+	destroy_workqueue(wg->handshake_receive_wq);
+	destroy_workqueue(wg->handshake_send_wq);
+	destroy_workqueue(wg->packet_crypt_wq);
+	wg_packet_queue_free(&wg->decrypt_queue, true);
+	wg_packet_queue_free(&wg->encrypt_queue, true);
+	rcu_barrier(); /* Wait for all the peers to be actually freed. */
+	wg_ratelimiter_uninit();
+	memzero_explicit(&wg->static_identity, sizeof(wg->static_identity));
+	skb_queue_purge(&wg->incoming_handshakes);
+	free_percpu(dev->tstats);
+	free_percpu(wg->incoming_handshakes_worker);
+	if (wg->have_creating_net_ref)
+		put_net(wg->creating_net);
+	kvfree(wg->index_hashtable);
+	kvfree(wg->peer_hashtable);
+	mutex_unlock(&wg->device_update_lock);
+
+	pr_debug("%s: Interface deleted\n", dev->name);
+	free_netdev(dev);
+}
+
+static const struct device_type device_type = { .name = KBUILD_MODNAME };
+
+static void wg_setup(struct net_device *dev)
+{
+	struct wg_device *wg = netdev_priv(dev);
+	enum { WG_NETDEV_FEATURES = NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
+				    NETIF_F_SG | NETIF_F_GSO |
+				    NETIF_F_GSO_SOFTWARE | NETIF_F_HIGHDMA };
+
+	dev->netdev_ops = &netdev_ops;
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->needed_headroom = DATA_PACKET_HEAD_ROOM;
+	dev->needed_tailroom = noise_encrypted_len(MESSAGE_PADDING_MULTIPLE);
+	dev->type = ARPHRD_NONE;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->features |= NETIF_F_LLTX;
+	dev->features |= WG_NETDEV_FEATURES;
+	dev->hw_features |= WG_NETDEV_FEATURES;
+	dev->hw_enc_features |= WG_NETDEV_FEATURES;
+	dev->mtu = ETH_DATA_LEN - MESSAGE_MINIMUM_LENGTH -
+		   sizeof(struct udphdr) -
+		   max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
+
+	SET_NETDEV_DEVTYPE(dev, &device_type);
+
+	/* We need to keep the dst around in case of icmp replies. */
+	netif_keep_dst(dev);
+
+	memset(wg, 0, sizeof(*wg));
+	wg->dev = dev;
+}
+
+static int wg_newlink(struct net *src_net, struct net_device *dev,
+		      struct nlattr *tb[], struct nlattr *data[],
+		      struct netlink_ext_ack *extack)
+{
+	struct wg_device *wg = netdev_priv(dev);
+	int ret = -ENOMEM;
+
+	wg->creating_net = src_net;
+	init_rwsem(&wg->static_identity.lock);
+	mutex_init(&wg->socket_update_lock);
+	mutex_init(&wg->device_update_lock);
+	skb_queue_head_init(&wg->incoming_handshakes);
+	wg_allowedips_init(&wg->peer_allowedips);
+	wg_cookie_checker_init(&wg->cookie_checker, wg);
+	INIT_LIST_HEAD(&wg->peer_list);
+	wg->device_update_gen = 1;
+
+	wg->peer_hashtable = wg_pubkey_hashtable_alloc();
+	if (!wg->peer_hashtable)
+		return ret;
+
+	wg->index_hashtable = wg_index_hashtable_alloc();
+	if (!wg->index_hashtable)
+		goto err_free_peer_hashtable;
+
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		goto err_free_index_hashtable;
+
+	wg->incoming_handshakes_worker =
+		wg_packet_percpu_multicore_worker_alloc(
+				wg_packet_handshake_receive_worker, wg);
+	if (!wg->incoming_handshakes_worker)
+		goto err_free_tstats;
+
+	wg->handshake_receive_wq = alloc_workqueue("wg-kex-%s",
+			WQ_CPU_INTENSIVE | WQ_FREEZABLE, 0, dev->name);
+	if (!wg->handshake_receive_wq)
+		goto err_free_incoming_handshakes;
+
+	wg->handshake_send_wq = alloc_workqueue("wg-kex-%s",
+			WQ_UNBOUND | WQ_FREEZABLE, 0, dev->name);
+	if (!wg->handshake_send_wq)
+		goto err_destroy_handshake_receive;
+
+	wg->packet_crypt_wq = alloc_workqueue("wg-crypt-%s",
+			WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0, dev->name);
+	if (!wg->packet_crypt_wq)
+		goto err_destroy_handshake_send;
+
+	ret = wg_packet_queue_init(&wg->encrypt_queue, wg_packet_encrypt_worker,
+				   true, MAX_QUEUED_PACKETS);
+	if (ret < 0)
+		goto err_destroy_packet_crypt;
+
+	ret = wg_packet_queue_init(&wg->decrypt_queue, wg_packet_decrypt_worker,
+				   true, MAX_QUEUED_PACKETS);
+	if (ret < 0)
+		goto err_free_encrypt_queue;
+
+	ret = wg_ratelimiter_init();
+	if (ret < 0)
+		goto err_free_decrypt_queue;
+
+	ret = register_netdevice(dev);
+	if (ret < 0)
+		goto err_uninit_ratelimiter;
+
+	list_add(&wg->device_list, &device_list);
+
+	/* We wait until the end to assign priv_destructor, so that
+	 * register_netdevice doesn't call it for us if it fails.
+	 */
+	dev->priv_destructor = wg_destruct;
+
+	pr_debug("%s: Interface created\n", dev->name);
+	return ret;
+
+err_uninit_ratelimiter:
+	wg_ratelimiter_uninit();
+err_free_decrypt_queue:
+	wg_packet_queue_free(&wg->decrypt_queue, true);
+err_free_encrypt_queue:
+	wg_packet_queue_free(&wg->encrypt_queue, true);
+err_destroy_packet_crypt:
+	destroy_workqueue(wg->packet_crypt_wq);
+err_destroy_handshake_send:
+	destroy_workqueue(wg->handshake_send_wq);
+err_destroy_handshake_receive:
+	destroy_workqueue(wg->handshake_receive_wq);
+err_free_incoming_handshakes:
+	free_percpu(wg->incoming_handshakes_worker);
+err_free_tstats:
+	free_percpu(dev->tstats);
+err_free_index_hashtable:
+	kvfree(wg->index_hashtable);
+err_free_peer_hashtable:
+	kvfree(wg->peer_hashtable);
+	return ret;
+}
+
+static struct rtnl_link_ops link_ops __read_mostly = {
+	.kind			= KBUILD_MODNAME,
+	.priv_size		= sizeof(struct wg_device),
+	.setup			= wg_setup,
+	.newlink		= wg_newlink,
+};
+
+static int wg_netdevice_notification(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct net_device *dev = ((struct netdev_notifier_info *)data)->dev;
+	struct wg_device *wg = netdev_priv(dev);
+
+	ASSERT_RTNL();
+
+	if (action != NETDEV_REGISTER || dev->netdev_ops != &netdev_ops)
+		return 0;
+
+	if (dev_net(dev) == wg->creating_net && wg->have_creating_net_ref) {
+		put_net(wg->creating_net);
+		wg->have_creating_net_ref = false;
+	} else if (dev_net(dev) != wg->creating_net &&
+		   !wg->have_creating_net_ref) {
+		wg->have_creating_net_ref = true;
+		get_net(wg->creating_net);
+	}
+	return 0;
+}
+
+static struct notifier_block netdevice_notifier = {
+	.notifier_call = wg_netdevice_notification
+};
+
+int __init wg_device_init(void)
+{
+	int ret;
+
+#ifdef CONFIG_PM_SLEEP
+	ret = register_pm_notifier(&pm_notifier);
+	if (ret)
+		return ret;
+#endif
+
+	ret = register_netdevice_notifier(&netdevice_notifier);
+	if (ret)
+		goto error_pm;
+
+	ret = rtnl_link_register(&link_ops);
+	if (ret)
+		goto error_netdevice;
+
+	return 0;
+
+error_netdevice:
+	unregister_netdevice_notifier(&netdevice_notifier);
+error_pm:
+#ifdef CONFIG_PM_SLEEP
+	unregister_pm_notifier(&pm_notifier);
+#endif
+	return ret;
+}
+
+void wg_device_uninit(void)
+{
+	rtnl_link_unregister(&link_ops);
+	unregister_netdevice_notifier(&netdevice_notifier);
+#ifdef CONFIG_PM_SLEEP
+	unregister_pm_notifier(&pm_notifier);
+#endif
+	rcu_barrier();
+}
diff --git a/drivers/net/wireguard/device.h b/drivers/net/wireguard/device.h
new file mode 100644
index 000000000000..b15a8be9d816
--- /dev/null
+++ b/drivers/net/wireguard/device.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_DEVICE_H
+#define _WG_DEVICE_H
+
+#include "noise.h"
+#include "allowedips.h"
+#include "peerlookup.h"
+#include "cookie.h"
+
+#include <linux/types.h>
+#include <linux/netdevice.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+#include <linux/net.h>
+#include <linux/ptr_ring.h>
+
+struct wg_device;
+
+struct multicore_worker {
+	void *ptr;
+	struct work_struct work;
+};
+
+struct crypt_queue {
+	struct ptr_ring ring;
+	union {
+		struct {
+			struct multicore_worker __percpu *worker;
+			int last_cpu;
+		};
+		struct work_struct work;
+	};
+};
+
+struct wg_device {
+	struct net_device *dev;
+	struct crypt_queue encrypt_queue, decrypt_queue;
+	struct sock __rcu *sock4, *sock6;
+	struct net *creating_net;
+	struct noise_static_identity static_identity;
+	struct workqueue_struct *handshake_receive_wq, *handshake_send_wq;
+	struct workqueue_struct *packet_crypt_wq;
+	struct sk_buff_head incoming_handshakes;
+	int incoming_handshake_cpu;
+	struct multicore_worker __percpu *incoming_handshakes_worker;
+	struct cookie_checker cookie_checker;
+	struct pubkey_hashtable *peer_hashtable;
+	struct index_hashtable *index_hashtable;
+	struct allowedips peer_allowedips;
+	struct mutex device_update_lock, socket_update_lock;
+	struct list_head device_list, peer_list;
+	unsigned int num_peers, device_update_gen;
+	u32 fwmark;
+	u16 incoming_port;
+	bool have_creating_net_ref;
+};
+
+int wg_device_init(void);
+void wg_device_uninit(void);
+
+#endif /* _WG_DEVICE_H */
diff --git a/drivers/net/wireguard/main.c b/drivers/net/wireguard/main.c
new file mode 100644
index 000000000000..10c0a40f6a9e
--- /dev/null
+++ b/drivers/net/wireguard/main.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "version.h"
+#include "device.h"
+#include "noise.h"
+#include "queueing.h"
+#include "ratelimiter.h"
+#include "netlink.h"
+
+#include <uapi/linux/wireguard.h>
+
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/genetlink.h>
+#include <net/rtnetlink.h>
+
+static int __init mod_init(void)
+{
+	int ret;
+
+#ifdef DEBUG
+	if (!wg_allowedips_selftest() || !wg_packet_counter_selftest() ||
+	    !wg_ratelimiter_selftest())
+		return -ENOTRECOVERABLE;
+#endif
+	wg_noise_init();
+
+	ret = wg_device_init();
+	if (ret < 0)
+		goto err_device;
+
+	ret = wg_genetlink_init();
+	if (ret < 0)
+		goto err_netlink;
+
+	pr_info("WireGuard " WIREGUARD_VERSION " loaded. See www.wireguard.com for information.\n");
+	pr_info("Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.\n");
+
+	return 0;
+
+err_netlink:
+	wg_device_uninit();
+err_device:
+	return ret;
+}
+
+static void __exit mod_exit(void)
+{
+	wg_genetlink_uninit();
+	wg_device_uninit();
+}
+
+module_init(mod_init);
+module_exit(mod_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("WireGuard secure network tunnel");
+MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
+MODULE_VERSION(WIREGUARD_VERSION);
+MODULE_ALIAS_RTNL_LINK(KBUILD_MODNAME);
+MODULE_ALIAS_GENL_FAMILY(WG_GENL_NAME);
diff --git a/drivers/net/wireguard/messages.h b/drivers/net/wireguard/messages.h
new file mode 100644
index 000000000000..b8a7b9ce32ba
--- /dev/null
+++ b/drivers/net/wireguard/messages.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_MESSAGES_H
+#define _WG_MESSAGES_H
+
+#include <crypto/curve25519.h>
+#include <crypto/chacha20poly1305.h>
+#include <crypto/blake2s.h>
+
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/skbuff.h>
+
+enum noise_lengths {
+	NOISE_PUBLIC_KEY_LEN = CURVE25519_KEY_SIZE,
+	NOISE_SYMMETRIC_KEY_LEN = CHACHA20POLY1305_KEY_SIZE,
+	NOISE_TIMESTAMP_LEN = sizeof(u64) + sizeof(u32),
+	NOISE_AUTHTAG_LEN = CHACHA20POLY1305_AUTHTAG_SIZE,
+	NOISE_HASH_LEN = BLAKE2S_HASH_SIZE
+};
+
+#define noise_encrypted_len(plain_len) ((plain_len) + NOISE_AUTHTAG_LEN)
+
+enum cookie_values {
+	COOKIE_SECRET_MAX_AGE = 2 * 60,
+	COOKIE_SECRET_LATENCY = 5,
+	COOKIE_NONCE_LEN = XCHACHA20POLY1305_NONCE_SIZE,
+	COOKIE_LEN = 16
+};
+
+enum counter_values {
+	COUNTER_BITS_TOTAL = 2048,
+	COUNTER_REDUNDANT_BITS = BITS_PER_LONG,
+	COUNTER_WINDOW_SIZE = COUNTER_BITS_TOTAL - COUNTER_REDUNDANT_BITS
+};
+
+enum limits {
+	REKEY_AFTER_MESSAGES = 1ULL << 60,
+	REJECT_AFTER_MESSAGES = U64_MAX - COUNTER_WINDOW_SIZE - 1,
+	REKEY_TIMEOUT = 5,
+	REKEY_TIMEOUT_JITTER_MAX_JIFFIES = HZ / 3,
+	REKEY_AFTER_TIME = 120,
+	REJECT_AFTER_TIME = 180,
+	INITIATIONS_PER_SECOND = 50,
+	MAX_PEERS_PER_DEVICE = 1U << 20,
+	KEEPALIVE_TIMEOUT = 10,
+	MAX_TIMER_HANDSHAKES = 90 / REKEY_TIMEOUT,
+	MAX_QUEUED_INCOMING_HANDSHAKES = 4096, /* TODO: replace this with DQL */
+	MAX_STAGED_PACKETS = 128,
+	MAX_QUEUED_PACKETS = 1024 /* TODO: replace this with DQL */
+};
+
+enum message_type {
+	MESSAGE_INVALID = 0,
+	MESSAGE_HANDSHAKE_INITIATION = 1,
+	MESSAGE_HANDSHAKE_RESPONSE = 2,
+	MESSAGE_HANDSHAKE_COOKIE = 3,
+	MESSAGE_DATA = 4
+};
+
+struct message_header {
+	/* The actual layout of this that we want is:
+	 * u8 type
+	 * u8 reserved_zero[3]
+	 *
+	 * But it turns out that by encoding this as little endian,
+	 * we achieve the same thing, and it makes checking faster.
+	 */
+	__le32 type;
+};
+
+struct message_macs {
+	u8 mac1[COOKIE_LEN];
+	u8 mac2[COOKIE_LEN];
+};
+
+struct message_handshake_initiation {
+	struct message_header header;
+	__le32 sender_index;
+	u8 unencrypted_ephemeral[NOISE_PUBLIC_KEY_LEN];
+	u8 encrypted_static[noise_encrypted_len(NOISE_PUBLIC_KEY_LEN)];
+	u8 encrypted_timestamp[noise_encrypted_len(NOISE_TIMESTAMP_LEN)];
+	struct message_macs macs;
+};
+
+struct message_handshake_response {
+	struct message_header header;
+	__le32 sender_index;
+	__le32 receiver_index;
+	u8 unencrypted_ephemeral[NOISE_PUBLIC_KEY_LEN];
+	u8 encrypted_nothing[noise_encrypted_len(0)];
+	struct message_macs macs;
+};
+
+struct message_handshake_cookie {
+	struct message_header header;
+	__le32 receiver_index;
+	u8 nonce[COOKIE_NONCE_LEN];
+	u8 encrypted_cookie[noise_encrypted_len(COOKIE_LEN)];
+};
+
+struct message_data {
+	struct message_header header;
+	__le32 key_idx;
+	__le64 counter;
+	u8 encrypted_data[];
+};
+
+#define message_data_len(plain_len) \
+	(noise_encrypted_len(plain_len) + sizeof(struct message_data))
+
+enum message_alignments {
+	MESSAGE_PADDING_MULTIPLE = 16,
+	MESSAGE_MINIMUM_LENGTH = message_data_len(0)
+};
+
+#define SKB_HEADER_LEN                                       \
+	(max(sizeof(struct iphdr), sizeof(struct ipv6hdr)) + \
+	 sizeof(struct udphdr) + NET_SKB_PAD)
+#define DATA_PACKET_HEAD_ROOM \
+	ALIGN(sizeof(struct message_data) + SKB_HEADER_LEN, 4)
+
+enum { HANDSHAKE_DSCP = 0x88 /* AF41, plus 00 ECN */ };
+
+#endif /* _WG_MESSAGES_H */
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
new file mode 100644
index 000000000000..522f59432c6a
--- /dev/null
+++ b/drivers/net/wireguard/netlink.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "netlink.h"
+#include "device.h"
+#include "peer.h"
+#include "socket.h"
+#include "queueing.h"
+#include "messages.h"
+
+#include <uapi/linux/wireguard.h>
+
+#include <linux/if.h>
+#include <net/genetlink.h>
+#include <net/sock.h>
+#include <crypto/algapi.h>
+
+static struct genl_family genl_family;
+
+static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
+	[WGDEVICE_A_IFINDEX]		= { .type = NLA_U32 },
+	[WGDEVICE_A_IFNAME]		= { .type = NLA_NUL_STRING, .len = IFNAMSIZ - 1 },
+	[WGDEVICE_A_PRIVATE_KEY]	= { .type = NLA_EXACT_LEN, .len = NOISE_PUBLIC_KEY_LEN },
+	[WGDEVICE_A_PUBLIC_KEY]		= { .type = NLA_EXACT_LEN, .len = NOISE_PUBLIC_KEY_LEN },
+	[WGDEVICE_A_FLAGS]		= { .type = NLA_U32 },
+	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
+	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
+	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
+};
+
+static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
+	[WGPEER_A_PUBLIC_KEY]				= { .type = NLA_EXACT_LEN, .len = NOISE_PUBLIC_KEY_LEN },
+	[WGPEER_A_PRESHARED_KEY]			= { .type = NLA_EXACT_LEN, .len = NOISE_SYMMETRIC_KEY_LEN },
+	[WGPEER_A_FLAGS]				= { .type = NLA_U32 },
+	[WGPEER_A_ENDPOINT]				= { .type = NLA_MIN_LEN, .len = sizeof(struct sockaddr) },
+	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
+	[WGPEER_A_LAST_HANDSHAKE_TIME]			= { .type = NLA_EXACT_LEN, .len = sizeof(struct __kernel_timespec) },
+	[WGPEER_A_RX_BYTES]				= { .type = NLA_U64 },
+	[WGPEER_A_TX_BYTES]				= { .type = NLA_U64 },
+	[WGPEER_A_ALLOWEDIPS]				= { .type = NLA_NESTED },
+	[WGPEER_A_PROTOCOL_VERSION]			= { .type = NLA_U32 }
+};
+
+static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1] = {
+	[WGALLOWEDIP_A_FAMILY]		= { .type = NLA_U16 },
+	[WGALLOWEDIP_A_IPADDR]		= { .type = NLA_MIN_LEN, .len = sizeof(struct in_addr) },
+	[WGALLOWEDIP_A_CIDR_MASK]	= { .type = NLA_U8 }
+};
+
+static struct wg_device *lookup_interface(struct nlattr **attrs,
+					  struct sk_buff *skb)
+{
+	struct net_device *dev = NULL;
+
+	if (!attrs[WGDEVICE_A_IFINDEX] == !attrs[WGDEVICE_A_IFNAME])
+		return ERR_PTR(-EBADR);
+	if (attrs[WGDEVICE_A_IFINDEX])
+		dev = dev_get_by_index(sock_net(skb->sk),
+				       nla_get_u32(attrs[WGDEVICE_A_IFINDEX]));
+	else if (attrs[WGDEVICE_A_IFNAME])
+		dev = dev_get_by_name(sock_net(skb->sk),
+				      nla_data(attrs[WGDEVICE_A_IFNAME]));
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+	if (!dev->rtnl_link_ops || !dev->rtnl_link_ops->kind ||
+	    strcmp(dev->rtnl_link_ops->kind, KBUILD_MODNAME)) {
+		dev_put(dev);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+	return netdev_priv(dev);
+}
+
+static int get_allowedips(struct sk_buff *skb, const u8 *ip, u8 cidr,
+			  int family)
+{
+	struct nlattr *allowedip_nest;
+
+	allowedip_nest = nla_nest_start(skb, 0);
+	if (!allowedip_nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u8(skb, WGALLOWEDIP_A_CIDR_MASK, cidr) ||
+	    nla_put_u16(skb, WGALLOWEDIP_A_FAMILY, family) ||
+	    nla_put(skb, WGALLOWEDIP_A_IPADDR, family == AF_INET6 ?
+		    sizeof(struct in6_addr) : sizeof(struct in_addr), ip)) {
+		nla_nest_cancel(skb, allowedip_nest);
+		return -EMSGSIZE;
+	}
+
+	nla_nest_end(skb, allowedip_nest);
+	return 0;
+}
+
+struct dump_ctx {
+	struct wg_device *wg;
+	struct wg_peer *next_peer;
+	struct allowedips_node *next_allowedip;
+	u64 allowedips_seq;
+};
+
+#define DUMP_CTX(cb) ((struct dump_ctx *)(cb)->args)
+
+static int
+get_peer(struct wg_peer *peer, struct sk_buff *skb, struct dump_ctx *ctx)
+{
+
+	struct nlattr *allowedips_nest, *peer_nest = nla_nest_start(skb, 0);
+	struct allowedips_node *allowedips_node = ctx->next_allowedip;
+	bool fail;
+
+	if (!peer_nest)
+		return -EMSGSIZE;
+
+	down_read(&peer->handshake.lock);
+	fail = nla_put(skb, WGPEER_A_PUBLIC_KEY, NOISE_PUBLIC_KEY_LEN,
+		       peer->handshake.remote_static);
+	up_read(&peer->handshake.lock);
+	if (fail)
+		goto err;
+
+	if (!allowedips_node) {
+		const struct __kernel_timespec last_handshake = {
+			.tv_sec = peer->walltime_last_handshake.tv_sec,
+			.tv_nsec = peer->walltime_last_handshake.tv_nsec
+		};
+
+		down_read(&peer->handshake.lock);
+		fail = nla_put(skb, WGPEER_A_PRESHARED_KEY,
+			       NOISE_SYMMETRIC_KEY_LEN,
+			       peer->handshake.preshared_key);
+		up_read(&peer->handshake.lock);
+		if (fail)
+			goto err;
+
+		if (nla_put(skb, WGPEER_A_LAST_HANDSHAKE_TIME,
+			    sizeof(last_handshake), &last_handshake) ||
+		    nla_put_u16(skb, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
+				peer->persistent_keepalive_interval) ||
+		    nla_put_u64_64bit(skb, WGPEER_A_TX_BYTES, peer->tx_bytes,
+				      WGPEER_A_UNSPEC) ||
+		    nla_put_u64_64bit(skb, WGPEER_A_RX_BYTES, peer->rx_bytes,
+				      WGPEER_A_UNSPEC) ||
+		    nla_put_u32(skb, WGPEER_A_PROTOCOL_VERSION, 1))
+			goto err;
+
+		read_lock_bh(&peer->endpoint_lock);
+		if (peer->endpoint.addr.sa_family == AF_INET)
+			fail = nla_put(skb, WGPEER_A_ENDPOINT,
+				       sizeof(peer->endpoint.addr4),
+				       &peer->endpoint.addr4);
+		else if (peer->endpoint.addr.sa_family == AF_INET6)
+			fail = nla_put(skb, WGPEER_A_ENDPOINT,
+				       sizeof(peer->endpoint.addr6),
+				       &peer->endpoint.addr6);
+		read_unlock_bh(&peer->endpoint_lock);
+		if (fail)
+			goto err;
+		allowedips_node =
+			list_first_entry_or_null(&peer->allowedips_list,
+					struct allowedips_node, peer_list);
+	}
+	if (!allowedips_node)
+		goto no_allowedips;
+	if (!ctx->allowedips_seq)
+		ctx->allowedips_seq = peer->device->peer_allowedips.seq;
+	else if (ctx->allowedips_seq != peer->device->peer_allowedips.seq)
+		goto no_allowedips;
+
+	allowedips_nest = nla_nest_start(skb, WGPEER_A_ALLOWEDIPS);
+	if (!allowedips_nest)
+		goto err;
+
+	list_for_each_entry_from(allowedips_node, &peer->allowedips_list,
+				 peer_list) {
+		u8 cidr, ip[16] __aligned(__alignof(u64));
+		int family;
+
+		family = wg_allowedips_read_node(allowedips_node, ip, &cidr);
+		if (get_allowedips(skb, ip, cidr, family)) {
+			nla_nest_end(skb, allowedips_nest);
+			nla_nest_end(skb, peer_nest);
+			ctx->next_allowedip = allowedips_node;
+			return -EMSGSIZE;
+		}
+	}
+	nla_nest_end(skb, allowedips_nest);
+no_allowedips:
+	nla_nest_end(skb, peer_nest);
+	ctx->next_allowedip = NULL;
+	ctx->allowedips_seq = 0;
+	return 0;
+err:
+	nla_nest_cancel(skb, peer_nest);
+	return -EMSGSIZE;
+}
+
+static int wg_get_device_start(struct netlink_callback *cb)
+{
+	struct wg_device *wg;
+
+	wg = lookup_interface(genl_dumpit_info(cb)->attrs, cb->skb);
+	if (IS_ERR(wg))
+		return PTR_ERR(wg);
+	DUMP_CTX(cb)->wg = wg;
+	return 0;
+}
+
+static int wg_get_device_dump(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct wg_peer *peer, *next_peer_cursor;
+	struct dump_ctx *ctx = DUMP_CTX(cb);
+	struct wg_device *wg = ctx->wg;
+	struct nlattr *peers_nest;
+	int ret = -EMSGSIZE;
+	bool done = true;
+	void *hdr;
+
+	rtnl_lock();
+	mutex_lock(&wg->device_update_lock);
+	cb->seq = wg->device_update_gen;
+	next_peer_cursor = ctx->next_peer;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &genl_family, NLM_F_MULTI, WG_CMD_GET_DEVICE);
+	if (!hdr)
+		goto out;
+	genl_dump_check_consistent(cb, hdr);
+
+	if (!ctx->next_peer) {
+		if (nla_put_u16(skb, WGDEVICE_A_LISTEN_PORT,
+				wg->incoming_port) ||
+		    nla_put_u32(skb, WGDEVICE_A_FWMARK, wg->fwmark) ||
+		    nla_put_u32(skb, WGDEVICE_A_IFINDEX, wg->dev->ifindex) ||
+		    nla_put_string(skb, WGDEVICE_A_IFNAME, wg->dev->name))
+			goto out;
+
+		down_read(&wg->static_identity.lock);
+		if (wg->static_identity.has_identity) {
+			if (nla_put(skb, WGDEVICE_A_PRIVATE_KEY,
+				    NOISE_PUBLIC_KEY_LEN,
+				    wg->static_identity.static_private) ||
+			    nla_put(skb, WGDEVICE_A_PUBLIC_KEY,
+				    NOISE_PUBLIC_KEY_LEN,
+				    wg->static_identity.static_public)) {
+				up_read(&wg->static_identity.lock);
+				goto out;
+			}
+		}
+		up_read(&wg->static_identity.lock);
+	}
+
+	peers_nest = nla_nest_start(skb, WGDEVICE_A_PEERS);
+	if (!peers_nest)
+		goto out;
+	ret = 0;
+	/* If the last cursor was removed via list_del_init in peer_remove, then
+	 * we just treat this the same as there being no more peers left. The
+	 * reason is that seq_nr should indicate to userspace that this isn't a
+	 * coherent dump anyway, so they'll try again.
+	 */
+	if (list_empty(&wg->peer_list) ||
+	    (ctx->next_peer && list_empty(&ctx->next_peer->peer_list))) {
+		nla_nest_cancel(skb, peers_nest);
+		goto out;
+	}
+	lockdep_assert_held(&wg->device_update_lock);
+	peer = list_prepare_entry(ctx->next_peer, &wg->peer_list, peer_list);
+	list_for_each_entry_continue(peer, &wg->peer_list, peer_list) {
+		if (get_peer(peer, skb, ctx)) {
+			done = false;
+			break;
+		}
+		next_peer_cursor = peer;
+	}
+	nla_nest_end(skb, peers_nest);
+
+out:
+	if (!ret && !done && next_peer_cursor)
+		wg_peer_get(next_peer_cursor);
+	wg_peer_put(ctx->next_peer);
+	mutex_unlock(&wg->device_update_lock);
+	rtnl_unlock();
+
+	if (ret) {
+		genlmsg_cancel(skb, hdr);
+		return ret;
+	}
+	genlmsg_end(skb, hdr);
+	if (done) {
+		ctx->next_peer = NULL;
+		return 0;
+	}
+	ctx->next_peer = next_peer_cursor;
+	return skb->len;
+
+	/* At this point, we can't really deal ourselves with safely zeroing out
+	 * the private key material after usage. This will need an additional API
+	 * in the kernel for marking skbs as zero_on_free.
+	 */
+}
+
+static int wg_get_device_done(struct netlink_callback *cb)
+{
+	struct dump_ctx *ctx = DUMP_CTX(cb);
+
+	if (ctx->wg)
+		dev_put(ctx->wg->dev);
+	wg_peer_put(ctx->next_peer);
+	return 0;
+}
+
+static int set_port(struct wg_device *wg, u16 port)
+{
+	struct wg_peer *peer;
+
+	if (wg->incoming_port == port)
+		return 0;
+	list_for_each_entry(peer, &wg->peer_list, peer_list)
+		wg_socket_clear_peer_endpoint_src(peer);
+	if (!netif_running(wg->dev)) {
+		wg->incoming_port = port;
+		return 0;
+	}
+	return wg_socket_init(wg, port);
+}
+
+static int set_allowedip(struct wg_peer *peer, struct nlattr **attrs)
+{
+	int ret = -EINVAL;
+	u16 family;
+	u8 cidr;
+
+	if (!attrs[WGALLOWEDIP_A_FAMILY] || !attrs[WGALLOWEDIP_A_IPADDR] ||
+	    !attrs[WGALLOWEDIP_A_CIDR_MASK])
+		return ret;
+	family = nla_get_u16(attrs[WGALLOWEDIP_A_FAMILY]);
+	cidr = nla_get_u8(attrs[WGALLOWEDIP_A_CIDR_MASK]);
+
+	if (family == AF_INET && cidr <= 32 &&
+	    nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in_addr))
+		ret = wg_allowedips_insert_v4(
+			&peer->device->peer_allowedips,
+			nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr, peer,
+			&peer->device->device_update_lock);
+	else if (family == AF_INET6 && cidr <= 128 &&
+		 nla_len(attrs[WGALLOWEDIP_A_IPADDR]) == sizeof(struct in6_addr))
+		ret = wg_allowedips_insert_v6(
+			&peer->device->peer_allowedips,
+			nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr, peer,
+			&peer->device->device_update_lock);
+
+	return ret;
+}
+
+static int set_peer(struct wg_device *wg, struct nlattr **attrs)
+{
+	u8 *public_key = NULL, *preshared_key = NULL;
+	struct wg_peer *peer = NULL;
+	u32 flags = 0;
+	int ret;
+
+	ret = -EINVAL;
+	if (attrs[WGPEER_A_PUBLIC_KEY] &&
+	    nla_len(attrs[WGPEER_A_PUBLIC_KEY]) == NOISE_PUBLIC_KEY_LEN)
+		public_key = nla_data(attrs[WGPEER_A_PUBLIC_KEY]);
+	else
+		goto out;
+	if (attrs[WGPEER_A_PRESHARED_KEY] &&
+	    nla_len(attrs[WGPEER_A_PRESHARED_KEY]) == NOISE_SYMMETRIC_KEY_LEN)
+		preshared_key = nla_data(attrs[WGPEER_A_PRESHARED_KEY]);
+
+	if (attrs[WGPEER_A_FLAGS])
+		flags = nla_get_u32(attrs[WGPEER_A_FLAGS]);
+	ret = -EOPNOTSUPP;
+	if (flags & ~__WGPEER_F_ALL)
+		goto out;
+
+	ret = -EPFNOSUPPORT;
+	if (attrs[WGPEER_A_PROTOCOL_VERSION]) {
+		if (nla_get_u32(attrs[WGPEER_A_PROTOCOL_VERSION]) != 1)
+			goto out;
+	}
+
+	peer = wg_pubkey_hashtable_lookup(wg->peer_hashtable,
+					  nla_data(attrs[WGPEER_A_PUBLIC_KEY]));
+	ret = 0;
+	if (!peer) { /* Peer doesn't exist yet. Add a new one. */
+		if (flags & (WGPEER_F_REMOVE_ME | WGPEER_F_UPDATE_ONLY))
+			goto out;
+
+		/* The peer is new, so there aren't allowed IPs to remove. */
+		flags &= ~WGPEER_F_REPLACE_ALLOWEDIPS;
+
+		down_read(&wg->static_identity.lock);
+		if (wg->static_identity.has_identity &&
+		    !memcmp(nla_data(attrs[WGPEER_A_PUBLIC_KEY]),
+			    wg->static_identity.static_public,
+			    NOISE_PUBLIC_KEY_LEN)) {
+			/* We silently ignore peers that have the same public
+			 * key as the device. The reason we do it silently is
+			 * that we'd like for people to be able to reuse the
+			 * same set of API calls across peers.
+			 */
+			up_read(&wg->static_identity.lock);
+			ret = 0;
+			goto out;
+		}
+		up_read(&wg->static_identity.lock);
+
+		peer = wg_peer_create(wg, public_key, preshared_key);
+		if (IS_ERR(peer)) {
+			/* Similar to the above, if the key is invalid, we skip
+			 * it without fanfare, so that services don't need to
+			 * worry about doing key validation themselves.
+			 */
+			ret = PTR_ERR(peer) == -EKEYREJECTED ? 0 : PTR_ERR(peer);
+			peer = NULL;
+			goto out;
+		}
+		/* Take additional reference, as though we've just been
+		 * looked up.
+		 */
+		wg_peer_get(peer);
+	}
+
+	if (flags & WGPEER_F_REMOVE_ME) {
+		wg_peer_remove(peer);
+		goto out;
+	}
+
+	if (preshared_key) {
+		down_write(&peer->handshake.lock);
+		memcpy(&peer->handshake.preshared_key, preshared_key,
+		       NOISE_SYMMETRIC_KEY_LEN);
+		up_write(&peer->handshake.lock);
+	}
+
+	if (attrs[WGPEER_A_ENDPOINT]) {
+		struct sockaddr *addr = nla_data(attrs[WGPEER_A_ENDPOINT]);
+		size_t len = nla_len(attrs[WGPEER_A_ENDPOINT]);
+
+		if ((len == sizeof(struct sockaddr_in) &&
+		     addr->sa_family == AF_INET) ||
+		    (len == sizeof(struct sockaddr_in6) &&
+		     addr->sa_family == AF_INET6)) {
+			struct endpoint endpoint = { { { 0 } } };
+
+			memcpy(&endpoint.addr, addr, len);
+			wg_socket_set_peer_endpoint(peer, &endpoint);
+		}
+	}
+
+	if (flags & WGPEER_F_REPLACE_ALLOWEDIPS)
+		wg_allowedips_remove_by_peer(&wg->peer_allowedips, peer,
+					     &wg->device_update_lock);
+
+	if (attrs[WGPEER_A_ALLOWEDIPS]) {
+		struct nlattr *attr, *allowedip[WGALLOWEDIP_A_MAX + 1];
+		int rem;
+
+		nla_for_each_nested(attr, attrs[WGPEER_A_ALLOWEDIPS], rem) {
+			ret = nla_parse_nested(allowedip, WGALLOWEDIP_A_MAX,
+					       attr, allowedip_policy, NULL);
+			if (ret < 0)
+				goto out;
+			ret = set_allowedip(peer, allowedip);
+			if (ret < 0)
+				goto out;
+		}
+	}
+
+	if (attrs[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]) {
+		const u16 persistent_keepalive_interval = nla_get_u16(
+				attrs[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]);
+		const bool send_keepalive =
+			!peer->persistent_keepalive_interval &&
+			persistent_keepalive_interval &&
+			netif_running(wg->dev);
+
+		peer->persistent_keepalive_interval = persistent_keepalive_interval;
+		if (send_keepalive)
+			wg_packet_send_keepalive(peer);
+	}
+
+	if (netif_running(wg->dev))
+		wg_packet_send_staged_packets(peer);
+
+out:
+	wg_peer_put(peer);
+	if (attrs[WGPEER_A_PRESHARED_KEY])
+		memzero_explicit(nla_data(attrs[WGPEER_A_PRESHARED_KEY]),
+				 nla_len(attrs[WGPEER_A_PRESHARED_KEY]));
+	return ret;
+}
+
+static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
+{
+	struct wg_device *wg = lookup_interface(info->attrs, skb);
+	u32 flags = 0;
+	int ret;
+
+	if (IS_ERR(wg)) {
+		ret = PTR_ERR(wg);
+		goto out_nodev;
+	}
+
+	rtnl_lock();
+	mutex_lock(&wg->device_update_lock);
+
+	if (info->attrs[WGDEVICE_A_FLAGS])
+		flags = nla_get_u32(info->attrs[WGDEVICE_A_FLAGS]);
+	ret = -EOPNOTSUPP;
+	if (flags & ~__WGDEVICE_F_ALL)
+		goto out;
+
+	ret = -EPERM;
+	if ((info->attrs[WGDEVICE_A_LISTEN_PORT] ||
+	     info->attrs[WGDEVICE_A_FWMARK]) &&
+	    !ns_capable(wg->creating_net->user_ns, CAP_NET_ADMIN))
+		goto out;
+
+	++wg->device_update_gen;
+
+	if (info->attrs[WGDEVICE_A_FWMARK]) {
+		struct wg_peer *peer;
+
+		wg->fwmark = nla_get_u32(info->attrs[WGDEVICE_A_FWMARK]);
+		list_for_each_entry(peer, &wg->peer_list, peer_list)
+			wg_socket_clear_peer_endpoint_src(peer);
+	}
+
+	if (info->attrs[WGDEVICE_A_LISTEN_PORT]) {
+		ret = set_port(wg,
+			nla_get_u16(info->attrs[WGDEVICE_A_LISTEN_PORT]));
+		if (ret)
+			goto out;
+	}
+
+	if (flags & WGDEVICE_F_REPLACE_PEERS)
+		wg_peer_remove_all(wg);
+
+	if (info->attrs[WGDEVICE_A_PRIVATE_KEY] &&
+	    nla_len(info->attrs[WGDEVICE_A_PRIVATE_KEY]) ==
+		    NOISE_PUBLIC_KEY_LEN) {
+		u8 *private_key = nla_data(info->attrs[WGDEVICE_A_PRIVATE_KEY]);
+		u8 public_key[NOISE_PUBLIC_KEY_LEN];
+		struct wg_peer *peer, *temp;
+
+		if (!crypto_memneq(wg->static_identity.static_private,
+				   private_key, NOISE_PUBLIC_KEY_LEN))
+			goto skip_set_private_key;
+
+		/* We remove before setting, to prevent race, which means doing
+		 * two 25519-genpub ops.
+		 */
+		if (curve25519_generate_public(public_key, private_key)) {
+			peer = wg_pubkey_hashtable_lookup(wg->peer_hashtable,
+							  public_key);
+			if (peer) {
+				wg_peer_put(peer);
+				wg_peer_remove(peer);
+			}
+		}
+
+		down_write(&wg->static_identity.lock);
+		wg_noise_set_static_identity_private_key(&wg->static_identity,
+							 private_key);
+		list_for_each_entry_safe(peer, temp, &wg->peer_list,
+					 peer_list) {
+			if (wg_noise_precompute_static_static(peer))
+				wg_noise_expire_current_peer_keypairs(peer);
+			else
+				wg_peer_remove(peer);
+		}
+		wg_cookie_checker_precompute_device_keys(&wg->cookie_checker);
+		up_write(&wg->static_identity.lock);
+	}
+skip_set_private_key:
+
+	if (info->attrs[WGDEVICE_A_PEERS]) {
+		struct nlattr *attr, *peer[WGPEER_A_MAX + 1];
+		int rem;
+
+		nla_for_each_nested(attr, info->attrs[WGDEVICE_A_PEERS], rem) {
+			ret = nla_parse_nested(peer, WGPEER_A_MAX, attr,
+					       peer_policy, NULL);
+			if (ret < 0)
+				goto out;
+			ret = set_peer(wg, peer);
+			if (ret < 0)
+				goto out;
+		}
+	}
+	ret = 0;
+
+out:
+	mutex_unlock(&wg->device_update_lock);
+	rtnl_unlock();
+	dev_put(wg->dev);
+out_nodev:
+	if (info->attrs[WGDEVICE_A_PRIVATE_KEY])
+		memzero_explicit(nla_data(info->attrs[WGDEVICE_A_PRIVATE_KEY]),
+				 nla_len(info->attrs[WGDEVICE_A_PRIVATE_KEY]));
+	return ret;
+}
+
+static const struct genl_ops genl_ops[] = {
+	{
+		.cmd = WG_CMD_GET_DEVICE,
+		.start = wg_get_device_start,
+		.dumpit = wg_get_device_dump,
+		.done = wg_get_device_done,
+		.flags = GENL_UNS_ADMIN_PERM
+	}, {
+		.cmd = WG_CMD_SET_DEVICE,
+		.doit = wg_set_device,
+		.flags = GENL_UNS_ADMIN_PERM
+	}
+};
+
+static struct genl_family genl_family __ro_after_init = {
+	.ops = genl_ops,
+	.n_ops = ARRAY_SIZE(genl_ops),
+	.name = WG_GENL_NAME,
+	.version = WG_GENL_VERSION,
+	.maxattr = WGDEVICE_A_MAX,
+	.module = THIS_MODULE,
+	.policy = device_policy,
+	.netnsok = true
+};
+
+int __init wg_genetlink_init(void)
+{
+	return genl_register_family(&genl_family);
+}
+
+void __exit wg_genetlink_uninit(void)
+{
+	genl_unregister_family(&genl_family);
+}
diff --git a/drivers/net/wireguard/netlink.h b/drivers/net/wireguard/netlink.h
new file mode 100644
index 000000000000..15100d92e2e3
--- /dev/null
+++ b/drivers/net/wireguard/netlink.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_NETLINK_H
+#define _WG_NETLINK_H
+
+int wg_genetlink_init(void);
+void wg_genetlink_uninit(void);
+
+#endif /* _WG_NETLINK_H */
diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
new file mode 100644
index 000000000000..d71c8db68a8c
--- /dev/null
+++ b/drivers/net/wireguard/noise.c
@@ -0,0 +1,828 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "noise.h"
+#include "device.h"
+#include "peer.h"
+#include "messages.h"
+#include "queueing.h"
+#include "peerlookup.h"
+
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/bitmap.h>
+#include <linux/scatterlist.h>
+#include <linux/highmem.h>
+#include <crypto/algapi.h>
+
+/* This implements Noise_IKpsk2:
+ *
+ * <- s
+ * ******
+ * -> e, es, s, ss, {t}
+ * <- e, ee, se, psk, {}
+ */
+
+static const u8 handshake_name[37] = "Noise_IKpsk2_25519_ChaChaPoly_BLAKE2s";
+static const u8 identifier_name[34] = "WireGuard v1 zx2c4 Jason@zx2c4.com";
+static u8 handshake_init_hash[NOISE_HASH_LEN] __ro_after_init;
+static u8 handshake_init_chaining_key[NOISE_HASH_LEN] __ro_after_init;
+static atomic64_t keypair_counter = ATOMIC64_INIT(0);
+
+void __init wg_noise_init(void)
+{
+	struct blake2s_state blake;
+
+	blake2s(handshake_init_chaining_key, handshake_name, NULL,
+		NOISE_HASH_LEN, sizeof(handshake_name), 0);
+	blake2s_init(&blake, NOISE_HASH_LEN);
+	blake2s_update(&blake, handshake_init_chaining_key, NOISE_HASH_LEN);
+	blake2s_update(&blake, identifier_name, sizeof(identifier_name));
+	blake2s_final(&blake, handshake_init_hash);
+}
+
+/* Must hold peer->handshake.static_identity->lock */
+bool wg_noise_precompute_static_static(struct wg_peer *peer)
+{
+	bool ret = true;
+
+	down_write(&peer->handshake.lock);
+	if (peer->handshake.static_identity->has_identity)
+		ret = curve25519(
+			peer->handshake.precomputed_static_static,
+			peer->handshake.static_identity->static_private,
+			peer->handshake.remote_static);
+	else
+		memset(peer->handshake.precomputed_static_static, 0,
+		       NOISE_PUBLIC_KEY_LEN);
+	up_write(&peer->handshake.lock);
+	return ret;
+}
+
+bool wg_noise_handshake_init(struct noise_handshake *handshake,
+			   struct noise_static_identity *static_identity,
+			   const u8 peer_public_key[NOISE_PUBLIC_KEY_LEN],
+			   const u8 peer_preshared_key[NOISE_SYMMETRIC_KEY_LEN],
+			   struct wg_peer *peer)
+{
+	memset(handshake, 0, sizeof(*handshake));
+	init_rwsem(&handshake->lock);
+	handshake->entry.type = INDEX_HASHTABLE_HANDSHAKE;
+	handshake->entry.peer = peer;
+	memcpy(handshake->remote_static, peer_public_key, NOISE_PUBLIC_KEY_LEN);
+	if (peer_preshared_key)
+		memcpy(handshake->preshared_key, peer_preshared_key,
+		       NOISE_SYMMETRIC_KEY_LEN);
+	handshake->static_identity = static_identity;
+	handshake->state = HANDSHAKE_ZEROED;
+	return wg_noise_precompute_static_static(peer);
+}
+
+static void handshake_zero(struct noise_handshake *handshake)
+{
+	memset(&handshake->ephemeral_private, 0, NOISE_PUBLIC_KEY_LEN);
+	memset(&handshake->remote_ephemeral, 0, NOISE_PUBLIC_KEY_LEN);
+	memset(&handshake->hash, 0, NOISE_HASH_LEN);
+	memset(&handshake->chaining_key, 0, NOISE_HASH_LEN);
+	handshake->remote_index = 0;
+	handshake->state = HANDSHAKE_ZEROED;
+}
+
+void wg_noise_handshake_clear(struct noise_handshake *handshake)
+{
+	wg_index_hashtable_remove(
+			handshake->entry.peer->device->index_hashtable,
+			&handshake->entry);
+	down_write(&handshake->lock);
+	handshake_zero(handshake);
+	up_write(&handshake->lock);
+	wg_index_hashtable_remove(
+			handshake->entry.peer->device->index_hashtable,
+			&handshake->entry);
+}
+
+static struct noise_keypair *keypair_create(struct wg_peer *peer)
+{
+	struct noise_keypair *keypair = kzalloc(sizeof(*keypair), GFP_KERNEL);
+
+	if (unlikely(!keypair))
+		return NULL;
+	keypair->internal_id = atomic64_inc_return(&keypair_counter);
+	keypair->entry.type = INDEX_HASHTABLE_KEYPAIR;
+	keypair->entry.peer = peer;
+	kref_init(&keypair->refcount);
+	return keypair;
+}
+
+static void keypair_free_rcu(struct rcu_head *rcu)
+{
+	kzfree(container_of(rcu, struct noise_keypair, rcu));
+}
+
+static void keypair_free_kref(struct kref *kref)
+{
+	struct noise_keypair *keypair =
+		container_of(kref, struct noise_keypair, refcount);
+
+	net_dbg_ratelimited("%s: Keypair %llu destroyed for peer %llu\n",
+			    keypair->entry.peer->device->dev->name,
+			    keypair->internal_id,
+			    keypair->entry.peer->internal_id);
+	wg_index_hashtable_remove(keypair->entry.peer->device->index_hashtable,
+				  &keypair->entry);
+	call_rcu(&keypair->rcu, keypair_free_rcu);
+}
+
+void wg_noise_keypair_put(struct noise_keypair *keypair, bool unreference_now)
+{
+	if (unlikely(!keypair))
+		return;
+	if (unlikely(unreference_now))
+		wg_index_hashtable_remove(
+			keypair->entry.peer->device->index_hashtable,
+			&keypair->entry);
+	kref_put(&keypair->refcount, keypair_free_kref);
+}
+
+struct noise_keypair *wg_noise_keypair_get(struct noise_keypair *keypair)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held(),
+		"Taking noise keypair reference without holding the RCU BH read lock");
+	if (unlikely(!keypair || !kref_get_unless_zero(&keypair->refcount)))
+		return NULL;
+	return keypair;
+}
+
+void wg_noise_keypairs_clear(struct noise_keypairs *keypairs)
+{
+	struct noise_keypair *old;
+
+	spin_lock_bh(&keypairs->keypair_update_lock);
+
+	/* We zero the next_keypair before zeroing the others, so that
+	 * wg_noise_received_with_keypair returns early before subsequent ones
+	 * are zeroed.
+	 */
+	old = rcu_dereference_protected(keypairs->next_keypair,
+		lockdep_is_held(&keypairs->keypair_update_lock));
+	RCU_INIT_POINTER(keypairs->next_keypair, NULL);
+	wg_noise_keypair_put(old, true);
+
+	old = rcu_dereference_protected(keypairs->previous_keypair,
+		lockdep_is_held(&keypairs->keypair_update_lock));
+	RCU_INIT_POINTER(keypairs->previous_keypair, NULL);
+	wg_noise_keypair_put(old, true);
+
+	old = rcu_dereference_protected(keypairs->current_keypair,
+		lockdep_is_held(&keypairs->keypair_update_lock));
+	RCU_INIT_POINTER(keypairs->current_keypair, NULL);
+	wg_noise_keypair_put(old, true);
+
+	spin_unlock_bh(&keypairs->keypair_update_lock);
+}
+
+void wg_noise_expire_current_peer_keypairs(struct wg_peer *peer)
+{
+	struct noise_keypair *keypair;
+
+	wg_noise_handshake_clear(&peer->handshake);
+	wg_noise_reset_last_sent_handshake(&peer->last_sent_handshake);
+
+	spin_lock_bh(&peer->keypairs.keypair_update_lock);
+	keypair = rcu_dereference_protected(peer->keypairs.next_keypair,
+			lockdep_is_held(&peer->keypairs.keypair_update_lock));
+	if (keypair)
+		keypair->sending.is_valid = false;
+	keypair = rcu_dereference_protected(peer->keypairs.current_keypair,
+			lockdep_is_held(&peer->keypairs.keypair_update_lock));
+	if (keypair)
+		keypair->sending.is_valid = false;
+	spin_unlock_bh(&peer->keypairs.keypair_update_lock);
+}
+
+static void add_new_keypair(struct noise_keypairs *keypairs,
+			    struct noise_keypair *new_keypair)
+{
+	struct noise_keypair *previous_keypair, *next_keypair, *current_keypair;
+
+	spin_lock_bh(&keypairs->keypair_update_lock);
+	previous_keypair = rcu_dereference_protected(keypairs->previous_keypair,
+		lockdep_is_held(&keypairs->keypair_update_lock));
+	next_keypair = rcu_dereference_protected(keypairs->next_keypair,
+		lockdep_is_held(&keypairs->keypair_update_lock));
+	current_keypair = rcu_dereference_protected(keypairs->current_keypair,
+		lockdep_is_held(&keypairs->keypair_update_lock));
+	if (new_keypair->i_am_the_initiator) {
+		/* If we're the initiator, it means we've sent a handshake, and
+		 * received a confirmation response, which means this new
+		 * keypair can now be used.
+		 */
+		if (next_keypair) {
+			/* If there already was a next keypair pending, we
+			 * demote it to be the previous keypair, and free the
+			 * existing current. Note that this means KCI can result
+			 * in this transition. It would perhaps be more sound to
+			 * always just get rid of the unused next keypair
+			 * instead of putting it in the previous slot, but this
+			 * might be a bit less robust. Something to think about
+			 * for the future.
+			 */
+			RCU_INIT_POINTER(keypairs->next_keypair, NULL);
+			rcu_assign_pointer(keypairs->previous_keypair,
+					   next_keypair);
+			wg_noise_keypair_put(current_keypair, true);
+		} else /* If there wasn't an existing next keypair, we replace
+			* the previous with the current one.
+			*/
+			rcu_assign_pointer(keypairs->previous_keypair,
+					   current_keypair);
+		/* At this point we can get rid of the old previous keypair, and
+		 * set up the new keypair.
+		 */
+		wg_noise_keypair_put(previous_keypair, true);
+		rcu_assign_pointer(keypairs->current_keypair, new_keypair);
+	} else {
+		/* If we're the responder, it means we can't use the new keypair
+		 * until we receive confirmation via the first data packet, so
+		 * we get rid of the existing previous one, the possibly
+		 * existing next one, and slide in the new next one.
+		 */
+		rcu_assign_pointer(keypairs->next_keypair, new_keypair);
+		wg_noise_keypair_put(next_keypair, true);
+		RCU_INIT_POINTER(keypairs->previous_keypair, NULL);
+		wg_noise_keypair_put(previous_keypair, true);
+	}
+	spin_unlock_bh(&keypairs->keypair_update_lock);
+}
+
+bool wg_noise_received_with_keypair(struct noise_keypairs *keypairs,
+				    struct noise_keypair *received_keypair)
+{
+	struct noise_keypair *old_keypair;
+	bool key_is_new;
+
+	/* We first check without taking the spinlock. */
+	key_is_new = received_keypair ==
+		     rcu_access_pointer(keypairs->next_keypair);
+	if (likely(!key_is_new))
+		return false;
+
+	spin_lock_bh(&keypairs->keypair_update_lock);
+	/* After locking, we double check that things didn't change from
+	 * beneath us.
+	 */
+	if (unlikely(received_keypair !=
+		    rcu_dereference_protected(keypairs->next_keypair,
+			    lockdep_is_held(&keypairs->keypair_update_lock)))) {
+		spin_unlock_bh(&keypairs->keypair_update_lock);
+		return false;
+	}
+
+	/* When we've finally received the confirmation, we slide the next
+	 * into the current, the current into the previous, and get rid of
+	 * the old previous.
+	 */
+	old_keypair = rcu_dereference_protected(keypairs->previous_keypair,
+		lockdep_is_held(&keypairs->keypair_update_lock));
+	rcu_assign_pointer(keypairs->previous_keypair,
+		rcu_dereference_protected(keypairs->current_keypair,
+			lockdep_is_held(&keypairs->keypair_update_lock)));
+	wg_noise_keypair_put(old_keypair, true);
+	rcu_assign_pointer(keypairs->current_keypair, received_keypair);
+	RCU_INIT_POINTER(keypairs->next_keypair, NULL);
+
+	spin_unlock_bh(&keypairs->keypair_update_lock);
+	return true;
+}
+
+/* Must hold static_identity->lock */
+void wg_noise_set_static_identity_private_key(
+	struct noise_static_identity *static_identity,
+	const u8 private_key[NOISE_PUBLIC_KEY_LEN])
+{
+	memcpy(static_identity->static_private, private_key,
+	       NOISE_PUBLIC_KEY_LEN);
+	curve25519_clamp_secret(static_identity->static_private);
+	static_identity->has_identity = curve25519_generate_public(
+		static_identity->static_public, private_key);
+}
+
+/* This is Hugo Krawczyk's HKDF:
+ *  - https://eprint.iacr.org/2010/264.pdf
+ *  - https://tools.ietf.org/html/rfc5869
+ */
+static void kdf(u8 *first_dst, u8 *second_dst, u8 *third_dst, const u8 *data,
+		size_t first_len, size_t second_len, size_t third_len,
+		size_t data_len, const u8 chaining_key[NOISE_HASH_LEN])
+{
+	u8 output[BLAKE2S_HASH_SIZE + 1];
+	u8 secret[BLAKE2S_HASH_SIZE];
+
+	WARN_ON(IS_ENABLED(DEBUG) &&
+		(first_len > BLAKE2S_HASH_SIZE ||
+		 second_len > BLAKE2S_HASH_SIZE ||
+		 third_len > BLAKE2S_HASH_SIZE ||
+		 ((second_len || second_dst || third_len || third_dst) &&
+		  (!first_len || !first_dst)) ||
+		 ((third_len || third_dst) && (!second_len || !second_dst))));
+
+	/* Extract entropy from data into secret */
+	blake2s256_hmac(secret, data, chaining_key, data_len, NOISE_HASH_LEN);
+
+	if (!first_dst || !first_len)
+		goto out;
+
+	/* Expand first key: key = secret, data = 0x1 */
+	output[0] = 1;
+	blake2s256_hmac(output, output, secret, 1, BLAKE2S_HASH_SIZE);
+	memcpy(first_dst, output, first_len);
+
+	if (!second_dst || !second_len)
+		goto out;
+
+	/* Expand second key: key = secret, data = first-key || 0x2 */
+	output[BLAKE2S_HASH_SIZE] = 2;
+	blake2s256_hmac(output, output, secret, BLAKE2S_HASH_SIZE + 1,
+			BLAKE2S_HASH_SIZE);
+	memcpy(second_dst, output, second_len);
+
+	if (!third_dst || !third_len)
+		goto out;
+
+	/* Expand third key: key = secret, data = second-key || 0x3 */
+	output[BLAKE2S_HASH_SIZE] = 3;
+	blake2s256_hmac(output, output, secret, BLAKE2S_HASH_SIZE + 1,
+			BLAKE2S_HASH_SIZE);
+	memcpy(third_dst, output, third_len);
+
+out:
+	/* Clear sensitive data from stack */
+	memzero_explicit(secret, BLAKE2S_HASH_SIZE);
+	memzero_explicit(output, BLAKE2S_HASH_SIZE + 1);
+}
+
+static void symmetric_key_init(struct noise_symmetric_key *key)
+{
+	spin_lock_init(&key->counter.receive.lock);
+	atomic64_set(&key->counter.counter, 0);
+	memset(key->counter.receive.backtrack, 0,
+	       sizeof(key->counter.receive.backtrack));
+	key->birthdate = ktime_get_coarse_boottime_ns();
+	key->is_valid = true;
+}
+
+static void derive_keys(struct noise_symmetric_key *first_dst,
+			struct noise_symmetric_key *second_dst,
+			const u8 chaining_key[NOISE_HASH_LEN])
+{
+	kdf(first_dst->key, second_dst->key, NULL, NULL,
+	    NOISE_SYMMETRIC_KEY_LEN, NOISE_SYMMETRIC_KEY_LEN, 0, 0,
+	    chaining_key);
+	symmetric_key_init(first_dst);
+	symmetric_key_init(second_dst);
+}
+
+static bool __must_check mix_dh(u8 chaining_key[NOISE_HASH_LEN],
+				u8 key[NOISE_SYMMETRIC_KEY_LEN],
+				const u8 private[NOISE_PUBLIC_KEY_LEN],
+				const u8 public[NOISE_PUBLIC_KEY_LEN])
+{
+	u8 dh_calculation[NOISE_PUBLIC_KEY_LEN];
+
+	if (unlikely(!curve25519(dh_calculation, private, public)))
+		return false;
+	kdf(chaining_key, key, NULL, dh_calculation, NOISE_HASH_LEN,
+	    NOISE_SYMMETRIC_KEY_LEN, 0, NOISE_PUBLIC_KEY_LEN, chaining_key);
+	memzero_explicit(dh_calculation, NOISE_PUBLIC_KEY_LEN);
+	return true;
+}
+
+static void mix_hash(u8 hash[NOISE_HASH_LEN], const u8 *src, size_t src_len)
+{
+	struct blake2s_state blake;
+
+	blake2s_init(&blake, NOISE_HASH_LEN);
+	blake2s_update(&blake, hash, NOISE_HASH_LEN);
+	blake2s_update(&blake, src, src_len);
+	blake2s_final(&blake, hash);
+}
+
+static void mix_psk(u8 chaining_key[NOISE_HASH_LEN], u8 hash[NOISE_HASH_LEN],
+		    u8 key[NOISE_SYMMETRIC_KEY_LEN],
+		    const u8 psk[NOISE_SYMMETRIC_KEY_LEN])
+{
+	u8 temp_hash[NOISE_HASH_LEN];
+
+	kdf(chaining_key, temp_hash, key, psk, NOISE_HASH_LEN, NOISE_HASH_LEN,
+	    NOISE_SYMMETRIC_KEY_LEN, NOISE_SYMMETRIC_KEY_LEN, chaining_key);
+	mix_hash(hash, temp_hash, NOISE_HASH_LEN);
+	memzero_explicit(temp_hash, NOISE_HASH_LEN);
+}
+
+static void handshake_init(u8 chaining_key[NOISE_HASH_LEN],
+			   u8 hash[NOISE_HASH_LEN],
+			   const u8 remote_static[NOISE_PUBLIC_KEY_LEN])
+{
+	memcpy(hash, handshake_init_hash, NOISE_HASH_LEN);
+	memcpy(chaining_key, handshake_init_chaining_key, NOISE_HASH_LEN);
+	mix_hash(hash, remote_static, NOISE_PUBLIC_KEY_LEN);
+}
+
+static void message_encrypt(u8 *dst_ciphertext, const u8 *src_plaintext,
+			    size_t src_len, u8 key[NOISE_SYMMETRIC_KEY_LEN],
+			    u8 hash[NOISE_HASH_LEN])
+{
+	chacha20poly1305_encrypt(dst_ciphertext, src_plaintext, src_len, hash,
+				 NOISE_HASH_LEN,
+				 0 /* Always zero for Noise_IK */, key);
+	mix_hash(hash, dst_ciphertext, noise_encrypted_len(src_len));
+}
+
+static bool message_decrypt(u8 *dst_plaintext, const u8 *src_ciphertext,
+			    size_t src_len, u8 key[NOISE_SYMMETRIC_KEY_LEN],
+			    u8 hash[NOISE_HASH_LEN])
+{
+	if (!chacha20poly1305_decrypt(dst_plaintext, src_ciphertext, src_len,
+				      hash, NOISE_HASH_LEN,
+				      0 /* Always zero for Noise_IK */, key))
+		return false;
+	mix_hash(hash, src_ciphertext, src_len);
+	return true;
+}
+
+static void message_ephemeral(u8 ephemeral_dst[NOISE_PUBLIC_KEY_LEN],
+			      const u8 ephemeral_src[NOISE_PUBLIC_KEY_LEN],
+			      u8 chaining_key[NOISE_HASH_LEN],
+			      u8 hash[NOISE_HASH_LEN])
+{
+	if (ephemeral_dst != ephemeral_src)
+		memcpy(ephemeral_dst, ephemeral_src, NOISE_PUBLIC_KEY_LEN);
+	mix_hash(hash, ephemeral_src, NOISE_PUBLIC_KEY_LEN);
+	kdf(chaining_key, NULL, NULL, ephemeral_src, NOISE_HASH_LEN, 0, 0,
+	    NOISE_PUBLIC_KEY_LEN, chaining_key);
+}
+
+static void tai64n_now(u8 output[NOISE_TIMESTAMP_LEN])
+{
+	struct timespec64 now;
+
+	ktime_get_real_ts64(&now);
+
+	/* In order to prevent some sort of infoleak from precise timers, we
+	 * round down the nanoseconds part to the closest rounded-down power of
+	 * two to the maximum initiations per second allowed anyway by the
+	 * implementation.
+	 */
+	now.tv_nsec = ALIGN_DOWN(now.tv_nsec,
+		rounddown_pow_of_two(NSEC_PER_SEC / INITIATIONS_PER_SECOND));
+
+	/* https://cr.yp.to/libtai/tai64.html */
+	*(__be64 *)output = cpu_to_be64(0x400000000000000aULL + now.tv_sec);
+	*(__be32 *)(output + sizeof(__be64)) = cpu_to_be32(now.tv_nsec);
+}
+
+bool
+wg_noise_handshake_create_initiation(struct message_handshake_initiation *dst,
+				     struct noise_handshake *handshake)
+{
+	u8 timestamp[NOISE_TIMESTAMP_LEN];
+	u8 key[NOISE_SYMMETRIC_KEY_LEN];
+	bool ret = false;
+
+	/* We need to wait for crng _before_ taking any locks, since
+	 * curve25519_generate_secret uses get_random_bytes_wait.
+	 */
+	wait_for_random_bytes();
+
+	down_read(&handshake->static_identity->lock);
+	down_write(&handshake->lock);
+
+	if (unlikely(!handshake->static_identity->has_identity))
+		goto out;
+
+	dst->header.type = cpu_to_le32(MESSAGE_HANDSHAKE_INITIATION);
+
+	handshake_init(handshake->chaining_key, handshake->hash,
+		       handshake->remote_static);
+
+	/* e */
+	curve25519_generate_secret(handshake->ephemeral_private);
+	if (!curve25519_generate_public(dst->unencrypted_ephemeral,
+					handshake->ephemeral_private))
+		goto out;
+	message_ephemeral(dst->unencrypted_ephemeral,
+			  dst->unencrypted_ephemeral, handshake->chaining_key,
+			  handshake->hash);
+
+	/* es */
+	if (!mix_dh(handshake->chaining_key, key, handshake->ephemeral_private,
+		    handshake->remote_static))
+		goto out;
+
+	/* s */
+	message_encrypt(dst->encrypted_static,
+			handshake->static_identity->static_public,
+			NOISE_PUBLIC_KEY_LEN, key, handshake->hash);
+
+	/* ss */
+	kdf(handshake->chaining_key, key, NULL,
+	    handshake->precomputed_static_static, NOISE_HASH_LEN,
+	    NOISE_SYMMETRIC_KEY_LEN, 0, NOISE_PUBLIC_KEY_LEN,
+	    handshake->chaining_key);
+
+	/* {t} */
+	tai64n_now(timestamp);
+	message_encrypt(dst->encrypted_timestamp, timestamp,
+			NOISE_TIMESTAMP_LEN, key, handshake->hash);
+
+	dst->sender_index = wg_index_hashtable_insert(
+		handshake->entry.peer->device->index_hashtable,
+		&handshake->entry);
+
+	handshake->state = HANDSHAKE_CREATED_INITIATION;
+	ret = true;
+
+out:
+	up_write(&handshake->lock);
+	up_read(&handshake->static_identity->lock);
+	memzero_explicit(key, NOISE_SYMMETRIC_KEY_LEN);
+	return ret;
+}
+
+struct wg_peer *
+wg_noise_handshake_consume_initiation(struct message_handshake_initiation *src,
+				      struct wg_device *wg)
+{
+	struct wg_peer *peer = NULL, *ret_peer = NULL;
+	struct noise_handshake *handshake;
+	bool replay_attack, flood_attack;
+	u8 key[NOISE_SYMMETRIC_KEY_LEN];
+	u8 chaining_key[NOISE_HASH_LEN];
+	u8 hash[NOISE_HASH_LEN];
+	u8 s[NOISE_PUBLIC_KEY_LEN];
+	u8 e[NOISE_PUBLIC_KEY_LEN];
+	u8 t[NOISE_TIMESTAMP_LEN];
+	u64 initiation_consumption;
+
+	down_read(&wg->static_identity.lock);
+	if (unlikely(!wg->static_identity.has_identity))
+		goto out;
+
+	handshake_init(chaining_key, hash, wg->static_identity.static_public);
+
+	/* e */
+	message_ephemeral(e, src->unencrypted_ephemeral, chaining_key, hash);
+
+	/* es */
+	if (!mix_dh(chaining_key, key, wg->static_identity.static_private, e))
+		goto out;
+
+	/* s */
+	if (!message_decrypt(s, src->encrypted_static,
+			     sizeof(src->encrypted_static), key, hash))
+		goto out;
+
+	/* Lookup which peer we're actually talking to */
+	peer = wg_pubkey_hashtable_lookup(wg->peer_hashtable, s);
+	if (!peer)
+		goto out;
+	handshake = &peer->handshake;
+
+	/* ss */
+	kdf(chaining_key, key, NULL, handshake->precomputed_static_static,
+	    NOISE_HASH_LEN, NOISE_SYMMETRIC_KEY_LEN, 0, NOISE_PUBLIC_KEY_LEN,
+	    chaining_key);
+
+	/* {t} */
+	if (!message_decrypt(t, src->encrypted_timestamp,
+			     sizeof(src->encrypted_timestamp), key, hash))
+		goto out;
+
+	down_read(&handshake->lock);
+	replay_attack = memcmp(t, handshake->latest_timestamp,
+			       NOISE_TIMESTAMP_LEN) <= 0;
+	flood_attack = (s64)handshake->last_initiation_consumption +
+			       NSEC_PER_SEC / INITIATIONS_PER_SECOND >
+		       (s64)ktime_get_coarse_boottime_ns();
+	up_read(&handshake->lock);
+	if (replay_attack || flood_attack)
+		goto out;
+
+	/* Success! Copy everything to peer */
+	down_write(&handshake->lock);
+	memcpy(handshake->remote_ephemeral, e, NOISE_PUBLIC_KEY_LEN);
+	if (memcmp(t, handshake->latest_timestamp, NOISE_TIMESTAMP_LEN) > 0)
+		memcpy(handshake->latest_timestamp, t, NOISE_TIMESTAMP_LEN);
+	memcpy(handshake->hash, hash, NOISE_HASH_LEN);
+	memcpy(handshake->chaining_key, chaining_key, NOISE_HASH_LEN);
+	handshake->remote_index = src->sender_index;
+	if ((s64)(handshake->last_initiation_consumption -
+	    (initiation_consumption = ktime_get_coarse_boottime_ns())) < 0)
+		handshake->last_initiation_consumption = initiation_consumption;
+	handshake->state = HANDSHAKE_CONSUMED_INITIATION;
+	up_write(&handshake->lock);
+	ret_peer = peer;
+
+out:
+	memzero_explicit(key, NOISE_SYMMETRIC_KEY_LEN);
+	memzero_explicit(hash, NOISE_HASH_LEN);
+	memzero_explicit(chaining_key, NOISE_HASH_LEN);
+	up_read(&wg->static_identity.lock);
+	if (!ret_peer)
+		wg_peer_put(peer);
+	return ret_peer;
+}
+
+bool wg_noise_handshake_create_response(struct message_handshake_response *dst,
+					struct noise_handshake *handshake)
+{
+	u8 key[NOISE_SYMMETRIC_KEY_LEN];
+	bool ret = false;
+
+	/* We need to wait for crng _before_ taking any locks, since
+	 * curve25519_generate_secret uses get_random_bytes_wait.
+	 */
+	wait_for_random_bytes();
+
+	down_read(&handshake->static_identity->lock);
+	down_write(&handshake->lock);
+
+	if (handshake->state != HANDSHAKE_CONSUMED_INITIATION)
+		goto out;
+
+	dst->header.type = cpu_to_le32(MESSAGE_HANDSHAKE_RESPONSE);
+	dst->receiver_index = handshake->remote_index;
+
+	/* e */
+	curve25519_generate_secret(handshake->ephemeral_private);
+	if (!curve25519_generate_public(dst->unencrypted_ephemeral,
+					handshake->ephemeral_private))
+		goto out;
+	message_ephemeral(dst->unencrypted_ephemeral,
+			  dst->unencrypted_ephemeral, handshake->chaining_key,
+			  handshake->hash);
+
+	/* ee */
+	if (!mix_dh(handshake->chaining_key, NULL, handshake->ephemeral_private,
+		    handshake->remote_ephemeral))
+		goto out;
+
+	/* se */
+	if (!mix_dh(handshake->chaining_key, NULL, handshake->ephemeral_private,
+		    handshake->remote_static))
+		goto out;
+
+	/* psk */
+	mix_psk(handshake->chaining_key, handshake->hash, key,
+		handshake->preshared_key);
+
+	/* {} */
+	message_encrypt(dst->encrypted_nothing, NULL, 0, key, handshake->hash);
+
+	dst->sender_index = wg_index_hashtable_insert(
+		handshake->entry.peer->device->index_hashtable,
+		&handshake->entry);
+
+	handshake->state = HANDSHAKE_CREATED_RESPONSE;
+	ret = true;
+
+out:
+	up_write(&handshake->lock);
+	up_read(&handshake->static_identity->lock);
+	memzero_explicit(key, NOISE_SYMMETRIC_KEY_LEN);
+	return ret;
+}
+
+struct wg_peer *
+wg_noise_handshake_consume_response(struct message_handshake_response *src,
+				    struct wg_device *wg)
+{
+	enum noise_handshake_state state = HANDSHAKE_ZEROED;
+	struct wg_peer *peer = NULL, *ret_peer = NULL;
+	struct noise_handshake *handshake;
+	u8 key[NOISE_SYMMETRIC_KEY_LEN];
+	u8 hash[NOISE_HASH_LEN];
+	u8 chaining_key[NOISE_HASH_LEN];
+	u8 e[NOISE_PUBLIC_KEY_LEN];
+	u8 ephemeral_private[NOISE_PUBLIC_KEY_LEN];
+	u8 static_private[NOISE_PUBLIC_KEY_LEN];
+
+	down_read(&wg->static_identity.lock);
+
+	if (unlikely(!wg->static_identity.has_identity))
+		goto out;
+
+	handshake = (struct noise_handshake *)wg_index_hashtable_lookup(
+		wg->index_hashtable, INDEX_HASHTABLE_HANDSHAKE,
+		src->receiver_index, &peer);
+	if (unlikely(!handshake))
+		goto out;
+
+	down_read(&handshake->lock);
+	state = handshake->state;
+	memcpy(hash, handshake->hash, NOISE_HASH_LEN);
+	memcpy(chaining_key, handshake->chaining_key, NOISE_HASH_LEN);
+	memcpy(ephemeral_private, handshake->ephemeral_private,
+	       NOISE_PUBLIC_KEY_LEN);
+	up_read(&handshake->lock);
+
+	if (state != HANDSHAKE_CREATED_INITIATION)
+		goto fail;
+
+	/* e */
+	message_ephemeral(e, src->unencrypted_ephemeral, chaining_key, hash);
+
+	/* ee */
+	if (!mix_dh(chaining_key, NULL, ephemeral_private, e))
+		goto fail;
+
+	/* se */
+	if (!mix_dh(chaining_key, NULL, wg->static_identity.static_private, e))
+		goto fail;
+
+	/* psk */
+	mix_psk(chaining_key, hash, key, handshake->preshared_key);
+
+	/* {} */
+	if (!message_decrypt(NULL, src->encrypted_nothing,
+			     sizeof(src->encrypted_nothing), key, hash))
+		goto fail;
+
+	/* Success! Copy everything to peer */
+	down_write(&handshake->lock);
+	/* It's important to check that the state is still the same, while we
+	 * have an exclusive lock.
+	 */
+	if (handshake->state != state) {
+		up_write(&handshake->lock);
+		goto fail;
+	}
+	memcpy(handshake->remote_ephemeral, e, NOISE_PUBLIC_KEY_LEN);
+	memcpy(handshake->hash, hash, NOISE_HASH_LEN);
+	memcpy(handshake->chaining_key, chaining_key, NOISE_HASH_LEN);
+	handshake->remote_index = src->sender_index;
+	handshake->state = HANDSHAKE_CONSUMED_RESPONSE;
+	up_write(&handshake->lock);
+	ret_peer = peer;
+	goto out;
+
+fail:
+	wg_peer_put(peer);
+out:
+	memzero_explicit(key, NOISE_SYMMETRIC_KEY_LEN);
+	memzero_explicit(hash, NOISE_HASH_LEN);
+	memzero_explicit(chaining_key, NOISE_HASH_LEN);
+	memzero_explicit(ephemeral_private, NOISE_PUBLIC_KEY_LEN);
+	memzero_explicit(static_private, NOISE_PUBLIC_KEY_LEN);
+	up_read(&wg->static_identity.lock);
+	return ret_peer;
+}
+
+bool wg_noise_handshake_begin_session(struct noise_handshake *handshake,
+				      struct noise_keypairs *keypairs)
+{
+	struct noise_keypair *new_keypair;
+	bool ret = false;
+
+	down_write(&handshake->lock);
+	if (handshake->state != HANDSHAKE_CREATED_RESPONSE &&
+	    handshake->state != HANDSHAKE_CONSUMED_RESPONSE)
+		goto out;
+
+	new_keypair = keypair_create(handshake->entry.peer);
+	if (!new_keypair)
+		goto out;
+	new_keypair->i_am_the_initiator = handshake->state ==
+					  HANDSHAKE_CONSUMED_RESPONSE;
+	new_keypair->remote_index = handshake->remote_index;
+
+	if (new_keypair->i_am_the_initiator)
+		derive_keys(&new_keypair->sending, &new_keypair->receiving,
+			    handshake->chaining_key);
+	else
+		derive_keys(&new_keypair->receiving, &new_keypair->sending,
+			    handshake->chaining_key);
+
+	handshake_zero(handshake);
+	rcu_read_lock_bh();
+	if (likely(!READ_ONCE(container_of(handshake, struct wg_peer,
+					   handshake)->is_dead))) {
+		add_new_keypair(keypairs, new_keypair);
+		net_dbg_ratelimited("%s: Keypair %llu created for peer %llu\n",
+				    handshake->entry.peer->device->dev->name,
+				    new_keypair->internal_id,
+				    handshake->entry.peer->internal_id);
+		ret = wg_index_hashtable_replace(
+			handshake->entry.peer->device->index_hashtable,
+			&handshake->entry, &new_keypair->entry);
+	} else {
+		kzfree(new_keypair);
+	}
+	rcu_read_unlock_bh();
+
+out:
+	up_write(&handshake->lock);
+	return ret;
+}
diff --git a/drivers/net/wireguard/noise.h b/drivers/net/wireguard/noise.h
new file mode 100644
index 000000000000..138a07bb817c
--- /dev/null
+++ b/drivers/net/wireguard/noise.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#ifndef _WG_NOISE_H
+#define _WG_NOISE_H
+
+#include "messages.h"
+#include "peerlookup.h"
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/atomic.h>
+#include <linux/rwsem.h>
+#include <linux/mutex.h>
+#include <linux/kref.h>
+
+union noise_counter {
+	struct {
+		u64 counter;
+		unsigned long backtrack[COUNTER_BITS_TOTAL / BITS_PER_LONG];
+		spinlock_t lock;
+	} receive;
+	atomic64_t counter;
+};
+
+struct noise_symmetric_key {
+	u8 key[NOISE_SYMMETRIC_KEY_LEN];
+	union noise_counter counter;
+	u64 birthdate;
+	bool is_valid;
+};
+
+struct noise_keypair {
+	struct index_hashtable_entry entry;
+	struct noise_symmetric_key sending;
+	struct noise_symmetric_key receiving;
+	__le32 remote_index;
+	bool i_am_the_initiator;
+	struct kref refcount;
+	struct rcu_head rcu;
+	u64 internal_id;
+};
+
+struct noise_keypairs {
+	struct noise_keypair __rcu *current_keypair;
+	struct noise_keypair __rcu *previous_keypair;
+	struct noise_keypair __rcu *next_keypair;
+	spinlock_t keypair_update_lock;
+};
+
+struct noise_static_identity {
+	u8 static_public[NOISE_PUBLIC_KEY_LEN];
+	u8 static_private[NOISE_PUBLIC_KEY_LEN];
+	struct rw_semaphore lock;
+	bool has_identity;
+};
+
+enum noise_handshake_state {
+	HANDSHAKE_ZEROED,
+	HANDSHAKE_CREATED_INITIATION,
+	HANDSHAKE_CONSUMED_INITIATION,
+	HANDSHAKE_CREATED_RESPONSE,
+	HANDSHAKE_CONSUMED_RESPONSE
+};
+
+struct noise_handshake {
+	struct index_hashtable_entry entry;
+
+	enum noise_handshake_state state;
+	u64 last_initiation_consumption;
+
+	struct noise_static_identity *static_identity;
+
+	u8 ephemeral_private[NOISE_PUBLIC_KEY_LEN];
+	u8 remote_static[NOISE_PUBLIC_KEY_LEN];
+	u8 remote_ephemeral[NOISE_PUBLIC_KEY_LEN];
+	u8 precomputed_static_static[NOISE_PUBLIC_KEY_LEN];
+
+	u8 preshared_key[NOISE_SYMMETRIC_KEY_LEN];
+
+	u8 hash[NOISE_HASH_LEN];
+	u8 chaining_key[NOISE_HASH_LEN];
+
+	u8 latest_timestamp[NOISE_TIMESTAMP_LEN];
+	__le32 remote_index;
+
+	/* Protects all members except the immutable (after noise_handshake_
+	 * init): remote_static, precomputed_static_static, static_identity.
+	 */
+	struct rw_semaphore lock;
+};
+
+struct wg_device;
+
+void wg_noise_init(void);
+bool wg_noise_handshake_init(struct noise_handshake *handshake,
+			   struct noise_static_identity *static_identity,
+			   const u8 peer_public_key[NOISE_PUBLIC_KEY_LEN],
+			   const u8 peer_preshared_key[NOISE_SYMMETRIC_KEY_LEN],
+			   struct wg_peer *peer);
+void wg_noise_handshake_clear(struct noise_handshake *handshake);
+static inline void wg_noise_reset_last_sent_handshake(atomic64_t *handshake_ns)
+{
+	atomic64_set(handshake_ns, ktime_get_coarse_boottime_ns() -
+				       (u64)(REKEY_TIMEOUT + 1) * NSEC_PER_SEC);
+}
+
+void wg_noise_keypair_put(struct noise_keypair *keypair, bool unreference_now);
+struct noise_keypair *wg_noise_keypair_get(struct noise_keypair *keypair);
+void wg_noise_keypairs_clear(struct noise_keypairs *keypairs);
+bool wg_noise_received_with_keypair(struct noise_keypairs *keypairs,
+				    struct noise_keypair *received_keypair);
+void wg_noise_expire_current_peer_keypairs(struct wg_peer *peer);
+
+void wg_noise_set_static_identity_private_key(
+	struct noise_static_identity *static_identity,
+	const u8 private_key[NOISE_PUBLIC_KEY_LEN]);
+bool wg_noise_precompute_static_static(struct wg_peer *peer);
+
+bool
+wg_noise_handshake_create_initiation(struct message_handshake_initiation *dst,
+				     struct noise_handshake *handshake);
+struct wg_peer *
+wg_noise_handshake_consume_initiation(struct message_handshake_initiation *src,
+				      struct wg_device *wg);
+
+bool wg_noise_handshake_create_response(struct message_handshake_response *dst,
+					struct noise_handshake *handshake);
+struct wg_peer *
+wg_noise_handshake_consume_response(struct message_handshake_response *src,
+				    struct wg_device *wg);
+
+bool wg_noise_handshake_begin_session(struct noise_handshake *handshake,
+				      struct noise_keypairs *keypairs);
+
+#endif /* _WG_NOISE_H */
diff --git a/drivers/net/wireguard/peer.c b/drivers/net/wireguard/peer.c
new file mode 100644
index 000000000000..071eedf33f5a
--- /dev/null
+++ b/drivers/net/wireguard/peer.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "peer.h"
+#include "device.h"
+#include "queueing.h"
+#include "timers.h"
+#include "peerlookup.h"
+#include "noise.h"
+
+#include <linux/kref.h>
+#include <linux/lockdep.h>
+#include <linux/rcupdate.h>
+#include <linux/list.h>
+
+static atomic64_t peer_counter = ATOMIC64_INIT(0);
+
+struct wg_peer *wg_peer_create(struct wg_device *wg,
+			       const u8 public_key[NOISE_PUBLIC_KEY_LEN],
+			       const u8 preshared_key[NOISE_SYMMETRIC_KEY_LEN])
+{
+	struct wg_peer *peer;
+	int ret = -ENOMEM;
+
+	lockdep_assert_held(&wg->device_update_lock);
+
+	if (wg->num_peers >= MAX_PEERS_PER_DEVICE)
+		return ERR_PTR(ret);
+
+	peer = kzalloc(sizeof(*peer), GFP_KERNEL);
+	if (unlikely(!peer))
+		return ERR_PTR(ret);
+	peer->device = wg;
+
+	if (!wg_noise_handshake_init(&peer->handshake, &wg->static_identity,
+				     public_key, preshared_key, peer)) {
+		ret = -EKEYREJECTED;
+		goto err_1;
+	}
+	if (dst_cache_init(&peer->endpoint_cache, GFP_KERNEL))
+		goto err_1;
+	if (wg_packet_queue_init(&peer->tx_queue, wg_packet_tx_worker, false,
+				 MAX_QUEUED_PACKETS))
+		goto err_2;
+	if (wg_packet_queue_init(&peer->rx_queue, NULL, false,
+				 MAX_QUEUED_PACKETS))
+		goto err_3;
+
+	peer->internal_id = atomic64_inc_return(&peer_counter);
+	peer->serial_work_cpu = nr_cpumask_bits;
+	wg_cookie_init(&peer->latest_cookie);
+	wg_timers_init(peer);
+	wg_cookie_checker_precompute_peer_keys(peer);
+	spin_lock_init(&peer->keypairs.keypair_update_lock);
+	INIT_WORK(&peer->transmit_handshake_work,
+		  wg_packet_handshake_send_worker);
+	rwlock_init(&peer->endpoint_lock);
+	kref_init(&peer->refcount);
+	skb_queue_head_init(&peer->staged_packet_queue);
+	wg_noise_reset_last_sent_handshake(&peer->last_sent_handshake);
+	set_bit(NAPI_STATE_NO_BUSY_POLL, &peer->napi.state);
+	netif_napi_add(wg->dev, &peer->napi, wg_packet_rx_poll,
+		       NAPI_POLL_WEIGHT);
+	napi_enable(&peer->napi);
+	list_add_tail(&peer->peer_list, &wg->peer_list);
+	INIT_LIST_HEAD(&peer->allowedips_list);
+	wg_pubkey_hashtable_add(wg->peer_hashtable, peer);
+	++wg->num_peers;
+	pr_debug("%s: Peer %llu created\n", wg->dev->name, peer->internal_id);
+	return peer;
+
+err_3:
+	wg_packet_queue_free(&peer->tx_queue, false);
+err_2:
+	dst_cache_destroy(&peer->endpoint_cache);
+err_1:
+	kfree(peer);
+	return ERR_PTR(ret);
+}
+
+struct wg_peer *wg_peer_get_maybe_zero(struct wg_peer *peer)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held(),
+			 "Taking peer reference without holding the RCU read lock");
+	if (unlikely(!peer || !kref_get_unless_zero(&peer->refcount)))
+		return NULL;
+	return peer;
+}
+
+static void peer_make_dead(struct wg_peer *peer)
+{
+	/* Remove from configuration-time lookup structures. */
+	list_del_init(&peer->peer_list);
+	wg_allowedips_remove_by_peer(&peer->device->peer_allowedips, peer,
+				     &peer->device->device_update_lock);
+	wg_pubkey_hashtable_remove(peer->device->peer_hashtable, peer);
+
+	/* Mark as dead, so that we don't allow jumping contexts after. */
+	WRITE_ONCE(peer->is_dead, true);
+
+	/* The caller must now synchronize_rcu() for this to take effect. */
+}
+
+static void peer_remove_after_dead(struct wg_peer *peer)
+{
+	WARN_ON(!peer->is_dead);
+
+	/* No more keypairs can be created for this peer, since is_dead protects
+	 * add_new_keypair, so we can now destroy existing ones.
+	 */
+	wg_noise_keypairs_clear(&peer->keypairs);
+
+	/* Destroy all ongoing timers that were in-flight at the beginning of
+	 * this function.
+	 */
+	wg_timers_stop(peer);
+
+	/* The transition between packet encryption/decryption queues isn't
+	 * guarded by is_dead, but each reference's life is strictly bounded by
+	 * two generations: once for parallel crypto and once for serial
+	 * ingestion, so we can simply flush twice, and be sure that we no
+	 * longer have references inside these queues.
+	 */
+
+	/* a) For encrypt/decrypt. */
+	flush_workqueue(peer->device->packet_crypt_wq);
+	/* b.1) For send (but not receive, since that's napi). */
+	flush_workqueue(peer->device->packet_crypt_wq);
+	/* b.2.1) For receive (but not send, since that's wq). */
+	napi_disable(&peer->napi);
+	/* b.2.1) It's now safe to remove the napi struct, which must be done
+	 * here from process context.
+	 */
+	netif_napi_del(&peer->napi);
+
+	/* Ensure any workstructs we own (like transmit_handshake_work or
+	 * clear_peer_work) no longer are in use.
+	 */
+	flush_workqueue(peer->device->handshake_send_wq);
+
+	/* After the above flushes, a peer might still be active in a few
+	 * different contexts: 1) from xmit(), before hitting is_dead and
+	 * returning, 2) from wg_packet_consume_data(), before hitting is_dead
+	 * and returning, 3) from wg_receive_handshake_packet() after a point
+	 * where it has processed an incoming handshake packet, but where
+	 * all calls to pass it off to timers fails because of is_dead. We won't
+	 * have new references in (1) eventually, because we're removed from
+	 * allowedips; we won't have new references in (2) eventually, because
+	 * wg_index_hashtable_lookup will always return NULL, since we removed
+	 * all existing keypairs and no more can be created; we won't have new
+	 * references in (3) eventually, because we're removed from the pubkey
+	 * hash table, which allows for a maximum of one handshake response,
+	 * via the still-uncleared index hashtable entry, but not more than one,
+	 * and in wg_cookie_message_consume, the lookup eventually gets a peer
+	 * with a refcount of zero, so no new reference is taken.
+	 */
+
+	--peer->device->num_peers;
+	wg_peer_put(peer);
+}
+
+/* We have a separate "remove" function make sure that all active places where
+ * a peer is currently operating will eventually come to an end and not pass
+ * their reference onto another context.
+ */
+void wg_peer_remove(struct wg_peer *peer)
+{
+	if (unlikely(!peer))
+		return;
+	lockdep_assert_held(&peer->device->device_update_lock);
+
+	peer_make_dead(peer);
+	synchronize_rcu();
+	peer_remove_after_dead(peer);
+}
+
+void wg_peer_remove_all(struct wg_device *wg)
+{
+	struct wg_peer *peer, *temp;
+	LIST_HEAD(dead_peers);
+
+	lockdep_assert_held(&wg->device_update_lock);
+
+	/* Avoid having to traverse individually for each one. */
+	wg_allowedips_free(&wg->peer_allowedips, &wg->device_update_lock);
+
+	list_for_each_entry_safe(peer, temp, &wg->peer_list, peer_list) {
+		peer_make_dead(peer);
+		list_add_tail(&peer->peer_list, &dead_peers);
+	}
+	synchronize_rcu();
+	list_for_each_entry_safe(peer, temp, &dead_peers, peer_list)
+		peer_remove_after_dead(peer);
+}
+
+static void rcu_release(struct rcu_head *rcu)
+{
+	struct wg_peer *peer = container_of(rcu, struct wg_peer, rcu);
+
+	dst_cache_destroy(&peer->endpoint_cache);
+	wg_packet_queue_free(&peer->rx_queue, false);
+	wg_packet_queue_free(&peer->tx_queue, false);
+
+	/* The final zeroing takes care of clearing any remaining handshake key
+	 * material and other potentially sensitive information.
+	 */
+	kzfree(peer);
+}
+
+static void kref_release(struct kref *refcount)
+{
+	struct wg_peer *peer = container_of(refcount, struct wg_peer, refcount);
+
+	pr_debug("%s: Peer %llu (%pISpfsc) destroyed\n",
+		 peer->device->dev->name, peer->internal_id,
+		 &peer->endpoint.addr);
+
+	/* Remove ourself from dynamic runtime lookup structures, now that the
+	 * last reference is gone.
+	 */
+	wg_index_hashtable_remove(peer->device->index_hashtable,
+				  &peer->handshake.entry);
+
+	/* Remove any lingering packets that didn't have a chance to be
+	 * transmitted.
+	 */
+	wg_packet_purge_staged_packets(peer);
+
+	/* Free the memory used. */
+	call_rcu(&peer->rcu, rcu_release);
+}
+
+void wg_peer_put(struct wg_peer *peer)
+{
+	if (unlikely(!peer))
+		return;
+	kref_put(&peer->refcount, kref_release);
+}
diff --git a/drivers/net/wireguard/peer.h b/drivers/net/wireguard/peer.h
new file mode 100644
index 000000000000..23af40922997
--- /dev/null
+++ b/drivers/net/wireguard/peer.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_PEER_H
+#define _WG_PEER_H
+
+#include "device.h"
+#include "noise.h"
+#include "cookie.h"
+
+#include <linux/types.h>
+#include <linux/netfilter.h>
+#include <linux/spinlock.h>
+#include <linux/kref.h>
+#include <net/dst_cache.h>
+
+struct wg_device;
+
+struct endpoint {
+	union {
+		struct sockaddr addr;
+		struct sockaddr_in addr4;
+		struct sockaddr_in6 addr6;
+	};
+	union {
+		struct {
+			struct in_addr src4;
+			/* Essentially the same as addr6->scope_id */
+			int src_if4;
+		};
+		struct in6_addr src6;
+	};
+};
+
+struct wg_peer {
+	struct wg_device *device;
+	struct crypt_queue tx_queue, rx_queue;
+	struct sk_buff_head staged_packet_queue;
+	int serial_work_cpu;
+	struct noise_keypairs keypairs;
+	struct endpoint endpoint;
+	struct dst_cache endpoint_cache;
+	rwlock_t endpoint_lock;
+	struct noise_handshake handshake;
+	atomic64_t last_sent_handshake;
+	struct work_struct transmit_handshake_work, clear_peer_work;
+	struct cookie latest_cookie;
+	struct hlist_node pubkey_hash;
+	u64 rx_bytes, tx_bytes;
+	struct timer_list timer_retransmit_handshake, timer_send_keepalive;
+	struct timer_list timer_new_handshake, timer_zero_key_material;
+	struct timer_list timer_persistent_keepalive;
+	unsigned int timer_handshake_attempts;
+	u16 persistent_keepalive_interval;
+	bool timer_need_another_keepalive;
+	bool sent_lastminute_handshake;
+	struct timespec64 walltime_last_handshake;
+	struct kref refcount;
+	struct rcu_head rcu;
+	struct list_head peer_list;
+	struct list_head allowedips_list;
+	u64 internal_id;
+	struct napi_struct napi;
+	bool is_dead;
+};
+
+struct wg_peer *wg_peer_create(struct wg_device *wg,
+			       const u8 public_key[NOISE_PUBLIC_KEY_LEN],
+			       const u8 preshared_key[NOISE_SYMMETRIC_KEY_LEN]);
+
+struct wg_peer *__must_check wg_peer_get_maybe_zero(struct wg_peer *peer);
+static inline struct wg_peer *wg_peer_get(struct wg_peer *peer)
+{
+	kref_get(&peer->refcount);
+	return peer;
+}
+void wg_peer_put(struct wg_peer *peer);
+void wg_peer_remove(struct wg_peer *peer);
+void wg_peer_remove_all(struct wg_device *wg);
+
+#endif /* _WG_PEER_H */
diff --git a/drivers/net/wireguard/peerlookup.c b/drivers/net/wireguard/peerlookup.c
new file mode 100644
index 000000000000..e4deb331476b
--- /dev/null
+++ b/drivers/net/wireguard/peerlookup.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "peerlookup.h"
+#include "peer.h"
+#include "noise.h"
+
+static struct hlist_head *pubkey_bucket(struct pubkey_hashtable *table,
+					const u8 pubkey[NOISE_PUBLIC_KEY_LEN])
+{
+	/* siphash gives us a secure 64bit number based on a random key. Since
+	 * the bits are uniformly distributed, we can then mask off to get the
+	 * bits we need.
+	 */
+	const u64 hash = siphash(pubkey, NOISE_PUBLIC_KEY_LEN, &table->key);
+
+	return &table->hashtable[hash & (HASH_SIZE(table->hashtable) - 1)];
+}
+
+struct pubkey_hashtable *wg_pubkey_hashtable_alloc(void)
+{
+	struct pubkey_hashtable *table = kvmalloc(sizeof(*table), GFP_KERNEL);
+
+	if (!table)
+		return NULL;
+
+	get_random_bytes(&table->key, sizeof(table->key));
+	hash_init(table->hashtable);
+	mutex_init(&table->lock);
+	return table;
+}
+
+void wg_pubkey_hashtable_add(struct pubkey_hashtable *table,
+			     struct wg_peer *peer)
+{
+	mutex_lock(&table->lock);
+	hlist_add_head_rcu(&peer->pubkey_hash,
+			   pubkey_bucket(table, peer->handshake.remote_static));
+	mutex_unlock(&table->lock);
+}
+
+void wg_pubkey_hashtable_remove(struct pubkey_hashtable *table,
+				struct wg_peer *peer)
+{
+	mutex_lock(&table->lock);
+	hlist_del_init_rcu(&peer->pubkey_hash);
+	mutex_unlock(&table->lock);
+}
+
+/* Returns a strong reference to a peer */
+struct wg_peer *
+wg_pubkey_hashtable_lookup(struct pubkey_hashtable *table,
+			   const u8 pubkey[NOISE_PUBLIC_KEY_LEN])
+{
+	struct wg_peer *iter_peer, *peer = NULL;
+
+	rcu_read_lock_bh();
+	hlist_for_each_entry_rcu_bh(iter_peer, pubkey_bucket(table, pubkey),
+				    pubkey_hash) {
+		if (!memcmp(pubkey, iter_peer->handshake.remote_static,
+			    NOISE_PUBLIC_KEY_LEN)) {
+			peer = iter_peer;
+			break;
+		}
+	}
+	peer = wg_peer_get_maybe_zero(peer);
+	rcu_read_unlock_bh();
+	return peer;
+}
+
+static struct hlist_head *index_bucket(struct index_hashtable *table,
+				       const __le32 index)
+{
+	/* Since the indices are random and thus all bits are uniformly
+	 * distributed, we can find its bucket simply by masking.
+	 */
+	return &table->hashtable[(__force u32)index &
+				 (HASH_SIZE(table->hashtable) - 1)];
+}
+
+struct index_hashtable *wg_index_hashtable_alloc(void)
+{
+	struct index_hashtable *table = kvmalloc(sizeof(*table), GFP_KERNEL);
+
+	if (!table)
+		return NULL;
+
+	hash_init(table->hashtable);
+	spin_lock_init(&table->lock);
+	return table;
+}
+
+/* At the moment, we limit ourselves to 2^20 total peers, which generally might
+ * amount to 2^20*3 items in this hashtable. The algorithm below works by
+ * picking a random number and testing it. We can see that these limits mean we
+ * usually succeed pretty quickly:
+ *
+ * >>> def calculation(tries, size):
+ * ...     return (size / 2**32)**(tries - 1) *  (1 - (size / 2**32))
+ * ...
+ * >>> calculation(1, 2**20 * 3)
+ * 0.999267578125
+ * >>> calculation(2, 2**20 * 3)
+ * 0.0007318854331970215
+ * >>> calculation(3, 2**20 * 3)
+ * 5.360489012673497e-07
+ * >>> calculation(4, 2**20 * 3)
+ * 3.9261394135792216e-10
+ *
+ * At the moment, we don't do any masking, so this algorithm isn't exactly
+ * constant time in either the random guessing or in the hash list lookup. We
+ * could require a minimum of 3 tries, which would successfully mask the
+ * guessing. this would not, however, help with the growing hash lengths, which
+ * is another thing to consider moving forward.
+ */
+
+__le32 wg_index_hashtable_insert(struct index_hashtable *table,
+				 struct index_hashtable_entry *entry)
+{
+	struct index_hashtable_entry *existing_entry;
+
+	spin_lock_bh(&table->lock);
+	hlist_del_init_rcu(&entry->index_hash);
+	spin_unlock_bh(&table->lock);
+
+	rcu_read_lock_bh();
+
+search_unused_slot:
+	/* First we try to find an unused slot, randomly, while unlocked. */
+	entry->index = (__force __le32)get_random_u32();
+	hlist_for_each_entry_rcu_bh(existing_entry,
+				    index_bucket(table, entry->index),
+				    index_hash) {
+		if (existing_entry->index == entry->index)
+			/* If it's already in use, we continue searching. */
+			goto search_unused_slot;
+	}
+
+	/* Once we've found an unused slot, we lock it, and then double-check
+	 * that nobody else stole it from us.
+	 */
+	spin_lock_bh(&table->lock);
+	hlist_for_each_entry_rcu_bh(existing_entry,
+				    index_bucket(table, entry->index),
+				    index_hash) {
+		if (existing_entry->index == entry->index) {
+			spin_unlock_bh(&table->lock);
+			/* If it was stolen, we start over. */
+			goto search_unused_slot;
+		}
+	}
+	/* Otherwise, we know we have it exclusively (since we're locked),
+	 * so we insert.
+	 */
+	hlist_add_head_rcu(&entry->index_hash,
+			   index_bucket(table, entry->index));
+	spin_unlock_bh(&table->lock);
+
+	rcu_read_unlock_bh();
+
+	return entry->index;
+}
+
+bool wg_index_hashtable_replace(struct index_hashtable *table,
+				struct index_hashtable_entry *old,
+				struct index_hashtable_entry *new)
+{
+	if (unlikely(hlist_unhashed(&old->index_hash)))
+		return false;
+	spin_lock_bh(&table->lock);
+	new->index = old->index;
+	hlist_replace_rcu(&old->index_hash, &new->index_hash);
+
+	/* Calling init here NULLs out index_hash, and in fact after this
+	 * function returns, it's theoretically possible for this to get
+	 * reinserted elsewhere. That means the RCU lookup below might either
+	 * terminate early or jump between buckets, in which case the packet
+	 * simply gets dropped, which isn't terrible.
+	 */
+	INIT_HLIST_NODE(&old->index_hash);
+	spin_unlock_bh(&table->lock);
+	return true;
+}
+
+void wg_index_hashtable_remove(struct index_hashtable *table,
+			       struct index_hashtable_entry *entry)
+{
+	spin_lock_bh(&table->lock);
+	hlist_del_init_rcu(&entry->index_hash);
+	spin_unlock_bh(&table->lock);
+}
+
+/* Returns a strong reference to a entry->peer */
+struct index_hashtable_entry *
+wg_index_hashtable_lookup(struct index_hashtable *table,
+			  const enum index_hashtable_type type_mask,
+			  const __le32 index, struct wg_peer **peer)
+{
+	struct index_hashtable_entry *iter_entry, *entry = NULL;
+
+	rcu_read_lock_bh();
+	hlist_for_each_entry_rcu_bh(iter_entry, index_bucket(table, index),
+				    index_hash) {
+		if (iter_entry->index == index) {
+			if (likely(iter_entry->type & type_mask))
+				entry = iter_entry;
+			break;
+		}
+	}
+	if (likely(entry)) {
+		entry->peer = wg_peer_get_maybe_zero(entry->peer);
+		if (likely(entry->peer))
+			*peer = entry->peer;
+		else
+			entry = NULL;
+	}
+	rcu_read_unlock_bh();
+	return entry;
+}
diff --git a/drivers/net/wireguard/peerlookup.h b/drivers/net/wireguard/peerlookup.h
new file mode 100644
index 000000000000..ced811797680
--- /dev/null
+++ b/drivers/net/wireguard/peerlookup.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_PEERLOOKUP_H
+#define _WG_PEERLOOKUP_H
+
+#include "messages.h"
+
+#include <linux/hashtable.h>
+#include <linux/mutex.h>
+#include <linux/siphash.h>
+
+struct wg_peer;
+
+struct pubkey_hashtable {
+	/* TODO: move to rhashtable */
+	DECLARE_HASHTABLE(hashtable, 11);
+	siphash_key_t key;
+	struct mutex lock;
+};
+
+struct pubkey_hashtable *wg_pubkey_hashtable_alloc(void);
+void wg_pubkey_hashtable_add(struct pubkey_hashtable *table,
+			     struct wg_peer *peer);
+void wg_pubkey_hashtable_remove(struct pubkey_hashtable *table,
+				struct wg_peer *peer);
+struct wg_peer *
+wg_pubkey_hashtable_lookup(struct pubkey_hashtable *table,
+			   const u8 pubkey[NOISE_PUBLIC_KEY_LEN]);
+
+struct index_hashtable {
+	/* TODO: move to rhashtable */
+	DECLARE_HASHTABLE(hashtable, 13);
+	spinlock_t lock;
+};
+
+enum index_hashtable_type {
+	INDEX_HASHTABLE_HANDSHAKE = 1U << 0,
+	INDEX_HASHTABLE_KEYPAIR = 1U << 1
+};
+
+struct index_hashtable_entry {
+	struct wg_peer *peer;
+	struct hlist_node index_hash;
+	enum index_hashtable_type type;
+	__le32 index;
+};
+
+struct index_hashtable *wg_index_hashtable_alloc(void);
+__le32 wg_index_hashtable_insert(struct index_hashtable *table,
+				 struct index_hashtable_entry *entry);
+bool wg_index_hashtable_replace(struct index_hashtable *table,
+				struct index_hashtable_entry *old,
+				struct index_hashtable_entry *new);
+void wg_index_hashtable_remove(struct index_hashtable *table,
+			       struct index_hashtable_entry *entry);
+struct index_hashtable_entry *
+wg_index_hashtable_lookup(struct index_hashtable *table,
+			  const enum index_hashtable_type type_mask,
+			  const __le32 index, struct wg_peer **peer);
+
+#endif /* _WG_PEERLOOKUP_H */
diff --git a/drivers/net/wireguard/queueing.c b/drivers/net/wireguard/queueing.c
new file mode 100644
index 000000000000..5c964fcb994e
--- /dev/null
+++ b/drivers/net/wireguard/queueing.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "queueing.h"
+
+struct multicore_worker __percpu *
+wg_packet_percpu_multicore_worker_alloc(work_func_t function, void *ptr)
+{
+	int cpu;
+	struct multicore_worker __percpu *worker =
+		alloc_percpu(struct multicore_worker);
+
+	if (!worker)
+		return NULL;
+
+	for_each_possible_cpu(cpu) {
+		per_cpu_ptr(worker, cpu)->ptr = ptr;
+		INIT_WORK(&per_cpu_ptr(worker, cpu)->work, function);
+	}
+	return worker;
+}
+
+int wg_packet_queue_init(struct crypt_queue *queue, work_func_t function,
+			 bool multicore, unsigned int len)
+{
+	int ret;
+
+	memset(queue, 0, sizeof(*queue));
+	ret = ptr_ring_init(&queue->ring, len, GFP_KERNEL);
+	if (ret)
+		return ret;
+	if (function) {
+		if (multicore) {
+			queue->worker = wg_packet_percpu_multicore_worker_alloc(
+				function, queue);
+			if (!queue->worker)
+				return -ENOMEM;
+		} else {
+			INIT_WORK(&queue->work, function);
+		}
+	}
+	return 0;
+}
+
+void wg_packet_queue_free(struct crypt_queue *queue, bool multicore)
+{
+	if (multicore)
+		free_percpu(queue->worker);
+	WARN_ON(!__ptr_ring_empty(&queue->ring));
+	ptr_ring_cleanup(&queue->ring, NULL);
+}
diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
new file mode 100644
index 000000000000..e49a464238fd
--- /dev/null
+++ b/drivers/net/wireguard/queueing.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_QUEUEING_H
+#define _WG_QUEUEING_H
+
+#include "peer.h"
+#include <linux/types.h>
+#include <linux/skbuff.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+struct wg_device;
+struct wg_peer;
+struct multicore_worker;
+struct crypt_queue;
+struct sk_buff;
+
+/* queueing.c APIs: */
+int wg_packet_queue_init(struct crypt_queue *queue, work_func_t function,
+			 bool multicore, unsigned int len);
+void wg_packet_queue_free(struct crypt_queue *queue, bool multicore);
+struct multicore_worker __percpu *
+wg_packet_percpu_multicore_worker_alloc(work_func_t function, void *ptr);
+
+/* receive.c APIs: */
+void wg_packet_receive(struct wg_device *wg, struct sk_buff *skb);
+void wg_packet_handshake_receive_worker(struct work_struct *work);
+/* NAPI poll function: */
+int wg_packet_rx_poll(struct napi_struct *napi, int budget);
+/* Workqueue worker: */
+void wg_packet_decrypt_worker(struct work_struct *work);
+
+/* send.c APIs: */
+void wg_packet_send_queued_handshake_initiation(struct wg_peer *peer,
+						bool is_retry);
+void wg_packet_send_handshake_response(struct wg_peer *peer);
+void wg_packet_send_handshake_cookie(struct wg_device *wg,
+				     struct sk_buff *initiating_skb,
+				     __le32 sender_index);
+void wg_packet_send_keepalive(struct wg_peer *peer);
+void wg_packet_purge_staged_packets(struct wg_peer *peer);
+void wg_packet_send_staged_packets(struct wg_peer *peer);
+/* Workqueue workers: */
+void wg_packet_handshake_send_worker(struct work_struct *work);
+void wg_packet_tx_worker(struct work_struct *work);
+void wg_packet_encrypt_worker(struct work_struct *work);
+
+enum packet_state {
+	PACKET_STATE_UNCRYPTED,
+	PACKET_STATE_CRYPTED,
+	PACKET_STATE_DEAD
+};
+
+struct packet_cb {
+	u64 nonce;
+	struct noise_keypair *keypair;
+	atomic_t state;
+	u32 mtu;
+	u8 ds;
+};
+
+#define PACKET_CB(skb) ((struct packet_cb *)((skb)->cb))
+#define PACKET_PEER(skb) (PACKET_CB(skb)->keypair->entry.peer)
+
+/* Returns either the correct skb->protocol value, or 0 if invalid. */
+static inline __be16 wg_skb_examine_untrusted_ip_hdr(struct sk_buff *skb)
+{
+	if (skb_network_header(skb) >= skb->head &&
+	    (skb_network_header(skb) + sizeof(struct iphdr)) <=
+		    skb_tail_pointer(skb) &&
+	    ip_hdr(skb)->version == 4)
+		return htons(ETH_P_IP);
+	if (skb_network_header(skb) >= skb->head &&
+	    (skb_network_header(skb) + sizeof(struct ipv6hdr)) <=
+		    skb_tail_pointer(skb) &&
+	    ipv6_hdr(skb)->version == 6)
+		return htons(ETH_P_IPV6);
+	return 0;
+}
+
+static inline void wg_reset_packet(struct sk_buff *skb)
+{
+	const int pfmemalloc = skb->pfmemalloc;
+
+	skb_scrub_packet(skb, true);
+	memset(&skb->headers_start, 0,
+	       offsetof(struct sk_buff, headers_end) -
+		       offsetof(struct sk_buff, headers_start));
+	skb->pfmemalloc = pfmemalloc;
+	skb->queue_mapping = 0;
+	skb->nohdr = 0;
+	skb->peeked = 0;
+	skb->mac_len = 0;
+	skb->dev = NULL;
+#ifdef CONFIG_NET_SCHED
+	skb->tc_index = 0;
+	skb_reset_tc(skb);
+#endif
+	skb->hdr_len = skb_headroom(skb);
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+	skb_probe_transport_header(skb);
+	skb_reset_inner_headers(skb);
+}
+
+static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
+{
+	unsigned int cpu = *stored_cpu, cpu_index, i;
+
+	if (unlikely(cpu == nr_cpumask_bits ||
+		     !cpumask_test_cpu(cpu, cpu_online_mask))) {
+		cpu_index = id % cpumask_weight(cpu_online_mask);
+		cpu = cpumask_first(cpu_online_mask);
+		for (i = 0; i < cpu_index; ++i)
+			cpu = cpumask_next(cpu, cpu_online_mask);
+		*stored_cpu = cpu;
+	}
+	return cpu;
+}
+
+/* This function is racy, in the sense that next is unlocked, so it could return
+ * the same CPU twice. A race-free version of this would be to instead store an
+ * atomic sequence number, do an increment-and-return, and then iterate through
+ * every possible CPU until we get to that index -- choose_cpu. However that's
+ * a bit slower, and it doesn't seem like this potential race actually
+ * introduces any performance loss, so we live with it.
+ */
+static inline int wg_cpumask_next_online(int *next)
+{
+	int cpu = *next;
+
+	while (unlikely(!cpumask_test_cpu(cpu, cpu_online_mask)))
+		cpu = cpumask_next(cpu, cpu_online_mask) % nr_cpumask_bits;
+	*next = cpumask_next(cpu, cpu_online_mask) % nr_cpumask_bits;
+	return cpu;
+}
+
+static inline int wg_queue_enqueue_per_device_and_peer(
+	struct crypt_queue *device_queue, struct crypt_queue *peer_queue,
+	struct sk_buff *skb, struct workqueue_struct *wq, int *next_cpu)
+{
+	int cpu;
+
+	atomic_set_release(&PACKET_CB(skb)->state, PACKET_STATE_UNCRYPTED);
+	/* We first queue this up for the peer ingestion, but the consumer
+	 * will wait for the state to change to CRYPTED or DEAD before.
+	 */
+	if (unlikely(ptr_ring_produce_bh(&peer_queue->ring, skb)))
+		return -ENOSPC;
+	/* Then we queue it up in the device queue, which consumes the
+	 * packet as soon as it can.
+	 */
+	cpu = wg_cpumask_next_online(next_cpu);
+	if (unlikely(ptr_ring_produce_bh(&device_queue->ring, skb)))
+		return -EPIPE;
+	queue_work_on(cpu, wq, &per_cpu_ptr(device_queue->worker, cpu)->work);
+	return 0;
+}
+
+static inline void wg_queue_enqueue_per_peer(struct crypt_queue *queue,
+					     struct sk_buff *skb,
+					     enum packet_state state)
+{
+	/* We take a reference, because as soon as we call atomic_set, the
+	 * peer can be freed from below us.
+	 */
+	struct wg_peer *peer = wg_peer_get(PACKET_PEER(skb));
+
+	atomic_set_release(&PACKET_CB(skb)->state, state);
+	queue_work_on(wg_cpumask_choose_online(&peer->serial_work_cpu,
+					       peer->internal_id),
+		      peer->device->packet_crypt_wq, &queue->work);
+	wg_peer_put(peer);
+}
+
+static inline void wg_queue_enqueue_per_peer_napi(struct sk_buff *skb,
+						  enum packet_state state)
+{
+	/* We take a reference, because as soon as we call atomic_set, the
+	 * peer can be freed from below us.
+	 */
+	struct wg_peer *peer = wg_peer_get(PACKET_PEER(skb));
+
+	atomic_set_release(&PACKET_CB(skb)->state, state);
+	napi_schedule(&peer->napi);
+	wg_peer_put(peer);
+}
+
+#ifdef DEBUG
+bool wg_packet_counter_selftest(void);
+#endif
+
+#endif /* _WG_QUEUEING_H */
diff --git a/drivers/net/wireguard/ratelimiter.c b/drivers/net/wireguard/ratelimiter.c
new file mode 100644
index 000000000000..3fedd1d21f5e
--- /dev/null
+++ b/drivers/net/wireguard/ratelimiter.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "ratelimiter.h"
+#include <linux/siphash.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <net/ip.h>
+
+static struct kmem_cache *entry_cache;
+static hsiphash_key_t key;
+static spinlock_t table_lock = __SPIN_LOCK_UNLOCKED("ratelimiter_table_lock");
+static DEFINE_MUTEX(init_lock);
+static u64 init_refcnt; /* Protected by init_lock, hence not atomic. */
+static atomic_t total_entries = ATOMIC_INIT(0);
+static unsigned int max_entries, table_size;
+static void wg_ratelimiter_gc_entries(struct work_struct *);
+static DECLARE_DEFERRABLE_WORK(gc_work, wg_ratelimiter_gc_entries);
+static struct hlist_head *table_v4;
+#if IS_ENABLED(CONFIG_IPV6)
+static struct hlist_head *table_v6;
+#endif
+
+struct ratelimiter_entry {
+	u64 last_time_ns, tokens, ip;
+	void *net;
+	spinlock_t lock;
+	struct hlist_node hash;
+	struct rcu_head rcu;
+};
+
+enum {
+	PACKETS_PER_SECOND = 20,
+	PACKETS_BURSTABLE = 5,
+	PACKET_COST = NSEC_PER_SEC / PACKETS_PER_SECOND,
+	TOKEN_MAX = PACKET_COST * PACKETS_BURSTABLE
+};
+
+static void entry_free(struct rcu_head *rcu)
+{
+	kmem_cache_free(entry_cache,
+			container_of(rcu, struct ratelimiter_entry, rcu));
+	atomic_dec(&total_entries);
+}
+
+static void entry_uninit(struct ratelimiter_entry *entry)
+{
+	hlist_del_rcu(&entry->hash);
+	call_rcu(&entry->rcu, entry_free);
+}
+
+/* Calling this function with a NULL work uninits all entries. */
+static void wg_ratelimiter_gc_entries(struct work_struct *work)
+{
+	const u64 now = ktime_get_coarse_boottime_ns();
+	struct ratelimiter_entry *entry;
+	struct hlist_node *temp;
+	unsigned int i;
+
+	for (i = 0; i < table_size; ++i) {
+		spin_lock(&table_lock);
+		hlist_for_each_entry_safe(entry, temp, &table_v4[i], hash) {
+			if (unlikely(!work) ||
+			    now - entry->last_time_ns > NSEC_PER_SEC)
+				entry_uninit(entry);
+		}
+#if IS_ENABLED(CONFIG_IPV6)
+		hlist_for_each_entry_safe(entry, temp, &table_v6[i], hash) {
+			if (unlikely(!work) ||
+			    now - entry->last_time_ns > NSEC_PER_SEC)
+				entry_uninit(entry);
+		}
+#endif
+		spin_unlock(&table_lock);
+		if (likely(work))
+			cond_resched();
+	}
+	if (likely(work))
+		queue_delayed_work(system_power_efficient_wq, &gc_work, HZ);
+}
+
+bool wg_ratelimiter_allow(struct sk_buff *skb, struct net *net)
+{
+	/* We only take the bottom half of the net pointer, so that we can hash
+	 * 3 words in the end. This way, siphash's len param fits into the final
+	 * u32, and we don't incur an extra round.
+	 */
+	const u32 net_word = (unsigned long)net;
+	struct ratelimiter_entry *entry;
+	struct hlist_head *bucket;
+	u64 ip;
+
+	if (skb->protocol == htons(ETH_P_IP)) {
+		ip = (u64 __force)ip_hdr(skb)->saddr;
+		bucket = &table_v4[hsiphash_2u32(net_word, ip, &key) &
+				   (table_size - 1)];
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (skb->protocol == htons(ETH_P_IPV6)) {
+		/* Only use 64 bits, so as to ratelimit the whole /64. */
+		memcpy(&ip, &ipv6_hdr(skb)->saddr, sizeof(ip));
+		bucket = &table_v6[hsiphash_3u32(net_word, ip >> 32, ip, &key) &
+				   (table_size - 1)];
+	}
+#endif
+	else
+		return false;
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(entry, bucket, hash) {
+		if (entry->net == net && entry->ip == ip) {
+			u64 now, tokens;
+			bool ret;
+			/* Quasi-inspired by nft_limit.c, but this is actually a
+			 * slightly different algorithm. Namely, we incorporate
+			 * the burst as part of the maximum tokens, rather than
+			 * as part of the rate.
+			 */
+			spin_lock(&entry->lock);
+			now = ktime_get_coarse_boottime_ns();
+			tokens = min_t(u64, TOKEN_MAX,
+				       entry->tokens + now -
+					       entry->last_time_ns);
+			entry->last_time_ns = now;
+			ret = tokens >= PACKET_COST;
+			entry->tokens = ret ? tokens - PACKET_COST : tokens;
+			spin_unlock(&entry->lock);
+			rcu_read_unlock();
+			return ret;
+		}
+	}
+	rcu_read_unlock();
+
+	if (atomic_inc_return(&total_entries) > max_entries)
+		goto err_oom;
+
+	entry = kmem_cache_alloc(entry_cache, GFP_KERNEL);
+	if (unlikely(!entry))
+		goto err_oom;
+
+	entry->net = net;
+	entry->ip = ip;
+	INIT_HLIST_NODE(&entry->hash);
+	spin_lock_init(&entry->lock);
+	entry->last_time_ns = ktime_get_coarse_boottime_ns();
+	entry->tokens = TOKEN_MAX - PACKET_COST;
+	spin_lock(&table_lock);
+	hlist_add_head_rcu(&entry->hash, bucket);
+	spin_unlock(&table_lock);
+	return true;
+
+err_oom:
+	atomic_dec(&total_entries);
+	return false;
+}
+
+int wg_ratelimiter_init(void)
+{
+	mutex_lock(&init_lock);
+	if (++init_refcnt != 1)
+		goto out;
+
+	entry_cache = KMEM_CACHE(ratelimiter_entry, 0);
+	if (!entry_cache)
+		goto err;
+
+	/* xt_hashlimit.c uses a slightly different algorithm for ratelimiting,
+	 * but what it shares in common is that it uses a massive hashtable. So,
+	 * we borrow their wisdom about good table sizes on different systems
+	 * dependent on RAM. This calculation here comes from there.
+	 */
+	table_size = (totalram_pages() > (1U << 30) / PAGE_SIZE) ? 8192 :
+		max_t(unsigned long, 16, roundup_pow_of_two(
+			(totalram_pages() << PAGE_SHIFT) /
+			(1U << 14) / sizeof(struct hlist_head)));
+	max_entries = table_size * 8;
+
+	table_v4 = kvzalloc(table_size * sizeof(*table_v4), GFP_KERNEL);
+	if (unlikely(!table_v4))
+		goto err_kmemcache;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	table_v6 = kvzalloc(table_size * sizeof(*table_v6), GFP_KERNEL);
+	if (unlikely(!table_v6)) {
+		kvfree(table_v4);
+		goto err_kmemcache;
+	}
+#endif
+
+	queue_delayed_work(system_power_efficient_wq, &gc_work, HZ);
+	get_random_bytes(&key, sizeof(key));
+out:
+	mutex_unlock(&init_lock);
+	return 0;
+
+err_kmemcache:
+	kmem_cache_destroy(entry_cache);
+err:
+	--init_refcnt;
+	mutex_unlock(&init_lock);
+	return -ENOMEM;
+}
+
+void wg_ratelimiter_uninit(void)
+{
+	mutex_lock(&init_lock);
+	if (!init_refcnt || --init_refcnt)
+		goto out;
+
+	cancel_delayed_work_sync(&gc_work);
+	wg_ratelimiter_gc_entries(NULL);
+	rcu_barrier();
+	kvfree(table_v4);
+#if IS_ENABLED(CONFIG_IPV6)
+	kvfree(table_v6);
+#endif
+	kmem_cache_destroy(entry_cache);
+out:
+	mutex_unlock(&init_lock);
+}
+
+#include "selftest/ratelimiter.c"
diff --git a/drivers/net/wireguard/ratelimiter.h b/drivers/net/wireguard/ratelimiter.h
new file mode 100644
index 000000000000..83067f71ea99
--- /dev/null
+++ b/drivers/net/wireguard/ratelimiter.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_RATELIMITER_H
+#define _WG_RATELIMITER_H
+
+#include <linux/skbuff.h>
+
+int wg_ratelimiter_init(void);
+void wg_ratelimiter_uninit(void);
+bool wg_ratelimiter_allow(struct sk_buff *skb, struct net *net);
+
+#ifdef DEBUG
+bool wg_ratelimiter_selftest(void);
+#endif
+
+#endif /* _WG_RATELIMITER_H */
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
new file mode 100644
index 000000000000..7e675f541491
--- /dev/null
+++ b/drivers/net/wireguard/receive.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "queueing.h"
+#include "device.h"
+#include "peer.h"
+#include "timers.h"
+#include "messages.h"
+#include "cookie.h"
+#include "socket.h"
+
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
+#include <net/ip_tunnels.h>
+
+/* Must be called with bh disabled. */
+static void update_rx_stats(struct wg_peer *peer, size_t len)
+{
+	struct pcpu_sw_netstats *tstats =
+		get_cpu_ptr(peer->device->dev->tstats);
+
+	u64_stats_update_begin(&tstats->syncp);
+	++tstats->rx_packets;
+	tstats->rx_bytes += len;
+	peer->rx_bytes += len;
+	u64_stats_update_end(&tstats->syncp);
+	put_cpu_ptr(tstats);
+}
+
+#define SKB_TYPE_LE32(skb) (((struct message_header *)(skb)->data)->type)
+
+static size_t validate_header_len(struct sk_buff *skb)
+{
+	if (unlikely(skb->len < sizeof(struct message_header)))
+		return 0;
+	if (SKB_TYPE_LE32(skb) == cpu_to_le32(MESSAGE_DATA) &&
+	    skb->len >= MESSAGE_MINIMUM_LENGTH)
+		return sizeof(struct message_data);
+	if (SKB_TYPE_LE32(skb) == cpu_to_le32(MESSAGE_HANDSHAKE_INITIATION) &&
+	    skb->len == sizeof(struct message_handshake_initiation))
+		return sizeof(struct message_handshake_initiation);
+	if (SKB_TYPE_LE32(skb) == cpu_to_le32(MESSAGE_HANDSHAKE_RESPONSE) &&
+	    skb->len == sizeof(struct message_handshake_response))
+		return sizeof(struct message_handshake_response);
+	if (SKB_TYPE_LE32(skb) == cpu_to_le32(MESSAGE_HANDSHAKE_COOKIE) &&
+	    skb->len == sizeof(struct message_handshake_cookie))
+		return sizeof(struct message_handshake_cookie);
+	return 0;
+}
+
+static int prepare_skb_header(struct sk_buff *skb, struct wg_device *wg)
+{
+	size_t data_offset, data_len, header_len;
+	struct udphdr *udp;
+
+	if (unlikely(wg_skb_examine_untrusted_ip_hdr(skb) != skb->protocol ||
+		     skb_transport_header(skb) < skb->head ||
+		     (skb_transport_header(skb) + sizeof(struct udphdr)) >
+			     skb_tail_pointer(skb)))
+		return -EINVAL; /* Bogus IP header */
+	udp = udp_hdr(skb);
+	data_offset = (u8 *)udp - skb->data;
+	if (unlikely(data_offset > U16_MAX ||
+		     data_offset + sizeof(struct udphdr) > skb->len))
+		/* Packet has offset at impossible location or isn't big enough
+		 * to have UDP fields.
+		 */
+		return -EINVAL;
+	data_len = ntohs(udp->len);
+	if (unlikely(data_len < sizeof(struct udphdr) ||
+		     data_len > skb->len - data_offset))
+		/* UDP packet is reporting too small of a size or lying about
+		 * its size.
+		 */
+		return -EINVAL;
+	data_len -= sizeof(struct udphdr);
+	data_offset = (u8 *)udp + sizeof(struct udphdr) - skb->data;
+	if (unlikely(!pskb_may_pull(skb,
+				data_offset + sizeof(struct message_header)) ||
+		     pskb_trim(skb, data_len + data_offset) < 0))
+		return -EINVAL;
+	skb_pull(skb, data_offset);
+	if (unlikely(skb->len != data_len))
+		/* Final len does not agree with calculated len */
+		return -EINVAL;
+	header_len = validate_header_len(skb);
+	if (unlikely(!header_len))
+		return -EINVAL;
+	__skb_push(skb, data_offset);
+	if (unlikely(!pskb_may_pull(skb, data_offset + header_len)))
+		return -EINVAL;
+	__skb_pull(skb, data_offset);
+	return 0;
+}
+
+static void wg_receive_handshake_packet(struct wg_device *wg,
+					struct sk_buff *skb)
+{
+	enum cookie_mac_state mac_state;
+	struct wg_peer *peer = NULL;
+	/* This is global, so that our load calculation applies to the whole
+	 * system. We don't care about races with it at all.
+	 */
+	static u64 last_under_load;
+	bool packet_needs_cookie;
+	bool under_load;
+
+	if (SKB_TYPE_LE32(skb) == cpu_to_le32(MESSAGE_HANDSHAKE_COOKIE)) {
+		net_dbg_skb_ratelimited("%s: Receiving cookie response from %pISpfsc\n",
+					wg->dev->name, skb);
+		wg_cookie_message_consume(
+			(struct message_handshake_cookie *)skb->data, wg);
+		return;
+	}
+
+	under_load = skb_queue_len(&wg->incoming_handshakes) >=
+		     MAX_QUEUED_INCOMING_HANDSHAKES / 8;
+	if (under_load)
+		last_under_load = ktime_get_coarse_boottime_ns();
+	else if (last_under_load)
+		under_load = !wg_birthdate_has_expired(last_under_load, 1);
+	mac_state = wg_cookie_validate_packet(&wg->cookie_checker, skb,
+					      under_load);
+	if ((under_load && mac_state == VALID_MAC_WITH_COOKIE) ||
+	    (!under_load && mac_state == VALID_MAC_BUT_NO_COOKIE)) {
+		packet_needs_cookie = false;
+	} else if (under_load && mac_state == VALID_MAC_BUT_NO_COOKIE) {
+		packet_needs_cookie = true;
+	} else {
+		net_dbg_skb_ratelimited("%s: Invalid MAC of handshake, dropping packet from %pISpfsc\n",
+					wg->dev->name, skb);
+		return;
+	}
+
+	switch (SKB_TYPE_LE32(skb)) {
+	case cpu_to_le32(MESSAGE_HANDSHAKE_INITIATION): {
+		struct message_handshake_initiation *message =
+			(struct message_handshake_initiation *)skb->data;
+
+		if (packet_needs_cookie) {
+			wg_packet_send_handshake_cookie(wg, skb,
+							message->sender_index);
+			return;
+		}
+		peer = wg_noise_handshake_consume_initiation(message, wg);
+		if (unlikely(!peer)) {
+			net_dbg_skb_ratelimited("%s: Invalid handshake initiation from %pISpfsc\n",
+						wg->dev->name, skb);
+			return;
+		}
+		wg_socket_set_peer_endpoint_from_skb(peer, skb);
+		net_dbg_ratelimited("%s: Receiving handshake initiation from peer %llu (%pISpfsc)\n",
+				    wg->dev->name, peer->internal_id,
+				    &peer->endpoint.addr);
+		wg_packet_send_handshake_response(peer);
+		break;
+	}
+	case cpu_to_le32(MESSAGE_HANDSHAKE_RESPONSE): {
+		struct message_handshake_response *message =
+			(struct message_handshake_response *)skb->data;
+
+		if (packet_needs_cookie) {
+			wg_packet_send_handshake_cookie(wg, skb,
+							message->sender_index);
+			return;
+		}
+		peer = wg_noise_handshake_consume_response(message, wg);
+		if (unlikely(!peer)) {
+			net_dbg_skb_ratelimited("%s: Invalid handshake response from %pISpfsc\n",
+						wg->dev->name, skb);
+			return;
+		}
+		wg_socket_set_peer_endpoint_from_skb(peer, skb);
+		net_dbg_ratelimited("%s: Receiving handshake response from peer %llu (%pISpfsc)\n",
+				    wg->dev->name, peer->internal_id,
+				    &peer->endpoint.addr);
+		if (wg_noise_handshake_begin_session(&peer->handshake,
+						     &peer->keypairs)) {
+			wg_timers_session_derived(peer);
+			wg_timers_handshake_complete(peer);
+			/* Calling this function will either send any existing
+			 * packets in the queue and not send a keepalive, which
+			 * is the best case, Or, if there's nothing in the
+			 * queue, it will send a keepalive, in order to give
+			 * immediate confirmation of the session.
+			 */
+			wg_packet_send_keepalive(peer);
+		}
+		break;
+	}
+	}
+
+	if (unlikely(!peer)) {
+		WARN(1, "Somehow a wrong type of packet wound up in the handshake queue!\n");
+		return;
+	}
+
+	local_bh_disable();
+	update_rx_stats(peer, skb->len);
+	local_bh_enable();
+
+	wg_timers_any_authenticated_packet_received(peer);
+	wg_timers_any_authenticated_packet_traversal(peer);
+	wg_peer_put(peer);
+}
+
+void wg_packet_handshake_receive_worker(struct work_struct *work)
+{
+	struct wg_device *wg = container_of(work, struct multicore_worker,
+					    work)->ptr;
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&wg->incoming_handshakes)) != NULL) {
+		wg_receive_handshake_packet(wg, skb);
+		dev_kfree_skb(skb);
+		cond_resched();
+	}
+}
+
+static void keep_key_fresh(struct wg_peer *peer)
+{
+	struct noise_keypair *keypair;
+	bool send = false;
+
+	if (peer->sent_lastminute_handshake)
+		return;
+
+	rcu_read_lock_bh();
+	keypair = rcu_dereference_bh(peer->keypairs.current_keypair);
+	if (likely(keypair && READ_ONCE(keypair->sending.is_valid)) &&
+	    keypair->i_am_the_initiator &&
+	    unlikely(wg_birthdate_has_expired(keypair->sending.birthdate,
+			REJECT_AFTER_TIME - KEEPALIVE_TIMEOUT - REKEY_TIMEOUT)))
+		send = true;
+	rcu_read_unlock_bh();
+
+	if (send) {
+		peer->sent_lastminute_handshake = true;
+		wg_packet_send_queued_handshake_initiation(peer, false);
+	}
+}
+
+static bool decrypt_packet(struct sk_buff *skb, struct noise_symmetric_key *key)
+{
+	struct scatterlist sg[MAX_SKB_FRAGS + 8];
+	struct sk_buff *trailer;
+	unsigned int offset;
+	int num_frags;
+
+	if (unlikely(!key))
+		return false;
+
+	if (unlikely(!READ_ONCE(key->is_valid) ||
+		  wg_birthdate_has_expired(key->birthdate, REJECT_AFTER_TIME) ||
+		  key->counter.receive.counter >= REJECT_AFTER_MESSAGES)) {
+		WRITE_ONCE(key->is_valid, false);
+		return false;
+	}
+
+	PACKET_CB(skb)->nonce =
+		le64_to_cpu(((struct message_data *)skb->data)->counter);
+
+	/* We ensure that the network header is part of the packet before we
+	 * call skb_cow_data, so that there's no chance that data is removed
+	 * from the skb, so that later we can extract the original endpoint.
+	 */
+	offset = skb->data - skb_network_header(skb);
+	skb_push(skb, offset);
+	num_frags = skb_cow_data(skb, 0, &trailer);
+	offset += sizeof(struct message_data);
+	skb_pull(skb, offset);
+	if (unlikely(num_frags < 0 || num_frags > ARRAY_SIZE(sg)))
+		return false;
+
+	sg_init_table(sg, num_frags);
+	if (skb_to_sgvec(skb, sg, 0, skb->len) <= 0)
+		return false;
+
+	if (!chacha20poly1305_decrypt_sg_inplace(sg, skb->len, NULL, 0,
+					         PACKET_CB(skb)->nonce,
+						 key->key))
+		return false;
+
+	/* Another ugly situation of pushing and pulling the header so as to
+	 * keep endpoint information intact.
+	 */
+	skb_push(skb, offset);
+	if (pskb_trim(skb, skb->len - noise_encrypted_len(0)))
+		return false;
+	skb_pull(skb, offset);
+
+	return true;
+}
+
+/* This is RFC6479, a replay detection bitmap algorithm that avoids bitshifts */
+static bool counter_validate(union noise_counter *counter, u64 their_counter)
+{
+	unsigned long index, index_current, top, i;
+	bool ret = false;
+
+	spin_lock_bh(&counter->receive.lock);
+
+	if (unlikely(counter->receive.counter >= REJECT_AFTER_MESSAGES + 1 ||
+		     their_counter >= REJECT_AFTER_MESSAGES))
+		goto out;
+
+	++their_counter;
+
+	if (unlikely((COUNTER_WINDOW_SIZE + their_counter) <
+		     counter->receive.counter))
+		goto out;
+
+	index = their_counter >> ilog2(BITS_PER_LONG);
+
+	if (likely(their_counter > counter->receive.counter)) {
+		index_current = counter->receive.counter >> ilog2(BITS_PER_LONG);
+		top = min_t(unsigned long, index - index_current,
+			    COUNTER_BITS_TOTAL / BITS_PER_LONG);
+		for (i = 1; i <= top; ++i)
+			counter->receive.backtrack[(i + index_current) &
+				((COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1)] = 0;
+		counter->receive.counter = their_counter;
+	}
+
+	index &= (COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1;
+	ret = !test_and_set_bit(their_counter & (BITS_PER_LONG - 1),
+				&counter->receive.backtrack[index]);
+
+out:
+	spin_unlock_bh(&counter->receive.lock);
+	return ret;
+}
+
+#include "selftest/counter.c"
+
+static void wg_packet_consume_data_done(struct wg_peer *peer,
+					struct sk_buff *skb,
+					struct endpoint *endpoint)
+{
+	struct net_device *dev = peer->device->dev;
+	unsigned int len, len_before_trim;
+	struct wg_peer *routed_peer;
+
+	wg_socket_set_peer_endpoint(peer, endpoint);
+
+	if (unlikely(wg_noise_received_with_keypair(&peer->keypairs,
+						    PACKET_CB(skb)->keypair))) {
+		wg_timers_handshake_complete(peer);
+		wg_packet_send_staged_packets(peer);
+	}
+
+	keep_key_fresh(peer);
+
+	wg_timers_any_authenticated_packet_received(peer);
+	wg_timers_any_authenticated_packet_traversal(peer);
+
+	/* A packet with length 0 is a keepalive packet */
+	if (unlikely(!skb->len)) {
+		update_rx_stats(peer, message_data_len(0));
+		net_dbg_ratelimited("%s: Receiving keepalive packet from peer %llu (%pISpfsc)\n",
+				    dev->name, peer->internal_id,
+				    &peer->endpoint.addr);
+		goto packet_processed;
+	}
+
+	wg_timers_data_received(peer);
+
+	if (unlikely(skb_network_header(skb) < skb->head))
+		goto dishonest_packet_size;
+	if (unlikely(!(pskb_network_may_pull(skb, sizeof(struct iphdr)) &&
+		       (ip_hdr(skb)->version == 4 ||
+			(ip_hdr(skb)->version == 6 &&
+			 pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))))))
+		goto dishonest_packet_type;
+
+	skb->dev = dev;
+	/* We've already verified the Poly1305 auth tag, which means this packet
+	 * was not modified in transit. We can therefore tell the networking
+	 * stack that all checksums of every layer of encapsulation have already
+	 * been checked "by the hardware" and therefore is unneccessary to check
+	 * again in software.
+	 */
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->csum_level = ~0; /* All levels */
+	skb->protocol = wg_skb_examine_untrusted_ip_hdr(skb);
+	if (skb->protocol == htons(ETH_P_IP)) {
+		len = ntohs(ip_hdr(skb)->tot_len);
+		if (unlikely(len < sizeof(struct iphdr)))
+			goto dishonest_packet_size;
+		if (INET_ECN_is_ce(PACKET_CB(skb)->ds))
+			IP_ECN_set_ce(ip_hdr(skb));
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		len = ntohs(ipv6_hdr(skb)->payload_len) +
+		      sizeof(struct ipv6hdr);
+		if (INET_ECN_is_ce(PACKET_CB(skb)->ds))
+			IP6_ECN_set_ce(skb, ipv6_hdr(skb));
+	} else {
+		goto dishonest_packet_type;
+	}
+
+	if (unlikely(len > skb->len))
+		goto dishonest_packet_size;
+	len_before_trim = skb->len;
+	if (unlikely(pskb_trim(skb, len)))
+		goto packet_processed;
+
+	routed_peer = wg_allowedips_lookup_src(&peer->device->peer_allowedips,
+					       skb);
+	wg_peer_put(routed_peer); /* We don't need the extra reference. */
+
+	if (unlikely(routed_peer != peer))
+		goto dishonest_packet_peer;
+
+	if (unlikely(napi_gro_receive(&peer->napi, skb) == GRO_DROP)) {
+		++dev->stats.rx_dropped;
+		net_dbg_ratelimited("%s: Failed to give packet to userspace from peer %llu (%pISpfsc)\n",
+				    dev->name, peer->internal_id,
+				    &peer->endpoint.addr);
+	} else {
+		update_rx_stats(peer, message_data_len(len_before_trim));
+	}
+	return;
+
+dishonest_packet_peer:
+	net_dbg_skb_ratelimited("%s: Packet has unallowed src IP (%pISc) from peer %llu (%pISpfsc)\n",
+				dev->name, skb, peer->internal_id,
+				&peer->endpoint.addr);
+	++dev->stats.rx_errors;
+	++dev->stats.rx_frame_errors;
+	goto packet_processed;
+dishonest_packet_type:
+	net_dbg_ratelimited("%s: Packet is neither ipv4 nor ipv6 from peer %llu (%pISpfsc)\n",
+			    dev->name, peer->internal_id, &peer->endpoint.addr);
+	++dev->stats.rx_errors;
+	++dev->stats.rx_frame_errors;
+	goto packet_processed;
+dishonest_packet_size:
+	net_dbg_ratelimited("%s: Packet has incorrect size from peer %llu (%pISpfsc)\n",
+			    dev->name, peer->internal_id, &peer->endpoint.addr);
+	++dev->stats.rx_errors;
+	++dev->stats.rx_length_errors;
+	goto packet_processed;
+packet_processed:
+	dev_kfree_skb(skb);
+}
+
+int wg_packet_rx_poll(struct napi_struct *napi, int budget)
+{
+	struct wg_peer *peer = container_of(napi, struct wg_peer, napi);
+	struct crypt_queue *queue = &peer->rx_queue;
+	struct noise_keypair *keypair;
+	struct endpoint endpoint;
+	enum packet_state state;
+	struct sk_buff *skb;
+	int work_done = 0;
+	bool free;
+
+	if (unlikely(budget <= 0))
+		return 0;
+
+	while ((skb = __ptr_ring_peek(&queue->ring)) != NULL &&
+	       (state = atomic_read_acquire(&PACKET_CB(skb)->state)) !=
+		       PACKET_STATE_UNCRYPTED) {
+		__ptr_ring_discard_one(&queue->ring);
+		peer = PACKET_PEER(skb);
+		keypair = PACKET_CB(skb)->keypair;
+		free = true;
+
+		if (unlikely(state != PACKET_STATE_CRYPTED))
+			goto next;
+
+		if (unlikely(!counter_validate(&keypair->receiving.counter,
+					       PACKET_CB(skb)->nonce))) {
+			net_dbg_ratelimited("%s: Packet has invalid nonce %llu (max %llu)\n",
+					    peer->device->dev->name,
+					    PACKET_CB(skb)->nonce,
+					    keypair->receiving.counter.receive.counter);
+			goto next;
+		}
+
+		if (unlikely(wg_socket_endpoint_from_skb(&endpoint, skb)))
+			goto next;
+
+		wg_reset_packet(skb);
+		wg_packet_consume_data_done(peer, skb, &endpoint);
+		free = false;
+
+next:
+		wg_noise_keypair_put(keypair, false);
+		wg_peer_put(peer);
+		if (unlikely(free))
+			dev_kfree_skb(skb);
+
+		if (++work_done >= budget)
+			break;
+	}
+
+	if (work_done < budget)
+		napi_complete_done(napi, work_done);
+
+	return work_done;
+}
+
+void wg_packet_decrypt_worker(struct work_struct *work)
+{
+	struct crypt_queue *queue = container_of(work, struct multicore_worker,
+						 work)->ptr;
+	struct sk_buff *skb;
+
+	while ((skb = ptr_ring_consume_bh(&queue->ring)) != NULL) {
+		enum packet_state state = likely(decrypt_packet(skb,
+				&PACKET_CB(skb)->keypair->receiving)) ?
+				PACKET_STATE_CRYPTED : PACKET_STATE_DEAD;
+		wg_queue_enqueue_per_peer_napi(skb, state);
+	}
+}
+
+static void wg_packet_consume_data(struct wg_device *wg, struct sk_buff *skb)
+{
+	__le32 idx = ((struct message_data *)skb->data)->key_idx;
+	struct wg_peer *peer = NULL;
+	int ret;
+
+	rcu_read_lock_bh();
+	PACKET_CB(skb)->keypair =
+		(struct noise_keypair *)wg_index_hashtable_lookup(
+			wg->index_hashtable, INDEX_HASHTABLE_KEYPAIR, idx,
+			&peer);
+	if (unlikely(!wg_noise_keypair_get(PACKET_CB(skb)->keypair)))
+		goto err_keypair;
+
+	if (unlikely(READ_ONCE(peer->is_dead)))
+		goto err;
+
+	ret = wg_queue_enqueue_per_device_and_peer(&wg->decrypt_queue,
+						   &peer->rx_queue, skb,
+						   wg->packet_crypt_wq,
+						   &wg->decrypt_queue.last_cpu);
+	if (unlikely(ret == -EPIPE))
+		wg_queue_enqueue_per_peer_napi(skb, PACKET_STATE_DEAD);
+	if (likely(!ret || ret == -EPIPE)) {
+		rcu_read_unlock_bh();
+		return;
+	}
+err:
+	wg_noise_keypair_put(PACKET_CB(skb)->keypair, false);
+err_keypair:
+	rcu_read_unlock_bh();
+	wg_peer_put(peer);
+	dev_kfree_skb(skb);
+}
+
+void wg_packet_receive(struct wg_device *wg, struct sk_buff *skb)
+{
+	if (unlikely(prepare_skb_header(skb, wg) < 0))
+		goto err;
+	switch (SKB_TYPE_LE32(skb)) {
+	case cpu_to_le32(MESSAGE_HANDSHAKE_INITIATION):
+	case cpu_to_le32(MESSAGE_HANDSHAKE_RESPONSE):
+	case cpu_to_le32(MESSAGE_HANDSHAKE_COOKIE): {
+		int cpu;
+
+		if (skb_queue_len(&wg->incoming_handshakes) >
+			    MAX_QUEUED_INCOMING_HANDSHAKES ||
+		    unlikely(!rng_is_initialized())) {
+			net_dbg_skb_ratelimited("%s: Dropping handshake packet from %pISpfsc\n",
+						wg->dev->name, skb);
+			goto err;
+		}
+		skb_queue_tail(&wg->incoming_handshakes, skb);
+		/* Queues up a call to packet_process_queued_handshake_
+		 * packets(skb):
+		 */
+		cpu = wg_cpumask_next_online(&wg->incoming_handshake_cpu);
+		queue_work_on(cpu, wg->handshake_receive_wq,
+			&per_cpu_ptr(wg->incoming_handshakes_worker, cpu)->work);
+		break;
+	}
+	case cpu_to_le32(MESSAGE_DATA):
+		PACKET_CB(skb)->ds = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
+		wg_packet_consume_data(wg, skb);
+		break;
+	default:
+		net_dbg_skb_ratelimited("%s: Invalid packet from %pISpfsc\n",
+					wg->dev->name, skb);
+		goto err;
+	}
+	return;
+
+err:
+	dev_kfree_skb(skb);
+}
diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
new file mode 100644
index 000000000000..846db14cb046
--- /dev/null
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -0,0 +1,683 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ * This contains some basic static unit tests for the allowedips data structure.
+ * It also has two additional modes that are disabled and meant to be used by
+ * folks directly playing with this file. If you define the macro
+ * DEBUG_PRINT_TRIE_GRAPHVIZ to be 1, then every time there's a full tree in
+ * memory, it will be printed out as KERN_DEBUG in a format that can be passed
+ * to graphviz (the dot command) to visualize it. If you define the macro
+ * DEBUG_RANDOM_TRIE to be 1, then there will be an extremely costly set of
+ * randomized tests done against a trivial implementation, which may take
+ * upwards of a half-hour to complete. There's no set of users who should be
+ * enabling these, and the only developers that should go anywhere near these
+ * nobs are the ones who are reading this comment.
+ */
+
+#ifdef DEBUG
+
+#include <linux/siphash.h>
+
+static __init void swap_endian_and_apply_cidr(u8 *dst, const u8 *src, u8 bits,
+					      u8 cidr)
+{
+	swap_endian(dst, src, bits);
+	memset(dst + (cidr + 7) / 8, 0, bits / 8 - (cidr + 7) / 8);
+	if (cidr)
+		dst[(cidr + 7) / 8 - 1] &= ~0U << ((8 - (cidr % 8)) % 8);
+}
+
+static __init void print_node(struct allowedips_node *node, u8 bits)
+{
+	char *fmt_connection = KERN_DEBUG "\t\"%p/%d\" -> \"%p/%d\";\n";
+	char *fmt_declaration = KERN_DEBUG
+		"\t\"%p/%d\"[style=%s, color=\"#%06x\"];\n";
+	char *style = "dotted";
+	u8 ip1[16], ip2[16];
+	u32 color = 0;
+
+	if (bits == 32) {
+		fmt_connection = KERN_DEBUG "\t\"%pI4/%d\" -> \"%pI4/%d\";\n";
+		fmt_declaration = KERN_DEBUG
+			"\t\"%pI4/%d\"[style=%s, color=\"#%06x\"];\n";
+	} else if (bits == 128) {
+		fmt_connection = KERN_DEBUG "\t\"%pI6/%d\" -> \"%pI6/%d\";\n";
+		fmt_declaration = KERN_DEBUG
+			"\t\"%pI6/%d\"[style=%s, color=\"#%06x\"];\n";
+	}
+	if (node->peer) {
+		hsiphash_key_t key = { { 0 } };
+
+		memcpy(&key, &node->peer, sizeof(node->peer));
+		color = hsiphash_1u32(0xdeadbeef, &key) % 200 << 16 |
+			hsiphash_1u32(0xbabecafe, &key) % 200 << 8 |
+			hsiphash_1u32(0xabad1dea, &key) % 200;
+		style = "bold";
+	}
+	swap_endian_and_apply_cidr(ip1, node->bits, bits, node->cidr);
+	printk(fmt_declaration, ip1, node->cidr, style, color);
+	if (node->bit[0]) {
+		swap_endian_and_apply_cidr(ip2,
+				rcu_dereference_raw(node->bit[0])->bits, bits,
+				node->cidr);
+		printk(fmt_connection, ip1, node->cidr, ip2,
+		       rcu_dereference_raw(node->bit[0])->cidr);
+		print_node(rcu_dereference_raw(node->bit[0]), bits);
+	}
+	if (node->bit[1]) {
+		swap_endian_and_apply_cidr(ip2,
+				rcu_dereference_raw(node->bit[1])->bits,
+				bits, node->cidr);
+		printk(fmt_connection, ip1, node->cidr, ip2,
+		       rcu_dereference_raw(node->bit[1])->cidr);
+		print_node(rcu_dereference_raw(node->bit[1]), bits);
+	}
+}
+
+static __init void print_tree(struct allowedips_node __rcu *top, u8 bits)
+{
+	printk(KERN_DEBUG "digraph trie {\n");
+	print_node(rcu_dereference_raw(top), bits);
+	printk(KERN_DEBUG "}\n");
+}
+
+enum {
+	NUM_PEERS = 2000,
+	NUM_RAND_ROUTES = 400,
+	NUM_MUTATED_ROUTES = 100,
+	NUM_QUERIES = NUM_RAND_ROUTES * NUM_MUTATED_ROUTES * 30
+};
+
+struct horrible_allowedips {
+	struct hlist_head head;
+};
+
+struct horrible_allowedips_node {
+	struct hlist_node table;
+	union nf_inet_addr ip;
+	union nf_inet_addr mask;
+	u8 ip_version;
+	void *value;
+};
+
+static __init void horrible_allowedips_init(struct horrible_allowedips *table)
+{
+	INIT_HLIST_HEAD(&table->head);
+}
+
+static __init void horrible_allowedips_free(struct horrible_allowedips *table)
+{
+	struct horrible_allowedips_node *node;
+	struct hlist_node *h;
+
+	hlist_for_each_entry_safe(node, h, &table->head, table) {
+		hlist_del(&node->table);
+		kfree(node);
+	}
+}
+
+static __init inline union nf_inet_addr horrible_cidr_to_mask(u8 cidr)
+{
+	union nf_inet_addr mask;
+
+	memset(&mask, 0x00, 128 / 8);
+	memset(&mask, 0xff, cidr / 8);
+	if (cidr % 32)
+		mask.all[cidr / 32] = (__force u32)htonl(
+			(0xFFFFFFFFUL << (32 - (cidr % 32))) & 0xFFFFFFFFUL);
+	return mask;
+}
+
+static __init inline u8 horrible_mask_to_cidr(union nf_inet_addr subnet)
+{
+	return hweight32(subnet.all[0]) + hweight32(subnet.all[1]) +
+	       hweight32(subnet.all[2]) + hweight32(subnet.all[3]);
+}
+
+static __init inline void
+horrible_mask_self(struct horrible_allowedips_node *node)
+{
+	if (node->ip_version == 4) {
+		node->ip.ip &= node->mask.ip;
+	} else if (node->ip_version == 6) {
+		node->ip.ip6[0] &= node->mask.ip6[0];
+		node->ip.ip6[1] &= node->mask.ip6[1];
+		node->ip.ip6[2] &= node->mask.ip6[2];
+		node->ip.ip6[3] &= node->mask.ip6[3];
+	}
+}
+
+static __init inline bool
+horrible_match_v4(const struct horrible_allowedips_node *node,
+		  struct in_addr *ip)
+{
+	return (ip->s_addr & node->mask.ip) == node->ip.ip;
+}
+
+static __init inline bool
+horrible_match_v6(const struct horrible_allowedips_node *node,
+		  struct in6_addr *ip)
+{
+	return (ip->in6_u.u6_addr32[0] & node->mask.ip6[0]) ==
+		       node->ip.ip6[0] &&
+	       (ip->in6_u.u6_addr32[1] & node->mask.ip6[1]) ==
+		       node->ip.ip6[1] &&
+	       (ip->in6_u.u6_addr32[2] & node->mask.ip6[2]) ==
+		       node->ip.ip6[2] &&
+	       (ip->in6_u.u6_addr32[3] & node->mask.ip6[3]) == node->ip.ip6[3];
+}
+
+static __init void
+horrible_insert_ordered(struct horrible_allowedips *table,
+			struct horrible_allowedips_node *node)
+{
+	struct horrible_allowedips_node *other = NULL, *where = NULL;
+	u8 my_cidr = horrible_mask_to_cidr(node->mask);
+
+	hlist_for_each_entry(other, &table->head, table) {
+		if (!memcmp(&other->mask, &node->mask,
+			    sizeof(union nf_inet_addr)) &&
+		    !memcmp(&other->ip, &node->ip,
+			    sizeof(union nf_inet_addr)) &&
+		    other->ip_version == node->ip_version) {
+			other->value = node->value;
+			kfree(node);
+			return;
+		}
+		where = other;
+		if (horrible_mask_to_cidr(other->mask) <= my_cidr)
+			break;
+	}
+	if (!other && !where)
+		hlist_add_head(&node->table, &table->head);
+	else if (!other)
+		hlist_add_behind(&node->table, &where->table);
+	else
+		hlist_add_before(&node->table, &where->table);
+}
+
+static __init int
+horrible_allowedips_insert_v4(struct horrible_allowedips *table,
+			      struct in_addr *ip, u8 cidr, void *value)
+{
+	struct horrible_allowedips_node *node = kzalloc(sizeof(*node),
+							GFP_KERNEL);
+
+	if (unlikely(!node))
+		return -ENOMEM;
+	node->ip.in = *ip;
+	node->mask = horrible_cidr_to_mask(cidr);
+	node->ip_version = 4;
+	node->value = value;
+	horrible_mask_self(node);
+	horrible_insert_ordered(table, node);
+	return 0;
+}
+
+static __init int
+horrible_allowedips_insert_v6(struct horrible_allowedips *table,
+			      struct in6_addr *ip, u8 cidr, void *value)
+{
+	struct horrible_allowedips_node *node = kzalloc(sizeof(*node),
+							GFP_KERNEL);
+
+	if (unlikely(!node))
+		return -ENOMEM;
+	node->ip.in6 = *ip;
+	node->mask = horrible_cidr_to_mask(cidr);
+	node->ip_version = 6;
+	node->value = value;
+	horrible_mask_self(node);
+	horrible_insert_ordered(table, node);
+	return 0;
+}
+
+static __init void *
+horrible_allowedips_lookup_v4(struct horrible_allowedips *table,
+			      struct in_addr *ip)
+{
+	struct horrible_allowedips_node *node;
+	void *ret = NULL;
+
+	hlist_for_each_entry(node, &table->head, table) {
+		if (node->ip_version != 4)
+			continue;
+		if (horrible_match_v4(node, ip)) {
+			ret = node->value;
+			break;
+		}
+	}
+	return ret;
+}
+
+static __init void *
+horrible_allowedips_lookup_v6(struct horrible_allowedips *table,
+			      struct in6_addr *ip)
+{
+	struct horrible_allowedips_node *node;
+	void *ret = NULL;
+
+	hlist_for_each_entry(node, &table->head, table) {
+		if (node->ip_version != 6)
+			continue;
+		if (horrible_match_v6(node, ip)) {
+			ret = node->value;
+			break;
+		}
+	}
+	return ret;
+}
+
+static __init bool randomized_test(void)
+{
+	unsigned int i, j, k, mutate_amount, cidr;
+	u8 ip[16], mutate_mask[16], mutated[16];
+	struct wg_peer **peers, *peer;
+	struct horrible_allowedips h;
+	DEFINE_MUTEX(mutex);
+	struct allowedips t;
+	bool ret = false;
+
+	mutex_init(&mutex);
+
+	wg_allowedips_init(&t);
+	horrible_allowedips_init(&h);
+
+	peers = kcalloc(NUM_PEERS, sizeof(*peers), GFP_KERNEL);
+	if (unlikely(!peers)) {
+		pr_err("allowedips random self-test malloc: FAIL\n");
+		goto free;
+	}
+	for (i = 0; i < NUM_PEERS; ++i) {
+		peers[i] = kzalloc(sizeof(*peers[i]), GFP_KERNEL);
+		if (unlikely(!peers[i])) {
+			pr_err("allowedips random self-test malloc: FAIL\n");
+			goto free;
+		}
+		kref_init(&peers[i]->refcount);
+	}
+
+	mutex_lock(&mutex);
+
+	for (i = 0; i < NUM_RAND_ROUTES; ++i) {
+		prandom_bytes(ip, 4);
+		cidr = prandom_u32_max(32) + 1;
+		peer = peers[prandom_u32_max(NUM_PEERS)];
+		if (wg_allowedips_insert_v4(&t, (struct in_addr *)ip, cidr,
+					    peer, &mutex) < 0) {
+			pr_err("allowedips random self-test malloc: FAIL\n");
+			goto free_locked;
+		}
+		if (horrible_allowedips_insert_v4(&h, (struct in_addr *)ip,
+						  cidr, peer) < 0) {
+			pr_err("allowedips random self-test malloc: FAIL\n");
+			goto free_locked;
+		}
+		for (j = 0; j < NUM_MUTATED_ROUTES; ++j) {
+			memcpy(mutated, ip, 4);
+			prandom_bytes(mutate_mask, 4);
+			mutate_amount = prandom_u32_max(32);
+			for (k = 0; k < mutate_amount / 8; ++k)
+				mutate_mask[k] = 0xff;
+			mutate_mask[k] = 0xff
+					 << ((8 - (mutate_amount % 8)) % 8);
+			for (; k < 4; ++k)
+				mutate_mask[k] = 0;
+			for (k = 0; k < 4; ++k)
+				mutated[k] = (mutated[k] & mutate_mask[k]) |
+					     (~mutate_mask[k] &
+					      prandom_u32_max(256));
+			cidr = prandom_u32_max(32) + 1;
+			peer = peers[prandom_u32_max(NUM_PEERS)];
+			if (wg_allowedips_insert_v4(&t,
+						    (struct in_addr *)mutated,
+						    cidr, peer, &mutex) < 0) {
+				pr_err("allowedips random malloc: FAIL\n");
+				goto free_locked;
+			}
+			if (horrible_allowedips_insert_v4(&h,
+				(struct in_addr *)mutated, cidr, peer)) {
+				pr_err("allowedips random self-test malloc: FAIL\n");
+				goto free_locked;
+			}
+		}
+	}
+
+	for (i = 0; i < NUM_RAND_ROUTES; ++i) {
+		prandom_bytes(ip, 16);
+		cidr = prandom_u32_max(128) + 1;
+		peer = peers[prandom_u32_max(NUM_PEERS)];
+		if (wg_allowedips_insert_v6(&t, (struct in6_addr *)ip, cidr,
+					    peer, &mutex) < 0) {
+			pr_err("allowedips random self-test malloc: FAIL\n");
+			goto free_locked;
+		}
+		if (horrible_allowedips_insert_v6(&h, (struct in6_addr *)ip,
+						  cidr, peer) < 0) {
+			pr_err("allowedips random self-test malloc: FAIL\n");
+			goto free_locked;
+		}
+		for (j = 0; j < NUM_MUTATED_ROUTES; ++j) {
+			memcpy(mutated, ip, 16);
+			prandom_bytes(mutate_mask, 16);
+			mutate_amount = prandom_u32_max(128);
+			for (k = 0; k < mutate_amount / 8; ++k)
+				mutate_mask[k] = 0xff;
+			mutate_mask[k] = 0xff
+					 << ((8 - (mutate_amount % 8)) % 8);
+			for (; k < 4; ++k)
+				mutate_mask[k] = 0;
+			for (k = 0; k < 4; ++k)
+				mutated[k] = (mutated[k] & mutate_mask[k]) |
+					     (~mutate_mask[k] &
+					      prandom_u32_max(256));
+			cidr = prandom_u32_max(128) + 1;
+			peer = peers[prandom_u32_max(NUM_PEERS)];
+			if (wg_allowedips_insert_v6(&t,
+						    (struct in6_addr *)mutated,
+						    cidr, peer, &mutex) < 0) {
+				pr_err("allowedips random self-test malloc: FAIL\n");
+				goto free_locked;
+			}
+			if (horrible_allowedips_insert_v6(
+				    &h, (struct in6_addr *)mutated, cidr,
+				    peer)) {
+				pr_err("allowedips random self-test malloc: FAIL\n");
+				goto free_locked;
+			}
+		}
+	}
+
+	mutex_unlock(&mutex);
+
+	if (IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)) {
+		print_tree(t.root4, 32);
+		print_tree(t.root6, 128);
+	}
+
+	for (i = 0; i < NUM_QUERIES; ++i) {
+		prandom_bytes(ip, 4);
+		if (lookup(t.root4, 32, ip) !=
+		    horrible_allowedips_lookup_v4(&h, (struct in_addr *)ip)) {
+			pr_err("allowedips random self-test: FAIL\n");
+			goto free;
+		}
+	}
+
+	for (i = 0; i < NUM_QUERIES; ++i) {
+		prandom_bytes(ip, 16);
+		if (lookup(t.root6, 128, ip) !=
+		    horrible_allowedips_lookup_v6(&h, (struct in6_addr *)ip)) {
+			pr_err("allowedips random self-test: FAIL\n");
+			goto free;
+		}
+	}
+	ret = true;
+
+free:
+	mutex_lock(&mutex);
+free_locked:
+	wg_allowedips_free(&t, &mutex);
+	mutex_unlock(&mutex);
+	horrible_allowedips_free(&h);
+	if (peers) {
+		for (i = 0; i < NUM_PEERS; ++i)
+			kfree(peers[i]);
+	}
+	kfree(peers);
+	return ret;
+}
+
+static __init inline struct in_addr *ip4(u8 a, u8 b, u8 c, u8 d)
+{
+	static struct in_addr ip;
+	u8 *split = (u8 *)&ip;
+
+	split[0] = a;
+	split[1] = b;
+	split[2] = c;
+	split[3] = d;
+	return &ip;
+}
+
+static __init inline struct in6_addr *ip6(u32 a, u32 b, u32 c, u32 d)
+{
+	static struct in6_addr ip;
+	__be32 *split = (__be32 *)&ip;
+
+	split[0] = cpu_to_be32(a);
+	split[1] = cpu_to_be32(b);
+	split[2] = cpu_to_be32(c);
+	split[3] = cpu_to_be32(d);
+	return &ip;
+}
+
+static __init struct wg_peer *init_peer(void)
+{
+	struct wg_peer *peer = kzalloc(sizeof(*peer), GFP_KERNEL);
+
+	if (!peer)
+		return NULL;
+	kref_init(&peer->refcount);
+	INIT_LIST_HEAD(&peer->allowedips_list);
+	return peer;
+}
+
+#define insert(version, mem, ipa, ipb, ipc, ipd, cidr)                       \
+	wg_allowedips_insert_v##version(&t, ip##version(ipa, ipb, ipc, ipd), \
+					cidr, mem, &mutex)
+
+#define maybe_fail() do {                                               \
+		++i;                                                    \
+		if (!_s) {                                              \
+			pr_info("allowedips self-test %zu: FAIL\n", i); \
+			success = false;                                \
+		}                                                       \
+	} while (0)
+
+#define test(version, mem, ipa, ipb, ipc, ipd) do {                          \
+		bool _s = lookup(t.root##version, (version) == 4 ? 32 : 128, \
+				 ip##version(ipa, ipb, ipc, ipd)) == (mem);  \
+		maybe_fail();                                                \
+	} while (0)
+
+#define test_negative(version, mem, ipa, ipb, ipc, ipd) do {                 \
+		bool _s = lookup(t.root##version, (version) == 4 ? 32 : 128, \
+				 ip##version(ipa, ipb, ipc, ipd)) != (mem);  \
+		maybe_fail();                                                \
+	} while (0)
+
+#define test_boolean(cond) do {   \
+		bool _s = (cond); \
+		maybe_fail();     \
+	} while (0)
+
+bool __init wg_allowedips_selftest(void)
+{
+	bool found_a = false, found_b = false, found_c = false, found_d = false,
+	     found_e = false, found_other = false;
+	struct wg_peer *a = init_peer(), *b = init_peer(), *c = init_peer(),
+		       *d = init_peer(), *e = init_peer(), *f = init_peer(),
+		       *g = init_peer(), *h = init_peer();
+	struct allowedips_node *iter_node;
+	bool success = false;
+	struct allowedips t;
+	DEFINE_MUTEX(mutex);
+	struct in6_addr ip;
+	size_t i = 0, count = 0;
+	__be64 part;
+
+	mutex_init(&mutex);
+	mutex_lock(&mutex);
+	wg_allowedips_init(&t);
+
+	if (!a || !b || !c || !d || !e || !f || !g || !h) {
+		pr_err("allowedips self-test malloc: FAIL\n");
+		goto free;
+	}
+
+	insert(4, a, 192, 168, 4, 0, 24);
+	insert(4, b, 192, 168, 4, 4, 32);
+	insert(4, c, 192, 168, 0, 0, 16);
+	insert(4, d, 192, 95, 5, 64, 27);
+	/* replaces previous entry, and maskself is required */
+	insert(4, c, 192, 95, 5, 65, 27);
+	insert(6, d, 0x26075300, 0x60006b00, 0, 0xc05f0543, 128);
+	insert(6, c, 0x26075300, 0x60006b00, 0, 0, 64);
+	insert(4, e, 0, 0, 0, 0, 0);
+	insert(6, e, 0, 0, 0, 0, 0);
+	/* replaces previous entry */
+	insert(6, f, 0, 0, 0, 0, 0);
+	insert(6, g, 0x24046800, 0, 0, 0, 32);
+	/* maskself is required */
+	insert(6, h, 0x24046800, 0x40040800, 0xdeadbeef, 0xdeadbeef, 64);
+	insert(6, a, 0x24046800, 0x40040800, 0xdeadbeef, 0xdeadbeef, 128);
+	insert(6, c, 0x24446800, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128);
+	insert(6, b, 0x24446800, 0xf0e40800, 0xeeaebeef, 0, 98);
+	insert(4, g, 64, 15, 112, 0, 20);
+	/* maskself is required */
+	insert(4, h, 64, 15, 123, 211, 25);
+	insert(4, a, 10, 0, 0, 0, 25);
+	insert(4, b, 10, 0, 0, 128, 25);
+	insert(4, a, 10, 1, 0, 0, 30);
+	insert(4, b, 10, 1, 0, 4, 30);
+	insert(4, c, 10, 1, 0, 8, 29);
+	insert(4, d, 10, 1, 0, 16, 29);
+
+	if (IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)) {
+		print_tree(t.root4, 32);
+		print_tree(t.root6, 128);
+	}
+
+	success = true;
+
+	test(4, a, 192, 168, 4, 20);
+	test(4, a, 192, 168, 4, 0);
+	test(4, b, 192, 168, 4, 4);
+	test(4, c, 192, 168, 200, 182);
+	test(4, c, 192, 95, 5, 68);
+	test(4, e, 192, 95, 5, 96);
+	test(6, d, 0x26075300, 0x60006b00, 0, 0xc05f0543);
+	test(6, c, 0x26075300, 0x60006b00, 0, 0xc02e01ee);
+	test(6, f, 0x26075300, 0x60006b01, 0, 0);
+	test(6, g, 0x24046800, 0x40040806, 0, 0x1006);
+	test(6, g, 0x24046800, 0x40040806, 0x1234, 0x5678);
+	test(6, f, 0x240467ff, 0x40040806, 0x1234, 0x5678);
+	test(6, f, 0x24046801, 0x40040806, 0x1234, 0x5678);
+	test(6, h, 0x24046800, 0x40040800, 0x1234, 0x5678);
+	test(6, h, 0x24046800, 0x40040800, 0, 0);
+	test(6, h, 0x24046800, 0x40040800, 0x10101010, 0x10101010);
+	test(6, a, 0x24046800, 0x40040800, 0xdeadbeef, 0xdeadbeef);
+	test(4, g, 64, 15, 116, 26);
+	test(4, g, 64, 15, 127, 3);
+	test(4, g, 64, 15, 123, 1);
+	test(4, h, 64, 15, 123, 128);
+	test(4, h, 64, 15, 123, 129);
+	test(4, a, 10, 0, 0, 52);
+	test(4, b, 10, 0, 0, 220);
+	test(4, a, 10, 1, 0, 2);
+	test(4, b, 10, 1, 0, 6);
+	test(4, c, 10, 1, 0, 10);
+	test(4, d, 10, 1, 0, 20);
+
+	insert(4, a, 1, 0, 0, 0, 32);
+	insert(4, a, 64, 0, 0, 0, 32);
+	insert(4, a, 128, 0, 0, 0, 32);
+	insert(4, a, 192, 0, 0, 0, 32);
+	insert(4, a, 255, 0, 0, 0, 32);
+	wg_allowedips_remove_by_peer(&t, a, &mutex);
+	test_negative(4, a, 1, 0, 0, 0);
+	test_negative(4, a, 64, 0, 0, 0);
+	test_negative(4, a, 128, 0, 0, 0);
+	test_negative(4, a, 192, 0, 0, 0);
+	test_negative(4, a, 255, 0, 0, 0);
+
+	wg_allowedips_free(&t, &mutex);
+	wg_allowedips_init(&t);
+	insert(4, a, 192, 168, 0, 0, 16);
+	insert(4, a, 192, 168, 0, 0, 24);
+	wg_allowedips_remove_by_peer(&t, a, &mutex);
+	test_negative(4, a, 192, 168, 0, 1);
+
+	/* These will hit the WARN_ON(len >= 128) in free_node if something
+	 * goes wrong.
+	 */
+	for (i = 0; i < 128; ++i) {
+		part = cpu_to_be64(~(1LLU << (i % 64)));
+		memset(&ip, 0xff, 16);
+		memcpy((u8 *)&ip + (i < 64) * 8, &part, 8);
+		wg_allowedips_insert_v6(&t, &ip, 128, a, &mutex);
+	}
+
+	wg_allowedips_free(&t, &mutex);
+
+	wg_allowedips_init(&t);
+	insert(4, a, 192, 95, 5, 93, 27);
+	insert(6, a, 0x26075300, 0x60006b00, 0, 0xc05f0543, 128);
+	insert(4, a, 10, 1, 0, 20, 29);
+	insert(6, a, 0x26075300, 0x6d8a6bf8, 0xdab1f1df, 0xc05f1523, 83);
+	insert(6, a, 0x26075300, 0x6d8a6bf8, 0xdab1f1df, 0xc05f1523, 21);
+	list_for_each_entry(iter_node, &a->allowedips_list, peer_list) {
+		u8 cidr, ip[16] __aligned(__alignof(u64));
+		int family = wg_allowedips_read_node(iter_node, ip, &cidr);
+
+		count++;
+
+		if (cidr == 27 && family == AF_INET &&
+		    !memcmp(ip, ip4(192, 95, 5, 64), sizeof(struct in_addr)))
+			found_a = true;
+		else if (cidr == 128 && family == AF_INET6 &&
+			 !memcmp(ip, ip6(0x26075300, 0x60006b00, 0, 0xc05f0543),
+				 sizeof(struct in6_addr)))
+			found_b = true;
+		else if (cidr == 29 && family == AF_INET &&
+			 !memcmp(ip, ip4(10, 1, 0, 16), sizeof(struct in_addr)))
+			found_c = true;
+		else if (cidr == 83 && family == AF_INET6 &&
+			 !memcmp(ip, ip6(0x26075300, 0x6d8a6bf8, 0xdab1e000, 0),
+				 sizeof(struct in6_addr)))
+			found_d = true;
+		else if (cidr == 21 && family == AF_INET6 &&
+			 !memcmp(ip, ip6(0x26075000, 0, 0, 0),
+				 sizeof(struct in6_addr)))
+			found_e = true;
+		else
+			found_other = true;
+	}
+	test_boolean(count == 5);
+	test_boolean(found_a);
+	test_boolean(found_b);
+	test_boolean(found_c);
+	test_boolean(found_d);
+	test_boolean(found_e);
+	test_boolean(!found_other);
+
+	if (IS_ENABLED(DEBUG_RANDOM_TRIE) && success)
+		success = randomized_test();
+
+	if (success)
+		pr_info("allowedips self-tests: pass\n");
+
+free:
+	wg_allowedips_free(&t, &mutex);
+	kfree(a);
+	kfree(b);
+	kfree(c);
+	kfree(d);
+	kfree(e);
+	kfree(f);
+	kfree(g);
+	kfree(h);
+	mutex_unlock(&mutex);
+
+	return success;
+}
+
+#undef test_negative
+#undef test
+#undef remove
+#undef insert
+#undef init_peer
+
+#endif
diff --git a/drivers/net/wireguard/selftest/counter.c b/drivers/net/wireguard/selftest/counter.c
new file mode 100644
index 000000000000..f4fbb9072ed7
--- /dev/null
+++ b/drivers/net/wireguard/selftest/counter.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifdef DEBUG
+bool __init wg_packet_counter_selftest(void)
+{
+	unsigned int test_num = 0, i;
+	union noise_counter counter;
+	bool success = true;
+
+#define T_INIT do {                                               \
+		memset(&counter, 0, sizeof(union noise_counter)); \
+		spin_lock_init(&counter.receive.lock);            \
+	} while (0)
+#define T_LIM (COUNTER_WINDOW_SIZE + 1)
+#define T(n, v) do {                                                  \
+		++test_num;                                           \
+		if (counter_validate(&counter, n) != (v)) {           \
+			pr_err("nonce counter self-test %u: FAIL\n",  \
+			       test_num);                             \
+			success = false;                              \
+		}                                                     \
+	} while (0)
+
+	T_INIT;
+	/*  1 */ T(0, true);
+	/*  2 */ T(1, true);
+	/*  3 */ T(1, false);
+	/*  4 */ T(9, true);
+	/*  5 */ T(8, true);
+	/*  6 */ T(7, true);
+	/*  7 */ T(7, false);
+	/*  8 */ T(T_LIM, true);
+	/*  9 */ T(T_LIM - 1, true);
+	/* 10 */ T(T_LIM - 1, false);
+	/* 11 */ T(T_LIM - 2, true);
+	/* 12 */ T(2, true);
+	/* 13 */ T(2, false);
+	/* 14 */ T(T_LIM + 16, true);
+	/* 15 */ T(3, false);
+	/* 16 */ T(T_LIM + 16, false);
+	/* 17 */ T(T_LIM * 4, true);
+	/* 18 */ T(T_LIM * 4 - (T_LIM - 1), true);
+	/* 19 */ T(10, false);
+	/* 20 */ T(T_LIM * 4 - T_LIM, false);
+	/* 21 */ T(T_LIM * 4 - (T_LIM + 1), false);
+	/* 22 */ T(T_LIM * 4 - (T_LIM - 2), true);
+	/* 23 */ T(T_LIM * 4 + 1 - T_LIM, false);
+	/* 24 */ T(0, false);
+	/* 25 */ T(REJECT_AFTER_MESSAGES, false);
+	/* 26 */ T(REJECT_AFTER_MESSAGES - 1, true);
+	/* 27 */ T(REJECT_AFTER_MESSAGES, false);
+	/* 28 */ T(REJECT_AFTER_MESSAGES - 1, false);
+	/* 29 */ T(REJECT_AFTER_MESSAGES - 2, true);
+	/* 30 */ T(REJECT_AFTER_MESSAGES + 1, false);
+	/* 31 */ T(REJECT_AFTER_MESSAGES + 2, false);
+	/* 32 */ T(REJECT_AFTER_MESSAGES - 2, false);
+	/* 33 */ T(REJECT_AFTER_MESSAGES - 3, true);
+	/* 34 */ T(0, false);
+
+	T_INIT;
+	for (i = 1; i <= COUNTER_WINDOW_SIZE; ++i)
+		T(i, true);
+	T(0, true);
+	T(0, false);
+
+	T_INIT;
+	for (i = 2; i <= COUNTER_WINDOW_SIZE + 1; ++i)
+		T(i, true);
+	T(1, true);
+	T(0, false);
+
+	T_INIT;
+	for (i = COUNTER_WINDOW_SIZE + 1; i-- > 0;)
+		T(i, true);
+
+	T_INIT;
+	for (i = COUNTER_WINDOW_SIZE + 2; i-- > 1;)
+		T(i, true);
+	T(0, false);
+
+	T_INIT;
+	for (i = COUNTER_WINDOW_SIZE + 1; i-- > 1;)
+		T(i, true);
+	T(COUNTER_WINDOW_SIZE + 1, true);
+	T(0, false);
+
+	T_INIT;
+	for (i = COUNTER_WINDOW_SIZE + 1; i-- > 1;)
+		T(i, true);
+	T(0, true);
+	T(COUNTER_WINDOW_SIZE + 1, true);
+
+#undef T
+#undef T_LIM
+#undef T_INIT
+
+	if (success)
+		pr_info("nonce counter self-tests: pass\n");
+	return success;
+}
+#endif
diff --git a/drivers/net/wireguard/selftest/ratelimiter.c b/drivers/net/wireguard/selftest/ratelimiter.c
new file mode 100644
index 000000000000..bcd6462e4540
--- /dev/null
+++ b/drivers/net/wireguard/selftest/ratelimiter.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifdef DEBUG
+
+#include <linux/jiffies.h>
+
+static const struct {
+	bool result;
+	unsigned int msec_to_sleep_before;
+} expected_results[] __initconst = {
+	[0 ... PACKETS_BURSTABLE - 1] = { true, 0 },
+	[PACKETS_BURSTABLE] = { false, 0 },
+	[PACKETS_BURSTABLE + 1] = { true, MSEC_PER_SEC / PACKETS_PER_SECOND },
+	[PACKETS_BURSTABLE + 2] = { false, 0 },
+	[PACKETS_BURSTABLE + 3] = { true, (MSEC_PER_SEC / PACKETS_PER_SECOND) * 2 },
+	[PACKETS_BURSTABLE + 4] = { true, 0 },
+	[PACKETS_BURSTABLE + 5] = { false, 0 }
+};
+
+static __init unsigned int maximum_jiffies_at_index(int index)
+{
+	unsigned int total_msecs = 2 * MSEC_PER_SEC / PACKETS_PER_SECOND / 3;
+	int i;
+
+	for (i = 0; i <= index; ++i)
+		total_msecs += expected_results[i].msec_to_sleep_before;
+	return msecs_to_jiffies(total_msecs);
+}
+
+static __init int timings_test(struct sk_buff *skb4, struct iphdr *hdr4,
+			       struct sk_buff *skb6, struct ipv6hdr *hdr6,
+			       int *test)
+{
+	unsigned long loop_start_time;
+	int i;
+
+	wg_ratelimiter_gc_entries(NULL);
+	rcu_barrier();
+	loop_start_time = jiffies;
+
+	for (i = 0; i < ARRAY_SIZE(expected_results); ++i) {
+		if (expected_results[i].msec_to_sleep_before)
+			msleep(expected_results[i].msec_to_sleep_before);
+
+		if (time_is_before_jiffies(loop_start_time +
+					   maximum_jiffies_at_index(i)))
+			return -ETIMEDOUT;
+		if (wg_ratelimiter_allow(skb4, &init_net) !=
+					expected_results[i].result)
+			return -EXFULL;
+		++(*test);
+
+		hdr4->saddr = htonl(ntohl(hdr4->saddr) + i + 1);
+		if (time_is_before_jiffies(loop_start_time +
+					   maximum_jiffies_at_index(i)))
+			return -ETIMEDOUT;
+		if (!wg_ratelimiter_allow(skb4, &init_net))
+			return -EXFULL;
+		++(*test);
+
+		hdr4->saddr = htonl(ntohl(hdr4->saddr) - i - 1);
+
+#if IS_ENABLED(CONFIG_IPV6)
+		hdr6->saddr.in6_u.u6_addr32[2] = htonl(i);
+		hdr6->saddr.in6_u.u6_addr32[3] = htonl(i);
+		if (time_is_before_jiffies(loop_start_time +
+					   maximum_jiffies_at_index(i)))
+			return -ETIMEDOUT;
+		if (wg_ratelimiter_allow(skb6, &init_net) !=
+					expected_results[i].result)
+			return -EXFULL;
+		++(*test);
+
+		hdr6->saddr.in6_u.u6_addr32[0] =
+			htonl(ntohl(hdr6->saddr.in6_u.u6_addr32[0]) + i + 1);
+		if (time_is_before_jiffies(loop_start_time +
+					   maximum_jiffies_at_index(i)))
+			return -ETIMEDOUT;
+		if (!wg_ratelimiter_allow(skb6, &init_net))
+			return -EXFULL;
+		++(*test);
+
+		hdr6->saddr.in6_u.u6_addr32[0] =
+			htonl(ntohl(hdr6->saddr.in6_u.u6_addr32[0]) - i - 1);
+
+		if (time_is_before_jiffies(loop_start_time +
+					   maximum_jiffies_at_index(i)))
+			return -ETIMEDOUT;
+#endif
+	}
+	return 0;
+}
+
+static __init int capacity_test(struct sk_buff *skb4, struct iphdr *hdr4,
+				int *test)
+{
+	int i;
+
+	wg_ratelimiter_gc_entries(NULL);
+	rcu_barrier();
+
+	if (atomic_read(&total_entries))
+		return -EXFULL;
+	++(*test);
+
+	for (i = 0; i <= max_entries; ++i) {
+		hdr4->saddr = htonl(i);
+		if (wg_ratelimiter_allow(skb4, &init_net) != (i != max_entries))
+			return -EXFULL;
+		++(*test);
+	}
+	return 0;
+}
+
+bool __init wg_ratelimiter_selftest(void)
+{
+	enum { TRIALS_BEFORE_GIVING_UP = 5000 };
+	bool success = false;
+	int test = 0, trials;
+	struct sk_buff *skb4, *skb6;
+	struct iphdr *hdr4;
+	struct ipv6hdr *hdr6;
+
+	if (IS_ENABLED(CONFIG_KASAN) || IS_ENABLED(CONFIG_UBSAN))
+		return true;
+
+	BUILD_BUG_ON(MSEC_PER_SEC % PACKETS_PER_SECOND != 0);
+
+	if (wg_ratelimiter_init())
+		goto out;
+	++test;
+	if (wg_ratelimiter_init()) {
+		wg_ratelimiter_uninit();
+		goto out;
+	}
+	++test;
+	if (wg_ratelimiter_init()) {
+		wg_ratelimiter_uninit();
+		wg_ratelimiter_uninit();
+		goto out;
+	}
+	++test;
+
+	skb4 = alloc_skb(sizeof(struct iphdr), GFP_KERNEL);
+	if (unlikely(!skb4))
+		goto err_nofree;
+	skb4->protocol = htons(ETH_P_IP);
+	hdr4 = (struct iphdr *)skb_put(skb4, sizeof(*hdr4));
+	hdr4->saddr = htonl(8182);
+	skb_reset_network_header(skb4);
+	++test;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	skb6 = alloc_skb(sizeof(struct ipv6hdr), GFP_KERNEL);
+	if (unlikely(!skb6)) {
+		kfree_skb(skb4);
+		goto err_nofree;
+	}
+	skb6->protocol = htons(ETH_P_IPV6);
+	hdr6 = (struct ipv6hdr *)skb_put(skb6, sizeof(*hdr6));
+	hdr6->saddr.in6_u.u6_addr32[0] = htonl(1212);
+	hdr6->saddr.in6_u.u6_addr32[1] = htonl(289188);
+	skb_reset_network_header(skb6);
+	++test;
+#endif
+
+	for (trials = TRIALS_BEFORE_GIVING_UP;;) {
+		int test_count = 0, ret;
+
+		ret = timings_test(skb4, hdr4, skb6, hdr6, &test_count);
+		if (ret == -ETIMEDOUT) {
+			if (!trials--) {
+				test += test_count;
+				goto err;
+			}
+			msleep(500);
+			continue;
+		} else if (ret < 0) {
+			test += test_count;
+			goto err;
+		} else {
+			test += test_count;
+			break;
+		}
+	}
+
+	for (trials = TRIALS_BEFORE_GIVING_UP;;) {
+		int test_count = 0;
+
+		if (capacity_test(skb4, hdr4, &test_count) < 0) {
+			if (!trials--) {
+				test += test_count;
+				goto err;
+			}
+			msleep(50);
+			continue;
+		}
+		test += test_count;
+		break;
+	}
+
+	success = true;
+
+err:
+	kfree_skb(skb4);
+#if IS_ENABLED(CONFIG_IPV6)
+	kfree_skb(skb6);
+#endif
+err_nofree:
+	wg_ratelimiter_uninit();
+	wg_ratelimiter_uninit();
+	wg_ratelimiter_uninit();
+	/* Uninit one extra time to check underflow detection. */
+	wg_ratelimiter_uninit();
+out:
+	if (success)
+		pr_info("ratelimiter self-tests: pass\n");
+	else
+		pr_err("ratelimiter self-test %d: FAIL\n", test);
+
+	return success;
+}
+#endif
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
new file mode 100644
index 000000000000..e713841f6605
--- /dev/null
+++ b/drivers/net/wireguard/send.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "queueing.h"
+#include "timers.h"
+#include "device.h"
+#include "peer.h"
+#include "socket.h"
+#include "messages.h"
+#include "cookie.h"
+
+#include <linux/uio.h>
+#include <linux/inetdevice.h>
+#include <linux/socket.h>
+#include <net/ip_tunnels.h>
+#include <net/udp.h>
+#include <net/sock.h>
+
+static void wg_packet_send_handshake_initiation(struct wg_peer *peer)
+{
+	struct message_handshake_initiation packet;
+
+	if (!wg_birthdate_has_expired(atomic64_read(&peer->last_sent_handshake),
+				      REKEY_TIMEOUT))
+		return; /* This function is rate limited. */
+
+	atomic64_set(&peer->last_sent_handshake, ktime_get_coarse_boottime_ns());
+	net_dbg_ratelimited("%s: Sending handshake initiation to peer %llu (%pISpfsc)\n",
+			    peer->device->dev->name, peer->internal_id,
+			    &peer->endpoint.addr);
+
+	if (wg_noise_handshake_create_initiation(&packet, &peer->handshake)) {
+		wg_cookie_add_mac_to_packet(&packet, sizeof(packet), peer);
+		wg_timers_any_authenticated_packet_traversal(peer);
+		wg_timers_any_authenticated_packet_sent(peer);
+		atomic64_set(&peer->last_sent_handshake,
+			     ktime_get_coarse_boottime_ns());
+		wg_socket_send_buffer_to_peer(peer, &packet, sizeof(packet),
+					      HANDSHAKE_DSCP);
+		wg_timers_handshake_initiated(peer);
+	}
+}
+
+void wg_packet_handshake_send_worker(struct work_struct *work)
+{
+	struct wg_peer *peer = container_of(work, struct wg_peer,
+					    transmit_handshake_work);
+
+	wg_packet_send_handshake_initiation(peer);
+	wg_peer_put(peer);
+}
+
+void wg_packet_send_queued_handshake_initiation(struct wg_peer *peer,
+						bool is_retry)
+{
+	if (!is_retry)
+		peer->timer_handshake_attempts = 0;
+
+	rcu_read_lock_bh();
+	/* We check last_sent_handshake here in addition to the actual function
+	 * we're queueing up, so that we don't queue things if not strictly
+	 * necessary:
+	 */
+	if (!wg_birthdate_has_expired(atomic64_read(&peer->last_sent_handshake),
+				      REKEY_TIMEOUT) ||
+			unlikely(READ_ONCE(peer->is_dead)))
+		goto out;
+
+	wg_peer_get(peer);
+	/* Queues up calling packet_send_queued_handshakes(peer), where we do a
+	 * peer_put(peer) after:
+	 */
+	if (!queue_work(peer->device->handshake_send_wq,
+			&peer->transmit_handshake_work))
+		/* If the work was already queued, we want to drop the
+		 * extra reference:
+		 */
+		wg_peer_put(peer);
+out:
+	rcu_read_unlock_bh();
+}
+
+void wg_packet_send_handshake_response(struct wg_peer *peer)
+{
+	struct message_handshake_response packet;
+
+	atomic64_set(&peer->last_sent_handshake, ktime_get_coarse_boottime_ns());
+	net_dbg_ratelimited("%s: Sending handshake response to peer %llu (%pISpfsc)\n",
+			    peer->device->dev->name, peer->internal_id,
+			    &peer->endpoint.addr);
+
+	if (wg_noise_handshake_create_response(&packet, &peer->handshake)) {
+		wg_cookie_add_mac_to_packet(&packet, sizeof(packet), peer);
+		if (wg_noise_handshake_begin_session(&peer->handshake,
+						     &peer->keypairs)) {
+			wg_timers_session_derived(peer);
+			wg_timers_any_authenticated_packet_traversal(peer);
+			wg_timers_any_authenticated_packet_sent(peer);
+			atomic64_set(&peer->last_sent_handshake,
+				     ktime_get_coarse_boottime_ns());
+			wg_socket_send_buffer_to_peer(peer, &packet,
+						      sizeof(packet),
+						      HANDSHAKE_DSCP);
+		}
+	}
+}
+
+void wg_packet_send_handshake_cookie(struct wg_device *wg,
+				     struct sk_buff *initiating_skb,
+				     __le32 sender_index)
+{
+	struct message_handshake_cookie packet;
+
+	net_dbg_skb_ratelimited("%s: Sending cookie response for denied handshake message for %pISpfsc\n",
+				wg->dev->name, initiating_skb);
+	wg_cookie_message_create(&packet, initiating_skb, sender_index,
+				 &wg->cookie_checker);
+	wg_socket_send_buffer_as_reply_to_skb(wg, initiating_skb, &packet,
+					      sizeof(packet));
+}
+
+static void keep_key_fresh(struct wg_peer *peer)
+{
+	struct noise_keypair *keypair;
+	bool send = false;
+
+	rcu_read_lock_bh();
+	keypair = rcu_dereference_bh(peer->keypairs.current_keypair);
+	if (likely(keypair && READ_ONCE(keypair->sending.is_valid)) &&
+	    (unlikely(atomic64_read(&keypair->sending.counter.counter) >
+		      REKEY_AFTER_MESSAGES) ||
+	     (keypair->i_am_the_initiator &&
+	      unlikely(wg_birthdate_has_expired(keypair->sending.birthdate,
+						REKEY_AFTER_TIME)))))
+		send = true;
+	rcu_read_unlock_bh();
+
+	if (send)
+		wg_packet_send_queued_handshake_initiation(peer, false);
+}
+
+static unsigned int calculate_skb_padding(struct sk_buff *skb)
+{
+	/* We do this modulo business with the MTU, just in case the networking
+	 * layer gives us a packet that's bigger than the MTU. In that case, we
+	 * wouldn't want the final subtraction to overflow in the case of the
+	 * padded_size being clamped.
+	 */
+	unsigned int last_unit = skb->len % PACKET_CB(skb)->mtu;
+	unsigned int padded_size = ALIGN(last_unit, MESSAGE_PADDING_MULTIPLE);
+
+	if (padded_size > PACKET_CB(skb)->mtu)
+		padded_size = PACKET_CB(skb)->mtu;
+	return padded_size - last_unit;
+}
+
+static bool encrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
+{
+	unsigned int padding_len, plaintext_len, trailer_len;
+	struct scatterlist sg[MAX_SKB_FRAGS + 8];
+	struct message_data *header;
+	struct sk_buff *trailer;
+	int num_frags;
+
+	/* Calculate lengths. */
+	padding_len = calculate_skb_padding(skb);
+	trailer_len = padding_len + noise_encrypted_len(0);
+	plaintext_len = skb->len + padding_len;
+
+	/* Expand data section to have room for padding and auth tag. */
+	num_frags = skb_cow_data(skb, trailer_len, &trailer);
+	if (unlikely(num_frags < 0 || num_frags > ARRAY_SIZE(sg)))
+		return false;
+
+	/* Set the padding to zeros, and make sure it and the auth tag are part
+	 * of the skb.
+	 */
+	memset(skb_tail_pointer(trailer), 0, padding_len);
+
+	/* Expand head section to have room for our header and the network
+	 * stack's headers.
+	 */
+	if (unlikely(skb_cow_head(skb, DATA_PACKET_HEAD_ROOM) < 0))
+		return false;
+
+	/* Finalize checksum calculation for the inner packet, if required. */
+	if (unlikely(skb->ip_summed == CHECKSUM_PARTIAL &&
+		     skb_checksum_help(skb)))
+		return false;
+
+	/* Only after checksumming can we safely add on the padding at the end
+	 * and the header.
+	 */
+	skb_set_inner_network_header(skb, 0);
+	header = (struct message_data *)skb_push(skb, sizeof(*header));
+	header->header.type = cpu_to_le32(MESSAGE_DATA);
+	header->key_idx = keypair->remote_index;
+	header->counter = cpu_to_le64(PACKET_CB(skb)->nonce);
+	pskb_put(skb, trailer, trailer_len);
+
+	/* Now we can encrypt the scattergather segments */
+	sg_init_table(sg, num_frags);
+	if (skb_to_sgvec(skb, sg, sizeof(struct message_data),
+			 noise_encrypted_len(plaintext_len)) <= 0)
+		return false;
+	return chacha20poly1305_encrypt_sg_inplace(sg, plaintext_len, NULL, 0,
+						   PACKET_CB(skb)->nonce,
+						   keypair->sending.key);
+}
+
+void wg_packet_send_keepalive(struct wg_peer *peer)
+{
+	struct sk_buff *skb;
+
+	if (skb_queue_empty(&peer->staged_packet_queue)) {
+		skb = alloc_skb(DATA_PACKET_HEAD_ROOM + MESSAGE_MINIMUM_LENGTH,
+				GFP_ATOMIC);
+		if (unlikely(!skb))
+			return;
+		skb_reserve(skb, DATA_PACKET_HEAD_ROOM);
+		skb->dev = peer->device->dev;
+		PACKET_CB(skb)->mtu = skb->dev->mtu;
+		skb_queue_tail(&peer->staged_packet_queue, skb);
+		net_dbg_ratelimited("%s: Sending keepalive packet to peer %llu (%pISpfsc)\n",
+				    peer->device->dev->name, peer->internal_id,
+				    &peer->endpoint.addr);
+	}
+
+	wg_packet_send_staged_packets(peer);
+}
+
+#define skb_walk_null_queue_safe(first, skb, next)                             \
+	for (skb = first, next = skb->next; skb;                               \
+	     skb = next, next = skb ? skb->next : NULL)
+static void skb_free_null_queue(struct sk_buff *first)
+{
+	struct sk_buff *skb, *next;
+
+	skb_walk_null_queue_safe(first, skb, next)
+		dev_kfree_skb(skb);
+}
+
+static void wg_packet_create_data_done(struct sk_buff *first,
+				       struct wg_peer *peer)
+{
+	struct sk_buff *skb, *next;
+	bool is_keepalive, data_sent = false;
+
+	wg_timers_any_authenticated_packet_traversal(peer);
+	wg_timers_any_authenticated_packet_sent(peer);
+	skb_walk_null_queue_safe(first, skb, next) {
+		is_keepalive = skb->len == message_data_len(0);
+		if (likely(!wg_socket_send_skb_to_peer(peer, skb,
+				PACKET_CB(skb)->ds) && !is_keepalive))
+			data_sent = true;
+	}
+
+	if (likely(data_sent))
+		wg_timers_data_sent(peer);
+
+	keep_key_fresh(peer);
+}
+
+void wg_packet_tx_worker(struct work_struct *work)
+{
+	struct crypt_queue *queue = container_of(work, struct crypt_queue,
+						 work);
+	struct noise_keypair *keypair;
+	enum packet_state state;
+	struct sk_buff *first;
+	struct wg_peer *peer;
+
+	while ((first = __ptr_ring_peek(&queue->ring)) != NULL &&
+	       (state = atomic_read_acquire(&PACKET_CB(first)->state)) !=
+		       PACKET_STATE_UNCRYPTED) {
+		__ptr_ring_discard_one(&queue->ring);
+		peer = PACKET_PEER(first);
+		keypair = PACKET_CB(first)->keypair;
+
+		if (likely(state == PACKET_STATE_CRYPTED))
+			wg_packet_create_data_done(first, peer);
+		else
+			skb_free_null_queue(first);
+
+		wg_noise_keypair_put(keypair, false);
+		wg_peer_put(peer);
+	}
+}
+
+void wg_packet_encrypt_worker(struct work_struct *work)
+{
+	struct crypt_queue *queue = container_of(work, struct multicore_worker,
+						 work)->ptr;
+	struct sk_buff *first, *skb, *next;
+
+	while ((first = ptr_ring_consume_bh(&queue->ring)) != NULL) {
+		enum packet_state state = PACKET_STATE_CRYPTED;
+
+		skb_walk_null_queue_safe(first, skb, next) {
+			if (likely(encrypt_packet(skb,
+					PACKET_CB(first)->keypair))) {
+				wg_reset_packet(skb);
+			} else {
+				state = PACKET_STATE_DEAD;
+				break;
+			}
+		}
+		wg_queue_enqueue_per_peer(&PACKET_PEER(first)->tx_queue, first,
+					  state);
+
+	}
+}
+
+static void wg_packet_create_data(struct sk_buff *first)
+{
+	struct wg_peer *peer = PACKET_PEER(first);
+	struct wg_device *wg = peer->device;
+	int ret = -EINVAL;
+
+	rcu_read_lock_bh();
+	if (unlikely(READ_ONCE(peer->is_dead)))
+		goto err;
+
+	ret = wg_queue_enqueue_per_device_and_peer(&wg->encrypt_queue,
+						   &peer->tx_queue, first,
+						   wg->packet_crypt_wq,
+						   &wg->encrypt_queue.last_cpu);
+	if (unlikely(ret == -EPIPE))
+		wg_queue_enqueue_per_peer(&peer->tx_queue, first,
+					  PACKET_STATE_DEAD);
+err:
+	rcu_read_unlock_bh();
+	if (likely(!ret || ret == -EPIPE))
+		return;
+	wg_noise_keypair_put(PACKET_CB(first)->keypair, false);
+	wg_peer_put(peer);
+	skb_free_null_queue(first);
+}
+
+void wg_packet_purge_staged_packets(struct wg_peer *peer)
+{
+	spin_lock_bh(&peer->staged_packet_queue.lock);
+	peer->device->dev->stats.tx_dropped += peer->staged_packet_queue.qlen;
+	__skb_queue_purge(&peer->staged_packet_queue);
+	spin_unlock_bh(&peer->staged_packet_queue.lock);
+}
+
+void wg_packet_send_staged_packets(struct wg_peer *peer)
+{
+	struct noise_symmetric_key *key;
+	struct noise_keypair *keypair;
+	struct sk_buff_head packets;
+	struct sk_buff *skb;
+
+	/* Steal the current queue into our local one. */
+	__skb_queue_head_init(&packets);
+	spin_lock_bh(&peer->staged_packet_queue.lock);
+	skb_queue_splice_init(&peer->staged_packet_queue, &packets);
+	spin_unlock_bh(&peer->staged_packet_queue.lock);
+	if (unlikely(skb_queue_empty(&packets)))
+		return;
+
+	/* First we make sure we have a valid reference to a valid key. */
+	rcu_read_lock_bh();
+	keypair = wg_noise_keypair_get(
+		rcu_dereference_bh(peer->keypairs.current_keypair));
+	rcu_read_unlock_bh();
+	if (unlikely(!keypair))
+		goto out_nokey;
+	key = &keypair->sending;
+	if (unlikely(!READ_ONCE(key->is_valid)))
+		goto out_nokey;
+	if (unlikely(wg_birthdate_has_expired(key->birthdate,
+					      REJECT_AFTER_TIME)))
+		goto out_invalid;
+
+	/* After we know we have a somewhat valid key, we now try to assign
+	 * nonces to all of the packets in the queue. If we can't assign nonces
+	 * for all of them, we just consider it a failure and wait for the next
+	 * handshake.
+	 */
+	skb_queue_walk(&packets, skb) {
+		/* 0 for no outer TOS: no leak. TODO: at some later point, we
+		 * might consider using flowi->tos as outer instead.
+		 */
+		PACKET_CB(skb)->ds = ip_tunnel_ecn_encap(0, ip_hdr(skb), skb);
+		PACKET_CB(skb)->nonce =
+				atomic64_inc_return(&key->counter.counter) - 1;
+		if (unlikely(PACKET_CB(skb)->nonce >= REJECT_AFTER_MESSAGES))
+			goto out_invalid;
+	}
+
+	packets.prev->next = NULL;
+	wg_peer_get(keypair->entry.peer);
+	PACKET_CB(packets.next)->keypair = keypair;
+	wg_packet_create_data(packets.next);
+	return;
+
+out_invalid:
+	WRITE_ONCE(key->is_valid, false);
+out_nokey:
+	wg_noise_keypair_put(keypair, false);
+
+	/* We orphan the packets if we're waiting on a handshake, so that they
+	 * don't block a socket's pool.
+	 */
+	skb_queue_walk(&packets, skb)
+		skb_orphan(skb);
+	/* Then we put them back on the top of the queue. We're not too
+	 * concerned about accidentally getting things a little out of order if
+	 * packets are being added really fast, because this queue is for before
+	 * packets can even be sent and it's small anyway.
+	 */
+	spin_lock_bh(&peer->staged_packet_queue.lock);
+	skb_queue_splice(&packets, &peer->staged_packet_queue);
+	spin_unlock_bh(&peer->staged_packet_queue.lock);
+
+	/* If we're exiting because there's something wrong with the key, it
+	 * means we should initiate a new handshake.
+	 */
+	wg_packet_send_queued_handshake_initiation(peer, false);
+}
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
new file mode 100644
index 000000000000..f9a06a35b91b
--- /dev/null
+++ b/drivers/net/wireguard/socket.c
@@ -0,0 +1,436 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "device.h"
+#include "peer.h"
+#include "socket.h"
+#include "queueing.h"
+#include "messages.h"
+
+#include <linux/ctype.h>
+#include <linux/net.h>
+#include <linux/if_vlan.h>
+#include <linux/if_ether.h>
+#include <linux/inetdevice.h>
+#include <net/udp_tunnel.h>
+#include <net/ipv6.h>
+
+static int send4(struct wg_device *wg, struct sk_buff *skb,
+		 struct endpoint *endpoint, u8 ds, struct dst_cache *cache)
+{
+	struct flowi4 fl = {
+		.saddr = endpoint->src4.s_addr,
+		.daddr = endpoint->addr4.sin_addr.s_addr,
+		.fl4_dport = endpoint->addr4.sin_port,
+		.flowi4_mark = wg->fwmark,
+		.flowi4_proto = IPPROTO_UDP
+	};
+	struct rtable *rt = NULL;
+	struct sock *sock;
+	int ret = 0;
+
+	skb->next = skb->prev = NULL;
+	skb->dev = wg->dev;
+	skb->mark = wg->fwmark;
+
+	rcu_read_lock_bh();
+	sock = rcu_dereference_bh(wg->sock4);
+
+	if (unlikely(!sock)) {
+		ret = -ENONET;
+		goto err;
+	}
+
+	fl.fl4_sport = inet_sk(sock)->inet_sport;
+
+	if (cache)
+		rt = dst_cache_get_ip4(cache, &fl.saddr);
+
+	if (!rt) {
+		security_sk_classify_flow(sock, flowi4_to_flowi(&fl));
+		if (unlikely(!inet_confirm_addr(sock_net(sock), NULL, 0,
+						fl.saddr, RT_SCOPE_HOST))) {
+			endpoint->src4.s_addr = 0;
+			*(__force __be32 *)&endpoint->src_if4 = 0;
+			fl.saddr = 0;
+			if (cache)
+				dst_cache_reset(cache);
+		}
+		rt = ip_route_output_flow(sock_net(sock), &fl, sock);
+		if (unlikely(endpoint->src_if4 && ((IS_ERR(rt) &&
+			     PTR_ERR(rt) == -EINVAL) || (!IS_ERR(rt) &&
+			     rt->dst.dev->ifindex != endpoint->src_if4)))) {
+			endpoint->src4.s_addr = 0;
+			*(__force __be32 *)&endpoint->src_if4 = 0;
+			fl.saddr = 0;
+			if (cache)
+				dst_cache_reset(cache);
+			if (!IS_ERR(rt))
+				ip_rt_put(rt);
+			rt = ip_route_output_flow(sock_net(sock), &fl, sock);
+		}
+		if (unlikely(IS_ERR(rt))) {
+			ret = PTR_ERR(rt);
+			net_dbg_ratelimited("%s: No route to %pISpfsc, error %d\n",
+					    wg->dev->name, &endpoint->addr, ret);
+			goto err;
+		} else if (unlikely(rt->dst.dev == skb->dev)) {
+			ip_rt_put(rt);
+			ret = -ELOOP;
+			net_dbg_ratelimited("%s: Avoiding routing loop to %pISpfsc\n",
+					    wg->dev->name, &endpoint->addr);
+			goto err;
+		}
+		if (cache)
+			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	}
+
+	skb->ignore_df = 1;
+	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
+			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
+			    fl.fl4_dport, false, false);
+	goto out;
+
+err:
+	kfree_skb(skb);
+out:
+	rcu_read_unlock_bh();
+	return ret;
+}
+
+static int send6(struct wg_device *wg, struct sk_buff *skb,
+		 struct endpoint *endpoint, u8 ds, struct dst_cache *cache)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct flowi6 fl = {
+		.saddr = endpoint->src6,
+		.daddr = endpoint->addr6.sin6_addr,
+		.fl6_dport = endpoint->addr6.sin6_port,
+		.flowi6_mark = wg->fwmark,
+		.flowi6_oif = endpoint->addr6.sin6_scope_id,
+		.flowi6_proto = IPPROTO_UDP
+		/* TODO: addr->sin6_flowinfo */
+	};
+	struct dst_entry *dst = NULL;
+	struct sock *sock;
+	int ret = 0;
+
+	skb->next = skb->prev = NULL;
+	skb->dev = wg->dev;
+	skb->mark = wg->fwmark;
+
+	rcu_read_lock_bh();
+	sock = rcu_dereference_bh(wg->sock6);
+
+	if (unlikely(!sock)) {
+		ret = -ENONET;
+		goto err;
+	}
+
+	fl.fl6_sport = inet_sk(sock)->inet_sport;
+
+	if (cache)
+		dst = dst_cache_get_ip6(cache, &fl.saddr);
+
+	if (!dst) {
+		security_sk_classify_flow(sock, flowi6_to_flowi(&fl));
+		if (unlikely(!ipv6_addr_any(&fl.saddr) &&
+			     !ipv6_chk_addr(sock_net(sock), &fl.saddr, NULL, 0))) {
+			endpoint->src6 = fl.saddr = in6addr_any;
+			if (cache)
+				dst_cache_reset(cache);
+		}
+		ret = ipv6_stub->ipv6_dst_lookup(sock_net(sock), sock, &dst,
+						 &fl);
+		if (unlikely(ret)) {
+			net_dbg_ratelimited("%s: No route to %pISpfsc, error %d\n",
+					    wg->dev->name, &endpoint->addr, ret);
+			goto err;
+		} else if (unlikely(dst->dev == skb->dev)) {
+			dst_release(dst);
+			ret = -ELOOP;
+			net_dbg_ratelimited("%s: Avoiding routing loop to %pISpfsc\n",
+					    wg->dev->name, &endpoint->addr);
+			goto err;
+		}
+		if (cache)
+			dst_cache_set_ip6(cache, dst, &fl.saddr);
+	}
+
+	skb->ignore_df = 1;
+	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
+			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
+			     fl.fl6_dport, false);
+	goto out;
+
+err:
+	kfree_skb(skb);
+out:
+	rcu_read_unlock_bh();
+	return ret;
+#else
+	return -EAFNOSUPPORT;
+#endif
+}
+
+int wg_socket_send_skb_to_peer(struct wg_peer *peer, struct sk_buff *skb, u8 ds)
+{
+	size_t skb_len = skb->len;
+	int ret = -EAFNOSUPPORT;
+
+	read_lock_bh(&peer->endpoint_lock);
+	if (peer->endpoint.addr.sa_family == AF_INET)
+		ret = send4(peer->device, skb, &peer->endpoint, ds,
+			    &peer->endpoint_cache);
+	else if (peer->endpoint.addr.sa_family == AF_INET6)
+		ret = send6(peer->device, skb, &peer->endpoint, ds,
+			    &peer->endpoint_cache);
+	else
+		dev_kfree_skb(skb);
+	if (likely(!ret))
+		peer->tx_bytes += skb_len;
+	read_unlock_bh(&peer->endpoint_lock);
+
+	return ret;
+}
+
+int wg_socket_send_buffer_to_peer(struct wg_peer *peer, void *buffer,
+				  size_t len, u8 ds)
+{
+	struct sk_buff *skb = alloc_skb(len + SKB_HEADER_LEN, GFP_ATOMIC);
+
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	skb_reserve(skb, SKB_HEADER_LEN);
+	skb_set_inner_network_header(skb, 0);
+	skb_put_data(skb, buffer, len);
+	return wg_socket_send_skb_to_peer(peer, skb, ds);
+}
+
+int wg_socket_send_buffer_as_reply_to_skb(struct wg_device *wg,
+					  struct sk_buff *in_skb, void *buffer,
+					  size_t len)
+{
+	int ret = 0;
+	struct sk_buff *skb;
+	struct endpoint endpoint;
+
+	if (unlikely(!in_skb))
+		return -EINVAL;
+	ret = wg_socket_endpoint_from_skb(&endpoint, in_skb);
+	if (unlikely(ret < 0))
+		return ret;
+
+	skb = alloc_skb(len + SKB_HEADER_LEN, GFP_ATOMIC);
+	if (unlikely(!skb))
+		return -ENOMEM;
+	skb_reserve(skb, SKB_HEADER_LEN);
+	skb_set_inner_network_header(skb, 0);
+	skb_put_data(skb, buffer, len);
+
+	if (endpoint.addr.sa_family == AF_INET)
+		ret = send4(wg, skb, &endpoint, 0, NULL);
+	else if (endpoint.addr.sa_family == AF_INET6)
+		ret = send6(wg, skb, &endpoint, 0, NULL);
+	/* No other possibilities if the endpoint is valid, which it is,
+	 * as we checked above.
+	 */
+
+	return ret;
+}
+
+int wg_socket_endpoint_from_skb(struct endpoint *endpoint,
+				const struct sk_buff *skb)
+{
+	memset(endpoint, 0, sizeof(*endpoint));
+	if (skb->protocol == htons(ETH_P_IP)) {
+		endpoint->addr4.sin_family = AF_INET;
+		endpoint->addr4.sin_port = udp_hdr(skb)->source;
+		endpoint->addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
+		endpoint->src4.s_addr = ip_hdr(skb)->daddr;
+		endpoint->src_if4 = skb->skb_iif;
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		endpoint->addr6.sin6_family = AF_INET6;
+		endpoint->addr6.sin6_port = udp_hdr(skb)->source;
+		endpoint->addr6.sin6_addr = ipv6_hdr(skb)->saddr;
+		endpoint->addr6.sin6_scope_id = ipv6_iface_scope_id(
+			&ipv6_hdr(skb)->saddr, skb->skb_iif);
+		endpoint->src6 = ipv6_hdr(skb)->daddr;
+	} else {
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static bool endpoint_eq(const struct endpoint *a, const struct endpoint *b)
+{
+	return (a->addr.sa_family == AF_INET && b->addr.sa_family == AF_INET &&
+		a->addr4.sin_port == b->addr4.sin_port &&
+		a->addr4.sin_addr.s_addr == b->addr4.sin_addr.s_addr &&
+		a->src4.s_addr == b->src4.s_addr && a->src_if4 == b->src_if4) ||
+	       (a->addr.sa_family == AF_INET6 &&
+		b->addr.sa_family == AF_INET6 &&
+		a->addr6.sin6_port == b->addr6.sin6_port &&
+		ipv6_addr_equal(&a->addr6.sin6_addr, &b->addr6.sin6_addr) &&
+		a->addr6.sin6_scope_id == b->addr6.sin6_scope_id &&
+		ipv6_addr_equal(&a->src6, &b->src6)) ||
+	       unlikely(!a->addr.sa_family && !b->addr.sa_family);
+}
+
+void wg_socket_set_peer_endpoint(struct wg_peer *peer,
+				 const struct endpoint *endpoint)
+{
+	/* First we check unlocked, in order to optimize, since it's pretty rare
+	 * that an endpoint will change. If we happen to be mid-write, and two
+	 * CPUs wind up writing the same thing or something slightly different,
+	 * it doesn't really matter much either.
+	 */
+	if (endpoint_eq(endpoint, &peer->endpoint))
+		return;
+	write_lock_bh(&peer->endpoint_lock);
+	if (endpoint->addr.sa_family == AF_INET) {
+		peer->endpoint.addr4 = endpoint->addr4;
+		peer->endpoint.src4 = endpoint->src4;
+		peer->endpoint.src_if4 = endpoint->src_if4;
+	} else if (endpoint->addr.sa_family == AF_INET6) {
+		peer->endpoint.addr6 = endpoint->addr6;
+		peer->endpoint.src6 = endpoint->src6;
+	} else {
+		goto out;
+	}
+	dst_cache_reset(&peer->endpoint_cache);
+out:
+	write_unlock_bh(&peer->endpoint_lock);
+}
+
+void wg_socket_set_peer_endpoint_from_skb(struct wg_peer *peer,
+					  const struct sk_buff *skb)
+{
+	struct endpoint endpoint;
+
+	if (!wg_socket_endpoint_from_skb(&endpoint, skb))
+		wg_socket_set_peer_endpoint(peer, &endpoint);
+}
+
+void wg_socket_clear_peer_endpoint_src(struct wg_peer *peer)
+{
+	write_lock_bh(&peer->endpoint_lock);
+	memset(&peer->endpoint.src6, 0, sizeof(peer->endpoint.src6));
+	dst_cache_reset(&peer->endpoint_cache);
+	write_unlock_bh(&peer->endpoint_lock);
+}
+
+static int wg_receive(struct sock *sk, struct sk_buff *skb)
+{
+	struct wg_device *wg;
+
+	if (unlikely(!sk))
+		goto err;
+	wg = sk->sk_user_data;
+	if (unlikely(!wg))
+		goto err;
+	wg_packet_receive(wg, skb);
+	return 0;
+
+err:
+	kfree_skb(skb);
+	return 0;
+}
+
+static void sock_free(struct sock *sock)
+{
+	if (unlikely(!sock))
+		return;
+	sk_clear_memalloc(sock);
+	udp_tunnel_sock_release(sock->sk_socket);
+}
+
+static void set_sock_opts(struct socket *sock)
+{
+	sock->sk->sk_allocation = GFP_ATOMIC;
+	sock->sk->sk_sndbuf = INT_MAX;
+	sk_set_memalloc(sock->sk);
+}
+
+int wg_socket_init(struct wg_device *wg, u16 port)
+{
+	int ret;
+	struct udp_tunnel_sock_cfg cfg = {
+		.sk_user_data = wg,
+		.encap_type = 1,
+		.encap_rcv = wg_receive
+	};
+	struct socket *new4 = NULL, *new6 = NULL;
+	struct udp_port_cfg port4 = {
+		.family = AF_INET,
+		.local_ip.s_addr = htonl(INADDR_ANY),
+		.local_udp_port = htons(port),
+		.use_udp_checksums = true
+	};
+#if IS_ENABLED(CONFIG_IPV6)
+	int retries = 0;
+	struct udp_port_cfg port6 = {
+		.family = AF_INET6,
+		.local_ip6 = IN6ADDR_ANY_INIT,
+		.use_udp6_tx_checksums = true,
+		.use_udp6_rx_checksums = true,
+		.ipv6_v6only = true
+	};
+#endif
+
+#if IS_ENABLED(CONFIG_IPV6)
+retry:
+#endif
+
+	ret = udp_sock_create(wg->creating_net, &port4, &new4);
+	if (ret < 0) {
+		pr_err("%s: Could not create IPv4 socket\n", wg->dev->name);
+		return ret;
+	}
+	set_sock_opts(new4);
+	setup_udp_tunnel_sock(wg->creating_net, new4, &cfg);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (ipv6_mod_enabled()) {
+		port6.local_udp_port = inet_sk(new4->sk)->inet_sport;
+		ret = udp_sock_create(wg->creating_net, &port6, &new6);
+		if (ret < 0) {
+			udp_tunnel_sock_release(new4);
+			if (ret == -EADDRINUSE && !port && retries++ < 100)
+				goto retry;
+			pr_err("%s: Could not create IPv6 socket\n",
+			       wg->dev->name);
+			return ret;
+		}
+		set_sock_opts(new6);
+		setup_udp_tunnel_sock(wg->creating_net, new6, &cfg);
+	}
+#endif
+
+	wg_socket_reinit(wg, new4->sk, new6 ? new6->sk : NULL);
+	return 0;
+}
+
+void wg_socket_reinit(struct wg_device *wg, struct sock *new4,
+		      struct sock *new6)
+{
+	struct sock *old4, *old6;
+
+	mutex_lock(&wg->socket_update_lock);
+	old4 = rcu_dereference_protected(wg->sock4,
+				lockdep_is_held(&wg->socket_update_lock));
+	old6 = rcu_dereference_protected(wg->sock6,
+				lockdep_is_held(&wg->socket_update_lock));
+	rcu_assign_pointer(wg->sock4, new4);
+	rcu_assign_pointer(wg->sock6, new6);
+	if (new4)
+		wg->incoming_port = ntohs(inet_sk(new4)->inet_sport);
+	mutex_unlock(&wg->socket_update_lock);
+	synchronize_rcu();
+	synchronize_net();
+	sock_free(old4);
+	sock_free(old6);
+}
diff --git a/drivers/net/wireguard/socket.h b/drivers/net/wireguard/socket.h
new file mode 100644
index 000000000000..bab5848efbcd
--- /dev/null
+++ b/drivers/net/wireguard/socket.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_SOCKET_H
+#define _WG_SOCKET_H
+
+#include <linux/netdevice.h>
+#include <linux/udp.h>
+#include <linux/if_vlan.h>
+#include <linux/if_ether.h>
+
+int wg_socket_init(struct wg_device *wg, u16 port);
+void wg_socket_reinit(struct wg_device *wg, struct sock *new4,
+		      struct sock *new6);
+int wg_socket_send_buffer_to_peer(struct wg_peer *peer, void *data,
+				  size_t len, u8 ds);
+int wg_socket_send_skb_to_peer(struct wg_peer *peer, struct sk_buff *skb,
+			       u8 ds);
+int wg_socket_send_buffer_as_reply_to_skb(struct wg_device *wg,
+					  struct sk_buff *in_skb,
+					  void *out_buffer, size_t len);
+
+int wg_socket_endpoint_from_skb(struct endpoint *endpoint,
+				const struct sk_buff *skb);
+void wg_socket_set_peer_endpoint(struct wg_peer *peer,
+				 const struct endpoint *endpoint);
+void wg_socket_set_peer_endpoint_from_skb(struct wg_peer *peer,
+					  const struct sk_buff *skb);
+void wg_socket_clear_peer_endpoint_src(struct wg_peer *peer);
+
+#if defined(CONFIG_DYNAMIC_DEBUG) || defined(DEBUG)
+#define net_dbg_skb_ratelimited(fmt, dev, skb, ...) do {                       \
+		struct endpoint __endpoint;                                    \
+		wg_socket_endpoint_from_skb(&__endpoint, skb);                 \
+		net_dbg_ratelimited(fmt, dev, &__endpoint.addr,                \
+				    ##__VA_ARGS__);                            \
+	} while (0)
+#else
+#define net_dbg_skb_ratelimited(fmt, skb, ...)
+#endif
+
+#endif /* _WG_SOCKET_H */
diff --git a/drivers/net/wireguard/timers.c b/drivers/net/wireguard/timers.c
new file mode 100644
index 000000000000..d54d32ac9bc4
--- /dev/null
+++ b/drivers/net/wireguard/timers.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include "timers.h"
+#include "device.h"
+#include "peer.h"
+#include "queueing.h"
+#include "socket.h"
+
+/*
+ * - Timer for retransmitting the handshake if we don't hear back after
+ * `REKEY_TIMEOUT + jitter` ms.
+ *
+ * - Timer for sending empty packet if we have received a packet but after have
+ * not sent one for `KEEPALIVE_TIMEOUT` ms.
+ *
+ * - Timer for initiating new handshake if we have sent a packet but after have
+ * not received one (even empty) for `(KEEPALIVE_TIMEOUT + REKEY_TIMEOUT) +
+ * jitter` ms.
+ *
+ * - Timer for zeroing out all ephemeral keys after `(REJECT_AFTER_TIME * 3)` ms
+ * if no new keys have been received.
+ *
+ * - Timer for, if enabled, sending an empty authenticated packet every user-
+ * specified seconds.
+ */
+
+static inline void mod_peer_timer(struct wg_peer *peer,
+				  struct timer_list *timer,
+				  unsigned long expires)
+{
+	rcu_read_lock_bh();
+	if (likely(netif_running(peer->device->dev) &&
+		   !READ_ONCE(peer->is_dead)))
+		mod_timer(timer, expires);
+	rcu_read_unlock_bh();
+}
+
+static void wg_expired_retransmit_handshake(struct timer_list *timer)
+{
+	struct wg_peer *peer = from_timer(peer, timer,
+					  timer_retransmit_handshake);
+
+	if (peer->timer_handshake_attempts > MAX_TIMER_HANDSHAKES) {
+		pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d attempts, giving up\n",
+			 peer->device->dev->name, peer->internal_id,
+			 &peer->endpoint.addr, MAX_TIMER_HANDSHAKES + 2);
+
+		del_timer(&peer->timer_send_keepalive);
+		/* We drop all packets without a keypair and don't try again,
+		 * if we try unsuccessfully for too long to make a handshake.
+		 */
+		wg_packet_purge_staged_packets(peer);
+
+		/* We set a timer for destroying any residue that might be left
+		 * of a partial exchange.
+		 */
+		if (!timer_pending(&peer->timer_zero_key_material))
+			mod_peer_timer(peer, &peer->timer_zero_key_material,
+				       jiffies + REJECT_AFTER_TIME * 3 * HZ);
+	} else {
+		++peer->timer_handshake_attempts;
+		pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d seconds, retrying (try %d)\n",
+			 peer->device->dev->name, peer->internal_id,
+			 &peer->endpoint.addr, REKEY_TIMEOUT,
+			 peer->timer_handshake_attempts + 1);
+
+		/* We clear the endpoint address src address, in case this is
+		 * the cause of trouble.
+		 */
+		wg_socket_clear_peer_endpoint_src(peer);
+
+		wg_packet_send_queued_handshake_initiation(peer, true);
+	}
+}
+
+static void wg_expired_send_keepalive(struct timer_list *timer)
+{
+	struct wg_peer *peer = from_timer(peer, timer, timer_send_keepalive);
+
+	wg_packet_send_keepalive(peer);
+	if (peer->timer_need_another_keepalive) {
+		peer->timer_need_another_keepalive = false;
+		mod_peer_timer(peer, &peer->timer_send_keepalive,
+			       jiffies + KEEPALIVE_TIMEOUT * HZ);
+	}
+}
+
+static void wg_expired_new_handshake(struct timer_list *timer)
+{
+	struct wg_peer *peer = from_timer(peer, timer, timer_new_handshake);
+
+	pr_debug("%s: Retrying handshake with peer %llu (%pISpfsc) because we stopped hearing back after %d seconds\n",
+		 peer->device->dev->name, peer->internal_id,
+		 &peer->endpoint.addr, KEEPALIVE_TIMEOUT + REKEY_TIMEOUT);
+	/* We clear the endpoint address src address, in case this is the cause
+	 * of trouble.
+	 */
+	wg_socket_clear_peer_endpoint_src(peer);
+	wg_packet_send_queued_handshake_initiation(peer, false);
+}
+
+static void wg_expired_zero_key_material(struct timer_list *timer)
+{
+	struct wg_peer *peer = from_timer(peer, timer, timer_zero_key_material);
+
+	rcu_read_lock_bh();
+	if (!READ_ONCE(peer->is_dead)) {
+		wg_peer_get(peer);
+		if (!queue_work(peer->device->handshake_send_wq,
+				&peer->clear_peer_work))
+			/* If the work was already on the queue, we want to drop
+			 * the extra reference.
+			 */
+			wg_peer_put(peer);
+	}
+	rcu_read_unlock_bh();
+}
+
+static void wg_queued_expired_zero_key_material(struct work_struct *work)
+{
+	struct wg_peer *peer = container_of(work, struct wg_peer,
+					    clear_peer_work);
+
+	pr_debug("%s: Zeroing out all keys for peer %llu (%pISpfsc), since we haven't received a new one in %d seconds\n",
+		 peer->device->dev->name, peer->internal_id,
+		 &peer->endpoint.addr, REJECT_AFTER_TIME * 3);
+	wg_noise_handshake_clear(&peer->handshake);
+	wg_noise_keypairs_clear(&peer->keypairs);
+	wg_peer_put(peer);
+}
+
+static void wg_expired_send_persistent_keepalive(struct timer_list *timer)
+{
+	struct wg_peer *peer = from_timer(peer, timer,
+					  timer_persistent_keepalive);
+
+	if (likely(peer->persistent_keepalive_interval))
+		wg_packet_send_keepalive(peer);
+}
+
+/* Should be called after an authenticated data packet is sent. */
+void wg_timers_data_sent(struct wg_peer *peer)
+{
+	if (!timer_pending(&peer->timer_new_handshake))
+		mod_peer_timer(peer, &peer->timer_new_handshake,
+			jiffies + (KEEPALIVE_TIMEOUT + REKEY_TIMEOUT) * HZ +
+			prandom_u32_max(REKEY_TIMEOUT_JITTER_MAX_JIFFIES));
+}
+
+/* Should be called after an authenticated data packet is received. */
+void wg_timers_data_received(struct wg_peer *peer)
+{
+	if (likely(netif_running(peer->device->dev))) {
+		if (!timer_pending(&peer->timer_send_keepalive))
+			mod_peer_timer(peer, &peer->timer_send_keepalive,
+				       jiffies + KEEPALIVE_TIMEOUT * HZ);
+		else
+			peer->timer_need_another_keepalive = true;
+	}
+}
+
+/* Should be called after any type of authenticated packet is sent, whether
+ * keepalive, data, or handshake.
+ */
+void wg_timers_any_authenticated_packet_sent(struct wg_peer *peer)
+{
+	del_timer(&peer->timer_send_keepalive);
+}
+
+/* Should be called after any type of authenticated packet is received, whether
+ * keepalive, data, or handshake.
+ */
+void wg_timers_any_authenticated_packet_received(struct wg_peer *peer)
+{
+	del_timer(&peer->timer_new_handshake);
+}
+
+/* Should be called after a handshake initiation message is sent. */
+void wg_timers_handshake_initiated(struct wg_peer *peer)
+{
+	mod_peer_timer(peer, &peer->timer_retransmit_handshake,
+		       jiffies + REKEY_TIMEOUT * HZ +
+		       prandom_u32_max(REKEY_TIMEOUT_JITTER_MAX_JIFFIES));
+}
+
+/* Should be called after a handshake response message is received and processed
+ * or when getting key confirmation via the first data message.
+ */
+void wg_timers_handshake_complete(struct wg_peer *peer)
+{
+	del_timer(&peer->timer_retransmit_handshake);
+	peer->timer_handshake_attempts = 0;
+	peer->sent_lastminute_handshake = false;
+	ktime_get_real_ts64(&peer->walltime_last_handshake);
+}
+
+/* Should be called after an ephemeral key is created, which is before sending a
+ * handshake response or after receiving a handshake response.
+ */
+void wg_timers_session_derived(struct wg_peer *peer)
+{
+	mod_peer_timer(peer, &peer->timer_zero_key_material,
+		       jiffies + REJECT_AFTER_TIME * 3 * HZ);
+}
+
+/* Should be called before a packet with authentication, whether
+ * keepalive, data, or handshakem is sent, or after one is received.
+ */
+void wg_timers_any_authenticated_packet_traversal(struct wg_peer *peer)
+{
+	if (peer->persistent_keepalive_interval)
+		mod_peer_timer(peer, &peer->timer_persistent_keepalive,
+			jiffies + peer->persistent_keepalive_interval * HZ);
+}
+
+void wg_timers_init(struct wg_peer *peer)
+{
+	timer_setup(&peer->timer_retransmit_handshake,
+		    wg_expired_retransmit_handshake, 0);
+	timer_setup(&peer->timer_send_keepalive, wg_expired_send_keepalive, 0);
+	timer_setup(&peer->timer_new_handshake, wg_expired_new_handshake, 0);
+	timer_setup(&peer->timer_zero_key_material,
+		    wg_expired_zero_key_material, 0);
+	timer_setup(&peer->timer_persistent_keepalive,
+		    wg_expired_send_persistent_keepalive, 0);
+	INIT_WORK(&peer->clear_peer_work, wg_queued_expired_zero_key_material);
+	peer->timer_handshake_attempts = 0;
+	peer->sent_lastminute_handshake = false;
+	peer->timer_need_another_keepalive = false;
+}
+
+void wg_timers_stop(struct wg_peer *peer)
+{
+	del_timer_sync(&peer->timer_retransmit_handshake);
+	del_timer_sync(&peer->timer_send_keepalive);
+	del_timer_sync(&peer->timer_new_handshake);
+	del_timer_sync(&peer->timer_zero_key_material);
+	del_timer_sync(&peer->timer_persistent_keepalive);
+	flush_work(&peer->clear_peer_work);
+}
diff --git a/drivers/net/wireguard/timers.h b/drivers/net/wireguard/timers.h
new file mode 100644
index 000000000000..f0653dcb1326
--- /dev/null
+++ b/drivers/net/wireguard/timers.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _WG_TIMERS_H
+#define _WG_TIMERS_H
+
+#include <linux/ktime.h>
+
+struct wg_peer;
+
+void wg_timers_init(struct wg_peer *peer);
+void wg_timers_stop(struct wg_peer *peer);
+void wg_timers_data_sent(struct wg_peer *peer);
+void wg_timers_data_received(struct wg_peer *peer);
+void wg_timers_any_authenticated_packet_sent(struct wg_peer *peer);
+void wg_timers_any_authenticated_packet_received(struct wg_peer *peer);
+void wg_timers_handshake_initiated(struct wg_peer *peer);
+void wg_timers_handshake_complete(struct wg_peer *peer);
+void wg_timers_session_derived(struct wg_peer *peer);
+void wg_timers_any_authenticated_packet_traversal(struct wg_peer *peer);
+
+static inline bool wg_birthdate_has_expired(u64 birthday_nanoseconds,
+					    u64 expiration_seconds)
+{
+	return (s64)(birthday_nanoseconds + expiration_seconds * NSEC_PER_SEC)
+		<= (s64)ktime_get_coarse_boottime_ns();
+}
+
+#endif /* _WG_TIMERS_H */
diff --git a/drivers/net/wireguard/version.h b/drivers/net/wireguard/version.h
new file mode 100644
index 000000000000..a1a269a11634
--- /dev/null
+++ b/drivers/net/wireguard/version.h
@@ -0,0 +1 @@
+#define WIREGUARD_VERSION "1.0.0"
diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
new file mode 100644
index 000000000000..dd8a47c4ad11
--- /dev/null
+++ b/include/uapi/linux/wireguard.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ * Documentation
+ * =============
+ *
+ * The below enums and macros are for interfacing with WireGuard, using generic
+ * netlink, with family WG_GENL_NAME and version WG_GENL_VERSION. It defines two
+ * methods: get and set. Note that while they share many common attributes,
+ * these two functions actually accept a slightly different set of inputs and
+ * outputs.
+ *
+ * WG_CMD_GET_DEVICE
+ * -----------------
+ *
+ * May only be called via NLM_F_REQUEST | NLM_F_DUMP. The command should contain
+ * one but not both of:
+ *
+ *    WGDEVICE_A_IFINDEX: NLA_U32
+ *    WGDEVICE_A_IFNAME: NLA_NUL_STRING, maxlen IFNAMESIZ - 1
+ *
+ * The kernel will then return several messages (NLM_F_MULTI) containing the
+ * following tree of nested items:
+ *
+ *    WGDEVICE_A_IFINDEX: NLA_U32
+ *    WGDEVICE_A_IFNAME: NLA_NUL_STRING, maxlen IFNAMESIZ - 1
+ *    WGDEVICE_A_PRIVATE_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
+ *    WGDEVICE_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
+ *    WGDEVICE_A_LISTEN_PORT: NLA_U16
+ *    WGDEVICE_A_FWMARK: NLA_U32
+ *    WGDEVICE_A_PEERS: NLA_NESTED
+ *        0: NLA_NESTED
+ *            WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
+ *            WGPEER_A_PRESHARED_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
+ *            WGPEER_A_ENDPOINT: NLA_MIN_LEN(struct sockaddr), struct sockaddr_in or struct sockaddr_in6
+ *            WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL: NLA_U16
+ *            WGPEER_A_LAST_HANDSHAKE_TIME: NLA_EXACT_LEN, struct __kernel_timespec
+ *            WGPEER_A_RX_BYTES: NLA_U64
+ *            WGPEER_A_TX_BYTES: NLA_U64
+ *            WGPEER_A_ALLOWEDIPS: NLA_NESTED
+ *                0: NLA_NESTED
+ *                    WGALLOWEDIP_A_FAMILY: NLA_U16
+ *                    WGALLOWEDIP_A_IPADDR: NLA_MIN_LEN(struct in_addr), struct in_addr or struct in6_addr
+ *                    WGALLOWEDIP_A_CIDR_MASK: NLA_U8
+ *                0: NLA_NESTED
+ *                    ...
+ *                0: NLA_NESTED
+ *                    ...
+ *                ...
+ *            WGPEER_A_PROTOCOL_VERSION: NLA_U32
+ *        0: NLA_NESTED
+ *            ...
+ *        ...
+ *
+ * It is possible that all of the allowed IPs of a single peer will not
+ * fit within a single netlink message. In that case, the same peer will
+ * be written in the following message, except it will only contain
+ * WGPEER_A_PUBLIC_KEY and WGPEER_A_ALLOWEDIPS. This may occur several
+ * times in a row for the same peer. It is then up to the receiver to
+ * coalesce adjacent peers. Likewise, it is possible that all peers will
+ * not fit within a single message. So, subsequent peers will be sent
+ * in following messages, except those will only contain WGDEVICE_A_IFNAME
+ * and WGDEVICE_A_PEERS. It is then up to the receiver to coalesce these
+ * messages to form the complete list of peers.
+ *
+ * Since this is an NLA_F_DUMP command, the final message will always be
+ * NLMSG_DONE, even if an error occurs. However, this NLMSG_DONE message
+ * contains an integer error code. It is either zero or a negative error
+ * code corresponding to the errno.
+ *
+ * WG_CMD_SET_DEVICE
+ * -----------------
+ *
+ * May only be called via NLM_F_REQUEST. The command should contain the
+ * following tree of nested items, containing one but not both of
+ * WGDEVICE_A_IFINDEX and WGDEVICE_A_IFNAME:
+ *
+ *    WGDEVICE_A_IFINDEX: NLA_U32
+ *    WGDEVICE_A_IFNAME: NLA_NUL_STRING, maxlen IFNAMESIZ - 1
+ *    WGDEVICE_A_FLAGS: NLA_U32, 0 or WGDEVICE_F_REPLACE_PEERS if all current
+ *                      peers should be removed prior to adding the list below.
+ *    WGDEVICE_A_PRIVATE_KEY: len WG_KEY_LEN, all zeros to remove
+ *    WGDEVICE_A_LISTEN_PORT: NLA_U16, 0 to choose randomly
+ *    WGDEVICE_A_FWMARK: NLA_U32, 0 to disable
+ *    WGDEVICE_A_PEERS: NLA_NESTED
+ *        0: NLA_NESTED
+ *            WGPEER_A_PUBLIC_KEY: len WG_KEY_LEN
+ *            WGPEER_A_FLAGS: NLA_U32, 0 and/or WGPEER_F_REMOVE_ME if the
+ *                            specified peer should not exist at the end of the
+ *                            operation, rather than added/updated and/or
+ *                            WGPEER_F_REPLACE_ALLOWEDIPS if all current allowed
+ *                            IPs of this peer should be removed prior to adding
+ *                            the list below and/or WGPEER_F_UPDATE_ONLY if the
+ *                            peer should only be set if it already exists.
+ *            WGPEER_A_PRESHARED_KEY: len WG_KEY_LEN, all zeros to remove
+ *            WGPEER_A_ENDPOINT: struct sockaddr_in or struct sockaddr_in6
+ *            WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL: NLA_U16, 0 to disable
+ *            WGPEER_A_ALLOWEDIPS: NLA_NESTED
+ *                0: NLA_NESTED
+ *                    WGALLOWEDIP_A_FAMILY: NLA_U16
+ *                    WGALLOWEDIP_A_IPADDR: struct in_addr or struct in6_addr
+ *                    WGALLOWEDIP_A_CIDR_MASK: NLA_U8
+ *                0: NLA_NESTED
+ *                    ...
+ *                0: NLA_NESTED
+ *                    ...
+ *                ...
+ *            WGPEER_A_PROTOCOL_VERSION: NLA_U32, should not be set or used at
+ *                                       all by most users of this API, as the
+ *                                       most recent protocol will be used when
+ *                                       this is unset. Otherwise, must be set
+ *                                       to 1.
+ *        0: NLA_NESTED
+ *            ...
+ *        ...
+ *
+ * It is possible that the amount of configuration data exceeds that of
+ * the maximum message length accepted by the kernel. In that case, several
+ * messages should be sent one after another, with each successive one
+ * filling in information not contained in the prior. Note that if
+ * WGDEVICE_F_REPLACE_PEERS is specified in the first message, it probably
+ * should not be specified in fragments that come after, so that the list
+ * of peers is only cleared the first time but appened after. Likewise for
+ * peers, if WGPEER_F_REPLACE_ALLOWEDIPS is specified in the first message
+ * of a peer, it likely should not be specified in subsequent fragments.
+ *
+ * If an error occurs, NLMSG_ERROR will reply containing an errno.
+ */
+
+#ifndef _WG_UAPI_WIREGUARD_H
+#define _WG_UAPI_WIREGUARD_H
+
+#define WG_GENL_NAME "wireguard"
+#define WG_GENL_VERSION 1
+
+#define WG_KEY_LEN 32
+
+enum wg_cmd {
+	WG_CMD_GET_DEVICE,
+	WG_CMD_SET_DEVICE,
+	__WG_CMD_MAX
+};
+#define WG_CMD_MAX (__WG_CMD_MAX - 1)
+
+enum wgdevice_flag {
+	WGDEVICE_F_REPLACE_PEERS = 1U << 0,
+	__WGDEVICE_F_ALL = WGDEVICE_F_REPLACE_PEERS
+};
+enum wgdevice_attribute {
+	WGDEVICE_A_UNSPEC,
+	WGDEVICE_A_IFINDEX,
+	WGDEVICE_A_IFNAME,
+	WGDEVICE_A_PRIVATE_KEY,
+	WGDEVICE_A_PUBLIC_KEY,
+	WGDEVICE_A_FLAGS,
+	WGDEVICE_A_LISTEN_PORT,
+	WGDEVICE_A_FWMARK,
+	WGDEVICE_A_PEERS,
+	__WGDEVICE_A_LAST
+};
+#define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
+
+enum wgpeer_flag {
+	WGPEER_F_REMOVE_ME = 1U << 0,
+	WGPEER_F_REPLACE_ALLOWEDIPS = 1U << 1,
+	WGPEER_F_UPDATE_ONLY = 1U << 2,
+	__WGPEER_F_ALL = WGPEER_F_REMOVE_ME | WGPEER_F_REPLACE_ALLOWEDIPS |
+			 WGPEER_F_UPDATE_ONLY
+};
+enum wgpeer_attribute {
+	WGPEER_A_UNSPEC,
+	WGPEER_A_PUBLIC_KEY,
+	WGPEER_A_PRESHARED_KEY,
+	WGPEER_A_FLAGS,
+	WGPEER_A_ENDPOINT,
+	WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
+	WGPEER_A_LAST_HANDSHAKE_TIME,
+	WGPEER_A_RX_BYTES,
+	WGPEER_A_TX_BYTES,
+	WGPEER_A_ALLOWEDIPS,
+	WGPEER_A_PROTOCOL_VERSION,
+	__WGPEER_A_LAST
+};
+#define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
+
+enum wgallowedip_attribute {
+	WGALLOWEDIP_A_UNSPEC,
+	WGALLOWEDIP_A_FAMILY,
+	WGALLOWEDIP_A_IPADDR,
+	WGALLOWEDIP_A_CIDR_MASK,
+	__WGALLOWEDIP_A_LAST
+};
+#define WGALLOWEDIP_A_MAX (__WGALLOWEDIP_A_LAST - 1)
+
+#endif /* _WG_UAPI_WIREGUARD_H */
diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
new file mode 100755
index 000000000000..e7310d9390f7
--- /dev/null
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -0,0 +1,537 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+#
+# This script tests the below topology:
+#
+# ┌─────────────────────┐   ┌──────────────────────────────────┐   ┌─────────────────────┐
+# │   $ns1 namespace    │   │          $ns0 namespace          │   │   $ns2 namespace    │
+# │                     │   │                                  │   │                     │
+# │┌────────┐           │   │            ┌────────┐            │   │           ┌────────┐│
+# ││  wg0   │───────────┼───┼────────────│   lo   │────────────┼───┼───────────│  wg0   ││
+# │├────────┴──────────┐│   │    ┌───────┴────────┴────────┐   │   │┌──────────┴────────┤│
+# ││192.168.241.1/24   ││   │    │(ns1)         (ns2)      │   │   ││192.168.241.2/24   ││
+# ││fd00::1/24         ││   │    │127.0.0.1:1   127.0.0.1:2│   │   ││fd00::2/24         ││
+# │└───────────────────┘│   │    │[::]:1        [::]:2     │   │   │└───────────────────┘│
+# └─────────────────────┘   │    └─────────────────────────┘   │   └─────────────────────┘
+#                           └──────────────────────────────────┘
+#
+# After the topology is prepared we run a series of TCP/UDP iperf3 tests between the
+# wireguard peers in $ns1 and $ns2. Note that $ns0 is the endpoint for the wg0
+# interfaces in $ns1 and $ns2. See https://www.wireguard.com/netns/ for further
+# details on how this is accomplished.
+set -e
+
+exec 3>&1
+export WG_HIDE_KEYS=never
+netns0="wg-test-$$-0"
+netns1="wg-test-$$-1"
+netns2="wg-test-$$-2"
+pretty() { echo -e "\x1b[32m\x1b[1m[+] ${1:+NS$1: }${2}\x1b[0m" >&3; }
+pp() { pretty "" "$*"; "$@"; }
+maybe_exec() { if [[ $BASHPID -eq $$ ]]; then "$@"; else exec "$@"; fi; }
+n0() { pretty 0 "$*"; maybe_exec ip netns exec $netns0 "$@"; }
+n1() { pretty 1 "$*"; maybe_exec ip netns exec $netns1 "$@"; }
+n2() { pretty 2 "$*"; maybe_exec ip netns exec $netns2 "$@"; }
+ip0() { pretty 0 "ip $*"; ip -n $netns0 "$@"; }
+ip1() { pretty 1 "ip $*"; ip -n $netns1 "$@"; }
+ip2() { pretty 2 "ip $*"; ip -n $netns2 "$@"; }
+sleep() { read -t "$1" -N 0 || true; }
+waitiperf() { pretty "${1//*-}" "wait for iperf:5201"; while [[ $(ss -N "$1" -tlp 'sport = 5201') != *iperf3* ]]; do sleep 0.1; done; }
+waitncatudp() { pretty "${1//*-}" "wait for udp:1111"; while [[ $(ss -N "$1" -ulp 'sport = 1111') != *ncat* ]]; do sleep 0.1; done; }
+waitncattcp() { pretty "${1//*-}" "wait for tcp:1111"; while [[ $(ss -N "$1" -tlp 'sport = 1111') != *ncat* ]]; do sleep 0.1; done; }
+waitiface() { pretty "${1//*-}" "wait for $2 to come up"; ip netns exec "$1" bash -c "while [[ \$(< \"/sys/class/net/$2/operstate\") != up ]]; do read -t .1 -N 0 || true; done;"; }
+
+cleanup() {
+	set +e
+	exec 2>/dev/null
+	printf "$orig_message_cost" > /proc/sys/net/core/message_cost
+	ip0 link del dev wg0
+	ip1 link del dev wg0
+	ip2 link del dev wg0
+	local to_kill="$(ip netns pids $netns0) $(ip netns pids $netns1) $(ip netns pids $netns2)"
+	[[ -n $to_kill ]] && kill $to_kill
+	pp ip netns del $netns1
+	pp ip netns del $netns2
+	pp ip netns del $netns0
+	exit
+}
+
+orig_message_cost="$(< /proc/sys/net/core/message_cost)"
+trap cleanup EXIT
+printf 0 > /proc/sys/net/core/message_cost
+
+ip netns del $netns0 2>/dev/null || true
+ip netns del $netns1 2>/dev/null || true
+ip netns del $netns2 2>/dev/null || true
+pp ip netns add $netns0
+pp ip netns add $netns1
+pp ip netns add $netns2
+ip0 link set up dev lo
+
+ip0 link add dev wg0 type wireguard
+ip0 link set wg0 netns $netns1
+ip0 link add dev wg0 type wireguard
+ip0 link set wg0 netns $netns2
+key1="$(pp wg genkey)"
+key2="$(pp wg genkey)"
+key3="$(pp wg genkey)"
+pub1="$(pp wg pubkey <<<"$key1")"
+pub2="$(pp wg pubkey <<<"$key2")"
+pub3="$(pp wg pubkey <<<"$key3")"
+psk="$(pp wg genpsk)"
+[[ -n $key1 && -n $key2 && -n $psk ]]
+
+configure_peers() {
+	ip1 addr add 192.168.241.1/24 dev wg0
+	ip1 addr add fd00::1/24 dev wg0
+
+	ip2 addr add 192.168.241.2/24 dev wg0
+	ip2 addr add fd00::2/24 dev wg0
+
+	n1 wg set wg0 \
+		private-key <(echo "$key1") \
+		listen-port 1 \
+		peer "$pub2" \
+			preshared-key <(echo "$psk") \
+			allowed-ips 192.168.241.2/32,fd00::2/128
+	n2 wg set wg0 \
+		private-key <(echo "$key2") \
+		listen-port 2 \
+		peer "$pub1" \
+			preshared-key <(echo "$psk") \
+			allowed-ips 192.168.241.1/32,fd00::1/128
+
+	ip1 link set up dev wg0
+	ip2 link set up dev wg0
+}
+configure_peers
+
+tests() {
+	# Ping over IPv4
+	n2 ping -c 10 -f -W 1 192.168.241.1
+	n1 ping -c 10 -f -W 1 192.168.241.2
+
+	# Ping over IPv6
+	n2 ping6 -c 10 -f -W 1 fd00::1
+	n1 ping6 -c 10 -f -W 1 fd00::2
+
+	# TCP over IPv4
+	n2 iperf3 -s -1 -B 192.168.241.2 &
+	waitiperf $netns2
+	n1 iperf3 -Z -t 3 -c 192.168.241.2
+
+	# TCP over IPv6
+	n1 iperf3 -s -1 -B fd00::1 &
+	waitiperf $netns1
+	n2 iperf3 -Z -t 3 -c fd00::1
+
+	# UDP over IPv4
+	n1 iperf3 -s -1 -B 192.168.241.1 &
+	waitiperf $netns1
+	n2 iperf3 -Z -t 3 -b 0 -u -c 192.168.241.1
+
+	# UDP over IPv6
+	n2 iperf3 -s -1 -B fd00::2 &
+	waitiperf $netns2
+	n1 iperf3 -Z -t 3 -b 0 -u -c fd00::2
+}
+
+[[ $(ip1 link show dev wg0) =~ mtu\ ([0-9]+) ]] && orig_mtu="${BASH_REMATCH[1]}"
+big_mtu=$(( 34816 - 1500 + $orig_mtu ))
+
+# Test using IPv4 as outer transport
+n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
+n2 wg set wg0 peer "$pub1" endpoint 127.0.0.1:1
+# Before calling tests, we first make sure that the stats counters and timestamper are working
+n2 ping -c 10 -f -W 1 192.168.241.1
+{ read _; read _; read _; read rx_bytes _; read _; read tx_bytes _; } < <(ip2 -stats link show dev wg0)
+(( rx_bytes == 1372 && (tx_bytes == 1428 || tx_bytes == 1460) ))
+{ read _; read _; read _; read rx_bytes _; read _; read tx_bytes _; } < <(ip1 -stats link show dev wg0)
+(( tx_bytes == 1372 && (rx_bytes == 1428 || rx_bytes == 1460) ))
+read _ rx_bytes tx_bytes < <(n2 wg show wg0 transfer)
+(( rx_bytes == 1372 && (tx_bytes == 1428 || tx_bytes == 1460) ))
+read _ rx_bytes tx_bytes < <(n1 wg show wg0 transfer)
+(( tx_bytes == 1372 && (rx_bytes == 1428 || rx_bytes == 1460) ))
+read _ timestamp < <(n1 wg show wg0 latest-handshakes)
+(( timestamp != 0 ))
+
+tests
+ip1 link set wg0 mtu $big_mtu
+ip2 link set wg0 mtu $big_mtu
+tests
+
+ip1 link set wg0 mtu $orig_mtu
+ip2 link set wg0 mtu $orig_mtu
+
+# Test using IPv6 as outer transport
+n1 wg set wg0 peer "$pub2" endpoint [::1]:2
+n2 wg set wg0 peer "$pub1" endpoint [::1]:1
+tests
+ip1 link set wg0 mtu $big_mtu
+ip2 link set wg0 mtu $big_mtu
+tests
+
+# Test that route MTUs work with the padding
+ip1 link set wg0 mtu 1300
+ip2 link set wg0 mtu 1300
+n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
+n2 wg set wg0 peer "$pub1" endpoint 127.0.0.1:1
+n0 iptables -A INPUT -m length --length 1360 -j DROP
+n1 ip route add 192.168.241.2/32 dev wg0 mtu 1299
+n2 ip route add 192.168.241.1/32 dev wg0 mtu 1299
+n2 ping -c 1 -W 1 -s 1269 192.168.241.1
+n2 ip route delete 192.168.241.1/32 dev wg0 mtu 1299
+n1 ip route delete 192.168.241.2/32 dev wg0 mtu 1299
+n0 iptables -F INPUT
+
+ip1 link set wg0 mtu $orig_mtu
+ip2 link set wg0 mtu $orig_mtu
+
+# Test using IPv4 that roaming works
+ip0 -4 addr del 127.0.0.1/8 dev lo
+ip0 -4 addr add 127.212.121.99/8 dev lo
+n1 wg set wg0 listen-port 9999
+n1 wg set wg0 peer "$pub2" endpoint 127.0.0.1:2
+n1 ping6 -W 1 -c 1 fd00::2
+[[ $(n2 wg show wg0 endpoints) == "$pub1	127.212.121.99:9999" ]]
+
+# Test using IPv6 that roaming works
+n1 wg set wg0 listen-port 9998
+n1 wg set wg0 peer "$pub2" endpoint [::1]:2
+n1 ping -W 1 -c 1 192.168.241.2
+[[ $(n2 wg show wg0 endpoints) == "$pub1	[::1]:9998" ]]
+
+# Test that crypto-RP filter works
+n1 wg set wg0 peer "$pub2" allowed-ips 192.168.241.0/24
+exec 4< <(n1 ncat -l -u -p 1111)
+ncat_pid=$!
+waitncatudp $netns1
+n2 ncat -u 192.168.241.1 1111 <<<"X"
+read -r -N 1 -t 1 out <&4 && [[ $out == "X" ]]
+kill $ncat_pid
+more_specific_key="$(pp wg genkey | pp wg pubkey)"
+n1 wg set wg0 peer "$more_specific_key" allowed-ips 192.168.241.2/32
+n2 wg set wg0 listen-port 9997
+exec 4< <(n1 ncat -l -u -p 1111)
+ncat_pid=$!
+waitncatudp $netns1
+n2 ncat -u 192.168.241.1 1111 <<<"X"
+! read -r -N 1 -t 1 out <&4 || false
+kill $ncat_pid
+n1 wg set wg0 peer "$more_specific_key" remove
+[[ $(n1 wg show wg0 endpoints) == "$pub2	[::1]:9997" ]]
+
+# Test that we can change private keys keys and immediately handshake
+n1 wg set wg0 private-key <(echo "$key1") peer "$pub2" preshared-key <(echo "$psk") allowed-ips 192.168.241.2/32 endpoint 127.0.0.1:2
+n2 wg set wg0 private-key <(echo "$key2") listen-port 2 peer "$pub1" preshared-key <(echo "$psk") allowed-ips 192.168.241.1/32
+n1 ping -W 1 -c 1 192.168.241.2
+n1 wg set wg0 private-key <(echo "$key3")
+n2 wg set wg0 peer "$pub3" preshared-key <(echo "$psk") allowed-ips 192.168.241.1/32 peer "$pub1" remove
+n1 ping -W 1 -c 1 192.168.241.2
+
+ip1 link del wg0
+ip2 link del wg0
+
+# Test using NAT. We now change the topology to this:
+# ┌────────────────────────────────────────┐    ┌────────────────────────────────────────────────┐     ┌────────────────────────────────────────┐
+# │             $ns1 namespace             │    │                 $ns0 namespace                 │     │             $ns2 namespace             │
+# │                                        │    │                                                │     │                                        │
+# │  ┌─────┐             ┌─────┐           │    │    ┌──────┐              ┌──────┐              │     │  ┌─────┐            ┌─────┐            │
+# │  │ wg0 │─────────────│vethc│───────────┼────┼────│vethrc│              │vethrs│──────────────┼─────┼──│veths│────────────│ wg0 │            │
+# │  ├─────┴──────────┐  ├─────┴──────────┐│    │    ├──────┴─────────┐    ├──────┴────────────┐ │     │  ├─────┴──────────┐ ├─────┴──────────┐ │
+# │  │192.168.241.1/24│  │192.168.1.100/24││    │    │192.168.1.1/24  │    │10.0.0.1/24        │ │     │  │10.0.0.100/24   │ │192.168.241.2/24│ │
+# │  │fd00::1/24      │  │                ││    │    │                │    │SNAT:192.168.1.0/24│ │     │  │                │ │fd00::2/24      │ │
+# │  └────────────────┘  └────────────────┘│    │    └────────────────┘    └───────────────────┘ │     │  └────────────────┘ └────────────────┘ │
+# └────────────────────────────────────────┘    └────────────────────────────────────────────────┘     └────────────────────────────────────────┘
+
+ip1 link add dev wg0 type wireguard
+ip2 link add dev wg0 type wireguard
+configure_peers
+
+ip0 link add vethrc type veth peer name vethc
+ip0 link add vethrs type veth peer name veths
+ip0 link set vethc netns $netns1
+ip0 link set veths netns $netns2
+ip0 link set vethrc up
+ip0 link set vethrs up
+ip0 addr add 192.168.1.1/24 dev vethrc
+ip0 addr add 10.0.0.1/24 dev vethrs
+ip1 addr add 192.168.1.100/24 dev vethc
+ip1 link set vethc up
+ip1 route add default via 192.168.1.1
+ip2 addr add 10.0.0.100/24 dev veths
+ip2 link set veths up
+waitiface $netns0 vethrc
+waitiface $netns0 vethrs
+waitiface $netns1 vethc
+waitiface $netns2 veths
+
+n0 bash -c 'printf 1 > /proc/sys/net/ipv4/ip_forward'
+n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout'
+n0 bash -c 'printf 2 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout_stream'
+n0 iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 10.0.0.0/24 -j SNAT --to 10.0.0.1
+
+n1 wg set wg0 peer "$pub2" endpoint 10.0.0.100:2 persistent-keepalive 1
+n1 ping -W 1 -c 1 192.168.241.2
+n2 ping -W 1 -c 1 192.168.241.1
+[[ $(n2 wg show wg0 endpoints) == "$pub1	10.0.0.1:1" ]]
+# Demonstrate n2 can still send packets to n1, since persistent-keepalive will prevent connection tracking entry from expiring (to see entries: `n0 conntrack -L`).
+pp sleep 3
+n2 ping -W 1 -c 1 192.168.241.1
+n1 wg set wg0 peer "$pub2" persistent-keepalive 0
+
+# Do a wg-quick(8)-style policy routing for the default route, making sure vethc has a v6 address to tease out bugs.
+ip1 -6 addr add fc00::9/96 dev vethc
+ip1 -6 route add default via fc00::1
+ip2 -4 addr add 192.168.99.7/32 dev wg0
+ip2 -6 addr add abab::1111/128 dev wg0
+n1 wg set wg0 fwmark 51820 peer "$pub2" allowed-ips 192.168.99.7,abab::1111
+ip1 -6 route add default dev wg0 table 51820
+ip1 -6 rule add not fwmark 51820 table 51820
+ip1 -6 rule add table main suppress_prefixlength 0
+ip1 -4 route add default dev wg0 table 51820
+ip1 -4 rule add not fwmark 51820 table 51820
+ip1 -4 rule add table main suppress_prefixlength 0
+# suppress_prefixlength only got added in 3.12, and we want to support 3.10+.
+if [[ $(ip1 -4 rule show all) == *suppress_prefixlength* ]]; then
+	# Flood the pings instead of sending just one, to trigger routing table reference counting bugs.
+	n1 ping -W 1 -c 100 -f 192.168.99.7
+	n1 ping -W 1 -c 100 -f abab::1111
+fi
+
+n0 iptables -t nat -F
+ip0 link del vethrc
+ip0 link del vethrs
+ip1 link del wg0
+ip2 link del wg0
+
+# Test that saddr routing is sticky but not too sticky, changing to this topology:
+# ┌────────────────────────────────────────┐    ┌────────────────────────────────────────┐
+# │             $ns1 namespace             │    │             $ns2 namespace             │
+# │                                        │    │                                        │
+# │  ┌─────┐             ┌─────┐           │    │  ┌─────┐            ┌─────┐            │
+# │  │ wg0 │─────────────│veth1│───────────┼────┼──│veth2│────────────│ wg0 │            │
+# │  ├─────┴──────────┐  ├─────┴──────────┐│    │  ├─────┴──────────┐ ├─────┴──────────┐ │
+# │  │192.168.241.1/24│  │10.0.0.1/24     ││    │  │10.0.0.2/24     │ │192.168.241.2/24│ │
+# │  │fd00::1/24      │  │fd00:aa::1/96   ││    │  │fd00:aa::2/96   │ │fd00::2/24      │ │
+# │  └────────────────┘  └────────────────┘│    │  └────────────────┘ └────────────────┘ │
+# └────────────────────────────────────────┘    └────────────────────────────────────────┘
+
+ip1 link add dev wg0 type wireguard
+ip2 link add dev wg0 type wireguard
+configure_peers
+ip1 link add veth1 type veth peer name veth2
+ip1 link set veth2 netns $netns2
+n1 bash -c 'printf 0 > /proc/sys/net/ipv6/conf/all/accept_dad'
+n2 bash -c 'printf 0 > /proc/sys/net/ipv6/conf/all/accept_dad'
+n1 bash -c 'printf 0 > /proc/sys/net/ipv6/conf/veth1/accept_dad'
+n2 bash -c 'printf 0 > /proc/sys/net/ipv6/conf/veth2/accept_dad'
+n1 bash -c 'printf 1 > /proc/sys/net/ipv4/conf/veth1/promote_secondaries'
+
+# First we check that we aren't overly sticky and can fall over to new IPs when old ones are removed
+ip1 addr add 10.0.0.1/24 dev veth1
+ip1 addr add fd00:aa::1/96 dev veth1
+ip2 addr add 10.0.0.2/24 dev veth2
+ip2 addr add fd00:aa::2/96 dev veth2
+ip1 link set veth1 up
+ip2 link set veth2 up
+waitiface $netns1 veth1
+waitiface $netns2 veth2
+n1 wg set wg0 peer "$pub2" endpoint 10.0.0.2:2
+n1 ping -W 1 -c 1 192.168.241.2
+ip1 addr add 10.0.0.10/24 dev veth1
+ip1 addr del 10.0.0.1/24 dev veth1
+n1 ping -W 1 -c 1 192.168.241.2
+n1 wg set wg0 peer "$pub2" endpoint [fd00:aa::2]:2
+n1 ping -W 1 -c 1 192.168.241.2
+ip1 addr add fd00:aa::10/96 dev veth1
+ip1 addr del fd00:aa::1/96 dev veth1
+n1 ping -W 1 -c 1 192.168.241.2
+
+# Now we show that we can successfully do reply to sender routing
+ip1 link set veth1 down
+ip2 link set veth2 down
+ip1 addr flush dev veth1
+ip2 addr flush dev veth2
+ip1 addr add 10.0.0.1/24 dev veth1
+ip1 addr add 10.0.0.2/24 dev veth1
+ip1 addr add fd00:aa::1/96 dev veth1
+ip1 addr add fd00:aa::2/96 dev veth1
+ip2 addr add 10.0.0.3/24 dev veth2
+ip2 addr add fd00:aa::3/96 dev veth2
+ip1 link set veth1 up
+ip2 link set veth2 up
+waitiface $netns1 veth1
+waitiface $netns2 veth2
+n2 wg set wg0 peer "$pub1" endpoint 10.0.0.1:1
+n2 ping -W 1 -c 1 192.168.241.1
+[[ $(n2 wg show wg0 endpoints) == "$pub1	10.0.0.1:1" ]]
+n2 wg set wg0 peer "$pub1" endpoint [fd00:aa::1]:1
+n2 ping -W 1 -c 1 192.168.241.1
+[[ $(n2 wg show wg0 endpoints) == "$pub1	[fd00:aa::1]:1" ]]
+n2 wg set wg0 peer "$pub1" endpoint 10.0.0.2:1
+n2 ping -W 1 -c 1 192.168.241.1
+[[ $(n2 wg show wg0 endpoints) == "$pub1	10.0.0.2:1" ]]
+n2 wg set wg0 peer "$pub1" endpoint [fd00:aa::2]:1
+n2 ping -W 1 -c 1 192.168.241.1
+[[ $(n2 wg show wg0 endpoints) == "$pub1	[fd00:aa::2]:1" ]]
+
+# What happens if the inbound destination address belongs to a different interface as the default route?
+ip1 link add dummy0 type dummy
+ip1 addr add 10.50.0.1/24 dev dummy0
+ip1 link set dummy0 up
+ip2 route add 10.50.0.0/24 dev veth2
+n2 wg set wg0 peer "$pub1" endpoint 10.50.0.1:1
+n2 ping -W 1 -c 1 192.168.241.1
+[[ $(n2 wg show wg0 endpoints) == "$pub1	10.50.0.1:1" ]]
+
+ip1 link del dummy0
+ip1 addr flush dev veth1
+ip2 addr flush dev veth2
+ip1 route flush dev veth1
+ip2 route flush dev veth2
+
+# Now we see what happens if another interface route takes precedence over an ongoing one
+ip1 link add veth3 type veth peer name veth4
+ip1 link set veth4 netns $netns2
+ip1 addr add 10.0.0.1/24 dev veth1
+ip2 addr add 10.0.0.2/24 dev veth2
+ip1 addr add 10.0.0.3/24 dev veth3
+ip1 link set veth1 up
+ip2 link set veth2 up
+ip1 link set veth3 up
+ip2 link set veth4 up
+waitiface $netns1 veth1
+waitiface $netns2 veth2
+waitiface $netns1 veth3
+waitiface $netns2 veth4
+ip1 route flush dev veth1
+ip1 route flush dev veth3
+ip1 route add 10.0.0.0/24 dev veth1 src 10.0.0.1 metric 2
+n1 wg set wg0 peer "$pub2" endpoint 10.0.0.2:2
+n1 ping -W 1 -c 1 192.168.241.2
+[[ $(n2 wg show wg0 endpoints) == "$pub1	10.0.0.1:1" ]]
+ip1 route add 10.0.0.0/24 dev veth3 src 10.0.0.3 metric 1
+n1 bash -c 'printf 0 > /proc/sys/net/ipv4/conf/veth1/rp_filter'
+n2 bash -c 'printf 0 > /proc/sys/net/ipv4/conf/veth4/rp_filter'
+n1 bash -c 'printf 0 > /proc/sys/net/ipv4/conf/all/rp_filter'
+n2 bash -c 'printf 0 > /proc/sys/net/ipv4/conf/all/rp_filter'
+n1 ping -W 1 -c 1 192.168.241.2
+[[ $(n2 wg show wg0 endpoints) == "$pub1	10.0.0.3:1" ]]
+
+ip1 link del veth1
+ip1 link del veth3
+ip1 link del wg0
+ip2 link del wg0
+
+# We test that Netlink/IPC is working properly by doing things that usually cause split responses
+ip0 link add dev wg0 type wireguard
+config=( "[Interface]" "PrivateKey=$(wg genkey)" "[Peer]" "PublicKey=$(wg genkey)" )
+for a in {1..255}; do
+	for b in {0..255}; do
+		config+=( "AllowedIPs=$a.$b.0.0/16,$a::$b/128" )
+	done
+done
+n0 wg setconf wg0 <(printf '%s\n' "${config[@]}")
+i=0
+for ip in $(n0 wg show wg0 allowed-ips); do
+	((++i))
+done
+((i == 255*256*2+1))
+ip0 link del wg0
+ip0 link add dev wg0 type wireguard
+config=( "[Interface]" "PrivateKey=$(wg genkey)" )
+for a in {1..40}; do
+	config+=( "[Peer]" "PublicKey=$(wg genkey)" )
+	for b in {1..52}; do
+		config+=( "AllowedIPs=$a.$b.0.0/16" )
+	done
+done
+n0 wg setconf wg0 <(printf '%s\n' "${config[@]}")
+i=0
+while read -r line; do
+	j=0
+	for ip in $line; do
+		((++j))
+	done
+	((j == 53))
+	((++i))
+done < <(n0 wg show wg0 allowed-ips)
+((i == 40))
+ip0 link del wg0
+ip0 link add wg0 type wireguard
+config=( )
+for i in {1..29}; do
+	config+=( "[Peer]" "PublicKey=$(wg genkey)" )
+done
+config+=( "[Peer]" "PublicKey=$(wg genkey)" "AllowedIPs=255.2.3.4/32,abcd::255/128" )
+n0 wg setconf wg0 <(printf '%s\n' "${config[@]}")
+n0 wg showconf wg0 > /dev/null
+ip0 link del wg0
+
+allowedips=( )
+for i in {1..197}; do
+        allowedips+=( abcd::$i )
+done
+saved_ifs="$IFS"
+IFS=,
+allowedips="${allowedips[*]}"
+IFS="$saved_ifs"
+ip0 link add wg0 type wireguard
+n0 wg set wg0 peer "$pub1"
+n0 wg set wg0 peer "$pub2" allowed-ips "$allowedips"
+{
+	read -r pub allowedips
+	[[ $pub == "$pub1" && $allowedips == "(none)" ]]
+	read -r pub allowedips
+	[[ $pub == "$pub2" ]]
+	i=0
+	for _ in $allowedips; do
+		((++i))
+	done
+	((i == 197))
+} < <(n0 wg show wg0 allowed-ips)
+ip0 link del wg0
+
+! n0 wg show doesnotexist || false
+
+ip0 link add wg0 type wireguard
+n0 wg set wg0 private-key <(echo "$key1") peer "$pub2" preshared-key <(echo "$psk")
+[[ $(n0 wg show wg0 private-key) == "$key1" ]]
+[[ $(n0 wg show wg0 preshared-keys) == "$pub2	$psk" ]]
+n0 wg set wg0 private-key /dev/null peer "$pub2" preshared-key /dev/null
+[[ $(n0 wg show wg0 private-key) == "(none)" ]]
+[[ $(n0 wg show wg0 preshared-keys) == "$pub2	(none)" ]]
+n0 wg set wg0 peer "$pub2"
+n0 wg set wg0 private-key <(echo "$key2")
+[[ $(n0 wg show wg0 public-key) == "$pub2" ]]
+[[ -z $(n0 wg show wg0 peers) ]]
+n0 wg set wg0 peer "$pub2"
+[[ -z $(n0 wg show wg0 peers) ]]
+n0 wg set wg0 private-key <(echo "$key1")
+n0 wg set wg0 peer "$pub2"
+[[ $(n0 wg show wg0 peers) == "$pub2" ]]
+n0 wg set wg0 private-key <(echo "/${key1:1}")
+[[ $(n0 wg show wg0 private-key) == "+${key1:1}" ]]
+n0 wg set wg0 peer "$pub2" allowed-ips 0.0.0.0/0,10.0.0.0/8,100.0.0.0/10,172.16.0.0/12,192.168.0.0/16
+n0 wg set wg0 peer "$pub2" allowed-ips 0.0.0.0/0
+n0 wg set wg0 peer "$pub2" allowed-ips ::/0,1700::/111,5000::/4,e000::/37,9000::/75
+n0 wg set wg0 peer "$pub2" allowed-ips ::/0
+ip0 link del wg0
+
+declare -A objects
+while read -t 0.1 -r line 2>/dev/null || [[ $? -ne 142 ]]; do
+	[[ $line =~ .*(wg[0-9]+:\ [A-Z][a-z]+\ [0-9]+)\ .*(created|destroyed).* ]] || continue
+	objects["${BASH_REMATCH[1]}"]+="${BASH_REMATCH[2]}"
+done < /dev/kmsg
+alldeleted=1
+for object in "${!objects[@]}"; do
+	if [[ ${objects["$object"]} != *createddestroyed ]]; then
+		echo "Error: $object: merely ${objects["$object"]}" >&3
+		alldeleted=0
+	fi
+done
+[[ $alldeleted -eq 1 ]]
+pretty "" "Objects that were created were also destroyed."
-- 
2.24.0

