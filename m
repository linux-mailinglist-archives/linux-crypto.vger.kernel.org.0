Return-Path: <linux-crypto+bounces-868-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6C481464B
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Dec 2023 12:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A06285AC2
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Dec 2023 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D846D2C690;
	Fri, 15 Dec 2023 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="XF9BPi3H"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C225572
	for <linux-crypto@vger.kernel.org>; Fri, 15 Dec 2023 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso5860365e9.2
        for <linux-crypto@vger.kernel.org>; Fri, 15 Dec 2023 03:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1702638435; x=1703243235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb5h6XsitjjkMwY2slc9nT1B2Witc+lbx2i0qDP2o4I=;
        b=XF9BPi3HHo48kzGWDaCVtrKmYUmImA4wNBghDNgC2lPUAoFgoZ0thLjJlm6k1volbp
         kGcOc2I5MaRYDouZRN/lSdl2ucALQwisz1j3DfgFPyc+yFTcHzm6bnfOsO4A9XlNrp1i
         f/TKKMHh3ejdBALepsvhKw6FzsBYUw4/V+1fnAMKNrelgekMq6+/EBajMeWIg7h/lO1n
         SuYCk3H4aa0U3ZGb6kGNn/qybAmYqQNDkoC7pUlZK7FqWPQjwbJN7EHY46+w5jyFyAxY
         Z0A5PPSFfyY63yyBkU+HxQSCVSbgIAuWfuh6z0+N5GwW5coXviwZd6WLeZZH+Apv0T4h
         Rblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638435; x=1703243235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zb5h6XsitjjkMwY2slc9nT1B2Witc+lbx2i0qDP2o4I=;
        b=iTG2sB+OBb7ezRzv4GlwoCIz/237UOKwUG7MlI6hJfjerQemvS4hdK4QGYRW7c7jSq
         w7DypYBXBn+Y9M3ojHpqozfLN7B1x/VDE5v7qUnvcrWfPJifDgk7AmRwKl1AYUs3zBYo
         vKk8pCfo9vmYz0QeayMAOVRqfTS4/bRyY7S2upk8dl5/PMiH+UnOLmiTTDxV8iM0STuS
         +Y5EqA+Au3DcqncbqtcAx4RNxkZFtalbLGi1SLVqKGKEIaBr3DJdKJ4MRhv4oVgiTXJy
         RqYKHxrbXT+rBs8smZZXNSaXI0yJDzQ6MuUV8Z+P3re/8fRsJu0D2WJCmEEGcy3FDu7L
         jf/A==
X-Gm-Message-State: AOJu0YyaP7FmoL6gJomeRJEkRJMj+3xtyGOhA5ujxw2aq0bmvSa1VS1I
	NJy16MtlqhOsgiOeOxPyqC7fbA==
X-Google-Smtp-Source: AGHT+IEdsbr9/i/knjcb9QmHXiVXg2YmHbzXGLWJsfMPmpozde86nTn0U65DAhMf0jc7ImNg0UJToA==
X-Received: by 2002:a05:600c:5022:b0:40c:3f87:32f8 with SMTP id n34-20020a05600c502200b0040c3f8732f8mr3614945wmr.277.1702638435470;
        Fri, 15 Dec 2023 03:07:15 -0800 (PST)
Received: from localhost (clnet-p106-198.ikbnet.co.at. [83.175.106.198])
        by smtp.gmail.com with UTF8SMTPSA id fc7-20020a05600c524700b0040c44cb251dsm21151352wmb.46.2023.12.15.03.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:07:15 -0800 (PST)
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
Subject: [PATCH v5 4/6] MAINTAINERS: add entry for DCP-based trusted keys
Date: Fri, 15 Dec 2023 12:06:31 +0100
Message-ID: <20231215110639.45522-5-david@sigma-star.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215110639.45522-1-david@sigma-star.at>
References: <20231215110639.45522-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This covers trusted keys backed by NXP's DCP (Data Co-Processor) chip
found in smaller i.MX SoCs.

Signed-off-by: David Gstir <david@sigma-star.at>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..988d01226131 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11647,6 +11647,15 @@ S:	Maintained
 F:	include/keys/trusted_caam.h
 F:	security/keys/trusted-keys/trusted_caam.c
 
+KEYS-TRUSTED-DCP
+M:	David Gstir <david@sigma-star.at>
+R:	sigma star Kernel Team <upstream+dcp@sigma-star.at>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	include/keys/trusted_dcp.h
+F:	security/keys/trusted-keys/trusted_dcp.c
+
 KEYS-TRUSTED-TEE
 M:	Sumit Garg <sumit.garg@linaro.org>
 L:	linux-integrity@vger.kernel.org
-- 
2.35.3


