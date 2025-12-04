Return-Path: <linux-crypto+bounces-18651-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11768CA36B2
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Dec 2025 12:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E84C302B327
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Dec 2025 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485933CEB9;
	Thu,  4 Dec 2025 11:22:52 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EC833C18D;
	Thu,  4 Dec 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847372; cv=none; b=HC//8ACuCk+AlWix2yZgu0++r86CzdVYEpK347c62QlSFuZdEg4A2TH6o6eghNKQgI8xEIlt9gvABSRk7aJvw+rwsOONUvMmxmSktv+odEvEFdu602oIFpVBn2n12KUeSROqePK1SN/sVv2MsUerzrBT76/cdExkGEB+nL/DKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847372; c=relaxed/simple;
	bh=7uEZlY08pApLqncxFus98l7GN5XvIf15qCw1fmPb8g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2AYU29OZDxxhM4mZV7i2QegkH7MC/XeePnvOml0AxtNwNTzkWDvfZ7xfSDxab0s39SSvJ6H3uqWhHbyFRRWpaJtWN4+jC/n/pj6G8oMsS8XQq8WIeQgkqfk+ZUygOpdTrDggP8tBE/LBeTITO9gOTEyYUI/1Yzye5LPB5sDTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxWNH4bjFp_AkrAA--.27439S3;
	Thu, 04 Dec 2025 19:22:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxG8HzbjFp1mpFAQ--.17590S4;
	Thu, 04 Dec 2025 19:22:31 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Gonglei <arei.gonglei@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: virtualization@lists.linux.dev,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] crypto: virtio: Replace package id with numa node id
Date: Thu,  4 Dec 2025 19:22:19 +0800
Message-Id: <20251204112227.2659404-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251204112227.2659404-1-maobibo@loongson.cn>
References: <20251204112227.2659404-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxG8HzbjFp1mpFAQ--.17590S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With multiple virtio crypto devices supported with different NUMA
nodes, when crypto session is created, it will search virtio crypto
device with the same numa node of current CPU.

Here API topology_physical_package_id() is replaced with cpu_to_node()
since package id is physical concept, and one package id have multiple
memory numa id.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/crypto/virtio/virtio_crypto_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 19c934af3df6..e559bdadf4f9 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -135,7 +135,7 @@ static inline int virtio_crypto_get_current_node(void)
 	int cpu, node;
 
 	cpu = get_cpu();
-	node = topology_physical_package_id(cpu);
+	node = cpu_to_node(cpu);
 	put_cpu();
 
 	return node;
-- 
2.39.3


