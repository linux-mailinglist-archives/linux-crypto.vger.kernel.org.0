Return-Path: <linux-crypto+bounces-22411-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBsaIYXDxGku3QQAu9opvQ
	(envelope-from <linux-crypto+bounces-22411-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 06:26:29 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F32CD32F5EA
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 06:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D428303D709
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B17C35DA44;
	Thu, 26 Mar 2026 05:25:46 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1709257843;
	Thu, 26 Mar 2026 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502746; cv=none; b=u1b36s9PPLwpVHKoYLJaqBTiNHM8Yi2jNQOK/UvV3QRMo9Co5k4pmKpFjI4MPuV1TUXJuYuEW1vzmBJ820hPIgafA7TzX92e+gKU11Ce/rQ6fP7BjQ0iVagfceHgGS3Pji8rGhPBGFmK1XfKF/P6MdMf82ljHlSyLOrGIIqvJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502746; c=relaxed/simple;
	bh=l8j7DWsTgVJlWmZiPw/yr9qIJjdDjTovhcHwfeIQJ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XituE51K5o5Po+5a8S40cf0W+3kQ7CkGIdinzP93QchZEjwu/7kQ1Y3anz3lZr9moiBnqHVfErpR+dKnUs+GpTHF4WEZhkKnZfpBJHp7x13SizTKfaNlTZCzukKCiN80+jpAxIZkhDIuTZRRfmLBxjEAks3dsLfjw0dtyPth03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2636068BEB; Thu, 26 Mar 2026 06:25:38 +0100 (CET)
Date: Thu, 26 Mar 2026 06:25:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 02/17] raid6: remove __KERNEL__ ifdefs
Message-ID: <20260326052537.GA23044@lst.de>
References: <20260324064115.3217136-1-hch@lst.de> <20260324064115.3217136-3-hch@lst.de> <59d1d178-c141-4229-81e9-a6c23fa81f2f@zytor.com> <fa11e4d3-1c70-4fa7-9f03-8772c002be6a@zytor.com> <20260325195821.GD2305@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325195821.GD2305@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22411-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,lst.de,linux-foundation.org,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F32CD32F5EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 12:58:21PM -0700, Eric Biggers wrote:
> While I do like developing code in userspace as well, I've been doing it
> less over time as the kernel's tests and benchmarks have been improved.
> Running the KUnit tests is pretty straightforward and fast.

Yes.  I would have totally subscribed to hpa's position when he initially
wrote the code, but 20+ years later things look different.  In fact these
days I often write code intended for userspace in the kernel first to
benefit from lockdep primarily, but also other checkers that are in theory
available in userspace but as easy to use.  Now of course lockdep doesn't
really matter for the algorithms here, but the rest still stands.

I also find the point of developing new code for new platforms
interesting: in this decade we had two new platforms added: loongarch
and riscv and all other changes were to the wiring up and not the
algorithms.  And of those riscv only had the compile in userspace
support added 8 month after the algorithm, so it doesn't really look
like development was aided by it.  We also plan to add new optimized
code, and getting the library in shape and dropping the hard to
maintain userspace code is actually prep work for making that not
painful.

> 
> The issues with providing userspace build support in the tree are that:
> 
> - It has to be maintained.
> - It's fundamentally a bit of a hack that is used only by developers
>   (who always have the option of doing something locally that is
>   tailored to the specific function they're working on)
> - It diverts effort from the kernel's actual test and benchmark.
> 
> So while the faster iteration speed that userspace development enables
> is definitely nice, I do think we should be cautious with committing to
> maintain it in the kernel tree.  If it's causing problems for the
> ongoing refactoring, dropping it for now seems reasonable to me.
> 
> I would suggest adding a benchmark to the KUnit test similar to the
> crypto and CRC ones, though.

The code already has a benchmark used for runtime selection, although
that could be improved on and run for bigger data sets from kunit.


