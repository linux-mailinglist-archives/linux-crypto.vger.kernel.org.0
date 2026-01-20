Return-Path: <linux-crypto+bounces-20203-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJgeEnbab2n8RwAAu9opvQ
	(envelope-from <linux-crypto+bounces-20203-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 20:41:42 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE274AA2E
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 20:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 509B080D7DD
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jan 2026 19:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2D477E34;
	Tue, 20 Jan 2026 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIXHpLSj"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB847278A;
	Tue, 20 Jan 2026 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936426; cv=none; b=tya7kFZTgL+HHWeUGhEw3kuTrmOAaaaPez6HLHRcQ6ITy9Unjgc5g38laNLeeBp+15kdOpLzn4kURH8J7y3aCndLeT613YzWqf1RAwobV/iPN4pmTLMqBFofNAkprAcYHa7TqKcsKUYQB2FrhCisX0/p+v5prYKFOuLQxXavgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936426; c=relaxed/simple;
	bh=hR7VS+eGnEIFJeV2CJ6Lyfs5CIcoszKcZFkapk5y51A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XZmpEILd8enAzk/mL0FgXY8MnsDfEimZWA0eiHstU7wFLb4xK98Y+08zongAKzQnW/iYPNg/cuzfrrs448RHfr5qi4GIAqrXVOeePeuWuhC6I5m0gk5SLYGK+qD5FRNVE3fpxc2Bdij4pXI4F3vJRPmrV1J0OeBn6en3OxKz4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIXHpLSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5DCC19425;
	Tue, 20 Jan 2026 19:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768936426;
	bh=hR7VS+eGnEIFJeV2CJ6Lyfs5CIcoszKcZFkapk5y51A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fIXHpLSjwwcIrK3t16Ux31rx7B3CC/uf12EHkBRtXsIKsaIIfMTIMmPAAxa+7ZnXb
	 uxmxogIu+BEGZ9asCjo/Z622Clnq807VAt2nQMHzAgvaeU4qAbuSClhoOdHWzRkptb
	 pN6YitKMvni2EsFreIafxjsyNmkDPhzbRn746kO9sf30/3OnwCUzJtWEn0azwm16kl
	 UPmr5rk9BcDd39oiCwgNe/ntDIPy9Y+MKESY971qTJF/RpjYiZxWJ7kVwWnaok49J4
	 fzMiHk04TnuYIzRrpO0C11GMD1g/9tw17UtOWxAI5R+VO4fMN9VUQlVD2d4MIaVh3i
	 zPWyqTkyXHHJQ==
Content-Type: multipart/mixed; boundary="===============7877633429921621322=="
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1f74213800152dbd91fa2649b82c182058c295f6c1c15799a5b5871aa5ced48@mail.kernel.org>
In-Reply-To: <20260120184701.23082-4-git@danielhodges.dev>
References: <20260120184701.23082-4-git@danielhodges.dev>
Subject: Re: [PATCH bpf-next v5 3/7] crypto: Add BPF signature algorithm type registration module
From: bot+bpf-ci@kernel.org
To: git@danielhodges.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,vadim.fedorenko@linux.dev,song@kernel.org,yatsenko@meta.com,martin.lau@linux.dev,eddyz87@gmail.com,haoluo@google.com,jolsa@kernel.org,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,yonghong.song@linux.dev,herbert@gondor.apana.org.au,davem@davemloft.net,linux-crypto@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,git@danielhodges.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 20 Jan 2026 19:13:44 +0000 (UTC)
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,meta.com,gmail.com,google.com,fomichev.me,gondor.apana.org.au,davemloft.net,vger.kernel.org,danielhodges.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20203-lists,linux-crypto=lfdr.de,bpf-ci];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: DEE274AA2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============7877633429921621322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/crypto/bpf_crypto_sig.c b/crypto/bpf_crypto_sig.c
> new file mode 100644
> index 000000000000..1d6521a066be
> --- /dev/null
> +++ b/crypto/bpf_crypto_sig.c

[ ... ]

> +static const struct bpf_crypto_type bpf_crypto_sig_type = {
> +	.alloc_tfm	= bpf_crypto_sig_alloc_tfm,
> +	.free_tfm	= bpf_crypto_sig_free_tfm,
> +	.has_algo	= bpf_crypto_sig_has_algo,
> +	.get_flags	= bpf_crypto_sig_get_flags,
> +	.setkey		= bpf_crypto_sig_setkey,
> +	.verify		= bpf_crypto_sig_verify,
> +	.owner		= THIS_MODULE,
> +	.type_id	= BPF_CRYPTO_TYPE_SIG,
> +	.name		= "sig",
> +};

The bpf_crypto_sig_type struct does not set .ivsize or .statesize callbacks.
In bpf_crypto_ctx_create() in kernel/bpf/crypto.c, there is an unconditional
call:

    ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);

If a BPF program creates a crypto context with type="sig", this will call
NULL function pointers and crash the kernel.

I see this is fixed later in the series by commit 76d771a64b50 ("bpf: Add
hash kfunc for cryptographic hashing") which adds NULL checks:

    if (type->ivsize && type->statesize)
        ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);

Should this fix be folded into this commit to avoid the intermediate crash?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21183820118

--===============7877633429921621322==--

