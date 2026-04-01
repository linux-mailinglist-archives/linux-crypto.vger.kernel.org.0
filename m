Return-Path: <linux-crypto+bounces-22680-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DGFCe7BzGkWWgYAu9opvQ
	(envelope-from <linux-crypto+bounces-22680-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 08:57:50 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020737577F
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 08:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63501306DCFA
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Apr 2026 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04328002B;
	Wed,  1 Apr 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5dMmES7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC826E70E
	for <linux-crypto@vger.kernel.org>; Wed,  1 Apr 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026665; cv=none; b=s2QETh6kbBp8vJilJZ106vkjY7KK5t/G0nyo+IYmTvRVV/eAh86d4shdACM7+UWnCCOSFUqDvriXA8DcUlE5Ae0hdE3R5hx3teKNTVg7VKfxVoJ42M8bpOIOJVw22mI0oobHV0ndkeKYCxZhQPABSFufRhJefrRfuRBtETqrcPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026665; c=relaxed/simple;
	bh=RNdUik6TjbyGhb6unGHczt6oHQzdTiA5XXduOoNpS6M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GIncdY5adNPD8In8B32UB8yO7iIiPRTJQWatENRglIxPvVIt6pn4mM1deDA4LsYzKBU6yNs2p+nnyHYPtzm4fPZr0kjwZRD9cW0+KWqrxw+/1uerjVkyYss3GZZXDC328lYeYb4IkeJ2sTBbx+UmuYFGFMkBCkqyiC4SuTwbSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5dMmES7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1F3C4CEF7;
	Wed,  1 Apr 2026 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775026665;
	bh=RNdUik6TjbyGhb6unGHczt6oHQzdTiA5XXduOoNpS6M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=t5dMmES7g+Yo0xGsg9xg6PzGk1qKTSHD8FKn6ImpnF6Q28onXkAMa8kCpTQlzkYxk
	 EwZkuJ9lbrGSlU60/hui1S6oFD0ROoL24YTYSSBBfWGN5qyLADizbeMi3SaT4HAX3e
	 3sF6gYo0ThApX/eyzcrZdOSdTocBRkCMmewIiW/ZCkbTjDolTf+25o1xE7U1SBGfL7
	 hkclV2i2djRnIC4HYMYY77Ic/ngCbdkE6eeSPwTjEVdn4yk6Lj6q+0d3TsxvHdcFKj
	 MB5BKReQ1Drao8RB/BGeQEQK+sWag+tlBim86xoflkRrdficFYkvTBga2qbC/zlBff
	 S2IVLG7ETvVKw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BC705F40080;
	Wed,  1 Apr 2026 02:57:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 01 Apr 2026 02:57:43 -0400
X-ME-Sender: <xms:58HMaaX3BvCkhu4E7btKqvpqeBRBTkkEK6BbQt2vDrKF9Sno8JvReQ>
    <xme:58HMaRaDILMdGvCpw_h7-AfE8w1n7QftxparP40_-n-3knykbk1Mmag-HDwuEPoSW
    SnoEXVYcahEQqPNvau057g_YptkAnm4P0Lf2Aqb1-jxxP8K1Q9wJ20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcuuehi
    vghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeeijeef
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    guodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeelqdef
    fedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrhgurd
    gtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peguvghmhigrnhhshhesghhmrghilhdrtghomhdprhgtphhtthhopegvsghighhgvghrsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghl
    sehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqtg
    hrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:58HMaffov1of8JNuHMN4oOxsHFNxSxWtDF3-qvRP1QWE_I-HptSNww>
    <xmx:58HMaQppTlMbBH2euTNr0rKhLClv-OxbZzZFM5tmg71hN90MXYhP6w>
    <xmx:58HMacDI5PMUgwJHLm-NvmSMoDoJcWk7plETcj4gWsuXaeGcpcZZ8g>
    <xmx:58HMaVbg8hCTBb-N592BhE8KskDO9brbEXrFJrdSXOtP9LsAspaLGQ>
    <xmx:58HMaX5bUXNzsaX815sclL6u6prvohGQto4K0BBKWez3iEeF78XHt6zv>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9D820700065; Wed,  1 Apr 2026 02:57:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aics4N9pNpZs
Date: Wed, 01 Apr 2026 08:57:23 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Demian Shulhan" <demyansh@gmail.com>
Message-Id: <232d35ea-433b-4eef-86e7-5cfb9f033bf5@app.fastmail.com>
In-Reply-To: <20260331223300.GA45047@quark>
References: <20260330144630.33026-7-ardb@kernel.org>
 <20260330144630.33026-8-ardb@kernel.org> <20260331223300.GA45047@quark>
Subject: Re: [PATCH 1/5] lib/crc: arm64: Drop unnecessary chunking logic from crc64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22680-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.933];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9020737577F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, 1 Apr 2026, at 00:33, Eric Biggers wrote:
> On Mon, Mar 30, 2026 at 04:46:32PM +0200, Ard Biesheuvel wrote:
>> On arm64, kernel mode NEON executes with preemption enabled, so there is
>> no need to chunk the input by hand.
>> 
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> There's still similar "chunking" in other arm64 code:
>
>     $ git grep -E 'SZ_4K|cond_yield' lib/crypto/arm64
>     lib/crypto/arm64/chacha.h:              unsigned int todo = 
> min_t(unsigned int, bytes, SZ_4K);
>     lib/crypto/arm64/poly1305.h:                    unsigned int todo = 
> min_t(unsigned int, len, SZ_4K);
>     lib/crypto/arm64/sha1-ce-core.S:        cond_yield      1f, x5, x6
>     lib/crypto/arm64/sha256-ce.S:   cond_yield      1f, x5, x6
>     lib/crypto/arm64/sha3-ce-core.S:        cond_yield 4f, x8, x9
>     lib/crypto/arm64/sha512-ce-core.S:      cond_yield      3f, x4, x5
>
> I thought it was still sticking around, despite kernel-mode NEON now
> being preemptible on arm64, because of CONFIG_PREEMPT_VOLUNTARY.
>
> However, I see that support for CONFIG_PREEMPT_VOLUNTARY was recently
> removed on arm64.  So that's what finally makes this no longer needed,
> and we can now clean up these other cases too, right?
>

Indeed.

