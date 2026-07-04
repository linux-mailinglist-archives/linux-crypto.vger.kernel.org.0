Return-Path: <linux-crypto+bounces-25584-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xWvCMq8ASWpmxQAAu9opvQ
	(envelope-from <linux-crypto+bounces-25584-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 04 Jul 2026 14:46:39 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C8707A5B
	for <lists+linux-crypto@lfdr.de>; Sat, 04 Jul 2026 14:46:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25584-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25584-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B4C301BF6B
	for <lists+linux-crypto@lfdr.de>; Sat,  4 Jul 2026 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3E4389116;
	Sat,  4 Jul 2026 12:46:35 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAA2ECD3A;
	Sat,  4 Jul 2026 12:46:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783169191; cv=none; b=mg90Eu7PsFet2GtpO3ggDQG6IRFpGRNSYxZ9s/MBfEzB+iReqoNvFMMdPT8SYG7xWJiL7lmHgjNV98WrPGVe1UagmszI/8Bn8DuH5YHvAri4us4fZc8/G0NoGFjxD+/9QsD2Fd0n/Q5rLYyPOo9TtzAihlssYPcMoQFx1jbGwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783169191; c=relaxed/simple;
	bh=jc0icbrBgyq1RxPfrWHXRbPtc0W6C9OpcPU6A+B9ugk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpLjuf3PJ+kNUxf2JB9sxsleLHxMboNa9etKr2F6DEM1JFU83Po7k/TM5KZFoH22yJxsQzKabYT/kDxs2sCyxKp1cMaVcFJLgzB6ed65EwLg6oQMAF+XuCx4Xl0zdzsK0FXaBt8i5ypGzdVmc4b7Kp/aPnE9eO8cByfUsgfZV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAC3r7aTAElqjlvWFg--.11714S2;
	Sat, 04 Jul 2026 20:46:12 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Prabhjot Khurana <prabhjot.khurana@intel.com>,
	Mark Gross <mgross@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: keembay: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 20:46:09 +0800
Message-ID: <20260704124609.16628-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3r7aTAElqjlvWFg--.11714S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45uw1rurW7Aw4DuryrtFb_yoWkAFb_CF
	18WrZ7WryFkwnYgF1YqwsxZr9Ykwn5uF97GryFqa4avasxXF1UuFWkurnIvw15Jr4jyF98
	Xrn8WF18CrW2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1F_MD
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25584-lists,linux-crypto=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:prabhjot.khurana@intel.com,m:mgross@linux.intel.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:pengpeng@iscas.ac.cn,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E88C8707A5B

The driver has an OF match table wired to .of_match_table, but does
not export the table with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
information is generated for OF based module autoloading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the platform driver, and the missing module alias publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/crypto/intel/keembay/keembay-ocs-ecc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/intel/keembay/keembay-ocs-ecc.c b/drivers/crypto/intel/keembay/keembay-ocs-ecc.c
index e61a95f66a0c..9e555b02086c 100644
--- a/drivers/crypto/intel/keembay/keembay-ocs-ecc.c
+++ b/drivers/crypto/intel/keembay/keembay-ocs-ecc.c
@@ -978,6 +978,7 @@ static const struct of_device_id kmb_ocs_ecc_of_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_ocs_ecc_of_match);
 
 /* The OCS driver is a platform device. */
 static struct platform_driver kmb_ocs_ecc_driver = {


