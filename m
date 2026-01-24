Return-Path: <linux-crypto+bounces-20349-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJueGoAJdWk3AAEAu9opvQ
	(envelope-from <linux-crypto+bounces-20349-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Jan 2026 19:03:44 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C41BD7E6EC
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Jan 2026 19:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EBE73011590
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Jan 2026 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7064F2459C5;
	Sat, 24 Jan 2026 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYz68VRR"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F193D76;
	Sat, 24 Jan 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769277816; cv=none; b=ayCvgmAOuwfa9kD4VG3nMi84oW/Jj1dsUIATCWWdqZYHkH0ODD4Q44ZJnSfjFqXitSTvevvh8v393Xoujb/SQZdBy7J04h4hjRk8zQMv449lD+/wemdBozuVbDt8SpXTfFSVW40OnPMiPNWvTBOboZwv2My2d4CFeF51ipuJOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769277816; c=relaxed/simple;
	bh=2trAOUoPnBEzvZ2E/ir5gzHdqC/uTdCQveNWKj+mbNY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MHYzZcvpOJlZgdv/keSOHKSQI/cHI9rRnTiHWCki39m0ZFyQXbAQus+40gYJcDrtEePRHt3J91snOP4xxFVOgYNmYTeivSmWzKP1fWQHH3soIcq4fgqrofoE3WLxNZ4Nsk+6WJ5/wJTjMXLpmrIneY44tPpTvAkhxGrU6NWOFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYz68VRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460BAC116D0;
	Sat, 24 Jan 2026 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769277815;
	bh=2trAOUoPnBEzvZ2E/ir5gzHdqC/uTdCQveNWKj+mbNY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pYz68VRRoq56TIBXZAPFFB5fsav7sg/TZ7UWtEDb9M/PFsSx1OXKHzJ+cpqOn5QhQ
	 0fk9Zqn9Z7fSAmsvBCGQl8fkqFSpF9S7Ksr6huQGdeGkfAjI6I4Zhuj0rMyEnpH7KU
	 Ygkd/7SbweVGCUfRlI7Yh/tpLEPKHBcM9GQG/vCZjduFRmXzq78KASRHsVuCDnDj2H
	 YqMiYeLcNuPofCnA7nzSdFw9FRbgEUCJW7C4wengm8L5CqejpTbz9S7loikDWYzkPx
	 zYP4gEpsFrtSThXNn2DI65/9MOFPiDEIe5w10j2aOJEXOQWwZril8uSdx4ATy7r6Dp
	 3FVVIdplnJKFg==
Content-Type: multipart/mixed; boundary="===============4105443870189554138=="
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <586edd61c4fed61324d16c9a2a18f1cb416ce89ffa945e5a9f865e7d8cb3c0d1@mail.kernel.org>
In-Reply-To: <20260124174349.16861-2-git@danielhodges.dev>
References: <20260124174349.16861-2-git@danielhodges.dev>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Add hash kfunc for cryptographic hashing
From: bot+bpf-ci@kernel.org
To: git@danielhodges.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,vadim.fedorenko@linux.dev,song@kernel.org,yatsenko@meta.com,martin.lau@linux.dev,eddyz87@gmail.com,haoluo@google.com,jolsa@kernel.org,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,yonghong.song@linux.dev,herbert@gondor.apana.org.au,davem@davemloft.net,linux-crypto@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,git@danielhodges.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 24 Jan 2026 18:03:35 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,meta.com,gmail.com,google.com,fomichev.me,gondor.apana.org.au,davemloft.net,vger.kernel.org,danielhodges.dev];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20349-lists,linux-crypto=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C41BD7E6EC
X-Rspamd-Action: no action

--===============4105443870189554138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
> index a41e71d4e2d9..cf2c66f9782b 100644
> --- a/include/linux/bpf_crypto.h
> +++ b/include/linux/bpf_crypto.h
> @@ -3,6 +3,12 @@
> #ifndef _BPF_CRYPTO_H
> #define _BPF_CRYPTO_H
>
> +enum bpf_crypto_type_id {
> +	BPF_CRYPTO_TYPE_SKCIPHER = 1,
> +	BPF_CRYPTO_TYPE_HASH,
> +	BPF_CRYPTO_TYPE_SIG,
> +};
> +
> struct bpf_crypto_type {

[ ... ]

> +	enum bpf_crypto_type_id type_id;
> 	char name[14];
> };

> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 7e75a1936256..bf14856ab5b1 100644

[ ... ]

> @@ -325,6 +337,9 @@ __bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
> 	const struct bpf_dynptr_kern *dst_kern = (struct bpf_dynptr_kern *)dst;
> 	const struct bpf_dynptr_kern *siv_kern = (struct bpf_dynptr_kern *)siv__nullable;
>
> +	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SKCIPHER)
> +		return -EINVAL;

The type_id check here will break existing skcipher users. Looking at
crypto/bpf_crypto_skcipher.c, bpf_crypto_lskcipher_type does not set
the type_id field:

    static const struct bpf_crypto_type bpf_crypto_lskcipher_type = {
        .alloc_tfm  = bpf_crypto_lskcipher_alloc_tfm,
        ...
        .owner      = THIS_MODULE,
        .name       = "skcipher",
        // no .type_id = BPF_CRYPTO_TYPE_SKCIPHER
    };

Since the struct is const and type_id is not initialized, it defaults to 0.
BPF_CRYPTO_TYPE_SKCIPHER is 1, so this check will always fail for skcipher
contexts, causing bpf_crypto_decrypt() to return -EINVAL for all skcipher
operations.

Should bpf_crypto_skcipher.c be updated in this commit to set
.type_id = BPF_CRYPTO_TYPE_SKCIPHER?

I found that commit 2dad6d96489e ("bpf: Add signature verification kfuncs")
later in the series adds this initialization, but until then existing
skcipher functionality appears broken.

> +
> 	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, true);
> }
>
> @@ -346,9 +361,64 @@ __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
> 	const struct bpf_dynptr_kern *dst_kern = (struct bpf_dynptr_kern *)dst;
> 	const struct bpf_dynptr_kern *siv_kern = (struct bpf_dynptr_kern *)siv__nullable;
>
> +	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SKCIPHER)
> +		return -EINVAL;

Same issue here - bpf_crypto_encrypt() will fail for skcipher contexts
because type_id is uninitialized in bpf_crypto_lskcipher_type.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21319193058

--===============4105443870189554138==--

