Return-Path: <linux-crypto+bounces-21714-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOFFBkJormmEDwIAu9opvQ
	(envelope-from <linux-crypto+bounces-21714-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 07:27:14 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2642342B6
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF390300C033
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Mar 2026 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411C359A7B;
	Mon,  9 Mar 2026 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkhNtiUf"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0ED359705
	for <linux-crypto@vger.kernel.org>; Mon,  9 Mar 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037630; cv=none; b=TxdAkcXtm1mzVq9/kHddPYP4tIc2VMxUlyjq+U3cOr+BFQPZju80mj9n3OJuY2JCufIYl27aWS7hn9wAYnijEoV58DmJT3RrzYGk8IwVxwKhGqQwjSiXuyh+IHSG9O60AF2l9S+8eP6oymKZuUVTkivsnzWmAStXOFHgeT8z3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037630; c=relaxed/simple;
	bh=bAzWEdhIzTouH8eIqxT29n5S4nzgSbNiXmw7ZEnfMG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMYOwDNUxIACMoTs0JWDUowQXTAR/MqF7FnXztWI2k+Qo1OBXiyyl85UiLVGztez+uXk+h+lFASUYUU7IG7aE7vVFxXIrMx4QZ1NK17t9AlPv/MaNiJyTbRMyFVqO11yn9EDc1Nzl5mlu7/uA7XOlKY40T8RgZVPMK3zWXxEKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkhNtiUf; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4171451e89aso728882fac.3
        for <linux-crypto@vger.kernel.org>; Sun, 08 Mar 2026 23:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773037628; x=1773642428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+OI56PrY1O188Hy4yE/+s+6VCfrbr9D/8DNyBUaLJs=;
        b=WkhNtiUfdbrJLp8TleksncRdEyGfPkmwi8hiVrgnvEAem1Yov6iU+352zqAlPDwPpO
         zPGgvDrEgZJb7yd05FKWLMkSCXUgw0fBEMb76wSiFdaDrXIeUX1VE3fbxKs6HHvnQSTl
         m1qLOhGCtO9AFl6PCfaxaTpkOSM5AYc5KYXp7ZaLWvX9rvctGzIFAeziFOn64JRgpRxS
         k95fPVSxI73j425sXoaidU0+AV/gPXfYlE/1WiiLzQ1ump6vCh2m87zPPFuncL5wmxhp
         A/28e2pEP2wRWa6fCvJZJW9RnkShMrzcT5ss29WFSvvPmKAxJalZrixHbYbM85ML7M3o
         G12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773037628; x=1773642428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+OI56PrY1O188Hy4yE/+s+6VCfrbr9D/8DNyBUaLJs=;
        b=iNQstrMcRs6I1rLCnyYIcJGCayBebbEo9Mx6HfFSLn83mOizJQSnU6izOlU4zTaVf5
         jO2FAS7wexoaSAcToaFMPAIaAkyI3edzRw/OJF63zgFNsGK4ijFGgPBAXkblsu6KpcmZ
         nGeHU6p8gMgYPUUOKOyxjOoW8nyWZRgP+U2/tlwiuuJZVRZhgSvZX23jW5eaZULXEXJN
         w4LXVos6cU5IU4wYRlyshqTltvwue3RUM10A4s09zTpYBJVXpf/5ElkIOxoGlOQAhr1J
         cP3xp3cQP6FJ9V2czcoOIqmbwc/ej4fSS216ageEunLw4Ag36ahEME1SisSuSeDaqpZn
         RCjw==
X-Gm-Message-State: AOJu0YzxgaEDelbx3F+H1dCjLDZjfe4ONpPL0pcrYNd4CXaNh3YuFVls
	BMYr9HCRUbEnmCBYww9s/eDWuju638vxhcjwV2V9oDzNRhPg6kRUrqau
X-Gm-Gg: ATEYQzwbfhRa8zUa7SQ3JOC8W8GhvoRpO6kxB1C0BtUAFcRceNdAt4EsyOw5S5QZrJo
	t8XRye/tsxaSGWDgc+0pn+mP9dDXjY4MYZqLQsKtl4y7j0Txr9leOhY7jI1eBuiIchqn4IJoOoI
	tH8KeU42vgeejm5x1i/O4fJEAA8xbxRl1KWOT/dAR+TR4BiP6lJ5xWQEgQWbDHeQff8ZVq8OOum
	Inoh60E3mM1Vq30XGEyIKahfbE2emhhRbQ2E6bhNWjRjhY9zgKPxSyX85GDc8NFjqCz/n28NrSR
	zpD9bSSpaypRA+cTWdtl0MtRpZzC+E9JpHKi0DE3Kcp3tW/ShPVNG+I8DIzmUdAYhqK6LmAakPO
	ljT/fiiMrugbYiv441K4bnpRqgLrDya8Nmm+yy7BsBGnJ9U5y8KOvOl9kroI36giUbVmU1b3vj2
	8HJuVaz5OgPcTFu5S2xK1QP/Q+IM81tTGDJJzVV4u527Xu8VLs7BeRljiYHtWrepLP56NUDWwDP
	Zg4NTKAQIaYxVbEFE/VBoMAt9YpjUSlFGXpPFsbOoelVl7M
X-Received: by 2002:a05:6871:a20e:b0:417:4520:3c85 with SMTP id 586e51a60fabf-4174520559bmr299333fac.42.1773037627654;
        Sun, 08 Mar 2026 23:27:07 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1cacsm8479676fac.8.2026.03.08.23.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 23:27:07 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	dhowells@redhat.com
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH] crypto: krb5enc - fix sleepable flag handling in encrypt dispatch
Date: Mon,  9 Mar 2026 00:26:24 -0600
Message-Id: <20260309062624.1848239-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C2642342B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21714-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

