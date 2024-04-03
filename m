Return-Path: <linux-crypto+bounces-3271-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8816889661A
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Apr 2024 09:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153F01F2761A
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Apr 2024 07:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08715813E;
	Wed,  3 Apr 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="sGSrJJEh"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8758AA9
	for <linux-crypto@vger.kernel.org>; Wed,  3 Apr 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128903; cv=none; b=tGPjAIxjIaI4r9h+nb8EwQkw+CsD0cKGAbqfrtY/Hpfz96XwywNYbPFoJh65qdP1EX9IhKMfSbEEQ6rzIuPhCiNrEM3esOvYQNBvrlLztnQf0PgAMHdtXDHx12MgliMfHsr2ecPYTii9u+gTGLgd+tf7/gbSE3JYoDPUZAZUrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128903; c=relaxed/simple;
	bh=zEOjOxnSTaZu8AzKX2vhwcbrNeYSFVlq7VcSspNUmDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TI7DsghK+oKXnB6wyp3Z8qRtOv9egP3nJlSj7Qd7oXzFHnPrxiCxby3yTijncrrJ3gUafrUUovl5MskHumukyRhtFy+J74GDB/9knPxBYa7yG4biZvT+Dc/ZDbuZ1nKO69iaf3C5Temow6ZnrKm53Q0z5xFbo5LSZfQBAV+Bgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=sGSrJJEh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41620ab6e9fso3738685e9.3
        for <linux-crypto@vger.kernel.org>; Wed, 03 Apr 2024 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1712128898; x=1712733698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6o/FOMMgtA6Efh2lZOLXQIlSvJPNil2JE+ZCOQOQcY=;
        b=sGSrJJEhDcZDKmeEzAdNrEFLaiOnr12XmMwPZESEAPTwDEDZkJcVzBp3yPRvW+kO4d
         98+dk8t9c/lP7PslLFc3lREbEZIU8X8MX8PNIWLkRWcBzVbw5hMwWpWKjWVLKFP1mh/h
         n9Lm+1wt8LsfnPVcpWBKQu6PyPi+Ewg61W16he2RZeP8hRWv37FCgoQx9PlCxFiCRbxA
         jsfywLZ5VrVq7QZ3EXEolkyYdb5eNGJKL6/wpl0XBGjbPTcyg1nGwpsxKIZFKIe/4KuB
         ONtzqmqlwGUAEKkvgJDbjC+TZGH5cmfg0EQ/9qrWynxvusLHPN7esMzflURF3hA130hF
         8/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128898; x=1712733698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6o/FOMMgtA6Efh2lZOLXQIlSvJPNil2JE+ZCOQOQcY=;
        b=fzK3J9GmhoTM+9Qaxw2YN694boy5lHeyX7XdyKZv1YGNMlMPHQk8h+XwjFalNRyVvd
         1rAxrJWcGKNbfuJCjJkGq5ljzMWDl9EImDtA2xcwjVpKQ2/LxyBqG7RWykog8e9WN/js
         jWhlGzQboO9SABVJWNXa6TPDPiiw+ZxYshg5QOvYI1qbYuJuwxnIdt1IPrmov2FKBti3
         t9hxylYhYbIv8DnpjTUV2O86eFB64lU6Yy2Zf2GBYbYD8s6QaBH9zazMaa3tC/yvoV7W
         jwHOgXbap6zvKjzJkHltAi/qGIMmUdBPMYE+ITb9pJWzc/WGzEbQNDDHMgfc3jzR3kPt
         YodQ==
X-Forwarded-Encrypted: i=1; AJvYcCXidUC9AfW4xN4VJr1uA+jTTdQ93RZ30yu0iLJVMOxvIuxm9BEY7B83NP4pxc7+qm5B12a2Lx1qU83iiLi+sbnD4ecLsSHiD/fEfTpd
X-Gm-Message-State: AOJu0Ywbnp5kjMKouQZvfYE09uxE3Yp6wNfFKJoX8x71t5d2pkIvm44g
	MM/jJfhWC9RMrQ0EkVH6pBHiYbDKnQSGtLK95rmxl5wA1DDwt0WQyhnVw1kprss=
X-Google-Smtp-Source: AGHT+IE/9Err26oBHnEgT5MkWJu1wDbsY5yCN4Hvc9o++TppeTxaNTSGe+M4pKLLv7eHhFdjLQngyw==
X-Received: by 2002:a05:600c:35c5:b0:414:22b5:c33a with SMTP id r5-20020a05600c35c500b0041422b5c33amr10417809wmq.1.1712128898557;
        Wed, 03 Apr 2024 00:21:38 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id r5-20020a056000014500b00341dc343e21sm16328599wrx.65.2024.04.03.00.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:21:38 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>,
	Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 0/6] DCP as trusted keys backend
