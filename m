Return-Path: <linux-crypto+bounces-25777-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SzDjE3f3T2oGrQIAu9opvQ
	(envelope-from <linux-crypto+bounces-25777-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 09 Jul 2026 21:33:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A725735060
	for <lists+linux-crypto@lfdr.de>; Thu, 09 Jul 2026 21:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KzUqQ+Z+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25777-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25777-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0320F3038F95
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2026 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8203B9952;
	Thu,  9 Jul 2026 19:29:56 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3333B71B8
	for <linux-crypto@vger.kernel.org>; Thu,  9 Jul 2026 19:29:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625396; cv=none; b=oXygHMJwMC80PouJhpmX3WIELmZ+SYcK968pkRvxf63FDfbzUpxxm/6qEx4BOO0s3IFPt1AtIZcH25TYkHwlJhvAYG3Uvn+kfKT0hVba41MkTOps9ORnH78qZ04GryoNbXYlSS/CnPYlJHSyrDhEd+fC45nKjabm04hGPY1nLdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625396; c=relaxed/simple;
	bh=UUhgffiwFMqsLRQqvi2m0+DFuWzKSUAEaQL9vakFVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj5GZuG0g05gv8i4PLqSIcx6aD18yV+Ufn6OOOsN9zMQQTXpD5Us/2JAUHvRlO8n/DTkgn53l17D4qZlLjiefTwYtr/iWzpa8pLyum0zg66xJY88onWPpDusE0TIwQvcMf/95zxDe0H2lXjHExqS18Ws89JG0NNxYMZw48/Mkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzUqQ+Z+; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so599095e9.3
        for <linux-crypto@vger.kernel.org>; Thu, 09 Jul 2026 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625394; x=1784230194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2u3pE1lizLe5VYoor11/eZUDKU8SqIFjsOoWnG1c0g=;
        b=KzUqQ+Z+w52Bfib6bJ8pXN7/OGhxEkwBzVDmlWa0nFVXG6bfLQtf/CKc2RGZ1m+4j5
         XHQayRMPJfJrchz+Efycxl5A/tK/nPhP0TRmp5sEi9HYJi2ut6Cv6rvklHl3s/mBncIt
         rPHYUXcaFwtexdfuzyhu1UDbItCzrZ2G3YVi6yyEqL31xQsK7ou8X1PRHJeGND3xrs8z
         F3OKiPu4sPNJT9bjm4q+XFy6gaEM3eJTaGKZZzxw5bxJnCJ9Y+s8AVEYUB1l+OfcVNin
         i3mdIUHyzEUUoC5EEK6E+diRkNb0FDFZsUHC+DOhma6+Y20MMJf3WnpbgL/6qqQF7MnN
         wvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625394; x=1784230194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2u3pE1lizLe5VYoor11/eZUDKU8SqIFjsOoWnG1c0g=;
        b=BjEDHdhG7CFF0uJXJY3TnSxUdgV3Uw7q2Tiu4eMaZM1PmK/Obb+hzB0TmOZRnrO+xi
         AMETWSTaAXleshnAXD2Fa7Uo8sL/n1XSxSwKbSxDWe/t7a5HluNQHgEga3z6J7DRIYqz
         Jx8EAH8URNS1+BKKt7VjVK8Wm9X8HHmuwlfwN7cE10KHyEX754Pb3eN9tTkvwQsduUem
         Atz0SRb2YfYdCVEsWs0Hr7hA+bqVYagQy49qwutMXiFWkIZQafkhhOXdbNbhvqnjvjTQ
         VxKxmcwvjbefdnFjq901AUWuGrR9VtLmhlvZcEMBVVHjWUWgln64jS/wquC1Zxvw7K/+
         s/EQ==
X-Forwarded-Encrypted: i=1; AHgh+RpuLo3Ch5w2YAsfZCeMmvIdrucl1GmAJjVufluBL6+hOzMzDb5cgyNij8d0GamV5Xvk3Iw0YjFE9gvOtsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzynnbZbinSQIb5Xe4MRhYgRxkwdxM1Ow/qUqcxqYh+moYDnqQ5
	XKF3hH5Gq3vgIfdKzb7dUoFnBqoFHsm+7eSpMH2ZdqUhxufIU3hNZR+3
X-Gm-Gg: AfdE7cl+NWJeim9jCFmiZ2JwNg2AtYAZLhJsm1k9iLvVQgfQKZH5qzovUGJTLE8Z8Wn
	2x8nX7/I411+4vTrMqN9nQHj37ZCEP66RBRXqcGlxvau8ivM9teH6itPukYaVwnem90oBOq28RQ
	lVDOmu8DVN5rSZj4r7itG2GhHeI5V82lT5sqYqOFWdlr7H4ojQDOi+kYLmylxX0tXWEmqJhg3YW
	yiNubn/+7C7A7sS/hhmsXmsL2hdB0iY9uzQvPIoEs/Tgc7cF5VAwufpmw/MT/WBejM+4XYPR6Vy
	KDYVLxc8DlK2fXgRwJM6AUjMcyUSUcm9jWxC0V/tNymy2gnZZ73rnMu4WY06AN0VWWqzloH66pC
	bmPp2cutB1SxFdKdmCpPNwRZT0F7kJA7U4Tta8HHJBvwzkYpHsDFvjFv53jKAsphscC6AnWDKNq
	FnSSoRWi1k/HyHr4MQc3BHxOm7
X-Received: by 2002:a05:600d:8444:10b0:493:ba6b:b6e6 with SMTP id 5b1f17b1804b1-493e689b0bemr68230185e9.31.1783625393415;
        Thu, 09 Jul 2026 12:29:53 -0700 (PDT)
Received: from mini.main.internal ([2a02:908:c211:cd18:d9f3:ab2b:ac6e:fc84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm53873509f8f.5.2026.07.09.12.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:52 -0700 (PDT)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ggoerisch@gmail.com,
	herbert@gondor.apana.org.au,
	herve.codina@bootlin.com,
	linux-crypto@vger.kernel.org,
	miquel.raynal@bootlin.com,
	paul.louvel@bootlin.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 6.6.y v2 0/5] crypto: talitos - fix rename first/last to first_desc/last_desc
Date: Thu,  9 Jul 2026 21:28:21 +0200
Message-ID: <20260709192826.12699-1-ggoerisch@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026070912-pluck-bagful-2a71@gregkh>
References: <2026070912-pluck-bagful-2a71@gregkh>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25777-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,bootlin.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[ggoerisch@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:ggoerisch@gmail.com,m:herbert@gondor.apana.org.au,m:herve.codina@bootlin.com,m:linux-crypto@vger.kernel.org,m:miquel.raynal@bootlin.com,m:paul.louvel@bootlin.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:thomas.petazzoni@bootlin.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ggoerisch@gmail.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A725735060

Thank you Greg for this feedback.
v2: add reason and SoB to revert commit which was missing.


Commit a1b80018b8cec27fc06a8b04a7f8b5f6cfe86eae
was backported to 6.6.y with a866e2b1c65edaee2e1bb1024ee2c761ced335f8
It renames last to last_desc but misses one occurrence which leads to compile errors on mpc85xx

drivers/crypto/talitos.c: In function 'ahash_digest':
drivers/crypto/talitos.c:2204:16: error: 'struct talitos_ahash_req_ctx' has no member named 'last'
 2204 | req_ctx->last = 1;
      |        ^~~~

Instead of renaming req_ctx->last, commit 9826d1d6ed5f8 ("crypto: talitos - stop
using crypto_ahash::init") should be applied.
Ideally before commit 00463d5f864a ("crypto: talitos - fix SEC1 32k ahash
request limitation") to avoid any compilation breakage and ensure correctness of
the code.
 
> > Greg could you please backport the mentioned commit to 6.6.y in the correct order for the next update?

> Can you send a series of backported patches in the correct order for us
> to apply, so we know to get them correct?  Trying to dig out from an
> email like this is usually quite easy to get wrong :)

Hope this is correct.
Goetz


Eric Biggers (1):
  crypto: talitos - stop using crypto_ahash::init

Goetz Goerisch (2):
  Revert "crypto: talitos - rename first/last to first_desc/last_desc"
  Revert "crypto: talitos - fix SEC1 32k ahash request limitation"

Paul Louvel (2):
  crypto: talitos - fix SEC1 32k ahash request limitation
  crypto: talitos - rename first/last to first_desc/last_desc

 drivers/crypto/talitos.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.54.0