krb5enc_encrypt_ahash_done() continues encryption from an ahash
completion callback by calling krb5enc_dispatch_encrypt().

That helper takes a flags argument for this continuation path, but it
ignored that argument and reused aead_request_flags(req) when setting
up the skcipher subrequest callback. This can incorrectly preserve
CRYPTO_TFM_REQ_MAY_SLEEP when the encrypt step is started from callback
context.

Preserve the original request flags but clear
CRYPTO_TFM_REQ_MAY_SLEEP for the callback continuation path, and use
the caller-supplied flags when setting up the skcipher subrequest.

Fixes: d1775a177f7f ("crypto: Add 'krb5enc' hash and cipher AEAD algorithm")
Assisted-by: Codex:GPT-5
Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 crypto/krb5enc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/crypto/krb5enc.c b/crypto/krb5enc.c
index a1de55994d92..1bfe8370cf94 100644
--- a/crypto/krb5enc.c
+++ b/crypto/krb5enc.c
@@ -154,7 +154,7 @@ static int krb5enc_dispatch_encrypt(struct aead_request *req,
 		dst = scatterwalk_ffwd(areq_ctx->dst, req->dst, req->assoclen);
 
 	skcipher_request_set_tfm(skreq, enc);
-	skcipher_request_set_callback(skreq, aead_request_flags(req),
+	skcipher_request_set_callback(skreq, flags,
 				      krb5enc_encrypt_done, req);
 	skcipher_request_set_crypt(skreq, src, dst, req->cryptlen, req->iv);
 
@@ -192,7 +192,8 @@ static void krb5enc_encrypt_ahash_done(void *data, int err)
 
 	krb5enc_insert_checksum(req, ahreq->result);
 
-	err = krb5enc_dispatch_encrypt(req, 0);
+	err = krb5enc_dispatch_encrypt(req,
+				       aead_request_flags(req) & ~CRYPTO_TFM_REQ_MAY_SLEEP);
 	if (err != -EINPROGRESS)
 		aead_request_complete(req, err);
 }

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.34.1