Date: Wed,  3 Apr 2024 09:21:16 +0200
Message-ID: <20240403072131.54935-1-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a revival of the previous patch set submitted by Richard Weinberger:
https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richard@nod.at/

After having been thoroughly reviewed by Jarkko, it would be great if this
could go into 6.10. :-)

v7 is here:
https://lore.kernel.org/keyrings/20240327082454.13729-1-david@sigma-star.at/

v7 -> v8:
- Add Reviewed-by from Jarkko Sakkinen for patches #2 and #5
- Use kernel-doc for DCP blob format documentation instead of copy-pasting as
  suggested by Jarkko Sakkinen
- Fix wording in docs for trusted.dcp_skip_zk_test kernel param
v6 -> v7:
- Add Reviewed-by from Jarkko Sakkinen for patches #1 and #3
- Improved commit messages
- Changed log level for non-trusted/secure mode check from error to warning
v5 -> v6:
- Cleaned up coding style and commit messages to make the whole series more
  coherent as suggested by Jarkko Sakkinen
- Added Acked-By from Jarkko Sakkinen to patch #4 - thanks!
- Rebased against next-20240307
v4 -> v5:
- Make Kconfig for trust source check scalable as suggested by Jarkko Sakkinen
- Add Acked-By from Herbert Xu to patch #1 - thanks!
v3 -> v4:
- Split changes on MAINTAINERS and documentation into dedicated patches
- Use more concise wording in commit messages as suggested by Jarkko Sakkinen
v2 -> v3:
- Addressed review comments from Jarkko Sakkinen
v1 -> v2:
- Revive and rebase to latest version
- Include review comments from Ahmad Fatoum

The Data Co-Processor (DCP) is an IP core built into many NXP SoCs such
as i.mx6ull.

Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
encrypt/decrypt user data using a unique, never-disclosed,
device-specific key. Unlike CAAM though, it cannot directly wrap and
unwrap blobs in hardware. As DCP offers only the bare minimum feature
set and a blob mechanism needs aid from software. A blob in this case
is a piece of sensitive data (e.g. a key) that is encrypted and
authenticated using the device-specific key so that unwrapping can only
be done on the hardware where the blob was wrapped.

This patch series adds a DCP based, trusted-key backend and is similar
in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
It is of interest for similar use cases as the CAAM patch set, but for
lower end devices, where CAAM is not available.

Because constructing and parsing the blob has to happen in software,
we needed to decide on a blob format and chose the following:

struct dcp_blob_fmt {
	__u8 fmt_version;
	__u8 blob_key[AES_KEYSIZE_128];
	__u8 nonce[AES_KEYSIZE_128];
	__le32 payload_len;
	__u8 payload[];
} __packed;

The `fmt_version` is currently 1.

The encrypted key is stored in the payload area. It is AES-128-GCM
encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
the end of the payload (`payload_len` does not include the size of
the auth tag).

The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
the OTP or UNIQUE device key. A new `blob_key` and `nonce` are generated
randomly, when sealing/exporting the DCP blob.

This patchset was tested with dm-crypt on an i.MX6ULL board.

[0] https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatoum@pengutronix.de/

David Gstir (6):
  crypto: mxs-dcp: Add support for hardware-bound keys
  KEYS: trusted: improve scalability of trust source config
  KEYS: trusted: Introduce NXP DCP-backed trusted keys
  MAINTAINERS: add entry for DCP-based trusted keys
  docs: document DCP-backed trusted keys kernel params
  docs: trusted-encrypted: add DCP as new trust source

 .../admin-guide/kernel-parameters.txt         |  13 +
 .../security/keys/trusted-encrypted.rst       |  53 +++
 MAINTAINERS                                   |   9 +
 drivers/crypto/mxs-dcp.c                      | 104 +++++-
 include/keys/trusted_dcp.h                    |  11 +
 include/soc/fsl/dcp.h                         |  20 ++
 security/keys/trusted-keys/Kconfig            |  18 +-
 security/keys/trusted-keys/Makefile           |   2 +
 security/keys/trusted-keys/trusted_core.c     |   6 +-
 security/keys/trusted-keys/trusted_dcp.c      | 332 ++++++++++++++++++
 10 files changed, 554 insertions(+), 14 deletions(-)
 create mode 100644 include/keys/trusted_dcp.h
 create mode 100644 include/soc/fsl/dcp.h
 create mode 100644 security/keys/trusted-keys/trusted_dcp.c

-- 
2.35.3


