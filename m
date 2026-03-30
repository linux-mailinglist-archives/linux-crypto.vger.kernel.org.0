Return-Path: <linux-crypto+bounces-22564-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOqfMo4Xyml85AUAu9opvQ
	(envelope-from <linux-crypto+bounces-22564-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 08:26:22 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27552355E52
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 08:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B660301E94D
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE933394487;
	Mon, 30 Mar 2026 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cRpCqcww"
X-Original-To: linux-crypto@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C3382369;
	Mon, 30 Mar 2026 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851939; cv=none; b=PM0z8sxRmAvUvTKpaZxf3MChhNxsRpC5z8Zfh4Ck5NWM/BB7Yer44VyJZdLThgJRDgqO85T1CWAFi8cKAeWxR2ecpQq2a8zjqi7tcC6MCh8m2meGEL9JEWSrrgngbAn0r7sctJOnp2Fy7D2S/e3hh9dQpqqUPBl4qG0b8Y/UXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851939; c=relaxed/simple;
	bh=jJKfanWZpYtgSyxZ50QVDqdpJVn+yU6BSW6raNgHQOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5VZ7AHaihHj81H2hhgyPX7AsYDOcyqBOmhnGCfAiBNnDXM3pjJRReHLMNSZyql9uu1m6qKUW5TntI1nzb7+scYZQZjlHu+/Fx/gLUOWNLzE8wdJUlUa8vvQHrtIBtiKYdjL/MGTNOdh5fcnmmJo6tuD1haeHr1hT65LlJ3UHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cRpCqcww; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1tK0WtC+91a0BZrfD200a8cx70L5JBMeduqK1gjqlPE=;
	b=cRpCqcwwNyYkr4618s4s1KClnwpQ+fIuaqbMQqRGTQxymscKIPOlunwjpMSBeuGQq+ELZ/0qg
	gEc2wihiOrRxO5qAOidzTpd44kNNT9Y57k9Ae+M4FgsakCLp3jKDPEZzaWs3cn9j5hElIXe3eCs
	6yGsnoqkgLhg6p9kOcAfyLI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fkh1k59bXznV4N;
	Mon, 30 Mar 2026 14:20:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 94F0640539;
	Mon, 30 Mar 2026 14:25:35 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 14:25:35 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 14:25:34 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <qianweili@huawei.com>,
	<wangzhou1@hisilicon.com>, <yinzhushuai@huawei.com>
Subject: [PATCH 5/5] crypto: hisilicon - remove unused and non-public APIs for qm and sec
Date: Mon, 30 Mar 2026 14:25:31 +0800
Message-ID: <20260330062531.2976138-6-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260330062531.2976138-1-huangchenghai2@huawei.com>
References: <20260330062531.2976138-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200001.china.huawei.com (7.202.195.16)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22564-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-crypto];
	FROM_NEQ_ENVFROM(0.00)[huangchenghai2@huawei.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 27552355E52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

- sec_register_to_crypto() and sec_unregister_from_crypto()
have been removed, the function declarations have not been
removed. Remove them.
- hisi_qm_start_qp and hisi_qm_stop_qp are called internally by the
QM. Therefore, the EXPORT_SYMBOL_GPL declaration of these
non-public interfaces is deleted.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/qm.c       | 8 ++++----
 drivers/crypto/hisilicon/sec2/sec.h | 2 --
 include/linux/hisi_acc_qm.h         | 2 --
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 2bb51d4d88a6..3ca47e2a9719 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -472,6 +472,8 @@ static struct qm_typical_qos_table shaper_cbs_s[] = {
 
 static void qm_irqs_unregister(struct hisi_qm *qm);
 static int qm_reset_device(struct hisi_qm *qm);
+static void hisi_qm_stop_qp(struct hisi_qp *qp);
+
 int hisi_qm_q_num_set(const char *val, const struct kernel_param *kp,
 		      unsigned int device)
 {
@@ -2262,7 +2264,7 @@ static int qm_start_qp_nolock(struct hisi_qp *qp, unsigned long arg)
  * After this function, qp can receive request from user. Return 0 if
  * successful, negative error code if failed.
  */
-int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg)
+static int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg)
 {
 	struct hisi_qm *qm = qp->qm;
 	int ret;
@@ -2273,7 +2275,6 @@ int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hisi_qm_start_qp);
 
 /**
  * qp_stop_fail_cb() - call request cb.
@@ -2418,13 +2419,12 @@ static void qm_stop_qp_nolock(struct hisi_qp *qp)
  *
  * This function is reverse of hisi_qm_start_qp.
  */
-void hisi_qm_stop_qp(struct hisi_qp *qp)
+static void hisi_qm_stop_qp(struct hisi_qp *qp)
 {
 	down_write(&qp->qm->qps_lock);
 	qm_stop_qp_nolock(qp);
 	up_write(&qp->qm->qps_lock);
 }
-EXPORT_SYMBOL_GPL(hisi_qm_stop_qp);
 
 /**
  * hisi_qp_send() - Queue up a task in the hardware queue.
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 0710977861f3..adf95795dffe 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -285,7 +285,5 @@ enum sec_cap_table_type {
 
 void sec_destroy_qps(struct hisi_qp **qps, int qp_num);
 struct hisi_qp **sec_create_qps(void);
-int sec_register_to_crypto(struct hisi_qm *qm);
-void sec_unregister_from_crypto(struct hisi_qm *qm);
 u64 sec_get_alg_bitmap(struct hisi_qm *qm, u32 high, u32 low);
 #endif
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 8a581b5bbbcd..a6268dc4f7cb 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -558,8 +558,6 @@ int hisi_qm_init(struct hisi_qm *qm);
 void hisi_qm_uninit(struct hisi_qm *qm);
 int hisi_qm_start(struct hisi_qm *qm);
 int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r);
-int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg);
-void hisi_qm_stop_qp(struct hisi_qp *qp);
 int hisi_qp_send(struct hisi_qp *qp, const void *msg);
 void hisi_qm_debug_init(struct hisi_qm *qm);
 void hisi_qm_debug_regs_clear(struct hisi_qm *qm);
-- 
2.33.0


