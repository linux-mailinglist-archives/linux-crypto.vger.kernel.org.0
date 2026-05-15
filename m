Return-Path: <linux-crypto+bounces-24067-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM8VNjDiBmrVogIAu9opvQ
	(envelope-from <linux-crypto+bounces-24067-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 11:06:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E0254C01A
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA8830D1D7C
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE863B4EB3;
	Fri, 15 May 2026 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="duRzPpHN"
X-Original-To: linux-crypto@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB413E3DBF
	for <linux-crypto@vger.kernel.org>; Fri, 15 May 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834302; cv=none; b=IH9fm9xeN/lPXTalwlez3iFZRuLq7KfaCCSTBQpprVHwuchIMd4og3zbtAvmqfJnADnNKFjIY4izmSlAlOShbrTLZWaAhA1u8p8Sc77IkFCb4azDlHOWuKS26+kbJAc9aaZJ1fhMiwFLmBWchvBoswoQ7tEmlPegEBNpTIxmPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834302; c=relaxed/simple;
	bh=aj3hdqBiwI2oolhKmH/HXsZkuHBQyGljvFcAPO0nImw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMCRFqaP3foa4V5duCLJytWfulFA4PLHsk9iH2RzUlGzfjbyvWzinXi1wFQhsepLRXUUYXpSdVJzLMtCeEW14Vtp9gnlLPHWjvkY9f22DQYOt0Tpw4rjlT7Zgc7w/pFvGpOqydpvcogo6W+kLf6D89lc0FTwCJn4ZxOzP03GihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=duRzPpHN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hr
	BfZ2oyNsIRrFSQcYBN9N9LnY2cZVscwcCx02SA0Uk=; b=duRzPpHN92PosK7AZr
	tEabDFpI7LmTzGUZ2dBzO1n2LjaqUlfz2UAP38YWOwQUFdbSg+5R/HDOemQ6H+yl
	Ror+MpqxQUkwCKOFdcmdqmywmuA8Eq3Ap1C53t6/lHij9wEOXbuMYeC+IJFgxRqP
	5iWkQN2ZQi+Owq19QikTA9Be8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHlOFC2wZq4mXLDg--.24792S3;
	Fri, 15 May 2026 16:37:24 +0800 (CST)
From: scott_gzh@163.com
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-crypto@vger.kernel.org,
	Scott GUO <scottzhguo@tencent.com>
Subject: [PATCH 1/2] scatterlist: Introduce sglist_shift_{left,right} helpers
Date: Fri, 15 May 2026 16:36:44 +0800
Message-ID: <20260515083645.4024574-2-scott_gzh@163.com>
X-Mailer: git-send-email 2.41.3
In-Reply-To: <20260515083645.4024574-1-scott_gzh@163.com>
References: <20260515083645.4024574-1-scott_gzh@163.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHlOFC2wZq4mXLDg--.24792S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxur1DKryfKFy5ZFy7Gw13twb_yoWrGF18pr
	W5t398tr4UJr1I9rW3WF15Kr4rGFZYkryfGr43Cr9Y9w13JayrJrWxC34Yqa15Krs3WF4U
	Za9IgF47Cr40yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCiiDUUUUU=
X-CM-SenderInfo: hvfr33hbj2xqqrwthudrp/xtbCxAQkwWoG20RmSAAA34
X-Rspamd-Queue-Id: 39E0254C01A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24067-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[scott_gzh@163.com,linux-crypto@vger.kernel.org]
X-Rspamd-Action: no action

From: Scott GUO <scottzhguo@tencent.com>

These helpers shifts data within sglist in a chunck by
chunck manner.

Signed-off-by: GUO Zihua <scottzhguo@tencent.com>
---
 crypto/scatterwalk.c         | 79 ++++++++++++++++++++++++++++++++++++
 include/crypto/scatterwalk.h |  6 +++
 2 files changed, 85 insertions(+)

diff --git a/crypto/scatterwalk.c b/crypto/scatterwalk.c
index be0e24843806..958ab7e20d9d 100644
--- a/crypto/scatterwalk.c
+++ b/crypto/scatterwalk.c
@@ -180,6 +180,85 @@ void memcpy_sglist(struct scatterlist *dst, struct scatterlist *src,
 }
 EXPORT_SYMBOL_GPL(memcpy_sglist);
 
+static unsigned int sglist_total_len(struct scatterlist *sg)
+{
+	unsigned int total = 0;
+
+	for (; sg; sg = sg_next(sg))
+		total += sg->length;
+	return total;
+}
+
+/**
+ * sglist_shift_left - shift a region of data left within a scatterlist
+ * @sg:      scatterlist to operate on
+ * @dst_off: destination offset in bytes (must be <= @src_off)
+ * @src_off: source offset in bytes (start of the region to move)
+ * @nbytes:  number of bytes to move
+ *
+ * Moves [src_off, src_off+nbytes) to [dst_off, dst_off+nbytes).
+ * Handles overlapping regions safely by copying forward (low to high).
+ */
+void sglist_shift_left(struct scatterlist *sg, unsigned int dst_off,
+		       unsigned int src_off, unsigned int nbytes)
+{
+	u8 buf[16];
+
+	if (!nbytes || dst_off == src_off)
+		return;
+	if (WARN_ON_ONCE(dst_off > src_off))
+		return;
+	if (WARN_ON_ONCE(src_off + nbytes > sglist_total_len(sg)))
+		return;
+
+	while (nbytes) {
+		unsigned int chunk = min_t(unsigned int, nbytes, sizeof(buf));
+
+		memcpy_from_sglist(buf, sg, src_off, chunk);
+		memcpy_to_sglist(sg, dst_off, buf, chunk);
+		src_off += chunk;
+		dst_off += chunk;
+		nbytes -= chunk;
+	}
+}
+EXPORT_SYMBOL_GPL(sglist_shift_left);
+
+/**
+ * sglist_shift_right - shift a region of data right within a scatterlist
+ * @sg:      scatterlist to operate on
+ * @dst_off: destination offset in bytes (must be >= @src_off)
+ * @src_off: source offset in bytes (start of the region to move)
+ * @nbytes:  number of bytes to move
+ *
+ * Moves [src_off, src_off+nbytes) to [dst_off, dst_off+nbytes).
+ * Handles overlapping regions safely by copying backward (high to low).
+ */
+void sglist_shift_right(struct scatterlist *sg, unsigned int dst_off,
+			unsigned int src_off, unsigned int nbytes)
+{
+	unsigned int src_end = src_off + nbytes;
+	unsigned int dst_end = dst_off + nbytes;
+	u8 buf[16];
+
+	if (!nbytes || dst_off == src_off)
+		return;
+	if (WARN_ON_ONCE(dst_off < src_off))
+		return;
+	if (WARN_ON_ONCE(dst_end > sglist_total_len(sg)))
+		return;
+
+	while (nbytes) {
+		unsigned int chunk = min_t(unsigned int, nbytes, sizeof(buf));
+
+		src_end -= chunk;
+		dst_end -= chunk;
+		memcpy_from_sglist(buf, sg, src_end, chunk);
+		memcpy_to_sglist(sg, dst_end, buf, chunk);
+		nbytes -= chunk;
+	}
+}
+EXPORT_SYMBOL_GPL(sglist_shift_right);
+
 struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
 				     struct scatterlist *src,
 				     unsigned int len)
diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 624fab589c2c..eed6aee5bf9c 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -249,6 +249,12 @@ static inline void scatterwalk_map_and_copy(void *buf, struct scatterlist *sg,
 		memcpy_from_sglist(buf, sg, start, nbytes);
 }
 
+void sglist_shift_left(struct scatterlist *sg, unsigned int dst_off,
+		       unsigned int src_off, unsigned int nbytes);
+
+void sglist_shift_right(struct scatterlist *sg, unsigned int dst_off,
+			unsigned int src_off, unsigned int nbytes);
+
 struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
 				     struct scatterlist *src,
 				     unsigned int len);
-- 
2.41.3


