Return-Path: <linux-crypto+bounces-23750-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKLsMxEc+mkJJgMAu9opvQ
	(envelope-from <linux-crypto+bounces-23750-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 18:34:25 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1E4D1614
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 18:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77B7B300ADA3
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46C48C8C1;
	Tue,  5 May 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGqHCpme"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA848C8DF;
	Tue,  5 May 2026 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998852; cv=none; b=RkbBg7CTIHTbqHKg1xOuGrr9I4QIuK/sl9WC7GrPu5Fxa5ZUt2t8KrdxPmRV22l90OpjW+d78iPXlmqXLPXiDmaG24uitblWccWbvIWcx/ZRVfACSqXinCTQlfbcO8WsiLAFs3m7L4fAAn0QnVC3oHuOd43DF3PX80kAel35cW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998852; c=relaxed/simple;
	bh=cVcfbLM3oOOyr4PSilEGrrxmebjeKHe6vnGyG+zyCQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMEdSu0RAFlazdofk2xfMa7wsAK2WeffVkl9eY809sfsD1WmV1F8pv94vesJP/zOj4DCpU/F3x3Rx+aHS6O+cJ9k9d3m03cYVgbBMMfX6PlvIjTHqkyW86dlzrTlJnm7ZpB+961Zr/k9raI5eA1F1lcDNcPGTforfH9E05rx8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGqHCpme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E6EC2BCC7;
	Tue,  5 May 2026 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998851;
	bh=cVcfbLM3oOOyr4PSilEGrrxmebjeKHe6vnGyG+zyCQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aGqHCpmenkupNMpAB65SsLcKFlhftkIXCwWsFuzzDqD4zTibLd05hRq1MVZox0ocM
	 GkQg2p/bqZrn4jy/LrVSfM0akpHTEwlT5hCv/maC4mRu7jrKRlHYX+IKxfVfKjERTx
	 QLboXgb/baZ7yjJN9Qfh72uRDRGaQ7/HjbMy3gj5N1XcBZmYye6jZ26HCtwgLVrlw7
	 cOLXLqksxDy63Sb+um8KusGV3gSzZI0PjdBopMOlr0Cuy3ifiAOiHEXtRbzThVYRrG
	 GMKwrvzQent7tw1q85yWUL0558FlpQNqmc+TeXmtAezDK+0EnxMNVFX/C/vZMFHoiv
	 jupzwXuY9XrHQ==
Message-ID: <56abbf15-2a2a-4f65-81ae-fcfb5e1d9601@kernel.org>
Date: Tue, 5 May 2026 18:34:08 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/crypto: powerpc/md5: Drop powerpc optimized MD5 code
To: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260504041448.15820-1-ebiggers@kernel.org>
 <111ea924-fef5-441e-9849-83f938c913a7@kernel.org>
 <112bf0af-1551-4d3e-ab15-e5dea3fc2435@app.fastmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <112bf0af-1551-4d3e-ab15-e5dea3fc2435@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01A1E4D1614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zx2c4.com,gondor.apana.org.au,lists.ozlabs.org,gmail.com,ellerman.id.au,linux.ibm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23750-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]



Le 04/05/2026 à 15:56, Ard Biesheuvel a écrit :
> Hello Christophe,
> 
> On Mon, 4 May 2026, at 15:28, Christophe Leroy (CS GROUP) wrote:
> ...
>> I'm really concerned with the optimised MD5 going away now, and I'm also
>> wondering what will be the way to splice a file into the kernel and get
>> it's MD-5 hash from the TALITOS if AF_ALG goes away in medium-term.
>>
>> What is the way forward ? I'm open to any suggestion as I really can't
>> see where to go for now.
>>
> 
> AF_ALG was created to give user space access to crypto accelerators that
> require privileged execution, for sharing between clients, and for managing
> DMA etc.
> 
> The fact that kernel crypto code that does not have this requirement was
> exposed via AF_ALG too is a historical accident, and this is causing the
> pain that Eric describes wrt attack surface etc.
> 
> It sounds like you have constructed a vertically integrated system where
> the kernel provides the fallback when the Talitos engine is not available
> via AF_ALG.
> 
> This fallback does not need to live in the kernel, and it would be much
> better (as well as more efficient) if user space would implemented MD5
> itself if the Talitos cannot be accessed via AF_ALG. In user space, you
> can use any implementation you like, generic or asm accelerated. This is
> what all other architectures already implement, in OpenSSL etc.
> 
> Claiming that your user space software must only implement one code path,
> and that punting this to the kernel is therefore required is not a
> technical argument: this is just policy on your part that the community
> is not bound to.
> 
> However, deprecating AF_ALG does not mean that we will ever be able to
> remove it entirely. Especially the crypto accelerators that cannot be
> accessed by user space in any other way will remain supported as long
> as needed for legacy use cases.
> 
> But I think we should consider libkcapi as a general purpose crypto
> library deprecated too, as well as any other use of AF_ALG in lieu of
> user space libraries. It is not the kernel's job to execute user space
> code that can easily execute non-privileged as well.
> 
> I suppose there will be more discussion soon about AF_ALG deprecation
> for software crypto. It is likely that we will need to come up with
> an allowlist of algorithms, in order to limit the attack surface to those
> algorithms (such as your MD5) that are known to be relied upon by user space,
> rather than any random combination of all the buggy template code and
> null_ciphers etc.
> 
> Do you have any use cases where MD5 is a bottle neck, and the generic
> implementation is too slow?

Well, our boards are used in air trafic control voice communication 
systems, every millisecond is worth it and every performance degradation 
must be explained, justified, etc ....

Christophe

