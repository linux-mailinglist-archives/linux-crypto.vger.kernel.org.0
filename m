Return-Path: <linux-crypto+bounces-22652-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NpOClCFy2l4IgYAu9opvQ
	(envelope-from <linux-crypto+bounces-22652-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 10:26:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B05E636611B
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 10:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F4F0308BD32
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA123DD51C;
	Tue, 31 Mar 2026 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHFi78M6"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1283DA5C8
	for <linux-crypto@vger.kernel.org>; Tue, 31 Mar 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945225; cv=none; b=A6JWWkkdnr0j8VEubups3RiRhOLTWfb/CFulRelx0eSLeqeNPXfRyh41okc7I9lMOHB7V6V7JSHiibpSwpVIcKNKDeRJQK3kv20pNFbDgBPGsVjudXDjrsNlbxpwB+y8iDds7YKD8cosU6gKHJw9UBPA7jNizUyFNvMP6h82j3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945225; c=relaxed/simple;
	bh=ROq3VRnEKIKK9hBJkmpGUe23U+FD0G+M72+mozJ94YI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BQKDplVYY9FPO8oOSxq2DmehpkjhIAff+09zkMmtYm0SM38FcrOLpS02wvzUj4cBG+V1mk6KGlW0muOGJUKxwmc9QDNg8UeI9Xec4pUe6Shmo/nxD01wN0dcm6cekaW/xmyIvzWQA7uGe5yseX0Tw6c5sBMRLPido5OmOGojcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHFi78M6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E74C2BCB1;
	Tue, 31 Mar 2026 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774945224;
	bh=ROq3VRnEKIKK9hBJkmpGUe23U+FD0G+M72+mozJ94YI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FHFi78M6ZBPEw3UVs5Ouyv+sgrCxwGlGxxYHEfpy83SrgKNiaGhJ900+RBFYT0rFb
	 f5YPxhGTKIcezQ/7GWSAUwLOdQ8hnsrcyslNpUB6SxGtP87eCzQaXAmvqD9MLAcdcE
	 xf/ZAmbtnNEyLUqbaIfBwV/+iYM7Y8C6vrUy9aBQn/F15nfY9SHstoqD9HSvjrfTQp
	 +xPBqsZjps4+O4fxWkOyYSiwGjjl1QGqMbyVJJw4qNKORvak4BjNfIgPzhgoKIrJ9z
	 HHPK6Nkpu9CJFobQ0scqCZpedAwrO7t4vKLJ24mJFASYuYeN2C1AqsXQXzouzrR4R2
	 U+6Yq7YoBTp8A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2C39CF4007A;
	Tue, 31 Mar 2026 04:20:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 04:20:23 -0400
X-ME-Sender: <xms:x4PLaU7q0jl3LvEYHSHeNaV595X0lIiEosPESvcehG0-jUGP69rv5A>
    <xme:x4PLaQurxpyd935rNMgKcbA6MP6-3XT4FDyQochN0GnmlRoEa_SpH9gUj1Gzat5SW
    C2vyKXlANrb1nDsTU5zXZOwx8YrvJYr1zc-knCdLFqOzH8kFj-FvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeguvghmhigrnhhshhesghhmrghilhdrtghomhdprhgtphhtthhopehhtghhsehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x4PLaaERw6U4Oxd-8dQZL-H79-Eex1oKa8FVHJ3fyrfsSixyD-nj4A>
    <xmx:x4PLaUSBTbh2ckTyRbLY_wZA6HCOejncj-weqpdQ3nSqodEfQUvcRA>
    <xmx:x4PLaftpDJTtLpOnJrJUormyOye5j8rd7Jo44QnQj01HcdUkJUwp7g>
    <xmx:x4PLaULjVYXS9rSw-SBeYHg5dVvhdaQTeZBJSE3U0_wkC_hF3IM4Pg>
    <xmx:x4PLaclpWvUsiY0eSBlBBYZqteqyaWhqGoLwe1SILD7FOJJeZmjg9VH6>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 09865700069; Tue, 31 Mar 2026 04:20:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8AYNq7FA6_V
Date: Tue, 31 Mar 2026 10:20:02 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Demian Shulhan" <demyansh@gmail.com>, "Eric Biggers" <ebiggers@kernel.org>
Message-Id: <416ca128-715c-449f-a614-1d97d8f193f2@app.fastmail.com>
In-Reply-To: <actuDkpYbzLj0sI8@infradead.org>
References: <20260330144630.33026-7-ardb@kernel.org>
 <20260330144630.33026-12-ardb@kernel.org> <actuDkpYbzLj0sI8@infradead.org>
Subject: Re: [PATCH 5/5] lib/crc: arm: Enable arm64's NEON intrinsics implementation of
 crc64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-22652-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.929];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B05E636611B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 31 Mar 2026, at 08:47, Christoph Hellwig wrote:
>>  	depends on CRC64 && CRC_OPTIMIZATIONS
>> +	default y if ARM && KERNEL_MODE_NEON && !(CPU_BIG_ENDIAN && CC_IS_CLANG)
>
> It would be useful to throw in a comment here why it is disabled for
> big-endian on clang.
>

Ack.

>> +#define crc64_be_arch crc64_be_generic
>> +
>> +static inline u64 crc64_nvme_arch(u64 crc, const u8 *p, size_t len)
>> +{
>> +	if (len >= 128 && static_branch_likely(&have_pmull) &&
>> +	    likely(may_use_simd())) {
>> +		do {
>> +			size_t chunk = min_t(size_t, len & ~15, SZ_4K);
>> +
>> +			scoped_ksimd()
>> +				crc = crc64_nvme_arm64_c(crc, p, chunk);
>> +
>> +			p += chunk;
>> +			len -= chunk;
>> +		} while (len >= 128);
>> +	}
>
> From reading the earlier patches, I'll assume arm SIMD code is
> non-preemptable and thus you want the chunking here?  Maybe add
> a little comment explaining that?

Indeed.

